Return-Path: <stable+bounces-10120-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B2382728A
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 16:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5B921C22968
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 15:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1760F4C3A0;
	Mon,  8 Jan 2024 15:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1Us+cpXT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BAC4A99F;
	Mon,  8 Jan 2024 15:13:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B6FC433C8;
	Mon,  8 Jan 2024 15:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704726822;
	bh=419qLiry/hQzF1iN/LWMfIelgftCCtWPYD4+bLnabf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1Us+cpXTSnSSRRMkVhIN4A/Zm4S/8KEmIr6oXZ6s8RtIS17GVvpTL2ynHCizLvOqe
	 eR7899vfs/4kPomlYUSGRmMwBmKNhg+Rv7CMQbvvVjW9D0bMtWzmtCBFGYPZspeB8d
	 kZNwt5gkhndWT8JOqtX/I2kZRyrEJ3HB/PuDJV5A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 060/124] net: ravb: Wait for operating mode to be applied
Date: Mon,  8 Jan 2024 16:08:06 +0100
Message-ID: <20240108150605.722039409@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108150602.976232871@linuxfoundation.org>
References: <20240108150602.976232871@linuxfoundation.org>
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

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

[ Upstream commit 9039cd4c61635b2d541009a7cd5e2cc052402f28 ]

CSR.OPS bits specify the current operating mode and (according to
documentation) they are updated by HW when the operating mode change
request is processed. To comply with this check CSR.OPS before proceeding.

Commit introduces ravb_set_opmode() that does all the necessities for
setting the operating mode (set CCC.OPC (and CCC.GAC, CCC.CSEL, if any) and
wait for CSR.OPS) and call it where needed. This should comply with all the
HW manuals requirements as different manual variants specify that different
modes need to be checked in CSR.OPS when setting CCC.OPC.

If gPTP active in config mode is supported and it needs to be enabled, the
CCC.GAC and CCC.CSEL needs to be configured along with CCC.OPC in the same
write access. For this, ravb_set_opmode() allows passing GAC and CSEL as
part of opmode and the function updates accordingly CCC register.

Fixes: c156633f1353 ("Renesas Ethernet AVB driver proper")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/renesas/ravb_main.c | 65 +++++++++++++++---------
 1 file changed, 42 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index bb56cf4090423..3c2a6b23c202a 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -66,16 +66,27 @@ int ravb_wait(struct net_device *ndev, enum ravb_reg reg, u32 mask, u32 value)
 	return -ETIMEDOUT;
 }
 
-static int ravb_config(struct net_device *ndev)
+static int ravb_set_opmode(struct net_device *ndev, u32 opmode)
 {
+	u32 csr_ops = 1U << (opmode & CCC_OPC);
+	u32 ccc_mask = CCC_OPC;
 	int error;
 
-	/* Set config mode */
-	ravb_modify(ndev, CCC, CCC_OPC, CCC_OPC_CONFIG);
-	/* Check if the operating mode is changed to the config mode */
-	error = ravb_wait(ndev, CSR, CSR_OPS, CSR_OPS_CONFIG);
-	if (error)
-		netdev_err(ndev, "failed to switch device to config mode\n");
+	/* If gPTP active in config mode is supported it needs to be configured
+	 * along with CSEL and operating mode in the same access. This is a
+	 * hardware limitation.
+	 */
+	if (opmode & CCC_GAC)
+		ccc_mask |= CCC_GAC | CCC_CSEL;
+
+	/* Set operating mode */
+	ravb_modify(ndev, CCC, ccc_mask, opmode);
+	/* Check if the operating mode is changed to the requested one */
+	error = ravb_wait(ndev, CSR, CSR_OPS, csr_ops);
+	if (error) {
+		netdev_err(ndev, "failed to switch device to requested mode (%u)\n",
+			   opmode & CCC_OPC);
+	}
 
 	return error;
 }
@@ -673,7 +684,7 @@ static int ravb_dmac_init(struct net_device *ndev)
 	int error;
 
 	/* Set CONFIG mode */
-	error = ravb_config(ndev);
+	error = ravb_set_opmode(ndev, CCC_OPC_CONFIG);
 	if (error)
 		return error;
 
