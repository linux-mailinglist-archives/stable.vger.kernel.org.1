Return-Path: <stable+bounces-85437-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 422CD99E751
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 13:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06FD7286082
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 11:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9961D90CD;
	Tue, 15 Oct 2024 11:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lVhTRk3E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C4D1CFEA9;
	Tue, 15 Oct 2024 11:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728993112; cv=none; b=Nk6dhlh2gNoh8eQcvWTtPH/vgmcPR3dYRsqn4WZc77fMgvR3PPO9xNNhQ59X6kLhD9psmvX6o99nejpJ3Y2mWYI5BG4LE4kxwazTdjuDy83sAiLgu6EH8fdDLw5ElolEoFOx/7fJxf3MTauGrB6q0FVMU/mvit4WBiEJSXUGbws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728993112; c=relaxed/simple;
	bh=QtzKvz7A/8LM8fplXf9ABPAPxdQhk7SN0FFBMfokcJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A+x3GGfOwI6o8eQiXCMD+dzZN2IkWUDtx4DxJT5Rb86AwWYnOZau/txlkJIMonh9R300+z05BQNXF4YPrZfdlma/m2OTOoQBHoNldpPrvGsSBFifHjLBTuPI9PQ6dBcBFwLOUd2VUIAMbc+bacu7Skmsz6xJJAXa6Yyp/LWCju4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lVhTRk3E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D84DDC4CED0;
	Tue, 15 Oct 2024 11:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728993112;
	bh=QtzKvz7A/8LM8fplXf9ABPAPxdQhk7SN0FFBMfokcJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lVhTRk3EEj1I86aXKBxwJHnYCRejHT7jY+nH/x0ynrsCH9dKNRXvUZ9xulYMcuezR
	 58B28FKXZmrnhjfvbLgSuNmRY5kGuOhZMM/9c8F1VLnqfgTIenIjo4NUi6igeizYGd
	 71hHjMbH38L5teNQJ/WFTCzq4wdQksZfJMywY27k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Robert Hancock <robert.hancock@calian.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 283/691] net: axienet: dont set IRQ timer when IRQ delay not used
Date: Tue, 15 Oct 2024 13:23:51 +0200
Message-ID: <20241015112451.576215467@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015112440.309539031@linuxfoundation.org>
References: <20241015112440.309539031@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Robert Hancock <robert.hancock@calian.com>

[ Upstream commit 0155ae6eb84dbeecb7199a2fd9dee72e046ac875 ]

When the RX or TX coalesce count is set to 1, there's no point in
setting the delay timer value since an interrupt will already be raised
on every packet, and the delay interrupt just causes extra pointless
interrupts.

Signed-off-by: Robert Hancock <robert.hancock@calian.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 5a6caa2cfabb ("net: xilinx: axienet: Fix packet counting")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/xilinx/xilinx_axienet_main.c  | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 25b5054ad3e9b..7bb8d04c997e7 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -236,14 +236,24 @@ static void axienet_dma_start(struct axienet_local *lp)
 
 	/* Start updating the Rx channel control register */
 	rx_cr = (lp->coalesce_count_rx << XAXIDMA_COALESCE_SHIFT) |
-		(XAXIDMA_DFT_RX_WAITBOUND << XAXIDMA_DELAY_SHIFT) |
-		XAXIDMA_IRQ_ALL_MASK;
+		XAXIDMA_IRQ_IOC_MASK | XAXIDMA_IRQ_ERROR_MASK;
+	/* Only set interrupt delay timer if not generating an interrupt on
+	 * the first RX packet. Otherwise leave at 0 to disable delay interrupt.
+	 */
+	if (lp->coalesce_count_rx > 1)
+		rx_cr |= (XAXIDMA_DFT_RX_WAITBOUND << XAXIDMA_DELAY_SHIFT) |
+			 XAXIDMA_IRQ_DELAY_MASK;
 	axienet_dma_out32(lp, XAXIDMA_RX_CR_OFFSET, rx_cr);
 
 	/* Start updating the Tx channel control register */
 	tx_cr = (lp->coalesce_count_tx << XAXIDMA_COALESCE_SHIFT) |
-		(XAXIDMA_DFT_TX_WAITBOUND << XAXIDMA_DELAY_SHIFT) |
-		XAXIDMA_IRQ_ALL_MASK;
+		XAXIDMA_IRQ_IOC_MASK | XAXIDMA_IRQ_ERROR_MASK;
+	/* Only set interrupt delay timer if not generating an interrupt on
+	 * the first TX packet. Otherwise leave at 0 to disable delay interrupt.
+	 */
+	if (lp->coalesce_count_tx > 1)
+		tx_cr |= (XAXIDMA_DFT_TX_WAITBOUND << XAXIDMA_DELAY_SHIFT) |
+			 XAXIDMA_IRQ_DELAY_MASK;
 	axienet_dma_out32(lp, XAXIDMA_TX_CR_OFFSET, tx_cr);
 
 	/* Populate the tail pointer and bring the Rx Axi DMA engine out of
-- 
2.43.0




