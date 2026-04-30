Return-Path: <stable+bounces-242086-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Gs9Nl4282lgygEAu9opvQ
	(envelope-from <stable+bounces-242086-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 13:00:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 355054A12C6
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 13:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B358E3004D21
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 10:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A633BE62A;
	Thu, 30 Apr 2026 10:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="CJHqkXdf"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A880D26FDBF
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 10:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777546750; cv=none; b=fuW5coSIDvVTnPncxYcOpOdceq5eqrOboxqC36Hu0vpJs8hsPt4qJF7bBVd1isOveYbKgWe561+ouBE/YJacbG8idkQ5SbIBswfP//Z0MMuyVIZ+V76m3rCJwM6reJkar5peHNLYbQXBQSm97VB5I8CavquAY774pGgNPBkSV0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777546750; c=relaxed/simple;
	bh=zNwDRWns4uq/RH9EqOLSxh+GuRHT5RtgtKyWYJkSWTo=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=DYSdW//aHkMES6worSgDcuQz678s2cXElL1mjxn1/gSe75pGrShtO0XgXcLzhvvCK/fRVyFXiyIawY4Qm8XXqtxInBO5OVszHJF9rx/rfNr7QqYAJRWCd1ZT4dw/cQ83tGqgq46xrjFMuxZBqJBL+hF+LTbM7mgaao/G2TLUo2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=CJHqkXdf; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2c156c4a9efso1414701eec.1
        for <stable@vger.kernel.org>; Thu, 30 Apr 2026 03:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1777546748; x=1778151548; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=btMjDy8fPFyZsQj1oG/xZ7H3VBPif3d8rU8fH2Wvgtw=;
        b=CJHqkXdfVesCq6AMU17iFK4ZW5tl8aqWkLUxIrLV5ftNO95jJVxEWI7lDo9uUgSxbI
         Jd1vKHCpLK0Zn6ENIsD5p1ERUYICIXOQeS4rOaM4znBAUL4LODLe5wgPN6Zspgnb1zEN
         NK2Uhh+4dtU16OyJCOl26xVK2PeXaNQ9LNKjTVyP5JdnpVnb8BjcBgUf9cSNWXmUgSxE
         LqnEy1sRxb8zLKILl7fzg8VMk+O9P6tpAyHqyknN8W9o/Dpv2CQ2Eg/rHF9tX8i0swkQ
         7tHTmjDn6tNEfI7R7S3NQzUw6pJadbKZFs7UwCOux9TRoLsODryZbt51U7xTVKgn1o+R
         2THQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777546748; x=1778151548;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=btMjDy8fPFyZsQj1oG/xZ7H3VBPif3d8rU8fH2Wvgtw=;
        b=gJV1JwZ6lRIIKChh6f1BGBnZ5STsEe72pDzK5h6ZkiBH3PsEntWCwNS4XYeDn5XxXn
         sLVrcDS7LVykWa3mgFxBBziqp769jtaTajGJO4T4uZWlnQul5EdRAqtVWrDV8lrtwGOq
         fuJsC1ITtZfaI+dS5l5NbFfIDZZZ0++RHcnlBVqYwmmDrzW1YNSbRhm9EjCksvPvwn8E
         KK/Oc63wt4VYRJeY49IkKYiBKzPKoW91++mQR8bycnfk0QO1bNrlFOjJJHjNmDkIhiYR
         wB7O7lrhFDfw4F2LCC4X0b4x1BLE3UaqGKVxeF1LAj/kFSsaf1iZ19fTJK6Uls6FZlLz
         zi5w==
X-Forwarded-Encrypted: i=1; AFNElJ/gsIhM5U5cQPoKE5g5ZgnjghQeW0WJm5FCHfmvTRU2XzgwJIbk+1NuO2FEWSp6YgfequLjyRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzERAu2NfIU+ofX/1DEkXPD0HogQhwyI6tka9f9Jh2hSVPHr4zO
	Pu2bhw9ZefZUSK/HU1ycOtoGg76gQd5cDvhDbEKhKE5KU/aTzuHXk2sCXlMDvJEx+WU=
X-Gm-Gg: AeBDieu7hRk7GLDNf+/6k9FWcflzLxoMaIrgjWT03C2AHMAUvlXjr7A3WVUl7uT1vTI
	fLjD4WwRqVmChx9GJGF0p8wQw0JBjqXBXlJzHLXaTGXqvH4ZwX90XSkGuGkU6JnqQBgy1GQyq+K
	xc3nAIEkTxCN9Qbb8Nj8okfECDafC732/QeJW/7/zGP/6ADJGc5DIZ3/OCsV2RTduR1wMwyyH2X
	u+zyDQhDIuXHh+HtXmz0Qtvvj2PnkGjla0Xl+EK1FtLQHaFxfJuhyxI5bG+wf6cvWHeD59I+zSl
	VTlmiVIlxVSU42CzWb0pqEulC6LG3Zp74P2pGHeI03qT1v5sUf4C70M29phd5wcgnygUbAPK06S
	XpNgxsIKFrbCpROfJv9QSFC1/2p38UnBVKOSzrx35LhGQ5/3FZ/W5ajm6W4MzCjn0DejnO3Pl3b
	Xv2xd9IVgMZgNjDsIWtdghE2SmoHk=
X-Received: by 2002:a05:693c:3b04:b0:2de:aafb:fef3 with SMTP id 5a478bee46e88-2ed3bdf8c6dmr964543eec.1.1777546747886;
        Thu, 30 Apr 2026 03:59:07 -0700 (PDT)
Received: from 997d03828cfd ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed1c070523sm6443041eec.19.2026.04.30.03.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 03:59:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable/linux-5.15.y: (build) error: Unable to open
 sqlite
 database /var/lib/rpm/rpmdb.sqlite: u...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Thu, 30 Apr 2026 10:59:07 -0000
Message-ID: <177754674673.471.14861215264612717690@997d03828cfd>
X-Rspamd-Queue-Id: 355054A12C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	SEM_URIBL(3.50)[0.0.0.0:email];
	MID_RHS_NOT_FQDN(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernelci.org:+];
	DMARC_POLICY_ALLOW(0.00)[kernelci.org,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-242086-lists,stable=lfdr.de];
	R_DKIM_ALLOW(0.00)[kernelci.org:s=google];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	HAS_REPLYTO(0.00)[kernelci@lists.linux.dev];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.924];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[bot@kernelci.org,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[pcie.f8000000:query timed out];
	TAGGED_RCPT(0.00)[stable];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:104.64.211.4:c];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,kernelci.org:email,kernelci.org:dkim,kernelci.org:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,0.0.0.0:email]





