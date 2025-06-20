Return-Path: <stable+bounces-154873-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA29AE1300
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 07:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 392547A063E
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 05:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8C71EFF92;
	Fri, 20 Jun 2025 05:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="grerNWqN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B9F1DED53
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 05:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750397847; cv=none; b=e6l9VFLqhVRGOW+sLOkgQnL2GksSImwNOYVmN6zqwIDNDA3s8f74XGVqzmLJNHtiRfkqO+mkJduePg3OJr2MF+OHtHfgfIdxHM/QF4eI54aNhFKF3V3pVhHTvOo+W6HXzD8hoP8oGtVuRQkcwfs3qDUEm7tpGk+w7We3QhauRAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750397847; c=relaxed/simple;
	bh=uYOSl0zPIlYBnA6+jg8uEHHJu2OVzvCLJ+R1RtJ8nmY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DetoKHw20v37aqN8z35b4HFgiVr/fdCap9wdlJqPGNM6kX+bMcRTab9QDEKZrNQeJAL9RrzzMFL8ku9XvyCM7AjBZvP2QmY2p7fQ012pPWaU3zRbfsCdXNlBJl55s61oEMLeDqg5Lh91kLKnsAfONGpNpQZETZCcVnoI/vdOJqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=grerNWqN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60DACC4CEE3;
	Fri, 20 Jun 2025 05:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750397846;
	bh=uYOSl0zPIlYBnA6+jg8uEHHJu2OVzvCLJ+R1RtJ8nmY=;
	h=Subject:To:Cc:From:Date:From;
	b=grerNWqNYYabG3c+TPwJVNdYaFm4QX+/UQnAVzDkOmfz0usK7J63HDq0JdsVv7Zmb
	 3QaAp0bjqdGuvp0TGjbDgcxB2etKLs1ZUugdeiontEDTNbmAfy0he6/JrOK9AG1+mJ
	 /hv6jO3RSmO+W24kUzDaQEQb33SZS+CQyQd7mkz8=
Subject: FAILED: patch "[PATCH] crypto: marvell/cesa - Do not chain submitted requests" failed to apply to 5.4-stable tree
To: herbert@gondor.apana.org.au,klaus.kudielka@gmail.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 07:37:23 +0200
Message-ID: <2025062023-fidgety-landslide-5061@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 0413bcf0fc460a68a2a7a8354aee833293d7d693
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062023-fidgety-landslide-5061@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0413bcf0fc460a68a2a7a8354aee833293d7d693 Mon Sep 17 00:00:00 2001
From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Thu, 8 May 2025 13:22:16 +0800
Subject: [PATCH] crypto: marvell/cesa - Do not chain submitted requests

This driver tries to chain requests together before submitting them
to hardware in order to reduce completion interrupts.

However, it even extends chains that have already been submitted
to hardware.  This is dangerous because there is no way of knowing
whether the hardware has already read the DMA memory in question
or not.

Fix this by splitting the chain list into two.  One for submitted
requests and one for requests that have not yet been submitted.
Only extend the latter.

