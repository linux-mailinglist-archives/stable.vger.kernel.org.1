Return-Path: <stable+bounces-203300-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 173BECD9037
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 12:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 189CA300AC59
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 11:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7DF33FE20;
	Tue, 23 Dec 2025 11:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XyNAe3Eu"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D862264614;
	Tue, 23 Dec 2025 11:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766487935; cv=none; b=a5onfHsxaSdY507dpNqla9B8jHnlFiO+zAeQX2YCtu2WMWxT/O7/esOK5fDnAi4UO23xRAuTbviru41fAus7D2Ah4QYxLSR3Hffr1hvTjuwKmc+fWU1shKNdKfu0AaHd3OSiYzGn7jM4UL4ULCuyXov8qqoTRMcTibB+fCz5Uzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766487935; c=relaxed/simple;
	bh=O29c7ITgEJCymXV/jcddxP+gJ4NesKAR0lu9ZRXMAT4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=m+oKTviSflfEP1HrSLgTCwVM7BleE8HAoT8vJoT9Ft8FVOpN2PuoKAj6iAX936tzgXNwaiVWg4e6Bp8MQ/JFtJsMgGTkAM5HggUk0OaBPfpyNOtAFg/RyZKJnold3eseYQrU0wW5qUZlT2tdclaX9IAveAFqGfItyCHUe1U7zvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XyNAe3Eu; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1766487931;
	bh=O29c7ITgEJCymXV/jcddxP+gJ4NesKAR0lu9ZRXMAT4=;
	h=From:Date:Subject:To:Cc:From;
	b=XyNAe3EuDaHR3MOpeXryvZwDB3jjh0ofXpEMba+shFfYY3viA9XRHpYpOIKUaYol6
	 lD3Aj8KCWWdtUwY0OKS9SbiyV9yDYdyy8YqIroI4nXGUhNUw9y+9wHYgrgp/UZBtzm
	 Bij9IOwpXw6oNKFCykwwJmbCy9RB3uF4WJJcVBkAK5qbDq4YpbjP5QgHGD73juA8lP
	 sdmysBReedOu3ypbtsOBP3PZInKq+e465Q71vM024nWE7kNXa1UdveWEa1tQ3jSQgs
	 +QT8Q/JjjBJPG1ECu03kjUP02FeohtMWakHhnBszTakDzfrCLtSBbkT4qQuCrtnQSA
	 wLSdydPPBXfOA==
