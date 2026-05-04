Return-Path: <stable+bounces-243849-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FJ+D2W1+Gm3zAIAu9opvQ
	(envelope-from <stable+bounces-243849-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 17:04:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FBF4C05C9
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 17:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4E1F5300F5FA
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A21E3DEAF9;
	Mon,  4 May 2026 14:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="fxjTzW69"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A291E3DE443
	for <stable@vger.kernel.org>; Mon,  4 May 2026 14:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777906748; cv=none; b=Qir2YZZkQ6P9RNnbOv8bFwXCak3zRq4lkiI9voosB8Zmm3Bj9hfI0SBY+D39nqv49XqXosHFvbn5ZobYdOnBpIdRhvcAu75MtEIPUKP4C0LPK3DjYTYTrIT82S49NJ2GOo5SYSRPQ/gfUExUbB7EfeD5QFHeCjEx9XgaPRKPXdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777906748; c=relaxed/simple;
	bh=A4xBqUwtS0OCJgfAPotgEX35Gce+rJd1WZ7B60hqsV8=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=ia4kmghxaf3golR1ejm+Xu3cIto1NkFnkEfUA0jKVisIGddcS162QPMIAd7FWWpKccNo/ykWQv5pLbonn9dXVWDeoUHWPyrRvi91SAoraXyAi7I9Xpjkikkx9Psi68eMw7gBtW0ptu6oIZimm9Dkmfqewx6vZM+AqavsU589JBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=fxjTzW69; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2f0ad52830cso2145931eec.1
        for <stable@vger.kernel.org>; Mon, 04 May 2026 07:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1777906745; x=1778511545; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=21dxf024L8tyWOjOKGqx7gK55RrPjicNl0v9xZphCnw=;
        b=fxjTzW69qVS1MJm8uaTyKBXKBv2m1ITW8+QVaNOZRmyJhLF26DYtWI2dNZ0IKllqBo
         fxJXIZLAs//YeeCH/04csvNWfjpv86E5uJrH9resc2Ej7p5fdp2OdP8uruD6q0Ef1Sfq
         LuqC4DUVcrCWsBENi1xRUqWDR0YU1Qs35rXe2H4xS0m1Hco5G8WPZUO7SM9HaeAiFg+t
         iy6rHSu60QAwdoNxtoT2FzfC0vp+vnuElDyGtRetVBC1VwybMnmc8J8JqfTr0jsT5gb5
         qlvKJwbcGsEmwoAt+RBWS+lj5Ednw1j14hDcFcYnFbbXdg2gXzmwVKWP7j5FnRVVxcJB
         r/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777906745; x=1778511545;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=21dxf024L8tyWOjOKGqx7gK55RrPjicNl0v9xZphCnw=;
        b=tEpYvwGCuj4S3rgVPDuIBYvV5qX9AM+BAK20AMUI4xOpikbm4oojyZN8KR1eeHsE+h
         uQIs/C1tcGWUWqSf+FR0knj1KIfPj6KP0ogwnVqYtjUFCgHl9Ieo66zCR/+FB2u1t00A
         xb4ilCcGwAjLv6AKVM37LIoZu07C8NCjYvxE/BCuPxK7hEuXRnsBuAD8GKLd28tYMuhf
         KaZsqqol6twDFGVFepreXwGMYWI2EiA4OksXQcvgJl7IpBoZ81Uo4qGG/mmgp2lfhO1d
         c3l6v1mIJLZFDziYI/GgiNdox9BU9H2VR3cr9q365IzPwUvvLVDIsMT9C/rur64o3cp3
         b37w==
X-Forwarded-Encrypted: i=1; AFNElJ9AdS1eT9foD/HOP7C9XZ7yZUpQfC2wTZYwHGO0mSPzqTz/JolmrK0Q6PBvFOqyZevDjd1xxrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjEqqztsvkDj53Ps24RdJtO9HEyVMvYT9ee2ZS8j9m9XR/ulSQ
	fUtgFVCnKYPFmAyTIdCs/wMDw1rEp40wItnjxZl64GzyGXcRZsoH11bC86UKAhxX9o40b6xd/0D
	VvPhN
X-Gm-Gg: AeBDies0KAo/RI6CsiUFbi+Va/j6C9974cbLSg4Q0urUvbXQboXLKtlLYqfwz4Jfhz1
	7c2YY+QZJXrDwtWVs0VwY+8EZyb7iUQwSB6PnBPRGnnvmtcs7JHIKJdEmeKMiqXhmXz5drEffK0
	N34yYKBgSacex3GTYHKHElwhbzVHbwdLtrXUshzO0velsn/fM4Blfv5eqFaazHy96WF/OKngVf8
	vUb9CCQFCDpTYYaMnmChq3ujxuICYAyvW0QyKrqXDvJthWaSYfPkMUoiXGaDNALyuij8zigYOKV
	2scX1+zMDpbngaHvOSIps75X6dCajQ0I+K2wD26YQOxGEQCiMLlaAL4NJYQbhYdVVDGqgpWXkDU
	31yaATpyeNujO7RyMs88JQh814XQzMa/02f2k/+jO/ymJCRTNviaEf8R3hNb/XdMgd3WHLroNND
	AxndWdiF6yF5ATakjxvEuM3iGjQMY=
X-Received: by 2002:a05:7301:3b8f:b0:2da:44ac:6d17 with SMTP id 5a478bee46e88-2efb9c865e9mr4046270eec.17.1777906745429;
        Mon, 04 May 2026 07:59:05 -0700 (PDT)
Received: from 997d03828cfd ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3bb60811sm15994716eec.24.2026.05.04.07.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 07:59:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.1.y: (build) error: Bad exit status
 from
 /var/tmp/rpm-tmp.TjFmc1 (%install) in ...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Mon, 04 May 2026 14:59:04 -0000
Message-ID: <177790674418.2389.13270434547023644068@997d03828cfd>
X-Rspamd-Queue-Id: 81FBF4C05C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernelci.org,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernelci.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-243849-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernelci.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DBL_PROHIBIT(0.00)[0.149.215.96:email,0.97.168.0:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernelci.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	HAS_REPLYTO(0.00)[kernelci@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:email,kernelci.org:email,kernelci.org:dkim,kernelci.org:url]





Hello,

New build issue found on stable-rc/linux-6.1.y:

---
 error: Bad exit status from /var/tmp/rpm-tmp.TjFmc1 (%install) in binrpm-pkg (/tmp/kci/linux/scripts/Makefile.package:71) [logspec:kbuild,kbuild.other]
---

- dashboard: https://d.kernelci.org/i/maestro:703f6a8c73beb25b89dd80d078b397e7c24ede45
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  3706134cadc0bfcc1887b832d1305df4b09dc676


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
tar --sort=name --owner=tuxmake:1000 --group=tuxmake:1000 --mtime=@1777902663 --clamp-mtime -caf /tmp/kci/artifacts/build/modules.tar.xz -C /tmp/kci/artifacts/build/modinstall lib
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build INSTALL_DTBS_PATH=/tmp/kci/artifacts/build/dtbsinstall/dtbs ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- dtbs
rm -rf /tmp/kci/artifacts/build/dtbsinstall
mkdir -p /tmp/kci/artifacts/build/dtbsinstall/dtbs
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build INSTALL_DTBS_PATH=/tmp/kci/artifacts/build/dtbsinstall/dtbs ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- dtbs_install
tar --sort=name --owner=tuxmake:1000 --group=tuxmake:1000 --mtime=@1777902663 --clamp-mtime -caf /tmp/kci/artifacts/build/dtbs.tar.xz -C /tmp/kci/artifacts/build/dtbsinstall dtbs
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- binrpm-pkg
Building target platforms: aarch64-linux
Building for target aarch64-linux
warning: line 22: It's not recommended to have unversioned Obsoletes: Obsoletes: kernel-headers
Executing(%mkbuilddir): /bin/sh -e /var/tmp/rpm-tmp.irSHD8
Executing(%install): /bin/sh -e /var/tmp/rpm-tmp.TjFmc1
+ umask 022
+ cd ./kernel-6.1.171_rc1-build
+ /usr/bin/rm -rf ./kernel-6.1.171_rc1-build/BUILDROOT
+ /usr/bin/mkdir -p ./kernel-6.1.171_rc1-build
+ /usr/bin/mkdir ./kernel-6.1.171_rc1-build/BUILDROOT
+ mkdir -p ./kernel-6.1.171_rc1-build/BUILDROOT/boot
+ make -f /tmp/kci/linux/Makefile -s image_name
/tmp/kci/linux/Makefile:747: include/config/auto.conf: No such file or directory
+ cp ./kernel-6.1.171_rc1-build/BUILDROOT/boot/vmlinuz-6.1.171-rc1
cp: missing destination file operand after './kernel-6.1.171_rc1-build/BUILDROOT/boot/vmlinuz-6.1.171-rc1'
Try 'cp --help' for more information.
error: Bad exit status from /var/tmp/rpm-tmp.TjFmc1 (%install)
RPM build warnings:
RPM build errors:

=====================================================


# Builds where the incident occurred:

## defconfig+aws-ec2 on (arm64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:69f893770e4ee292cbccba77


#kernelci issue maestro:703f6a8c73beb25b89dd80d078b397e7c24ede45

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

