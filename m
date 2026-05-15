Return-Path: <stable+bounces-247720-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MuHECIMB2oLrAIAu9opvQ
	(envelope-from <stable+bounces-247720-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:05:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D6C54F0B5
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C68B3304ED72
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 12:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB0047ECD4;
	Fri, 15 May 2026 11:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="YYeEmqXN"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7F9145B11
	for <stable@vger.kernel.org>; Fri, 15 May 2026 11:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778846348; cv=none; b=V6oOprTPLjEhOA7WMrladBYIMk4eJhF8D3iHryvFNhme/rAhG6rEPCjQAQV1Xvn059Zrbj9uFvqrI2CrsLax1vZrud8zF7fBfJc841XxUDZXxdhgWwLoPOojmwbLAsYuriN+YHibbEHrUB1BzljeaNOXfFOrbz/UZo23v3R8QFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778846348; c=relaxed/simple;
	bh=S0zb5hd8tE79VmDjQ5446RyLsNgRXWTU1os8Zqo6h/4=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=SoKA8j0xJCFNEZcfDm/7PAmP7R9GuvypuNFJdGA8sF7OT+qUYR5ZYZJsYxd6txP/CX2Xzpq/rS0nUwVFo/jQ/Qhe5vQqUwjt8GAMzHZQqm/NvZe78tDBaWoNHoV9FF7upwOaGEMI72j4++F3P4aJOA3wudot3xUjmGPXi3sXK3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=YYeEmqXN; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2f33ae12f97so5763946eec.1
        for <stable@vger.kernel.org>; Fri, 15 May 2026 04:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1778846346; x=1779451146; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dsFE1Vqsi7uaTN5UInCJcgiZbmHVQImIuZfhUoFvBZI=;
        b=YYeEmqXN+XG/X4jWGKmcZuMnb+QVUwZWBhZYWVKJbglJ6+EgMiyH9VD0bPjogNoQ1A
         esRULOIfEfAfsvmmTLfLid944VKQFOkJTfKyE+JIY6uT3uWb0ItCRUXZeifIjgp2YfTd
         ec7AtW+fSoDR0RbWhCOjmZsL0zp0fEsEXz+APatSvZYul/J3qqoFVU5dYEZuDFpQ0egE
         Pxy65+svCd3pN9UbUXfVGbhN2mcnKgoNnbPotOJgUNaylxiLlXR8dbKaU5aX7cdx0YXf
         aE1ckA6ddzX9Bml6eCgqW2LhLlpU6Ty1XCnkLJ64I71zdWvnvloU/78WOb3MO1XviSEa
         Gg1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778846346; x=1779451146;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dsFE1Vqsi7uaTN5UInCJcgiZbmHVQImIuZfhUoFvBZI=;
        b=Hkmr7isMJYRRyxBAJp2lSh1qbJkBenYsqiU8n/c5gaJREMdSUvID+gnTcbuyGn7h1R
         pGCIO8XHpDe2l4A9ek6lqgFSRF4donp6PGRPvT6nSTaDr9Sr11Lk07i1xaBbJg48j8NM
         Fd19E8a3eepkH44/tPyfG5AnTne+zacD7ukrVvSRQhCjKTkn0Tbc4Ee6uKnq+MDYs23N
         rKuRDrF0nZmuzTBVTLjk0mMREwKMf9m54a2xo9+odu82DEHIBnLkZ5KTw23UBKOA4ZFC
         ddeBQb088j48TSS8xKyw41b6KEZW4eI42IxDoAiEYmfxpP5pK4JkKNCjUF6ag5vcVepV
         4Z/A==
X-Forwarded-Encrypted: i=1; AFNElJ/cg8nDvdnQBgH3KbtdYHldYtkk0TOHNbY+ihNRDfwzSRy1s/sNRRLYbkLXSYk7qU0U8RSUa8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVZJq5NxFnYtCIw2liUjgvIdH220e2jaRfji9LcB0c9S3hVk/K
	Dy8ZBZMSSuXiX0djFmdXkMUeeVYNVF7jFGTmx8UZxkqp8InnaBx4ryXxYrNBC4DjGb2Oh/4BtwF
	+RRr/
X-Gm-Gg: Acq92OEms/j2E3T7kWsenGGoTtzVnX372ZF9jyN7oVQ8GoUXaT5RuKj0LdYX3rrOQ0l
	maYS2kHvi4OzAQ0RaRHdDCPfAj4MyGKSebmmS5g6hTxkrWu03a+Q8nrCZ1ZB6ur0QCcewYZgqO6
	pVL2VZ3D6/1Hl02/kjBTDYIw7e1RerAV0+DIWZf/5alfSIOBSxHhOpMAqDK4JDS0JwuTHFsMbTT
	VCvmYayicqK4XWEUEd0NsoINtmhdBlAlefWbdxG8Om4KwW/Ag/fuy0zelCru8YE48u060phctt9
	XcQSQZzePILrWmImEZ/LFm72me/eKU3tQkHFkj/3t6rrXG9k8U9hkMD9B5CIUACDOWgRoHEEKUS
	V3nuk309B4bJqHGgxsMUeKu5FXKobGd89yOr0uDJQ4dc1/oPHaWPK6sSfxN7XghWg8AjaPGyVA4
	h+3xf0VbTy9qrNelpv
X-Received: by 2002:a05:7301:198e:b0:2f7:e322:725f with SMTP id 5a478bee46e88-303986aac62mr1810924eec.33.1778846345572;
        Fri, 15 May 2026 04:59:05 -0700 (PDT)
Received: from 330cfa3079ca ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30293e2ea6dsm6740157eec.4.2026.05.15.04.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 04:59:04 -0700 (PDT)
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
 /var/tmp/rpm-tmp.T8Jqk5 (%install) in ...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 15 May 2026 11:59:04 -0000
Message-ID: <177884634407.947.15906430783828618676@330cfa3079ca>
X-Rspamd-Queue-Id: C6D6C54F0B5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernelci.org,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernelci.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_FROM(0.00)[bounces-247720-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernelci.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernelci.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[kernelci@lists.linux.dev]
X-Rspamd-Action: no action





Hello,

New build issue found on stable-rc/linux-6.1.y:

---
 error: Bad exit status from /var/tmp/rpm-tmp.T8Jqk5 (%install) in binrpm-pkg (/tmp/kci/linux/scripts/Makefile.package:71) [logspec:kbuild,kbuild.other]
---

- dashboard: https://d.kernelci.org/i/maestro:c875f0011efabcc90d733ebe654c81940845420e
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  75fd020d62d50b059da5e5c922a9e68296254adf


Please include the KernelCI tag when submitting a fix:

Reported-by: kernelci.org bot <bot@kernelci.org>


Log excerpt:
=====================================================
# /tmp/kci/artifacts/fragments/0.config -> /tmp/kci/artifacts/build/0.config
# /tmp/kci/artifacts/fragments/1.config -> /tmp/kci/artifacts/build/1.config
make --silent --keep-going --jobs=16 O=/tmp/kci/artifacts/build ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- defconfig
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
make --silent --keep-going --jobs=16 O=/tmp/kci/artifacts/build ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- olddefconfig
make --silent --keep-going --jobs=16 O=/tmp/kci/artifacts/build ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf-
/tmp/kci/linux/arch/arm64/boot/dts/qcom/msm8996.dtsi:2954.36-2962.5: Warning (clocks_property): /soc/clock-controller@6400000: Missing property '#clock-cells' in node /soc/mailbox@9820000 or bad phandle (referred from clocks[2])
/tmp/kci/linux/arch/arm64/boot/dts/qcom/msm8996.dtsi:2954.36-2962.5: Warning (clocks_property): /soc/clock-controller@6400000: Missing property '#clock-cells' in node /soc/mailbox@9820000 or bad phandle (referred from clocks[2])
/tmp/kci/linux/arch/arm64/boot/dts/qcom/msm8996.dtsi:2954.36-2962.5: Warning (clocks_property): /soc/clock-controller@6400000: Missing property '#clock-cells' in node /soc/mailbox@9820000 or bad phandle (referred from clocks[2])
/tmp/kci/linux/arch/arm64/boot/dts/qcom/msm8996.dtsi:2954.36-2962.5: Warning (clocks_property): /soc/clock-controller@6400000: Missing property '#clock-cells' in node /soc/mailbox@9820000 or bad phandle (referred from clocks[2])
/tmp/kci/linux/arch/arm64/boot/dts/qcom/msm8996.dtsi:2954.36-2962.5: Warning (clocks_property): /soc/clock-controller@6400000: Missing property '#clock-cells' in node /soc/mailbox@9820000 or bad phandle (referred from clocks[2])
/tmp/kci/linux/arch/arm64/boot/dts/qcom/msm8996.dtsi:2954.36-2962.5: Warning (clocks_property): /soc/clock-controller@6400000: Missing property '#clock-cells' in node /soc/mailbox@9820000 or bad phandle (referred from clocks[2])
/tmp/kci/linux/arch/arm64/boot/dts/qcom/msm8996.dtsi:2954.36-2962.5: Warning (clocks_property): /soc/clock-controller@6400000: Missing property '#clock-cells' in node /soc/mailbox@9820000 or bad phandle (referred from clocks[2])
/tmp/kci/linux/arch/arm64/boot/dts/qcom/msm8996.dtsi:2954.36-2962.5: Warning (clocks_property): /soc/clock-controller@6400000: Missing property '#clock-cells' in node /soc/mailbox@9820000 or bad phandle (referred from clocks[2])
/tmp/kci/linux/arch/arm64/boot/dts/qcom/msm8996.dtsi:2954.36-2962.5: Warning (clocks_property): /soc/clock-controller@6400000: Missing property '#clock-cells' in node /soc/mailbox@9820000 or bad phandle (referred from clocks[2])
make --silent --keep-going --jobs=16 O=/tmp/kci/artifacts/build ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- Image.gz
rm -rf /tmp/kci/artifacts/build/modinstall
make --silent --keep-going --jobs=16 O=/tmp/kci/artifacts/build INSTALL_MOD_STRIP=1 INSTALL_MOD_PATH=/tmp/kci/artifacts/build/modinstall ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- modules_install
tar --sort=name --owner=tuxmake:1000 --group=tuxmake:1000 --mtime=@1778843202 --clamp-mtime -caf /tmp/kci/artifacts/build/modules.tar.xz -C /tmp/kci/artifacts/build/modinstall lib
make --silent --keep-going --jobs=16 O=/tmp/kci/artifacts/build INSTALL_DTBS_PATH=/tmp/kci/artifacts/build/dtbsinstall/dtbs ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- dtbs
rm -rf /tmp/kci/artifacts/build/dtbsinstall
mkdir -p /tmp/kci/artifacts/build/dtbsinstall/dtbs
make --silent --keep-going --jobs=16 O=/tmp/kci/artifacts/build INSTALL_DTBS_PATH=/tmp/kci/artifacts/build/dtbsinstall/dtbs ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- dtbs_install
tar --sort=name --owner=tuxmake:1000 --group=tuxmake:1000 --mtime=@1778843202 --clamp-mtime -caf /tmp/kci/artifacts/build/dtbs.tar.xz -C /tmp/kci/artifacts/build/dtbsinstall dtbs
make --silent --keep-going --jobs=16 O=/tmp/kci/artifacts/build ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- binrpm-pkg
Building target platforms: aarch64-linux
Building for target aarch64-linux
warning: line 22: It's not recommended to have unversioned Obsoletes: Obsoletes: kernel-headers
Executing(%mkbuilddir): /bin/sh -e /var/tmp/rpm-tmp.UXbKU4
Executing(%install): /bin/sh -e /var/tmp/rpm-tmp.T8Jqk5
+ umask 022
+ cd ./kernel-6.1.173_rc1-build
+ /usr/bin/rm -rf ./kernel-6.1.173_rc1-build/BUILDROOT
+ /usr/bin/mkdir -p ./kernel-6.1.173_rc1-build
+ /usr/bin/mkdir ./kernel-6.1.173_rc1-build/BUILDROOT
+ mkdir -p ./kernel-6.1.173_rc1-build/BUILDROOT/boot
+ make -f /tmp/kci/linux/Makefile -s image_name
/tmp/kci/linux/Makefile:747: include/config/auto.conf: No such file or directory
+ cp ./kernel-6.1.173_rc1-build/BUILDROOT/boot/vmlinuz-6.1.173-rc1
cp: missing destination file operand after './kernel-6.1.173_rc1-build/BUILDROOT/boot/vmlinuz-6.1.173-rc1'
Try 'cp --help' for more information.
error: Bad exit status from /var/tmp/rpm-tmp.T8Jqk5 (%install)
RPM build warnings:
RPM build errors:

=====================================================


# Builds where the incident occurred:

## defconfig+aws-ec2 on (arm64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a06f67f0ed99f002e8bdf38


#kernelci issue maestro:c875f0011efabcc90d733ebe654c81940845420e

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

