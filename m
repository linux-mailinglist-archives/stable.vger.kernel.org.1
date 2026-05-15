Return-Path: <stable+bounces-247783-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOGSIQYpB2ppsQIAu9opvQ
	(envelope-from <stable+bounces-247783-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:09:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BE0551069
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BD7D302F3AD
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 13:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF21A481AA3;
	Fri, 15 May 2026 13:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="ET9SfQHo"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A90D30B533
	for <stable@vger.kernel.org>; Fri, 15 May 2026 13:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778853549; cv=none; b=L6o0Jvjcyn4XsHOazae1DYE4S/eawdgDtiWNNfuDdJJWLIcs+gZyXhh0yrUjNyVnPr4m98zdmFOGNzXAU4WloWxvs11a49UmG2YeRM7wZ3OXhLsk4HFl1XmCtmCsz8yvyvvSMauv516+3DIVcwa375VUmM673+/vPcJf8UJquWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778853549; c=relaxed/simple;
	bh=Khpu/jjI2BT9zFmWCfw6GERosqoVjKVtmua5kj1iVNw=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=sKgxVoX1xjgXdaYG0kY1EHU4gQ4lCORw9npSB3pKghKc2pTwT99HTemWfosbgKRZhckNCQRYQgExRI18tzW1G9bIeug8fwk99Mz7b4Fh9lUKjZhmbuLyiEUBOVPE91j4HqOmjmFlR3NI78IYVt+CIekt6o+AaZqZ1Te6eTve/4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=ET9SfQHo; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2f0ad52830cso13680102eec.1
        for <stable@vger.kernel.org>; Fri, 15 May 2026 06:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1778853547; x=1779458347; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/9pBtu8GYweRoiMCpe/uTmyClI2ZzbMd937+NZe9Ql4=;
        b=ET9SfQHoV8NOuORfZ7Nx7lR9A2EnkgOXZJwE0SCD2+6bhUIckGH8lulxyG++JHOoM8
         6viRHh6Yc2E7QAO/1xC2FpK+gjWZOdZhDxFo9F0Db1iM54hQB0kcr4FdGVV/ZwTz6K06
         TFGej4vofiMkWor7EA6uvgBsMa4uXw96FHdIL0oVx+m8q0e96sXHFE8HmvbZWiQkekg3
         jz+bVRsm5OMpPBy95TjR/VZ5xnNaspOISbYAN89ATaYDfuPW1TwYqCeSbtQXMg02k8bx
         /sdgUEnj+zw1CVCkuT2Q+C1cpXwm6qOiIVro7JqbazngidwTEYIm4NMXJ7Uo9+S/I7bV
         QfbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778853547; x=1779458347;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/9pBtu8GYweRoiMCpe/uTmyClI2ZzbMd937+NZe9Ql4=;
        b=FznsnWOl2RlpxQZXDsyQt9RNFS/mZ7Wpv8zadw3AzosiPeMRgtvmeMELcq2PR7H+EK
         h6CMJSiiOmKmVL4MV1HAU4Atbt4xDVP/wNrMAThj9bs4qu7U5qefZ/wZL46+dVLIo8gK
         1EOXCrE/tushr7IMuHIsCcxQ9omSQ6JWxh3WWIeUULToRXvP2afT3NAy45mCnAXzA+05
         tCnY8KRXYH8/UJZZIaT9tas2mpj7ihIPBZfLOG94aDlHBgq+Lf9R1aY2t/RhLK1rc6Y9
         0BhQVo1pIkkpUJI9zVPHxsLizLbZ42wjraFLqo4s06lb0RXb7uHo0VXMb0jIZKMu4eOT
         6KQQ==
X-Forwarded-Encrypted: i=1; AFNElJ+m/VrwkTONtETeB3GSr5GpN67bFB/a4JCMzhjQBE9bnRwx+1FSnxEu2EnMbYm+wIz9jHCFYyc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyis7S1z8IWzcnk6Jo7AKgyeg/MxviOfg3LCzRAMhN6J1mnVHB5
	QC9bAcpSInbOfphTyhCS+XkOUci6lTTxI29nQxFYCbU2hAkLAeUYBLKjHJzRFZ2REjs=
X-Gm-Gg: Acq92OFELDrpEniUEMoTZ2izyvFvubKMLVS4B16uk99PbPV67kXGAYKkk5ZN70+QPam
	qUF2TawwYJrS9loJxEeTr+nYefeKMUFHqjiI9L0TDGElfzL3XjVJ5U4fihTkiyBgf8YhDoVhrGJ
	MRAtzi/1ySAOwo3qA6lUkddNV5SVit5VoWpXpP8uTOl+7RrNxQ5hO8aXGfK2TWjM/r1fMdRitoN
	DS1dl3b2e8ahJ6LdnFgBQiVu90T12DsEzlLOWGqy388RVSNTBnh/MzPn58EsM47HsqIQcQlXwL+
	8QOtD/gOubSfy2o7uLUioqiNsxpVuYxXxb5NZasrhvXn8slR5MVgAIl2iIdKR4+ercBdqWfVSWK
	rSiyc6YwPY245kdFvUgkBQeCLAm5/5KQS4/1cYXuvSxOl2fky++AIFc5TQvcY1xgep5KbFfNrAF
	02KLi83TIoMjNBAv0a
X-Received: by 2002:a05:693c:2c8d:b0:2d9:6373:ad0a with SMTP id 5a478bee46e88-3039818738dmr1962994eec.11.1778853546981;
        Fri, 15 May 2026 06:59:06 -0700 (PDT)
Received: from 330cfa3079ca ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302973bbd50sm6907566eec.20.2026.05.15.06.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 06:59:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable/linux-5.15.y: (build) error: Bad exit status from
 /var/tmp/rpm-tmp.BejqcO (%install) in ...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 15 May 2026 13:59:06 -0000
Message-ID: <177885354599.985.4346415357702471282@330cfa3079ca>
X-Rspamd-Queue-Id: E0BE0551069
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernelci.org,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernelci.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_FROM(0.00)[bounces-247783-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernelci.org:+];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[kernelci@lists.linux.dev];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernelci.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,f8000000:email,kernelci.org:email,kernelci.org:url,kernelci.org:dkim]
X-Rspamd-Action: no action





