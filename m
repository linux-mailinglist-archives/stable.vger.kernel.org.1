Return-Path: <stable+bounces-1351-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D3B7F7F3A
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A0401C21442
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD5F37170;
	Fri, 24 Nov 2023 18:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lkCYHznE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FEC2D626;
	Fri, 24 Nov 2023 18:39:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C43C433C8;
	Fri, 24 Nov 2023 18:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700851184;
	bh=CcYG9MN9FDu8WnpezJf1m9fdkmZIlFT+KjTFx0EWyxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lkCYHznEzGObjPgB0khvSpAsLJjhL7mW3FOVJ8ydeMaj/kjQ79KXt9kOe5laPm/Vt
	 ltAU4i+tJnBzrpeBM4ZTEo8rEFk++u3i0vwUo/3dOld8DIJe3kymAuRSsRZCElpx47
	 T48jFf+fJdpdgmN4KaHMCKHYFnEP23orUKPmYFXQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alain Volmat <alain.volmat@foss.st.com>,
	Amelie Delaunay <amelie.delaunay@foss.st.com>,
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 6.5 346/491] dmaengine: stm32-mdma: correct desc prep when channel running
Date: Fri, 24 Nov 2023 17:49:42 +0000
Message-ID: <20231124172034.961769545@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172024.664207345@linuxfoundation.org>
References: <20231124172024.664207345@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alain Volmat <alain.volmat@foss.st.com>

commit 03f25d53b145bc2f7ccc82fc04e4482ed734f524 upstream.

In case of the prep descriptor while the channel is already running, the
CCR register value stored into the channel could already have its EN bit
set.  This would lead to a bad transfer since, at start transfer time,
enabling the channel while other registers aren't yet properly set.
To avoid this, ensure to mask the CCR_EN bit when storing the ccr value
into the mdma channel structure.

Fixes: a4ffb13c8946 ("dmaengine: Add STM32 MDMA driver")
Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc: stable@vger.kernel.org
Tested-by: Alain Volmat <alain.volmat@foss.st.com>
Link: https://lore.kernel.org/r/20231009082450.452877-1-amelie.delaunay@foss.st.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/stm32-mdma.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/dma/stm32-mdma.c
+++ b/drivers/dma/stm32-mdma.c
@@ -490,7 +490,7 @@ static int stm32_mdma_set_xfer_param(str
 	src_maxburst = chan->dma_config.src_maxburst;
 	dst_maxburst = chan->dma_config.dst_maxburst;
 
-	ccr = stm32_mdma_read(dmadev, STM32_MDMA_CCR(chan->id));
+	ccr = stm32_mdma_read(dmadev, STM32_MDMA_CCR(chan->id)) & ~STM32_MDMA_CCR_EN;
 	ctcr = stm32_mdma_read(dmadev, STM32_MDMA_CTCR(chan->id));
 	ctbr = stm32_mdma_read(dmadev, STM32_MDMA_CTBR(chan->id));
 
@@ -966,7 +966,7 @@ stm32_mdma_prep_dma_memcpy(struct dma_ch
 	if (!desc)
 		return NULL;
 
-	ccr = stm32_mdma_read(dmadev, STM32_MDMA_CCR(chan->id));
+	ccr = stm32_mdma_read(dmadev, STM32_MDMA_CCR(chan->id)) & ~STM32_MDMA_CCR_EN;
 	ctcr = stm32_mdma_read(dmadev, STM32_MDMA_CTCR(chan->id));
 	ctbr = stm32_mdma_read(dmadev, STM32_MDMA_CTBR(chan->id));
 	cbndtr = stm32_mdma_read(dmadev, STM32_MDMA_CBNDTR(chan->id));



