Return-Path: <stable+bounces-242085-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHFXJ1k282lgygEAu9opvQ
	(envelope-from <stable+bounces-242085-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 13:00:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 52EC24A12C5
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 13:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D02223004CB3
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 10:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283073BF667;
	Thu, 30 Apr 2026 10:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="Ox/WW4YG"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCBB3B4E98
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 10:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777546748; cv=none; b=EXWqUseImVr1bVcIx69kP+m1gXotH8SC7BuOfakiNtfR2HjhK+inxcfcAWcdDa/Hh0+crBTrQ/mye3GwzjIUPsXHI+8xn8oeIrnTzgADdc1Ox0ourh5yoKx4xgKtXiYlo62MEJCVLJCVJk5CDU2E2Wn+Lr9YaNZpeKOdM/DGOoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777546748; c=relaxed/simple;
	bh=NDUy042lUbUdnwsKYMNWbkB+migzOMsrDgmjja37fsE=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=lme46l99kZJOShOPYV1DLcVEukCN2LTgEAaa6wetznSxQWuUOaJAPOaAOua1v5WyoBZEWOx5f90bRPlAOi00F7c8omw10HCincRva8O+VqPqmg5x1dOuLWrlUyNHqxUS+9ALu7VqctuF3KyV5HuQcl46wZPq+WkWhLLbRKYJ904=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=Ox/WW4YG; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2ba895adfeaso965061eec.0
        for <stable@vger.kernel.org>; Thu, 30 Apr 2026 03:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1777546746; x=1778151546; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bp3H6HuIKriOpmTghmF+x+Ha9AsTEaET5jnkYEYm+w4=;
        b=Ox/WW4YGwmoddgJjMPqsHRZlqICCANLWaONStfuiCY7N/LtF8XdQy70j2z4WuK7AUX
         YvubW5uhmEpfFreiYk1nZjkKnWI5CNXAKZ7HESXmZ6ealshHVEiAoTd4ycma4yRjz5EU
         OOYUKXQnPxqsa553Vv3bm/Wq+kVpzYurkAb0mfuTw59Mlj47mE92KX7ZITjP0zierY0J
         em14wkdhcCj1Vo2aXjvO8MxNC9Z0AhIes6ISFGlK+hiNoG43wRz13w6WHOJzhOEykgLw
         2C4+ZqGoSg0BHcNtZ8gf6boz6UDH54dT9rBDEVS9AcK57gCklUveNgCwFoGI8S1OquZp
         nhOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777546746; x=1778151546;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bp3H6HuIKriOpmTghmF+x+Ha9AsTEaET5jnkYEYm+w4=;
        b=i/kErZTqEgzvKtgSgWEVQ2uhn4dsuceYFcc6h6B4+h9mh3hLwcdTreJQrqPj9YOiPr
         ASY3NjiOWfGUkUxwYzYzhlM5gtyaeP4Y1V7y1x7CcKrSdgjse0IUoDQpR/p8FZUvhNPD
         byJmlMMs0mDoTaQ0HpvaVaEzbW9KLZe3+CJgk4PTjErkIV879t7NJN99ibQF+S0z9aP+
         IQbe/5JJMgxAZ5+1vHNXWks51D12aoB2ZaSyjt8TwyD8SOC31W1bXrDNPtrGG8t1MIyZ
         niL3o24Zyu+OsB2XhtHbgoSkLO0w8K/DrYdnQ1Tpuq8djdqsQqUI8NjMzBBsj3Nh7VRK
         4fdw==
X-Forwarded-Encrypted: i=1; AFNElJ+MJTopmgGk8IDuBu9+LmsoQakBYe2W5QjHcJOgIdWY3lsXcInS94bw59QUh/UvCR8fpW51niM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDmnwARX+ppzGRs4hswAgWbT1UezByskRi1Y9j6k1GMOqbE0Hc
	jcE+j9ugTJkDMoJe3KycFChfJwb/6Xx7ygmupYqkBrEfmvNzMg6aazs/3goQUKRXyvWwQuSfAnW
	zayPN
X-Gm-Gg: AeBDietZuDZwTOlRqxkFupW0UjU2IWD+ibvtXxg8gKsGNnuoi1gBXr/4Au2Fhv8Gbes
	/scSbyOd28beZZuasDSgef3a2Zv6f+9X4sM5g6IKMBR/0gpCmp50ndX1SeEbLBI9ACMWm+1zBQx
	XBeOGAG7+HT7sIuc5G1HKX4e+6b3W2Azo5ZJp16r9LfOOLAzfwwMClmrxxRxdeCap1ZAQK4E/yK
	7WlbnY9nI3M/gJIjutDu2SJFJW9MIAO/VL6CvEAVqdyjz86/2QmEuG0rmV7vu5aEpJbzfM4vM3t
	bLQZ8jJRYZsHrLznWc966r0QTR6hGSwwD4myrwENed4yLjw2wAdhSORCXZRUpclnxaxxZ0E3854
	XDZS3quBY8SXc05dT9TOYe6s/sSyYDeP4HAwRSP7wm8CbQtLDE32xUndh1q2CIx/frVpznupIQ7
	IJOAHPwxozt23/YDX7rbHlE0OxmAc=
X-Received: by 2002:a05:7022:2583:b0:12d:de3e:be88 with SMTP id a92af1059eb24-12dead2782emr946495c88.36.1777546746246;
        Thu, 30 Apr 2026 03:59:06 -0700 (PDT)
Received: from 997d03828cfd ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12de3269b41sm6649876c88.13.2026.04.30.03.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 03:59:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable/linux-5.10.y: (build) error: Unable to open
 sqlite
 database /var/lib/rpm/rpmdb.sqlite: u...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Thu, 30 Apr 2026 10:59:05 -0000
Message-ID: <177754674523.471.17790086637201486125@997d03828cfd>
X-Rspamd-Queue-Id: 52EC24A12C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernelci.org,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernelci.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_FROM(0.00)[bounces-242085-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,kernelci.org:email,kernelci.org:dkim,kernelci.org:url]





Hello,

New build issue found on stable/linux-5.10.y:

---
 error: Unable to open sqlite database /var/lib/rpm/rpmdb.sqlite: unable to open database file error: cannot open Packages index using sqlite - Operation not permitted (1) error: cannot open Packages database in /var/lib/rpm error: Bad exit status from /var/tmp/rpm-tmp.G2k84s (%install) in binrpm-pkg (/tmp/kci/linux/scripts/Makefile.package:68) [logspec:kbuild,kbuild.other]
---

- dashboard: https://d.kernelci.org/i/maestro:0e9a894ecbf29b01f0fdd539d5061f2ab8821254
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
- commit HEAD:  484bc8b8a0b5816ecc80375b1bc38382abf6bcf5
- tags: v5.10.254

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
make --silent --keep-going --jobs=16 O=/tmp/kci/artifacts/build ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- Image.gz
rm -rf /tmp/kci/artifacts/build/modinstall
make --silent --keep-going --jobs=16 O=/tmp/kci/artifacts/build INSTALL_MOD_STRIP=1 INSTALL_MOD_PATH=/tmp/kci/artifacts/build/modinstall ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- modules_install
tar --sort=name --owner=tuxmake:1000 --group=tuxmake:1000 --mtime=@1777544395 --clamp-mtime -caf /tmp/kci/artifacts/build/modules.tar.xz -C /tmp/kci/artifacts/build/modinstall lib
make --silent --keep-going --jobs=16 O=/tmp/kci/artifacts/build INSTALL_DTBS_PATH=/tmp/kci/artifacts/build/dtbsinstall/dtbs ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- dtbs
rm -rf /tmp/kci/artifacts/build/dtbsinstall
mkdir -p /tmp/kci/artifacts/build/dtbsinstall/dtbs
make --silent --keep-going --jobs=16 O=/tmp/kci/artifacts/build INSTALL_DTBS_PATH=/tmp/kci/artifacts/build/dtbsinstall/dtbs ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- dtbs_install
tar --sort=name --owner=tuxmake:1000 --group=tuxmake:1000 --mtime=@1777544395 --clamp-mtime -caf /tmp/kci/artifacts/build/dtbs.tar.xz -C /tmp/kci/artifacts/build/dtbsinstall dtbs
make --silent --keep-going --jobs=16 O=/tmp/kci/artifacts/build ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- binrpm-pkg
Building target platforms: aarch64
Building for target aarch64
warning: line 19: It's not recommended to have unversioned Obsoletes: Obsoletes: kernel-headers
error: Unable to open sqlite database /var/lib/rpm/rpmdb.sqlite: unable to open database file
error: cannot open Packages index using sqlite - Operation not permitted (1)
error: cannot open Packages database in /var/lib/rpm
Executing(%mkbuilddir): /bin/sh -e /var/tmp/rpm-tmp.BQob2q
Executing(%install): /bin/sh -e /var/tmp/rpm-tmp.G2k84s
+ umask 022
+ cd ./kernel-5.10.254-build
+ /usr/bin/rm -rf ./kernel-5.10.254-build/BUILDROOT
+ /usr/bin/mkdir -p ./kernel-5.10.254-build
+ /usr/bin/mkdir ./kernel-5.10.254-build/BUILDROOT
+ mkdir -p ./kernel-5.10.254-build/BUILDROOT/boot
+ make -f /tmp/kci/linux/Makefile -s image_name
/tmp/kci/linux/Makefile:656: include/config/auto.conf: No such file or directory
+ cp ./kernel-5.10.254-build/BUILDROOT/boot/vmlinuz-5.10.254
cp: missing destination file operand after './kernel-5.10.254-build/BUILDROOT/boot/vmlinuz-5.10.254'
Try 'cp --help' for more information.
error: Bad exit status from /var/tmp/rpm-tmp.G2k84s (%install)
RPM build warnings:
RPM build errors:

=====================================================


# Builds where the incident occurred:

## defconfig+aws-ec2 on (arm64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:69f32c62800b539063e949a7


#kernelci issue maestro:0e9a894ecbf29b01f0fdd539d5061f2ab8821254

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

