Return-Path: <stable+bounces-248905-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0B0MLlB7B2rG5AIAu9opvQ
	(envelope-from <stable+bounces-248905-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 22:00:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE12557317
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 22:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 909843027942
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7309F23E325;
	Fri, 15 May 2026 19:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="PE82p+R4"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB15B3812CD
	for <stable@vger.kernel.org>; Fri, 15 May 2026 19:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778875150; cv=none; b=NwG8QL+x6hrDwghxFI9geOQ5gZyRUP9Nz2SkC7zM8mxKsg7gjjSnAIrb1HcI4SooTEE/jU01G3BCxNPKHRygV5Uxh3TpjOM+YlLpAQH2q6XP4f5dVHrfwifx3j50sQAFTBQQZcRq4IkUbJmesXS5IgmPVgtvTaLg/CrQnpZRP9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778875150; c=relaxed/simple;
	bh=LHvsfifIHo4e2gOHF9JfWNOVQxxLBjYTzN0xDTCPN1I=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=af/ilFD/nTZ74rEoX3hOk9y97Q0thFEtyzflpZara28rda5/v0M0aghgSnDgL+CAZR6u4wJQb7gIIlQWleGKqKhP4oaiDuF7FbUvB8JK/2CFW0MTajOswYtQc29SK2fvET3yKQAhsejBLabzFPoHpcXcbKhwIa5txsUuSucNKD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=PE82p+R4; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-133466cf955so655867c88.0
        for <stable@vger.kernel.org>; Fri, 15 May 2026 12:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1778875145; x=1779479945; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DbeGwRdLq2Djj/PplELDMQqFCT55W6Gwpz4tqhUJHrU=;
        b=PE82p+R4iPtzjmO+amXeJC8UwF8cfWuTyb7TgWWI642nJhdd1lGSR9NHvQmt8GH/Md
         FTycsfAM+gPoLcuvOAn2o89+Nk5+yqicaGF8TNg8wOGWkBS7omJhIKCKdbI89z2Oi6oS
         fvzZrjQ4PJfyWhD8MhLH4rXAhVWdSUTjaYUA5isVG9j+X+GQhko5QibeFqhAXIriekzb
         /elGv3g3zXKWkngZMTA6/QaoX5PxsHET1C1ybKPKWIn74HZsldhCCTOqUHGIGmEcAjp6
         C3axs3SX4fgCZledjiXRvePIce59rGLij8WL+gyZ26w23MNQ8Lh2oYlduZMJEqqx9HsH
         ophg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778875145; x=1779479945;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DbeGwRdLq2Djj/PplELDMQqFCT55W6Gwpz4tqhUJHrU=;
        b=eP5TTmYdpqij/pFkSC7poxLwZZLCAMnqmAoJMafS7LFqPyXj68UbAxGK7EyuTz+K61
         6XtX8sxnt3x4f07lwkx3AdpHjYGE9V/Gwqmh55dzhJn1QX469my0sag5o1XZQJOpcwra
         JT9xWvuM3SfyXGuU0HWNSSsFdzOc98jxSPON/XUUdsUL1Yj5KsJdFme11w+TmCGnIzqs
         jEHGiY3gJ/OSS8RcmAKJmjn0U2xZd9NfHBAUfMCnv/CPznrzpBXP8zahv8poKzxXx9ac
         dkndTCbmVLtjhwRNWopwWQeT/XZXDIz98+IIWyazJ7hFlFCi/BaRcpP7o34KqOJjEmt5
         2OWA==
X-Forwarded-Encrypted: i=1; AFNElJ8fvuc+o0RgLbxafGKtTWU0piVh/nk5QQiUlJQuxmhhTl3w3mCbPnzSU0hM8cK8n/uzofxv7tg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd3031wSgpIF0dcW7UpXyzw3j+0YWh/1sFgGbDRDhFDHk9V7lc
	g78I3IgttCLfCey45cgUXuCHlnAJ2OpSN2JD80mZghSOQs0h+p4Ijqha+7iX2q0xkzVpaqXa0Fi
	jVM09
X-Gm-Gg: Acq92OFBYelV0H7CyqWnAekPVui8EG/g6LpBHAz8/1RtQCIssXMpqV9dedJfxiUbPbH
	8E/GTc2i1qDVwQt4WdvJYuE1MUnU/y0opixPJCQQOaFt2HzLvH8JGGB/fdCTSVOjJjWTqafy42M
	tr6NkU3evdhFBDuROwGI92cMtyizxl8drehuly/NVgzMbPOtYM8gZ4Q61QBEkJQyQ/ISTr9suJb
	IAJGIu28kR9Zmip20xqJ1czFjIpn3gU9NHLRjR78mZm6XOSSONKp5evdAQwX5cbU/wNHZ5gXqy/
	l7d1Am9Sgs85X4xhBpFfjz5+Xlt7cuyCf8+Q1BuWsL9BLNZws0chClQKwXausZg1ENMVyZl90u2
	V8pXxgO+0qF1yDsJSQvBTmAzXES3UE+1b6tNdTvalhQkvqYlm2c9z71o1J3trVocqQvT7a8h9br
	yWybjECgExurzxMClM
X-Received: by 2002:a05:7022:2586:b0:128:d51a:5161 with SMTP id a92af1059eb24-13504841fefmr2747713c88.27.1778875145235;
        Fri, 15 May 2026 12:59:05 -0700 (PDT)
Received: from 330cfa3079ca ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbcb93f3sm10957615c88.3.2026.05.15.12.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 12:59:04 -0700 (PDT)
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
 /var/tmp/rpm-tmp.rl24IY (%install) in ...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 15 May 2026 19:59:04 -0000
Message-ID: <177887514407.1100.1301868691579667602@330cfa3079ca>
X-Rspamd-Queue-Id: EFE12557317
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernelci.org,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernelci.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-248905-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernelci.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lists.linux.dev:replyto,kernelci.org:email,kernelci.org:url,kernelci.org:dkim,0.97.168.0:email]
X-Rspamd-Action: no action





