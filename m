Return-Path: <stable+bounces-244755-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iERBGjfe/Wn0jwAAu9opvQ
	(envelope-from <stable+bounces-244755-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 14:59:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AAF74F6AAA
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 14:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD17E3053D0A
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 12:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3E73E123B;
	Fri,  8 May 2026 12:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="WdrLAbBe"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233663E0C6F
	for <stable@vger.kernel.org>; Fri,  8 May 2026 12:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778245154; cv=none; b=ud7aURwJpcARdG6sVUhZ9uSZQtw0tOUjauBZx2T3SvPiNxjCkSA2qXNJVzjPamxGFacUofkvx1Ym2F8QqX4JxXg0lzhRdQzudXW1wvflXylpUGM6rM4D0wby0NCYD2PtGeKlxe7Ii+z8kvIH1wbNPz5O0oMug/dzoLTf6cXblzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778245154; c=relaxed/simple;
	bh=yySbHu9GfzW9b1nK6e/5RSSNJ1XYnX4kF/Xq5JGIZV0=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=Uyk+ky5eak6zyCom7cJRLsySicap4R8ZnE3lb5n2IQUmnr8abEiUEy+USqhKU4D7OXN54j8bRSDLu+izZxYahC1jKqpgudJkddbYJIK8qSwqRiyq/dmX5YLON7uqvDOSZeNUk3N6ZO68m8zkEtfZoW2ytLRt/AfdMG4oPEexaHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=WdrLAbBe; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2ecf9e398f4so5315352eec.1
        for <stable@vger.kernel.org>; Fri, 08 May 2026 05:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1778245151; x=1778849951; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S+mmGSdkZms6X5Yd0bY6NXoXxU73KaNnqB6iqfDTT14=;
        b=WdrLAbBeGkBiTW4PqlAyZMFDBvAVsiYKPkAqyeZIug8EP7xNNet/YPYzoESrLmwI3Y
         Iv9ci9T0E4rOtCVg6ZokKTOZfr+bizDWDJMSSzmDgFhh5zBrsl9DUFz3AAFhrir96y+4
         vR2rxToJ3r59NxZo1dIpRGZNZ8ZPcWT/6bWecngXNZG0doGlhdfvaMyf6LmL20q3fiHP
         oa+fBMsVo9DEfBi+uBtC3ReXP5xJfJEjg3868QqQyJkHiOm0dI33SJtciLlzsfTYPrPf
         GEDp9jEJ9iCcZL/9lZjY2aBKWriO0OxPvDnBC/8X+mYDrJ379W6rMrHpp2yIXoYxBe0w
         qvOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778245151; x=1778849951;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S+mmGSdkZms6X5Yd0bY6NXoXxU73KaNnqB6iqfDTT14=;
        b=GIMo76sB49Hl93LRJgkQ64INy6egR4MAcVHUbuVlqTbwnpEVqqn+z2opoOOceZxsJn
         gztIa6GBmbNDSCXhrayVNCstF2o6G1Mm9e9V9HLbOVm2gm1kU9raPsc4c/KYpKEHWmS7
         k5S8Irfg1LFawClLJKnuNYZX852MVhPhrTLsGigmtb+MHmRNz8hroo0HfIKnJZOTapgt
         fmwfb78fkb7mnrhAqeqTPUtFS6TDrEjawrTCOd9vQ+v2nyHwnvpsAAXwmxTUY3g6DUMw
         FvP2mm1uoeVuRFcnCAiLBe6C0oOiCapLsNHHF/fgbN8cFz4TXyATYX0C82EpKHiA7s0M
         f3jg==
X-Forwarded-Encrypted: i=1; AFNElJ9wEUfjGKbJyp86+TnhDBmx5g9sm90JNuHuQZJaAArBm6CEDV+Rj03/9C3aShM5OBZEJw1h2EA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz+VIJ9qY/zZidZTcntDBqJdYGuglyVl/z6T5DxkAh+WaqGOil
	2gTOlebIXxajCodBN5lxHa/SsB9F1YrmlR9Os7K/bbMoC8n50I9X+qIDH4D3GejPfp9iUl5oUHG
	x1cam
X-Gm-Gg: Acq92OF59BWxANBK3vcqQTSsdZOB/uMokCMaQC1eVadvtNGmjR39288IcYrtKkm76ap
	OvQCsH0kr0Q3JxNcECB+muvoxpRVGs9fG0p7ACCRd7lAblPtIS7c2n6OqupO+9VVk5k+Xk25lTy
	x2HvSacGI9XdpOjHy6KKHKESi/GbHfgZd1qe4FNUaP0AlkTh5GJybUtzDTqH54lJWkJ9zAFDMY0
	4Ixy1B2rb/z4OjgXNVQ4L7ieBj70enrahfig8mZn9KyWTfNA/NnflbSEGl8CR/DO7OWpoI76TXo
	SceygmWVyXbcayGBduXu28HF9MN3moUT4bTE+04I46VKjKs5bSVjmnLnPVZ59TYnp0uVc6BHaF9
	CjdzO27EpqkbV7137XqUe33mK+uJ91/30XTTVGIXwAGgYZW0A/0Z6ahtCe5cAIo+tSBR3NKpq5S
	FmapU/T6fdcyfM41lw
X-Received: by 2002:a05:7300:2146:b0:2d9:ad46:4a92 with SMTP id 5a478bee46e88-2f54b68d65bmr6472369eec.13.1778245151156;
        Fri, 08 May 2026 05:59:11 -0700 (PDT)
Received: from 997d03828cfd ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8893441absm2557737eec.31.2026.05.08.05.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 05:59:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-5.10.y: (build) error: Bad exit status
 from
 /var/tmp/rpm-tmp.WUtNLY (%install) in ...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 08 May 2026 12:59:10 -0000
Message-ID: <177824515005.4192.4279993857505228610@997d03828cfd>
X-Rspamd-Queue-Id: 0AAF74F6AAA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernelci.org,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernelci.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernelci.org:+];
	TAGGED_FROM(0.00)[bounces-244755-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[kernelci@lists.linux.dev];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernelci.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kernelci.org:email,kernelci.org:url,kernelci.org:dkim,linux.dev:email]