Received: from beast.luon.net (simons.connected.by.freedominter.net [45.83.240.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sjoerd)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 639B217E0125;
	Tue, 23 Dec 2025 12:05:31 +0100 (CET)
Received: by beast.luon.net (Postfix, from userid 1000)
	id 0425A1179E810; Tue, 23 Dec 2025 12:05:30 +0100 (CET)
From: Sjoerd Simons <sjoerd@collabora.com>
Date: Tue, 23 Dec 2025 12:05:17 +0100
Subject: [PATCH] clk: mediatek: Drop __initconst from gates
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-mtk-gate-v1-1-e4a489ab33de@collabora.com>
X-B4-Tracking: v=1; b=H4sIAGx3SmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDIyNj3dySbN30xJJU3URLC0Nj48QkC4NkSyWg8oKi1LTMCrBR0bG1tQB
 +JXBwWgAAAA==
X-Change-ID: 20251223-mtk-gate-a98133ab80c9
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Laura Nao <laura.nao@collabora.com>, Chen-Yu Tsai <wenst@chromium.org>
Cc: kernel@collabora.com, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, stable@vger.kernel.org, 
 Sjoerd Simons <sjoerd@collabora.com>
X-Mailer: b4 0.14.3

Since commit 8ceff24a754a ("clk: mediatek: clk-gate: Refactor
mtk_clk_register_gate to use mtk_gate struct") the mtk_gate structs
are no longer just used for initialization/registration, but also at
runtime. So drop __initconst annotations.

Fixes: 8ceff24a754a ("clk: mediatek: clk-gate: Refactor mtk_clk_register_gate to use mtk_gate struct")
Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
---
 drivers/clk/mediatek/clk-mt7981-eth.c | 6 +++---
 drivers/clk/mediatek/clk-mt8516.c     | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7981-eth.c b/drivers/clk/mediatek/clk-mt7981-eth.c
index 906aec9ddff5..0655ebb6c561 100644
--- a/drivers/clk/mediatek/clk-mt7981-eth.c
+++ b/drivers/clk/mediatek/clk-mt7981-eth.c
@@ -31,7 +31,7 @@ static const struct mtk_gate_regs sgmii0_cg_regs = {
 		.ops = &mtk_clk_gate_ops_no_setclr_inv,	\
 	}
 
-static const struct mtk_gate sgmii0_clks[] __initconst = {
+static const struct mtk_gate sgmii0_clks[] = {
 	GATE_SGMII0(CLK_SGM0_TX_EN, "sgm0_tx_en", "usb_tx250m", 2),
 	GATE_SGMII0(CLK_SGM0_RX_EN, "sgm0_rx_en", "usb_eq_rx250m", 3),
 	GATE_SGMII0(CLK_SGM0_CK0_EN, "sgm0_ck0_en", "usb_ln0", 4),
@@ -53,7 +53,7 @@ static const struct mtk_gate_regs sgmii1_cg_regs = {
 		.ops = &mtk_clk_gate_ops_no_setclr_inv,	\
 	}
 
-static const struct mtk_gate sgmii1_clks[] __initconst = {
+static const struct mtk_gate sgmii1_clks[] = {
 	GATE_SGMII1(CLK_SGM1_TX_EN, "sgm1_tx_en", "usb_tx250m", 2),
 	GATE_SGMII1(CLK_SGM1_RX_EN, "sgm1_rx_en", "usb_eq_rx250m", 3),
 	GATE_SGMII1(CLK_SGM1_CK1_EN, "sgm1_ck1_en", "usb_ln0", 4),
@@ -75,7 +75,7 @@ static const struct mtk_gate_regs eth_cg_regs = {
 		.ops = &mtk_clk_gate_ops_no_setclr_inv,	\
 	}
 
-static const struct mtk_gate eth_clks[] __initconst = {
+static const struct mtk_gate eth_clks[] = {
 	GATE_ETH(CLK_ETH_FE_EN, "eth_fe_en", "netsys_2x", 6),
 	GATE_ETH(CLK_ETH_GP2_EN, "eth_gp2_en", "sgm_325m", 7),
 	GATE_ETH(CLK_ETH_GP1_EN, "eth_gp1_en", "sgm_325m", 8),
diff --git a/drivers/clk/mediatek/clk-mt8516.c b/drivers/clk/mediatek/clk-mt8516.c
index 21eb052b0a53..342a59019fea 100644
--- a/drivers/clk/mediatek/clk-mt8516.c
+++ b/drivers/clk/mediatek/clk-mt8516.c
@@ -544,7 +544,7 @@ static const struct mtk_gate_regs top5_cg_regs = {
 #define GATE_TOP5(_id, _name, _parent, _shift)				\
 	GATE_MTK(_id, _name, _parent, &top5_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
-static const struct mtk_gate top_clks[] __initconst = {
+static const struct mtk_gate top_clks[] = {
 	/* TOP1 */
 	GATE_TOP1(CLK_TOP_THEM, "them", "ahb_infra_sel", 1),
 	GATE_TOP1(CLK_TOP_APDMA, "apdma", "ahb_infra_sel", 2),

---
base-commit: b927546677c876e26eba308550207c2ddf812a43
change-id: 20251223-mtk-gate-a98133ab80c9

Best regards,
-- 
Sjoerd Simons <sjoerd@collabora.com>


