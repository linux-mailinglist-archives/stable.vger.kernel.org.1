Return-Path: <stable+bounces-178144-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB3AB47D6E
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 22:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10D1D7B02E2
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 20:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915DF22F74D;
	Sun,  7 Sep 2025 20:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uBSTFZ4+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCD41CDFAC;
	Sun,  7 Sep 2025 20:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757275905; cv=none; b=h0Gz6UidzaxgJCCmripammzmeIGWFcGLvusEKGH14+M6tWjFCtFd3Uvzn/bA1K8EJrEN9IN0EwVI6pnkwxWKXay4W8rJV3U5s5OU2ZJ2BTAIM6nzP7qMabqmbcroMwKoNef0kMkFMBOaV0jRbZNBDNxVOh8/3tQgLYhwlFtjduU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757275905; c=relaxed/simple;
	bh=Ub7SjvMiGQhmmN/HiKerd4NHrpiPO6smrtaa/DpUMr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HZjAOrxlstJGc2u0cFfC6Fca61Vzlmo+UY4fXw1TZ2P/zODr3lvsuzzd1dVyTl5feYTkKluaVvmF+EWulWmFuUHLbZ2QcjWuc0HVeE8zBuXaHYIu+gV71P5Z4vuOMKwro3l+oUKzIBNyKIw5b3+V++X8DrZedeeQqCOQGP5mUpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uBSTFZ4+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B9BC4CEF0;
	Sun,  7 Sep 2025 20:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757275905;
	bh=Ub7SjvMiGQhmmN/HiKerd4NHrpiPO6smrtaa/DpUMr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uBSTFZ4+klKALODGCtRA5F2Bw0/xYMryIKFVEIydcYT+KxMs3EWd0WHxx2P+hvc4H
	 OHJS0Pq5Yv34od1nICU4N0QO2iHlRybUCeM7+V+8jMyKo8I/Lwbop2Nq6VZkNXLv9p
	 M07zh95Tj688RRS8dUrudxabxW/v/dHLKOo2ZXFc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Qiu-ji Chen <chenqiuji666@gmail.com>,
	Eugen Hristev <eugen.hristev@linaro.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 45/45] dmaengine: mediatek: Fix a flag reuse error in mtk_cqdma_tx_status()
Date: Sun,  7 Sep 2025 21:58:31 +0200
Message-ID: <20250907195602.317058327@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250907195600.953058118@linuxfoundation.org>
References: <20250907195600.953058118@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qiu-ji Chen <chenqiuji666@gmail.com>

[ Upstream commit 8eba2187391e5ab49940cd02d6bd45a5617f4daf ]

Fixed a flag reuse bug in the mtk_cqdma_tx_status() function.

Fixes: 157ae5ffd76a ("dmaengine: mediatek: Fix a possible deadlock error in mtk_cqdma_tx_status()")
Cc: stable@vger.kernel.org
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202505270641.MStzJUfU-lkp@intel.com/
Signed-off-by: Qiu-ji Chen <chenqiuji666@gmail.com>
Reviewed-by: Eugen Hristev <eugen.hristev@linaro.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://lore.kernel.org/r/20250606090017.5436-1-chenqiuji666@gmail.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/mediatek/mtk-cqdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/mediatek/mtk-cqdma.c b/drivers/dma/mediatek/mtk-cqdma.c
index 11ec5734a816e..175b27b66b045 100644
--- a/drivers/dma/mediatek/mtk-cqdma.c
+++ b/drivers/dma/mediatek/mtk-cqdma.c
@@ -450,9 +450,9 @@ static enum dma_status mtk_cqdma_tx_status(struct dma_chan *c,
 		return ret;
 
 	spin_lock_irqsave(&cvc->pc->lock, flags);
-	spin_lock_irqsave(&cvc->vc.lock, flags);
+	spin_lock(&cvc->vc.lock);
 	vd = mtk_cqdma_find_active_desc(c, cookie);
-	spin_unlock_irqrestore(&cvc->vc.lock, flags);
+	spin_unlock(&cvc->vc.lock);
 	spin_unlock_irqrestore(&cvc->pc->lock, flags);
 
 	if (vd) {
-- 
2.51.0




