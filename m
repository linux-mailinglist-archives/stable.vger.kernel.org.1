Return-Path: <stable+bounces-247804-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPtkEyk1B2qQswIAu9opvQ
	(envelope-from <stable+bounces-247804-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 17:00:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2F8551CF8
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 17:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B4DAB300D759
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FA33C1F22;
	Fri, 15 May 2026 14:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="Sm4rfRwQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DC33BBA1A
	for <stable@vger.kernel.org>; Fri, 15 May 2026 14:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778857147; cv=none; b=Nt5wUAr4wzXdr5R6Ir6JIIK6kfpksRNwomHRI5Gu1gLezqUNxrtWUgEDz0G0zg2MsYB70u5VgWUsJUSVU2Yl4A/OgjaFiGkIp/s6+ce/kMQ0yeqn7igbei5XP2W28mcQt3jCBze0xKOCNx4t1m7wN3mucCDFJEpqmO50KHAlPoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778857147; c=relaxed/simple;
	bh=evtqAXnRsxCNbJ54PpiZfTds7888WrqwMTuQg9AH85I=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=X0KNDE7jgFJdtrTywoxY1A1CY+xvq3pdjGD6hd/XmpYdNL8eXOg0cOgmzesYpeQ9tKQiseOTDMLDUN/XZ8NTxt10711pVSEP/cDEhGJYIH+1jCPQhDNNH+rfJu9UPHVB7HoiqewdusJ0qS9ug9mcI3wVRHAAW1jCarcG7WMcEY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=Sm4rfRwQ; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2f7ca62a3c4so9739783eec.0
        for <stable@vger.kernel.org>; Fri, 15 May 2026 07:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1778857145; x=1779461945; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2lo5B4APz2AHxY+gOTJ1/PofXQ++VHSqNrd9RNX66MY=;
        b=Sm4rfRwQ5Ljg+oltgEM2ouKSBVK3Y8VPy4pR0HIYL/bjI5eHkDoFyRpwmRSQAFCTmi
         0iDZVUpfLSDQRhvAePlQe8Rf8gUjwDKG9drmBUX5rM60aGkCv4INm/y+u6RhWEM1OBfK
         0L2DnDNlod40doKPR5z5WznENq2hek1KXWq+yW8PiarHoT0AZfdRkTTPcSYAUHzTGWSI
         SiAN8KBtj27kRdrRWeDlGGN85m39G+WR5cLcvYl6dR8KX8XXWApvRqyxrWlwGMeUUq4e
         aL+cHwc/cmL8JPOhUEJrUxpjx/a9VXnFT2YC+5OFAX0+s2i2vWeAhUQkbLdT5++Lw+4W
         fqZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778857145; x=1779461945;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2lo5B4APz2AHxY+gOTJ1/PofXQ++VHSqNrd9RNX66MY=;
        b=NOyRHIQrtt/J+licCUQa3AwIeefzi3JJj0/3qskwY0YdoBl1UtzKy0hfNDtUm89Cj5
         rTGGiMW4vN9MYFR23bGAFLofZihr1Ty85rJdX5C2UqFVhUmr5bfmrI7bEGunL6G4NsOw
         jMtzcQsAxEscoMKfcOqVos+1Ivl3FkzsjEZn7BYdE/vvKdG4owhFcMdUzJ0Mw6/YUCmr
         9/0E8+TdC3j7FnHmsL+euACpmnckDB5P5YbuvdoKs69Gul0i6rEJwe+VbWBK18lR+47P
         AXXGg72GISwCtLfvoqFrd3YZODFRT8yoEcBs+rPxZYklbzDFxOBOyGJ3t52edjPsCoDn
         aC9g==
X-Forwarded-Encrypted: i=1; AFNElJ8nn9ov/Z1Glw6Yeukl0V+SHNndFEZmd0j3LDCRl+jt1XHRLfRTmm9yH/orfjMsK51kL1WFlSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNGzQFA2QPc+71eb1kMHmCl2i/nvYE7APpxUDpJCP9gsV7+czJ
	AmFVbUZq9cyPOrncQNXcJD8mxB28WtPBo+CJOd8nNTHN5ovur0/z5dy6uIOrdTXZPzZPkD168/b
	2vxMU
X-Gm-Gg: Acq92OF5xXjRcASlJevCExXn9+4YNw7w2Oq7AmYhkchry+PaWBNFvmO/SmW6h0P4KCV
	mmVzvn9hmUpGtRJmD3GKnRIqS96crQgSsTBEZqhLr8hJRCRWNyF05THt6v3VruZi3Fk0XWT9Zi4
	sIqZllry36BVvaEL+t1kSi6sjGmWAlayQfxkElkv3LsDS/PViiXekCYIj+O82BH7dOjAWRjHsSz
	fTa0z0b1JmxhRYmnrioa1IjhGuY2bk+QThQEQgpWk8hcbjhWVl0gdGhBeCGnpOaPWN3UX+ueRvc
	mokTVIWwWUhwxQo8aAm0jASJPMcCLL5R8ht1wxFG4Vn8YrFM7G60l29scFu2xOQ27mHGmw5eQs/
	MzCX4Lx04oCGLVObb3fKNyL73TZs/XOizRHteHwh9vzlv3HafQGRGMQVhzn3MyViEPncs6zCUfK
	8Rn2wMmbydr4b4u3Z/vV7nZyNMAK0=
X-Received: by 2002:a05:7301:7c12:b0:2ed:e14:7f57 with SMTP id 5a478bee46e88-303986c651cmr2487416eec.33.1778857145212;
        Fri, 15 May 2026 07:59:05 -0700 (PDT)
Received: from 330cfa3079ca ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302944ffb85sm7346817eec.7.2026.05.15.07.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 07:59:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable/linux-6.1.y: (build) error: Bad exit status from
 /var/tmp/rpm-tmp.PzvaZN (%install) in ...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 15 May 2026 14:59:04 -0000
Message-ID: <177885714386.1005.3592687596689940189@330cfa3079ca>
X-Rspamd-Queue-Id: 5F2F8551CF8
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
	TAGGED_FROM(0.00)[bounces-247804-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:email,kernelci.org:email,kernelci.org:url,kernelci.org:dkim,lists.linux.dev:replyto]
X-Rspamd-Action: no action





Hello,

New build issue found on stable/linux-6.1.y:

---
 error: Bad exit status from /var/tmp/rpm-tmp.PzvaZN (%install) in binrpm-pkg (/tmp/kci/linux/scripts/Makefile.package:71) [logspec:kbuild,kbuild.other]
---

- dashboard: https://d.kernelci.org/i/maestro:7b9d2a5a8b3db9e6e6f4ee69b25555ee33826321
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
- commit HEAD:  c27210688955656e93e26cffab0a82bbca4e5d2b
- tags: v6.1.173

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
tar --sort=name --owner=tuxmake:1000 --group=tuxmake:1000 --mtime=@1778855984 --clamp-mtime -caf /tmp/kci/artifacts/build/modules.tar.xz -C /tmp/kci/artifacts/build/modinstall lib
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build ARCH=x86_64 SRCARCH=x86 CROSS_COMPILE=x86_64-linux-gnu- binrpm-pkg
Building target platforms: x86_64-linux
Building for target x86_64-linux
warning: line 22: It's not recommended to have unversioned Obsoletes: Obsoletes: kernel-headers
Executing(%mkbuilddir): /bin/sh -e /var/tmp/rpm-tmp.Wrgehz
Executing(%install): /bin/sh -e /var/tmp/rpm-tmp.PzvaZN
+ umask 022
+ cd ./kernel-6.1.173-build
+ /usr/bin/rm -rf ./kernel-6.1.173-build/BUILDROOT
+ /usr/bin/mkdir -p ./kernel-6.1.173-build
+ /usr/bin/mkdir ./kernel-6.1.173-build/BUILDROOT
+ mkdir -p ./kernel-6.1.173-build/BUILDROOT/boot
+ make -f /tmp/kci/linux/Makefile -s image_name
/tmp/kci/linux/Makefile:747: include/config/auto.conf: No such file or directory
+ cp ./kernel-6.1.173-build/BUILDROOT/boot/vmlinuz-6.1.173
cp: missing destination file operand after './kernel-6.1.173-build/BUILDROOT/boot/vmlinuz-6.1.173'
Try 'cp --help' for more information.
error: Bad exit status from /var/tmp/rpm-tmp.PzvaZN (%install)
RPM build warnings:
RPM build errors:

=====================================================


# Builds where the incident occurred:

## x86_64_defconfig+aws-ec2 on (x86_64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a0722f30ed99f002e8df8a4


#kernelci issue maestro:7b9d2a5a8b3db9e6e6f4ee69b25555ee33826321

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

