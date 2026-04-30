Return-Path: <stable+bounces-241993-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBCJMK3u8mnhvgEAu9opvQ
	(envelope-from <stable+bounces-241993-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 07:54:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DF549DC4E
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 07:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E279301E7FC
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 05:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E9F37269B;
	Thu, 30 Apr 2026 05:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oyHQ0avA"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D1736BCDD
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 05:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777528481; cv=none; b=ikQ2Pagv/K+I5pBvt7R7UgyDpfVI0eJOxZ1D4OJyOsIYXmSOt5M+18Qjf1zhdcEg4VSFYgymEBv5EHVTUtoOv8oeMA0H6DvwPHsOMpINwZunL0oxFQqZy+amMDMU1ms4347WVT66NxlnQ+xfJKvbQWNYfV+5DWg6W2IBgVITeGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777528481; c=relaxed/simple;
	bh=Q7R86ThebD20EoDOnSlfVUdeU/ySa31tJjx/p+OQE/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eliG0xb5i0yAgAmSzT2sBQe8WcXdnEYtICRl3JNoVoXLswNFCuGkF1nH8+eDmaqi0bm4v0O7P4/0U4Osf+YvxKOg3dUjRQYfhmm3BcueUi+J0NXZ/JSdcU9jh+5AHRskemZtw272t+r53BnhGgJEUSkbmPsFcpubnY4dEc71maw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oyHQ0avA; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82748257f5fso1215062b3a.1
        for <stable@vger.kernel.org>; Wed, 29 Apr 2026 22:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777528479; x=1778133279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o2kxYsOO6pq5/nEFGxNKpCk5FTnWbDP6rB+zhW93ugg=;
        b=oyHQ0avAU+/rL/2bQvYEETUrxkBGFOJWYFJz38M34g8biw8miM4OKlnH60qKjDGbKe
         ZlFq53k30z4pl6hn0fzrW4mqEWgJSzOYYvstSZKMaZ2lVhcEOL2AIixmzdw4I3lZ9ZMO
         ZOYbLQk2Ijo68fwiSS8sqXnW8B+W/QhcXYTuwszRsHTcoZccpPng74GQuc/vrS02kPbL
         iuOqSM8bC958qaVWhms+vxptWv4olIdfUDd/AOVpxaU1cB7uLM3Zyfd8kcfF19qu/I2h
         tokGu1PpEW9iBpHztGeKXkD4Pqcw3YyYu6Z61Ctn15rHtqBPvzOq7QcLgOj4aDnuSF36
         ObBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777528479; x=1778133279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o2kxYsOO6pq5/nEFGxNKpCk5FTnWbDP6rB+zhW93ugg=;
        b=NfPCXQC51LJctK8BqXC0vrTlCBTwSTtxRycSG2HSRqJAD4gUVbo+xomWIiYNthCuoI
         t66BoS9mPTpdFnUUZKaJwadW5ty0QnrKAiZHp3PiDE2ANph2VqoU44GwllKajAp2cdJk
         8UW613SzHttqExdZz2mii8iZYFQC5EW5GAQdwH0BMavMC6UQaZzy9sTma6AuotWqLiOU
         QYHWcIz9edSkPs82VORpjV/TcJJ7FU5r0wLdQzPcufZJyBD/oWZ3V/j5SiguSGpA8eSh
         KkSS4WZZ9FEbuep6OSDNq1LVH/DyUR6EToZpYBvtRVVa8OJpxLLJxVSIWnbWcwLdDUTE
         tQxA==
X-Forwarded-Encrypted: i=1; AFNElJ8E8C+j3n1vEomkZQH6/l8076mQpn1CNcCK5Mw4+5h35ate6EORVJznc7+2lH2vmXrQ1GuqsqE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh6uwPkF9YS2K6ZCmvMw6o6caUo6qBInQ3VLfPFm4a4LYRakAL
	h6LlBu3OJA4kwVfd9nGtLZDH8LY0nyW+SNOepOmvRoYI6+D7KDJG1OXJ
X-Gm-Gg: AeBDieskw04RhbBJP4DSr20zYufVGhAZePrUQZ1yuV4nAUab98Ta1cRWeBsEQxMwpGC
	cJ9BEm4LN6P+7k2jw1R+KZ9zYPGkRm7FMBr3SBvZpOuqZij/OtBpblaLDbUyiPzYOgnk/Pdgmj2
	fhM8ejgNu0Sld0ToX8S+QwFsSkLh3z/6pevpa7v+TMK5j47bHs+XqTQ7ATkJGDPXYIcLnqhPPd2
	BLO1HPHD1d4MVaC7fc7b0QD0Z3aWlHwBttd1VbFBXmIJwJqOBT5DAXTJLrBL7U+vx0zY/X7nZPK
	VjciAAoTbBTvLaAfpSnVxSEuF/6mzwTVqVUAW9OoAQ3Iza0be3TNYG6jM6KVMzC0/Lsk6DpOhkH
	g4e6jmvs6z8XLuAPhTxYHKXPFfFh8orrm/z6FgKWHDaQlRtoK8e2tuxiTtl1rMcG/+vztiI2ZL2
	XyS93udIbsCLyrn7v+keO8dhI=
X-Received: by 2002:a05:6a00:8990:b0:82f:7888:e2fa with SMTP id d2e1a72fcca58-8350015fc9amr715848b3a.17.1777528479291;
        Wed, 29 Apr 2026 22:54:39 -0700 (PDT)
Received: from lgs.. ([101.36.106.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834ed2fd07csm4062251b3a.0.2026.04.29.22.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 22:54:38 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bingbu Cao <bingbu.cao@intel.com>,
	Tianshu Qiu <tian.shu.qiu@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] media: intel/ipu6: Fix pdata double free in init error paths
Date: Thu, 30 Apr 2026 13:54:30 +0800
Message-ID: <20260430055430.447536-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 64DF549DC4E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-241993-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

ipu6_bus_initialize_device() stores the caller allocated pdata pointer in
adev->pdata and installs ipu6_bus_release() as the device release callback.
After auxiliary_device_init() succeeds, pdata is released by
ipu6_bus_release().

The isys and psys init error paths still call kfree(pdata) after
put_device() or after ipu6_bus_add_device() fails. In both cases the
auxiliary device release callback has already been invoked, so pdata has
already been freed through adev->pdata.

Remove the duplicate kfree(pdata) calls. Also cache the MMU init error
before calling put_device(), since put_device() may release the auxiliary
device container.

This issue was found by a static analysis tool I am developing.

Fixes: 25fedc021985a ("media: intel/ipu6: add Intel IPU6 PCI device driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/media/pci/intel/ipu6/ipu6.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/media/pci/intel/ipu6/ipu6.c b/drivers/media/pci/intel/ipu6/ipu6.c
index 34f67f4f1bb5..96ee33af8f6a 100644
--- a/drivers/media/pci/intel/ipu6/ipu6.c
+++ b/drivers/media/pci/intel/ipu6/ipu6.c
@@ -399,19 +399,18 @@ ipu6_isys_init(struct pci_dev *pdev, struct device *parent,
 	isys_adev->mmu = ipu6_mmu_init(dev, base, ISYS_MMID,
 				       &ipdata->hw_variant);
 	if (IS_ERR(isys_adev->mmu)) {
+		ret = PTR_ERR(isys_adev->mmu);
+		dev_err_probe(dev, ret,
+			      "ipu6_mmu_init(isys_adev->mmu) failed\n");
 		put_device(&isys_adev->auxdev.dev);
-		kfree(pdata);
-		return dev_err_cast_probe(dev, isys_adev->mmu,
-				"ipu6_mmu_init(isys_adev->mmu) failed\n");
+		return ERR_PTR(ret);
 	}
 
 	isys_adev->mmu->dev = &isys_adev->auxdev.dev;
 
 	ret = ipu6_bus_add_device(isys_adev);
-	if (ret) {
-		kfree(pdata);
+	if (ret)
 		return ERR_PTR(ret);
-	}
 
 	return isys_adev;
 }
@@ -443,19 +442,18 @@ ipu6_psys_init(struct pci_dev *pdev, struct device *parent,
 	psys_adev->mmu = ipu6_mmu_init(&pdev->dev, base, PSYS_MMID,
 				       &ipdata->hw_variant);
 	if (IS_ERR(psys_adev->mmu)) {
+		ret = PTR_ERR(psys_adev->mmu);
+		dev_err_probe(&pdev->dev, ret,
+			      "ipu6_mmu_init(psys_adev->mmu) failed\n");
 		put_device(&psys_adev->auxdev.dev);
-		kfree(pdata);
-		return dev_err_cast_probe(&pdev->dev, psys_adev->mmu,
-				"ipu6_mmu_init(psys_adev->mmu) failed\n");
+		return ERR_PTR(ret);
 	}
 
 	psys_adev->mmu->dev = &psys_adev->auxdev.dev;
 
 	ret = ipu6_bus_add_device(psys_adev);
-	if (ret) {
-		kfree(pdata);
+	if (ret)
 		return ERR_PTR(ret);
-	}
 
 	return psys_adev;
 }
-- 
2.43.0


