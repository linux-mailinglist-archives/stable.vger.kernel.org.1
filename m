Return-Path: <stable+bounces-89719-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA16C9BBA83
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 17:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EA75B214CA
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 16:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4315E1C32E4;
	Mon,  4 Nov 2024 16:43:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53261C231D
	for <stable@vger.kernel.org>; Mon,  4 Nov 2024 16:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730738612; cv=none; b=G0ZlFOebSx/UQgzcSckxx3Y78+mIjhlMnl/+ZmIY+05BMMe9nubj+byZkOLz/VUdkzyp+wWPk2LMDzpzvfDbp6+/S7X176F1oPUcAEyRfsSRx5GewstE48nufl9ASk/5BfVTZQg/cPlmcG6nfyXGtb5twT6UZKxy08dAvzf3IPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730738612; c=relaxed/simple;
	bh=63xFusTRsY1L/nYoLVzTZYDCcu+dflkbrtHdaafc8Ow=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PpFopAsnx4ztjbtZ7LQJCjHva/RK+Vib6uBTURv8Z1XHzaoPkN2eS60YotfVWjRabXvNAzHbe1VFXToW2BoCZsRZ9m1n5VMmnW5AqKrL6djZlXrXf9pap+qXHQHklQ8WRr+Pc2L1PH8KxfbkwF1g6hPjVPH4MiSgxyBjnM/MxGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1t80Ao-0005Fk-6x
	for stable@vger.kernel.org; Mon, 04 Nov 2024 17:43:26 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1t80Ao-0020q2-02
	for stable@vger.kernel.org;
	Mon, 04 Nov 2024 17:43:26 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id B56E5367DFA
	for <stable@vger.kernel.org>; Mon, 04 Nov 2024 16:43:25 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 834B7367DF1;
	Mon, 04 Nov 2024 16:43:23 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id e44711e1;
	Mon, 4 Nov 2024 16:43:22 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 04 Nov 2024 17:42:40 +0100
Subject: [PATCH can v3] can: mcp251xfd: mcp251xfd_get_tef_len(): fix length
 calculation
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241104-mcp251xfd-fix-length-calculation-v3-1-608b6e7e2197@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAH/5KGcC/42Nyw6DIBBFf8WwLg1Q8dFV/6PpgseoJBYNILEx/
 nsnrpp04/LO3HvORiIEB5Hci40EyC66yWO4XQpiBuV7oM5iJoKJkjPG6dvMQvK1s7RzKx3B92m
 gRo1mGVXCMWWtrozhTIFmBDFzAGweiicxypMXHgcX0xQ+hzbz43XekDnlVLaNLivJGlvxx4ylJ
 YXJu/Vq4TBk8UMV8gRVIBWUtLquG91K9kfd9/0LHtUS8zABAAA=
X-Change-ID: 20241001-mcp251xfd-fix-length-calculation-09b6cc10aeb0
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Thomas Kopp <thomas.kopp@microchip.com>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 Sven Schuchmann <schuchmann@schleissheimer.de>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2880; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=63xFusTRsY1L/nYoLVzTZYDCcu+dflkbrtHdaafc8Ow=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBnKPmFN0MvQy+Sg3vSdfw3tywkkT9FJrkcQEQqe
 gWP0ISUzWeJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZyj5hQAKCRAoOKI+ei28
 b/aTB/4tiMmTguV9zreuyT/rwm10dGSiYkqN2vMEjs770WOwPNxh+zX+pYyqt1llpm+U367uovF
 59sgNZoY0x7CuT3xjrDOAuAyVB9ZsAf7rs+KgLPfu364rItSGUb+ByYWU3JwZKCfgc45MWtF6Xl
 b6o4+ZouLKt7QSRvwjL3N1OhZOxrbiGISx8sWgz6JYcCmIK6yxMr1bRU4kmP7Zw9vtxIw1kuj6k
 AVtwo9PjNtt66ZJcomC0rtRcLdMcQ7IPojctlSI9hyMHkt08agL/i9Zrvkfn7v4r8mM6aYLWNcG
 G2lQ7WeqcfzTeXaEFoRHJuJaxFTkLT1Im7GF9WKkkIexVrii
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org

Commit b8e0ddd36ce9 ("can: mcp251xfd: tef: prepare to workaround
broken TEF FIFO tail index erratum") introduced
mcp251xfd_get_tef_len() to get the number of unhandled transmit events
from the Transmit Event FIFO (TEF).

As the TEF has no head pointer, the driver uses the TX FIFO's tail
pointer instead, assuming that send frames are completed. However the
check for the TEF being full was not correct. This leads to the driver
stop working if the TEF is full.

Fix the TEF full check by assuming that if, from the driver's point of
view, there are no free TX buffers in the chip and the TX FIFO is
empty, all messages must have been sent and the TEF must therefore be
full.

Reported-by: Sven Schuchmann <schuchmann@schleissheimer.de>
Closes: https://patch.msgid.link/FR3P281MB155216711EFF900AD9791B7ED9692@FR3P281MB1552.DEUP281.PROD.OUTLOOK.COM
Fixes: b8e0ddd36ce9 ("can: mcp251xfd: tef: prepare to workaround broken TEF FIFO tail index erratum")
Tested-by: Sven Schuchmann <schuchmann@schleissheimer.de>
Cc: stable@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Changes in v3:
- add proper patch description
- added Sven's Tested-by
- Link to v2: https://patch.msgid.link/20241025-mcp251xfd-fix-length-calculation-v2-1-ea5db778b950@pengutronix.de

Changes in v2:
- mcp251xfd_tx_fifo_sta_empty(): fix check if TX-FIFO is empty
- Link to RFC: https://patch.msgid.link/20241001-mcp251xfd-fix-length-calculation-v1-1-598b46508d61@pengutronix.de
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
index f732556d233a7be3b43f6f08e0b8f25732190104..d3ac865933fdf6c4ecdd80ad4d7accbff51eb0f8 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
@@ -16,9 +16,9 @@
 
 #include "mcp251xfd.h"
 
-static inline bool mcp251xfd_tx_fifo_sta_full(u32 fifo_sta)
+static inline bool mcp251xfd_tx_fifo_sta_empty(u32 fifo_sta)
 {
-	return !(fifo_sta & MCP251XFD_REG_FIFOSTA_TFNRFNIF);
+	return fifo_sta & MCP251XFD_REG_FIFOSTA_TFERFFIF;
 }
 
 static inline int
@@ -122,7 +122,11 @@ mcp251xfd_get_tef_len(struct mcp251xfd_priv *priv, u8 *len_p)
 	if (err)
 		return err;
 
-	if (mcp251xfd_tx_fifo_sta_full(fifo_sta)) {
+	/* If the chip says the TX-FIFO is empty, but there are no TX
+	 * buffers free in the ring, we assume all have been sent.
+	 */
+	if (mcp251xfd_tx_fifo_sta_empty(fifo_sta) &&
+	    mcp251xfd_get_tx_free(tx_ring) == 0) {
 		*len_p = tx_ring->obj_num;
 		return 0;
 	}

---
base-commit: 5ccdcdf186aec6b9111845fd37e1757e9b413e2f
change-id: 20241001-mcp251xfd-fix-length-calculation-09b6cc10aeb0

Best regards,
-- 
Marc Kleine-Budde <mkl@pengutronix.de>



