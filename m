Return-Path: <stable+bounces-26339-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47485870E22
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 22:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCBE7B24E6D
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 21:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9507BB08;
	Mon,  4 Mar 2024 21:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mw9b4PeV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4382211193;
	Mon,  4 Mar 2024 21:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709588466; cv=none; b=f062XagDWT03eIwppbMqLrd7RxmUn54RwpzJxOEmL1YFrBO0aLrDMK9Z9Bfvs8CaStOO7rgQYGmHqDbj82KE8hz5gyTDrpqhVT75o79ZjxiOttp2GhpxUtI2LCsyVoD8t5QZSFevWMgde3Lmerp/17Iv1BCcD52xoJFEG9+R1SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709588466; c=relaxed/simple;
	bh=dXH7xTM0+YlebJHtdKYlmmRcwvSp417lxRG5kxnv6co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LaOtjEd0NbRN1v1zqkz5iq+VU6avMjnN4A7ypZ1IgwwAusAd4/EZLqZaNoWMYmu7bXaSMDh4luRqGWr0xha2S+kIZ3RYgEkAdS7jcdxl8mk1Nd1jI2wWK0AHi5G/6wq7ijV2Z1I/7VKCvFxQchVDecJf4+GxeI9ilEzXy1u8gag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mw9b4PeV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C93DCC433F1;
	Mon,  4 Mar 2024 21:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709588466;
	bh=dXH7xTM0+YlebJHtdKYlmmRcwvSp417lxRG5kxnv6co=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mw9b4PeVblr44Jwi8Kx3oB1M0K6MzNv9aDFto1nxo1yGv/4EfJPQ2hzWh5pREjzdb
	 +tir2c60l364/aAzY13OXcfFOXLB2mPhQJ9QU5xM02qZ/d2pHOFCusWio+NIo/sLGw
	 WZfAPiO36o+U+64vJ/WkuA1wUogjlmCfC4r93sdo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 118/143] dmaengine: dw-edma: Fix the ch_count hdma callback
Date: Mon,  4 Mar 2024 21:23:58 +0000
Message-ID: <20240304211553.691538280@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304211549.876981797@linuxfoundation.org>
References: <20240304211549.876981797@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kory Maincent <kory.maincent@bootlin.com>

[ Upstream commit cd665bfc757c71e9b7e0abff0f362d8abd38a805 ]

The current check of ch_en enabled to know the maximum number of available
hardware channels is wrong as it check the number of ch_en register set
but all of them are unset at probe. This register is set at the
dw_hdma_v0_core_start function which is run lately before a DMA transfer.

The HDMA IP have no way to know the number of hardware channels available
like the eDMA IP, then let set it to maximum channels and let the platform
set the right number of channels.

Fixes: e74c39573d35 ("dmaengine: dw-edma: Add support for native HDMA")
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
Link: https://lore.kernel.org/r/20240129-b4-feature_hdma_mainline-v7-1-8e8c1acb7a46@bootlin.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 00b735a0202ab..1f4cb7db54756 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -65,18 +65,12 @@ static void dw_hdma_v0_core_off(struct dw_edma *dw)
 
 static u16 dw_hdma_v0_core_ch_count(struct dw_edma *dw, enum dw_edma_dir dir)
 {
-	u32 num_ch = 0;
-	int id;
-
-	for (id = 0; id < HDMA_V0_MAX_NR_CH; id++) {
-		if (GET_CH_32(dw, id, dir, ch_en) & BIT(0))
-			num_ch++;
-	}
-
-	if (num_ch > HDMA_V0_MAX_NR_CH)
-		num_ch = HDMA_V0_MAX_NR_CH;
-
-	return (u16)num_ch;
+	/*
+	 * The HDMA IP have no way to know the number of hardware channels
+	 * available, we set it to maximum channels and let the platform
+	 * set the right number of channels.
+	 */
+	return HDMA_V0_MAX_NR_CH;
 }
 
 static enum dma_status dw_hdma_v0_core_ch_status(struct dw_edma_chan *chan)
-- 
2.43.0




