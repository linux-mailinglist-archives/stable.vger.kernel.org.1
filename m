Return-Path: <stable+bounces-41173-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFE88AFB1C
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 23:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20DA6B2BC97
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 21:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32F6149E19;
	Tue, 23 Apr 2024 21:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B5EsQQtE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED39143C49;
	Tue, 23 Apr 2024 21:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713908727; cv=none; b=PU7Q1IQZCVw9AtS5sUVAdZyZrvVIe0PrYTDWfEasLjgAQCNl4aQ671lGCnquLOnS02FYHhmITBlVWo6oO6AyGgByrA/1gmrpGzZXKjtssJw2uH4S4HzmvDPT5tHKwPfW4b5jIEHc9jmE9bJ6BpJ/NyydfrykjW5YTDKE1t+oVss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713908727; c=relaxed/simple;
	bh=UjefLzGGoXuKXKwnbY4F/0v/Yb8ijbtvKGw8Vk90/Io=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FcOfc7YgqdzXuDgOeAp+Q3mVTOw2QYE55IQkYm5TuAOWkyPYswF1QNIvtBpzEPpz7OnzCXVxrk02J4j2jg+E8OayELUakDaEveu7lVXIiBd7ZPdFbfkVKf3G2dT5qpruCejoBDMp4rpakzxoHKc3jmXilcf85vVKwA8W3X2OMAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B5EsQQtE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A302C116B1;
	Tue, 23 Apr 2024 21:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713908727;
	bh=UjefLzGGoXuKXKwnbY4F/0v/Yb8ijbtvKGw8Vk90/Io=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B5EsQQtEDpyRp7MSi1lXVAIYMeOsPTcj1Xh+JIsROAmXsIJ0pBptJLeQNZMnrVkhL
	 PmZ9daY7mbzTn+qFqvcdwHTqeI2q7JFdj08SZK7hd9HWg75GmQiwhmqI7N7LWHi1GA
	 KCNefPcanu0jS8OY+a/aSmRWbJZx27iYuCGQamzc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Miles Chen <miles.chen@mediatek.com>,
	Mingming Su <mingming.su@mediatek.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 092/141] clk: mediatek: clk-gate: Propagate struct device with mtk_clk_register_gates()
Date: Tue, 23 Apr 2024 14:39:20 -0700
Message-ID: <20240423213856.167798967@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423213853.356988651@linuxfoundation.org>
References: <20240423213853.356988651@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

[ Upstream commit 20498d52c9c1a68b1d92c42bce1dc893d3e74f30 ]

Commit e4c23e19aa2a ("clk: mediatek: Register clock gate with device")
introduces a helper function for the sole purpose of propagating a
struct device pointer to the clk API when registering the mtk-gate
clocks to take advantage of Runtime PM when/where needed and where
a power domain is defined in devicetree.

Function mtk_clk_register_gates() then becomes a wrapper around the
new mtk_clk_register_gates_with_dev() function that will simply pass
NULL as struct device: this is essential when registering drivers
with CLK_OF_DECLARE instead of as a platform device, as there will
be no struct device to pass... but we can as well simply have only
one function that always takes such pointer as a param and pass NULL
when unavoidable.

This commit removes the mtk_clk_register_gates() wrapper and renames
mtk_clk_register_gates_with_dev() to the former and all of the calls
to either of the two functions were fixed in all drivers in order to
reflect this change; also, to improve consistency with other kernel
functions, the pointer to struct device was moved as the first param.

Since a lot of MediaTek clock drivers are actually registering as a
platform device, but were still registering the mtk-gate clocks
without passing any struct device to the clock framework, they've
been changed to pass a valid one now, as to make all those platforms
able to use runtime power management where available.

While at it, some much needed indentation changes were also done.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>
Tested-by: Miles Chen <miles.chen@mediatek.com>
Link: https://lore.kernel.org/r/20230120092053.182923-4-angelogioacchino.delregno@collabora.com
Tested-by: Mingming Su <mingming.su@mediatek.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Stable-dep-of: 2f7b1d8b5505 ("clk: mediatek: Do a runtime PM get on controllers during probe")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/mediatek/clk-gate.c              | 23 ++++++-------------
 drivers/clk/mediatek/clk-gate.h              |  7 +-----
 drivers/clk/mediatek/clk-mt2701-aud.c        |  4 ++--
 drivers/clk/mediatek/clk-mt2701-eth.c        |  4 ++--
 drivers/clk/mediatek/clk-mt2701-g3d.c        |  2 +-
 drivers/clk/mediatek/clk-mt2701-hif.c        |  4 ++--
 drivers/clk/mediatek/clk-mt2701-mm.c         |  4 ++--
 drivers/clk/mediatek/clk-mt2701.c            | 12 +++++-----
 drivers/clk/mediatek/clk-mt2712-mm.c         |  4 ++--
 drivers/clk/mediatek/clk-mt2712.c            | 12 +++++-----
 drivers/clk/mediatek/clk-mt6765.c            | 10 ++++----
 drivers/clk/mediatek/clk-mt6779-mm.c         |  4 ++--
 drivers/clk/mediatek/clk-mt6779.c            |  6 ++---
 drivers/clk/mediatek/clk-mt6795-infracfg.c   |  3 ++-
 drivers/clk/mediatek/clk-mt6795-mm.c         |  3 ++-
 drivers/clk/mediatek/clk-mt6795-pericfg.c    |  3 ++-
 drivers/clk/mediatek/clk-mt6797-mm.c         |  4 ++--
 drivers/clk/mediatek/clk-mt6797.c            |  4 ++--
 drivers/clk/mediatek/clk-mt7622-aud.c        |  4 ++--
 drivers/clk/mediatek/clk-mt7622-eth.c        |  8 +++----
 drivers/clk/mediatek/clk-mt7622-hif.c        |  8 +++----
 drivers/clk/mediatek/clk-mt7622.c            | 14 ++++++------
 drivers/clk/mediatek/clk-mt7629-eth.c        |  7 +++---
 drivers/clk/mediatek/clk-mt7629-hif.c        |  8 +++----
 drivers/clk/mediatek/clk-mt7629.c            | 10 ++++----
 drivers/clk/mediatek/clk-mt7986-eth.c        | 10 ++++----
 drivers/clk/mediatek/clk-mt7986-infracfg.c   |  4 ++--
 drivers/clk/mediatek/clk-mt8135.c            |  8 +++----
 drivers/clk/mediatek/clk-mt8167-aud.c        |  2 +-
 drivers/clk/mediatek/clk-mt8167-img.c        |  2 +-
 drivers/clk/mediatek/clk-mt8167-mfgcfg.c     |  2 +-
 drivers/clk/mediatek/clk-mt8167-mm.c         |  4 ++--
 drivers/clk/mediatek/clk-mt8167-vdec.c       |  3 ++-
 drivers/clk/mediatek/clk-mt8167.c            |  2 +-
 drivers/clk/mediatek/clk-mt8173-mm.c         |  4 ++--
 drivers/clk/mediatek/clk-mt8173.c            | 24 ++++++++++----------
 drivers/clk/mediatek/clk-mt8183-audio.c      |  4 ++--
 drivers/clk/mediatek/clk-mt8183-mm.c         |  4 ++--
 drivers/clk/mediatek/clk-mt8183.c            | 16 ++++++-------
 drivers/clk/mediatek/clk-mt8186-mm.c         |  3 ++-
 drivers/clk/mediatek/clk-mt8192-aud.c        |  3 ++-
 drivers/clk/mediatek/clk-mt8192-mm.c         |  3 ++-
 drivers/clk/mediatek/clk-mt8192.c            | 17 +++++++-------
 drivers/clk/mediatek/clk-mt8195-apmixedsys.c |  3 ++-
 drivers/clk/mediatek/clk-mt8195-topckgen.c   |  3 ++-
 drivers/clk/mediatek/clk-mt8195-vdo0.c       |  3 ++-
 drivers/clk/mediatek/clk-mt8195-vdo1.c       |  3 ++-
 drivers/clk/mediatek/clk-mt8365-mm.c         |  5 ++--
 drivers/clk/mediatek/clk-mt8365.c            |  4 ++--
 drivers/clk/mediatek/clk-mt8516-aud.c        |  2 +-
 drivers/clk/mediatek/clk-mt8516.c            |  2 +-
 drivers/clk/mediatek/clk-mtk.c               |  4 ++--
 52 files changed, 156 insertions(+), 160 deletions(-)

