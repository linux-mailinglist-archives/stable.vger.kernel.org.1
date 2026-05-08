Return-Path: <stable+bounces-244790-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AImpIlwK/mm1mQAAu9opvQ
	(envelope-from <stable+bounces-244790-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 18:07:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D270B4F933B
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 18:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C32DB310A6CB
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 16:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B8E40242C;
	Fri,  8 May 2026 15:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="HMpd8ntJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB1F3FF8AA
	for <stable@vger.kernel.org>; Fri,  8 May 2026 15:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778255957; cv=none; b=NbPPTxaT6Dqkwi6TWn432IwYpQPItOglOmY9lseM0NGNY6KNmBg4pauLlw4Xw5hwO4fVyZotu1HdS/mv4DouijZrY878pEZ0sz5Esu0MxNY/2rBB8xZQKg9OQzkFMsBdRF5zuvv2B3uVooU7P9nFi6a4DO5BPZqfDQLSNfqVtA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778255957; c=relaxed/simple;
	bh=3zJfepxlEga7O/f58JSDNobfV/eGMAngepWhOeGUDvM=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=eXrEibF2FpMMuGpreee2aJvr7KA/iI1402/GRryK90dc5lCRX6XYDPP4l9b0fBvzHob/LBbok3JKCFs2fcD9U1glMVAKi/dTbtp1dvNNPdPhOYA1OYaxvd0N4silAVjvxgnAZKNgJZ/VQhEiljgoK7flI/qm45HJlBEr9uMAAlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=HMpd8ntJ; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2f3c623322bso3606056eec.0
        for <stable@vger.kernel.org>; Fri, 08 May 2026 08:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1778255947; x=1778860747; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VjIlJDDJci6rLgZUHJxt0tTdgda69be3rLsI4L2dFBE=;
        b=HMpd8ntJ0qjMMn5ivXFDoGwNQXZ025kTC6unRlnR5XYRtNhiZQRQjHEkwMz3RtpJl4
         GuvV3IpD8h8p855mMtwAJFvE3jLUcX6553OXLdsWhjvxy9bIpTXawhHBlE2c2U+d5op5
         5jbZi9aw909/SyVcAX/cRUJcOdOv0SsK51yzyTyJehLK/qDX7anywlXawi21ZNm6sgvo
         l4ajiUK7sppxdwUAueZGXgiZltcdZyHqu5Lp0wWcjKzU/CSwQpPiLc7djXb3m7JocKuj
         GkHRWh/maemV9Oudd/WvZcH5jQqfTcGOg4v47HpJ1apb308oizF5Z1GYcrfMkYKK0NPu
         s1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778255947; x=1778860747;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VjIlJDDJci6rLgZUHJxt0tTdgda69be3rLsI4L2dFBE=;
        b=XGTa7OveZHm8ElFtAC27M/DBhrItkRKDdnSmtT2KJ2tVklU/rd5/wUeqtyD0LD4z16
         bCxDUF+f1ajXvbY0NW9VGnEFrYuWOMGj+mgBwQKXgEcR/IkeHMVjkMk7DPdFxya4nJTM
         QAgtEeT3EmUowcKWuhbWCP+J7diJHcxuEmh2NLKBSwW+Gk84700rytrhnKKekPd6QxKH
         anCcKjqOG4mHYxKuqTY53YGs8fiEuHD+uxyaAKqsjXCyUQgfDUenBZ80bZ9LmJz0XGII
         i57vIJI0kJm5rdR/eESVqasD2X6BxEzqpfnarJtRM6DWSbYukYqsm5ObXE4eZfrVVeKw
         jsWw==
X-Forwarded-Encrypted: i=1; AFNElJ8rGLSdbQWNjAWhoZNCLDO7PHQw0Ye+zjKnpSJ3RXeEHI3NHvzp9KmqrJtiDSHUd6rxUXEf6VE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4B8gvNgrEHQDg5qJkO6sgA3pYU+Ar5zLkzHHkljPumw4OtIec
	gKSDuX/xnX/2aEW9JyPgEMRMFJm5U4JJw5TIQ2mEFfhX91BDxRNO3T8x65dGaYS/FYE=
X-Gm-Gg: Acq92OHjaEUnFCTJMkMQhbesJzargTm+YtAcAsAbFeQfARKTrXv5mtPDrKI5Ht5FNow
	sPh7pfMfWl2xdoVhehrzOlBjgrEQ7S7rhEe3SdkH6mU6Tin8wYOSfMcrUJUFyHbPXxnUJmsaFzN
	WjmGHVJsPEZgxyiErHdDHFF/Ow22u6iHBy6Q69fDGECKuPoAVbf9ANVeK3mGa39LDxvf4cRnfPu
	Cz6z606foxG8x8JYMjyNewLDG1LlHdgmFQSqST9LBYfGyxX258Mqy21eFGwR3mLEbOhhWrbdtOE
	Dg3jWVU/TSOXE8UxAgOhkNty94odw0D/Mqeo1gtYBo2gHSoNpAyTv2Zfo0zJOcdzkyk9/KndYIv
	NDXuCG/sI7CPl4UCjnTb20B0R/+oXX7BdpFxf09rVJog3tvr+8ZJhhveGCuV/NOQ5QaCPV3wXUE
	Ji5TSeS2aGxQiEZiq9
X-Received: by 2002:a05:7300:dc04:b0:2da:4216:7ea3 with SMTP id 5a478bee46e88-2f54b892059mr7031267eec.14.1778255946831;
        Fri, 08 May 2026 08:59:06 -0700 (PDT)
Received: from 997d03828cfd ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8859eb4b7sm2819212eec.2.2026.05.08.08.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 08:59:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable/linux-5.15.y: (build) error: Bad exit status from
 /var/tmp/rpm-tmp.3MDgDj (%install) in ...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 08 May 2026 15:59:06 -0000
Message-ID: <177825594564.4250.3252229859415804906@997d03828cfd>
X-Rspamd-Queue-Id: D270B4F933B
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
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernelci.org,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-244790-lists,stable=lfdr.de];
	R_DKIM_ALLOW(0.00)[kernelci.org:s=google];
	DKIM_TRACE(0.00)[kernelci.org:+];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernelci.org,stable@vger.kernel.org];
	HAS_REPLYTO(0.00)[kernelci@lists.linux.dev];
	NEURAL_HAM(-0.00)[-0.822];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,0.0.0.0:email]