@@ -682,9 +693,7 @@ static int ravb_dmac_init(struct net_device *ndev)
 		return error;
 
 	/* Setting the control will start the AVB-DMAC process. */
-	ravb_modify(ndev, CCC, CCC_OPC, CCC_OPC_OPERATION);
-
-	return 0;
+	return ravb_set_opmode(ndev, CCC_OPC_OPERATION);
 }
 
 static void ravb_get_tx_tstamp(struct net_device *ndev)
@@ -1046,7 +1055,7 @@ static int ravb_stop_dma(struct net_device *ndev)
 		return error;
 
 	/* Stop AVB-DMAC process */
-	return ravb_config(ndev);
+	return ravb_set_opmode(ndev, CCC_OPC_CONFIG);
 }
 
 /* E-MAC interrupt handler */
@@ -2560,21 +2569,25 @@ static int ravb_set_gti(struct net_device *ndev)
 	return 0;
 }
 
-static void ravb_set_config_mode(struct net_device *ndev)
+static int ravb_set_config_mode(struct net_device *ndev)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *info = priv->info;
+	int error;
 
 	if (info->gptp) {
-		ravb_modify(ndev, CCC, CCC_OPC, CCC_OPC_CONFIG);
+		error = ravb_set_opmode(ndev, CCC_OPC_CONFIG);
+		if (error)
+			return error;
 		/* Set CSEL value */
 		ravb_modify(ndev, CCC, CCC_CSEL, CCC_CSEL_HPB);
 	} else if (info->ccc_gac) {
-		ravb_modify(ndev, CCC, CCC_OPC, CCC_OPC_CONFIG |
-			    CCC_GAC | CCC_CSEL_HPB);
+		error = ravb_set_opmode(ndev, CCC_OPC_CONFIG | CCC_GAC | CCC_CSEL_HPB);
 	} else {
-		ravb_modify(ndev, CCC, CCC_OPC, CCC_OPC_CONFIG);
+		error = ravb_set_opmode(ndev, CCC_OPC_CONFIG);
 	}
+
+	return error;
 }
 
 /* Set tx and rx clock internal delay modes */
@@ -2794,7 +2807,9 @@ static int ravb_probe(struct platform_device *pdev)
 	ndev->ethtool_ops = &ravb_ethtool_ops;
 
 	/* Set AVB config mode */
-	ravb_set_config_mode(ndev);
+	error = ravb_set_config_mode(ndev);
+	if (error)
+		goto out_disable_gptp_clk;
 
 	if (info->gptp || info->ccc_gac) {
 		/* Set GTI value */
@@ -2917,8 +2932,7 @@ static int ravb_remove(struct platform_device *pdev)
 	dma_free_coherent(ndev->dev.parent, priv->desc_bat_size, priv->desc_bat,
 			  priv->desc_bat_dma);
 
-	/* Set reset mode */
-	ravb_write(ndev, CCC_OPC_RESET, CCC);
+	ravb_set_opmode(ndev, CCC_OPC_RESET);
 
 	clk_disable_unprepare(priv->gptp_clk);
 	clk_disable_unprepare(priv->refclk);
@@ -3002,8 +3016,11 @@ static int __maybe_unused ravb_resume(struct device *dev)
 	int ret = 0;
 
 	/* If WoL is enabled set reset mode to rearm the WoL logic */
-	if (priv->wol_enabled)
-		ravb_write(ndev, CCC_OPC_RESET, CCC);
+	if (priv->wol_enabled) {
+		ret = ravb_set_opmode(ndev, CCC_OPC_RESET);
+		if (ret)
+			return ret;
+	}
 
 	/* All register have been reset to default values.
 	 * Restore all registers which where setup at probe time and
@@ -3011,7 +3028,9 @@ static int __maybe_unused ravb_resume(struct device *dev)
 	 */
 
 	/* Set AVB config mode */
-	ravb_set_config_mode(ndev);
+	ret = ravb_set_config_mode(ndev);
+	if (ret)
+		return ret;
 
 	if (info->gptp || info->ccc_gac) {
 		/* Set GTI value */
-- 
2.43.0




