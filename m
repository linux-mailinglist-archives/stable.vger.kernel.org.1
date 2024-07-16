Return-Path: <stable+bounces-59753-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D18932B93
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 17:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42FDC1F2099A
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 15:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1935195B27;
	Tue, 16 Jul 2024 15:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nId1gjLS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F16312B72;
	Tue, 16 Jul 2024 15:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721144809; cv=none; b=kPSAbTFoIy4DVSHsuBAPcKgBafFefcZcjcln+MvMnOD2W87X0VSXNHJ4pXHj4c/ie+U70jumtJQyDM26uKIqAELYz/Z2YVyy1fnKsBf2lbzWZEyWWfZto1GXHXiUNhmLrbUCFfga4g47hKNC6CDOnkfR1mlyDNsqURMITPF2hak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721144809; c=relaxed/simple;
	bh=EcHLPFSBcaSPyd8e0BxFBWInHwVfGakeG/iaO4l/Jp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A3wDHfQwuPnuX6qNOJbFfTFip7qUUKMfo/l+jMbw1UrHTq8EOhHK1AbbmUBW7hl1PLRNWGJecqupxI0Xwa9znqui8iNgJ4lR/U42epK8k+lfoK5bIJ30f8LPSIZjjIxpR/TLqicsrs6EsBISI8FjNsxAXhWUqaJRWxJZ+FVyOjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nId1gjLS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF220C4AF0B;
	Tue, 16 Jul 2024 15:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721144809;
	bh=EcHLPFSBcaSPyd8e0BxFBWInHwVfGakeG/iaO4l/Jp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nId1gjLS8nkA5vIbkvycgWncMZ2ju2YdJasw3nGkJd/+EP+MF+jAsiX7mz6H1Nc4a
	 8WcCOsR5nXdJ8eZBDPFwGb3nPiLdmANeInL/TOcpgZwCEmHg75Ve7G5M1s8lp7CDZ8
	 w5i7/Ax0K9UUUSEG1BMcHErdtHTmJAdI+KqlaTGA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dirk Behme <dirk.behme@de.bosch.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 101/108] i2c: rcar: bring hardware to known state when probing
Date: Tue, 16 Jul 2024 17:31:56 +0200
Message-ID: <20240716152749.873831353@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716152745.988603303@linuxfoundation.org>
References: <20240716152745.988603303@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

[ Upstream commit 4e36c0f20cb1c74c7bd7ea31ba432c1c4a989031 ]

When probing, the hardware is not brought into a known state. This may
be a problem when a hypervisor restarts Linux without resetting the
hardware, leaving an old state running. Make sure the hardware gets
initialized, especially interrupts should be cleared and disabled.

Reported-by: Dirk Behme <dirk.behme@de.bosch.com>
Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Closes: https://lore.kernel.org/r/20240702045535.2000393-1-dirk.behme@de.bosch.com
Fixes: 6ccbe607132b ("i2c: add Renesas R-Car I2C driver")
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-rcar.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 6a7a7a074a975..029d999708261 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -220,6 +220,14 @@ static void rcar_i2c_init(struct rcar_i2c_priv *priv)
 
 }
 
+static void rcar_i2c_reset_slave(struct rcar_i2c_priv *priv)
+{
+	rcar_i2c_write(priv, ICSIER, 0);
+	rcar_i2c_write(priv, ICSSR, 0);
+	rcar_i2c_write(priv, ICSCR, SDBS);
+	rcar_i2c_write(priv, ICSAR, 0); /* Gen2: must be 0 if not using slave */
+}
+
 static int rcar_i2c_bus_barrier(struct rcar_i2c_priv *priv)
 {
 	int ret;
@@ -888,11 +896,8 @@ static int rcar_unreg_slave(struct i2c_client *slave)
 
 	/* ensure no irq is running before clearing ptr */
 	disable_irq(priv->irq);
-	rcar_i2c_write(priv, ICSIER, 0);
-	rcar_i2c_write(priv, ICSSR, 0);
+	rcar_i2c_reset_slave(priv);
 	enable_irq(priv->irq);
-	rcar_i2c_write(priv, ICSCR, SDBS);
-	rcar_i2c_write(priv, ICSAR, 0); /* Gen2: must be 0 if not using slave */
 
 	priv->slave = NULL;
 
@@ -1004,7 +1009,9 @@ static int rcar_i2c_probe(struct platform_device *pdev)
 		goto out_pm_disable;
 	}
 
-	rcar_i2c_write(priv, ICSAR, 0); /* Gen2: must be 0 if not using slave */
+	/* Bring hardware to known state */
+	rcar_i2c_init(priv);
+	rcar_i2c_reset_slave(priv);
 
 	if (priv->devtype < I2C_RCAR_GEN3) {
 		irqflags |= IRQF_NO_THREAD;
-- 
2.43.0




