Return-Path: <stable+bounces-182598-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A09BADABC
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 17:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 796697AAB5E
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 15:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C2D173;
	Tue, 30 Sep 2025 15:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mrx72hab"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D5527B328;
	Tue, 30 Sep 2025 15:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759245468; cv=none; b=BmPaIRxIJtoEblE3hkNGB4Qr1+MEpGrnXZ1c1zu9zE+nyGzzhpFcf9dysZJEAwLHCUreJRpnpeQklguSLm7nCdGrzl38jPqQ7iZ9tz5rk1wx+d9/YBI85SSq4qkYVpuNhVAoXo+fORVCClihVp59n/sCoiYEhAmzAA2SFSZgnng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759245468; c=relaxed/simple;
	bh=VrJZuDBuSTfcsf45xOBQvmpWSkOdSpXgRFKudgsBRJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XKCZ4yfUR/8RgwJysm8mpoCo9kIHWE63CRzCUfJmkHdViP4oyWTUi7LOIYFXyKLexQ/BFYdBj+VPhvk8C6dLb0fIdgA1yA/SlQrtkljPES8spbrhObxH9WMQqpPOUvtqld/THgYlkB/x2m7PpJrEMdgVwIAlDLcIRz8xyW6jK9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mrx72hab; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4FB7C4CEF0;
	Tue, 30 Sep 2025 15:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759245468;
	bh=VrJZuDBuSTfcsf45xOBQvmpWSkOdSpXgRFKudgsBRJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mrx72habS7QEERTqxlx6OiGtB+MYojtoiR/hUoQhq/CWZILs91aHpPfwgbW0APPxd
	 xjV7nrDI/LUb9+MoGMbLPjBGDNZ+4hVsxA/RfZYFfy8sSvr9l5ksXt8NOC0SWwP2Tk
	 yDqfsOXV2g9W30Z6c1+CLjnGi5egK0B4z/NdPOyg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 26/73] can: rcar_can: rcar_can_resume(): fix s2ram with PSCI
Date: Tue, 30 Sep 2025 16:47:30 +0200
Message-ID: <20250930143821.662193863@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930143820.537407601@linuxfoundation.org>
References: <20250930143820.537407601@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 5c793afa07da6d2d4595f6c73a2a543a471bb055 ]

On R-Car Gen3 using PSCI, s2ram powers down the SoC.  After resume, the
CAN interface no longer works, until it is brought down and up again.

Fix this by calling rcar_can_start() from the PM resume callback, to
fully initialize the controller instead of just restarting it.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/699b2f7fcb60b31b6f976a37f08ce99c5ffccb31.1755165227.git.geert+renesas@glider.be
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/rcar/rcar_can.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_can.c
index cc43c9c5e38c5..92a3f28bea87a 100644
--- a/drivers/net/can/rcar/rcar_can.c
+++ b/drivers/net/can/rcar/rcar_can.c
@@ -862,7 +862,6 @@ static int __maybe_unused rcar_can_resume(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct rcar_can_priv *priv = netdev_priv(ndev);
-	u16 ctlr;
 	int err;
 
 	if (!netif_running(ndev))
@@ -874,12 +873,7 @@ static int __maybe_unused rcar_can_resume(struct device *dev)
 		return err;
 	}
 
-	ctlr = readw(&priv->regs->ctlr);
-	ctlr &= ~RCAR_CAN_CTLR_SLPM;
-	writew(ctlr, &priv->regs->ctlr);
-	ctlr &= ~RCAR_CAN_CTLR_CANM;
-	writew(ctlr, &priv->regs->ctlr);
-	priv->can.state = CAN_STATE_ERROR_ACTIVE;
+	rcar_can_start(ndev);
 
 	netif_device_attach(ndev);
 	netif_start_queue(ndev);
-- 
2.51.0




