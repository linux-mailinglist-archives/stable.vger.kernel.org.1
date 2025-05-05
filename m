Return-Path: <stable+bounces-140255-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B312AAA6DB
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 566A7987BE8
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A067C32B2BB;
	Mon,  5 May 2025 22:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+3SMWC4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5471B32B2B4;
	Mon,  5 May 2025 22:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484506; cv=none; b=VAlZW4PXOCZSNyJe5kIVNdJedoeYTZ0NP0GjmHwWBnXZUcFBK0BtIz/WebRe9IJMgXhoTNNLs4tJWffW5Xt/KQpugK1HfpvlLCUkg6guMEaBzzbIB1bL95amJo1LRiCDD00BaSMukjKzGcd4nJuKvhQGOJSsRLO2jtIOytayz7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484506; c=relaxed/simple;
	bh=yxsnRJRb9xThATtH7UqhtyDa4fYv1SCQYDmsViCzhlg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S8IEC3b2O+x1ve/oWKlvlU5WLjVnghAXOIeTQltJ4vrxK75Vv1dHn5CFC3Vy7B7/v3pN5ibjwlsXccuzU2qXsgWB7j0dXw2Ew8hSrxBxN0+7KID/8tcvfqO24Tl4SwvQWynOAFVoOLtBhoYLcvl7w5xn0obXWmDmcMdeIICqaG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+3SMWC4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75129C4CEF1;
	Mon,  5 May 2025 22:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484506;
	bh=yxsnRJRb9xThATtH7UqhtyDa4fYv1SCQYDmsViCzhlg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T+3SMWC4t6zNDw9qiCgC9msclclk+BXyhXX0WCuqpCN0JVOZJMUdxl7e2p737Jxlo
	 t0Jru+ED73moun5qAOPM9GjmOYw3ZcZjslmjqdCLkj/CODhKOprtU4c0mQ8V6mf+Ua
	 Z3F0VdPLYh6+6bC3J4JMxnHJDhj/l0xa3myBZNUBSydORjsj1TZCxFeGRwlyYVsLn+
	 3PKI8a/4Q4nAA+o+eGb/n/uWsRGSUzAIYJqJYXkWoWUzoUHzmikXEtRpXEygQMLfOs
	 f25EIOaXu5EPN5XBECPuek1bxCqK4YLPiTXb2TuESsFAId7egDVnGhnU8IY+QXG7/Y
	 cVFgP8z7WQNyg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Simon Horman <horms@kernel.org>, Csókás@web.codeaurora.org,
	Paolo Abeni <pabeni@redhat.com>, Sasha Levin <sashal@kernel.org>,
	wei.fang@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, imx@lists.linux.dev,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 507/642] net: fec: Refactor MAC reset to function
Date: Mon,  5 May 2025 18:12:03 -0400
Message-Id: <20250505221419.2672473-507-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Csókás, Bence <csokas.bence@prolan.hu>

[ Upstream commit 67800d296191d0a9bde0a7776f99ca1ddfa0fc26 ]

The core is reset both in `fec_restart()` (called on link-up) and
`fec_stop()` (going to sleep, driver remove etc.). These two functions
had their separate implementations, which was at first only a register
write and a `udelay()` (and the accompanying block comment). However,
since then we got soft-reset (MAC disable) and Wake-on-LAN support, which
meant that these implementations diverged, often causing bugs.

For instance, as of now, `fec_stop()` does not check for
`FEC_QUIRK_NO_HARD_RESET`, meaning the MII/RMII mode is cleared on eg.
a PM power-down event; and `fec_restart()` missed the refactor renaming
the "magic" constant `1` to `FEC_ECR_RESET`.

To harmonize current implementations, and eliminate this source of
potential future bugs, refactor implementation to a common function.

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
Link: https://patch.msgid.link/20250207121255.161146-2-csokas.bence@prolan.hu
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/fec_main.c | 52 +++++++++++------------
 1 file changed, 25 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index f7c4ce8e9a265..a86cfebedaa8b 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1093,6 +1093,29 @@ static void fec_enet_enable_ring(struct net_device *ndev)
 	}
 }
 
+/* Whack a reset.  We should wait for this.
+ * For i.MX6SX SOC, enet use AXI bus, we use disable MAC
+ * instead of reset MAC itself.
+ */
+static void fec_ctrl_reset(struct fec_enet_private *fep, bool allow_wol)
+{
+	u32 val;
+
+	if (!allow_wol || !(fep->wol_flag & FEC_WOL_FLAG_SLEEP_ON)) {
+		if (fep->quirks & FEC_QUIRK_HAS_MULTI_QUEUES ||
+		    ((fep->quirks & FEC_QUIRK_NO_HARD_RESET) && fep->link)) {
+			writel(0, fep->hwp + FEC_ECNTRL);
+		} else {
+			writel(FEC_ECR_RESET, fep->hwp + FEC_ECNTRL);
+			udelay(10);
+		}
+	} else {
+		val = readl(fep->hwp + FEC_ECNTRL);
+		val |= (FEC_ECR_MAGICEN | FEC_ECR_SLEEP);
+		writel(val, fep->hwp + FEC_ECNTRL);
+	}
+}
+
 /*
  * This function is called to start or restart the FEC during a link
  * change, transmit timeout, or to reconfigure the FEC.  The network
@@ -1109,17 +1132,7 @@ fec_restart(struct net_device *ndev)
 	if (fep->bufdesc_ex)
 		fec_ptp_save_state(fep);
 
-	/* Whack a reset.  We should wait for this.
-	 * For i.MX6SX SOC, enet use AXI bus, we use disable MAC
-	 * instead of reset MAC itself.
-	 */
-	if (fep->quirks & FEC_QUIRK_HAS_MULTI_QUEUES ||
-	    ((fep->quirks & FEC_QUIRK_NO_HARD_RESET) && fep->link)) {
-		writel(0, fep->hwp + FEC_ECNTRL);
-	} else {
-		writel(1, fep->hwp + FEC_ECNTRL);
-		udelay(10);
-	}
+	fec_ctrl_reset(fep, false);
 
 	/*
 	 * enet-mac reset will reset mac address registers too,
@@ -1373,22 +1386,7 @@ fec_stop(struct net_device *ndev)
 	if (fep->bufdesc_ex)
 		fec_ptp_save_state(fep);
 
-	/* Whack a reset.  We should wait for this.
-	 * For i.MX6SX SOC, enet use AXI bus, we use disable MAC
-	 * instead of reset MAC itself.
-	 */
-	if (!(fep->wol_flag & FEC_WOL_FLAG_SLEEP_ON)) {
-		if (fep->quirks & FEC_QUIRK_HAS_MULTI_QUEUES) {
-			writel(0, fep->hwp + FEC_ECNTRL);
-		} else {
-			writel(FEC_ECR_RESET, fep->hwp + FEC_ECNTRL);
-			udelay(10);
-		}
-	} else {
-		val = readl(fep->hwp + FEC_ECNTRL);
-		val |= (FEC_ECR_MAGICEN | FEC_ECR_SLEEP);
-		writel(val, fep->hwp + FEC_ECNTRL);
-	}
+	fec_ctrl_reset(fep, true);
 	writel(fep->phy_speed, fep->hwp + FEC_MII_SPEED);
 	writel(FEC_DEFAULT_IMASK, fep->hwp + FEC_IMASK);
 
-- 
2.39.5


