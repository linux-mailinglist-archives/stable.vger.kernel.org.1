Return-Path: <stable+bounces-242096-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHUBOapE82kMzAEAu9opvQ
	(envelope-from <stable+bounces-242096-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 14:01:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C7B4A283B
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 14:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F3AA3055EA6
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 11:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D230383C65;
	Thu, 30 Apr 2026 11:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="Qldq3jzy"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879A53DA7ED
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 11:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777550349; cv=none; b=rVAUqaDryvmLDDO97tG0Ju4s+L8Ty6vnvY+D9Je4tuW/CIWqjqzEq28etogDz3ninSzjBBN8QGeM//9xLvD6tUWeg4jVxf0jpror4vNuHQ2TfurQ3ZJakS/cx2BrwZ/mpDyYjtu8Pv4gTA9dqRffTAwjC7NgPj5rzH4V4dedGCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777550349; c=relaxed/simple;
	bh=Tr7VNqGWGXKYfATnSEpOfEJ1mWk3OAc0ha8UNMdV76c=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=Wzm2nndIpF2Ss+FZgMEGZwtauWopeRMhD6XZjtqSXuZsJbprOnzkAM4bVfDacx90SKH3SVbIK38u4cMzjwNDslzFw0IVWtBvGOD99KL3N/s2+a7CXDfhAlCuqXuvFimdy4bgBZrZdIMK+so7ER3bbmm/uyfET29LNlVsRvdZxKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=Qldq3jzy; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12c8cc7a77eso1420089c88.1
        for <stable@vger.kernel.org>; Thu, 30 Apr 2026 04:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1777550347; x=1778155147; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EhvG2ghL2wmKFWH0GlkZGtFBVc3OF4ot676hmgX93Pk=;
        b=Qldq3jzyLZnsgQJH8DvqOwuyOc9g4Zq6tDdyg0JrCfjfhZKn5tN6X3GmorgFOaxdVH
         FOIFOdhZ+v3bDiaBNotTAMCYTG6XxK4hcMNESfXZzIiR2E6/kSaX3uTlCYwO0sFi+fSx
         6/uztxJib7oTwPN4R0EzLlJ8/92IekX2UD6JBc52BXgLdnjO5pPVz66ILBJpjmGYp0Bt
         UNb05lpiroUPD0DH+VuC+ETnE94ALmbRpPkTpnCEDWSURr2xMEY3CKCUrW1ZfWfcddHk
         kXkv5IsiI55HXindR9IdBPYfprBU02/fr2dGfSFQCxvKjMjI4vQqqHhQPN9fxByw+8mD
         xpEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777550347; x=1778155147;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EhvG2ghL2wmKFWH0GlkZGtFBVc3OF4ot676hmgX93Pk=;
        b=A01xfW5mlLdOQen2TqLpLb6MHI2SGam/NwavQqYf1AjkRNkKjUYtziHw9coBO14k7x
         H/mBLf0ZaOh5qocr//RwEnyiHtnfRbICyn9QkBBY3EsfV8FZQ6fl+sPOtSVumLSSohQF
         zLaJu7tGa4T/7JJBRek5ELc9KD1JOGImVkDPJPcNpNbJoBGfT1y64BDJUcXnJyzNV4yd
         m5TAjxzUV0g/JW04bGzbHBHWHo2WsJZMbZ15OCx7aSlB1qUDQHhXBTeRpbs5n3mmxXYb
         DWGs3QjlHafEL9csLoJX6xAlxELhmb/X1BimYNlSGyrSAGX3Txpk2whaxLlyqMbGG8Jd
         S5Ow==
X-Forwarded-Encrypted: i=1; AFNElJ8CqHGJw15b1VlvxFKM5dp73+LUJC0tyyYeGt4YWeentsDC6TEdcNp5pPYvbsyz7tNBB6uTbRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTbc9xcON18yWBF+1ABC0KTrHFMQvWygVJbU6e/zQKD9yFk4eo
	uP0k21hivm0uCGUkDZXRA1f9WZ9EpCeSDAquWPrxZQOLpNqrqPrheY6qPZMuaGLkKzhIYnlJKa5
	VukN/
X-Gm-Gg: AeBDieubvIIvBp8kqdxhQd4jWFeFtDlvc8HhqL+eU7kM3pLULlUhuc1WqmPM/byEDPn
	WkwWlzCKEdGz+SB8j6ZzOwkEtX0907FC66vsRtT8asbzXV5RRmPimNQGJ/axFLZrtQvphcARqql
	UqSIh06PC04b0PLJvzt3yuwFSDqeoCk2RvKmDC4KUTg18h3N2XXep9D0YOWdQx5xQ8G6ocBLARw
	OTOoV2YqfuOF8xwDi0/gdV5LV6TmrODnhKYGnl4QA4DeRJerUyT0OIfhjtzP8EWr59IU97csOOV
	Ya0ibveLLzu5Iu3XJ0GsmL9zMxYPLDZMKa1b6Bl0g4I7uzoCiMca1Ypl7DF2O3YAdW3z5xO/W5N
	Pwde7DRQf+jadkyeuSWAX8fDPpIhIrkZWDbsawUNu9Ii3bDK902E++456KrV7p3aRWTdqoCJar1
	AxfpMO3W+f2XAX7TLd2V+3QeTyu7M=
X-Received: by 2002:a05:7022:128c:b0:12c:839:7462 with SMTP id a92af1059eb24-12dec90e2bemr938853c88.12.1777550346573;
        Thu, 30 Apr 2026 04:59:06 -0700 (PDT)
Received: from 997d03828cfd ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12de320ed98sm7447327c88.3.2026.04.30.04.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 04:59:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable/linux-6.1.y: (build) error: Unable to open sqlite
 database
 /var/lib/rpm/rpmdb.sqlite: u...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Thu, 30 Apr 2026 11:59:05 -0000
Message-ID: <177755034534.490.7374078042732129294@997d03828cfd>
X-Rspamd-Queue-Id: 89C7B4A283B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernelci.org,reject];
	R_DKIM_ALLOW(-0.20)[kernelci.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242096-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[0.149.215.96:query timed out,linux.dev:query timed out,0.97.168.0:query timed out];
	DKIM_TRACE(0.00)[kernelci.org:+];
	MISSING_XM_UA(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[soc/mailbox.0.149.215.96:query timed out];
	RCVD_COUNT_FIVE(0.00)[5];
	DBL_PROHIBIT(0.00)[0.97.168.0:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernelci.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	HAS_REPLYTO(0.00)[kernelci@lists.linux.dev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,kernelci.org:email,kernelci.org:dkim,kernelci.org:url,0.149.215.96:email]





Hello,

New build issue found on stable/linux-6.1.y:

---
 error: Unable to open sqlite database /var/lib/rpm/rpmdb.sqlite: unable to open database file error: cannot open Packages index using sqlite - Operation not permitted (1) error: cannot open Packages database in /var/lib/rpm error: Bad exit status from /var/tmp/rpm-tmp.JFdy0M (%install) in binrpm-pkg (/tmp/kci/linux/scripts/Makefile.package:71) [logspec:kbuild,kbuild.other]
---

- dashboard: https://d.kernelci.org/i/maestro:7898b16ce3367a674c40c278c60bb5c193f747d2
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
- commit HEAD:  4931e0e1673d2592ba7ab7365a25d1248b6a41b8
- tags: v6.1.170

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
/tmp/kci/linux/arch/arm64/boot/dts/qcom/msm8996.dtsi:2954.36-2962.5: Warning (clocks_property): /soc/clock-controller@6400000: Missing property '#clock-cells' in node /soc/mailbox@9820000 or bad phandle (referred from clocks[2])
/tmp/kci/linux/arch/arm64/boot/dts/qcom/msm8996.dtsi:2954.36-2962.5: Warning (clocks_property): /soc/clock-controller@6400000: Missing property '#clock-cells' in node /soc/mailbox@9820000 or bad phandle (referred from clocks[2])
/tmp/kci/linux/arch/arm64/boot/dts/qcom/msm8996.dtsi:2954.36-2962.5: Warning (clocks_property): /soc/clock-controller@6400000: Missing property '#clock-cells' in node /soc/mailbox@9820000 or bad phandle (referred from clocks[2])
/tmp/kci/linux/arch/arm64/boot/dts/qcom/msm8996.dtsi:2954.36-2962.5: Warning (clocks_property): /soc/clock-controller@6400000: Missing property '#clock-cells' in node /soc/mailbox@9820000 or bad phandle (referred from clocks[2])
/tmp/kci/linux/arch/arm64/boot/dts/qcom/msm8996.dtsi:2954.36-2962.5: Warning (clocks_property): /soc/clock-controller@6400000: Missing property '#clock-cells' in node /soc/mailbox@9820000 or bad phandle (referred from clocks[2])
/tmp/kci/linux/arch/arm64/boot/dts/qcom/msm8996.dtsi:2954.36-2962.5: Warning (clocks_property): /soc/clock-controller@6400000: Missing property '#clock-cells' in node /soc/mailbox@9820000 or bad phandle (referred from clocks[2])
/tmp/kci/linux/arch/arm64/boot/dts/qcom/msm8996.dtsi:2954.36-2962.5: Warning (clocks_property): /soc/clock-controller@6400000: Missing property '#clock-cells' in node /soc/mailbox@9820000 or bad phandle (referred from clocks[2])
/tmp/kci/linux/arch/arm64/boot/dts/qcom/msm8996.dtsi:2954.36-2962.5: Warning (clocks_property): /soc/clock-controller@6400000: Missing property '#clock-cells' in node /soc/mailbox@9820000 or bad phandle (referred from clocks[2])
/tmp/kci/linux/arch/arm64/boot/dts/qcom/msm8996.dtsi:2954.36-2962.5: Warning (clocks_property): /soc/clock-controller@6400000: Missing property '#clock-cells' in node /soc/mailbox@9820000 or bad phandle (referred from clocks[2])
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- Image.gz
rm -rf /tmp/kci/artifacts/build/modinstall
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build INSTALL_MOD_STRIP=1 INSTALL_MOD_PATH=/tmp/kci/artifacts/build/modinstall ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- modules_install
tar --sort=name --owner=tuxmake:1000 --group=tuxmake:1000 --mtime=@1777545520 --clamp-mtime -caf /tmp/kci/artifacts/build/modules.tar.xz -C /tmp/kci/artifacts/build/modinstall lib
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build INSTALL_DTBS_PATH=/tmp/kci/artifacts/build/dtbsinstall/dtbs ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- dtbs
rm -rf /tmp/kci/artifacts/build/dtbsinstall
mkdir -p /tmp/kci/artifacts/build/dtbsinstall/dtbs
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build INSTALL_DTBS_PATH=/tmp/kci/artifacts/build/dtbsinstall/dtbs ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- dtbs_install
tar --sort=name --owner=tuxmake:1000 --group=tuxmake:1000 --mtime=@1777545520 --clamp-mtime -caf /tmp/kci/artifacts/build/dtbs.tar.xz -C /tmp/kci/artifacts/build/dtbsinstall dtbs
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- binrpm-pkg
Building target platforms: aarch64-linux
Building for target aarch64-linux
warning: line 22: It's not recommended to have unversioned Obsoletes: Obsoletes: kernel-headers
error: Unable to open sqlite database /var/lib/rpm/rpmdb.sqlite: unable to open database file
error: cannot open Packages index using sqlite - Operation not permitted (1)
error: cannot open Packages database in /var/lib/rpm
Executing(%mkbuilddir): /bin/sh -e /var/tmp/rpm-tmp.cpnX8j
Executing(%install): /bin/sh -e /var/tmp/rpm-tmp.JFdy0M
+ umask 022
+ cd ./kernel-6.1.170-build
+ /usr/bin/rm -rf ./kernel-6.1.170-build/BUILDROOT
+ /usr/bin/mkdir -p ./kernel-6.1.170-build
+ /usr/bin/mkdir ./kernel-6.1.170-build/BUILDROOT
+ mkdir -p ./kernel-6.1.170-build/BUILDROOT/boot
+ make -f /tmp/kci/linux/Makefile -s image_name
/tmp/kci/linux/Makefile:747: include/config/auto.conf: No such file or directory
+ cp ./kernel-6.1.170-build/BUILDROOT/boot/vmlinuz-6.1.170
cp: missing destination file operand after './kernel-6.1.170-build/BUILDROOT/boot/vmlinuz-6.1.170'
Try 'cp --help' for more information.
error: Bad exit status from /var/tmp/rpm-tmp.JFdy0M (%install)
RPM build warnings:
RPM build errors:

=====================================================


# Builds where the incident occurred:

## defconfig+aws-ec2 on (arm64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:69f32dc0800b539063e94b77


#kernelci issue maestro:7898b16ce3367a674c40c278c60bb5c193f747d2

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