Hello,

New build issue found on stable/linux-5.15.y:

---
 error: Unable to open sqlite database /var/lib/rpm/rpmdb.sqlite: unable to open database file error: cannot open Packages index using sqlite - Operation not permitted (1) error: cannot open Packages database in /var/lib/rpm error: Bad exit status from /var/tmp/rpm-tmp.Vid3i0 (%install) in binrpm-pkg (/tmp/kci/linux/scripts/Makefile.package:68) [logspec:kbuild,kbuild.other]
---

- dashboard: https://d.kernelci.org/i/maestro:edef9fb39a12ec87b4a9ef46dd9e7976ec4ad8c3
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
- commit HEAD:  ef251c45f1cd4a1a3e8f6eb2e3aee3903c7fa71b
- tags: v5.15.204

Please include the KernelCI tag when submitting a fix:

Reported-by: kernelci.org bot <bot@kernelci.org>


Log excerpt:
=====================================================
# /tmp/kci/artifacts/fragments/0.config -> /tmp/kci/artifacts/build/0.config
# /tmp/kci/artifacts/fragments/1.config -> /tmp/kci/artifacts/build/1.config
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- defconfig
scripts/kconfig/merge_config.sh -m -O /tmp/kci/artifacts/build /tmp/kci/artifacts/build/.config /tmp/kci/artifacts/build/0.config /tmp/kci/artifacts/build/1.config
Using /tmp/kci/artifacts/build/.config as base
Merging /tmp/kci/artifacts/build/0.config
Value of CONFIG_ENA_ETHERNET is redefined by fragment /tmp/kci/artifacts/build/0.config:
Previous value: # CONFIG_ENA_ETHERNET is not set
New value: CONFIG_ENA_ETHERNET=y
Value of CONFIG_NVME_CORE is redefined by fragment /tmp/kci/artifacts/build/0.config:
Previous value: CONFIG_NVME_CORE=m
New value: CONFIG_NVME_CORE=y
Value of CONFIG_BLK_DEV_NVME is redefined by fragment /tmp/kci/artifacts/build/0.config:
Previous value: CONFIG_BLK_DEV_NVME=m
New value: CONFIG_BLK_DEV_NVME=y
Value of CONFIG_XFS_FS is redefined by fragment /tmp/kci/artifacts/build/0.config:
Previous value: # CONFIG_XFS_FS is not set
New value: CONFIG_XFS_FS=y
Value of CONFIG_DEBUG_INFO is redefined by fragment /tmp/kci/artifacts/build/0.config:
Previous value: CONFIG_DEBUG_INFO=y
New value: CONFIG_DEBUG_INFO=n
Merging /tmp/kci/artifacts/build/1.config
#
# merged configuration written to /tmp/kci/artifacts/build/.config (needs make)
#
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- olddefconfig
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf-
/tmp/kci/linux/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi:460.3-52: Warning (pci_device_reg): /pcie@f8000000/pcie@0,0:reg: PCI reg address is not configuration space
/tmp/kci/linux/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi:460.3-52: Warning (pci_device_reg): /pcie@f8000000/pcie@0,0:reg: PCI reg address is not configuration space
/tmp/kci/linux/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi:460.3-52: Warning (pci_device_reg): /pcie@f8000000/pcie@0,0:reg: PCI reg address is not configuration space
/tmp/kci/linux/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi:460.3-52: Warning (pci_device_reg): /pcie@f8000000/pcie@0,0:reg: PCI reg address is not configuration space
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- Image.gz
rm -rf /tmp/kci/artifacts/build/modinstall
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build INSTALL_MOD_STRIP=1 INSTALL_MOD_PATH=/tmp/kci/artifacts/build/modinstall ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- modules_install
tar --sort=name --owner=tuxmake:1000 --group=tuxmake:1000 --mtime=@1777544746 --clamp-mtime -caf /tmp/kci/artifacts/build/modules.tar.xz -C /tmp/kci/artifacts/build/modinstall lib
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build INSTALL_DTBS_PATH=/tmp/kci/artifacts/build/dtbsinstall/dtbs ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- dtbs
rm -rf /tmp/kci/artifacts/build/dtbsinstall
mkdir -p /tmp/kci/artifacts/build/dtbsinstall/dtbs
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build INSTALL_DTBS_PATH=/tmp/kci/artifacts/build/dtbsinstall/dtbs ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- dtbs_install
tar --sort=name --owner=tuxmake:1000 --group=tuxmake:1000 --mtime=@1777544746 --clamp-mtime -caf /tmp/kci/artifacts/build/dtbs.tar.xz -C /tmp/kci/artifacts/build/dtbsinstall dtbs
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- binrpm-pkg
Building target platforms: aarch64
Building for target aarch64
warning: line 19: It's not recommended to have unversioned Obsoletes: Obsoletes: kernel-headers
error: Unable to open sqlite database /var/lib/rpm/rpmdb.sqlite: unable to open database file
error: cannot open Packages index using sqlite - Operation not permitted (1)
error: cannot open Packages database in /var/lib/rpm
Executing(%mkbuilddir): /bin/sh -e /var/tmp/rpm-tmp.beQuIY
Executing(%install): /bin/sh -e /var/tmp/rpm-tmp.Vid3i0
+ umask 022
+ cd ./kernel-5.15.204-build
+ /usr/bin/rm -rf ./kernel-5.15.204-build/BUILDROOT
+ /usr/bin/mkdir -p ./kernel-5.15.204-build
+ /usr/bin/mkdir ./kernel-5.15.204-build/BUILDROOT
+ mkdir -p ./kernel-5.15.204-build/BUILDROOT/boot
+ make -f /tmp/kci/linux/Makefile -s image_name
/tmp/kci/linux/Makefile:669: include/config/auto.conf: No such file or directory
+ cp ./kernel-5.15.204-build/BUILDROOT/boot/vmlinuz-5.15.204
cp: missing destination file operand after './kernel-5.15.204-build/BUILDROOT/boot/vmlinuz-5.15.204'
Try 'cp --help' for more information.
error: Bad exit status from /var/tmp/rpm-tmp.Vid3i0 (%install)
RPM build warnings:
RPM build errors:

=====================================================


# Builds where the incident occurred:

## defconfig+aws-ec2 on (arm64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:69f32d08800b539063e94a8f


#kernelci issue maestro:edef9fb39a12ec87b4a9ef46dd9e7976ec4ad8c3

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

