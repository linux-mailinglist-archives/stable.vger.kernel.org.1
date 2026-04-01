Return-Path: <stable+bounces-232671-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGB+KXmRzGk7UAYAu9opvQ
	(envelope-from <stable+bounces-232671-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 05:31:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F5637465B
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 05:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0BD173031F07
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 03:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D521364922;
	Wed,  1 Apr 2026 03:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ss38zBFv"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3349137E2E5
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 03:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775014227; cv=none; b=s6yIRpWhKSu1glwnkQ+X3akw8WcE0YS6wi1/RTeIS/2vLulvgIA+A/VuyOiQCmPCNeTrUh3wGv9780dI8Z2ZMV/c8nFvj3X1VwcaCHazZefX377TfZ7/3dWBt2j9uCK98V85LgE79r1yqsejRvb4iOtEoeveJeRNne+z6rbNIOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775014227; c=relaxed/simple;
	bh=hxXLF5lyQ0tyXHzP24s/EoG6WZkR9hY6mbKxFS7/gIc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PNRm55NxA58+wXSdYKQT9rk4KjRDHlzdjj3hqQK6ki0rv0099arZVWUELQOJ05pDUI+XnCzZXCyiJt1lgeV7Iq+ixF+9DO0qmNb84PS9lQevNk/gQXBRTrqNuLCGxUJ5LHRSwzvily5KQS3suUzY7JIdvL2x6wT+eTjroLEktRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ss38zBFv; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-35c2fe0d90fso2978931a91.1
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 20:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775014225; x=1775619025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9P47rW39jbyc8421UN3l72weYmCGnxeZ7bLfcFbS7SM=;
        b=ss38zBFvluFtVZYV7DHbzNSzWM1JvzgeB8iKywu5nM3E0zkQUByE2DVjXu+lpjO+sP
         X0WSVzem3+nz8Y5diCsepL2bgMXbhjyx6YtE4cfhtgzcNo+VGolOu5hylARuXJuBDwrU
         seyHS51mPDvIji0pJtSoCc3phy9dctonah7m0jWDVDiHK/Sldn75btNcxp3SNef14LYE
         jP/tjmix4EvsxmRn4gQ5Q7FRSvSnyzpey8kZpl4ljxH+Mf8yF9H6HiXaOuReysfPXy8G
         59VsMLpw6LRsUttRWvrwrhkIpfIFhP7x44VJ21kclBvMP2DKpl4nmcjKL3aXp/8Ptb2x
         xqWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775014225; x=1775619025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9P47rW39jbyc8421UN3l72weYmCGnxeZ7bLfcFbS7SM=;
        b=J2vqpZlMTFoQCsvCwkHKRq/Ex3XoGgYMXFQVhdpL47zQeLy0pBiGQQoa8YlfAYTB/f
         x9pJY3K4jegrpIs6L0siALJ3H2UcH3RFyev9z3URXAFmR4y/MQ7pi+0nYupegZOUfG+Q
         AywVotazik4cWi2o0v5Kk13iynFV1Mm1bAiITsSbXuW/gNd+XXTq70i36Zuw8ZGIk2CL
         qMzmAC6WtQ0B0iLzrSudql9hFAl9LE4kv2ed1s3QOK7pVzZtUPeqkQeS4eGHxLFLzXPD
         7mSBxE7xVLDCAHbg7U/aAEtaKCPG80id9pYiDqnXzXBOt3h7/VtzvkAF3zARkfBAnCIC
         me0w==
X-Forwarded-Encrypted: i=1; AJvYcCUlOpskgaw6LCrD9h/PVLNB39SucgDrDFalA4f2Bm0ZEflK2E8dxDYQtmC7Jl1WuBlrMAQ5tC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR95EkSz4QFMxwWVQ+d1wBLun3BZ0sF3TE7uhhc2og8dx6bzg8
	plsRA/lYmG0Za5/q6n5wnMgnd+9Q9q2nVfGhDFHq5DDsM0lgTKAtxxxt
X-Gm-Gg: ATEYQzzPst6LKvLYWSKkJdPs/KwMQibTugod2KoHpOIPtHd/kY7RlM9pFgm/XbxAszA
	kEDYSh/+Wov6IM+HHtNjast4J11eipD9Rs+S0bb0hLWMSGbu5csM/JHQsIIFPhCQOM5AkjfGE/p
	febwK/stp/hovl3D6+sXc+L71/dcAlDzzLo6gL2lKIPyz+OLCfo3u7KEKDyGxcw48oTBn1SJ6BU
	eXIHrTegdtg3hrymEUxrzswpTr+IgM2CeBLmY7yw0VrJUfQwFVR8fkXN+psQi4iDs+FsR0ke2qN
	7NWK1mxbMa6nyKcUedqxC6L1p+jYTaWo0sI6eAh08GK2ANZF5rGgMBarfybPbQuGBcSQx9IdcOd
	8Gri3KG51ozClFqUx742AFr4WTN4yAXln32FeGrzpwdX3zaru718Ks6mxnbRnRTL/mS9J+NNJpK
	PbMBlBi/HJoEo1N35dglULAQ==
X-Received: by 2002:a17:90b:528c:b0:35d:a0b7:9608 with SMTP id 98e67ed59e1d1-35dc6e7b1d8mr1756731a91.7.1775014223910;
        Tue, 31 Mar 2026 20:30:23 -0700 (PDT)
Received: from lgs.. ([2408:8417:e10:5f85:653:6a84:ffc9:685c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe41b11fsm3075358a91.0.2026.03.31.20.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 20:30:23 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] dmaengine: idxd: fix double free in idxd_setup_wqs() error path
Date: Wed,  1 Apr 2026 11:30:13 +0800
Message-ID: <20260401033013.1434986-1-lgs201920130244@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-232671-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 24F5637465B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When an error happens after device_initialize(), idxd_setup_wqs()
calls put_device(conf_dev).

The device release callback idxd_conf_wq_release() frees wq,
wq->wqcfg, and wq->opcap_bmap, but the current error paths then free
them again directly, causing a double free.

Keep the cleanup in idxd_conf_wq_release() after put_device() and
avoid freeing those objects again in idxd_setup_wqs().

Fixes: 39aaa337449e7 ("dmaengine: idxd: Fix double free in idxd_setup_wqs()")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/dma/idxd/init.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 2acc34b3daff..b782eb3c191d 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -212,7 +212,7 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 		rc = dev_set_name(conf_dev, "wq%d.%d", idxd->id, wq->id);
 		if (rc < 0) {
 			put_device(conf_dev);
-			kfree(wq);
+
 			goto err_unwind;
 		}
 
@@ -226,7 +226,7 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 		wq->wqcfg = kzalloc_node(idxd->wqcfg_size, GFP_KERNEL, dev_to_node(dev));
 		if (!wq->wqcfg) {
 			put_device(conf_dev);
-			kfree(wq);
+
 			rc = -ENOMEM;
 			goto err_unwind;
 		}
@@ -234,9 +234,9 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 		if (idxd->hw.wq_cap.op_config) {
 			wq->opcap_bmap = bitmap_zalloc(IDXD_MAX_OPCAP_BITS, GFP_KERNEL);
 			if (!wq->opcap_bmap) {
-				kfree(wq->wqcfg);
+
 				put_device(conf_dev);
-				kfree(wq);
+
 				rc = -ENOMEM;
 				goto err_unwind;
 			}
@@ -252,12 +252,10 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 err_unwind:
 	while (--i >= 0) {
 		wq = idxd->wqs[i];
-		if (idxd->hw.wq_cap.op_config)
-			bitmap_free(wq->opcap_bmap);
-		kfree(wq->wqcfg);
+
 		conf_dev = wq_confdev(wq);
 		put_device(conf_dev);
-		kfree(wq);
+
 	}
 	bitmap_free(idxd->wq_enable_map);
 
-- 
2.43.0


