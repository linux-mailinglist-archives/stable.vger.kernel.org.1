Return-Path: <stable+bounces-173910-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C13AB3606C
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E57F37C0EF2
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 12:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEA51A9FB0;
	Tue, 26 Aug 2025 12:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MsfszPGf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDAC17A303;
	Tue, 26 Aug 2025 12:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756212988; cv=none; b=GW4oTNv0IV9MKu7ef95SZhv4vlwh1EiScoqXvK0upFTv9ZTDb8HTbi3bh4oeNOoPohBfIgahBw0VGE9WolPZnpmUK1GJPljXiyi7JUrlbBNVB8lmVQWOLwNDzXBQOsiTL/S6MM1HWOSBCOHEQyskh8dvPo0aYKBX0Rpn4TC2VPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756212988; c=relaxed/simple;
	bh=bTZ61wKlUGNHGOESzQOpidMPztcw13kqaQULYXSje/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J+VxhXoeJ9lyTlQdacKSpnNcVmwPBoKtgNSA0brUfzJQvAxPWaT7cQJFQABTaoxw9qP+YEa3FpjCYuPYB/t4mqE81c0B5vvK8QezIKAUsav7Jy9Q8Ao6yOffRJvf8L6DlzBw4paEv1bGtglSsgsa2oHEmnoX/95ccpJgVGhl+dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MsfszPGf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98FBEC4CEF1;
	Tue, 26 Aug 2025 12:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756212988;
	bh=bTZ61wKlUGNHGOESzQOpidMPztcw13kqaQULYXSje/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MsfszPGfnBLwNAD/bCl4qJE/KAU6knOcuVj2vNG1u79BHwOMTvyUy/ScxZMrrZAHL
	 U9/3KvW91GOPyVB9BaiuJ4aZ4SgxemEnQ6nwB4F0UEf1GKxgVyyIVY9KZfNCNTJkx8
	 mB7YDCnVM0KlXpwoFZqK5yAgsbMbRXYEw6145H8I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jonas Rebmann <jre@pengutronix.de>,
	Wei Fang <wei.fang@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 178/587] net: fec: allow disable coalescing
Date: Tue, 26 Aug 2025 13:05:27 +0200
Message-ID: <20250826110957.470857139@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110952.942403671@linuxfoundation.org>
References: <20250826110952.942403671@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jonas Rebmann <jre@pengutronix.de>

[ Upstream commit b7ad21258f9e9a7f58b19595d5ceed2cde3bed68 ]

In the current implementation, IP coalescing is always enabled and
cannot be disabled.

As setting maximum frames to 0 or 1, or setting delay to zero implies
immediate delivery of single packets/IRQs, disable coalescing in
hardware in these cases.

This also guarantees that coalescing is never enabled with ICFT or ICTT
set to zero, a configuration that could lead to unpredictable behaviour
according to i.MX8MP reference manual.

Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
Reviewed-by: Wei Fang <wei.fang@nxp.com>
Link: https://patch.msgid.link/20250626-fec_deactivate_coalescing-v2-1-0b217f2e80da@pengutronix.de
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/fec_main.c | 34 +++++++++++------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 291c88a76a27..2a8b5429df59 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3069,27 +3069,25 @@ static int fec_enet_us_to_itr_clock(struct net_device *ndev, int us)
 static void fec_enet_itr_coal_set(struct net_device *ndev)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
-	int rx_itr, tx_itr;
+	u32 rx_itr = 0, tx_itr = 0;
+	int rx_ictt, tx_ictt;
 
-	/* Must be greater than zero to avoid unpredictable behavior */
-	if (!fep->rx_time_itr || !fep->rx_pkts_itr ||
-	    !fep->tx_time_itr || !fep->tx_pkts_itr)
-		return;
-
-	/* Select enet system clock as Interrupt Coalescing
-	 * timer Clock Source
-	 */
-	rx_itr = FEC_ITR_CLK_SEL;
-	tx_itr = FEC_ITR_CLK_SEL;
+	rx_ictt = fec_enet_us_to_itr_clock(ndev, fep->rx_time_itr);
+	tx_ictt = fec_enet_us_to_itr_clock(ndev, fep->tx_time_itr);
 
-	/* set ICFT and ICTT */
-	rx_itr |= FEC_ITR_ICFT(fep->rx_pkts_itr);
-	rx_itr |= FEC_ITR_ICTT(fec_enet_us_to_itr_clock(ndev, fep->rx_time_itr));
-	tx_itr |= FEC_ITR_ICFT(fep->tx_pkts_itr);
-	tx_itr |= FEC_ITR_ICTT(fec_enet_us_to_itr_clock(ndev, fep->tx_time_itr));
+	if (rx_ictt > 0 && fep->rx_pkts_itr > 1) {
+		/* Enable with enet system clock as Interrupt Coalescing timer Clock Source */
+		rx_itr = FEC_ITR_EN | FEC_ITR_CLK_SEL;
+		rx_itr |= FEC_ITR_ICFT(fep->rx_pkts_itr);
+		rx_itr |= FEC_ITR_ICTT(rx_ictt);
+	}
 
-	rx_itr |= FEC_ITR_EN;
-	tx_itr |= FEC_ITR_EN;
+	if (tx_ictt > 0 && fep->tx_pkts_itr > 1) {
+		/* Enable with enet system clock as Interrupt Coalescing timer Clock Source */
+		tx_itr = FEC_ITR_EN | FEC_ITR_CLK_SEL;
+		tx_itr |= FEC_ITR_ICFT(fep->tx_pkts_itr);
+		tx_itr |= FEC_ITR_ICTT(tx_ictt);
+	}
 
 	writel(tx_itr, fep->hwp + FEC_TXIC0);
 	writel(rx_itr, fep->hwp + FEC_RXIC0);
-- 
2.39.5




