Return-Path: <stable+bounces-20578-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A05885A86B
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 17:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD0BE287836
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 16:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120273B7A8;
	Mon, 19 Feb 2024 16:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lDvecOBg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B2B3B7A9
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 16:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708359160; cv=none; b=PbvtMOnzHQC0lPgwOJeDcWiEoG3mdJH+FcL++6STy1FZw7o8QYrPBX4T3iR/XcYHFOxahi1kw6Wy+5kFWtju4/mytHvsnW+aojf5hV2Tm5SXUDVHS/lnR9wT5HB22a1cKMKAMPZY5GzYT+du5K3N80kUXhrM6X7I5QmmNoCBmgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708359160; c=relaxed/simple;
	bh=OVMsZS4qfuFhmnpe7F0xNA9h6QAfA9wmmDzun1bX0j8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=EhNJmK+W4/TNd6uxVWhheJj0Mt+w0zyWWLfEDGMP64LdL00l7/vi4X2i1kiwPK9IGHodx/WpRmmmgUh+H+oDZbFD3fzovXRsMNHIDjF5v/cVhxyhXO6LulpguyCOKOwRH3NRxyGfCRTGjzoWpBQtKlWWJWSk+jwcw/8zhd+NTnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lDvecOBg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC01AC433C7;
	Mon, 19 Feb 2024 16:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708359160;
	bh=OVMsZS4qfuFhmnpe7F0xNA9h6QAfA9wmmDzun1bX0j8=;
	h=Subject:To:Cc:From:Date:From;
	b=lDvecOBgAPGXtn86IUy4EASO2O0GtIA9hY7O6tVP5dHeWf1Qf2o8J+ZkADTs4uk3s
	 OGSNMEGkFizXmAYjFCd5VU2xJctOi70gvivQ85CFhFLPRuY4pQK2uUqo2QZovNacSr
	 +DPU54xxdsxQLNS+MVbUqWzzp1InHqDE2NONbhsk=
Subject: FAILED: patch "[PATCH] kbuild: rpm-pkg: simplify installkernel %post" failed to apply to 6.1-stable tree
To: jtornosm@redhat.com,dcavalca@meta.com,masahiroy@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 17:12:34 +0100
Message-ID: <2024021934-spree-discard-c389@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 358de8b4f201bc05712484b15f0109b1ae3516a8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021934-spree-discard-c389@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

358de8b4f201 ("kbuild: rpm-pkg: simplify installkernel %post")
0df8e9708594 ("scripts: clean up IA-64 code")
2d7d1bc119a4 ("kbuild: remove stale code for 'source' symlink in packaging scripts")
49c803cd919d ("kbuild: rpm-pkg: split out the body of spec file")
2a291fc315b6 ("kbuild: rpm-pkg: introduce %{with_devel} switch to select devel package")
b537925fdd68 ("kbuild: rpm-pkg: run modules_install for non-modular kernel")
1789fc912541 ("kbuild: rpm-pkg: invoke the kernel build from rpmbuild for binrpm-pkg")
d4f651277e92 ("kbuild: rpm-pkg: use a dummy string for _arch when undefined")
d5d2d4cc6088 ("kbuild: rpm-pkg: derive the Version from %{KERNELRELEASE}")
fe66b5d2ae72 ("kbuild: refactor kernel-devel RPM package and linux-headers Deb package")
93ed5605c618 ("kbuild: rpm-pkg: replace $KERNELRELEASE in spec file with %{KERNELRELEASE}")
5d8e41b51865 ("kbuild: rpm-pkg: replace $__KERNELRELEASE in spec file with %{version}")
a06d9ef897d5 ("kbuild: rpm-pkg: record ARCH option in spec file")
fe809b8271be ("kbuild: rpm-pkg: use %{makeflags} to pass common Make options")
192868258d2c ("kbuild: rpm-pkg: do not hard-code $MAKE in spec file")
61eca933d0a6 ("kbuild: rpm-pkg: remove unneeded '-f $srctree/Makefile' in spec file")
233046a2afd1 ("kbuild: rpm-pkg: define _arch conditionally")
1240dabe8d58 ("kbuild: deb-pkg: remove the CONFIG_MODULES check in buildeb")
4243afdb9326 ("kbuild: builddeb: always make modules_install, to install modules.builtin*")
c90b3bbff2a0 ("kbuild: rpm-pkg: remove kernel-drm PROVIDES")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 358de8b4f201bc05712484b15f0109b1ae3516a8 Mon Sep 17 00:00:00 2001
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Date: Mon, 29 Jan 2024 10:28:19 +0100
Subject: [PATCH] kbuild: rpm-pkg: simplify installkernel %post

The new installkernel application that is now included in systemd-udev
package allows installation although destination files are already present
in the boot directory of the kernel package, but is failing with the
implemented workaround for the old installkernel application from grubby
package.

