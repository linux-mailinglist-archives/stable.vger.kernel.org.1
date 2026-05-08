Return-Path: <stable+bounces-244798-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDeFGmwW/mkTmwAAu9opvQ
	(envelope-from <stable+bounces-244798-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 18:59:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B58D84F9A6E
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 18:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 756083026A9C
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 16:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FB140DFC4;
	Fri,  8 May 2026 16:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="X0/+hFkQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6D440DFC2
	for <stable@vger.kernel.org>; Fri,  8 May 2026 16:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778259552; cv=none; b=Qy/PejhjHHuo35jYy3uU2VHzhcHnRp7//XLS0Kr2Kt8Z3VvGFw4fEgTSb95/q3Myi/u4XVJ3QW5h2V6w/QvgEeSDpd3u1f1xsNQ9etRNOHXR0RPl7/6MH5ujiSZahHdPGx+czUZ0C7MrOuX39EY0vgMpcyjlrUjTvu2489M8VWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778259552; c=relaxed/simple;
	bh=y3cZf7tR6W/sucGOsE6hRTxyFTbTMudeIl/nmbiTFZY=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=mq3oiA1eOtskWd0R8NY5bOa16Ac6Udg8zsaSfzPZ3dN5Qy8ORs4d2KTlgbhJZgRU01NkMSmA60zAezNpkeuEcUS7ASoqPhzkSL76s1N6VGKaKr8Yi+tDjKYTJ4RzgcUVCk8oxZxMx9TXAsrv4PZlgLWC8yOmEqb2NpiKH6aFzOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=X0/+hFkQ; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2ef2a1cc06dso691317eec.0
        for <stable@vger.kernel.org>; Fri, 08 May 2026 09:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1778259548; x=1778864348; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/z0bb71qY9OyJxrjP9XQAMNA6QuAbRVnICmxbgxUBWE=;
        b=X0/+hFkQROZTapB0g/ItHlVtCH7bLOiuQnQUNtddHK/FfTXDI27rVLZqrxziQrppR8
         /oq/Qj/1PkhBlxV/Ca1ZSP/T0fl6d2tB1pMzUJGrXRGsrUBqgk7L39q/zu1N3Y8qdtMm
         1nRVIam0u9G2qvuo3vtNm5kW5LQflcLHkQ73YVDDmreuGizm5tyo0ehzbdAqsXFg/ENe
         eRF0g2njwevgOVAUwZ28t87DqLT1K4ctU2aDbUpMVVJsOSAGAzrBFVY6TpDG7WxlAkX1
         9rAKn6azc6kqOoXTqkWK1OXizME55o3+JeZXJDpOz0xqRggSKuwB5biN9kl9+OXlb885
         1UzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778259548; x=1778864348;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/z0bb71qY9OyJxrjP9XQAMNA6QuAbRVnICmxbgxUBWE=;
        b=AdqczbjsJNjoaOy37OiL1R6GEH23SDYck01TJf1/amFcwRDXp5P6Iqh/yiwpgDDCDB
         nx9QamWYbSi+dD0p5DG7TvualMn2rrBSvnoexWJYTh1DGnWfWEXCYiqJqwhUuP+EnXWE
         LxrMsSdQcUFfXZttmjBVZcDMaiwljXqfMPeRV0KRK1G+pvMEdGh0qbbsx0yi6910unOd
         kxXf+zCyAwcuLGynR+XNsagccLczUVQkrhWx0xGroIL5yW1LfM2je3V5r4NpqBmyVXaG
         9reDf70u5vFCTbjMwCWhRYE7LMNwXs1OUtJWCRX1rd14KRQs7nYb0L2UdhJ3HW9xSc/H
         Exhw==
X-Forwarded-Encrypted: i=1; AFNElJ8+AtQPM/bE1ZIKoU3mvp3TrIRO80JgNSXfvDglHN8vVK5CgitvY4nK/T43wq9iH53Y5msQZ44=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG404lyel1vgvzdh5lmuy6P+jqDi+H8FCeNoKbqWSppxStQJul
	bO3Rb/sW/onIxUSayKvBcfTy2fLgl9PwrhIdnp1M3BeI6QazTMHfuUi1TAGeLm2WZO4=
X-Gm-Gg: Acq92OHDtv5QQhartp+J3xmglPBazIXGaKbJtyrSaBQ89ibqAMA/6eS13rAa35mmsTC
	/8T1zew9Eoj0+uVaJ6nCueNgviBtWs59hfFSkXwfPlSc1V1DSrU1cb6p//6J8UmAHwBA2dl8Rnu
	B+OIYsYrYJPs26LaKPYHd3ROQnxDxd65ij+V9v55MIb2oMHDldoJ2aHOA1Hle6iN8gTrlk4hl/c
	LgW00MTFneKVb5iR04kxOX283Q7QrHjxG5yHs3Lj9n4h4DjPlwpip8mwcem2C9BdrrdSyloFRnP
	zM/HMLQ3SoWt9Oz28Faxco0sLPRf9hIZ1YGktUzo6cD/OF/dvwtaqWHyE+9EqJV1i+TFw+8xChI
	5sCvvBG/Mx9twGdgi0xghTp5PrbzMyklqhgZD6nti2E2gWzCmnFQf72sFsvNUrLQkZHyGkntTyf
	6NIFEioYb2x0S+ek5jk8SomAg4H/c7jyiAFxrDTg==
X-Received: by 2002:a05:7300:cc90:b0:2ed:6f94:9d94 with SMTP id 5a478bee46e88-2f549f5f684mr4043237eec.19.1778259547215;
        Fri, 08 May 2026 09:59:07 -0700 (PDT)
Received: from 997d03828cfd ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8859eafcdsm3663384eec.6.2026.05.08.09.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 09:59:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable/linux-6.1.y: (build) error: Bad exit status from
 /var/tmp/rpm-tmp.1wiLwW (%install) in ...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 08 May 2026 16:59:06 -0000
Message-ID: <177825954610.4269.5805271519178733882@997d03828cfd>
X-Rspamd-Queue-Id: B58D84F9A6E
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
	DKIM_TRACE(0.00)[kernelci.org:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-244798-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lists.linux.dev:replyto,kernelci.org:email,kernelci.org:url,kernelci.org:dkim]
X-Rspamd-Action: no action





Hello,

New build issue found on stable/linux-6.1.y:

---
 error: Bad exit status from /var/tmp/rpm-tmp.1wiLwW (%install) in binrpm-pkg (/tmp/kci/linux/scripts/Makefile.package:71) [logspec:kbuild,kbuild.other]
---

- dashboard: https://d.kernelci.org/i/maestro:24c2a938b5327f34fd898781275a882275672937
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
- commit HEAD:  ad16b162f21d970235ced0c7e36e960c227317e8
- tags: v6.1.172

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
tar --sort=name --owner=tuxmake:1000 --group=tuxmake:1000 --mtime=@1778255684 --clamp-mtime -caf /tmp/kci/artifacts/build/modules.tar.xz -C /tmp/kci/artifacts/build/modinstall lib
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build INSTALL_DTBS_PATH=/tmp/kci/artifacts/build/dtbsinstall/dtbs ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- dtbs
rm -rf /tmp/kci/artifacts/build/dtbsinstall
mkdir -p /tmp/kci/artifacts/build/dtbsinstall/dtbs
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build INSTALL_DTBS_PATH=/tmp/kci/artifacts/build/dtbsinstall/dtbs ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- dtbs_install
tar --sort=name --owner=tuxmake:1000 --group=tuxmake:1000 --mtime=@1778255684 --clamp-mtime -caf /tmp/kci/artifacts/build/dtbs.tar.xz -C /tmp/kci/artifacts/build/dtbsinstall dtbs
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- binrpm-pkg
Building target platforms: aarch64-linux
Building for target aarch64-linux
warning: line 22: It's not recommended to have unversioned Obsoletes: Obsoletes: kernel-headers
Executing(%mkbuilddir): /bin/sh -e /var/tmp/rpm-tmp.RRo07B
Executing(%install): /bin/sh -e /var/tmp/rpm-tmp.1wiLwW
+ umask 022
+ cd ./kernel-6.1.172-build
+ /usr/bin/rm -rf ./kernel-6.1.172-build/BUILDROOT
+ /usr/bin/mkdir -p ./kernel-6.1.172-build
+ /usr/bin/mkdir ./kernel-6.1.172-build/BUILDROOT
+ mkdir -p ./kernel-6.1.172-build/BUILDROOT/boot
+ make -f /tmp/kci/linux/Makefile -s image_name
/tmp/kci/linux/Makefile:747: include/config/auto.conf: No such file or directory
+ cp ./kernel-6.1.172-build/BUILDROOT/boot/vmlinuz-6.1.172
cp: missing destination file operand after './kernel-6.1.172-build/BUILDROOT/boot/vmlinuz-6.1.172'
Try 'cp --help' for more information.
error: Bad exit status from /var/tmp/rpm-tmp.1wiLwW (%install)
RPM build warnings:
RPM build errors:

=====================================================


# Builds where the incident occurred:

## defconfig+aws-ec2 on (arm64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:69fe06f00e4ee292cbf0f937


#kernelci issue maestro:24c2a938b5327f34fd898781275a882275672937

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

