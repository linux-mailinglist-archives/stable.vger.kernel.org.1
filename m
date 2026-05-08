Return-Path: <stable+bounces-244753-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNiUJiHe/Wn0jwAAu9opvQ
	(envelope-from <stable+bounces-244753-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 14:59:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F664F6A75
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 14:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8A06A3015857
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 12:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0733B3E122F;
	Fri,  8 May 2026 12:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="SAjNp67Y"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673B637756F
	for <stable@vger.kernel.org>; Fri,  8 May 2026 12:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778245150; cv=none; b=dyWZdAig614j9Yc0tosOTQVydbLoTqXcIo07Z5hnotMFHD+fjbLJLoe+hNzBHDP6YWQfnkkhz4SW5DgAmPn99NVsSa/myL8I0C2B4meNm4YvpeWViCFZDTTUxzgK+R5fUFnhj+7QsLuxlUwViLZ7ZCy+A++7tQ0DF7yKF5sCZGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778245150; c=relaxed/simple;
	bh=QD4ozTjGXLGXsQ4p4Wpy4IzO/tw3RM4YXuxUY5IuIfM=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=esBj/WHLcRLajXL0zWesroZjKTk2c2JZcjfiR5R5pNI8xhuOMg9z/jfwLimFzZPsmyaPISv2o262llN3IpbzQhL0/eQxthwtDyFVhElJ+hwYvDy8f8hcUiVF5UZCGlUnCwhm+vX+z6j7/hWQaBMlnqCZvbj6I6W7wcUWhvwgADU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=SAjNp67Y; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2b4520f6b32so3625397eec.0
        for <stable@vger.kernel.org>; Fri, 08 May 2026 05:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1778245148; x=1778849948; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++KZUKhbU3zuMOwTifA3WfmQXnNruOM/Q1mLz/JQ6Ro=;
        b=SAjNp67YYoQSWoY1kN/NfDkH9WqZvdqpY+vdEAAqSGrn8f5kqoEywVhaiosM7os4Hi
         ZOugKwvBezVNvuDEp7Di1KQu6yySGlUH+zzbBkvagCZTGPwbu+XkbaoWEy69d60R3Y10
         6tXlCjp7fV7IYjoQcu1oJ72sgbkfvApUhwltiMuuJgiPjShgqyXcqCfqmgj7zU0IZoNy
         NKvxDn4OoppVkJP3jpMZ3Aet7FoP0TYJJrXQen1abUVhTKHrRSt8gU89dRlWNzd0jHU1
         8gKwjyY9KDjzbbl0Roe/jAO1hbyFoLs10WAks7H3E+TYxWTH/+M0h2B8umigX7QaWibg
         gO3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778245148; x=1778849948;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=++KZUKhbU3zuMOwTifA3WfmQXnNruOM/Q1mLz/JQ6Ro=;
        b=R69A5BtbD1ObZVS44YbgU1xxvypQLMBN/chATcE+JIgc1G3BE83V4HD1LBSU6yJB6N
         07WNTceFlKxelOGYC8SrUYNAJrl8Zc5A/tJU8/kide7VAwMQWClParHh2z9o58tbGlak
         OC81JGMiJq6fPWZuzuFxhwIJAu3W7orVznO4hz/akahuth6zuo0KaPy1NwMniCpCXnjV
         T/DghhzIkEGM0wa0PyoPGNR9LoSY/OzmnEzu0owO7sxONK2CblxRwR71VCW7xnvoLqw3
         F6p7EdVIGGs9BpWBK1BC5PTCKE30VGSR7TZQgGb7+FjghSuOOGrnZ06Cisi9v9P40gwc
         ybyQ==
X-Forwarded-Encrypted: i=1; AFNElJ+ZDbr0DM2DdF2+O8ux3JDWWUYpQ8d9WFwpsvaWg6LAHyG2WOlc8SX+dsvEDyr/OiXmgYR12iI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRpia36OY7og68tbKztacm913Fjyq/9g4kpnvGCf/cD6Rah5Kf
	R+CPcdXPuuTv8XIK99bBJZAHlbBIbYsPqF3X0y/jHd7N9IlOxF9mE0j2DDi0sFWcFmyZVMMpJ6A
	rZFBR
X-Gm-Gg: AeBDievtI33r6BbUfYVDt88re/SCYwfqb5zjMNc9/bCP6EzznTh3dHV5mSgimIX1Mo7
	XQf/jT3LjMIGSRI/vb7jAlKj505r1VD6p4XUNhH8tIOicKu3yRRicJrLcgEV5YMfgbtc24ZKlFu
	oUtMhKZVbYAOZIF7h57kvDPm3KUAAKZfF/kNfeVAh1AzwwVaFGwKmPC5Rms3YV3HO6c17/VgCjq
	VdxKL/XEbQGKHUwfp5PJIgKC7CQNZfTfisvXxWmo+yOZoqFCGka8at6MwdUVaQy41iqBkyXNpka
	qxYwOG2kRTqRfkExqe6Ayro4KagLv0O2bF3sEmGGLC0aqNHhW6+Zdt50hJk2qkwIWXmT9h+OJno
	IAOLWRNQAn4A4Z1qt1bTpYG36gs9bkS91F4kXGUjGNayaHZzIHFn3OnWczOhN2qOXvxzmHFv5qt
	cgGjoO7JYIdH/HGRga
X-Received: by 2002:a05:7022:f417:b0:130:aa42:167c with SMTP id a92af1059eb24-1319cd26284mr5648541c88.19.1778245148410;
        Fri, 08 May 2026 05:59:08 -0700 (PDT)
Received: from 997d03828cfd ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13277bb2b14sm2709500c88.0.2026.05.08.05.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 05:59:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-5.15.y: (build) error: Bad exit status
 from
 /var/tmp/rpm-tmp.wRo82d (%install) in ...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 08 May 2026 12:59:07 -0000
Message-ID: <177824514720.4192.1513661219770617528@997d03828cfd>
X-Rspamd-Queue-Id: 30F664F6A75
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
	TAGGED_FROM(0.00)[bounces-244753-lists,stable=lfdr.de];
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

New build issue found on stable-rc/linux-5.15.y:

---
 error: Bad exit status from /var/tmp/rpm-tmp.wRo82d (%install) in binrpm-pkg (/tmp/kci/linux/scripts/Makefile.package:68) [logspec:kbuild,kbuild.other]
---

- dashboard: https://d.kernelci.org/i/maestro:3b21a0d05dc3c793325355f5ef0f18413aa8986f
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  7e75ef31ddc90089f78a67b7327c9552fd3786d8
- tags: v5.15.205

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
tar --sort=name --owner=tuxmake:1000 --group=tuxmake:1000 --mtime=@1778241666 --clamp-mtime -caf /tmp/kci/artifacts/build/modules.tar.xz -C /tmp/kci/artifacts/build/modinstall lib
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build ARCH=x86_64 SRCARCH=x86 CROSS_COMPILE=x86_64-linux-gnu- binrpm-pkg
Building target platforms: x86_64
Building for target x86_64
warning: line 19: It's not recommended to have unversioned Obsoletes: Obsoletes: kernel-headers
Executing(%mkbuilddir): /bin/sh -e /var/tmp/rpm-tmp.blCcXi
Executing(%install): /bin/sh -e /var/tmp/rpm-tmp.wRo82d
+ umask 022
+ cd ./kernel-5.15.205-build
+ /usr/bin/rm -rf ./kernel-5.15.205-build/BUILDROOT
+ /usr/bin/mkdir -p ./kernel-5.15.205-build
+ /usr/bin/mkdir ./kernel-5.15.205-build/BUILDROOT
+ mkdir -p ./kernel-5.15.205-build/BUILDROOT/boot
+ make -f /tmp/kci/linux/Makefile -s image_name
/tmp/kci/linux/Makefile:669: include/config/auto.conf: No such file or directory
+ cp ./kernel-5.15.205-build/BUILDROOT/boot/vmlinuz-5.15.205
cp: missing destination file operand after './kernel-5.15.205-build/BUILDROOT/boot/vmlinuz-5.15.205'
Try 'cp --help' for more information.
error: Bad exit status from /var/tmp/rpm-tmp.wRo82d (%install)
RPM build warnings:
RPM build errors:

=====================================================


# Builds where the incident occurred:

## x86_64_defconfig+aws-ec2 on (x86_64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:69fdcd6f0e4ee292cbef1f66


#kernelci issue maestro:3b21a0d05dc3c793325355f5ef0f18413aa8986f

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

