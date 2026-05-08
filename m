Return-Path: <stable+bounces-244754-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBs8OyLe/Wn0jwAAu9opvQ
	(envelope-from <stable+bounces-244754-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 14:59:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0F84F6A7C
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 14:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3DB6F301B6F1
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 12:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC713E0C75;
	Fri,  8 May 2026 12:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="Y2ywSY9+"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2B93E122B
	for <stable@vger.kernel.org>; Fri,  8 May 2026 12:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778245152; cv=none; b=ZOS7w434bn2YATLbXaka8bdMbFqhvpRvHGd8jEB2SXQ28sVBjGmRjM0nSeWkKfgX/LgYc9KbkEY6o7HIk7V2b625r9aeXSh4EvImwuRK3ME3PEaQs7jKrylSxhegJjUXK6oHbhzkSlDfGyPyMc3yEwXdjizmWlEqKPBhgXpylB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778245152; c=relaxed/simple;
	bh=+lgHcf3eqA0ZKh5vewNiMrnxgtmcDCc2hOS6neSeF7g=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=A6dbjCHIFbyWzdTCAy25FPz56fMsQnQoGbZ3+f8gsc0qpSlY8tuDb9Ibi9nB/3kFUD0gU5okCptfWUR+a070+ZlcXGOgisK4lWY/IBdNJ7BWiEa+p6z9FGlbjvuouLo+1l9kmMVzK14uy/c+xg0R2FhUZBOWx2t7nVOdZCgYDP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=Y2ywSY9+; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2f0ad52830cso2984825eec.1
        for <stable@vger.kernel.org>; Fri, 08 May 2026 05:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1778245150; x=1778849950; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xa0H8Wz+/+Di/c211OKboRFjh3YMCVG0p2AWYwhRTR4=;
        b=Y2ywSY9+sQvuwTBX/rTPD6wxp3m1U2fBpXvFC9LcSTadgjQsNToZ7pZLAssAkNBYhL
         JOIrFh4Sv7ExicRS09h95ooUldGWuOB1NOBJiHxFQS+tWpYef7Mz7P9swnycMBrKKWvo
         7BNDj+LM2nB0IatUTL+lk22lsQJ8deBB9IdiulZsPueiH/y+Fz12rULUayKgnLH0dclY
         TUJLL+sqyzBKhPQd7GoJJPRTy3iuTRA6eFlG1AqN+dEdNqylGIBOx177vJjTWPJvusoz
         F59kWhR+7+vK8gxJvku9LvX469mCixJj5m5+24hENX5/E0yWDbY/P+XzAgLE52cEKugn
         tayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778245150; x=1778849950;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xa0H8Wz+/+Di/c211OKboRFjh3YMCVG0p2AWYwhRTR4=;
        b=cX6kYapl3DoWuZa5IUEbW7QzZvpgqr7jYs66slhGk8KHgOrnkMa0ns9xfIMl0+a7bY
         WjRTWiot7PZagUPjFw1nv/8EPDPMUodH3LELL0bCq84LIGei3J6o/ynZDHtd46/RCbxI
         hKTSnRf9Wwc/q30NHKWqZ8pPtNYgF5yKB/fxCAYjJSYyIyTVgYl4dAKjYC1UON+Z0Yw4
         G2HCKslErshotuF1MSTMQW9ZyMn8xd72JxkwKaWJMOgkH1mPnSuP9LcK+gBO+jgaE5v3
         fmjtBxEpYA4c1mk4WoFBUhkQ1zwpLF7GnXh2fVVe5kqLFnTXH+6SiwbOwibSE+954Spq
         wq8Q==
X-Forwarded-Encrypted: i=1; AFNElJ/VJtzCOrOlWhY7GZ0dfv4etcGrEUAbfL1ktZrBkHfk8DinT84m8twUHUwD+uetcQTG4w+0fvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOyktq36Zz6VXBBdJVH6tnOlutHrQLhbmNuDfhVLR4d1y3vigq
	/r3uUODdNjGhqe7wjEbL9jA519Y/pzsaQvwnWZEtK/ttAGpYavnMQFx4AKtLIV/b3PA=
X-Gm-Gg: Acq92OGtGMi/W2jmy5IkLI527sMBFSvsqmcWR/0rD01rbaaOC5jJG62zNvj+1HAdtHM
	/+IVqUomJWc6LI0v18K87MdBW623cC5OA0gXKRdEW7LPaTD7ijAwlrT1AcuiwlGojZJcv4gYYz7
	ssmyNpPk27PLVb1dnVseLx5ORcKqTEAXgvB1Nsr145MVtRZ4l8+Bt4m1x7x6mnwSOLPa79KFgjn
	Kzg6iZaK+V3DCIa1bx80Seyu5KlubpB1H50a5L1TRsQ9U1MPDJXcxX9iDas7pBSxA3UcAuCqlwE
	2hedA1dQEWw9nQt9bkUI2aUzWgXOkIcLiKYNMWqKBoJQhRk48/h3WwBo/BYhjTkTv1fIoLjVfac
	a4mi/lRvOulE0THRj515rJJ5ffb9G2mCAGgtPu8ZjMoTvhVLzBx9Aa1siJH1QaIwJkzTfhdhA5x
	2ZrjAvCUe2QGr85+rRczaEQ4F9XJA=
X-Received: by 2002:a05:7300:641c:b0:2ed:e12:376d with SMTP id 5a478bee46e88-2f54b98f9fbmr6751606eec.35.1778245149842;
        Fri, 08 May 2026 05:59:09 -0700 (PDT)
Received: from 997d03828cfd ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f888e3e285sm2483021eec.27.2026.05.08.05.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 05:59:09 -0700 (PDT)
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
 /var/tmp/rpm-tmp.6dSpfB (%install) in ...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 08 May 2026 12:59:09 -0000
Message-ID: <177824514865.4192.238579836512891112@997d03828cfd>
X-Rspamd-Queue-Id: AA0F84F6A7C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernelci.org,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernelci.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernelci.org:+];
	TAGGED_FROM(0.00)[bounces-244754-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,kernelci.org:email,kernelci.org:url,kernelci.org:dkim]