Reported-by: Klaus Kudielka <klaus.kudielka@gmail.com>
Fixes: 85030c5168f1 ("crypto: marvell - Add support for chaining crypto requests in TDMA mode")
Cc: <stable@vger.kernel.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/crypto/marvell/cesa/cesa.c b/drivers/crypto/marvell/cesa/cesa.c
index fa08f10e6f3f..9c21f5d835d2 100644
--- a/drivers/crypto/marvell/cesa/cesa.c
+++ b/drivers/crypto/marvell/cesa/cesa.c
@@ -94,7 +94,7 @@ static int mv_cesa_std_process(struct mv_cesa_engine *engine, u32 status)
 
 static int mv_cesa_int_process(struct mv_cesa_engine *engine, u32 status)
 {
-	if (engine->chain.first && engine->chain.last)
+	if (engine->chain_hw.first && engine->chain_hw.last)
 		return mv_cesa_tdma_process(engine, status);
 
 	return mv_cesa_std_process(engine, status);
diff --git a/drivers/crypto/marvell/cesa/cesa.h b/drivers/crypto/marvell/cesa/cesa.h
index d215a6bed6bc..50ca1039fdaa 100644
--- a/drivers/crypto/marvell/cesa/cesa.h
+++ b/drivers/crypto/marvell/cesa/cesa.h
@@ -440,8 +440,10 @@ struct mv_cesa_dev {
  *			SRAM
  * @queue:		fifo of the pending crypto requests
  * @load:		engine load counter, useful for load balancing
- * @chain:		list of the current tdma descriptors being processed
- *			by this engine.
+ * @chain_hw:		list of the current tdma descriptors being processed
+ *			by the hardware.
+ * @chain_sw:		list of the current tdma descriptors that will be
+ *			submitted to the hardware.
  * @complete_queue:	fifo of the processed requests by the engine
  *
  * Structure storing CESA engine information.
@@ -463,7 +465,8 @@ struct mv_cesa_engine {
 	struct gen_pool *pool;
 	struct crypto_queue queue;
 	atomic_t load;
-	struct mv_cesa_tdma_chain chain;
+	struct mv_cesa_tdma_chain chain_hw;
+	struct mv_cesa_tdma_chain chain_sw;
 	struct list_head complete_queue;
 	int irq;
 };
diff --git a/drivers/crypto/marvell/cesa/tdma.c b/drivers/crypto/marvell/cesa/tdma.c
index 388a06e180d6..243305354420 100644
--- a/drivers/crypto/marvell/cesa/tdma.c
+++ b/drivers/crypto/marvell/cesa/tdma.c
@@ -38,6 +38,15 @@ void mv_cesa_dma_step(struct mv_cesa_req *dreq)
 {
 	struct mv_cesa_engine *engine = dreq->engine;
 
+	spin_lock_bh(&engine->lock);
+	if (engine->chain_sw.first == dreq->chain.first) {
+		engine->chain_sw.first = NULL;
+		engine->chain_sw.last = NULL;
+	}
+	engine->chain_hw.first = dreq->chain.first;
+	engine->chain_hw.last = dreq->chain.last;
+	spin_unlock_bh(&engine->lock);
+
 	writel_relaxed(0, engine->regs + CESA_SA_CFG);
 
 	mv_cesa_set_int_mask(engine, CESA_SA_INT_ACC0_IDMA_DONE);
@@ -96,25 +105,27 @@ void mv_cesa_dma_prepare(struct mv_cesa_req *dreq,
 void mv_cesa_tdma_chain(struct mv_cesa_engine *engine,
 			struct mv_cesa_req *dreq)
 {
-	if (engine->chain.first == NULL && engine->chain.last == NULL) {
-		engine->chain.first = dreq->chain.first;
-		engine->chain.last  = dreq->chain.last;
-	} else {
-		struct mv_cesa_tdma_desc *last;
+	struct mv_cesa_tdma_desc *last = engine->chain_sw.last;
 
-		last = engine->chain.last;
+	/*
+	 * Break the DMA chain if the request being queued needs the IV
+	 * regs to be set before lauching the request.
+	 */
+	if (!last || dreq->chain.first->flags & CESA_TDMA_SET_STATE)
+		engine->chain_sw.first = dreq->chain.first;
+	else {
 		last->next = dreq->chain.first;
-		engine->chain.last = dreq->chain.last;
-
-		/*
-		 * Break the DMA chain if the CESA_TDMA_BREAK_CHAIN is set on
-		 * the last element of the current chain, or if the request
-		 * being queued needs the IV regs to be set before lauching
-		 * the request.
-		 */
-		if (!(last->flags & CESA_TDMA_BREAK_CHAIN) &&
-		    !(dreq->chain.first->flags & CESA_TDMA_SET_STATE))
-			last->next_dma = cpu_to_le32(dreq->chain.first->cur_dma);
+		last->next_dma = cpu_to_le32(dreq->chain.first->cur_dma);
+	}
+	last = dreq->chain.last;
+	engine->chain_sw.last = last;
+	/*
+	 * Break the DMA chain if the CESA_TDMA_BREAK_CHAIN is set on
+	 * the last element of the current chain.
+	 */
+	if (last->flags & CESA_TDMA_BREAK_CHAIN) {
+		engine->chain_sw.first = NULL;
+		engine->chain_sw.last = NULL;
 	}
 }
 
@@ -127,7 +138,7 @@ int mv_cesa_tdma_process(struct mv_cesa_engine *engine, u32 status)
 
 	tdma_cur = readl(engine->regs + CESA_TDMA_CUR);
 
-	for (tdma = engine->chain.first; tdma; tdma = next) {
+	for (tdma = engine->chain_hw.first; tdma; tdma = next) {
 		spin_lock_bh(&engine->lock);
 		next = tdma->next;
 		spin_unlock_bh(&engine->lock);
@@ -149,12 +160,12 @@ int mv_cesa_tdma_process(struct mv_cesa_engine *engine, u32 status)
 								 &backlog);
 
 			/* Re-chaining to the next request */
-			engine->chain.first = tdma->next;
+			engine->chain_hw.first = tdma->next;
 			tdma->next = NULL;
 
 			/* If this is the last request, clear the chain */
-			if (engine->chain.first == NULL)
-				engine->chain.last  = NULL;
+			if (engine->chain_hw.first == NULL)
+				engine->chain_hw.last  = NULL;
 			spin_unlock_bh(&engine->lock);
 
 			ctx = crypto_tfm_ctx(req->tfm);


