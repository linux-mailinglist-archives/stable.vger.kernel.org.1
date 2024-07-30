Return-Path: <stable+bounces-62636-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB6794086A
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 08:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7C8B1F23E28
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 06:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D4D16B3B7;
	Tue, 30 Jul 2024 06:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LDnWj7h+"
X-Original-To: stable@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EAD168481;
	Tue, 30 Jul 2024 06:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722321113; cv=none; b=W52wNMkRd497sLBQv5EUcAJXG9nMAI+E2mQ0u38BMvhk8noGNkaRegL90Bd3S1/T1VMJent4JnReAUT1XTZGKLEIX1pf4pYjrhr4y0sicj43bP684mzWJJlaaxJO1QFbox5ACpZqblt62qXIL0/DvsFm6iFiy5lw9noKkwhWBNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722321113; c=relaxed/simple;
	bh=OIdwXythHkoNdaeB3ZeMXCUAjEHgdqGq79Stvjbip4s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xosd3gT55ZisRgfWS3fhJj89wafcKa6bLS+uDh3cjaoedEY0uLag5QneneWnTpfakEZJSW19mShnYQqyO0CG9Ik+nujEyUibTmtelVDcSS1mR/XRp4lHXXDufg8SxhFsJdxlUvPi5lV0lfQYt0PLLLLouhaVGFWmL87WwqnN70U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LDnWj7h+; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 4AD18C0005;
	Tue, 30 Jul 2024 06:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722321103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9oaw32SfWoWdpOCGj4cbaO4s/PkPuA9eMA+JWXWEy20=;
	b=LDnWj7h+3M0k/9trK9YpfYCOEPHFvG5dja4cagBcM68icJxeMArucrSTXuRXUu2x5EBApk
	XYznIeIRVt5GEhCaJZbSdQu0LC0UBvB9joWLdCZzYGvZG/NeKH0zfSYhIu9C0LVVomGPiK
	NKMBbrz3Gma55Rsg4hmWOQ7rK9qyldAbOtp2pcgzrH2nfuUIE+BD98Qg6EimV66//LI1qi
	s+0PWtfdRNw8+j6NQEHn5HPWv95n1OP8LbA05pIrlT8eiftPJIOE7xQfRfyWJeRZHZ5gyv
	s+lQUjGjSeqA+CgY8MLkbeqSiho8jPGwPTOavjGlC1cb/wQoybCxYCGjDEkmHg==
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	stable@vger.kernel.org
Subject: [PATCH net v1] net: wan: fsl_qmc_hdlc: Discard received CRC
Date: Tue, 30 Jul 2024 08:31:33 +0200
Message-ID: <20240730063133.179598-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Received frame from QMC contains the CRC.
Upper layers don't need this CRC and tcpdump mentioned trailing junk
data due to this CRC presence.

As some other HDLC driver, simply discard this CRC.

Fixes: d0f2258e79fd ("net: wan: Add support for QMC HDLC")
Cc: stable@vger.kernel.org
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/net/wan/fsl_qmc_hdlc.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

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
+		goto re_queue;
+	}
 
-		skb_put(desc->skb, length);
-		desc->skb->protocol = hdlc_type_trans(desc->skb, netdev);
-		netif_rx(desc->skb);
+	/* Discard the CRC */
+	crc_size = qmc_hdlc->is_crc32 ? 4 : 2;
+	if (length < crc_size) {
+		netdev->stats.rx_length_errors++;
+		kfree_skb(desc->skb);
+		goto re_queue;
 	}
+	length -= crc_size;
+
+	netdev->stats.rx_packets++;
+	netdev->stats.rx_bytes += length;
+
+	skb_put(desc->skb, length);
+	desc->skb->protocol = hdlc_type_trans(desc->skb, netdev);
+	netif_rx(desc->skb);
 
+re_queue:
 	/* Re-queue a transfer using the same descriptor */
 	ret = qmc_hdlc_recv_queue(qmc_hdlc, desc, desc->dma_size);
 	if (ret) {
-- 
2.45.0


