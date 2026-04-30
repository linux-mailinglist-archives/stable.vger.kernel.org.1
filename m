Return-Path: <stable+bounces-242095-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBEpMdhE82kMzAEAu9opvQ
	(envelope-from <stable+bounces-242095-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 14:02:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6D64A2850
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 14:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5377D304B800
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 11:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F8D3DA7EC;
	Thu, 30 Apr 2026 11:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="Lhv/ytpf"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F304014A4
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 11:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777550347; cv=none; b=Nlim46WwKdcFsLqwlsB0Ccs5C8ITMOMowRSwI7YG/aQuF81jv9HbpKxR2Y577IGZ1V65RnIjW+afK47P8obGWpO+uOKHy+JEnljCBqiqq8VADZ5tzJWbbNuD5jNCDCFk6SqzozZXCdwVk/ZbskZUrXk1ZEa63cpsAnZXm+JvAS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777550347; c=relaxed/simple;
	bh=ZXHgd2Zi1AYRfaDb0cRztXGaRGx+7/R4o6K1Bq108gA=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=DKcCE1wsusbmzM5VMiBegE1fJk3/kvuwzQiDSBwLDR2swtfBRzt7vpcOlFWxDeImkXAtpx/ul4B6/13FGa7oJ9IcfCMnYuejVZYB2zk4Tbd8+AkeKQupRC5tCvcFzve7zwc+vpv9ZwCgQy87etK9CqZ/5L7eUrtcxGovFPRyY/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=Lhv/ytpf; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-12c637089ccso1368767c88.1
        for <stable@vger.kernel.org>; Thu, 30 Apr 2026 04:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1777550345; x=1778155145; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jp7+YHgJgw9mu84DQqbIX8boIhz28WMRXg4ifJXgoQU=;
        b=Lhv/ytpfCMDdQcBjNVuePcknrAdhJ2w1kFfeU5amI6FStlGWa0JbvbytNpYQMYvJ31
         trIFo2owYIFrwzNyWiUtD7qndvLvBShtlr6ypZG/KBsejF3Y063k6oGyjzQPd/5yEmx3
         K4ggcmfSGoay5r7rD+KJSQ/60sdUs2TthP9wNdlGPXf7hyxFVks4JDYjmbzjx1nLPgm+
         Jqcjoy0GqSB+3KgKHD2jgAi/dexkb0zoiH0g2FVeuojAabS7eKwh3qKkRJCaC6qthk3Z
         i6opoaILioyh0EVSAq3b6iTemMDi2EbZGAzhx2kCsSb9vl39DpYmhOhGKcCNrZcNFbFF
         Wa/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777550345; x=1778155145;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jp7+YHgJgw9mu84DQqbIX8boIhz28WMRXg4ifJXgoQU=;
        b=dy572udzD8/Jg4vssXKGfyMLMYg+IEcAGQZpgmQE9uCqm0NVmgy2c2TaWhwe9gfJwc
         d6yJ9ZHvAkKZeXcLEd1ikQvTuhuab06Ne43MXSyydJPZHg6Fr5pULdB4liUAqmjgq+Lb
         xvAILivr6EK8BObbXqmsyE4F9/J37ufnoPYZ0tqBo5ZctiBgcjv+vlvbr6l2JmKELCP2
         bujnq4euwgVo7fk8JltwCHetzUz9UiNnH6cIaBVTyk5udJ+MqYaY0DGae+TNhJDhPyHC
         FQ5oTb774/jfjRoO9QuBH/6iN6dvzTWpeXr073hUpp8YgE/Imm+d+sOKJEHSQ5LEpX3h
         aVnw==
X-Forwarded-Encrypted: i=1; AFNElJ+/bdtU6Yn9nc3em9sfe6u0TMbXfex1U4pI/r2Qppy6sLoPuKO0ij3upSyqlpgcIAQtj3FNuCk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6VWWY19jQj5Ja5R+3ZRWVHBlq4u7Kg6/L+uA08Y3LVlxl530V
	iKYPbD1gZLa76fN9EOyyg5InyZDIDvjrT0vN1okPJ9VQlcRp8OixJyz7V7oxZXFd4+U=
X-Gm-Gg: AeBDietw2/dgnU6XI6gWhCNGswTD7bTYH5y53tQPRdNhuTnTfArHgQ3scL7UfWE3Knx
	pqDyDo/SSd5J9nlqOclsVNDvbABtk5LFD5xOG6wAptNjzFDPoMDfDgFNbRfB/V9hdP1Fh56AScv
	h5YG2fE0ZIW+3dUNRCkQBHogbu1cfTKjEXdwaqpXItXdVb4MSkVxRwSsSFnzvdcLcdpX1yX3fnW
	G++MJo6SdxUIxyP/x1f4b/5QmEBBwthnqyUoUzw71gsY6OH0c4QDdq2w1+BeuuBFItEAIUzbmBZ
	0YoEDivHRgvgWmpPaqTT83W6f3+L6BZy2O4WbZX/UX2ZUStiNpjSAfImaUiBHj5PqmitbZYlQJn
	ZclXiqH9d25jsCqprx/kfcc1AyjE0zXWujrKrq/lFZpRDAI1V3rjedZs9TGn9fxJM1/PHNqY9VL
	7eCbEULZ494mTzdf2TF3m6NTGQTPP+BsAnstiThw==
X-Received: by 2002:a05:7022:e19:b0:12a:6ab7:3f8a with SMTP id a92af1059eb24-12deac3a1b9mr1764205c88.3.1777550345162;
        Thu, 30 Apr 2026 04:59:05 -0700 (PDT)
Received: from 997d03828cfd ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12de320ecf9sm9325729c88.2.2026.04.30.04.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 04:59:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable/linux-5.15.y: (build) error: Unable to open
 sqlite
 database /var/lib/rpm/rpmdb.sqlite: u...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Thu, 30 Apr 2026 11:59:03 -0000
Message-ID: <177755034363.490.4984264685318166547@997d03828cfd>
X-Rspamd-Queue-Id: 9F6D64A2850
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernelci.org,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernelci.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernelci.org:+];
	TAGGED_FROM(0.00)[bounces-242095-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,lists.linux.dev:replyto,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]





