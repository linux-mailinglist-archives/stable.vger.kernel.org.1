Return-Path: <stable+bounces-65712-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8772A94AB8E
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 17:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7DE51C21B92
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 15:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B247078291;
	Wed,  7 Aug 2024 15:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0cd5uL9R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC297D3E4;
	Wed,  7 Aug 2024 15:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723043205; cv=none; b=bUPC7sFwCPU0pQ7eTksjzNbyQGBrjZgevZo78haLcFaS1lU0zAldqEniWPZR8seKHoliobHAcIq6Tg5+lyHcEq0rhwNvSuXrITRgFxMaxGHvU7g6lm4JwjRCpzQZDRK04J2ABdR+5qhh27KYcftDIc2/UTQCF84ps8sX2COgANQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723043205; c=relaxed/simple;
	bh=q+tLKqN6a5RMQuktnkRSC6mUO5lGbfcLixXPW/UW1is=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T+UH9t6a9FPXUpzJowDrQjmPG4VWT9G3Boe4VSmDkoZ5SsJXGjVmouCI5grgIB7v5RePApmHlgfw4WQdXhqPZwf1Kht+Os+f/sI6O3TrEjtMzyDzn0DP/rnA5wwzdoCREFQI5ulL1s+wPFK71VQT69oXgbLVw74KK4ZoiChSl5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0cd5uL9R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B56B7C32781;
	Wed,  7 Aug 2024 15:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723043205;
	bh=q+tLKqN6a5RMQuktnkRSC6mUO5lGbfcLixXPW/UW1is=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0cd5uL9RXxhS78WnpalB3fRVag3dZwgpJbhwBM6Y7nkIrzhbXizFFzyNCejbL2aSP
	 GnQz5Q63Xdp3wAx1+66OOPkTGryx+YVtVMorUUisAySK3ERSPHNrNL69MavbqOAKIn
	 jLYY+mZs732R69vzFNPSE56bFEbLhsVDWCaIm0tI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Herve Codina <herve.codina@bootlin.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.10 110/123] net: wan: fsl_qmc_hdlc: Discard received CRC
Date: Wed,  7 Aug 2024 17:00:29 +0200
Message-ID: <20240807150024.427982423@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240807150020.790615758@linuxfoundation.org>
References: <20240807150020.790615758@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Herve Codina <herve.codina@bootlin.com>

commit e549360069b4a57e111b8222fc072f3c7c1688ab upstream.

Received frame from QMC contains the CRC.
Upper layers don't need this CRC and tcpdump mentioned trailing junk
data due to this CRC presence.

As some other HDLC driver, simply discard this CRC.

Fixes: d0f2258e79fd ("net: wan: Add support for QMC HDLC")
Cc: stable@vger.kernel.org
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20240730063133.179598-1-herve.codina@bootlin.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wan/fsl_qmc_hdlc.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wan/fsl_qmc_hdlc.c b/drivers/net/wan/fsl_qmc_hdlc.c
index 64b4bfa6fea7..8fcfbde31a1c 100644
--- a/drivers/net/wan/fsl_qmc_hdlc.c
+++ b/drivers/net/wan/fsl_qmc_hdlc.c
@@ -250,6 +250,7 @@ static void qmc_hcld_recv_complete(void *context, size_t length, unsigned int fl
 	struct qmc_hdlc_desc *desc = context;
 	struct net_device *netdev;
 	struct qmc_hdlc *qmc_hdlc;
+	size_t crc_size;
 	int ret;
 
 	netdev = desc->netdev;
@@ -268,15 +269,26 @@ static void qmc_hcld_recv_complete(void *context, size_t length, unsigned int fl
 		if (flags & QMC_RX_FLAG_HDLC_CRC) /* CRC error */
 			netdev->stats.rx_crc_errors++;
 		kfree_skb(desc->skb);
-	} else {
-		netdev->stats.rx_packets++;
-		netdev->stats.rx_bytes += length;
-
-		skb_put(desc->skb, length);
-		desc->skb->protocol = hdlc_type_trans(desc->skb, netdev);
-		netif_rx(desc->skb);
+		goto re_queue;
 	}
 
+	/* Discard the CRC */
+	crc_size = qmc_hdlc->is_crc32 ? 4 : 2;
+	if (length < crc_size) {
+		netdev->stats.rx_length_errors++;
+		kfree_skb(desc->skb);
+		goto re_queue;
+	}
+	length -= crc_size;
+
+	netdev->stats.rx_packets++;
+	netdev->stats.rx_bytes += length;
+
+	skb_put(desc->skb, length);
+	desc->skb->protocol = hdlc_type_trans(desc->skb, netdev);
+	netif_rx(desc->skb);
+
+re_queue:
 	/* Re-queue a transfer using the same descriptor */
 	ret = qmc_hdlc_recv_queue(qmc_hdlc, desc, desc->dma_size);
 	if (ret) {
-- 
2.46.0




