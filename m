Return-Path: <stable+bounces-248880-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFUGF0RUB2oqywIAu9opvQ
	(envelope-from <stable+bounces-248880-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:13:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05986554A1A
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D953D3019E55
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A44F4CA287;
	Fri, 15 May 2026 16:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="Sn/T6GrU"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F474D2EC5
	for <stable@vger.kernel.org>; Fri, 15 May 2026 16:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778864348; cv=none; b=ZuVi6TLOe/8I4ad4HheyuvD/06mGP7Msqr+gpTnHxbfJGqaJklSQW/inbplB6z7c5endss2ZQ/8WqaUEYdkUNNzWYPkztvw7LJhpTi82nDK/AcHuYsKyfpDdmJKEa/JPDqUzlQjeQ8lEBuUgrz2DYRs4HXaItu0iXKax7/z8EVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778864348; c=relaxed/simple;
	bh=f9XMbyLnn6tQl/WUei+2MNms5SC2Fu4GSnulcNurWJc=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=S5Lnf7buiXyy/pWrvPuaEUeNU4hizsbDG9VbdEkWymf+yMagYP3CWRsPzt+QecdwIv0QON+5Zy7mmdB8THHzOJSXA8jl/GcvvvJrXmLJecfys40qV4mwqY9FXc5/anuQWYFDEpRyr2NRH4S6uixQE/KOO1S1bkN7WvJfOXlqmz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=Sn/T6GrU; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12c1a170a50so13238716c88.0
        for <stable@vger.kernel.org>; Fri, 15 May 2026 09:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1778864345; x=1779469145; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ch+woSnVSAlSOp/YfzEFDMkMUTj1fPGZNcF9e6lQ/Wo=;
        b=Sn/T6GrUW5v6kevb2FPXHn0qOP3RrGCVw74Kk7jFNsj5Ll/UE1v3xsvBpltpVj0vSq
         E0tPcWsP1jgv0THhkj3jJ4uNUF3hGBUm9ZUIWVLLPc+CmqkPC9Q06n+u3K/Yj7/0dsqc
         xka57BPIpU9D1scRX3PZP1HLtESZ5A/Eoa6IASk4w9FDHmnszFAX8Dhl01gnGy6+JQfP
         ImLXmkd3LeEjgF2ElzMjozJ/AyQRS2K//babtXqzzJFM7lYuwqjY0vc9YBuKPXV2CKp+
         pu+wBfPvYtGM10e5hAzayZX8cAtX8YtDs9phNLQCGPwF2Hy5o8U9ZniE90Z7xixarq70
         5lbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778864345; x=1779469145;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ch+woSnVSAlSOp/YfzEFDMkMUTj1fPGZNcF9e6lQ/Wo=;
        b=F8gMX1gc+MRiiulndH8Fm5xsnBoa6NdEcDpTQFVxXPFJbtApwdVYXqS/QXrEriZqRZ
         DaCWbyv/GpJ7YC7sF6ScReZNsHo2SUIdH6POlyATPDjaoIbUREt0T8I9z/KC+8sVzJIM
         3fBtX2XfXknqpMSh7d9D4SWhZg+IAxmnZEAlhIgiqS3mmwbFtYmKkvhwy1EdUYG3YbVz
         wWh8FqHHqQm3K05jNZEnPEjqL+qRpsOJtRIUzCs3xaoRwY3bRnM2sMlA3AX91f9T7TK0
         UWCShLW6ss3XvrtfmBO9ix/+ZXsNrVgAio4ov1cBXGPQZ4gxG/2SgstcliZpxQ5QwOKu
         K9Vg==
X-Forwarded-Encrypted: i=1; AFNElJ+oX9411gecjZ+A8geE7GUK1VGvXjQPt9iBJ3Rzo+f0we5klS1iYzbqx7vuD6T4yxufBZDbQ9U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk9fziZCSvmTaL89mfL0ac9mYra9zvihdOH2avWw7tJwkZrWQb
	freBSzGyLVGe+wtoL+OPWJ4yNFrvrbk4JZ2fBD9aLyq6yBQQNSXUzx5I0iOwsLJYQiw=
X-Gm-Gg: Acq92OHlKq5xt1MYZFHulMSXnno+pQAX1HHKE4g9E2a41CadekFfbI4gOhE1mzmiVZ9
	grTq9XLmwcsixhWJxuAuwSD0jz77DPzGVMAxI/VKP3c56r+vJ3Rvk1BIXUtDIqmycadP3UBaPyy
	zZHiKZ0zCY3rdrKV67M5UmoWqrJi2xCr4twfro8u/dIW2BQZP+bP4cI+Wf2p8V1iOkN6wzzjgCD
	xDfLEA2h7uuOJlOWuAmL9KUv9ESr7xDjZCyaogw3k/OkxszbklrJ1hqIphKiB4Wz4BiNrWE19bx
	0LpNwrsC+BeP5Xz3yVSR6JgFMJLtUp0Bh+TW+ofAx2mMBhuGYRX88RY6ghwjgMdkutjudE2/8an
	MbPMH/yql8gt8neKOzxqHuBvI/iD27DSY/P8ICaZKzJh3AW6cziXkSEdZM05OcX7lUkvyiVghpQ
	6qrf7t9iMw0t3RM4lT7nRhDAo/GFE=
X-Received: by 2002:a05:7022:4596:b0:12d:ca32:5a7 with SMTP id a92af1059eb24-13504417740mr2380751c88.10.1778864345233;
        Fri, 15 May 2026 09:59:05 -0700 (PDT)
Received: from 330cfa3079ca ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbed2232sm11209594c88.7.2026.05.15.09.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 09:59:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable/linux-5.15.y: (build) error: Bad exit status from
 /var/tmp/rpm-tmp.Q5n4WM (%install) in ...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 15 May 2026 16:59:04 -0000
Message-ID: <177886434396.1043.198909766699845466@330cfa3079ca>
X-Rspamd-Queue-Id: 05986554A1A
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
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_FROM(0.00)[bounces-248880-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Action: no action





Hello,

New build issue found on stable/linux-5.15.y:

---
 error: Bad exit status from /var/tmp/rpm-tmp.Q5n4WM (%install) in binrpm-pkg (/tmp/kci/linux/scripts/Makefile.package:68) [logspec:kbuild,kbuild.other]
---

- dashboard: https://d.kernelci.org/i/maestro:a63c26ed279a6fa57d9d5630162f28051458d693
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
- commit HEAD:  93741761e5e3fa630ddc1fc19a460ac42baece80
- tags: v5.15.207

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
arch/x86/kernel/smp.o: warning: objtool: fred_sysvec_reboot()+0x3b: unreachable instruction
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build ARCH=x86_64 SRCARCH=x86 CROSS_COMPILE=x86_64-linux-gnu- bzImage
rm -rf /tmp/kci/artifacts/build/modinstall
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build INSTALL_MOD_STRIP=1 INSTALL_MOD_PATH=/tmp/kci/artifacts/build/modinstall ARCH=x86_64 SRCARCH=x86 CROSS_COMPILE=x86_64-linux-gnu- modules_install
tar --sort=name --owner=tuxmake:1000 --group=tuxmake:1000 --mtime=@1778862318 --clamp-mtime -caf /tmp/kci/artifacts/build/modules.tar.xz -C /tmp/kci/artifacts/build/modinstall lib
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build ARCH=x86_64 SRCARCH=x86 CROSS_COMPILE=x86_64-linux-gnu- binrpm-pkg
Building target platforms: x86_64
Building for target x86_64
warning: line 19: It's not recommended to have unversioned Obsoletes: Obsoletes: kernel-headers
Executing(%mkbuilddir): /bin/sh -e /var/tmp/rpm-tmp.StXVxJ
Executing(%install): /bin/sh -e /var/tmp/rpm-tmp.Q5n4WM
+ umask 022
+ cd ./kernel-5.15.207-build
+ /usr/bin/rm -rf ./kernel-5.15.207-build/BUILDROOT
+ /usr/bin/mkdir -p ./kernel-5.15.207-build
+ /usr/bin/mkdir ./kernel-5.15.207-build/BUILDROOT
+ mkdir -p ./kernel-5.15.207-build/BUILDROOT/boot
+ make -f /tmp/kci/linux/Makefile -s image_name
/tmp/kci/linux/Makefile:669: include/config/auto.conf: No such file or directory
+ cp ./kernel-5.15.207-build/BUILDROOT/boot/vmlinuz-5.15.207
cp: missing destination file operand after './kernel-5.15.207-build/BUILDROOT/boot/vmlinuz-5.15.207'
Try 'cp --help' for more information.
error: Bad exit status from /var/tmp/rpm-tmp.Q5n4WM (%install)
RPM build warnings:
RPM build errors:

=====================================================


# Builds where the incident occurred:

## x86_64_defconfig+aws-ec2 on (x86_64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a0722220ed99f002e8df250


#kernelci issue maestro:a63c26ed279a6fa57d9d5630162f28051458d693

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

