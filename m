Return-Path: <stable+bounces-185694-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EC8BDA7B2
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 17:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F307E19A0CE0
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 15:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A333002DB;
	Tue, 14 Oct 2025 15:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GX+yctSw"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068321C3C08;
	Tue, 14 Oct 2025 15:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760456990; cv=none; b=ieQsLjihXVMxFLRChIXwHTUjibGLpfVgD/3Z6g7r1+nu7HlO1YL5U1ZDE1TXSpHBuMRzSurde0HF3IzfSM2v7cWmqfuW2mbyI69YR6joh1j0OYOuAHqqC1kRRQuZXQP7bhaVX8Mvy0VOYAje2S8yeSryAtrlbSzf3WBzaVgEyzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760456990; c=relaxed/simple;
	bh=O2OnOz5scUDSd+QFrf/tvNMYuICl3jWPJOhwXXYif2c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Z9ma/fttP2P6PX0y7131a12YVq3QFx4ts0ZdlOKv5yxmGbz7msv3HGgcaGzx3qW0QInJ8P5bWUMyPJpkJUaNKBxQpWT3+gUYDmQG9D1D46i3HB/e0yCrkJjAA2mZ9GQuPRKBbrREqNSnvt6dj8uKWRxRfZWQQ8uHE0dKkI25Ias=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GX+yctSw; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760456987;
	bh=O2OnOz5scUDSd+QFrf/tvNMYuICl3jWPJOhwXXYif2c=;
	h=From:Date:Subject:To:Cc:From;
	b=GX+yctSwy6m7W9I4+JzKb3R4HW7aDUAyt/mwtGFQlJEWqFbA3pyAC/lsNAcMdaJEg
	 ytEZeHKXOE8nVkaeMSpoym697Y3LMcOJq48f52J/rDwtVCh4K31E3d9lvzb52FX+Fq
	 baqnVCBJzPLwoFV/QYHl2+p1DtAD4RDbocqA3mvmE0xGEq6YIHlajUSsESS46DyoTs
	 DITm5FqB2WbwuTvcSZgETgzwECjyeYZKjMNX4K0HbymnvM6uOU5iRGuSh3+GFXP4ls
	 NapHKToYf+lwlI4MRl65y/v4h10GefoDlhelFcJi0H5jYUZAOwjkCdu9Q/eKoFmjNo
	 ra45orkWevLkg==
Received: from jupiter.universe (dyndsl-091-248-212-042.ewe-ip-backbone.de [91.248.212.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 10E6F17E0FC2;
	Tue, 14 Oct 2025 17:49:47 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id C7D4B480044; Tue, 14 Oct 2025 17:49:46 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Tue, 14 Oct 2025 17:49:34 +0200
Subject: [PATCH net] net: stmmac: dwmac-rk: Fix disabling
 set_clock_selection
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-rockchip-network-clock-fix-v1-1-c257b4afdf75@collabora.com>
X-B4-Tracking: v=1; b=H4sIAA1x7mgC/x2M0QqDMAwAf0XybKAt2jF/RXzQmM3gaCWVTRD/3
 bDHO447obAKF+iqE5S/UiQnA19XQMuY3owyG0NwofXON6iZVlpkw8T7L+uK9DGDLzkw0MPF5xi
 nyAQ22JRN/+c9WA7Ddd10TxPpcQAAAA==
X-Change-ID: 20251014-rockchip-network-clock-fix-2c7069a6b6ec
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 David Wu <david.wu@rock-chips.com>
Cc: netdev@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kernel@collabora.com, stable@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1840;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=O2OnOz5scUDSd+QFrf/tvNMYuICl3jWPJOhwXXYif2c=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGjucRo2uFWL3tpG3umZXtieNofXO4nAVctBy
 5GLiCh0M1e+rYkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJo7nEaAAoJENju1/PI
 O/qaMRgP/iHJbV5a//GQfdq66WDDNHayu81bXQstYRXDdc/7YdmVEcv0rb8N0XNFrKluxH9R0bR
 sQ4PWok9aNKOApOWZ08lrrbr4IgNP0oMfR4CRiIEn6p28TI+jjKkq9/639UPolu+/iPapqnkSF6
 rE2ooV/kOppR6SQrB9+wLisBqnT3QShTnaq7HWhn6jJPWT9u+el0CbscGum+IYuJ/K3iUw2QTJM
 KgpF4PnJyNCb6V3Et6gOhT67VIU7CFWi/8sAMy0Q3nQrl5wJl1UxFjeHf6KmVxq6Mgs5Q6vpRJf
 MSvEtO86J9cBNFmgcrcVOasDrgnvvX9ZRbJbfbg4yzOG8C2MBUZ3ZmzOazQTAVqMoIybmZlPvoR
 nj0khD6HikFTzc9vWa536n1ZuuJH0IIzbX9qZtSvp202bu5nJ7I6k5dvaAfDlHHwPQTMIbKdx4J
 rzBYGfRYUNusTavH45VWs+4pJed1PIvGJAJ2cm5iVTh0kup4eUS7iPTzDO6uyKVXDrGmLJQmRFC
 mSY3nIlCJpvo02UCAncaD3OLR7165ubeG+pD1p3pLDQhyQO91xgydGwpXYj1aq6xT04jdgJH5V/
 B8aO3l2FIdl2KMrX8GYf0ji7K5J9qoiJ0l+R05gQ4rt1GK+BfBsZitLWjW47/3KpUAAQ58gCARc
 t70WWOTk/R/hbaOtx56g2KQ==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

On all platforms set_clock_selection() writes to a GRF register. This
requires certain clocks running and thus should happen before the
clocks are disabled.

This has been noticed on RK3576 Sige5, which hangs during system suspend
when trying to suspend the second network interface. Note, that
suspending the first interface works, because the second device ensures
that the necessary clocks for the GRF are enabled.

Cc: stable@vger.kernel.org
Fixes: 2f2b60a0ec28 ("net: ethernet: stmmac: dwmac-rk: Add gmac support for rk3588")
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 51ea0caf16c1..0786816e05f0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -1446,14 +1446,15 @@ static int gmac_clk_enable(struct rk_priv_data *bsp_priv, bool enable)
 		}
 	} else {
 		if (bsp_priv->clk_enabled) {
+			if (bsp_priv->ops && bsp_priv->ops->set_clock_selection) {
+				bsp_priv->ops->set_clock_selection(bsp_priv,
+					      bsp_priv->clock_input, false);
+			}
+
 			clk_bulk_disable_unprepare(bsp_priv->num_clks,
 						   bsp_priv->clks);
 			clk_disable_unprepare(bsp_priv->clk_phy);
 
-			if (bsp_priv->ops && bsp_priv->ops->set_clock_selection)
-				bsp_priv->ops->set_clock_selection(bsp_priv,
-					      bsp_priv->clock_input, false);
-
 			bsp_priv->clk_enabled = false;
 		}
 	}

---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251014-rockchip-network-clock-fix-2c7069a6b6ec

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


