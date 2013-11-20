Name:           jpeg_ltsm
Version:        0.9.1
Release:        1%{?dist}
Summary:        JPEG Lossless Transformation Service Menu for KDE 4

Group:          User Interface/Desktops
License:        GPLv2+
URL:            http://www.mr700.info/
Source0:        http://www.mr700.info/%{name}/%{name}-%{version}.tar.bz2
Requires:       libjpeg-turbo-utils

BuildRoot:      %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
BuildRequires:  python-docutils
BuildArch:      noarch


%description
JPEG Lossless Transformation Service Menu for KDE 4, as the name suggests,
is a KDE service menu for KDE 4 that does lossless JPEG transformations
(grayscaling looses the color, but not quality from the BW image part).

It uses jpegtran from libjpeg (6b-43) to do the job and kdialog for user
interaction and notifocation.


%prep
%setup -q


%build
make %{?_smp_mflags}


%install
rm -rf %{buildroot}
make DESTDIR=$RPM_BUILD_ROOT install


%clean
rm -rf $RPM_BUILD_ROOT


%post
# arg1 = 1 if rpm -i (first time), arg1 = 2 if rpm -U
if [ "$1" = "1" ]; then
    xdg-desktop-menu forceupdate 2> /dev/null || :
else
    xdg-desktop-menu forceupdate 2> /dev/null || :
fi


%postun
# arg1 = 1 if rpm -U, arg1 = 0 if rpm -e
if [ "$1" = "0" ]; then
    xdg-desktop-menu forceupdate 2> /dev/null || :
else
    xdg-desktop-menu forceupdate 2> /dev/null || :
fi


%files
%defattr(-,root,root,-)
%doc README README.html jpeg_ltsm_action.gif jpeg_ltsm_menu.png jpeg_ltsm_submenu.png
%doc ChangeLog LICENSE
%{_kde4_libexecdir}/%{name}.sh
%{_kde4_datadir}/kde4/services/%{name}.desktop


%changelog
* Mon Apr 20 2009 Doncho N. Gunchev <dgunchev@gmail.com> 0.9.1-1
- update to 0.9.1

* Sat Apr 11 2009 Doncho N. Gunchev <dgunchev@gmail.com> 0.9.0-1
- initial RPM package
