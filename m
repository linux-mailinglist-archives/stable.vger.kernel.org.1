Return-Path: <stable+bounces-145493-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D767ABDBE7
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 16:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B835188955D
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 14:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F252824729D;
	Tue, 20 May 2025 14:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1vDCFEE0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBFD248F6D;
	Tue, 20 May 2025 14:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747750337; cv=none; b=e1PHRC0zfhBNNW5INumqk7qqvzNvMvIb92En7+Zha03UQ0UsCuo4LPUSyPnSOzdwgqrr8fHbMikedhy3nAxqeBFhSXzrInXTm/BWe15+wckMBRj9Md9qJppSx/OfKr25nl6uFfFjLjkeOb9/grVY99F8HqPZ77FTKN4BDLQ0pUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747750337; c=relaxed/simple;
	bh=VtMPFVp05EGl20vJB7S5xADQc9LNeAMF/OSH43rPZDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=huEDbHCBRkBh1bEl9C/+dexhavNCpqSSvrSdsA5gEHHYCwNZO8vpXW+y2Uq52g8FB8pC7YArmm1No5knF5+jfLo6D0U2wn4jFPS++HC/NQZ4KWBZbtqb/N/GmCj/tIRXzXM611unl43p0dWQoLY+8RqS6t2rmkFyTewu6tIEHaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1vDCFEE0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F7A5C4CEE9;
	Tue, 20 May 2025 14:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747750337;
	bh=VtMPFVp05EGl20vJB7S5xADQc9LNeAMF/OSH43rPZDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1vDCFEE0D5ob0R/C81ybLH+6nUVLc08RsJay3ICEuvbJIKyITiX/VgGa/eEAunfHq
	 XQKxcR8Ru7F7uMwL0thDvBw7gSfbXwb7Nw//Xe/l3M9Uf4gcVyQM7UkqeqUf1Ny7iO
	 XcHhWF5fVBQdmXMIwSjJMvtiv9zJ5vMVN39gdx9o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Fenghua Yu <fenghuay@nvidia.com>,
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 6.12 120/143] dmaengine: idxd: fix memory leak in error handling path of idxd_setup_wqs
Date: Tue, 20 May 2025 15:51:15 +0200
Message-ID: <20250520125814.744885788@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520125810.036375422@linuxfoundation.org>
References: <20250520125810.036375422@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shuai Xue <xueshuai@linux.alibaba.com>

commit 3fd2f4bc010cdfbc07dd21018dc65bd9370eb7a4 upstream.

Memory allocated for wqs is not freed if an error occurs during
idxd_setup_wqs(). To fix it, free the allocated memory in the reverse
order of allocation before exiting the function in case of an error.

Fixes: 7c5dd23e57c1 ("dmaengine: idxd: fix wq conf_dev 'struct device' lifetime")
Fixes: 700af3a0a26c ("dmaengine: idxd: add 'struct idxd_dev' as wrapper for conf_dev")
Fixes: de5819b99489 ("dmaengine: idxd: track enabled workqueues in bitmap")
Fixes: b0325aefd398 ("dmaengine: idxd: add WQ operation cap restriction support")
Cc: stable@vger.kernel.org
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
Link: https://lore.kernel.org/r/20250404120217.48772-2-xueshuai@linux.alibaba.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/idxd/init.c |   30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -167,8 +167,8 @@ static int idxd_setup_wqs(struct idxd_de
 
 	idxd->wq_enable_map = bitmap_zalloc_node(idxd->max_wqs, GFP_KERNEL, dev_to_node(dev));
 	if (!idxd->wq_enable_map) {
-		kfree(idxd->wqs);
-		return -ENOMEM;
+		rc = -ENOMEM;
+		goto err_bitmap;
 	}
 
 	for (i = 0; i < idxd->max_wqs; i++) {
@@ -187,10 +187,8 @@ static int idxd_setup_wqs(struct idxd_de
 		conf_dev->bus = &dsa_bus_type;
 		conf_dev->type = &idxd_wq_device_type;
 		rc = dev_set_name(conf_dev, "wq%d.%d", idxd->id, wq->id);
-		if (rc < 0) {
-			put_device(conf_dev);
+		if (rc < 0)
 			goto err;
-		}
 
 		mutex_init(&wq->wq_lock);
 		init_waitqueue_head(&wq->err_queue);
@@ -201,7 +199,6 @@ static int idxd_setup_wqs(struct idxd_de
 		wq->enqcmds_retries = IDXD_ENQCMDS_RETRIES;
 		wq->wqcfg = kzalloc_node(idxd->wqcfg_size, GFP_KERNEL, dev_to_node(dev));
 		if (!wq->wqcfg) {
-			put_device(conf_dev);
 			rc = -ENOMEM;
 			goto err;
 		}
@@ -209,9 +206,8 @@ static int idxd_setup_wqs(struct idxd_de
 		if (idxd->hw.wq_cap.op_config) {
 			wq->opcap_bmap = bitmap_zalloc(IDXD_MAX_OPCAP_BITS, GFP_KERNEL);
 			if (!wq->opcap_bmap) {
-				put_device(conf_dev);
 				rc = -ENOMEM;
-				goto err;
+				goto err_opcap_bmap;
 			}
 			bitmap_copy(wq->opcap_bmap, idxd->opcap_bmap, IDXD_MAX_OPCAP_BITS);
 		}
@@ -222,12 +218,28 @@ static int idxd_setup_wqs(struct idxd_de
 
 	return 0;
 
- err:
+err_opcap_bmap:
+	kfree(wq->wqcfg);
+
+err:
+	put_device(conf_dev);
+	kfree(wq);
+
 	while (--i >= 0) {
 		wq = idxd->wqs[i];
+		if (idxd->hw.wq_cap.op_config)
+			bitmap_free(wq->opcap_bmap);
+		kfree(wq->wqcfg);
 		conf_dev = wq_confdev(wq);
 		put_device(conf_dev);
+		kfree(wq);
+
 	}
+	bitmap_free(idxd->wq_enable_map);
+
+err_bitmap:
+	kfree(idxd->wqs);
+
 	return rc;
 }
 



