Return-Path: <stable+bounces-180164-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8829B7EC57
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 15:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE09C482852
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 12:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A29330D5E;
	Wed, 17 Sep 2025 12:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0mnOEjJ3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94623330D41;
	Wed, 17 Sep 2025 12:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113581; cv=none; b=TG+yFavK0Qlq2JnuJ6iXG6FpJr6hRZ2NTDEa9qczeVkoc8JsDWP93lHuCivHhunbpIqXFZIZh/Zwu122OPUirLUGN+ZwLHE7EOfoflGAA8T1UTgxXj9k8j1GWTmV3iFwZ6KcTs2miOHuN4kqxDrSpF4U322EZ2bVYV6/AK+uVLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113581; c=relaxed/simple;
	bh=VBU81/+PUSJRSMfkygKaWUM75QvE6AZSmCWJ4nqDK9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cQyB/i9fIvfixX41/19zQhtC/vFZbFSqAFKqOBYcaxD2y/c8XxNytbVgLRGyfGz+t+AMo5dqb98UOGvlo02E2GJUgFtZJrDebcVXgqQhXhFxI0kk3C9NXv2PDknOnmmSub0f9dvYh732XiXfKi42hM+IZGnrJNbuj42PrhsQ1V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0mnOEjJ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 122DCC4CEF0;
	Wed, 17 Sep 2025 12:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758113581;
	bh=VBU81/+PUSJRSMfkygKaWUM75QvE6AZSmCWJ4nqDK9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0mnOEjJ3Op2Qd6FQxeA+hw0Bxxc6MpHbGPAQrXs6ag1mTPZesJ/Vh53o4QwWrk2c9
	 sC6Kc4hf3dEQjJjIeZwZ0owCPoUUVkl76zwZS1+CqW1GUQ5/1ZQefR5WXwcOdg1L5Y
	 bTFRtxySuz82tScWsC0+/lfkGe+M75pao6tYNQ6s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Colin Ian King <colin.i.king@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 123/140] dmaengine: idxd: Fix double free in idxd_setup_wqs()
Date: Wed, 17 Sep 2025 14:34:55 +0200
Message-ID: <20250917123347.316233845@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917123344.315037637@linuxfoundation.org>
References: <20250917123344.315037637@linuxfoundation.org>
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

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 39aaa337449e71a41d4813be0226a722827ba606 ]

The clean up in idxd_setup_wqs() has had a couple bugs because the error
handling is a bit subtle.  It's simpler to just re-write it in a cleaner
way.  The issues here are:

1) If "idxd->max_wqs" is <= 0 then we call put_device(conf_dev) when
   "conf_dev" hasn't been initialized.
2) If kzalloc_node() fails then again "conf_dev" is invalid.  It's
   either uninitialized or it points to the "conf_dev" from the
   previous iteration so it leads to a double free.

It's better to free partial loop iterations within the loop and then
the unwinding at the end can handle whole loop iterations.  I also
renamed the labels to describe what the goto does and not where the goto
was located.

Fixes: 3fd2f4bc010c ("dmaengine: idxd: fix memory leak in error handling path of idxd_setup_wqs")
Reported-by: Colin Ian King <colin.i.king@gmail.com>
Closes: https://lore.kernel.org/all/20250811095836.1642093-1-colin.i.king@gmail.com/
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Link: https://lore.kernel.org/r/aJnJW3iYTDDCj9sk@stanley.mountain
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/idxd/init.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index a7344aac8dd98..74a83203181d6 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -187,27 +187,30 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 	idxd->wq_enable_map = bitmap_zalloc_node(idxd->max_wqs, GFP_KERNEL, dev_to_node(dev));
 	if (!idxd->wq_enable_map) {
 		rc = -ENOMEM;
-		goto err_bitmap;
+		goto err_free_wqs;
 	}
 
 	for (i = 0; i < idxd->max_wqs; i++) {
 		wq = kzalloc_node(sizeof(*wq), GFP_KERNEL, dev_to_node(dev));
 		if (!wq) {
 			rc = -ENOMEM;
-			goto err;
+			goto err_unwind;
 		}
 
 		idxd_dev_set_type(&wq->idxd_dev, IDXD_DEV_WQ);
 		conf_dev = wq_confdev(wq);
 		wq->id = i;
 		wq->idxd = idxd;
-		device_initialize(wq_confdev(wq));
+		device_initialize(conf_dev);
 		conf_dev->parent = idxd_confdev(idxd);
 		conf_dev->bus = &dsa_bus_type;
 		conf_dev->type = &idxd_wq_device_type;
 		rc = dev_set_name(conf_dev, "wq%d.%d", idxd->id, wq->id);
-		if (rc < 0)
-			goto err;
+		if (rc < 0) {
+			put_device(conf_dev);
+			kfree(wq);
+			goto err_unwind;
+		}
 
 		mutex_init(&wq->wq_lock);
 		init_waitqueue_head(&wq->err_queue);
@@ -218,15 +221,20 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 		wq->enqcmds_retries = IDXD_ENQCMDS_RETRIES;
 		wq->wqcfg = kzalloc_node(idxd->wqcfg_size, GFP_KERNEL, dev_to_node(dev));
 		if (!wq->wqcfg) {
+			put_device(conf_dev);
+			kfree(wq);
 			rc = -ENOMEM;
-			goto err;
+			goto err_unwind;
 		}
 
 		if (idxd->hw.wq_cap.op_config) {
 			wq->opcap_bmap = bitmap_zalloc(IDXD_MAX_OPCAP_BITS, GFP_KERNEL);
 			if (!wq->opcap_bmap) {
+				kfree(wq->wqcfg);
+				put_device(conf_dev);
+				kfree(wq);
 				rc = -ENOMEM;
-				goto err_opcap_bmap;
+				goto err_unwind;
 			}
 			bitmap_copy(wq->opcap_bmap, idxd->opcap_bmap, IDXD_MAX_OPCAP_BITS);
 		}
@@ -237,13 +245,7 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 
 	return 0;
 
-err_opcap_bmap:
-	kfree(wq->wqcfg);
-
-err:
-	put_device(conf_dev);
-	kfree(wq);
-
+err_unwind:
 	while (--i >= 0) {
 		wq = idxd->wqs[i];
 		if (idxd->hw.wq_cap.op_config)
@@ -252,11 +254,10 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 		conf_dev = wq_confdev(wq);
 		put_device(conf_dev);
 		kfree(wq);
-
 	}
 	bitmap_free(idxd->wq_enable_map);
 
-err_bitmap:
+err_free_wqs:
 	kfree(idxd->wqs);
 
 	return rc;
-- 
2.51.0