Hello,

New build issue found on stable/linux-5.15.y:

---
 error: Bad exit status from /var/tmp/rpm-tmp.BejqcO (%install) in binrpm-pkg (/tmp/kci/linux/scripts/Makefile.package:68) [logspec:kbuild,kbuild.other]
---

- dashboard: https://d.kernelci.org/i/maestro:13ce2f85fb9f2eb5902810d0505240d261a219c1
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
- commit HEAD:  93741761e5e3fa630ddc1fc19a460ac42baece80
- tags: v5.15.207

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
tar --sort=name --owner=tuxmake:1000 --group=tuxmake:1000 --mtime=@1778852441 --clamp-mtime -caf /tmp/kci/artifacts/build/modules.tar.xz -C /tmp/kci/artifacts/build/modinstall lib
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build INSTALL_DTBS_PATH=/tmp/kci/artifacts/build/dtbsinstall/dtbs ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- dtbs
rm -rf /tmp/kci/artifacts/build/dtbsinstall
mkdir -p /tmp/kci/artifacts/build/dtbsinstall/dtbs
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build INSTALL_DTBS_PATH=/tmp/kci/artifacts/build/dtbsinstall/dtbs ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- dtbs_install
tar --sort=name --owner=tuxmake:1000 --group=tuxmake:1000 --mtime=@1778852441 --clamp-mtime -caf /tmp/kci/artifacts/build/dtbs.tar.xz -C /tmp/kci/artifacts/build/dtbsinstall dtbs
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- binrpm-pkg
Building target platforms: aarch64
Building for target aarch64
warning: line 19: It's not recommended to have unversioned Obsoletes: Obsoletes: kernel-headers
Executing(%mkbuilddir): /bin/sh -e /var/tmp/rpm-tmp.rEv8GM
Executing(%install): /bin/sh -e /var/tmp/rpm-tmp.BejqcO
+ umask 022
+ cd ./kernel-5.15.207-build
+ /usr/bin/rm -rf ./kernel-5.15.207-build/BUILDROOT
+ /usr/bin/mkdir -p ./kernel-5.15.207-build
+ /usr/bin/mkdir ./kernel-5.15.207-build/BUILDROOT
+ mkdir -p ./kernel-5.15.207-build/BUILDROOT/boot
+ make -f /tmp/kci/linux/Makefile -s image_name
/tmp/kci/linux/Makefile:669: include/config/auto.conf: No such file or directory
+ cp ./kernel-5.15.207-build/BUILDROOT/boot/vmlinuz-5.15.207
cp: missing destination file operand after './kernel-5.15.207-build/BUILDROOT/boot/vmlinuz-5.15.207'
Try 'cp --help' for more information.
error: Bad exit status from /var/tmp/rpm-tmp.BejqcO (%install)
RPM build warnings:
RPM build errors:

=====================================================


# Builds where the incident occurred:

## defconfig+aws-ec2 on (arm64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a0721cc0ed99f002e8df1d2


#kernelci issue maestro:13ce2f85fb9f2eb5902810d0505240d261a219c1

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