Hello,

New build issue found on stable/linux-5.15.y:

---
 error: Unable to open sqlite database /var/lib/rpm/rpmdb.sqlite: unable to open database file error: cannot open Packages index using sqlite - Operation not permitted (1) error: cannot open Packages database in /var/lib/rpm error: Bad exit status from /var/tmp/rpm-tmp.mr9VfV (%install) in binrpm-pkg (/tmp/kci/linux/scripts/Makefile.package:68) [logspec:kbuild,kbuild.other]
---

- dashboard: https://d.kernelci.org/i/maestro:c9128b5978bad7d23279e34b6703ed098838ad23
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
- commit HEAD:  ef251c45f1cd4a1a3e8f6eb2e3aee3903c7fa71b
- tags: v5.15.204

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
tar --sort=name --owner=tuxmake:1000 --group=tuxmake:1000 --mtime=@1777547788 --clamp-mtime -caf /tmp/kci/artifacts/build/modules.tar.xz -C /tmp/kci/artifacts/build/modinstall lib
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build ARCH=x86_64 SRCARCH=x86 CROSS_COMPILE=x86_64-linux-gnu- binrpm-pkg
Building target platforms: x86_64
Building for target x86_64
warning: line 19: It's not recommended to have unversioned Obsoletes: Obsoletes: kernel-headers
error: Unable to open sqlite database /var/lib/rpm/rpmdb.sqlite: unable to open database file
error: cannot open Packages index using sqlite - Operation not permitted (1)
error: cannot open Packages database in /var/lib/rpm
Executing(%mkbuilddir): /bin/sh -e /var/tmp/rpm-tmp.GW85Pf
Executing(%install): /bin/sh -e /var/tmp/rpm-tmp.mr9VfV
+ umask 022
+ cd ./kernel-5.15.204-build
+ /usr/bin/rm -rf ./kernel-5.15.204-build/BUILDROOT
+ /usr/bin/mkdir -p ./kernel-5.15.204-build
+ /usr/bin/mkdir ./kernel-5.15.204-build/BUILDROOT
+ mkdir -p ./kernel-5.15.204-build/BUILDROOT/boot
+ make -f /tmp/kci/linux/Makefile -s image_name
/tmp/kci/linux/Makefile:669: include/config/auto.conf: No such file or directory
+ cp ./kernel-5.15.204-build/BUILDROOT/boot/vmlinuz-5.15.204
cp: missing destination file operand after './kernel-5.15.204-build/BUILDROOT/boot/vmlinuz-5.15.204'
Try 'cp --help' for more information.
error: Bad exit status from /var/tmp/rpm-tmp.mr9VfV (%install)
RPM build warnings:
RPM build errors:

=====================================================


# Builds where the incident occurred:

## x86_64_defconfig+aws-ec2 on (x86_64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:69f32d55800b539063e94af6


#kernelci issue maestro:c9128b5978bad7d23279e34b6703ed098838ad23

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