Hello,

New build issue found on stable-rc/linux-6.1.y:

---
 error: Bad exit status from /var/tmp/rpm-tmp.rl24IY (%install) in binrpm-pkg (/tmp/kci/linux/scripts/Makefile.package:71) [logspec:kbuild,kbuild.other]
---

- dashboard: https://d.kernelci.org/i/maestro:e64bc83917e586a569133d5b8aa4b9b136e425e4
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  0264b4b2bffa15c601db4f4c69f96a326685d4df


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
tar --sort=name --owner=tuxmake:1000 --group=tuxmake:1000 --mtime=@1778873506 --clamp-mtime -caf /tmp/kci/artifacts/build/modules.tar.xz -C /tmp/kci/artifacts/build/modinstall lib
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build INSTALL_DTBS_PATH=/tmp/kci/artifacts/build/dtbsinstall/dtbs ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- dtbs
rm -rf /tmp/kci/artifacts/build/dtbsinstall
mkdir -p /tmp/kci/artifacts/build/dtbsinstall/dtbs
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build INSTALL_DTBS_PATH=/tmp/kci/artifacts/build/dtbsinstall/dtbs ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- dtbs_install
tar --sort=name --owner=tuxmake:1000 --group=tuxmake:1000 --mtime=@1778873506 --clamp-mtime -caf /tmp/kci/artifacts/build/dtbs.tar.xz -C /tmp/kci/artifacts/build/dtbsinstall dtbs
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- binrpm-pkg
Building target platforms: aarch64-linux
Building for target aarch64-linux
warning: line 22: It's not recommended to have unversioned Obsoletes: Obsoletes: kernel-headers
Executing(%mkbuilddir): /bin/sh -e /var/tmp/rpm-tmp.ty3BUE
Executing(%install): /bin/sh -e /var/tmp/rpm-tmp.rl24IY
+ umask 022
+ cd ./kernel-6.1.174_rc1-build
+ /usr/bin/rm -rf ./kernel-6.1.174_rc1-build/BUILDROOT
+ /usr/bin/mkdir -p ./kernel-6.1.174_rc1-build
+ /usr/bin/mkdir ./kernel-6.1.174_rc1-build/BUILDROOT
+ mkdir -p ./kernel-6.1.174_rc1-build/BUILDROOT/boot
+ make -f /tmp/kci/linux/Makefile -s image_name
/tmp/kci/linux/Makefile:747: include/config/auto.conf: No such file or directory
+ cp ./kernel-6.1.174_rc1-build/BUILDROOT/boot/vmlinuz-6.1.174-rc1
cp: missing destination file operand after './kernel-6.1.174_rc1-build/BUILDROOT/boot/vmlinuz-6.1.174-rc1'
Try 'cp --help' for more information.
error: Bad exit status from /var/tmp/rpm-tmp.rl24IY (%install)
RPM build warnings:
RPM build errors:

=====================================================


# Builds where the incident occurred:

## defconfig+aws-ec2 on (arm64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a074d930ed99f002e8f6a23


#kernelci issue maestro:e64bc83917e586a569133d5b8aa4b9b136e425e4

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

