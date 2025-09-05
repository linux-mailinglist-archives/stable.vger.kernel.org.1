Return-Path: <stable+bounces-177895-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54960B4648D
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 22:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F199F1C2548C
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 20:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A92826F46E;
	Fri,  5 Sep 2025 20:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="myJvJXCp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6E1220F3F
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 20:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757103738; cv=none; b=mxZ2IP92/ycGyV6aCEHhE0EFxiZHiG3U5Q4JlKRqo+IHISSnC2/8/nzRAgpbQy+HrZ/cCb8Kwxo9j8WqiovnFdmNUAZKL0qu+/08d+9dw7ZZ8k/UC+xrO1tvciEhaKaWjfbYIU7zlk3ZTdmpRyoq8VsUthUNaGzUUNYyqBB9oJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757103738; c=relaxed/simple;
	bh=umafBw7/v4WclsswRl8ByoMxfvWIT8JlXCOXhzROOCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FHrk/FkUGUe0LmI9IPrtsUTpP4aNudkEuJTluNVdYQ7RMAhrAbbzvfY3voFDbrzZqpNSF14R/A6+8Xhlxnmt4iw/ovPp38QVsp8LOsboapmJ2F4g1KvhaXkeSeipuHjyMqhtY8ZQ3cfGGtpO5krfbBTkcvmj1YkxT4yzAyPu9yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=myJvJXCp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A4CC4CEF1;
	Fri,  5 Sep 2025 20:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757103736;
	bh=umafBw7/v4WclsswRl8ByoMxfvWIT8JlXCOXhzROOCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=myJvJXCpqBN1okwjPu/PhD5++fLHxc3EEzXjOvTzS8Cy5W/pWIjxxZmPY02K56gwG
	 brbXG91g4zAXuIOl65mIT95KB9xqyhV8BWr9OgWBltZB9VYYlpxm7RlE/+x7fUdTK1
	 EcxiNUc8hORfl5CkQQKXKKB1HgElhdocrS7Hs73Bx80NMDmc4PLOsXUsmJDx6E4Mcg
	 omghcD5Ls9V04k78u1ZMK/SPXTPUHQSQc8VDajP7W5Hxkpc0HZGjyFB87XTceGWYqm
	 SfvihkT5xIFgC+5Abdsc2OsrYGTNr1kBNZPAEK9IdOGSmMyCO6D39cDEW2x5q+CrlF
	 swnoDR8cE9ttw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qiu-ji Chen <chenqiuji666@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] dmaengine: mediatek: Fix a possible deadlock error in mtk_cqdma_tx_status()
Date: Fri,  5 Sep 2025 16:22:14 -0400
Message-ID: <20250905202214.3400840-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025051903-impurity-frivolous-0b7e@gregkh>
References: <2025051903-impurity-frivolous-0b7e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Qiu-ji Chen <chenqiuji666@gmail.com>

[ Upstream commit 157ae5ffd76a2857ccb4b7ce40bc5a344ca00395 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/mediatek/mtk-cqdma.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/mediatek/mtk-cqdma.c b/drivers/dma/mediatek/mtk-cqdma.c
index 9ae92b8940efe..be0c5db57d9de 100644
--- a/drivers/dma/mediatek/mtk-cqdma.c
+++ b/drivers/dma/mediatek/mtk-cqdma.c
@@ -421,15 +421,11 @@ static struct virt_dma_desc *mtk_cqdma_find_active_desc(struct dma_chan *c,
 {
 	struct mtk_cqdma_vchan *cvc = to_cqdma_vchan(c);
 	struct virt_dma_desc *vd;
-	unsigned long flags;
 
-	spin_lock_irqsave(&cvc->pc->lock, flags);
 	list_for_each_entry(vd, &cvc->pc->queue, node)
 		if (vd->tx.cookie == cookie) {
-			spin_unlock_irqrestore(&cvc->pc->lock, flags);
 			return vd;
 		}
-	spin_unlock_irqrestore(&cvc->pc->lock, flags);
 
 	list_for_each_entry(vd, &cvc->vc.desc_issued, node)
 		if (vd->tx.cookie == cookie)
@@ -453,9 +449,11 @@ static enum dma_status mtk_cqdma_tx_status(struct dma_chan *c,
 	if (ret == DMA_COMPLETE || !txstate)
 		return ret;
 
+	spin_lock_irqsave(&cvc->pc->lock, flags);
 	spin_lock_irqsave(&cvc->vc.lock, flags);
 	vd = mtk_cqdma_find_active_desc(c, cookie);
 	spin_unlock_irqrestore(&cvc->vc.lock, flags);
+	spin_unlock_irqrestore(&cvc->pc->lock, flags);
 
 	if (vd) {
 		cvd = to_cqdma_vdesc(vd);
-- 
2.50.1