X-Rspamd-Action: no action





Hello,

New build issue found on stable/linux-5.15.y:

---
 error: Bad exit status from /var/tmp/rpm-tmp.3MDgDj (%install) in binrpm-pkg (/tmp/kci/linux/scripts/Makefile.package:68) [logspec:kbuild,kbuild.other]
---

- dashboard: https://d.kernelci.org/i/maestro:6cceb1809dceddad93ab97d4802ebbaeea14bc52
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
- commit HEAD:  de8dfb3f0278dbf02ec63612f0ebdf7b92870d58
- tags: v5.15.206

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
tar --sort=name --owner=tuxmake:1000 --group=tuxmake:1000 --mtime=@1778252152 --clamp-mtime -caf /tmp/kci/artifacts/build/modules.tar.xz -C /tmp/kci/artifacts/build/modinstall lib
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build INSTALL_DTBS_PATH=/tmp/kci/artifacts/build/dtbsinstall/dtbs ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- dtbs
rm -rf /tmp/kci/artifacts/build/dtbsinstall
mkdir -p /tmp/kci/artifacts/build/dtbsinstall/dtbs
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build INSTALL_DTBS_PATH=/tmp/kci/artifacts/build/dtbsinstall/dtbs ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- dtbs_install
tar --sort=name --owner=tuxmake:1000 --group=tuxmake:1000 --mtime=@1778252152 --clamp-mtime -caf /tmp/kci/artifacts/build/dtbs.tar.xz -C /tmp/kci/artifacts/build/dtbsinstall dtbs
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- binrpm-pkg
Building target platforms: aarch64
Building for target aarch64
warning: line 19: It's not recommended to have unversioned Obsoletes: Obsoletes: kernel-headers
Executing(%mkbuilddir): /bin/sh -e /var/tmp/rpm-tmp.jCwbmm
Executing(%install): /bin/sh -e /var/tmp/rpm-tmp.3MDgDj
+ umask 022
+ cd ./kernel-5.15.206-build
+ /usr/bin/rm -rf ./kernel-5.15.206-build/BUILDROOT
+ /usr/bin/mkdir -p ./kernel-5.15.206-build
+ /usr/bin/mkdir ./kernel-5.15.206-build/BUILDROOT
+ mkdir -p ./kernel-5.15.206-build/BUILDROOT/boot
+ make -f /tmp/kci/linux/Makefile -s image_name
/tmp/kci/linux/Makefile:669: include/config/auto.conf: No such file or directory
+ cp ./kernel-5.15.206-build/BUILDROOT/boot/vmlinuz-5.15.206
cp: missing destination file operand after './kernel-5.15.206-build/BUILDROOT/boot/vmlinuz-5.15.206'
Try 'cp --help' for more information.
error: Bad exit status from /var/tmp/rpm-tmp.3MDgDj (%install)
RPM build warnings:
RPM build errors:

=====================================================


# Builds where the incident occurred:

## defconfig+aws-ec2 on (arm64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:69fdf8a50e4ee292cbf04e21


#kernelci issue maestro:6cceb1809dceddad93ab97d4802ebbaeea14bc52

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

