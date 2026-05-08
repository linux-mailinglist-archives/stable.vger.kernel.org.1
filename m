Return-Path: <stable+bounces-244761-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHaRIMDs/WlJkwAAu9opvQ
	(envelope-from <stable+bounces-244761-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 16:01:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD8D4F781F
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 16:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6D98E3077569
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 13:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EB23E5EF1;
	Fri,  8 May 2026 13:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="ieQdwCzU"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6894A3ED5C3
	for <stable@vger.kernel.org>; Fri,  8 May 2026 13:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778248750; cv=none; b=okYkQZqreMadp3GFRtTLgF/llzOz4up4z41X0G0eLIifNFQC5dmkzFs+kfOhaH+nLmvqTqg1Nbdj4HDD9iTMEQqv4GZBuEMjL3Cjc7TGScBSNXnMUCMXW0er9wVviAdoRv8PQAW70309KebmKQgy1+JQPmRBipibPbvZDVcTayY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778248750; c=relaxed/simple;
	bh=4I2vfQd8vlE8jGGFR03ZKoEchTXITr6U80HrbKN3ANc=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=dAW8UbwE2T//7EjsQaaNTHzYp5DEFGnpl3hCNNLM448pn4ZYuq3+H3GYOgbjtkMOU43+k5mIF+fdYMPxKM4qMjNfNXAzom4oMAqievkJsoiCTXK+Cl1/LZ0G0Tl6I5Q+/7f3W4P6nI+tVpX3IKgQW+NJBiTo5YexOtu/i/Fr0no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=ieQdwCzU; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2f0ad52830cso3101706eec.1
        for <stable@vger.kernel.org>; Fri, 08 May 2026 06:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1778248746; x=1778853546; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q922Ip2GzL4YktMs2xke7BoMjw2kirdzaacfQ1GgSGw=;
        b=ieQdwCzUA+dyrN4dr30fVDU5iwvh6YbxD8+xBeHmlfa/zoyPcHtRkpTQuoUwWUxo4D
         ZDyATNeFbFi9Rpyh+d/yffW15FlrEUXszFfIDUZBNmWUtld+tg9/MOACy9vwVZLNZi0r
         dxHpR9cFj0Ojz2cTAFajj7bK3IPQe7SahX05BuU4rqunZddvzwWI51ee2ILYqyAb+w9Z
         J99QepcaJzDLjiD4rsgs439eKITdgyHwuiYYH2NcXQz1b7DqRkh8yEM6mjBSMDMTzv6w
         Le/wR4QQBuceUirI4ZaozQY/ww075cpIN05pvYEs9naCpOVkhTy7xTV/RQg+hiIL9PEk
         byhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778248746; x=1778853546;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q922Ip2GzL4YktMs2xke7BoMjw2kirdzaacfQ1GgSGw=;
        b=GhG0Q08nKD35tfRdHr3QFKScAiQx6wKuw2XIs8Z2XaCuVTj8eWC7JjGU0w0817mUPS
         7kRGyMmMNLYTcIZcqxhBgs4KbwJCE7qM3h9d/0QU+K8tQTG5ygqTxiP3dd5Ti5Lvn9l6
         AISSc+MhZqI2o2GjPX0VSv2KuV2E6YvxHvNoA49ZzjuLUv6UI5SWFLUKn+I84fPzQ44o
         njwHY1JqbVRjiBVBOWHV/Zk4TmrLOKoJOptf0OJ1Tv/GYxoQEDOhr5+E5U9ZVofBeR8z
         2ybiNuV+rtFWfeauBhtCqD1nyhsIBQC6L740SNFwvLAkrHLxZzMiU5NkVPXXBJtgIgmj
         I12g==
X-Forwarded-Encrypted: i=1; AFNElJ9A6EWRYoN9ECFpIGh/5b++cV4caoQJGjisKx4Mq9l6NeTBY73IwD5t7dss5PsTfYUFQKuS4BM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUQ4AIul6rPpkzWBJDQRysdSrzOeWKHWICZ7y3f5tZAGm8dR5z
	OHHvEbCs9WEwMOXYSN+jWw1PHUaXUBkZVTpALwIhzLtA9HMCtIu4pzrFs9NH6QK8P6cUBbY8NfL
	q/Agp
X-Gm-Gg: Acq92OGA6LMiy2NIz//Vy9k7h1eBLPdWAO2Y3QsATXOhB9MGM6ARMSLQpUZJW8UnV7Z
	bgakQdlVr9VnM1/1n/17X6TwxzzZOALy25452GAQnDpsYWrTB8/tJmLs1iMs+Ul51us2wv6+ClO
	WuyXK0vOKlEHBiDQ1Rl3KB/8AcMYodJI08NEk2/k06Ule1sSwzwQfvvz+2CUwZz4Y9upQ//8iQt
	k255mHzT+rZlxG8dje0UjVosymEBrEJ02FYcB1RUKA00IgUg2Lh3smmDc0kaCDSwd0IDPvBeIy9
	UdKRPQTIugUFoOAfeLwAhpaup44t/TDvXDqBOmvbyfAMbOzI+u1LUxDnNd06iAOw0//Khf0Xe3Z
	51crhoggJdl+HDfZX32Xq9uDDdXA862bAC4mcVBRftR3yNFxOOjisAsKcY2bPdtRVA+8dcLY3TD
	gqSSO238D/uL6wJJSY
X-Received: by 2002:a05:7300:a987:b0:2c5:60d0:702e with SMTP id 5a478bee46e88-2f54a77f55cmr6256203eec.18.1778248745955;
        Fri, 08 May 2026 06:59:05 -0700 (PDT)
Received: from 997d03828cfd ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8864c37basm2236142eec.13.2026.05.08.06.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 06:59:04 -0700 (PDT)
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
 /var/tmp/rpm-tmp.5p7QuJ (%install) in ...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 08 May 2026 13:59:04 -0000
Message-ID: <177824874413.4211.15205642800224987110@997d03828cfd>
X-Rspamd-Queue-Id: EBD8D4F781F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernelci.org,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernelci.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-244761-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernelci.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernelci.org:email,kernelci.org:url,kernelci.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lists.linux.dev:replyto,linux.dev:email,0.97.168.0:email]
X-Rspamd-Action: no action