For the new installkernel application, as Davide says:
<<The %post currently does a shuffling dance before calling installkernel.
This isn't actually necessary afaict, and the current implementation
ends up triggering downstream issues such as
https://github.com/systemd/systemd/issues/29568
This commit simplifies the logic to remove the shuffling. For reference,
the original logic was added in commit 3c9c7a14b627("rpm-pkg: add %post
section to create initramfs and grub hooks").>>

But we need to keep the old behavior as well, because the old installkernel
application from grubby package, does not allow this simplification and
we need to be backward compatible to avoid issues with the different
packages.

Mimic Fedora shipping process and store vmlinuz, config amd System.map
in the module directory instead of the boot directory. In this way, we will
avoid the commented problem for all the cases, because the new destination
files are not going to exist in the boot directory of the kernel package.

Replace installkernel tool with kernel-install tool, because the latter is
more complete.

Besides, after installkernel tool execution, check to complete if the
correct package files vmlinuz, System.map and config files are present
in /boot directory, and if necessary, copy manually for install operation.
In this way, take into account if  files were not previously copied from
/usr/lib/kernel/install.d/* scripts and if the suitable files for the
requested package are present (it could be others if the rpm files were
replace with a new pacakge with the same release and a different build).

Tested with Fedora 38, Fedora 39, RHEL 9, Oracle Linux 9.3,
openSUSE Tumbleweed and openMandrive ROME, using dnf/zypper and rpm tools.

cc: stable@vger.kernel.org
Co-Developed-by: Davide Cavalca <dcavalca@meta.com>
Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
index 89298983a169..f58726671fb3 100644
--- a/scripts/package/kernel.spec
+++ b/scripts/package/kernel.spec
@@ -55,12 +55,12 @@ patch -p1 < %{SOURCE2}
 %{make} %{makeflags} KERNELRELEASE=%{KERNELRELEASE} KBUILD_BUILD_VERSION=%{release}
 
 %install
-mkdir -p %{buildroot}/boot
-cp $(%{make} %{makeflags} -s image_name) %{buildroot}/boot/vmlinuz-%{KERNELRELEASE}
+mkdir -p %{buildroot}/lib/modules/%{KERNELRELEASE}
+cp $(%{make} %{makeflags} -s image_name) %{buildroot}/lib/modules/%{KERNELRELEASE}/vmlinuz
 %{make} %{makeflags} INSTALL_MOD_PATH=%{buildroot} modules_install
 %{make} %{makeflags} INSTALL_HDR_PATH=%{buildroot}/usr headers_install
-cp System.map %{buildroot}/boot/System.map-%{KERNELRELEASE}
-cp .config %{buildroot}/boot/config-%{KERNELRELEASE}
+cp System.map %{buildroot}/lib/modules/%{KERNELRELEASE}
+cp .config %{buildroot}/lib/modules/%{KERNELRELEASE}/config
 ln -fns /usr/src/kernels/%{KERNELRELEASE} %{buildroot}/lib/modules/%{KERNELRELEASE}/build
 %if %{with_devel}
 %{make} %{makeflags} run-command KBUILD_RUN_COMMAND='${srctree}/scripts/package/install-extmod-build %{buildroot}/usr/src/kernels/%{KERNELRELEASE}'
@@ -70,13 +70,14 @@ ln -fns /usr/src/kernels/%{KERNELRELEASE} %{buildroot}/lib/modules/%{KERNELRELEA
 rm -rf %{buildroot}
 
 %post
-if [ -x /sbin/installkernel -a -r /boot/vmlinuz-%{KERNELRELEASE} -a -r /boot/System.map-%{KERNELRELEASE} ]; then
-cp /boot/vmlinuz-%{KERNELRELEASE} /boot/.vmlinuz-%{KERNELRELEASE}-rpm
-cp /boot/System.map-%{KERNELRELEASE} /boot/.System.map-%{KERNELRELEASE}-rpm
-rm -f /boot/vmlinuz-%{KERNELRELEASE} /boot/System.map-%{KERNELRELEASE}
-/sbin/installkernel %{KERNELRELEASE} /boot/.vmlinuz-%{KERNELRELEASE}-rpm /boot/.System.map-%{KERNELRELEASE}-rpm
-rm -f /boot/.vmlinuz-%{KERNELRELEASE}-rpm /boot/.System.map-%{KERNELRELEASE}-rpm
+if [ -x /usr/bin/kernel-install ]; then
+	/usr/bin/kernel-install add %{KERNELRELEASE} /lib/modules/%{KERNELRELEASE}/vmlinuz
 fi
+for file in vmlinuz System.map config; do
+	if ! cmp --silent "/lib/modules/%{KERNELRELEASE}/${file}" "/boot/${file}-%{KERNELRELEASE}"; then
+		cp "/lib/modules/%{KERNELRELEASE}/${file}" "/boot/${file}-%{KERNELRELEASE}"
+	fi
+done
 
 %preun
 if [ -x /sbin/new-kernel-pkg ]; then
@@ -94,7 +95,6 @@ fi
 %defattr (-, root, root)
 /lib/modules/%{KERNELRELEASE}
 %exclude /lib/modules/%{KERNELRELEASE}/build
-/boot/*
 
 %files headers
 %defattr (-, root, root)


