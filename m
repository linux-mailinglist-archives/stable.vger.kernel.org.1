Return-Path: <stable+bounces-242087-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEAPB2c282lgygEAu9opvQ
	(envelope-from <stable+bounces-242087-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 13:00:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA174A12D5
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 13:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5B5633007A67
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 10:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2D03BE62A;
	Thu, 30 Apr 2026 10:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="Q2picDGs"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE403B4E98
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 10:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777546751; cv=none; b=UxJW1sxJ85+OJakmoNjpYvZSPNDzB6kd4k+mGNkRvdoPbslTdhDCWj9heliATfXNfaRm+lNVngqg8Kw7urJ6sFQUPjkZE5zGPLjL4rnNmvTXXTxk8H0k5NdXWQDS/syY9V9Ha/eBcn8EaqDlieSp0WM9iORByR9D7V99iME2f1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777546751; c=relaxed/simple;
	bh=QJ3MO6qXIjlZ1DGgkcaBHRm1zXoqNs3ipfy6isT5byc=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=EsdNFvTy7YY1heGh5RKRx5/Vb6nfYGoh7123HS18mvtlSJQCDlSHwEMcfYv6cRJrxEmZJzPOlmop1IJ1o8err0rRN0eNObORgsyjBoMRhB9Fywoi+QWiVQ4Nl3a4L3AobcCZWG0ltLrg3FtX3ckKUzcXJUlD68Lo2bc0ysWEeKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=Q2picDGs; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12de530cbf1so1585620c88.0
        for <stable@vger.kernel.org>; Thu, 30 Apr 2026 03:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1777546749; x=1778151549; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D0qyQQ5F3f8NiUt+HEB+8LRwZ+Y8O9pLCcHfvr/EqMM=;
        b=Q2picDGs9hxbTfUvijo8qAUtjYNTX5cArvZcvHZOD03DmV6Xtjj9VybnsyExY/DF08
         vRQCPySGMgN36YVAyjkdfBgmS1Fh9GkIoIhp45ZQG4l26eeii75mvR4Ct9UNMTSX3YUB
         up5y1/0D+soHEi8pYe5oitKNYFUWwPk6FoUpszWzdAWKD72vj2dRf9li3GM0+eh11tc4
         NjPtYnJP9b82CxRd3nIZr3qr6nCMotT+BXGd1C9YWHm2SW7KZ0g6BGAPghBUCjaXsCA6
         ZiVJ3N/7yDBrf37ij0wp6Lf1aFeREZmROs9jR9cgNG1DFuzmf0ein9bQERX9LGS5qUaJ
         lBlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777546749; x=1778151549;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D0qyQQ5F3f8NiUt+HEB+8LRwZ+Y8O9pLCcHfvr/EqMM=;
        b=ZdQbMg+mqod33hxyJki4wbMNZDSy4lL0PR6GBeQut+3zZqtUZRLVsVo0iBx5J35Wgp
         xneqH+yi98fbL3QstO0Oh1zlJrkRTCVvStSNfkGzD+iK2ZYYdeuW5QC0lqTxS7qXEAID
         FxYdQNSzfV6ntbJAa/7uQ1F4N/XrQG2xuA2lT2+ASHAFoBYgvEkMjVlywA9IaIgbQqPd
         7oBFwAa0/a9WBfBGp3vGWEpucBRG1RPRvMV9yd7fEhQxwfUFfKNF0p6q6vubmD0+Evxo
         Ta54pnX8NUYQG2ScHW0O+Wur0YQbOR8EdHmpRtfcwN/KqN8vG1uDumxOqPuTHZuZrxDl
         aCAg==
X-Forwarded-Encrypted: i=1; AFNElJ9w5N1dpgDtFl+r/S5YpAqrBDQoFwmWWkOB2/KY2vUYIRKZIhddsCigGRTL4+1ux5f8or7bEYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCZcB1ngiIVVovzaGIx0XSFyaFkWa/P0UKqoDN/GSMHEZgmxru
	q85U7MKsVR5V66OsB0Sdg5prXWSP6xh9s5JGKLkpCGMIeqCVPAJpQBvSkkYU3agMBf8=
X-Gm-Gg: AeBDiesLCxf5aaRvgB2Weq5A9xtHxjqHioHvZtayoEsw8F7eqitTPwZCC4hLrOXkYEn
	RoiwuqA6kZXJKXGpXRQQtaSVrdJS6s8jVY4SP2qadvuJOyN5UfwPFYgBIo3NARgKP7v+WLw71UW
	1eylKrNF6BjGeHr+HK61hSLFj/RmMVZsgbyYboyjT4D8uaZ49J1FAsAkDsp+rQnXIWrxTcwusCN
	oEQStgjTlBDqEcHCAABZ2ZCb4U892oNgRuE8mk0Eu2Lb8EMo719bTGQkDSi4sVrEkWGlLjOcREe
	VonaQggwy9rQIhqeMwacRfjn1aL9927tVmb6+ioJShsD0/+czxp+oJtyEb9KqFvFzm0W0FNIbuq
	7U1BExp45QNIRFcdmBNpob4nd/oIt8XUtfFwRpd7SuPbr+QDb1vYil3BEbuOKdw3diwvmB6Mebg
	T7TxhXm9Fg509LsfF6BPtDsmrapOc=
X-Received: by 2002:a05:7022:f20e:b0:12d:de3e:86aa with SMTP id a92af1059eb24-12deb092014mr884962c88.40.1777546749125;
        Thu, 30 Apr 2026 03:59:09 -0700 (PDT)
Received: from 997d03828cfd ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12de3216e81sm8983923c88.4.2026.04.30.03.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 03:59:08 -0700 (PDT)
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
Date: Thu, 30 Apr 2026 10:59:08 -0000
Message-ID: <177754674807.471.7678691979289349822@997d03828cfd>
X-Rspamd-Queue-Id: 6BA174A12D5
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
	TAGGED_FROM(0.00)[bounces-242087-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[kernelci.org:query timed out];
	DKIM_TRACE(0.00)[kernelci.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernelci.org,stable@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	HAS_REPLYTO(0.00)[kernelci@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]





Hello,

New build issue found on stable/linux-5.10.y:

---
 error: Unable to open sqlite database /var/lib/rpm/rpmdb.sqlite: unable to open database file error: cannot open Packages index using sqlite - Operation not permitted (1) error: cannot open Packages database in /var/lib/rpm error: Bad exit status from /var/tmp/rpm-tmp.hHKb6T (%install) in binrpm-pkg (/tmp/kci/linux/scripts/Makefile.package:68) [logspec:kbuild,kbuild.other]
---

- dashboard: https://d.kernelci.org/i/maestro:d6cdb559b0a561bf3d016dc94ec66dd5097342c2
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
- commit HEAD:  484bc8b8a0b5816ecc80375b1bc38382abf6bcf5
- tags: v5.10.254

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
tar --sort=name --owner=tuxmake:1000 --group=tuxmake:1000 --mtime=@1777544475 --clamp-mtime -caf /tmp/kci/artifacts/build/modules.tar.xz -C /tmp/kci/artifacts/build/modinstall lib
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build ARCH=x86_64 SRCARCH=x86 CROSS_COMPILE=x86_64-linux-gnu- binrpm-pkg
Building target platforms: x86_64
Building for target x86_64
warning: line 19: It's not recommended to have unversioned Obsoletes: Obsoletes: kernel-headers
error: Unable to open sqlite database /var/lib/rpm/rpmdb.sqlite: unable to open database file
error: cannot open Packages index using sqlite - Operation not permitted (1)
error: cannot open Packages database in /var/lib/rpm
Executing(%mkbuilddir): /bin/sh -e /var/tmp/rpm-tmp.Z61eIw
Executing(%install): /bin/sh -e /var/tmp/rpm-tmp.hHKb6T
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
error: Bad exit status from /var/tmp/rpm-tmp.hHKb6T (%install)
RPM build warnings:
RPM build errors:

=====================================================


# Builds where the incident occurred:

## x86_64_defconfig+aws-ec2 on (x86_64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:69f32ca5800b539063e94a19


#kernelci issue maestro:d6cdb559b0a561bf3d016dc94ec66dd5097342c2

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