Hello,

New build issue found on stable-rc/linux-6.1.y:

---
 error: Bad exit status from /var/tmp/rpm-tmp.5p7QuJ (%install) in binrpm-pkg (/tmp/kci/linux/scripts/Makefile.package:71) [logspec:kbuild,kbuild.other]
---

- dashboard: https://d.kernelci.org/i/maestro:6051f83c9bf8bb3e83787912bafcd853f8b63d7b
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  128a674368bf4493be63895d126ef9bc98516f4b
- tags: v6.1.171

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
tar --sort=name --owner=tuxmake:1000 --group=tuxmake:1000 --mtime=@1778243296 --clamp-mtime -caf /tmp/kci/artifacts/build/modules.tar.xz -C /tmp/kci/artifacts/build/modinstall lib
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build INSTALL_DTBS_PATH=/tmp/kci/artifacts/build/dtbsinstall/dtbs ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- dtbs
rm -rf /tmp/kci/artifacts/build/dtbsinstall
mkdir -p /tmp/kci/artifacts/build/dtbsinstall/dtbs
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build INSTALL_DTBS_PATH=/tmp/kci/artifacts/build/dtbsinstall/dtbs ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- dtbs_install
tar --sort=name --owner=tuxmake:1000 --group=tuxmake:1000 --mtime=@1778243296 --clamp-mtime -caf /tmp/kci/artifacts/build/dtbs.tar.xz -C /tmp/kci/artifacts/build/dtbsinstall dtbs
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- binrpm-pkg
Building target platforms: aarch64-linux
Building for target aarch64-linux
warning: line 22: It's not recommended to have unversioned Obsoletes: Obsoletes: kernel-headers
Executing(%mkbuilddir): /bin/sh -e /var/tmp/rpm-tmp.S6zZrD
Executing(%install): /bin/sh -e /var/tmp/rpm-tmp.5p7QuJ
+ umask 022
+ cd ./kernel-6.1.171-build
+ /usr/bin/rm -rf ./kernel-6.1.171-build/BUILDROOT
+ /usr/bin/mkdir -p ./kernel-6.1.171-build
+ /usr/bin/mkdir ./kernel-6.1.171-build/BUILDROOT
+ mkdir -p ./kernel-6.1.171-build/BUILDROOT/boot
+ make -f /tmp/kci/linux/Makefile -s image_name
/tmp/kci/linux/Makefile:747: include/config/auto.conf: No such file or directory
+ cp ./kernel-6.1.171-build/BUILDROOT/boot/vmlinuz-6.1.171
cp: missing destination file operand after './kernel-6.1.171-build/BUILDROOT/boot/vmlinuz-6.1.171'
Try 'cp --help' for more information.
error: Bad exit status from /var/tmp/rpm-tmp.5p7QuJ (%install)
RPM build warnings:
RPM build errors:

=====================================================


# Builds where the incident occurred:

## defconfig+aws-ec2 on (arm64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:69fdcdc90e4ee292cbef1fcf


#kernelci issue maestro:6051f83c9bf8bb3e83787912bafcd853f8b63d7b

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

