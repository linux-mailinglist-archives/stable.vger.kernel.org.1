Return-Path: <stable+bounces-242084-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCg5OP4182kUygEAu9opvQ
	(envelope-from <stable+bounces-242084-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 12:59:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 454A34A1266
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 12:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9B18300E733
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 10:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14D93BED31;
	Thu, 30 Apr 2026 10:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="QxzeY2m1"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125C326FDBF
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 10:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777546747; cv=none; b=Hq8u9miYeL+Qp7gSD5FAdx5rHvJh6dvz8cJRdgKIV+fWDud3ndBQjbzPXvgatR5/EToZ4xKHiImp/h4JcqOaR6gdODOgBAyPCdzBiZKlA6Osh22767gxyQtPqc0Lqftw0EfYjVTxBxXM9TGiaYp6B4/Mn1O8mso9tzLS9sBkamQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777546747; c=relaxed/simple;
	bh=CvcOIZgK/rP2V7oNp14tuaOx0wnIVFRtZdXYHUbTcdQ=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=KwnsPfAnfZlBuN0H2p+oXn1zikOjSzZMEDSY/R8B69l5LlGSt1gcpho+zJtluDysesPPpocZJun/oyFqviPazflfF/gO5dlaNs64RDBj3lfJ4x4sX8od/F5kzBlpOU6PpGNdZglU2yxKVnCAyGB5QhSZB2b+zgPJ2Z5h/Vw8lQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=QxzeY2m1; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12c6df0b9bbso292136c88.1
        for <stable@vger.kernel.org>; Thu, 30 Apr 2026 03:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1777546745; x=1778151545; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBXXhtaIaSZ5nSnc1flttIyPbaTOf8EMcYbuJs3AekE=;
        b=QxzeY2m1AcmSqnSD++ngBhiAJ1gHGrUb7AQdm4RAxufLomTXtdOSpUHosBhOf1psKH
         nIslG6s8DaY6Wo90TLF6AP4aOVPvnv/CMppc/HyltG5P9nDOVUQERBq6B5NsgZaupSvy
         9TB9mrsoMqhLresMwMI3v4mp+w31VKXu5yRPsRX2Okf1tZ0/8q7oK8RQqpGd6B4/Miuf
         tgm2+uzssI0gYZGSB9uTFFRp/b6Yp9OdnYWvf7Q3jrdDr0LOlq7ZcchfxJ3DsmUE750K
         4m5AUTq19H9u8Jx93FU6iD2SjZr+s+m3O1MtyeCunQclCJ2MlPYTbpBpUv7qDoN1+ZNW
         /RKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777546745; x=1778151545;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yBXXhtaIaSZ5nSnc1flttIyPbaTOf8EMcYbuJs3AekE=;
        b=nlHtMwkMNvZFaP5FUiAHYCvi5E7Ch4dsfZGDIwG16zjB2W1btOK08FPPFDMbagOOQR
         GcznU8uEs7Uh7nIU3FDFvp0aBENal6yNxtgDM42A4O71s/4TKQS56EsYyCdy3H4T/Xix
         ovBXvKNyLtU66bnB6hL41GPXD7TdZDjRsvD9o/3OMHjgZ+G9PdpZAYNnfguzoOYrCx7A
         DS9JJaOUtv6G6MW6rciaqdT3ZlFx7lLVsDeihjZ/aViECDMH5Tm4lHTtji7EXtwYvAE9
         0ua6qlthGX2Ct4vBQR/9ewbJue6TqmGMxDpBEov/qDsvGamfQRGy3BXcGeZakPl4h7KN
         PDlA==
X-Forwarded-Encrypted: i=1; AFNElJ8b9ddYUYQU6LNBLk2zmOxj+D910yHGqLPmT2nDhMclSR3lcwzGNvjDYiRZvkWpMud0+zTYrMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWmJyLP4vEJ+BgUYDFGnE/b70yzmhHjKYv9BxhedXmOxWxHQUj
	ta0uZy5rAfi2ZgSlksi5S8Qf+80HmB/6dUq8jWrMqPsC9mc+q5yoK/fQ7KkB5BGMUNPaPKpZt4w
	/IeLT
X-Gm-Gg: AeBDiev78xEvzqiEFGMAo2cg52cRMUY7GpsU229nKzY/fRp69/yvE6FCH6CIYARIcmX
	29CZ4Vv4a2dFEYZNVUVp4dxBxpzKXQSQTgf/8B4Mqq/fHjGYl+ykFEBMZk6b1h0GRC8plNigmM2
	PzUySwzwVqYuA2sWoJmhKng9MMx8pA1HB7qHmhivr9z74RZbscJIgjgt4NehlmBLjBsRvfv96ym
	icXB7Ak3QmT4O1GUmUc3N+AheSOgAIlONWTVagSY5JELI2oWwuRMqMb1VUf3N2OUPWMmJOpggi9
	86MlWeJvE7WIbJimW591zh0zoxD7cWofnNl38wSV3MkIQ8rsfAFf4CCOqUIhUNCuGvvulTT8S4V
	xr9LVY7NBOinH/7JeTAht7kj5kDLWrtx7cL8U1gq387XJEif/pGwc98CVcQRV7K9Cdno/vPyluX
	ZniVc6KhdGp+SJRU+jSjdxJZ7cpV0=
X-Received: by 2002:a05:7022:f40e:b0:11b:b179:6e17 with SMTP id a92af1059eb24-12dead144f2mr969025c88.34.1777546745019;
        Thu, 30 Apr 2026 03:59:05 -0700 (PDT)
Received: from 997d03828cfd ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12de326a583sm8429990c88.14.2026.04.30.03.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 03:59:04 -0700 (PDT)
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
Date: Thu, 30 Apr 2026 10:59:04 -0000
Message-ID: <177754674391.471.9813205668294909246@997d03828cfd>
X-Rspamd-Queue-Id: 454A34A1266
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernelci.org,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernelci.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_FROM(0.00)[bounces-242084-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email]





Hello,

New build issue found on stable/linux-6.1.y:

---
 error: Unable to open sqlite database /var/lib/rpm/rpmdb.sqlite: unable to open database file error: cannot open Packages index using sqlite - Operation not permitted (1) error: cannot open Packages database in /var/lib/rpm error: Bad exit status from /var/tmp/rpm-tmp.vHAd7E (%install) in binrpm-pkg (/tmp/kci/linux/scripts/Makefile.package:71) [logspec:kbuild,kbuild.other]
---

- dashboard: https://d.kernelci.org/i/maestro:d3e703ad4b5187f58c5805c13325f18eb57beb60
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
- commit HEAD:  4931e0e1673d2592ba7ab7365a25d1248b6a41b8
- tags: v6.1.170

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
tar --sort=name --owner=tuxmake:1000 --group=tuxmake:1000 --mtime=@1777545944 --clamp-mtime -caf /tmp/kci/artifacts/build/modules.tar.xz -C /tmp/kci/artifacts/build/modinstall lib
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build ARCH=x86_64 SRCARCH=x86 CROSS_COMPILE=x86_64-linux-gnu- binrpm-pkg
Building target platforms: x86_64-linux
Building for target x86_64-linux
warning: line 22: It's not recommended to have unversioned Obsoletes: Obsoletes: kernel-headers
error: Unable to open sqlite database /var/lib/rpm/rpmdb.sqlite: unable to open database file
error: cannot open Packages index using sqlite - Operation not permitted (1)
error: cannot open Packages database in /var/lib/rpm
Executing(%mkbuilddir): /bin/sh -e /var/tmp/rpm-tmp.5il9xW
Executing(%install): /bin/sh -e /var/tmp/rpm-tmp.vHAd7E
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
error: Bad exit status from /var/tmp/rpm-tmp.vHAd7E (%install)
RPM build warnings:
RPM build errors:

=====================================================


# Builds where the incident occurred:

## x86_64_defconfig+aws-ec2 on (x86_64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:69f32e0f800b539063e94bd0


#kernelci issue maestro:d3e703ad4b5187f58c5805c13325f18eb57beb60

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

