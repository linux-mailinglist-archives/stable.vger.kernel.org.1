Return-Path: <stable+bounces-144851-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E13F6ABBEFB
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 15:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F1031B6152D
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 13:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B3B27817A;
	Mon, 19 May 2025 13:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vN734swt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777941A83E5
	for <stable@vger.kernel.org>; Mon, 19 May 2025 13:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747660813; cv=none; b=CVEqbXBCp9z3KYM0lvsIIvLQaPSkSCY9jlu8cEG8TVg+gz0u66LREshrXFaytZyCodR6PXG9+vn3P0zhnuM7uoa3d0gKuzAkaeaTc5W3xa+eOFx1brTYkbk0a6/guiS9ypaTjIEgPqR3RyHy3ZJKpFxgGbNQu5DcJFp/m2Bj6EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747660813; c=relaxed/simple;
	bh=B1viVRd1CXCjAXTU/StSpau2Yjhl5ELBlwCldR+WHK4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FxK5H2atZVwdURK4+tK5TxPJrswvBH0i/nXnKKPzQfoopp8QKlOUF/VzaKhbzbNz2GUhvcXJwDEgPF7q19BtvG9BvbMfoCqlAFJ95FO1WIskMYNfyn3VGBuFt4eAplB4orOcmPCkpAiCTErLfRu169C9pv3OiM64mu8lAxOQFgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vN734swt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A23C4CEE4;
	Mon, 19 May 2025 13:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747660812;
	bh=B1viVRd1CXCjAXTU/StSpau2Yjhl5ELBlwCldR+WHK4=;
	h=Subject:To:Cc:From:Date:From;
	b=vN734swtXq4GEFmZC0S1gQ8guTee+N8lWG+5DPdaQ/yjzkZ6borVnoLc3bdcvcrqA
	 eUQa4U7MwjedVclj06zkKEoHJpcGxTv/iJJViZxhTYq+iMVKLTdvQKjen+GllJu1aG
	 DuWIEJVET6Ms8yfW9JzciSSG+GV34AjLpU6zjTms=
Subject: FAILED: patch "[PATCH] dmaengine: mediatek: Fix a possible deadlock error in" failed to apply to 5.10-stable tree
To: chenqiuji666@gmail.com,angelogioacchino.delregno@collabora.com,vkoul@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 May 2025 15:20:09 +0200
Message-ID: <2025051909-laziness-boss-78ae@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 157ae5ffd76a2857ccb4b7ce40bc5a344ca00395
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051909-laziness-boss-78ae@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 157ae5ffd76a2857ccb4b7ce40bc5a344ca00395 Mon Sep 17 00:00:00 2001
From: Qiu-ji Chen <chenqiuji666@gmail.com>
Date: Thu, 8 May 2025 15:36:33 +0800
Subject: [PATCH] dmaengine: mediatek: Fix a possible deadlock error in
 mtk_cqdma_tx_status()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix a potential deadlock bug. Observe that in the mtk-cqdma.c
file, functions like mtk_cqdma_issue_pending() and
mtk_cqdma_free_active_desc() properly acquire the pc lock before the vc
lock when handling pc and vc fields. However, mtk_cqdma_tx_status()
violates this order by first acquiring the vc lock before invoking
mtk_cqdma_find_active_desc(), which subsequently takes the pc lock. This
reversed locking sequence (vc → pc) contradicts the established
pc → vc order and creates deadlock risks.

Fix the issue by moving the vc lock acquisition code from
mtk_cqdma_find_active_desc() to mtk_cqdma_tx_status(). Ensure the pc lock
is acquired before the vc lock in the calling function to maintain correct
locking hierarchy. Note that since mtk_cqdma_find_active_desc() is a
static function with only one caller (mtk_cqdma_tx_status()), this
modification safely eliminates the deadlock possibility without affecting
other components.

This possible bug is found by an experimental static analysis tool
developed by our team. This tool analyzes the locking APIs to extract
function pairs that can be concurrently executed, and then analyzes the
instructions in the paired functions to identify possible concurrency bugs
including deadlocks, data races and atomicity violations.

Fixes: b1f01e48df5a ("dmaengine: mediatek: Add MediaTek Command-Queue DMA controller for MT6765 SoC")
Cc: stable@vger.kernel.org
Signed-off-by: Qiu-ji Chen <chenqiuji666@gmail.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://lore.kernel.org/r/20250508073634.3719-1-chenqiuji666@gmail.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>

diff --git a/drivers/dma/mediatek/mtk-cqdma.c b/drivers/dma/mediatek/mtk-cqdma.c
index d5ddb4e30e71..e35271ac1eed 100644
--- a/drivers/dma/mediatek/mtk-cqdma.c
+++ b/drivers/dma/mediatek/mtk-cqdma.c
@@ -422,13 +422,10 @@ static struct virt_dma_desc *mtk_cqdma_find_active_desc(struct dma_chan *c,
 	struct virt_dma_desc *vd;
 	unsigned long flags;
 
-	spin_lock_irqsave(&cvc->pc->lock, flags);
 	list_for_each_entry(vd, &cvc->pc->queue, node)
 		if (vd->tx.cookie == cookie) {
-			spin_unlock_irqrestore(&cvc->pc->lock, flags);
 			return vd;
 		}
-	spin_unlock_irqrestore(&cvc->pc->lock, flags);
 
 	list_for_each_entry(vd, &cvc->vc.desc_issued, node)
 		if (vd->tx.cookie == cookie)
@@ -452,9 +449,11 @@ static enum dma_status mtk_cqdma_tx_status(struct dma_chan *c,
 	if (ret == DMA_COMPLETE || !txstate)
 		return ret;
 
+	spin_lock_irqsave(&cvc->pc->lock, flags);
 	spin_lock_irqsave(&cvc->vc.lock, flags);
 	vd = mtk_cqdma_find_active_desc(c, cookie);
 	spin_unlock_irqrestore(&cvc->vc.lock, flags);
+	spin_unlock_irqrestore(&cvc->pc->lock, flags);
 
 	if (vd) {
 		cvd = to_cqdma_vdesc(vd);