X-Rspamd-Action: no action





Hello,

New build issue found on stable-rc/linux-5.10.y:

---
 error: Bad exit status from /var/tmp/rpm-tmp.WUtNLY (%install) in binrpm-pkg (/tmp/kci/linux/scripts/Makefile.package:68) [logspec:kbuild,kbuild.other]
---

- dashboard: https://d.kernelci.org/i/maestro:e23151dd09c95c7f84e7602c7ba935b4f1844ad3
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  8d9ad8de1c07b07bc75178cda26a7c47f2cc0812
- tags: v5.10.255

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
Value of CONFIG_VIRTIO_PCI is redefined by fragment /tmp/kci/artifacts/build/0.config:
Previous value: # CONFIG_VIRTIO_PCI is not set
New value: CONFIG_VIRTIO_PCI=y
Value of CONFIG_DEBUG_INFO is redefined by fragment /tmp/kci/artifacts/build/0.config:
Previous value: # CONFIG_DEBUG_INFO is not set
New value: CONFIG_DEBUG_INFO=n
Merging /tmp/kci/artifacts/build/1.config
#
# merged configuration written to /tmp/kci/artifacts/build/.config (needs make)
#
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build ARCH=x86_64 SRCARCH=x86 CROSS_COMPILE=x86_64-linux-gnu- olddefconfig
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build ARCH=x86_64 SRCARCH=x86 CROSS_COMPILE=x86_64-linux-gnu-
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build ARCH=x86_64 SRCARCH=x86 CROSS_COMPILE=x86_64-linux-gnu- bzImage
rm -rf /tmp/kci/artifacts/build/modinstall
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build INSTALL_MOD_STRIP=1 INSTALL_MOD_PATH=/tmp/kci/artifacts/build/modinstall ARCH=x86_64 SRCARCH=x86 CROSS_COMPILE=x86_64-linux-gnu- modules_install
tar --sort=name --owner=tuxmake:1000 --group=tuxmake:1000 --mtime=@1778241050 --clamp-mtime -caf /tmp/kci/artifacts/build/modules.tar.xz -C /tmp/kci/artifacts/build/modinstall lib
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build ARCH=x86_64 SRCARCH=x86 CROSS_COMPILE=x86_64-linux-gnu- binrpm-pkg
Building target platforms: x86_64
Building for target x86_64
warning: line 19: It's not recommended to have unversioned Obsoletes: Obsoletes: kernel-headers
Executing(%mkbuilddir): /bin/sh -e /var/tmp/rpm-tmp.lXGvDs
Executing(%install): /bin/sh -e /var/tmp/rpm-tmp.WUtNLY
+ umask 022
+ cd ./kernel-5.10.255-build
+ /usr/bin/rm -rf ./kernel-5.10.255-build/BUILDROOT
+ /usr/bin/mkdir -p ./kernel-5.10.255-build
+ /usr/bin/mkdir ./kernel-5.10.255-build/BUILDROOT
+ mkdir -p ./kernel-5.10.255-build/BUILDROOT/boot
+ make -f /tmp/kci/linux/Makefile -s image_name
/tmp/kci/linux/Makefile:656: include/config/auto.conf: No such file or directory
+ cp ./kernel-5.10.255-build/BUILDROOT/boot/vmlinuz-5.10.255
cp: missing destination file operand after './kernel-5.10.255-build/BUILDROOT/boot/vmlinuz-5.10.255'
Try 'cp --help' for more information.
error: Bad exit status from /var/tmp/rpm-tmp.WUtNLY (%install)
RPM build warnings:
RPM build errors:

=====================================================


# Builds where the incident occurred:

## x86_64_defconfig+aws-ec2 on (x86_64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:69fdccda0e4ee292cbef0039


#kernelci issue maestro:e23151dd09c95c7f84e7602c7ba935b4f1844ad3

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

