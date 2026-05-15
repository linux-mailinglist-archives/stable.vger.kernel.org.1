Return-Path: <stable+bounces-247759-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJ2VOzUjB2rasAIAu9opvQ
	(envelope-from <stable+bounces-247759-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:44:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7126550ACA
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C0012303C9B3
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 12:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969CC2C21F4;
	Fri, 15 May 2026 12:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="IQEBwuyI"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050E12D3725
	for <stable@vger.kernel.org>; Fri, 15 May 2026 12:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778849949; cv=none; b=ZFU3Oezxptyfs9hs3jMQAHNf1Ga/FIKC5ndMl6pzlzZ4CbE1oJz5gBvcdTXQGTq17SUprkUorUuAR8WoXE4HtvjkT45PZQrs2NyESYl3rvLzOYmNPpVUnWRJDJmJerh5FVgjdL3ulBvRJ1+bK/eMDDwIrw23Rx4VO563/vxwThE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778849949; c=relaxed/simple;
	bh=p2Zt3cKWdC1/pxWoY84lOFaPN4h7dJLGK4y3mI87lk0=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=FucHCnvJ1vJjFN1k4qQZTsB/aN0h4pkVi24olBmRAJ1i6sn7aKMDSJYrsB19uEApywGYRb67+BOcH7gAD1CU1ZmmBfu//sRaDtAH2h+mFFUu1m6tlkAbMMffJtGLGAU45BoFh4kxWvAIv69YOQ0CSkQ+l7Gyyy0kmgE2fluKk4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=IQEBwuyI; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2b4520f6b32so14863979eec.0
        for <stable@vger.kernel.org>; Fri, 15 May 2026 05:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1778849947; x=1779454747; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NwIjtQtazgLSHuIaEMysSR80uQRRPZdYqqCJNHXMag=;
        b=IQEBwuyIHYtYIhykF3fjBTcnwTbPD181ZBelwhtmbRaIoHJ3ao21/k+428YU4Q76bG
         XRuaDu8dCCPu5keGcqXbc76RQSHCu/tnbIHfAypuEwFjaQ8ITaHgm4ERpJ4m9/EfJ5NQ
         wdTpwSbNUknQGxb4TJdPEqZwWDPJ/ixWUwrQFGPn/9yI8WLvOoLWrvoUO4kz1Cr4s5Fg
         ZUMeXg0WbpJxw0Ekb0OXw+qAed3bwyADV82lrAU/o0f/nElNnFoNhXT3yPzJubUm/7FX
         9Dp13qpfRLTUNtZE+V8PlDkasZTUQTThpiej9+VxWMv2h2eAaqBd3CTMcamRjrQnyBW+
         3SSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778849947; x=1779454747;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2NwIjtQtazgLSHuIaEMysSR80uQRRPZdYqqCJNHXMag=;
        b=K5G0RIflOUNa2VkmNxjI2/JRyPTByGJwL7WncR/NP9XdHuRUpxgptlskXaIOzOco4h
         lDHIxJeaeMdkz1psnpmKSFCrvqbmJZILCUeMBknZkAY3M6AlePdIZsd+tN4E9+LHZ4sD
         vez2kHVVDhPs44TOV+oK0UFPWCh/q/Mpfm6Pq+83NhAoloUP+DPWJMTb0gVZj4ep/S//
         97IzeN5OCiqybQM9IexHMN5c20TJlFeRvKd7IAOC0uFu2d3jfDq69/Ovm7ngHNwNEy1t
         GdGEvs7NbesEUbueBzzQcsE6fWiytlY4KBboKWgb5RmOabP/Hxc1hlINoMxOoJbroDE7
         +Umw==
X-Forwarded-Encrypted: i=1; AFNElJ+BlmJ0yMLi6kdtot37JZQSPiWW5d7ZTs+IWt7IavzOwOUlZYFrt+iDk3tao+vcozbQzhTxYT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGxLwLAZ1599V1CU8m4LO6o/FdUvatbJzFK1DKMd5vtR+GeqEq
	eQPZE9cYowkL5hJar2BNvhXhpPcgDkFsuQirSrw8+wyN3r++EA1ORSpLfz2V6CK39yPn5zty4Rb
	zgwTL
X-Gm-Gg: Acq92OFaFERaR08pc8lL/+sDoot3Cbqeb2r4RLPoniM1lsLpxCB+Rqll6Rwn34aNWfI
	8fhTt5wHDOKp+NIBFUpaBkAkhoC5VSI4wiIKUt/RXfVN+AOmP+oDiEvloP47oybNQV5O0VexPdw
	jITPsNSc2krp6qjQSNHMckBV2NmlgoSRwxMMkUBlMN+UgPfVGn4ZohPtum+LaQos5cqh3x+BOby
	1TRo608kJMvmY3rigXOGX2lfAYl+wUcucb152C0BTwXX3LS39thgk4TuCB082Z5y55CMaTHi+9Y
	Y99Cvo7P4C9MKz6trXDuxWq1y7xpaBDQ4cImenLA1FQEHacqSPIH1cHK4TdtvVAcVGmrUv+M7uX
	SBCDusnmZXs6XuRYBipZ08e4DJn87t9zytt61o61iBuunIn1CYzJ6zUfTAgEf124FKOXMmgt19U
	h8syn4lJTMypGyqZH8
X-Received: by 2002:a05:7300:2152:b0:2f2:b544:2fca with SMTP id 5a478bee46e88-303986950a4mr1904226eec.33.1778849947022;
        Fri, 15 May 2026 05:59:07 -0700 (PDT)
Received: from 330cfa3079ca ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302947e917dsm6739435eec.12.2026.05.15.05.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 05:59:06 -0700 (PDT)
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
 /var/tmp/rpm-tmp.MFewDt (%install) in ...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 15 May 2026 12:59:06 -0000
Message-ID: <177884994587.966.8579645271051613787@330cfa3079ca>
X-Rspamd-Queue-Id: E7126550ACA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernelci.org,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernelci.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_FROM(0.00)[bounces-247759-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,kernelci.org:email,kernelci.org:url,kernelci.org:dkim,lists.linux.dev:replyto]
X-Rspamd-Action: no action





Hello,

New build issue found on stable-rc/linux-6.1.y:

---
 error: Bad exit status from /var/tmp/rpm-tmp.MFewDt (%install) in binrpm-pkg (/tmp/kci/linux/scripts/Makefile.package:71) [logspec:kbuild,kbuild.other]
---

- dashboard: https://d.kernelci.org/i/maestro:97239c514eb26f5e18412c1866a2061fa9d6dba9
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  75fd020d62d50b059da5e5c922a9e68296254adf


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
tar --sort=name --owner=tuxmake:1000 --group=tuxmake:1000 --mtime=@1778846459 --clamp-mtime -caf /tmp/kci/artifacts/build/modules.tar.xz -C /tmp/kci/artifacts/build/modinstall lib
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build ARCH=x86_64 SRCARCH=x86 CROSS_COMPILE=x86_64-linux-gnu- binrpm-pkg
Building target platforms: x86_64-linux
Building for target x86_64-linux
warning: line 22: It's not recommended to have unversioned Obsoletes: Obsoletes: kernel-headers
Executing(%mkbuilddir): /bin/sh -e /var/tmp/rpm-tmp.6fkPfL
Executing(%install): /bin/sh -e /var/tmp/rpm-tmp.MFewDt
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
error: Bad exit status from /var/tmp/rpm-tmp.MFewDt (%install)
RPM build warnings:
RPM build errors:

=====================================================


# Builds where the incident occurred:

## x86_64_defconfig+aws-ec2 on (x86_64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a06f6bf0ed99f002e8bdf76


#kernelci issue maestro:97239c514eb26f5e18412c1866a2061fa9d6dba9

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

