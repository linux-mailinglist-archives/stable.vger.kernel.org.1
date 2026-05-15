Return-Path: <stable+bounces-247805-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOlsFNo2B2rftQIAu9opvQ
	(envelope-from <stable+bounces-247805-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 17:08:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CB8551E0D
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 17:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB01F30D25E4
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C733B0ACE;
	Fri, 15 May 2026 14:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="KYgsMKNu"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F5A3C196F
	for <stable@vger.kernel.org>; Fri, 15 May 2026 14:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778857149; cv=none; b=t3x+QlTPw6x7kY6ZmLcH+SxcUU0N7czw4527VXOP3oSYc9pAZC6dDrK1l2mZ1QnRCz/RLfHLuTxUPuJY6wYePJLlPorDtEHWx+Cc/YZAhIm2D63x9nhDiJpnAvGJJzCsZbSeuDTNpl1frJzqiYw+bvMf4JVwYuDU5BfX24aJsfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778857149; c=relaxed/simple;
	bh=cfr9UtKRVlKP7tBXIGWC+VEtcs7A3AdGh+w0WbO8cWY=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=R78AlnkyrO6Gg9+tMtFJ1fWJ6zxmig5YbGcmOCsLoWMP6w2PMv3sxX9zycbhimWHTfxkcx+LemwmwdS+/d45AJS42pyKCXyvIgjMahrpiQNDGFOrohNXS7G1V2cQuxlxUPIQk1CFKZLtXBVSZ7BWDn/Je3tVO/1ciZ5r4/aPFOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=KYgsMKNu; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2ee1054627bso797577eec.1
        for <stable@vger.kernel.org>; Fri, 15 May 2026 07:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1778857147; x=1779461947; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bKf16RtzcgtsajW9OsSkYB6qGNEvy1M5bBh979QqWzA=;
        b=KYgsMKNu8kqi0nruHzO2eNYgQEVlGEmSBgkZiw4/MKPc4WK2msxqSG5cWh9GdBDfTz
         V2cTH3jP0ga+lafurMUCxj/38663x61tZkloM4nZCP/b8B58nM9gOAFZue2j3MQgASuf
         pxtpfpVL0UMK34L57BxtOFWKjod85Px036b1yfPR2guUZ1nFKiXOnohhAFEQlUH1WsEW
         bFMhv61/8QhrVCMcCR22WRSTfotan6wqF8uS4gvA9OlmUFySgev5w9dQIYqA9IEr+ANt
         dKE/+Z/mAQD1Rq4B6eDTpeKzrMb4svRUydlmKeHzF5J/r92hwp3EM7Rk2Ahx/JH41aAm
         RJjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778857147; x=1779461947;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bKf16RtzcgtsajW9OsSkYB6qGNEvy1M5bBh979QqWzA=;
        b=CJ92cg+esvLhEmoQA34YLoSua5JK1XOFKFJtCCY6dg1noYc6+502wAWzAS0+1LVYuM
         LmsaQUNt6ytvDNt1Km2JH2RwpmCxU1SY+7eCEYsFPG5X3rUmJcrNCI+dBjx0nTA9lWLW
         uRYYyqTgvUd/IXouRoohd5HChl4Xxb0CHaX9sxYCjYAYSvaBAAy/YfGORcV75RSQqCEr
         WRe4SRZrDhj9d9MgKZJMMGcJowza8wc4cwR/H5uyf3Cn7yrvTSna1P/lrYpyY9pqtTOL
         Ne0TmFukPgZ3dMdR11Q3CuBXsxO27YGlFXYQeHMEXMdv6IoonWWiIJJZWNbqC86Wwutk
         ySwA==
X-Forwarded-Encrypted: i=1; AFNElJ84RqRy464UUKmn137WNUGgVzO2d0OVc/1cGJVzx9FGLjEro5LOJc9TfZRyHPU6YUxefYmP2zY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgTHSIPDz0JiOH+E/S9DaqzB5vIb2T6FWqjOvDnLY8/3F2rzuV
	YDSy2E39OXQ4MkVx6gVtmh/W7FwCrC1/w2shvQjiq6W1KQpmGJ2MvFOuMzrdJh9ECLScp5Kp0Oe
	5S2WH
X-Gm-Gg: Acq92OHBQaEo+hFH0N68VjwcCs/6TjJwMQS2O/IVcwfJYRu01frmxvimbo4Oc4UJR6e
	C69nU8aqxSqRSlTcn4ZdGIvEMw5X19Txsh83Gldvi4ESKD607BMjf2XqxSHxwrSkam+ZVT+iZLu
	Bw94vxG1Hf6vV5cYG7Gv1Gxz7AdJw+SbLQzk3KOsQNZKWNmHbtvLroLj/bnW+PLxAALUxZkX0Bs
	PJKhXn4mK/E6yMfBXFu35eidqk7CYcdLRiNYRCAfkKjszOR78UljgOtwWuHmRTkVCXljaqzngR2
	RcexqtIWvH9huRx0q1zXma/Z9GTtySwEMFDMBCnYHVj1+x1bGeEaFv5ZeWsgAdsCWop8uqptGsU
	3G9LRUm6twa7mvKvgrAerZGecJVcWJIUixq+tW0+kFbvbYxOHcvSWPDUHtdOz+U5QWqPRLaVOBQ
	zvMbPfwVimAn8Gwhc4
X-Received: by 2002:a05:7301:290e:b0:2c1:7480:ff9b with SMTP id 5a478bee46e88-3026294ea33mr4307250eec.18.1778857147019;
        Fri, 15 May 2026 07:59:07 -0700 (PDT)
Received: from 330cfa3079ca ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302946f2149sm7040286eec.11.2026.05.15.07.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 07:59:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable/linux-6.1.y: (build) error: Bad exit status from
 /var/tmp/rpm-tmp.DxAF8s (%install) in ...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 15 May 2026 14:59:05 -0000
Message-ID: <177885714543.1005.4969775176895380037@330cfa3079ca>
X-Rspamd-Queue-Id: A1CB8551E0D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernelci.org,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernelci.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-247805-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernelci.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DBL_PROHIBIT(0.00)[0.149.215.96:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernelci.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	HAS_REPLYTO(0.00)[kernelci@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,lists.linux.dev:replyto,kernelci.org:email,kernelci.org:url,kernelci.org:dkim,0.97.168.0:email]
X-Rspamd-Action: no action





Hello,

New build issue found on stable/linux-6.1.y:

---
 error: Bad exit status from /var/tmp/rpm-tmp.DxAF8s (%install) in binrpm-pkg (/tmp/kci/linux/scripts/Makefile.package:71) [logspec:kbuild,kbuild.other]
---

- dashboard: https://d.kernelci.org/i/maestro:20822d6152b8beaeba1f175e293525bbf8793539
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
- commit HEAD:  c27210688955656e93e26cffab0a82bbca4e5d2b
- tags: v6.1.173

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
tar --sort=name --owner=tuxmake:1000 --group=tuxmake:1000 --mtime=@1778854053 --clamp-mtime -caf /tmp/kci/artifacts/build/modules.tar.xz -C /tmp/kci/artifacts/build/modinstall lib
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build INSTALL_DTBS_PATH=/tmp/kci/artifacts/build/dtbsinstall/dtbs ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- dtbs
rm -rf /tmp/kci/artifacts/build/dtbsinstall
mkdir -p /tmp/kci/artifacts/build/dtbsinstall/dtbs
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build INSTALL_DTBS_PATH=/tmp/kci/artifacts/build/dtbsinstall/dtbs ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- dtbs_install
tar --sort=name --owner=tuxmake:1000 --group=tuxmake:1000 --mtime=@1778854053 --clamp-mtime -caf /tmp/kci/artifacts/build/dtbs.tar.xz -C /tmp/kci/artifacts/build/dtbsinstall dtbs
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- binrpm-pkg
Building target platforms: aarch64-linux
Building for target aarch64-linux
warning: line 22: It's not recommended to have unversioned Obsoletes: Obsoletes: kernel-headers
Executing(%mkbuilddir): /bin/sh -e /var/tmp/rpm-tmp.qpCPto
Executing(%install): /bin/sh -e /var/tmp/rpm-tmp.DxAF8s
+ umask 022
+ cd ./kernel-6.1.173-build
+ /usr/bin/rm -rf ./kernel-6.1.173-build/BUILDROOT
+ /usr/bin/mkdir -p ./kernel-6.1.173-build
+ /usr/bin/mkdir ./kernel-6.1.173-build/BUILDROOT
+ mkdir -p ./kernel-6.1.173-build/BUILDROOT/boot
+ make -f /tmp/kci/linux/Makefile -s image_name
/tmp/kci/linux/Makefile:747: include/config/auto.conf: No such file or directory
+ cp ./kernel-6.1.173-build/BUILDROOT/boot/vmlinuz-6.1.173
cp: missing destination file operand after './kernel-6.1.173-build/BUILDROOT/boot/vmlinuz-6.1.173'
Try 'cp --help' for more information.
error: Bad exit status from /var/tmp/rpm-tmp.DxAF8s (%install)
RPM build warnings:
RPM build errors:

=====================================================


# Builds where the incident occurred:

## defconfig+aws-ec2 on (arm64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a0722970ed99f002e8df7af


#kernelci issue maestro:20822d6152b8beaeba1f175e293525bbf8793539

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

