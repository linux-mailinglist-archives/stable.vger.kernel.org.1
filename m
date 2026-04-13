Return-Path: <stable+bounces-235999-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FbUIWLW3GmcWQkAu9opvQ
	(envelope-from <stable+bounces-235999-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 13:41:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9773EB6B5
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 13:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8668D300E241
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 11:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D243C1976;
	Mon, 13 Apr 2026 11:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hGl2PfJT"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D563A9603
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 11:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776080381; cv=none; b=ufGDxsAKtWCegpQJIsoiBItkDWXGysP/6pgcnQiJqgWgydINiH6yOAxKfYHo/zrRVt6ZJPOaKCmzsxaCxpX7YV1D/rMgCGum3rPjgR595kCRppTNEyy4nMPiOqLXl/UQ7a0rnGpEqBTc1FoAChZyY8a1n/FUnznH/SY3yxvh/9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776080381; c=relaxed/simple;
	bh=YntEt/LZoVGnThRGEiUzRWkG7HPchILZZyy2yOKUjvo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o3uzFriYwe2nn4vBI3jDT5d394mOia2UMHTRo5jFJsU1eT+/uEI9bOJBqezjFOfXxPXRKFRHYY0P0z6WtgLUH+QBq3u4xsSJXKDMOJwyXm676f27Bxws/e0o48ZzhylbTAeinCIwQks5q/Dh3PIMGQGSHil5PLwq/ENx80AsE4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hGl2PfJT; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35da8d037a5so2031162a91.0
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 04:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776080380; x=1776685180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sKy2zr8o44SlqpTL5OnNaWPmsx1DrrUAZd9+1Le4qeA=;
        b=hGl2PfJTnjuCwxYEWAfQfovu7QfrVAkyOBKiN5iFIQyNeUXHHzmnl3AbZmVVBRKLRJ
         I/h5PhvSBA3ySE9hfF8RlMZUawrxGjePHufSb/pX/+V4cEnDWuQEAs1UBnCxqkZ7pzjT
         bsmVGTGWz8dR2s7PfCP8tt8Z7Ez4qxFthWXiV0x4vqvaypA2r83I7QPQoYR9lamm23N0
         cR0vbHz5fmWdTDxcDjcBlPLBHqSIQjV29HLZKa9oqM2UPqSuwRzM3mVTvgaViULcZDhD
         UJ40Ns40Tp2edVMhcKJ8LBFQsGbhKsl1J70TKtoFoxmLu9t6iwuWTmo6Thj2GHXxS2XF
         6Z3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776080380; x=1776685180;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sKy2zr8o44SlqpTL5OnNaWPmsx1DrrUAZd9+1Le4qeA=;
        b=TP3YXBccts5YXJwhZOA95YjbadVlDIKpBJd02Gs2wSLJjB/PrZm0b4pW+yAXtZ48ct
         Ln2tgmN1A9N9HSp1fMgpJ4l/sO8u2l8Ng3P2makWuWMjxMa7CG8d3NaoJuGBWbWSpsw6
         glB/JtwQT70TS5for39yG0/lSJYxv/wI+gmDSjROfs+6c/+LnL0CMAmAc6UHnGTkPis7
         Y8r+83GavlopuP3525wGIQ9SepyK5ILE2Eaf+MAvgXmgwOfwcAL6UVaTKq/S7hSdyNZU
         nr2j0/meHSnnPKE03ZMTRRYv6Pe/ex/Dd0jaMffuZQLH2QldCfdnjCZaQfwoChRa/5z6
         zbUQ==
X-Forwarded-Encrypted: i=1; AFNElJ+/bAcMlujymoRHOoiLlc3Oy8448vYSEJKxcQPV1zoFQSup4+Qhbegu7NkbIGmTsn4ou2Ehvw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK1LGjoosJz3UL/DLUFTlwgt0mfqHQHSR2qSH6lxqwS4z5drUp
	8Ur+79wbDH6VkibfcKFRQYFXYeBQnEDwh7ZP6Z8Z15stoD8UgZ8YLRRG
X-Gm-Gg: AeBDiestXYZF+47/lJ511Tqa1UfJuU2bOdu2MZO/F4ZglDPXSvide4hzR+Fka+2JWYe
	ZqHH79kt0iM0KbHHGE21t58hS7pJgy7kR+8T+TH/N7K2LsYjALRE7UCp4pkVBCliZ48XV3FQ4OV
	aaRxIP9KhweNSD46wP9jKG9vsBlPkF9ApYqSQiPFkXZUnVr4kJIlpQZ5Ybkxo2xVrk97e5SyBes
	HIGEzoUOubbqs2nIMpeea79QxSoy3iykHIJvK1BVhfr9uCTqs9MqDMCAtKP2GDgekZBQPHP5F8J
	JYSoR5VykanOYyF+FegeGSr8Mnd6OHKwHVfgmWcV8qzCPmODQXdILG4lTL1apAcspKwWqGX33nT
	aOWHAYs79u5ms80jc2bkRQKUFdDe3v9K6u8rowf/imIcgA7g1EUxbQhf/pnEXY3/u/c1OtFCXim
	zkzjiolHPIJrp3o13wJ9+CkA==
X-Received: by 2002:a17:90b:1d86:b0:35b:93d8:6aaf with SMTP id 98e67ed59e1d1-35e42827d1emr12889237a91.19.1776080379468;
        Mon, 13 Apr 2026 04:39:39 -0700 (PDT)
Received: from lgs.. ([112.224.67.108])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e4133695bsm15853279a91.13.2026.04.13.04.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 04:39:39 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Fenghua Yu <fenghua.yu@intel.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] dmaengine: idxd: fix double free in idxd_cdev_open() error path
Date: Mon, 13 Apr 2026 19:39:27 +0800
Message-ID: <20260413113927.2753349-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-235999-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DA9773EB6B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When dev_set_name() or device_add() fails, the call chain is:

idxd_cdev_open()
-> device_initialize(fdev)
-> dev_set_name() / device_add()
-> failure
-> put_device(fdev)
-> idxd_file_dev_release()
-> kfree(ctx)

Then control returns to idxd_cdev_open(), where the error path continues
with:

failed:
-> kfree(ctx)

Thus, ctx is freed twice.

In addition, idxd_file_dev_release() also calls ida_free() and
idxd_wq_put(), but in the current code ctx->id is allocated and the wq
reference is taken only after device_add() succeeds. If put_device(fdev)
runs the release callback before that point, the cleanup is not balanced.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Allocate the file ida and take the wq reference before
device_initialize(), so the device release callback can own the cleanup
after put_device(). For the dev_set_name() and device_add() failure path,
let put_device() and the release callback handle resource teardown.

Fixes: e6fd6d7e5f0fe ("dmaengine: idxd: add a device to represent the file opened")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - note that the issue was identified by my static analysis tool
  - and confirmed by manual review

 drivers/dma/idxd/cdev.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index 7e4715f92773..001d233e091c 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -225,6 +225,7 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
 	struct iommu_sva *sva = NULL;
 	unsigned int pasid;
 	struct idxd_cdev *idxd_cdev;
+	bool wq_ref = false;
 
 	wq = inode_wq(inode);
 	idxd = wq->idxd;
@@ -280,12 +281,15 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
 		}
 	}
 
-	idxd_cdev = wq->idxd_cdev;
 	ctx->id = ida_alloc(&file_ida, GFP_KERNEL);
 	if (ctx->id < 0) {
 		dev_warn(dev, "ida alloc failure\n");
 		goto failed_ida;
 	}
+	idxd_wq_get(wq);
+	wq_ref = true;
+
+	idxd_cdev = wq->idxd_cdev;
 	ctx->idxd_dev.type  = IDXD_DEV_CDEV_FILE;
 	fdev = user_ctx_dev(ctx);
 	device_initialize(fdev);
@@ -305,20 +309,23 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
 		goto failed_dev_add;
 	}
 
-	idxd_wq_get(wq);
 	mutex_unlock(&wq->wq_lock);
 	return 0;
 
 failed_dev_add:
 failed_dev_name:
 	put_device(fdev);
-failed_ida:
+	mutex_unlock(&wq->wq_lock);
+	return rc;
 failed_set_pasid:
 	if (device_user_pasid_enabled(idxd))
 		idxd_xa_pasid_remove(ctx);
 failed_get_pasid:
 	if (device_user_pasid_enabled(idxd) && !IS_ERR_OR_NULL(sva))
 		iommu_sva_unbind_device(sva);
+failed_ida:
+	if (wq_ref)
+		idxd_wq_put(wq);
 failed:
 	mutex_unlock(&wq->wq_lock);
 	kfree(ctx);
-- 
2.43.0


