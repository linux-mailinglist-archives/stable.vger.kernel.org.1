Return-Path: <stable+bounces-244752-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id nXKlOCPe/WmqkAAAu9opvQ
	(envelope-from <stable+bounces-244752-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 14:59:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 573924F6A84
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 14:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C96863024447
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 12:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E513E1205;
	Fri,  8 May 2026 12:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="fl3BVfTU"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1373D5662
	for <stable@vger.kernel.org>; Fri,  8 May 2026 12:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778245149; cv=none; b=k6MYu51XlXeGXyd0btlqGurkdQ8kczwgF2EDZl9r8tr3mO2jUBkuYEU2Z4MLtpFc1wFxlPUjABIUeGrvNIbiPvWFBpCpTT89WhXesPlx2QxfwYmZx1XU1/t8WzF8dDszMJK3OWmI3R/Ti+DeHaKNxq/fkCl1hl5mDc/zIwYba0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778245149; c=relaxed/simple;
	bh=H4VziGPMaWqljOIy55lu4EWtFpmBlcF9UothmvTeiH0=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=p9LGzsbZd0cLFfTNBLQHPi9ZLEb/4YjYg7Lh7FkHnjai0W7/hbWfVEDlG3rNvkwcKz5nRUDWHP9pWRh1eX7et9tQlrVZkfCm5Dj+gesHHrCoDrF4/1oUbbq6Oemx/P6QtGfp92+9GPeBsn9k4WxofA17Tfq8bx1Y3THG0LJDhSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=fl3BVfTU; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1309f4ee973so2325614c88.1
        for <stable@vger.kernel.org>; Fri, 08 May 2026 05:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1778245147; x=1778849947; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q3LxepLOtI8uTen8+UE7r2BlQwLhLLbRPVVqyjgTsDQ=;
        b=fl3BVfTUrzSBggYrqsZa3qnlmjvjwLR4eXJy/jC9LdRPF+kp+CwwxLgI9rqj4gIJrB
         T7fci7UxJvWcq1xdUtv+PQXWpromday3Ort8Vv0fKMKbullhjWQFRoLq8Y/H7Kx0k84a
         GeGpiZJn1sp05mmZDBhqRrQU8g1sXtSMOBSAjZIGiQ13zGWGut81R6VXq6kUUM5GaYnY
         /Pasv7Hgbfzhv37aFiWnbCubiDBEHoICG139QflTqHSbFiREcuL3W+4wcjrbl9Vi3rdj
         awYsi1AGq+CflzjlFM1EP+8SNns3iDcWGPmLSnso7ZpcXvJnyxt5vvq2A/RGu2ebDgjH
         08sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778245147; x=1778849947;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q3LxepLOtI8uTen8+UE7r2BlQwLhLLbRPVVqyjgTsDQ=;
        b=nSRcV4edu7aSJxCbgEu/sq2VZ4yVQ16v8Zh9hSAFI8pNJ5g4GzOhVnwwVnbO1NZMs4
         O+HAIgFbyL4PclL8WMtlIfqMdcEbS0blbU16gXmwKqGtq3aLop9tAUd2z30EcWBhyz0t
         YEC9LL7g455cum8c9tcW01y9qTTkXJCY5pWXGbcl8b13/tYHnDllt+Ov67oRguXmOsZp
         qq4gzELWVURcm/vTHAP1Ic1LMvwH1an6T9xCKaa76TcA/vZAgULEKtOQ7EWSJ71Sdgxu
         MTddOsy13gpVEf37MBHrbhVXcZdzyRpqXViN54f3IUK7iYyTbISgyWA8OdUzmgqVkSFM
         h+Wg==
X-Forwarded-Encrypted: i=1; AFNElJ8Y3H6AiM34wvhVrXhacsJ6hlFHtpubSns9VQufkvnQtREu3OGdHmjkcCjG6cp49nc4cMMwEak=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjfpGwzlCtwddq571HgbKQUeig0rettibOq/xihqlghLblLlTB
	OxBy9IetEw4uW2o/su68cACpcRQ4ndYoBjhxzwu9hmKRu+OswyFEQsrXuLstyg6W61uVledEvD5
	I/l4e
X-Gm-Gg: AeBDietJ7TIyl1QBu2eJtj9JUmIL/ygik8lIoW5RKGwt5B4DOpXYP72RwF7K28AtvJq
	9iouxxpQC7aLUgEXtt5lIAkeMhAd6pVa1uScW7HIJCZ0XnOflBRppe+8dXHJ6MdLQLByqh2Z5y7
	I7YX5enbRYo0g8S6YwhPibr//xvzZPtIJNDXeKQdJRdmzvuvXdIvO6sWXg50I/fQ7Y6qvezc2+y
	Ae+6n81hIIBz4FDht2FIJgmHdH32lxY1JSRWrfxlNic/B1tROf+M8s3fZD6sO97uDdgIyr1fnyN
	g4nTgf0lpE5UwO7+njIhSz3yxhKT0nEVvkrqkSmuX+Ir9zbf2kwwm6dnzoPfLxy4AWIlY+Hdlvp
	kQD/3NMNDIZeHwigbrpXrLiozzJdb7GTIRPVzWC/lbb8WezUEhREq1tMlxN75oM3OF0QA3FZLSR
	VhHHfgpnXUVv/y3imy
X-Received: by 2002:a05:701b:271a:b0:132:7ab5:6ca8 with SMTP id a92af1059eb24-1327ab56e23mr507677c88.22.1778245146986;
        Fri, 08 May 2026 05:59:06 -0700 (PDT)
Received: from 997d03828cfd ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1327810ffb9sm2763334c88.2.2026.05.08.05.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 05:59:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.1.y: (build) error: Bad exit status
 from
 /var/tmp/rpm-tmp.SsQRn5 (%install) in ...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 08 May 2026 12:59:05 -0000
Message-ID: <177824514556.4192.2485790955376539715@997d03828cfd>
X-Rspamd-Queue-Id: 573924F6A84
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
	TAGGED_FROM(0.00)[bounces-244752-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernelci.org:email,kernelci.org:url,kernelci.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action





Hello,

New build issue found on stable-rc/linux-6.1.y:

---
 error: Bad exit status from /var/tmp/rpm-tmp.SsQRn5 (%install) in binrpm-pkg (/tmp/kci/linux/scripts/Makefile.package:71) [logspec:kbuild,kbuild.other]
---

- dashboard: https://d.kernelci.org/i/maestro:82b35b8c395c1b84614c5c6712b47aa6c96fc982
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  128a674368bf4493be63895d126ef9bc98516f4b
- tags: v6.1.171

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
tar --sort=name --owner=tuxmake:1000 --group=tuxmake:1000 --mtime=@1778242305 --clamp-mtime -caf /tmp/kci/artifacts/build/modules.tar.xz -C /tmp/kci/artifacts/build/modinstall lib
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build ARCH=x86_64 SRCARCH=x86 CROSS_COMPILE=x86_64-linux-gnu- binrpm-pkg
Building target platforms: x86_64-linux
Building for target x86_64-linux
warning: line 22: It's not recommended to have unversioned Obsoletes: Obsoletes: kernel-headers
Executing(%mkbuilddir): /bin/sh -e /var/tmp/rpm-tmp.WISUWs
Executing(%install): /bin/sh -e /var/tmp/rpm-tmp.SsQRn5
+ umask 022
+ cd ./kernel-6.1.171-build
+ /usr/bin/rm -rf ./kernel-6.1.171-build/BUILDROOT
+ /usr/bin/mkdir -p ./kernel-6.1.171-build
+ /usr/bin/mkdir ./kernel-6.1.171-build/BUILDROOT
+ mkdir -p ./kernel-6.1.171-build/BUILDROOT/boot
+ make -f /tmp/kci/linux/Makefile -s image_name
/tmp/kci/linux/Makefile:747: include/config/auto.conf: No such file or directory
+ cp ./kernel-6.1.171-build/BUILDROOT/boot/vmlinuz-6.1.171
cp: missing destination file operand after './kernel-6.1.171-build/BUILDROOT/boot/vmlinuz-6.1.171'
Try 'cp --help' for more information.
error: Bad exit status from /var/tmp/rpm-tmp.SsQRn5 (%install)
RPM build warnings:
RPM build errors:

=====================================================


# Builds where the incident occurred:

## x86_64_defconfig+aws-ec2 on (x86_64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:69fdce0a0e4ee292cbef2016


#kernelci issue maestro:82b35b8c395c1b84614c5c6712b47aa6c96fc982

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

