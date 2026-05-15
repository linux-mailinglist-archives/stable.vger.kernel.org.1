Return-Path: <stable+bounces-248898-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEcBDxRtB2rY2gIAu9opvQ
	(envelope-from <stable+bounces-248898-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 20:59:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3495568BB
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 20:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1980300A754
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3E937BE73;
	Fri, 15 May 2026 18:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="ev1owZ1Q"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415FC35E1A9
	for <stable@vger.kernel.org>; Fri, 15 May 2026 18:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778871547; cv=none; b=mj5Dmz1/YHxivCJpNdcGe24MOTDyw6rQB2zPiz9KFDtBC/qFdgY8xi5IDh1tGIZ7//Rt+gH2st4VrVJGWCNZBu+cP+DhkdUkh8ThVCnROTLue5aVR98980m62rChjlXfYA9GFjaJN5ExV08o3/eLWC5tW/f05oG3nP/bQlPquXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778871547; c=relaxed/simple;
	bh=ZQc6/LVrFY/wvECGQ+Gm52PdBMKcw6XRlValtWu4kIs=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=LSsx1F6O5Z6KVCiaFkFZxwIVGEMz+pTOqUnUD2RRAecNz7C10BJsTy8dLEM0bqLmZW+ZUFrKMfzHqdbGFTebFLjp3/ZEakphnThP7xFqaO37ELHdHu8vAVSuejufuz5t7Gcb3a0+MVyopIPPSo7vy7SH5bEW38LTsAETEJykFSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=ev1owZ1Q; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-132830d8281so332563c88.1
        for <stable@vger.kernel.org>; Fri, 15 May 2026 11:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1778871545; x=1779476345; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g6hrFMrDy+BJLIoRJUZB0FlD9oy0qN9LKUwt5l1EzyA=;
        b=ev1owZ1QJBH3qaEb6GKC3nD8Bje8VtcVGQ6cJRlF9ip5SLzeOrc3Soa827W3hOlR5N
         Un9b2AEwaSk6sSn1rcPZw7h9RtZxi940xrm07vxSmtH1cRbwszhkgtycqizmTRJ6V8mB
         McAVWeS50ISrG17plL0pdR9b4sNSn0we/iKFFiM0jFdOtGhLGvTlyN9Jr2jERZAlyB6E
         9Ygmj5Aeg1tpbqOJw0l/PN0l+gRCf9Uex3ITXN0J38DY6BuNeaXcsiKXakH/DbiGv09G
         FDvP36h4N3iC/MH6VbhZF4F7pzCuVI1IGVhHTX6Y/nRT4cEANp2fKLSBnhBHPSpIR7tW
         /s2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778871545; x=1779476345;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g6hrFMrDy+BJLIoRJUZB0FlD9oy0qN9LKUwt5l1EzyA=;
        b=OoBEozPa+KX6s+jKzEt3zhg9GfKAXgIbz75aH80EmFyYt9qgI9Aj9o9+9+7Yvar2Uj
         XBoi98XgTcL0g2TNSofbIv9Wy3hsWJjsEIkBB4ME4kOlJHdGDDK2iW2RcPrNSti02Ik6
         YMo0P8XOVH1u4TtL1Rd1HtYpu/UGNGGbkKG21Vu5/ihLIYT4gp9r/rrQbAMMbsUuHkEb
         HCuj0T/qpzdb7RQ+uGV143ZrIODtBYPeJqRDaNVIa1bL3rMW4XzBFtf4FN1Ym2EbR1do
         SvvYLvodYoq60yqRnyz4YM3jpIM4lwP4O1WY9Y81AtvuNcgqX88wzFRVsJrkmwCSFrgc
         Tpnw==
X-Forwarded-Encrypted: i=1; AFNElJ9cIOoWa9vjkkgj86uTQS5XRaCIqfWwl64z/r6ShjiaHkh10vTu7q7WV5rItnnIvJI8Ym3JDTs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym/rVg3zFSwLnGVoKHuXZ+YFgr4gwDqFRMMeWPspKeQQxm8YGQ
	mb8m/23l2PavqcYywN+pQIRWr4Mg0lPz73dhM+WOQ56lrDvjvYS1O1iC132rfuR8U94=
X-Gm-Gg: Acq92OFUvSUPsNwWLtsGhYrvxGVp4j9I+Tws9I9E3i1qC2XPlw3MGpAbIk/JjeND4i8
	BxRa5B85N2vamKzCvkv24K+yMeNkstBgRQGPWdH47CfGuFO8g8YZE0Fe/p2Ocz0MTtqeD4yf8H8
	sLPgqxNhnnO1grxoeNeEc+aH5kkMPX5emUmsCQFCyX10MludzlXx4JaSnL+kjy+wuzpZDI0VkyP
	Z3EpBvpYpzj9HU6Gl0qIP/8JUa67QfTmA22++IfZfOCX295WpKoYUEuJR94/Aj2YY8cg3xc/diS
	2yzNK81A1yQdvg9UNmlZaHezG7ade/bsPDSZ3Zciyr2Fifw7SN7+2meMQlW060mK3Ibg+mE44Ga
	R/4Vf35H6vLp3uoHo792F6bswuYFHAWCyp4v7Dmz2unPIBJmusIWaxEERYkeYBgaUeIdNfNuX0K
	hyRdfGmeOIrk61YMCv
X-Received: by 2002:a05:7022:301:b0:12d:c730:c7f with SMTP id a92af1059eb24-13505538487mr2407277c88.33.1778871545171;
        Fri, 15 May 2026 11:59:05 -0700 (PDT)
Received: from 330cfa3079ca ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cc3490bcsm9474736c88.15.2026.05.15.11.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 11:59:04 -0700 (PDT)
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
 /var/tmp/rpm-tmp.5En1GC (%install) in ...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 15 May 2026 18:59:04 -0000
Message-ID: <177887154397.1081.10051963817255281518@330cfa3079ca>
X-Rspamd-Queue-Id: 8A3495568BB
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
	TAGGED_FROM(0.00)[bounces-248898-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kernelci.org:email,kernelci.org:url,kernelci.org:dkim,linux.dev:email]
X-Rspamd-Action: no action





Hello,

New build issue found on stable-rc/linux-6.1.y:

---
 error: Bad exit status from /var/tmp/rpm-tmp.5En1GC (%install) in binrpm-pkg (/tmp/kci/linux/scripts/Makefile.package:71) [logspec:kbuild,kbuild.other]
---

- dashboard: https://d.kernelci.org/i/maestro:f9bd75e9ff6070e79c87ed0de2375ebeb2fa9ec3
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  0264b4b2bffa15c601db4f4c69f96a326685d4df


Please include the KernelCI tag when submitting a fix:

Reported-by: kernelci.org bot <bot@kernelci.org>


Log excerpt:
=====================================================
# /tmp/kci/artifacts/fragments/0.config -> /tmp/kci/artifacts/build/0.config
# /tmp/kci/artifacts/fragments/1.config -> /tmp/kci/artifacts/build/1.config
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build ARCH=x86_64 SRCARCH=x86 CROSS_COMPILE=x86_64-linux-gnu- x86_64_defconfig
scripts/kconfig/merge_config.sh -m -O /tmp/kci/artifacts/build /tmp/kci/artifacts/build/.config /tmp/kci/artifacts/build/0.config /tmp/kci/artifacts/build/1.config
Using /tmp/kci/artifacts/build/.config as base
Merging /tmp/kci/artifacts/build/0.config
Value of CONFIG_ENA_ETHERNET is redefined by fragment /tmp/kci/artifacts/build/0.config:
Previous value: # CONFIG_ENA_ETHERNET is not set
New value: CONFIG_ENA_ETHERNET=y
Value of CONFIG_BLK_DEV_NVME is redefined by fragment /tmp/kci/artifacts/build/0.config:
Previous value: # CONFIG_BLK_DEV_NVME is not set
New value: CONFIG_BLK_DEV_NVME=y
Value of CONFIG_XFS_FS is redefined by fragment /tmp/kci/artifacts/build/0.config:
Previous value: # CONFIG_XFS_FS is not set
New value: CONFIG_XFS_FS=y
Merging /tmp/kci/artifacts/build/1.config
#
# merged configuration written to /tmp/kci/artifacts/build/.config (needs make)
#
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build ARCH=x86_64 SRCARCH=x86 CROSS_COMPILE=x86_64-linux-gnu- olddefconfig
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build ARCH=x86_64 SRCARCH=x86 CROSS_COMPILE=x86_64-linux-gnu-
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build ARCH=x86_64 SRCARCH=x86 CROSS_COMPILE=x86_64-linux-gnu- bzImage
rm -rf /tmp/kci/artifacts/build/modinstall
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build INSTALL_MOD_STRIP=1 INSTALL_MOD_PATH=/tmp/kci/artifacts/build/modinstall ARCH=x86_64 SRCARCH=x86 CROSS_COMPILE=x86_64-linux-gnu- modules_install
tar --sort=name --owner=tuxmake:1000 --group=tuxmake:1000 --mtime=@1778868267 --clamp-mtime -caf /tmp/kci/artifacts/build/modules.tar.xz -C /tmp/kci/artifacts/build/modinstall lib
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build ARCH=x86_64 SRCARCH=x86 CROSS_COMPILE=x86_64-linux-gnu- binrpm-pkg
Building target platforms: x86_64-linux
Building for target x86_64-linux
warning: line 22: It's not recommended to have unversioned Obsoletes: Obsoletes: kernel-headers
Executing(%mkbuilddir): /bin/sh -e /var/tmp/rpm-tmp.k61NlG
Executing(%install): /bin/sh -e /var/tmp/rpm-tmp.5En1GC
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
error: Bad exit status from /var/tmp/rpm-tmp.5En1GC (%install)
RPM build warnings:
RPM build errors:

=====================================================


# Builds where the incident occurred:

## x86_64_defconfig+aws-ec2 on (x86_64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a074de40ed99f002e8f6e44


#kernelci issue maestro:f9bd75e9ff6070e79c87ed0de2375ebeb2fa9ec3

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

