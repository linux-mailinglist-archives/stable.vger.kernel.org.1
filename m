Return-Path: <stable+bounces-154573-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10636ADDC81
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 21:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A169189ED20
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 19:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF7728C5DA;
	Tue, 17 Jun 2025 19:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="az2gcQkq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5EA28C5A7
	for <stable@vger.kernel.org>; Tue, 17 Jun 2025 19:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750189137; cv=none; b=rJvu7f+kJeMhiZcAjVovBDrpT9nsZ43slkI9mXu/s5O6l9GwYcLv+CB9Gg7GEuXpO5LoHDPTx2AzB4u0jLe+0nH+vs1pIbQjk4l8msrKmEa9S1SIsMMQ4vja6pfQAqzoI07z3J1ie1KK4shH/oP/cj5n4YbVRaGKnUrffJXrRxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750189137; c=relaxed/simple;
	bh=CponJXrZwMo2j07Ym7urufjVk/2DXDL7cs6dUBeSdic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GU1cXMhDG+l0vFmmWUqksvi+wli/GEQMPgR+Fr+i/eMF/vZvU086UzFYL/nvpOQOnoqL1VBh8cOXtlQG4U1AYj+s5nhJuuWadS9CCdMWyzp5WmBwmHApkv7OnRcapcE/dcHgRchchuOCzxWJBV60q6cufuWsMRrjH1ebZfK/7+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=az2gcQkq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9ECC4CEE3;
	Tue, 17 Jun 2025 19:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750189136;
	bh=CponJXrZwMo2j07Ym7urufjVk/2DXDL7cs6dUBeSdic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=az2gcQkqDRBzKTkH+BEV9m3fjBNZO7ux29tE+lcP0PnAJPMWRcYA+bAStwL9AXz0/
	 dKRmId0Kr53urh1dTXw5IC9A1yHm8RjEE+mZLQmCWc+wUUWL2PMhA5nO8cMd2BdERm
	 uftjTBYls/CFlpemQjmZIDQA9Ouwz3s4dd34Jt35EWGBjRRjekj20C4sKdKFnJxwbO
	 HL/JtlgHqdbjKdrrMd0u27Obu8VMh9hflAbS5BGfowG6zgNu6c6aG8AT2pGgqpC0Cj
	 ltxT7LEq3md1DIz5s/NO3/vnoC2huPS58zXXlQc6VaHDIWdTGVMP3UtNEf/dqrcu9J
	 ndecuXK/tDZTA==
From: Chuck Lever <cel@kernel.org>
To: <stable@vger.kernel.org>
Cc: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	Davide Cavalca <dcavalca@meta.com>
Subject: [PATCH 6.6.y 2/2] kbuild: rpm-pkg: simplify installkernel %post
Date: Tue, 17 Jun 2025 15:38:53 -0400
Message-ID: <20250617193853.388270-3-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2024021932-lavish-expel-58e5@gregkh>
References: <2024021932-lavish-expel-58e5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

[ Upstream commit 358de8b4f201bc05712484b15f0109b1ae3516a8 ]

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
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 scripts/package/kernel.spec | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

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
-- 
2.49.0


