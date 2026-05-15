Return-Path: <stable+bounces-247782-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPiVDAcpB2ppsQIAu9opvQ
	(envelope-from <stable+bounces-247782-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:09:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE72D551070
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FC59300B449
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 13:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6C947ECD6;
	Fri, 15 May 2026 13:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="bGMhN37H"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C8A44A701
	for <stable@vger.kernel.org>; Fri, 15 May 2026 13:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778853548; cv=none; b=BsW3fv4eSqr4QjQOXSN3hWuOIo4GpG5z/jW96gm7KuDYcepIQJyw1SCYmHpJa5KjMws+08enI2ghpCSyTbkofHHAT583hFFPXZdxfxFyPJ1wdbPu8XeVGW+Ro+1uHa42wjt6C5yVYa2zg64LWJIMcCic+6ORs2Oi0nQEz0KcPKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778853548; c=relaxed/simple;
	bh=LiVStk9IrBaVC6lHIxPrtEMMsBrtamXgF0QJoUb7bKY=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=nfHVrrSeNpnq8Qe562Npx94DBJVmZkRH7BEtCR261SPRkb4TwGL3D3ToxR2lyJfN0Ai8xnj1WfDRrjQz1gWbPbgrs7OH/akzEnEom1k7jIEdsnGLPAhLCeOFl/1AVleM2Q7dychRvxYNJxvoczq+j8GNCoUhmVpFyMmuZ0/YATs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=bGMhN37H; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12c8f9846c8so13727938c88.0
        for <stable@vger.kernel.org>; Fri, 15 May 2026 06:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1778853546; x=1779458346; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXHXhSImgI91lYfMBYexAtHONRbePuXV1eIJjGQADrI=;
        b=bGMhN37HcalRm2OxKAJa1Ac63XLEOI4lbUuLTptelyZaAsHQub8z+32/CYZo/6OvJo
         NbvU2Njjn67cJlpx/tHbJ6sI8A3Qufon6EXYWQe33AcXNz1aDmS3Oxp7IqXFgbbR0AKu
         Qk42A2us9UsNWA++jnGr9hBckY2vbYTrAV6QhSJhU6Ch+VMSH3W6IFUE3cbyMWGmWqMb
         +aBtEQg1V5fucmfpjbh4JU+KJsykb0XnuOf/9O44Di7Z1ZJj0IUT0LMu+v24JNcXbWtQ
         LrdiSVUvZb3JLs1jIzG82CPvdzISGzfcKhIVgQ28MJKRHPvqInfS+gIX38t3tisrU4tO
         /kFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778853546; x=1779458346;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xXHXhSImgI91lYfMBYexAtHONRbePuXV1eIJjGQADrI=;
        b=eyGh6bG0NrYpUy10Bn3v/P5vyH8J8HmBSnQheMIeVDhb84Lm+EADX1BE1eONZ4So6J
         xt0cV/LjziG5dQ10jrjy2xWcv4n/PGwZt3QFWZQJmp8woKb8APteh7Sa0Z6u3CwChkJm
         D2ehq5KSjkOxpDJyeZqrCaHmX6m23N4UYAzQNemUqsxwwn/6SlO0ZwCHKrIzptF4ajiv
         BLP1FYexJyaLnVCgOdO3EWMzdQWqtHp8OK4CoJnHBKW8BazGWOLcB4Y6vaWEkLBsURiK
         j/mfdbNO56uzjc1hZb2ogAj3RvlGuwqO+og/PSnus+9I7Z4EU0LqDcVzO6/sxxBmf5FN
         12KA==
X-Forwarded-Encrypted: i=1; AFNElJ99k5TUMCk3dm7TyEuCWGifWS3BPCG0YqEa+++w2cIBjBFENruVEBbA9ugiiznyXtPh+YpsNdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX8gf38EIi//MXwQpu10T1ZcCb7JHSSp+b83PhtaTAizUj3Bh6
	2sWDm9YKIh9MPFLb+olT7R6/nPU+/OTvYK9h0mRwfM/8Apb9RCOP5jydd2FJZQKPEERRTvyPiSe
	doYmU
X-Gm-Gg: Acq92OF7jpPlwC9kX22hBuz3SUY4U6sTy/PSo3gSBi2SdRADu7LjNFrkudQPiXS7sAH
	sZZZ4RsWpBgIkO1R561fjCpYEbrfIDTVckLR4M5eRMOMJq5Y5cK4wRoLiunTbj7GFLXBi71aZDd
	9RtlC21Smr0JrXrrGj0fhP/xWrb/REynOhrsd1y0AVgT1LNO+l2YL1OyEO+M6/w/z0fVZmvp8Jg
	JkSauHQkV3R2PWQ0ppokKpxqvVB9fOh79qlM0VGnqgxxg1jbmfx4pMdX9zOVVDACwirTP1qNO0k
	BYlrjZcjEOCqfOMigkLhudgnIy1Kk3gnL7gjEJHd2tXV8fKdE9aNSxoTQaJLP8GuvccXuJyBc8A
	lo7u9f0Q9FTihQLZ0chFDpqynQt6KVIJ/QX8v9J8PHDNLQVJM+C0m2QUrn7XdjUT08Pg8XWs+6K
	l6slHeQOtsjqxs1nbM
X-Received: by 2002:a05:7301:600c:b0:2dd:6937:79d5 with SMTP id 5a478bee46e88-303982b788dmr1878168eec.8.1778853545790;
        Fri, 15 May 2026 06:59:05 -0700 (PDT)
Received: from 330cfa3079ca ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30293e2e6a9sm7000097eec.2.2026.05.15.06.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 06:59:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable/linux-5.10.y: (build) error: Bad exit status from
 /var/tmp/rpm-tmp.6DCee3 (%install) in ...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 15 May 2026 13:59:04 -0000
Message-ID: <177885354449.985.4460906655747959512@330cfa3079ca>
X-Rspamd-Queue-Id: BE72D551070
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
	DKIM_TRACE(0.00)[kernelci.org:+];
	TAGGED_FROM(0.00)[bounces-247782-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kernelci.org:email,kernelci.org:url,kernelci.org:dkim]
X-Rspamd-Action: no action





Hello,

New build issue found on stable/linux-5.10.y:

---
 error: Bad exit status from /var/tmp/rpm-tmp.6DCee3 (%install) in binrpm-pkg (/tmp/kci/linux/scripts/Makefile.package:68) [logspec:kbuild,kbuild.other]
---

- dashboard: https://d.kernelci.org/i/maestro:c56368a1d421442daeca87c776f7e6dc0632cd43
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
- commit HEAD:  6b2498787ec6803cf0d0a983321796babe5392d4
- tags: v5.10.256

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
tar --sort=name --owner=tuxmake:1000 --group=tuxmake:1000 --mtime=@1778852605 --clamp-mtime -caf /tmp/kci/artifacts/build/modules.tar.xz -C /tmp/kci/artifacts/build/modinstall lib
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build INSTALL_DTBS_PATH=/tmp/kci/artifacts/build/dtbsinstall/dtbs ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- dtbs
rm -rf /tmp/kci/artifacts/build/dtbsinstall
mkdir -p /tmp/kci/artifacts/build/dtbsinstall/dtbs
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build INSTALL_DTBS_PATH=/tmp/kci/artifacts/build/dtbsinstall/dtbs ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- dtbs_install
tar --sort=name --owner=tuxmake:1000 --group=tuxmake:1000 --mtime=@1778852605 --clamp-mtime -caf /tmp/kci/artifacts/build/dtbs.tar.xz -C /tmp/kci/artifacts/build/dtbsinstall dtbs
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- binrpm-pkg
Building target platforms: aarch64
Building for target aarch64
warning: line 19: It's not recommended to have unversioned Obsoletes: Obsoletes: kernel-headers
Executing(%mkbuilddir): /bin/sh -e /var/tmp/rpm-tmp.yznZfg
Executing(%install): /bin/sh -e /var/tmp/rpm-tmp.6DCee3
+ umask 022
+ cd ./kernel-5.10.256-build
+ /usr/bin/rm -rf ./kernel-5.10.256-build/BUILDROOT
+ /usr/bin/mkdir -p ./kernel-5.10.256-build
+ /usr/bin/mkdir ./kernel-5.10.256-build/BUILDROOT
+ mkdir -p ./kernel-5.10.256-build/BUILDROOT/boot
+ make -f /tmp/kci/linux/Makefile -s image_name
/tmp/kci/linux/Makefile:656: include/config/auto.conf: No such file or directory
+ cp ./kernel-5.10.256-build/BUILDROOT/boot/vmlinuz-5.10.256
cp: missing destination file operand after './kernel-5.10.256-build/BUILDROOT/boot/vmlinuz-5.10.256'
Try 'cp --help' for more information.
error: Bad exit status from /var/tmp/rpm-tmp.6DCee3 (%install)
RPM build warnings:
RPM build errors:

=====================================================


# Builds where the incident occurred:

## defconfig+aws-ec2 on (arm64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a0721030ed99f002e8dee10


#kernelci issue maestro:c56368a1d421442daeca87c776f7e6dc0632cd43

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