diff --git a/drivers/clk/mediatek/clk-gate.c b/drivers/clk/mediatek/clk-gate.c
index 0c867136e49d7..67d9e741c5e73 100644
--- a/drivers/clk/mediatek/clk-gate.c
+++ b/drivers/clk/mediatek/clk-gate.c
@@ -152,12 +152,12 @@ const struct clk_ops mtk_clk_gate_ops_no_setclr_inv = {
 };
 EXPORT_SYMBOL_GPL(mtk_clk_gate_ops_no_setclr_inv);
 
-static struct clk_hw *mtk_clk_register_gate(const char *name,
+static struct clk_hw *mtk_clk_register_gate(struct device *dev, const char *name,
 					 const char *parent_name,
 					 struct regmap *regmap, int set_ofs,
 					 int clr_ofs, int sta_ofs, u8 bit,
 					 const struct clk_ops *ops,
-					 unsigned long flags, struct device *dev)
+					 unsigned long flags)
 {
 	struct mtk_clk_gate *cg;
 	int ret;
@@ -202,10 +202,9 @@ static void mtk_clk_unregister_gate(struct clk_hw *hw)
 	kfree(cg);
 }
 
-int mtk_clk_register_gates_with_dev(struct device_node *node,
-				    const struct mtk_gate *clks, int num,
-				    struct clk_hw_onecell_data *clk_data,
-				    struct device *dev)
+int mtk_clk_register_gates(struct device *dev, struct device_node *node,
+			   const struct mtk_gate *clks, int num,
+			   struct clk_hw_onecell_data *clk_data)
 {
 	int i;
 	struct clk_hw *hw;
@@ -229,13 +228,13 @@ int mtk_clk_register_gates_with_dev(struct device_node *node,
 			continue;
 		}
 
-		hw = mtk_clk_register_gate(gate->name, gate->parent_name,
+		hw = mtk_clk_register_gate(dev, gate->name, gate->parent_name,
 					    regmap,
 					    gate->regs->set_ofs,
 					    gate->regs->clr_ofs,
 					    gate->regs->sta_ofs,
 					    gate->shift, gate->ops,
-					    gate->flags, dev);
+					    gate->flags);
 
 		if (IS_ERR(hw)) {
 			pr_err("Failed to register clk %s: %pe\n", gate->name,
@@ -261,14 +260,6 @@ int mtk_clk_register_gates_with_dev(struct device_node *node,
 
 	return PTR_ERR(hw);
 }
-EXPORT_SYMBOL_GPL(mtk_clk_register_gates_with_dev);
-
-int mtk_clk_register_gates(struct device_node *node,
-			   const struct mtk_gate *clks, int num,
-			   struct clk_hw_onecell_data *clk_data)
-{
-	return mtk_clk_register_gates_with_dev(node, clks, num, clk_data, NULL);
-}
 EXPORT_SYMBOL_GPL(mtk_clk_register_gates);
 
 void mtk_clk_unregister_gates(const struct mtk_gate *clks, int num,
diff --git a/drivers/clk/mediatek/clk-gate.h b/drivers/clk/mediatek/clk-gate.h
index d9897ef535284..1a46b4c56fc5d 100644
--- a/drivers/clk/mediatek/clk-gate.h
+++ b/drivers/clk/mediatek/clk-gate.h
@@ -50,15 +50,10 @@ struct mtk_gate {
 #define GATE_MTK(_id, _name, _parent, _regs, _shift, _ops)		\
 	GATE_MTK_FLAGS(_id, _name, _parent, _regs, _shift, _ops, 0)
 
-int mtk_clk_register_gates(struct device_node *node,
+int mtk_clk_register_gates(struct device *dev, struct device_node *node,
 			   const struct mtk_gate *clks, int num,
 			   struct clk_hw_onecell_data *clk_data);
 
-int mtk_clk_register_gates_with_dev(struct device_node *node,
-				    const struct mtk_gate *clks, int num,
-				    struct clk_hw_onecell_data *clk_data,
-				    struct device *dev);
-
 void mtk_clk_unregister_gates(const struct mtk_gate *clks, int num,
 			      struct clk_hw_onecell_data *clk_data);
 
diff --git a/drivers/clk/mediatek/clk-mt2701-aud.c b/drivers/clk/mediatek/clk-mt2701-aud.c
index 4287bd3f545ee..03ab212aa7f4e 100644
--- a/drivers/clk/mediatek/clk-mt2701-aud.c
+++ b/drivers/clk/mediatek/clk-mt2701-aud.c
@@ -127,8 +127,8 @@ static int clk_mt2701_aud_probe(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_AUD_NR);
 
-	mtk_clk_register_gates(node, audio_clks, ARRAY_SIZE(audio_clks),
-			       clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, audio_clks,
+			       ARRAY_SIZE(audio_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r) {
diff --git a/drivers/clk/mediatek/clk-mt2701-eth.c b/drivers/clk/mediatek/clk-mt2701-eth.c
index 601358748750e..924725d67c13e 100644
--- a/drivers/clk/mediatek/clk-mt2701-eth.c
+++ b/drivers/clk/mediatek/clk-mt2701-eth.c
@@ -51,8 +51,8 @@ static int clk_mt2701_eth_probe(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_ETHSYS_NR);
 
-	mtk_clk_register_gates(node, eth_clks, ARRAY_SIZE(eth_clks),
-						clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, eth_clks,
+			       ARRAY_SIZE(eth_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
diff --git a/drivers/clk/mediatek/clk-mt2701-g3d.c b/drivers/clk/mediatek/clk-mt2701-g3d.c
index 8d1fc8e3336eb..501fb99bb41a2 100644
--- a/drivers/clk/mediatek/clk-mt2701-g3d.c
+++ b/drivers/clk/mediatek/clk-mt2701-g3d.c
@@ -45,7 +45,7 @@ static int clk_mt2701_g3dsys_init(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_G3DSYS_NR);
 
-	mtk_clk_register_gates(node, g3d_clks, ARRAY_SIZE(g3d_clks),
+	mtk_clk_register_gates(&pdev->dev, node, g3d_clks, ARRAY_SIZE(g3d_clks),
 			       clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
diff --git a/drivers/clk/mediatek/clk-mt2701-hif.c b/drivers/clk/mediatek/clk-mt2701-hif.c
index edeeb033a2350..1ddefc21d6a0d 100644
--- a/drivers/clk/mediatek/clk-mt2701-hif.c
+++ b/drivers/clk/mediatek/clk-mt2701-hif.c
@@ -48,8 +48,8 @@ static int clk_mt2701_hif_probe(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_HIFSYS_NR);
 
-	mtk_clk_register_gates(node, hif_clks, ARRAY_SIZE(hif_clks),
-						clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, hif_clks,
+			       ARRAY_SIZE(hif_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r) {
diff --git a/drivers/clk/mediatek/clk-mt2701-mm.c b/drivers/clk/mediatek/clk-mt2701-mm.c
index eb069f3bc9a2b..f4885dffb324f 100644
--- a/drivers/clk/mediatek/clk-mt2701-mm.c
+++ b/drivers/clk/mediatek/clk-mt2701-mm.c
@@ -76,8 +76,8 @@ static int clk_mt2701_mm_probe(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_MM_NR);
 
-	mtk_clk_register_gates(node, mm_clks, ARRAY_SIZE(mm_clks),
-						clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, mm_clks,
+			       ARRAY_SIZE(mm_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
diff --git a/drivers/clk/mediatek/clk-mt2701.c b/drivers/clk/mediatek/clk-mt2701.c
index 00d2e81bdd43e..c7510f7ba4cc9 100644
--- a/drivers/clk/mediatek/clk-mt2701.c
+++ b/drivers/clk/mediatek/clk-mt2701.c
@@ -685,8 +685,8 @@ static int mtk_topckgen_init(struct platform_device *pdev)
 	mtk_clk_register_dividers(top_adj_divs, ARRAY_SIZE(top_adj_divs),
 				base, &mt2701_clk_lock, clk_data);
 
-	mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks),
-						clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, top_clks,
+			       ARRAY_SIZE(top_clks), clk_data);
 
 	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
@@ -789,8 +789,8 @@ static int mtk_infrasys_init(struct platform_device *pdev)
 		}
 	}
 
-	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
-						infra_clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, infra_clks,
+			       ARRAY_SIZE(infra_clks), infra_clk_data);
 	mtk_clk_register_factors(infra_fixed_divs, ARRAY_SIZE(infra_fixed_divs),
 						infra_clk_data);
 
@@ -902,8 +902,8 @@ static int mtk_pericfg_init(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	mtk_clk_register_gates(node, peri_clks, ARRAY_SIZE(peri_clks),
-						clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, peri_clks,
+			       ARRAY_SIZE(peri_clks), clk_data);
 
 	mtk_clk_register_composites(peri_muxs, ARRAY_SIZE(peri_muxs), base,
 			&mt2701_clk_lock, clk_data);
diff --git a/drivers/clk/mediatek/clk-mt2712-mm.c b/drivers/clk/mediatek/clk-mt2712-mm.c
index ad6daa8f28a83..e5264f1ce60d0 100644
--- a/drivers/clk/mediatek/clk-mt2712-mm.c
+++ b/drivers/clk/mediatek/clk-mt2712-mm.c
@@ -117,8 +117,8 @@ static int clk_mt2712_mm_probe(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_MM_NR_CLK);
 
-	mtk_clk_register_gates(node, mm_clks, ARRAY_SIZE(mm_clks),
-			clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, mm_clks,
+			       ARRAY_SIZE(mm_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
diff --git a/drivers/clk/mediatek/clk-mt2712.c b/drivers/clk/mediatek/clk-mt2712.c
index d6c2cc183b1a1..78ebb4f2335c1 100644
--- a/drivers/clk/mediatek/clk-mt2712.c
+++ b/drivers/clk/mediatek/clk-mt2712.c
@@ -1324,8 +1324,8 @@ static int clk_mt2712_top_probe(struct platform_device *pdev)
 			&mt2712_clk_lock, top_clk_data);
 	mtk_clk_register_dividers(top_adj_divs, ARRAY_SIZE(top_adj_divs), base,
 			&mt2712_clk_lock, top_clk_data);
-	mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks),
-			top_clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, top_clks,
+			       ARRAY_SIZE(top_clks), top_clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, top_clk_data);
 
@@ -1344,8 +1344,8 @@ static int clk_mt2712_infra_probe(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
 
-	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
-			clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, infra_clks,
+			       ARRAY_SIZE(infra_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
@@ -1366,8 +1366,8 @@ static int clk_mt2712_peri_probe(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_PERI_NR_CLK);
 
-	mtk_clk_register_gates(node, peri_clks, ARRAY_SIZE(peri_clks),
-			clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, peri_clks,
+			       ARRAY_SIZE(peri_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
diff --git a/drivers/clk/mediatek/clk-mt6765.c b/drivers/clk/mediatek/clk-mt6765.c
index 2c6a52ff5564e..4a7bc6e04580d 100644
--- a/drivers/clk/mediatek/clk-mt6765.c
+++ b/drivers/clk/mediatek/clk-mt6765.c
@@ -743,7 +743,7 @@ static int clk_mt6765_apmixed_probe(struct platform_device *pdev)
 
 	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
 
-	mtk_clk_register_gates(node, apmixed_clks,
+	mtk_clk_register_gates(&pdev->dev, node, apmixed_clks,
 			       ARRAY_SIZE(apmixed_clks), clk_data);
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
@@ -784,8 +784,8 @@ static int clk_mt6765_top_probe(struct platform_device *pdev)
 				 clk_data);
 	mtk_clk_register_muxes(top_muxes, ARRAY_SIZE(top_muxes), node,
 			       &mt6765_clk_lock, clk_data);
-	mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks),
-			       clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, top_clks,
+			       ARRAY_SIZE(top_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
@@ -820,8 +820,8 @@ static int clk_mt6765_ifr_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	mtk_clk_register_gates(node, ifr_clks, ARRAY_SIZE(ifr_clks),
-			       clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, ifr_clks,
+			       ARRAY_SIZE(ifr_clks), clk_data);
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
 	if (r)
diff --git a/drivers/clk/mediatek/clk-mt6779-mm.c b/drivers/clk/mediatek/clk-mt6779-mm.c
index eda8cbee3d234..2cccf62d3b36f 100644
--- a/drivers/clk/mediatek/clk-mt6779-mm.c
+++ b/drivers/clk/mediatek/clk-mt6779-mm.c
@@ -93,8 +93,8 @@ static int clk_mt6779_mm_probe(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_MM_NR_CLK);
 
-	mtk_clk_register_gates(node, mm_clks, ARRAY_SIZE(mm_clks),
-			       clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, mm_clks,
+			       ARRAY_SIZE(mm_clks), clk_data);
 
 	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
diff --git a/drivers/clk/mediatek/clk-mt6779.c b/drivers/clk/mediatek/clk-mt6779.c
index 39dadc9547088..5a396d2464ce5 100644
--- a/drivers/clk/mediatek/clk-mt6779.c
+++ b/drivers/clk/mediatek/clk-mt6779.c
@@ -1223,7 +1223,7 @@ static int clk_mt6779_apmixed_probe(struct platform_device *pdev)
 
 	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
 
-	mtk_clk_register_gates(node, apmixed_clks,
+	mtk_clk_register_gates(&pdev->dev, node, apmixed_clks,
 			       ARRAY_SIZE(apmixed_clks), clk_data);
 
 	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
@@ -1267,8 +1267,8 @@ static int clk_mt6779_infra_probe(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
 
-	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
-			       clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, infra_clks,
+			       ARRAY_SIZE(infra_clks), clk_data);
 
 	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
diff --git a/drivers/clk/mediatek/clk-mt6795-infracfg.c b/drivers/clk/mediatek/clk-mt6795-infracfg.c
index df7eed6e071e3..8025d171d6923 100644
--- a/drivers/clk/mediatek/clk-mt6795-infracfg.c
+++ b/drivers/clk/mediatek/clk-mt6795-infracfg.c
@@ -101,7 +101,8 @@ static int clk_mt6795_infracfg_probe(struct platform_device *pdev)
 	if (ret)
 		goto free_clk_data;
 
-	ret = mtk_clk_register_gates(node, infra_gates, ARRAY_SIZE(infra_gates), clk_data);
+	ret = mtk_clk_register_gates(&pdev->dev, node, infra_gates,
+				     ARRAY_SIZE(infra_gates), clk_data);
 	if (ret)
 		goto free_clk_data;
 
diff --git a/drivers/clk/mediatek/clk-mt6795-mm.c b/drivers/clk/mediatek/clk-mt6795-mm.c
index fd73f202f2925..eebb6143ada22 100644
--- a/drivers/clk/mediatek/clk-mt6795-mm.c
+++ b/drivers/clk/mediatek/clk-mt6795-mm.c
@@ -87,7 +87,8 @@ static int clk_mt6795_mm_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	ret = mtk_clk_register_gates(node, mm_gates, ARRAY_SIZE(mm_gates), clk_data);
+	ret = mtk_clk_register_gates(&pdev->dev, node, mm_gates,
+				     ARRAY_SIZE(mm_gates), clk_data);
 	if (ret)
 		goto free_clk_data;
 
diff --git a/drivers/clk/mediatek/clk-mt6795-pericfg.c b/drivers/clk/mediatek/clk-mt6795-pericfg.c
index cb28d35dad59b..f69e715e0c1f3 100644
--- a/drivers/clk/mediatek/clk-mt6795-pericfg.c
+++ b/drivers/clk/mediatek/clk-mt6795-pericfg.c
@@ -109,7 +109,8 @@ static int clk_mt6795_pericfg_probe(struct platform_device *pdev)
 	if (ret)
 		goto free_clk_data;
 
-	ret = mtk_clk_register_gates(node, peri_gates, ARRAY_SIZE(peri_gates), clk_data);
+	ret = mtk_clk_register_gates(&pdev->dev, node, peri_gates,
+				     ARRAY_SIZE(peri_gates), clk_data);
 	if (ret)
 		goto free_clk_data;
 
diff --git a/drivers/clk/mediatek/clk-mt6797-mm.c b/drivers/clk/mediatek/clk-mt6797-mm.c
index 99a63f46642fa..d5e9fe445e308 100644
--- a/drivers/clk/mediatek/clk-mt6797-mm.c
+++ b/drivers/clk/mediatek/clk-mt6797-mm.c
@@ -89,8 +89,8 @@ static int clk_mt6797_mm_probe(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_MM_NR);
 
-	mtk_clk_register_gates(node, mm_clks, ARRAY_SIZE(mm_clks),
-			       clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, mm_clks,
+			       ARRAY_SIZE(mm_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
diff --git a/drivers/clk/mediatek/clk-mt6797.c b/drivers/clk/mediatek/clk-mt6797.c
index b362e99c8f53c..29211744b1736 100644
--- a/drivers/clk/mediatek/clk-mt6797.c
+++ b/drivers/clk/mediatek/clk-mt6797.c
@@ -584,8 +584,8 @@ static int mtk_infrasys_init(struct platform_device *pdev)
 		}
 	}
 
-	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
-			       infra_clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, infra_clks,
+			       ARRAY_SIZE(infra_clks), infra_clk_data);
 	mtk_clk_register_factors(infra_fixed_divs, ARRAY_SIZE(infra_fixed_divs),
 				 infra_clk_data);
 
diff --git a/drivers/clk/mediatek/clk-mt7622-aud.c b/drivers/clk/mediatek/clk-mt7622-aud.c
index b17731fa11445..e9070d0bea8d6 100644
--- a/drivers/clk/mediatek/clk-mt7622-aud.c
+++ b/drivers/clk/mediatek/clk-mt7622-aud.c
@@ -114,8 +114,8 @@ static int clk_mt7622_audiosys_init(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_AUDIO_NR_CLK);
 
-	mtk_clk_register_gates(node, audio_clks, ARRAY_SIZE(audio_clks),
-			       clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, audio_clks,
+			       ARRAY_SIZE(audio_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r) {
diff --git a/drivers/clk/mediatek/clk-mt7622-eth.c b/drivers/clk/mediatek/clk-mt7622-eth.c
index a60190e834186..ece0f7a7c5f62 100644
--- a/drivers/clk/mediatek/clk-mt7622-eth.c
+++ b/drivers/clk/mediatek/clk-mt7622-eth.c
@@ -69,8 +69,8 @@ static int clk_mt7622_ethsys_init(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_ETH_NR_CLK);
 
-	mtk_clk_register_gates(node, eth_clks, ARRAY_SIZE(eth_clks),
-			       clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, eth_clks,
+			       ARRAY_SIZE(eth_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
@@ -91,8 +91,8 @@ static int clk_mt7622_sgmiisys_init(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_SGMII_NR_CLK);
 
-	mtk_clk_register_gates(node, sgmii_clks, ARRAY_SIZE(sgmii_clks),
-			       clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, sgmii_clks,
+			       ARRAY_SIZE(sgmii_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
diff --git a/drivers/clk/mediatek/clk-mt7622-hif.c b/drivers/clk/mediatek/clk-mt7622-hif.c
index 55baa6d06a205..c57ac2273c4e2 100644
--- a/drivers/clk/mediatek/clk-mt7622-hif.c
+++ b/drivers/clk/mediatek/clk-mt7622-hif.c
@@ -80,8 +80,8 @@ static int clk_mt7622_ssusbsys_init(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_SSUSB_NR_CLK);
 
-	mtk_clk_register_gates(node, ssusb_clks, ARRAY_SIZE(ssusb_clks),
-			       clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, ssusb_clks,
+			       ARRAY_SIZE(ssusb_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
@@ -102,8 +102,8 @@ static int clk_mt7622_pciesys_init(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_PCIE_NR_CLK);
 
-	mtk_clk_register_gates(node, pcie_clks, ARRAY_SIZE(pcie_clks),
-			       clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, pcie_clks,
+			       ARRAY_SIZE(pcie_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index eebbb87906930..bba88018f056a 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -621,8 +621,8 @@ static int mtk_topckgen_init(struct platform_device *pdev)
 	mtk_clk_register_dividers(top_adj_divs, ARRAY_SIZE(top_adj_divs),
 				  base, &mt7622_clk_lock, clk_data);
 
-	mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks),
-			       clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, top_clks,
+			       ARRAY_SIZE(top_clks), clk_data);
 
 	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
@@ -635,8 +635,8 @@ static int mtk_infrasys_init(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
 
-	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
-			       clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, infra_clks,
+			       ARRAY_SIZE(infra_clks), clk_data);
 
 	mtk_clk_register_cpumuxes(node, infra_muxes, ARRAY_SIZE(infra_muxes),
 				  clk_data);
@@ -663,7 +663,7 @@ static int mtk_apmixedsys_init(struct platform_device *pdev)
 	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls),
 			      clk_data);
 
-	mtk_clk_register_gates(node, apmixed_clks,
+	mtk_clk_register_gates(&pdev->dev, node, apmixed_clks,
 			       ARRAY_SIZE(apmixed_clks), clk_data);
 
 	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
@@ -682,8 +682,8 @@ static int mtk_pericfg_init(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_PERI_NR_CLK);
 
-	mtk_clk_register_gates(node, peri_clks, ARRAY_SIZE(peri_clks),
-			       clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, peri_clks,
+			       ARRAY_SIZE(peri_clks), clk_data);
 
 	mtk_clk_register_composites(peri_muxes, ARRAY_SIZE(peri_muxes), base,
 				    &mt7622_clk_lock, clk_data);
diff --git a/drivers/clk/mediatek/clk-mt7629-eth.c b/drivers/clk/mediatek/clk-mt7629-eth.c
index e1d2635c72c10..eab838af6d413 100644
--- a/drivers/clk/mediatek/clk-mt7629-eth.c
+++ b/drivers/clk/mediatek/clk-mt7629-eth.c
@@ -82,7 +82,8 @@ static int clk_mt7629_ethsys_init(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	mtk_clk_register_gates(node, eth_clks, CLK_ETH_NR_CLK, clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, eth_clks,
+			       CLK_ETH_NR_CLK, clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
@@ -106,8 +107,8 @@ static int clk_mt7629_sgmiisys_init(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	mtk_clk_register_gates(node, sgmii_clks[id++], CLK_SGMII_NR_CLK,
-			       clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, sgmii_clks[id++],
+			       CLK_SGMII_NR_CLK, clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
diff --git a/drivers/clk/mediatek/clk-mt7629-hif.c b/drivers/clk/mediatek/clk-mt7629-hif.c
index 3628811a2f57f..804900792e490 100644
--- a/drivers/clk/mediatek/clk-mt7629-hif.c
+++ b/drivers/clk/mediatek/clk-mt7629-hif.c
@@ -75,8 +75,8 @@ static int clk_mt7629_ssusbsys_init(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_SSUSB_NR_CLK);
 
-	mtk_clk_register_gates(node, ssusb_clks, ARRAY_SIZE(ssusb_clks),
-			       clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, ssusb_clks,
+			       ARRAY_SIZE(ssusb_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
@@ -97,8 +97,8 @@ static int clk_mt7629_pciesys_init(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_PCIE_NR_CLK);
 
-	mtk_clk_register_gates(node, pcie_clks, ARRAY_SIZE(pcie_clks),
-			       clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, pcie_clks,
+			       ARRAY_SIZE(pcie_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
diff --git a/drivers/clk/mediatek/clk-mt7629.c b/drivers/clk/mediatek/clk-mt7629.c
index 01ee45fcd7e34..c0cdaf0242961 100644
--- a/drivers/clk/mediatek/clk-mt7629.c
+++ b/drivers/clk/mediatek/clk-mt7629.c
@@ -585,8 +585,8 @@ static int mtk_infrasys_init(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
-			       clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, infra_clks,
+			       ARRAY_SIZE(infra_clks), clk_data);
 
 	mtk_clk_register_cpumuxes(node, infra_muxes, ARRAY_SIZE(infra_muxes),
 				  clk_data);
@@ -610,8 +610,8 @@ static int mtk_pericfg_init(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	mtk_clk_register_gates(node, peri_clks, ARRAY_SIZE(peri_clks),
-			       clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, peri_clks,
+			       ARRAY_SIZE(peri_clks), clk_data);
 
 	mtk_clk_register_composites(peri_muxes, ARRAY_SIZE(peri_muxes), base,
 				    &mt7629_clk_lock, clk_data);
@@ -637,7 +637,7 @@ static int mtk_apmixedsys_init(struct platform_device *pdev)
 	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls),
 			      clk_data);
 
-	mtk_clk_register_gates(node, apmixed_clks,
+	mtk_clk_register_gates(&pdev->dev, node, apmixed_clks,
 			       ARRAY_SIZE(apmixed_clks), clk_data);
 
 	clk_prepare_enable(clk_data->hws[CLK_APMIXED_ARMPLL]->clk);
diff --git a/drivers/clk/mediatek/clk-mt7986-eth.c b/drivers/clk/mediatek/clk-mt7986-eth.c
index c21e1d672384a..e04bc6845ea6d 100644
--- a/drivers/clk/mediatek/clk-mt7986-eth.c
+++ b/drivers/clk/mediatek/clk-mt7986-eth.c
@@ -72,8 +72,8 @@ static void __init mtk_sgmiisys_0_init(struct device_node *node)
 
 	clk_data = mtk_alloc_clk_data(ARRAY_SIZE(sgmii0_clks));
 
-	mtk_clk_register_gates(node, sgmii0_clks, ARRAY_SIZE(sgmii0_clks),
-			       clk_data);
+	mtk_clk_register_gates(NULL, node, sgmii0_clks,
+			       ARRAY_SIZE(sgmii0_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
@@ -90,8 +90,8 @@ static void __init mtk_sgmiisys_1_init(struct device_node *node)
 
 	clk_data = mtk_alloc_clk_data(ARRAY_SIZE(sgmii1_clks));
 
-	mtk_clk_register_gates(node, sgmii1_clks, ARRAY_SIZE(sgmii1_clks),
-			       clk_data);
+	mtk_clk_register_gates(NULL, node, sgmii1_clks,
+			       ARRAY_SIZE(sgmii1_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
@@ -109,7 +109,7 @@ static void __init mtk_ethsys_init(struct device_node *node)
 
 	clk_data = mtk_alloc_clk_data(ARRAY_SIZE(eth_clks));
 
-	mtk_clk_register_gates(node, eth_clks, ARRAY_SIZE(eth_clks), clk_data);
+	mtk_clk_register_gates(NULL, node, eth_clks, ARRAY_SIZE(eth_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
diff --git a/drivers/clk/mediatek/clk-mt7986-infracfg.c b/drivers/clk/mediatek/clk-mt7986-infracfg.c
index 74e68a7197301..578f150e0ee52 100644
--- a/drivers/clk/mediatek/clk-mt7986-infracfg.c
+++ b/drivers/clk/mediatek/clk-mt7986-infracfg.c
@@ -180,8 +180,8 @@ static int clk_mt7986_infracfg_probe(struct platform_device *pdev)
 	mtk_clk_register_factors(infra_divs, ARRAY_SIZE(infra_divs), clk_data);
 	mtk_clk_register_muxes(infra_muxes, ARRAY_SIZE(infra_muxes), node,
 			       &mt7986_clk_lock, clk_data);
-	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
-			       clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, infra_clks,
+			       ARRAY_SIZE(infra_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r) {
diff --git a/drivers/clk/mediatek/clk-mt8135.c b/drivers/clk/mediatek/clk-mt8135.c
index 3ea06d2ec2f11..8137cf2252724 100644
--- a/drivers/clk/mediatek/clk-mt8135.c
+++ b/drivers/clk/mediatek/clk-mt8135.c
@@ -553,8 +553,8 @@ static void __init mtk_infrasys_init(struct device_node *node)
 
 	clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
 
-	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
-						clk_data);
+	mtk_clk_register_gates(NULL, node, infra_clks,
+			       ARRAY_SIZE(infra_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
@@ -579,8 +579,8 @@ static void __init mtk_pericfg_init(struct device_node *node)
 
 	clk_data = mtk_alloc_clk_data(CLK_PERI_NR_CLK);
 
-	mtk_clk_register_gates(node, peri_gates, ARRAY_SIZE(peri_gates),
-						clk_data);
+	mtk_clk_register_gates(NULL, node, peri_gates,
+			       ARRAY_SIZE(peri_gates), clk_data);
 	mtk_clk_register_composites(peri_clks, ARRAY_SIZE(peri_clks), base,
 			&mt8135_clk_lock, clk_data);
 
diff --git a/drivers/clk/mediatek/clk-mt8167-aud.c b/drivers/clk/mediatek/clk-mt8167-aud.c
index b5ac196cd9454..47a7d89d5777c 100644
--- a/drivers/clk/mediatek/clk-mt8167-aud.c
+++ b/drivers/clk/mediatek/clk-mt8167-aud.c
@@ -50,7 +50,7 @@ static void __init mtk_audsys_init(struct device_node *node)
 
 	clk_data = mtk_alloc_clk_data(CLK_AUD_NR_CLK);
 
-	mtk_clk_register_gates(node, aud_clks, ARRAY_SIZE(aud_clks), clk_data);
+	mtk_clk_register_gates(NULL, node, aud_clks, ARRAY_SIZE(aud_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
diff --git a/drivers/clk/mediatek/clk-mt8167-img.c b/drivers/clk/mediatek/clk-mt8167-img.c
index 4e7c0772b4f99..e196b3b894a16 100644
--- a/drivers/clk/mediatek/clk-mt8167-img.c
+++ b/drivers/clk/mediatek/clk-mt8167-img.c
@@ -42,7 +42,7 @@ static void __init mtk_imgsys_init(struct device_node *node)
 
 	clk_data = mtk_alloc_clk_data(CLK_IMG_NR_CLK);
 
-	mtk_clk_register_gates(node, img_clks, ARRAY_SIZE(img_clks), clk_data);
+	mtk_clk_register_gates(NULL, node, img_clks, ARRAY_SIZE(img_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
diff --git a/drivers/clk/mediatek/clk-mt8167-mfgcfg.c b/drivers/clk/mediatek/clk-mt8167-mfgcfg.c
index 192714498b2ec..602d25f4cb2e2 100644
--- a/drivers/clk/mediatek/clk-mt8167-mfgcfg.c
+++ b/drivers/clk/mediatek/clk-mt8167-mfgcfg.c
@@ -40,7 +40,7 @@ static void __init mtk_mfgcfg_init(struct device_node *node)
 
 	clk_data = mtk_alloc_clk_data(CLK_MFG_NR_CLK);
 
-	mtk_clk_register_gates(node, mfg_clks, ARRAY_SIZE(mfg_clks), clk_data);
+	mtk_clk_register_gates(NULL, node, mfg_clks, ARRAY_SIZE(mfg_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
diff --git a/drivers/clk/mediatek/clk-mt8167-mm.c b/drivers/clk/mediatek/clk-mt8167-mm.c
index a94961b7b8cc6..abc70e1221bf9 100644
--- a/drivers/clk/mediatek/clk-mt8167-mm.c
+++ b/drivers/clk/mediatek/clk-mt8167-mm.c
@@ -98,8 +98,8 @@ static int clk_mt8167_mm_probe(struct platform_device *pdev)
 
 	data = &mt8167_mmsys_driver_data;
 
-	ret = mtk_clk_register_gates(node, data->gates_clk, data->gates_num,
-				     clk_data);
+	ret = mtk_clk_register_gates(&pdev->dev, node, data->gates_clk,
+				     data->gates_num, clk_data);
 	if (ret)
 		return ret;
 
diff --git a/drivers/clk/mediatek/clk-mt8167-vdec.c b/drivers/clk/mediatek/clk-mt8167-vdec.c
index 38f0ba357d599..92bc05d997985 100644
--- a/drivers/clk/mediatek/clk-mt8167-vdec.c
+++ b/drivers/clk/mediatek/clk-mt8167-vdec.c
@@ -49,7 +49,8 @@ static void __init mtk_vdecsys_init(struct device_node *node)
 
 	clk_data = mtk_alloc_clk_data(CLK_VDEC_NR_CLK);
 
-	mtk_clk_register_gates(node, vdec_clks, ARRAY_SIZE(vdec_clks), clk_data);
+	mtk_clk_register_gates(NULL, node, vdec_clks, ARRAY_SIZE(vdec_clks),
+			       clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
diff --git a/drivers/clk/mediatek/clk-mt8167.c b/drivers/clk/mediatek/clk-mt8167.c
index f900ac4bf7b8d..59fe82ba5c7a1 100644
--- a/drivers/clk/mediatek/clk-mt8167.c
+++ b/drivers/clk/mediatek/clk-mt8167.c
@@ -937,7 +937,7 @@ static void __init mtk_topckgen_init(struct device_node *node)
 
 	mtk_clk_register_fixed_clks(fixed_clks, ARRAY_SIZE(fixed_clks),
 				    clk_data);
-	mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks), clk_data);
+	mtk_clk_register_gates(NULL, node, top_clks, ARRAY_SIZE(top_clks), clk_data);
 
 	mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
 	mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes), base,
diff --git a/drivers/clk/mediatek/clk-mt8173-mm.c b/drivers/clk/mediatek/clk-mt8173-mm.c
index 5826eabdc9c77..444a3d58c8bf5 100644
--- a/drivers/clk/mediatek/clk-mt8173-mm.c
+++ b/drivers/clk/mediatek/clk-mt8173-mm.c
@@ -112,8 +112,8 @@ static int clk_mt8173_mm_probe(struct platform_device *pdev)
 
 	data = &mt8173_mmsys_driver_data;
 
-	ret = mtk_clk_register_gates(node, data->gates_clk, data->gates_num,
-				     clk_data);
+	ret = mtk_clk_register_gates(&pdev->dev, node, data->gates_clk,
+				     data->gates_num, clk_data);
 	if (ret)
 		return ret;
 
diff --git a/drivers/clk/mediatek/clk-mt8173.c b/drivers/clk/mediatek/clk-mt8173.c
index b8529ee7199da..74ed7dd129f47 100644
--- a/drivers/clk/mediatek/clk-mt8173.c
+++ b/drivers/clk/mediatek/clk-mt8173.c
@@ -888,8 +888,8 @@ static void __init mtk_infrasys_init(struct device_node *node)
 
 	clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
 
-	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
-						clk_data);
+	mtk_clk_register_gates(NULL, node, infra_clks,
+			       ARRAY_SIZE(infra_clks), clk_data);
 	mtk_clk_register_factors(infra_divs, ARRAY_SIZE(infra_divs), clk_data);
 
 	mtk_clk_register_cpumuxes(node, cpu_muxes, ARRAY_SIZE(cpu_muxes),
@@ -918,8 +918,8 @@ static void __init mtk_pericfg_init(struct device_node *node)
 
 	clk_data = mtk_alloc_clk_data(CLK_PERI_NR_CLK);
 
-	mtk_clk_register_gates(node, peri_gates, ARRAY_SIZE(peri_gates),
-						clk_data);
+	mtk_clk_register_gates(NULL, node, peri_gates,
+			       ARRAY_SIZE(peri_gates), clk_data);
 	mtk_clk_register_composites(peri_clks, ARRAY_SIZE(peri_clks), base,
 			&mt8173_clk_lock, clk_data);
 
@@ -1062,8 +1062,8 @@ static void __init mtk_imgsys_init(struct device_node *node)
 
 	clk_data = mtk_alloc_clk_data(CLK_IMG_NR_CLK);
 
-	mtk_clk_register_gates(node, img_clks, ARRAY_SIZE(img_clks),
-						clk_data);
+	mtk_clk_register_gates(NULL, node, img_clks,
+			       ARRAY_SIZE(img_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
@@ -1080,8 +1080,8 @@ static void __init mtk_vdecsys_init(struct device_node *node)
 
 	clk_data = mtk_alloc_clk_data(CLK_VDEC_NR_CLK);
 
-	mtk_clk_register_gates(node, vdec_clks, ARRAY_SIZE(vdec_clks),
-						clk_data);
+	mtk_clk_register_gates(NULL, node, vdec_clks,
+			       ARRAY_SIZE(vdec_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
@@ -1097,8 +1097,8 @@ static void __init mtk_vencsys_init(struct device_node *node)
 
 	clk_data = mtk_alloc_clk_data(CLK_VENC_NR_CLK);
 
-	mtk_clk_register_gates(node, venc_clks, ARRAY_SIZE(venc_clks),
-						clk_data);
+	mtk_clk_register_gates(NULL, node, venc_clks,
+			       ARRAY_SIZE(venc_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
@@ -1114,8 +1114,8 @@ static void __init mtk_vencltsys_init(struct device_node *node)
 
 	clk_data = mtk_alloc_clk_data(CLK_VENCLT_NR_CLK);
 
-	mtk_clk_register_gates(node, venclt_clks, ARRAY_SIZE(venclt_clks),
-						clk_data);
+	mtk_clk_register_gates(NULL, node, venclt_clks,
+			       ARRAY_SIZE(venclt_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
diff --git a/drivers/clk/mediatek/clk-mt8183-audio.c b/drivers/clk/mediatek/clk-mt8183-audio.c
index b2d7746eddbed..f358a6e7a3408 100644
--- a/drivers/clk/mediatek/clk-mt8183-audio.c
+++ b/drivers/clk/mediatek/clk-mt8183-audio.c
@@ -75,8 +75,8 @@ static int clk_mt8183_audio_probe(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_AUDIO_NR_CLK);
 
-	mtk_clk_register_gates(node, audio_clks, ARRAY_SIZE(audio_clks),
-			clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, audio_clks,
+			       ARRAY_SIZE(audio_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
diff --git a/drivers/clk/mediatek/clk-mt8183-mm.c b/drivers/clk/mediatek/clk-mt8183-mm.c
index 11ecc6fb0065b..3580315309132 100644
--- a/drivers/clk/mediatek/clk-mt8183-mm.c
+++ b/drivers/clk/mediatek/clk-mt8183-mm.c
@@ -90,8 +90,8 @@ static int clk_mt8183_mm_probe(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_MM_NR_CLK);
 
-	mtk_clk_register_gates(node, mm_clks, ARRAY_SIZE(mm_clks),
-			clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, mm_clks,
+			       ARRAY_SIZE(mm_clks), clk_data);
 
 	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index 1860a35a723a5..ba0d6ba10b359 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -1172,8 +1172,8 @@ static int clk_mt8183_apmixed_probe(struct platform_device *pdev)
 
 	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
 
-	mtk_clk_register_gates(node, apmixed_clks, ARRAY_SIZE(apmixed_clks),
-		clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, apmixed_clks,
+			       ARRAY_SIZE(apmixed_clks), clk_data);
 
 	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
@@ -1247,8 +1247,8 @@ static int clk_mt8183_top_probe(struct platform_device *pdev)
 	mtk_clk_register_composites(top_aud_divs, ARRAY_SIZE(top_aud_divs),
 		base, &mt8183_clk_lock, top_clk_data);
 
-	mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks),
-		top_clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, top_clks,
+			       ARRAY_SIZE(top_clks), top_clk_data);
 
 	ret = clk_mt8183_reg_mfg_mux_notifier(&pdev->dev,
 					      top_clk_data->hws[CLK_TOP_MUX_MFG]->clk);
@@ -1267,8 +1267,8 @@ static int clk_mt8183_infra_probe(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
 
-	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
-		clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, infra_clks,
+			       ARRAY_SIZE(infra_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r) {
@@ -1290,8 +1290,8 @@ static int clk_mt8183_peri_probe(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_PERI_NR_CLK);
 
-	mtk_clk_register_gates(node, peri_clks, ARRAY_SIZE(peri_clks),
-			       clk_data);
+	mtk_clk_register_gates(&pdev->dev, node, peri_clks,
+			       ARRAY_SIZE(peri_clks), clk_data);
 
 	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
diff --git a/drivers/clk/mediatek/clk-mt8186-mm.c b/drivers/clk/mediatek/clk-mt8186-mm.c
index 1d33be4079470..0b72607777fa1 100644
--- a/drivers/clk/mediatek/clk-mt8186-mm.c
+++ b/drivers/clk/mediatek/clk-mt8186-mm.c
@@ -69,7 +69,8 @@ static int clk_mt8186_mm_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	r = mtk_clk_register_gates(node, mm_clks, ARRAY_SIZE(mm_clks), clk_data);
+	r = mtk_clk_register_gates(&pdev->dev, node, mm_clks,
+				   ARRAY_SIZE(mm_clks), clk_data);
 	if (r)
 		goto free_mm_data;
 
diff --git a/drivers/clk/mediatek/clk-mt8192-aud.c b/drivers/clk/mediatek/clk-mt8192-aud.c
index 8c989bffd8c72..f524188fe4c2d 100644
--- a/drivers/clk/mediatek/clk-mt8192-aud.c
+++ b/drivers/clk/mediatek/clk-mt8192-aud.c
@@ -87,7 +87,8 @@ static int clk_mt8192_aud_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	r = mtk_clk_register_gates(node, aud_clks, ARRAY_SIZE(aud_clks), clk_data);
+	r = mtk_clk_register_gates(&pdev->dev, node, aud_clks,
+				   ARRAY_SIZE(aud_clks), clk_data);
 	if (r)
 		return r;
 
diff --git a/drivers/clk/mediatek/clk-mt8192-mm.c b/drivers/clk/mediatek/clk-mt8192-mm.c
index 1be3ff4d407db..e9eb4cf8349ac 100644
--- a/drivers/clk/mediatek/clk-mt8192-mm.c
+++ b/drivers/clk/mediatek/clk-mt8192-mm.c
@@ -91,7 +91,8 @@ static int clk_mt8192_mm_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	r = mtk_clk_register_gates(node, mm_clks, ARRAY_SIZE(mm_clks), clk_data);
+	r = mtk_clk_register_gates(&pdev->dev, node, mm_clks,
+			       ARRAY_SIZE(mm_clks), clk_data);
 	if (r)
 		return r;
 
diff --git a/drivers/clk/mediatek/clk-mt8192.c b/drivers/clk/mediatek/clk-mt8192.c
index 508af9bbcc46c..ac1eee513649b 100644
--- a/drivers/clk/mediatek/clk-mt8192.c
+++ b/drivers/clk/mediatek/clk-mt8192.c
@@ -1127,8 +1127,8 @@ static int clk_mt8192_top_probe(struct platform_device *pdev)
 	if (r)
 		goto unregister_top_composites;
 
-	r = mtk_clk_register_gates_with_dev(node, top_clks, ARRAY_SIZE(top_clks),
-					    top_clk_data, &pdev->dev);
+	r = mtk_clk_register_gates(&pdev->dev, node, top_clks,
+				   ARRAY_SIZE(top_clks), top_clk_data);
 	if (r)
 		goto unregister_adj_divs_composites;
 
@@ -1171,8 +1171,8 @@ static int clk_mt8192_infra_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	r = mtk_clk_register_gates_with_dev(node, infra_clks, ARRAY_SIZE(infra_clks),
-					    clk_data, &pdev->dev);
+	r = mtk_clk_register_gates(&pdev->dev, node, infra_clks,
+				   ARRAY_SIZE(infra_clks), clk_data);
 	if (r)
 		goto free_clk_data;
 
@@ -1203,8 +1203,8 @@ static int clk_mt8192_peri_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	r = mtk_clk_register_gates_with_dev(node, peri_clks, ARRAY_SIZE(peri_clks),
-					    clk_data, &pdev->dev);
+	r = mtk_clk_register_gates(&pdev->dev, node, peri_clks,
+				   ARRAY_SIZE(peri_clks), clk_data);
 	if (r)
 		goto free_clk_data;
 
@@ -1232,9 +1232,8 @@ static int clk_mt8192_apmixed_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
-	r = mtk_clk_register_gates_with_dev(node, apmixed_clks,
-					    ARRAY_SIZE(apmixed_clks), clk_data,
-					    &pdev->dev);
+	r = mtk_clk_register_gates(&pdev->dev, node, apmixed_clks,
+				   ARRAY_SIZE(apmixed_clks), clk_data);
 	if (r)
 		goto free_clk_data;
 
diff --git a/drivers/clk/mediatek/clk-mt8195-apmixedsys.c b/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
index 0dfed6ec4d155..1bc917f2667e4 100644
--- a/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
@@ -124,7 +124,8 @@ static int clk_mt8195_apmixed_probe(struct platform_device *pdev)
 	if (r)
 		goto free_apmixed_data;
 
-	r = mtk_clk_register_gates(node, apmixed_clks, ARRAY_SIZE(apmixed_clks), clk_data);
+	r = mtk_clk_register_gates(&pdev->dev, node, apmixed_clks,
+				   ARRAY_SIZE(apmixed_clks), clk_data);
 	if (r)
 		goto unregister_plls;
 
diff --git a/drivers/clk/mediatek/clk-mt8195-topckgen.c b/drivers/clk/mediatek/clk-mt8195-topckgen.c
index 1e016329c1d23..e6e0298d64494 100644
--- a/drivers/clk/mediatek/clk-mt8195-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt8195-topckgen.c
@@ -1286,7 +1286,8 @@ static int clk_mt8195_topck_probe(struct platform_device *pdev)
 	if (r)
 		goto unregister_muxes;
 
-	r = mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks), top_clk_data);
+	r = mtk_clk_register_gates(&pdev->dev, node, top_clks,
+				   ARRAY_SIZE(top_clks), top_clk_data);
 	if (r)
 		goto unregister_composite_divs;
 
diff --git a/drivers/clk/mediatek/clk-mt8195-vdo0.c b/drivers/clk/mediatek/clk-mt8195-vdo0.c
index 07b46bfd50406..839b730688acb 100644
--- a/drivers/clk/mediatek/clk-mt8195-vdo0.c
+++ b/drivers/clk/mediatek/clk-mt8195-vdo0.c
@@ -104,7 +104,8 @@ static int clk_mt8195_vdo0_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	r = mtk_clk_register_gates(node, vdo0_clks, ARRAY_SIZE(vdo0_clks), clk_data);
+	r = mtk_clk_register_gates(&pdev->dev, node, vdo0_clks,
+				   ARRAY_SIZE(vdo0_clks), clk_data);
 	if (r)
 		goto free_vdo0_data;
 
diff --git a/drivers/clk/mediatek/clk-mt8195-vdo1.c b/drivers/clk/mediatek/clk-mt8195-vdo1.c
index 835335b9d87bb..7df695b289258 100644
--- a/drivers/clk/mediatek/clk-mt8195-vdo1.c
+++ b/drivers/clk/mediatek/clk-mt8195-vdo1.c
@@ -131,7 +131,8 @@ static int clk_mt8195_vdo1_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	r = mtk_clk_register_gates(node, vdo1_clks, ARRAY_SIZE(vdo1_clks), clk_data);
+	r = mtk_clk_register_gates(&pdev->dev, node, vdo1_clks,
+				   ARRAY_SIZE(vdo1_clks), clk_data);
 	if (r)
 		goto free_vdo1_data;
 
diff --git a/drivers/clk/mediatek/clk-mt8365-mm.c b/drivers/clk/mediatek/clk-mt8365-mm.c
index 5c8bf18ab1f1d..22c75a03a6452 100644
--- a/drivers/clk/mediatek/clk-mt8365-mm.c
+++ b/drivers/clk/mediatek/clk-mt8365-mm.c
@@ -81,9 +81,8 @@ static int clk_mt8365_mm_probe(struct platform_device *pdev)
 
 	clk_data = mtk_alloc_clk_data(CLK_MM_NR_CLK);
 
-	ret = mtk_clk_register_gates_with_dev(node, mm_clks,
-					      ARRAY_SIZE(mm_clks), clk_data,
-					      dev);
+	ret = mtk_clk_register_gates(dev, node, mm_clks,
+				     ARRAY_SIZE(mm_clks), clk_data);
 	if (ret)
 		goto err_free_clk_data;
 
diff --git a/drivers/clk/mediatek/clk-mt8365.c b/drivers/clk/mediatek/clk-mt8365.c
index adfecb618f102..b30cbeae1c3d3 100644
--- a/drivers/clk/mediatek/clk-mt8365.c
+++ b/drivers/clk/mediatek/clk-mt8365.c
@@ -1019,8 +1019,8 @@ static int clk_mt8365_infra_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	ret = mtk_clk_register_gates(node, ifr_clks, ARRAY_SIZE(ifr_clks),
-				     clk_data);
+	ret = mtk_clk_register_gates(&pdev->dev, node, ifr_clks,
+				     ARRAY_SIZE(ifr_clks), clk_data);
 	if (ret)
 		goto free_clk_data;
 
diff --git a/drivers/clk/mediatek/clk-mt8516-aud.c b/drivers/clk/mediatek/clk-mt8516-aud.c
index a3dafc719799c..a6ae8003b9ff6 100644
--- a/drivers/clk/mediatek/clk-mt8516-aud.c
+++ b/drivers/clk/mediatek/clk-mt8516-aud.c
@@ -48,7 +48,7 @@ static void __init mtk_audsys_init(struct device_node *node)
 
 	clk_data = mtk_alloc_clk_data(CLK_AUD_NR_CLK);
 
-	mtk_clk_register_gates(node, aud_clks, ARRAY_SIZE(aud_clks), clk_data);
+	mtk_clk_register_gates(NULL, node, aud_clks, ARRAY_SIZE(aud_clks), clk_data);
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
diff --git a/drivers/clk/mediatek/clk-mt8516.c b/drivers/clk/mediatek/clk-mt8516.c
index 056953d594c66..bde0b8c761d47 100644
--- a/drivers/clk/mediatek/clk-mt8516.c
+++ b/drivers/clk/mediatek/clk-mt8516.c
@@ -655,7 +655,7 @@ static void __init mtk_topckgen_init(struct device_node *node)
 
 	mtk_clk_register_fixed_clks(fixed_clks, ARRAY_SIZE(fixed_clks),
 				    clk_data);
-	mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks), clk_data);
+	mtk_clk_register_gates(NULL, node, top_clks, ARRAY_SIZE(top_clks), clk_data);
 
 	mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
 	mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes), base,
diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index d31f01d0ba1c2..6123b234d3c3b 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -459,8 +459,8 @@ int mtk_clk_simple_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	r = mtk_clk_register_gates_with_dev(node, mcd->clks, mcd->num_clks,
-					    clk_data, &pdev->dev);
+	r = mtk_clk_register_gates(&pdev->dev, node, mcd->clks, mcd->num_clks,
+				   clk_data);
 	if (r)
 		goto free_data;
 
-- 
2.43.0