X-Rspamd-Action: no action





Hello,

New build issue found on stable-rc/linux-5.10.y:

---
 error: Bad exit status from /var/tmp/rpm-tmp.6dSpfB (%install) in binrpm-pkg (/tmp/kci/linux/scripts/Makefile.package:68) [logspec:kbuild,kbuild.other]
---

- dashboard: https://d.kernelci.org/i/maestro:9579efc862db0a1632c6f1a728a2a3d9998b46c7
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  8d9ad8de1c07b07bc75178cda26a7c47f2cc0812
- tags: v5.10.255

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
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- Image.gz
rm -rf /tmp/kci/artifacts/build/modinstall
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build INSTALL_MOD_STRIP=1 INSTALL_MOD_PATH=/tmp/kci/artifacts/build/modinstall ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- modules_install
tar --sort=name --owner=tuxmake:1000 --group=tuxmake:1000 --mtime=@1778241084 --clamp-mtime -caf /tmp/kci/artifacts/build/modules.tar.xz -C /tmp/kci/artifacts/build/modinstall lib
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build INSTALL_DTBS_PATH=/tmp/kci/artifacts/build/dtbsinstall/dtbs ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- dtbs
rm -rf /tmp/kci/artifacts/build/dtbsinstall
mkdir -p /tmp/kci/artifacts/build/dtbsinstall/dtbs
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build INSTALL_DTBS_PATH=/tmp/kci/artifacts/build/dtbsinstall/dtbs ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- dtbs_install
tar --sort=name --owner=tuxmake:1000 --group=tuxmake:1000 --mtime=@1778241084 --clamp-mtime -caf /tmp/kci/artifacts/build/dtbs.tar.xz -C /tmp/kci/artifacts/build/dtbsinstall dtbs
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- binrpm-pkg
Building target platforms: aarch64
Building for target aarch64
warning: line 19: It's not recommended to have unversioned Obsoletes: Obsoletes: kernel-headers
Executing(%mkbuilddir): /bin/sh -e /var/tmp/rpm-tmp.uthNeJ
Executing(%install): /bin/sh -e /var/tmp/rpm-tmp.6dSpfB
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
error: Bad exit status from /var/tmp/rpm-tmp.6dSpfB (%install)
RPM build warnings:
RPM build errors:

=====================================================


# Builds where the incident occurred:

## defconfig+aws-ec2 on (arm64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:69fdcca10e4ee292cbeeffd5


#kernelci issue maestro:9579efc862db0a1632c6f1a728a2a3d9998b46c7

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

