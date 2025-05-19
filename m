Return-Path: <stable+bounces-144858-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1DDABBF4B
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 15:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B8D53B0BF8
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 13:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF7C279911;
	Mon, 19 May 2025 13:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GfNLYbKX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F15E278E47
	for <stable@vger.kernel.org>; Mon, 19 May 2025 13:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747661725; cv=none; b=IgvsWbY68e2COUs0PI4FfCXZv3+spQRN1LcwjCeIZNp5BRXfJcw5GwxII6jDeRK3thnZsuWdXIQ5N9/0gRKkdt+zfeKc+d6nCzdMldaLWXubww8mkuSpm4MntHo6RiLsA9Za3268lhobu3RTBf4nwvUVXGedDWBrLi0qQC6cb+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747661725; c=relaxed/simple;
	bh=jMxkemNNK/zNpifCdASIb8PChxn7d2F2TK1yR3k5s8g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tnENMdq6hp3bBrT9t0kFCfeaRQMDTSOVGBwRBEpzJiBl/JPuP3ZIqk267u8e1DFsepTC3muM9c+tjQYQmP/31vLAUt4s3WjL73YHtmlQt59iTOkjgk9Xi7HZ44MixxCEWWqz4ab0eVG/qD1Wug3rarzLkq43A6b+2ipAp9DHFsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GfNLYbKX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29050C4CEE4;
	Mon, 19 May 2025 13:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747661724;
	bh=jMxkemNNK/zNpifCdASIb8PChxn7d2F2TK1yR3k5s8g=;
	h=Subject:To:Cc:From:Date:From;
	b=GfNLYbKXOtZy7UjsAIY10yfpc5FKTaWPDMbzGwGNde2PG+xY2fH8zYeIq5KA6NoJL
	 lSwdHWfEJ9mFKjGCDdUbUX3kVdyGxA2e/MotPtxZkLvXqHZI2SCXHI2U6T/n6eSIhc
	 jqugGeC1t9P12uY3p0UCmy8kqdJ+HXBdhr3NNiUs=
Subject: FAILED: patch "[PATCH] dmaengine: idxd: Add missing cleanup for early error out in" failed to apply to 5.15-stable tree
To: xueshuai@linux.alibaba.com,dave.jiang@intel.com,fenghuay@nvidia.com,vkoul@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 May 2025 15:35:21 +0200
Message-ID: <2025051921-smother-limpness-650a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 61259fb96e023f7299c442c48b13e72c441fc0f2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051921-smother-limpness-650a@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 61259fb96e023f7299c442c48b13e72c441fc0f2 Mon Sep 17 00:00:00 2001
From: Shuai Xue <xueshuai@linux.alibaba.com>
Date: Fri, 4 Apr 2025 20:02:12 +0800
Subject: [PATCH] dmaengine: idxd: Add missing cleanup for early error out in
 idxd_setup_internals

The idxd_setup_internals() is missing some cleanup when things fail in
the middle.

Add the appropriate cleanup routines:

- cleanup groups
- cleanup enginces
- cleanup wqs

to make sure it exits gracefully.

Fixes: defe49f96012 ("dmaengine: idxd: fix group conf_dev lifetime")
Cc: stable@vger.kernel.org
Suggested-by: Fenghua Yu <fenghuay@nvidia.com>
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Link: https://lore.kernel.org/r/20250404120217.48772-5-xueshuai@linux.alibaba.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 7f0a26e2e0a5..a40fb2fd5006 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -155,6 +155,25 @@ static void idxd_cleanup_interrupts(struct idxd_device *idxd)
 	pci_free_irq_vectors(pdev);
 }
 
+static void idxd_clean_wqs(struct idxd_device *idxd)
+{
+	struct idxd_wq *wq;
+	struct device *conf_dev;
+	int i;
+
+	for (i = 0; i < idxd->max_wqs; i++) {
+		wq = idxd->wqs[i];
+		if (idxd->hw.wq_cap.op_config)
+			bitmap_free(wq->opcap_bmap);
+		kfree(wq->wqcfg);
+		conf_dev = wq_confdev(wq);
+		put_device(conf_dev);
+		kfree(wq);
+	}
+	bitmap_free(idxd->wq_enable_map);
+	kfree(idxd->wqs);
+}
+
 static int idxd_setup_wqs(struct idxd_device *idxd)
 {
 	struct device *dev = &idxd->pdev->dev;
@@ -245,6 +264,21 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 	return rc;
 }
 
+static void idxd_clean_engines(struct idxd_device *idxd)
+{
+	struct idxd_engine *engine;
+	struct device *conf_dev;
+	int i;
+
+	for (i = 0; i < idxd->max_engines; i++) {
+		engine = idxd->engines[i];
+		conf_dev = engine_confdev(engine);
+		put_device(conf_dev);
+		kfree(engine);
+	}
+	kfree(idxd->engines);
+}
+
 static int idxd_setup_engines(struct idxd_device *idxd)
 {
 	struct idxd_engine *engine;
@@ -296,6 +330,19 @@ static int idxd_setup_engines(struct idxd_device *idxd)
 	return rc;
 }
 
+static void idxd_clean_groups(struct idxd_device *idxd)
+{
+	struct idxd_group *group;
+	int i;
+
+	for (i = 0; i < idxd->max_groups; i++) {
+		group = idxd->groups[i];
+		put_device(group_confdev(group));
+		kfree(group);
+	}
+	kfree(idxd->groups);
+}
+
 static int idxd_setup_groups(struct idxd_device *idxd)
 {
 	struct device *dev = &idxd->pdev->dev;
@@ -410,7 +457,7 @@ static int idxd_init_evl(struct idxd_device *idxd)
 static int idxd_setup_internals(struct idxd_device *idxd)
 {
 	struct device *dev = &idxd->pdev->dev;
-	int rc, i;
+	int rc;
 
 	init_waitqueue_head(&idxd->cmd_waitq);
 
@@ -441,14 +488,11 @@ static int idxd_setup_internals(struct idxd_device *idxd)
  err_evl:
 	destroy_workqueue(idxd->wq);
  err_wkq_create:
-	for (i = 0; i < idxd->max_groups; i++)
-		put_device(group_confdev(idxd->groups[i]));
+	idxd_clean_groups(idxd);
  err_group:
-	for (i = 0; i < idxd->max_engines; i++)
-		put_device(engine_confdev(idxd->engines[i]));
+	idxd_clean_engines(idxd);
  err_engine:
-	for (i = 0; i < idxd->max_wqs; i++)
-		put_device(wq_confdev(idxd->wqs[i]));
+	idxd_clean_wqs(idxd);
  err_wqs:
 	return rc;
 }


