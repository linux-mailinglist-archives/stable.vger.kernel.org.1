Return-Path: <stable+bounces-1202-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCD07F7E7F
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB5F228231B
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8642F86B;
	Fri, 24 Nov 2023 18:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TnBEciaU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1DD39FCC;
	Fri, 24 Nov 2023 18:33:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C380C433C7;
	Fri, 24 Nov 2023 18:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700850812;
	bh=W+QQSf8uThFchLSKZSDAWZ0U0YX3f0aMaaMoVvBkQ7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TnBEciaUd3MrtjAfDullKMsbq2E5cBIlu5XVGolKu1GSJmzm8ys0x8bBykJRdWU7J
	 MxAJoxvzBWrj4Bm8R1IfCMmjc71rjFTFkay3QBT2W06/dSDafoCQWUT/OlOrwfZVJT
	 aHd8TH1hJulVPoNJtfeeAcpLDifdeY9TiCZKQ1fQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Baruch Siach <baruch@tkos.co.il>,
	Serge Semin <fancer.lancer@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 199/491] net: stmmac: avoid rx queue overrun
Date: Fri, 24 Nov 2023 17:47:15 +0000
Message-ID: <20231124172030.482283939@linuxfoundation.org>
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

From: Baruch Siach <baruch@tkos.co.il>

[ Upstream commit b6cb4541853c7ee512111b0e7ddf3cb66c99c137 ]

dma_rx_size can be set as low as 64. Rx budget might be higher than
that. Make sure to not overrun allocated rx buffers when budget is
larger.

Leave one descriptor unused to avoid wrap around of 'dirty_rx' vs
'cur_rx'.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Fixes: 47dd7a540b8a ("net: add support for STMicroelectronics Ethernet controllers.")
Link: https://lore.kernel.org/r/d95413e44c97d4692e72cec13a75f894abeb6998.1699897370.git.baruch@tkos.co.il
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 7f9b02bb22a30..86ff015fba354 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5223,6 +5223,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 
 	dma_dir = page_pool_get_dma_dir(rx_q->page_pool);
 	buf_sz = DIV_ROUND_UP(priv->dma_conf.dma_buf_sz, PAGE_SIZE) * PAGE_SIZE;
+	limit = min(priv->dma_conf.dma_rx_size - 1, (unsigned int)limit);
 
 	if (netif_msg_rx_status(priv)) {
 		void *rx_head;
-- 
2.42.0




