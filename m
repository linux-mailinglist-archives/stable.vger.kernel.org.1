Return-Path: <stable+bounces-244789-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFNHNtoK/mm2mQAAu9opvQ
	(envelope-from <stable+bounces-244789-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 18:10:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC094F93A1
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 18:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98303305D5F0
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 16:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2033D3D16;
	Fri,  8 May 2026 15:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="DDLCv6sO"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A7C401A31
	for <stable@vger.kernel.org>; Fri,  8 May 2026 15:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778255955; cv=none; b=ma5nKSN1lMiI1rTaeG6ZDukNzwk7BOkykBAxMm/3CoxPtlCdgTv03RcKvherRHJWEMyKKfEVrAlXfXcKdUNBQyR9pM7L70bItF0ATDnYMZQX5DvLcZMYZzDUpXF2MS55ZiNo7C62C0plRTs/tfbe/3Ewe5OngNR2OVbMgVOq/bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778255955; c=relaxed/simple;
	bh=JyZkI5r/3R1QfQhON5Fxq40dIzFLiZVVSNnBlj9O98I=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=tFpIJs+mYYFy+P9iDEvtTR02zhQlGBwsSkSK6snxgoTH60f7n6zlMGy1vkaz+ZUORdHu3yPmlBa+iLwyv2noaaBNq5rMRsKyQIBs307L8+aM7q7vAsZ1YbGtEc5bOc/Lj70aWlkASyXqiuQLnarglIlYD5feENY0603GMvV66U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=DDLCv6sO; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2f0d3e07e30so5624457eec.0
        for <stable@vger.kernel.org>; Fri, 08 May 2026 08:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1778255945; x=1778860745; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7hvqzFR1Yrtvjs629j0OiNCMafpfQg+66oMpkE+JHgk=;
        b=DDLCv6sORYvYDXGaAAOGLHN3JYPcAhxGnlDBu+MYFVAk8bj2Y14uE0D1dna7FoY9eO
         K1oGvzOFPeGBWpHXyo0Y6MoEfTwStB+9a6/Vk/BjlW8z1+WdC6T3+uB9anLAEu52rNHV
         PoWerPr8VfFPl1H65FRMG1TIwLGdQuOjaAOS3+LzEUlGt9arlnf96UTv14wblfQFu7Tf
         3XGeLYIHx+edrkz8YryAtjB8gLJJxJX3dd4obOBYskY/9i67bi8TL5za5VN8vb/ggXos
         fmedQ2CeYfaCna8ZX/TcK6NmF+lsi42DKRfxEwkqtKgdagveBFLibxbxloGGLudrMRZW
         vo4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778255945; x=1778860745;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7hvqzFR1Yrtvjs629j0OiNCMafpfQg+66oMpkE+JHgk=;
        b=p4bozTcmbLDgP75X3zEhpmwm//Yd2bo7Cg/FqIufC7HB9zS4xCRXClkoiwR0XHRB0j
         CkUfIGbtVDZZi8ABEDO06UCwvOQ2IytErg0j+zNIhP26sKoC5GVe+Qqphl5QC9EdpXLo
         pDnWDcwjPagpxc7j7Zo6GBvcqQoR6du1wNBRa4EHf8DMMoOYRt23CEoJkzEvmRLPUi+Q
         eXzwU/fElmvBpI5B2o6jGGUn2OEQUxdO6gZUu9FOEGGzre2x81tWfX5Rzea0FAH/CFm5
         A+ivQMYl9c3nh8nl4uCbHqbpbQyLDHudEgs1rJT5PBoQ4CGgIV+Smz4ok2CVcAMGZd5g
         QkZQ==
X-Forwarded-Encrypted: i=1; AFNElJ+D3xf65V2YLuJ26fVhhZoyj3K/rMym03PVwx9BuZ6PcM1eeT/kqVMasWgpD4yRax1Zy/SCiUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQk2JMuFy3oNfZ73Vw8sraQCUtGJPAwKdK1sCfelta6Mdy0+OI
	EXT9VupD/m71SHcZ+H6hCe9Er5+vHMAfw7SkgH32bNWVZ4IdkI79ivuRGpNLJUVrMCw=
X-Gm-Gg: Acq92OHK6eWZMx4bbq+hJiiXs8GPV5YE68tC3pVb3kaqpwXWBjNcjs9Qzx+0qSSUYr2
	t2/Aj9I91uk49uv28psbm7HPyR95KbEd0iaiePjxiZcLQmNTxpdVrUKRvifebdtgab4MuJVssBs
	snDq1a5kfQ1Ap07gZQDVSOZHfVihUcr8WGJFI1myxKWGNawgPUFV3dT51CCL/ArNSTiejX3VhZE
	oPYsCGdvpJ7QMNr/aZpx2PTdB++wEP7MJQAlB7uosJbj0nEvLE9g/TehF01nBUwH0oslSau+IDH
	g90hSxxzNdwKWN74QTR9RoABM5OLvzfvx9OMzOr55ixZGoVrspc+XFejjq87Ul0oyc1NAVYhaDh
	bZMqLslKkoPiaRf4+mT21x+bKztodUdk2wkm7B1B98Ks2mouO/XhIxCMKfb6UO+NsPnit1zpzXm
	TaiSOGPARZPW4RqoiglrwbjXJbefM=
X-Received: by 2002:a05:693c:2c97:b0:2ed:e15:c926 with SMTP id 5a478bee46e88-2f54be949a5mr7035131eec.34.1778255945406;
        Fri, 08 May 2026 08:59:05 -0700 (PDT)
Received: from 997d03828cfd ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8859eafacsm2686037eec.1.2026.05.08.08.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 08:59:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable/linux-5.15.y: (build) error: Bad exit status from
 /var/tmp/rpm-tmp.YdZiv2 (%install) in ...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 08 May 2026 15:59:04 -0000
Message-ID: <177825594432.4250.284198487165033514@997d03828cfd>
X-Rspamd-Queue-Id: 3FC094F93A1
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
	TAGGED_FROM(0.00)[bounces-244789-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action





Hello,

New build issue found on stable/linux-5.15.y:

---
 error: Bad exit status from /var/tmp/rpm-tmp.YdZiv2 (%install) in binrpm-pkg (/tmp/kci/linux/scripts/Makefile.package:68) [logspec:kbuild,kbuild.other]
---

- dashboard: https://d.kernelci.org/i/maestro:25a75877c3c2eda3ffe39c7cd5ae8c6c398ff5e7
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
- commit HEAD:  de8dfb3f0278dbf02ec63612f0ebdf7b92870d58
- tags: v5.15.206

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
tar --sort=name --owner=tuxmake:1000 --group=tuxmake:1000 --mtime=@1778252876 --clamp-mtime -caf /tmp/kci/artifacts/build/modules.tar.xz -C /tmp/kci/artifacts/build/modinstall lib
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build ARCH=x86_64 SRCARCH=x86 CROSS_COMPILE=x86_64-linux-gnu- binrpm-pkg
Building target platforms: x86_64
Building for target x86_64
warning: line 19: It's not recommended to have unversioned Obsoletes: Obsoletes: kernel-headers
Executing(%mkbuilddir): /bin/sh -e /var/tmp/rpm-tmp.FQtt73
Executing(%install): /bin/sh -e /var/tmp/rpm-tmp.YdZiv2
+ umask 022
+ cd ./kernel-5.15.206-build
+ /usr/bin/rm -rf ./kernel-5.15.206-build/BUILDROOT
+ /usr/bin/mkdir -p ./kernel-5.15.206-build
+ /usr/bin/mkdir ./kernel-5.15.206-build/BUILDROOT
+ mkdir -p ./kernel-5.15.206-build/BUILDROOT/boot
+ make -f /tmp/kci/linux/Makefile -s image_name
/tmp/kci/linux/Makefile:669: include/config/auto.conf: No such file or directory
+ cp ./kernel-5.15.206-build/BUILDROOT/boot/vmlinuz-5.15.206
cp: missing destination file operand after './kernel-5.15.206-build/BUILDROOT/boot/vmlinuz-5.15.206'
Try 'cp --help' for more information.
error: Bad exit status from /var/tmp/rpm-tmp.YdZiv2 (%install)
RPM build warnings:
RPM build errors:

=====================================================


# Builds where the incident occurred:

## x86_64_defconfig+aws-ec2 on (x86_64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:69fdf8f70e4ee292cbf04eb0


#kernelci issue maestro:25a75877c3c2eda3ffe39c7cd5ae8c6c398ff5e7

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

