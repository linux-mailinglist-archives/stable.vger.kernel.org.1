Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4C36FAC6B
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235596AbjEHLYY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235706AbjEHLYM (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:24:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4F439BBD
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:24:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0CE262D0D
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:24:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62518C433D2;
        Mon,  8 May 2023 11:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683545042;
        bh=KrNPMfkSQ5/JfqgGYwz5qB7SNDQeKkRZwnoDN6hTeM8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OHDRBYslfAXe0kI1wYwsjJkiUdRhGmlbfEmNV48G5mjNiD/QHr04XK3WTvGNJIvOa
         JJwW3CiK/eoq6vp58uuyqu9+Fyj3aHUSqD2PHL9jjZTjbnYjVXblCfM0mZr3uOvuF3
         rQBSjWgvHk8GBuDtcmh5OEwxwKlXiiLrr9f2vX0s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 578/694] clk: mediatek: Consistently use GATE_MTK() macro
Date:   Mon,  8 May 2023 11:46:53 +0200
Message-Id: <20230508094453.666430596@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

[ Upstream commit 4c85e20b656607897e3bb06ff565822fa4b4de95 ]

All the various MediaTek clock drivers are, in a way or another,
redefining the GATE_MTK() macro with different names: while some
are doing that by actually using GATE_MTK(), others are copying
it entirely (hence, entirely redefining it).

Change all clock drivers to always and consistently use this macro.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Tested-by: Chen-Yu Tsai <wenst@chromium.org> # MT8183, MT8192, MT8195 Chromebooks
Link: https://lore.kernel.org/r/20230306140543.1813621-23-angelogioacchino.delregno@collabora.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Stable-dep-of: fa8c0d01df62 ("clk: mediatek: mt7622: Properly use CLK_IS_CRITICAL flag")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/mediatek/clk-mt2701-aud.c      | 40 +++--------
 drivers/clk/mediatek/clk-mt2701-bdp.c      | 20 ++----
 drivers/clk/mediatek/clk-mt2701-eth.c      | 10 +--
 drivers/clk/mediatek/clk-mt2701-g3d.c      | 10 +--
 drivers/clk/mediatek/clk-mt2701-hif.c      | 10 +--
 drivers/clk/mediatek/clk-mt2701-img.c      | 10 +--
 drivers/clk/mediatek/clk-mt2701-mm.c       | 20 ++----
 drivers/clk/mediatek/clk-mt2701-vdec.c     | 20 ++----
 drivers/clk/mediatek/clk-mt2701.c          | 40 +++--------
 drivers/clk/mediatek/clk-mt2712-bdp.c      | 10 +--
 drivers/clk/mediatek/clk-mt2712-img.c      | 10 +--
 drivers/clk/mediatek/clk-mt2712-jpgdec.c   | 10 +--
 drivers/clk/mediatek/clk-mt2712-mfg.c      | 10 +--
 drivers/clk/mediatek/clk-mt2712-mm.c       | 34 +++------
 drivers/clk/mediatek/clk-mt2712-vdec.c     | 20 ++----
 drivers/clk/mediatek/clk-mt2712-venc.c     | 10 +--
 drivers/clk/mediatek/clk-mt2712.c          | 60 ++++------------
 drivers/clk/mediatek/clk-mt6765-audio.c    | 20 ++----
 drivers/clk/mediatek/clk-mt6765-cam.c      | 10 +--
 drivers/clk/mediatek/clk-mt6765-img.c      | 10 +--
 drivers/clk/mediatek/clk-mt6765-mipi0a.c   | 10 +--
 drivers/clk/mediatek/clk-mt6765-mm.c       | 10 +--
 drivers/clk/mediatek/clk-mt6765-vcodec.c   | 10 +--
 drivers/clk/mediatek/clk-mt6765.c          | 80 +++++-----------------
 drivers/clk/mediatek/clk-mt6797-img.c      | 10 +--
 drivers/clk/mediatek/clk-mt6797-mm.c       | 20 ++----
 drivers/clk/mediatek/clk-mt6797-vdec.c     | 20 ++----
 drivers/clk/mediatek/clk-mt6797-venc.c     | 10 +--
 drivers/clk/mediatek/clk-mt6797.c          | 42 ++++--------
 drivers/clk/mediatek/clk-mt7622-aud.c      | 40 +++--------
 drivers/clk/mediatek/clk-mt7622-eth.c      | 20 ++----
 drivers/clk/mediatek/clk-mt7622-hif.c      | 22 ++----
 drivers/clk/mediatek/clk-mt7622.c          | 61 ++++-------------
 drivers/clk/mediatek/clk-mt7629-eth.c      | 20 ++----
 drivers/clk/mediatek/clk-mt7629-hif.c      | 22 ++----
 drivers/clk/mediatek/clk-mt7629.c          | 40 +++--------
 drivers/clk/mediatek/clk-mt7986-eth.c      | 24 ++-----
 drivers/clk/mediatek/clk-mt7986-infracfg.c | 24 ++-----
 drivers/clk/mediatek/clk-mt8135.c          | 30 ++------
 drivers/clk/mediatek/clk-mt8167-aud.c      | 11 +--
 drivers/clk/mediatek/clk-mt8167-img.c      | 10 +--
 drivers/clk/mediatek/clk-mt8167-mfgcfg.c   | 10 +--
 drivers/clk/mediatek/clk-mt8167-mm.c       | 22 ++----
 drivers/clk/mediatek/clk-mt8167-vdec.c     | 20 ++----
 drivers/clk/mediatek/clk-mt8173-mm.c       | 22 ++----
 drivers/clk/mediatek/clk-mt8516-aud.c      | 10 +--
 drivers/clk/mediatek/clk-mt8516.c          | 60 ++++------------
 47 files changed, 224 insertions(+), 840 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt2701-aud.c b/drivers/clk/mediatek/clk-mt2701-aud.c
index 1a32d8b7db84f..21f7cc106bbe5 100644
--- a/drivers/clk/mediatek/clk-mt2701-aud.c
+++ b/drivers/clk/mediatek/clk-mt2701-aud.c
@@ -15,41 +15,17 @@
 
 #include <dt-bindings/clock/mt2701-clk.h>
 
-#define GATE_AUDIO0(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &audio0_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr,	\
-	}
+#define GATE_AUDIO0(_id, _name, _parent, _shift)		\
+	GATE_MTK(_id, _name, _parent, &audio0_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr)
 
-#define GATE_AUDIO1(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &audio1_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr,	\
-	}
+#define GATE_AUDIO1(_id, _name, _parent, _shift)		\
+	GATE_MTK(_id, _name, _parent, &audio1_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr)
 
-#define GATE_AUDIO2(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &audio2_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr,	\
-	}
+#define GATE_AUDIO2(_id, _name, _parent, _shift)		\
+	GATE_MTK(_id, _name, _parent, &audio2_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr)
 
-#define GATE_AUDIO3(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &audio3_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr,	\
-	}
+#define GATE_AUDIO3(_id, _name, _parent, _shift)		\
+	GATE_MTK(_id, _name, _parent, &audio3_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr)
 
 static const struct mtk_gate_regs audio0_cg_regs = {
 	.set_ofs = 0x0,
diff --git a/drivers/clk/mediatek/clk-mt2701-bdp.c b/drivers/clk/mediatek/clk-mt2701-bdp.c
index 435ed4819d563..b0f0572079452 100644
--- a/drivers/clk/mediatek/clk-mt2701-bdp.c
+++ b/drivers/clk/mediatek/clk-mt2701-bdp.c
@@ -24,23 +24,11 @@ static const struct mtk_gate_regs bdp1_cg_regs = {
 	.sta_ofs = 0x0110,
 };
 
-#define GATE_BDP0(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &bdp0_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr_inv,	\
-	}
+#define GATE_BDP0(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &bdp0_cg_regs, _shift, &mtk_clk_gate_ops_setclr_inv)
 
-#define GATE_BDP1(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &bdp1_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr_inv,	\
-	}
+#define GATE_BDP1(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &bdp1_cg_regs, _shift, &mtk_clk_gate_ops_setclr_inv)
 
 static const struct mtk_gate bdp_clks[] = {
 	GATE_BDP0(CLK_BDP_BRG_BA, "brg_baclk", "mm_sel", 0),
diff --git a/drivers/clk/mediatek/clk-mt2701-eth.c b/drivers/clk/mediatek/clk-mt2701-eth.c
index f3cb78e7f6e9e..4c830ebdd7613 100644
--- a/drivers/clk/mediatek/clk-mt2701-eth.c
+++ b/drivers/clk/mediatek/clk-mt2701-eth.c
@@ -16,14 +16,8 @@ static const struct mtk_gate_regs eth_cg_regs = {
 	.sta_ofs = 0x0030,
 };
 
-#define GATE_ETH(_id, _name, _parent, _shift) {		\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &eth_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr_inv,	\
-	}
+#define GATE_ETH(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &eth_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr_inv)
 
 static const struct mtk_gate eth_clks[] = {
 	GATE_DUMMY(CLK_DUMMY, "eth_dummy"),
diff --git a/drivers/clk/mediatek/clk-mt2701-g3d.c b/drivers/clk/mediatek/clk-mt2701-g3d.c
index 499a170ba5f92..ae094046890aa 100644
--- a/drivers/clk/mediatek/clk-mt2701-g3d.c
+++ b/drivers/clk/mediatek/clk-mt2701-g3d.c
@@ -16,14 +16,8 @@
 
 #include <dt-bindings/clock/mt2701-clk.h>
 
-#define GATE_G3D(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &g3d_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
+#define GATE_G3D(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &g3d_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
 static const struct mtk_gate_regs g3d_cg_regs = {
 	.sta_ofs = 0x0,
diff --git a/drivers/clk/mediatek/clk-mt2701-hif.c b/drivers/clk/mediatek/clk-mt2701-hif.c
index d5465d7829935..3583bd1240d55 100644
--- a/drivers/clk/mediatek/clk-mt2701-hif.c
+++ b/drivers/clk/mediatek/clk-mt2701-hif.c
@@ -16,14 +16,8 @@ static const struct mtk_gate_regs hif_cg_regs = {
 	.sta_ofs = 0x0030,
 };
 
-#define GATE_HIF(_id, _name, _parent, _shift) {		\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &hif_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr_inv,	\
-	}
+#define GATE_HIF(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &hif_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr_inv)
 
 static const struct mtk_gate hif_clks[] = {
 	GATE_DUMMY(CLK_DUMMY, "hif_dummy"),
diff --git a/drivers/clk/mediatek/clk-mt2701-img.c b/drivers/clk/mediatek/clk-mt2701-img.c
index 7e53deb7f9905..eb172473f0755 100644
--- a/drivers/clk/mediatek/clk-mt2701-img.c
+++ b/drivers/clk/mediatek/clk-mt2701-img.c
@@ -18,14 +18,8 @@ static const struct mtk_gate_regs img_cg_regs = {
 	.sta_ofs = 0x0000,
 };
 
-#define GATE_IMG(_id, _name, _parent, _shift) {		\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &img_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
+#define GATE_IMG(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &img_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
 static const struct mtk_gate img_clks[] = {
 	GATE_IMG(CLK_IMG_SMI_COMM, "img_smi_comm", "mm_sel", 0),
diff --git a/drivers/clk/mediatek/clk-mt2701-mm.c b/drivers/clk/mediatek/clk-mt2701-mm.c
index 23d5ddcc1d372..f4885dffb324f 100644
--- a/drivers/clk/mediatek/clk-mt2701-mm.c
+++ b/drivers/clk/mediatek/clk-mt2701-mm.c
@@ -24,23 +24,11 @@ static const struct mtk_gate_regs disp1_cg_regs = {
 	.sta_ofs = 0x0110,
 };
 
-#define GATE_DISP0(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &disp0_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
+#define GATE_DISP0(_id, _name, _parent, _shift)	\
+	GATE_MTK(_id, _name, _parent, &disp0_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
-#define GATE_DISP1(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &disp1_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
+#define GATE_DISP1(_id, _name, _parent, _shift)	\
+	GATE_MTK(_id, _name, _parent, &disp1_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
 static const struct mtk_gate mm_clks[] = {
 	GATE_DISP0(CLK_MM_SMI_COMMON, "mm_smi_comm", "mm_sel", 0),
diff --git a/drivers/clk/mediatek/clk-mt2701-vdec.c b/drivers/clk/mediatek/clk-mt2701-vdec.c
index d3089da0ab62e..0f07c5d731df6 100644
--- a/drivers/clk/mediatek/clk-mt2701-vdec.c
+++ b/drivers/clk/mediatek/clk-mt2701-vdec.c
@@ -24,23 +24,11 @@ static const struct mtk_gate_regs vdec1_cg_regs = {
 	.sta_ofs = 0x0008,
 };
 
-#define GATE_VDEC0(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &vdec0_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr_inv,	\
-	}
+#define GATE_VDEC0(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &vdec0_cg_regs, _shift, &mtk_clk_gate_ops_setclr_inv)
 
-#define GATE_VDEC1(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &vdec1_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr_inv,	\
-	}
+#define GATE_VDEC1(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &vdec1_cg_regs, _shift, &mtk_clk_gate_ops_setclr_inv)
 
 static const struct mtk_gate vdec_clks[] = {
 	GATE_VDEC0(CLK_VDEC_CKGEN, "vdec_cken", "vdec_sel", 0),
diff --git a/drivers/clk/mediatek/clk-mt2701.c b/drivers/clk/mediatek/clk-mt2701.c
index 06ca81359d350..dfe328f7a44b2 100644
--- a/drivers/clk/mediatek/clk-mt2701.c
+++ b/drivers/clk/mediatek/clk-mt2701.c
@@ -636,14 +636,8 @@ static const struct mtk_gate_regs top_aud_cg_regs = {
 	.sta_ofs = 0x012C,
 };
 
-#define GATE_TOP_AUD(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &top_aud_cg_regs,		\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr,	\
-	}
+#define GATE_TOP_AUD(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &top_aud_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr)
 
 static const struct mtk_gate top_clks[] = {
 	GATE_TOP_AUD(CLK_TOP_AUD_48K_TIMING, "a1sys_hp_ck", "aud_mux1_div",
@@ -702,14 +696,8 @@ static const struct mtk_gate_regs infra_cg_regs = {
 	.sta_ofs = 0x0048,
 };
 
-#define GATE_ICG(_id, _name, _parent, _shift) {		\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &infra_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
+#define GATE_ICG(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &infra_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
 static const struct mtk_gate infra_clks[] = {
 	GATE_ICG(CLK_INFRA_DBG, "dbgclk", "axi_sel", 0),
@@ -823,23 +811,11 @@ static const struct mtk_gate_regs peri1_cg_regs = {
 	.sta_ofs = 0x001c,
 };
 
-#define GATE_PERI0(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &peri0_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
+#define GATE_PERI0(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &peri0_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
-#define GATE_PERI1(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &peri1_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
+#define GATE_PERI1(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &peri1_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
 static const struct mtk_gate peri_clks[] = {
 	GATE_PERI0(CLK_PERI_USB0_MCU, "usb0_mcu_ck", "axi_sel", 31),
diff --git a/drivers/clk/mediatek/clk-mt2712-bdp.c b/drivers/clk/mediatek/clk-mt2712-bdp.c
index 684d03e9f6de1..5e668651dd901 100644
--- a/drivers/clk/mediatek/clk-mt2712-bdp.c
+++ b/drivers/clk/mediatek/clk-mt2712-bdp.c
@@ -18,14 +18,8 @@ static const struct mtk_gate_regs bdp_cg_regs = {
 	.sta_ofs = 0x100,
 };
 
-#define GATE_BDP(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &bdp_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr,	\
-	}
+#define GATE_BDP(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &bdp_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr)
 
 static const struct mtk_gate bdp_clks[] = {
 	GATE_BDP(CLK_BDP_BRIDGE_B, "bdp_bridge_b", "mm_sel", 0),
diff --git a/drivers/clk/mediatek/clk-mt2712-img.c b/drivers/clk/mediatek/clk-mt2712-img.c
index 335049cdc856c..3ffa51384e6b2 100644
--- a/drivers/clk/mediatek/clk-mt2712-img.c
+++ b/drivers/clk/mediatek/clk-mt2712-img.c
@@ -18,14 +18,8 @@ static const struct mtk_gate_regs img_cg_regs = {
 	.sta_ofs = 0x0,
 };
 
-#define GATE_IMG(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &img_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr,	\
-	}
+#define GATE_IMG(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &img_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr)
 
 static const struct mtk_gate img_clks[] = {
 	GATE_IMG(CLK_IMG_SMI_LARB2, "img_smi_larb2", "mm_sel", 0),
diff --git a/drivers/clk/mediatek/clk-mt2712-jpgdec.c b/drivers/clk/mediatek/clk-mt2712-jpgdec.c
index 07ba7c5e80aff..8c768d5ce24d5 100644
--- a/drivers/clk/mediatek/clk-mt2712-jpgdec.c
+++ b/drivers/clk/mediatek/clk-mt2712-jpgdec.c
@@ -18,14 +18,8 @@ static const struct mtk_gate_regs jpgdec_cg_regs = {
 	.sta_ofs = 0x0,
 };
 
-#define GATE_JPGDEC(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &jpgdec_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr_inv,	\
-	}
+#define GATE_JPGDEC(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &jpgdec_cg_regs, _shift, &mtk_clk_gate_ops_setclr_inv)
 
 static const struct mtk_gate jpgdec_clks[] = {
 	GATE_JPGDEC(CLK_JPGDEC_JPGDEC1, "jpgdec_jpgdec1", "jpgdec_sel", 0),
diff --git a/drivers/clk/mediatek/clk-mt2712-mfg.c b/drivers/clk/mediatek/clk-mt2712-mfg.c
index 42f8cf3ecf4cb..8949315c2dd20 100644
--- a/drivers/clk/mediatek/clk-mt2712-mfg.c
+++ b/drivers/clk/mediatek/clk-mt2712-mfg.c
@@ -18,14 +18,8 @@ static const struct mtk_gate_regs mfg_cg_regs = {
 	.sta_ofs = 0x0,
 };
 
-#define GATE_MFG(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &mfg_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
+#define GATE_MFG(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &mfg_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
 static const struct mtk_gate mfg_clks[] = {
 	GATE_MFG(CLK_MFG_BG3D, "mfg_bg3d", "mfg_sel", 0),
diff --git a/drivers/clk/mediatek/clk-mt2712-mm.c b/drivers/clk/mediatek/clk-mt2712-mm.c
index 25b8af640c128..e5264f1ce60d0 100644
--- a/drivers/clk/mediatek/clk-mt2712-mm.c
+++ b/drivers/clk/mediatek/clk-mt2712-mm.c
@@ -30,32 +30,14 @@ static const struct mtk_gate_regs mm2_cg_regs = {
 	.sta_ofs = 0x220,
 };
 
-#define GATE_MM0(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &mm0_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
-
-#define GATE_MM1(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &mm1_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
-
-#define GATE_MM2(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &mm2_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
+#define GATE_MM0(_id, _name, _parent, _shift)	\
+	GATE_MTK(_id, _name, _parent, &mm0_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
+
+#define GATE_MM1(_id, _name, _parent, _shift)	\
+	GATE_MTK(_id, _name, _parent, &mm1_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
+
+#define GATE_MM2(_id, _name, _parent, _shift)	\
+	GATE_MTK(_id, _name, _parent, &mm2_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
 static const struct mtk_gate mm_clks[] = {
 	/* MM0 */
diff --git a/drivers/clk/mediatek/clk-mt2712-vdec.c b/drivers/clk/mediatek/clk-mt2712-vdec.c
index 6296ed5c5b555..572290dd43c87 100644
--- a/drivers/clk/mediatek/clk-mt2712-vdec.c
+++ b/drivers/clk/mediatek/clk-mt2712-vdec.c
@@ -24,23 +24,11 @@ static const struct mtk_gate_regs vdec1_cg_regs = {
 	.sta_ofs = 0x8,
 };
 
-#define GATE_VDEC0(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &vdec0_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr_inv,	\
-	}
+#define GATE_VDEC0(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &vdec0_cg_regs, _shift, &mtk_clk_gate_ops_setclr_inv)
 
-#define GATE_VDEC1(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &vdec1_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr_inv,	\
-	}
+#define GATE_VDEC1(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &vdec1_cg_regs, _shift, &mtk_clk_gate_ops_setclr_inv)
 
 static const struct mtk_gate vdec_clks[] = {
 	/* VDEC0 */
diff --git a/drivers/clk/mediatek/clk-mt2712-venc.c b/drivers/clk/mediatek/clk-mt2712-venc.c
index b9bfc35de629c..9588eb03016eb 100644
--- a/drivers/clk/mediatek/clk-mt2712-venc.c
+++ b/drivers/clk/mediatek/clk-mt2712-venc.c
@@ -18,14 +18,8 @@ static const struct mtk_gate_regs venc_cg_regs = {
 	.sta_ofs = 0x0,
 };
 
-#define GATE_VENC(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &venc_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr_inv,	\
-	}
+#define GATE_VENC(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &venc_cg_regs, _shift, &mtk_clk_gate_ops_setclr_inv)
 
 static const struct mtk_gate venc_clks[] = {
 	GATE_VENC(CLK_VENC_SMI_COMMON_CON, "venc_smi", "mm_sel", 0),
diff --git a/drivers/clk/mediatek/clk-mt2712.c b/drivers/clk/mediatek/clk-mt2712.c
index aa39d006358a3..79cdb1e72ec52 100644
--- a/drivers/clk/mediatek/clk-mt2712.c
+++ b/drivers/clk/mediatek/clk-mt2712.c
@@ -958,23 +958,11 @@ static const struct mtk_gate_regs top1_cg_regs = {
 	.sta_ofs = 0x424,
 };
 
-#define GATE_TOP0(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &top0_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr,	\
-	}
+#define GATE_TOP0(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &top0_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr)
 
-#define GATE_TOP1(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &top1_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr_inv,	\
-	}
+#define GATE_TOP1(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &top1_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr_inv)
 
 static const struct mtk_gate top_clks[] = {
 	/* TOP0 */
@@ -998,14 +986,8 @@ static const struct mtk_gate_regs infra_cg_regs = {
 	.sta_ofs = 0x48,
 };
 
-#define GATE_INFRA(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &infra_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
+#define GATE_INFRA(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &infra_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
 static const struct mtk_gate infra_clks[] = {
 	GATE_INFRA(CLK_INFRA_DBGCLK, "infra_dbgclk", "axi_sel", 0),
@@ -1035,32 +1017,14 @@ static const struct mtk_gate_regs peri2_cg_regs = {
 	.sta_ofs = 0x42c,
 };
 
-#define GATE_PERI0(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &peri0_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
+#define GATE_PERI0(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &peri0_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
-#define GATE_PERI1(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &peri1_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
+#define GATE_PERI1(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &peri1_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
-#define GATE_PERI2(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &peri2_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr_inv,	\
-	}
+#define GATE_PERI2(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &peri2_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr_inv)
 
 static const struct mtk_gate peri_clks[] = {
 	/* PERI0 */
diff --git a/drivers/clk/mediatek/clk-mt6765-audio.c b/drivers/clk/mediatek/clk-mt6765-audio.c
index 0aa6c0d352ca5..5682e0302eee2 100644
--- a/drivers/clk/mediatek/clk-mt6765-audio.c
+++ b/drivers/clk/mediatek/clk-mt6765-audio.c
@@ -24,23 +24,11 @@ static const struct mtk_gate_regs audio1_cg_regs = {
 	.sta_ofs = 0x4,
 };
 
-#define GATE_AUDIO0(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &audio0_cg_regs,		\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr,	\
-	}
+#define GATE_AUDIO0(_id, _name, _parent, _shift)		\
+	GATE_MTK(_id, _name, _parent, &audio0_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr)
 
-#define GATE_AUDIO1(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &audio1_cg_regs,		\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr,	\
-	}
+#define GATE_AUDIO1(_id, _name, _parent, _shift)		\
+	GATE_MTK(_id, _name, _parent, &audio1_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr)
 
 static const struct mtk_gate audio_clks[] = {
 	/* AUDIO0 */
diff --git a/drivers/clk/mediatek/clk-mt6765-cam.c b/drivers/clk/mediatek/clk-mt6765-cam.c
index 25f2bef38126e..6e7d192c19cb0 100644
--- a/drivers/clk/mediatek/clk-mt6765-cam.c
+++ b/drivers/clk/mediatek/clk-mt6765-cam.c
@@ -18,14 +18,8 @@ static const struct mtk_gate_regs cam_cg_regs = {
 	.sta_ofs = 0x0,
 };
 
-#define GATE_CAM(_id, _name, _parent, _shift) {		\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &cam_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
+#define GATE_CAM(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &cam_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
 static const struct mtk_gate cam_clks[] = {
 	GATE_CAM(CLK_CAM_LARB3, "cam_larb3", "mm_ck", 0),
diff --git a/drivers/clk/mediatek/clk-mt6765-img.c b/drivers/clk/mediatek/clk-mt6765-img.c
index a62303ef4f41d..cfbc907988aff 100644
--- a/drivers/clk/mediatek/clk-mt6765-img.c
+++ b/drivers/clk/mediatek/clk-mt6765-img.c
@@ -18,14 +18,8 @@ static const struct mtk_gate_regs img_cg_regs = {
 	.sta_ofs = 0x0,
 };
 
-#define GATE_IMG(_id, _name, _parent, _shift) {		\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &img_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
+#define GATE_IMG(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &img_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
 static const struct mtk_gate img_clks[] = {
 	GATE_IMG(CLK_IMG_LARB2, "img_larb2", "mm_ck", 0),
diff --git a/drivers/clk/mediatek/clk-mt6765-mipi0a.c b/drivers/clk/mediatek/clk-mt6765-mipi0a.c
index 25c829fc38661..f2b9dc8084801 100644
--- a/drivers/clk/mediatek/clk-mt6765-mipi0a.c
+++ b/drivers/clk/mediatek/clk-mt6765-mipi0a.c
@@ -18,14 +18,8 @@ static const struct mtk_gate_regs mipi0a_cg_regs = {
 	.sta_ofs = 0x80,
 };
 
-#define GATE_MIPI0A(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &mipi0a_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr_inv,	\
-	}
+#define GATE_MIPI0A(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &mipi0a_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr_inv)
 
 static const struct mtk_gate mipi0a_clks[] = {
 	GATE_MIPI0A(CLK_MIPI0A_CSR_CSI_EN_0A,
diff --git a/drivers/clk/mediatek/clk-mt6765-mm.c b/drivers/clk/mediatek/clk-mt6765-mm.c
index bda774668a361..a4570c9dbefa5 100644
--- a/drivers/clk/mediatek/clk-mt6765-mm.c
+++ b/drivers/clk/mediatek/clk-mt6765-mm.c
@@ -18,14 +18,8 @@ static const struct mtk_gate_regs mm_cg_regs = {
 	.sta_ofs = 0x100,
 };
 
-#define GATE_MM(_id, _name, _parent, _shift) {		\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &mm_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
+#define GATE_MM(_id, _name, _parent, _shift)	\
+	GATE_MTK(_id, _name, _parent, &mm_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
 static const struct mtk_gate mm_clks[] = {
 	/* MM */
diff --git a/drivers/clk/mediatek/clk-mt6765-vcodec.c b/drivers/clk/mediatek/clk-mt6765-vcodec.c
index 2bc1fbde87da9..75d72b9b4032c 100644
--- a/drivers/clk/mediatek/clk-mt6765-vcodec.c
+++ b/drivers/clk/mediatek/clk-mt6765-vcodec.c
@@ -18,14 +18,8 @@ static const struct mtk_gate_regs venc_cg_regs = {
 	.sta_ofs = 0x0,
 };
 
-#define GATE_VENC(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &venc_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr_inv,	\
-	}
+#define GATE_VENC(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &venc_cg_regs, _shift, &mtk_clk_gate_ops_setclr_inv)
 
 static const struct mtk_gate venc_clks[] = {
 	GATE_VENC(CLK_VENC_SET0_LARB, "venc_set0_larb", "mm_ck", 0),
diff --git a/drivers/clk/mediatek/clk-mt6765.c b/drivers/clk/mediatek/clk-mt6765.c
index 6f5c92a7f6204..0c20ce678350e 100644
--- a/drivers/clk/mediatek/clk-mt6765.c
+++ b/drivers/clk/mediatek/clk-mt6765.c
@@ -483,32 +483,14 @@ static const struct mtk_gate_regs top2_cg_regs = {
 	.sta_ofs = 0x320,
 };
 
-#define GATE_TOP0(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &top0_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr,	\
-	}
+#define GATE_TOP0(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &top0_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr)
 
-#define GATE_TOP1(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &top1_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr_inv,	\
-	}
+#define GATE_TOP1(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &top1_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr_inv)
 
-#define GATE_TOP2(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &top2_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr,	\
-	}
+#define GATE_TOP2(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &top2_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr)
 
 static const struct mtk_gate top_clks[] = {
 	/* TOP0 */
@@ -559,41 +541,17 @@ static const struct mtk_gate_regs ifr5_cg_regs = {
 	.sta_ofs = 0xc8,
 };
 
-#define GATE_IFR2(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &ifr2_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
+#define GATE_IFR2(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &ifr2_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
-#define GATE_IFR3(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &ifr3_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
+#define GATE_IFR3(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &ifr3_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
-#define GATE_IFR4(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &ifr4_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
+#define GATE_IFR4(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &ifr4_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
-#define GATE_IFR5(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &ifr5_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
+#define GATE_IFR5(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &ifr5_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
 static const struct mtk_gate ifr_clks[] = {
 	/* INFRA_TOPAXI */
@@ -674,14 +632,8 @@ static const struct mtk_gate_regs apmixed_cg_regs = {
 	.sta_ofs = 0x14,
 };
 
-#define GATE_APMIXED(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &apmixed_cg_regs,		\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr_inv,		\
-	}
+#define GATE_APMIXED(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &apmixed_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr_inv)
 
 static const struct mtk_gate apmixed_clks[] = {
 	/* AUDIO0 */
diff --git a/drivers/clk/mediatek/clk-mt6797-img.c b/drivers/clk/mediatek/clk-mt6797-img.c
index 7c6a53fbb8be6..06441393478f6 100644
--- a/drivers/clk/mediatek/clk-mt6797-img.c
+++ b/drivers/clk/mediatek/clk-mt6797-img.c
@@ -16,14 +16,8 @@ static const struct mtk_gate_regs img_cg_regs = {
 	.sta_ofs = 0x0000,
 };
 
-#define GATE_IMG(_id, _name, _parent, _shift) {		\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &img_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
+#define GATE_IMG(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &img_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
 static const struct mtk_gate img_clks[] = {
 	GATE_IMG(CLK_IMG_FDVT, "img_fdvt", "mm_sel", 11),
diff --git a/drivers/clk/mediatek/clk-mt6797-mm.c b/drivers/clk/mediatek/clk-mt6797-mm.c
index deb16a6b16a5e..d5e9fe445e308 100644
--- a/drivers/clk/mediatek/clk-mt6797-mm.c
+++ b/drivers/clk/mediatek/clk-mt6797-mm.c
@@ -23,23 +23,11 @@ static const struct mtk_gate_regs mm1_cg_regs = {
 	.sta_ofs = 0x0110,
 };
 
-#define GATE_MM0(_id, _name, _parent, _shift) {			\
-	.id = _id,					\
-	.name = _name,					\
-	.parent_name = _parent,				\
-	.regs = &mm0_cg_regs,				\
-	.shift = _shift,				\
-	.ops = &mtk_clk_gate_ops_setclr,		\
-}
+#define GATE_MM0(_id, _name, _parent, _shift)	\
+	GATE_MTK(_id, _name, _parent, &mm0_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
-#define GATE_MM1(_id, _name, _parent, _shift) {			\
-	.id = _id,					\
-	.name = _name,					\
-	.parent_name = _parent,				\
-	.regs = &mm1_cg_regs,				\
-	.shift = _shift,				\
-	.ops = &mtk_clk_gate_ops_setclr,		\
-}
+#define GATE_MM1(_id, _name, _parent, _shift)	\
+	GATE_MTK(_id, _name, _parent, &mm1_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
 static const struct mtk_gate mm_clks[] = {
 	GATE_MM0(CLK_MM_SMI_COMMON, "mm_smi_common", "mm_sel", 0),
diff --git a/drivers/clk/mediatek/clk-mt6797-vdec.c b/drivers/clk/mediatek/clk-mt6797-vdec.c
index 6120fccc859f1..8622ddd87a5bb 100644
--- a/drivers/clk/mediatek/clk-mt6797-vdec.c
+++ b/drivers/clk/mediatek/clk-mt6797-vdec.c
@@ -24,23 +24,11 @@ static const struct mtk_gate_regs vdec1_cg_regs = {
 	.sta_ofs = 0x0008,
 };
 
-#define GATE_VDEC0(_id, _name, _parent, _shift) {		\
-	.id = _id,					\
-	.name = _name,					\
-	.parent_name = _parent,				\
-	.regs = &vdec0_cg_regs,				\
-	.shift = _shift,				\
-	.ops = &mtk_clk_gate_ops_setclr_inv,		\
-}
+#define GATE_VDEC0(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &vdec0_cg_regs, _shift, &mtk_clk_gate_ops_setclr_inv)
 
-#define GATE_VDEC1(_id, _name, _parent, _shift) {		\
-	.id = _id,					\
-	.name = _name,					\
-	.parent_name = _parent,				\
-	.regs = &vdec1_cg_regs,				\
-	.shift = _shift,				\
-	.ops = &mtk_clk_gate_ops_setclr_inv,		\
-}
+#define GATE_VDEC1(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &vdec1_cg_regs, _shift, &mtk_clk_gate_ops_setclr_inv)
 
 static const struct mtk_gate vdec_clks[] = {
 	GATE_VDEC0(CLK_VDEC_CKEN_ENG, "vdec_cken_eng", "vdec_sel", 8),
diff --git a/drivers/clk/mediatek/clk-mt6797-venc.c b/drivers/clk/mediatek/clk-mt6797-venc.c
index 834d3834d2bbc..928d611a476e4 100644
--- a/drivers/clk/mediatek/clk-mt6797-venc.c
+++ b/drivers/clk/mediatek/clk-mt6797-venc.c
@@ -18,14 +18,8 @@ static const struct mtk_gate_regs venc_cg_regs = {
 	.sta_ofs = 0x0000,
 };
 
-#define GATE_VENC(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &venc_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr_inv,	\
-	}
+#define GATE_VENC(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &venc_cg_regs, _shift, &mtk_clk_gate_ops_setclr_inv)
 
 static const struct mtk_gate venc_clks[] = {
 	GATE_VENC(CLK_VENC_0, "venc_0", "mm_sel", 0),
diff --git a/drivers/clk/mediatek/clk-mt6797.c b/drivers/clk/mediatek/clk-mt6797.c
index 105a512857b3c..17b23ee4faee6 100644
--- a/drivers/clk/mediatek/clk-mt6797.c
+++ b/drivers/clk/mediatek/clk-mt6797.c
@@ -421,40 +421,22 @@ static const struct mtk_gate_regs infra2_cg_regs = {
 	.sta_ofs = 0x00b0,
 };
 
-#define GATE_ICG0(_id, _name, _parent, _shift) {		\
-	.id = _id,						\
-	.name = _name,						\
-	.parent_name = _parent,					\
-	.regs = &infra0_cg_regs,				\
-	.shift = _shift,					\
-	.ops = &mtk_clk_gate_ops_setclr,			\
-}
+#define GATE_ICG0(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &infra0_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
-#define GATE_ICG1(_id, _name, _parent, _shift)			\
-	GATE_ICG1_FLAGS(_id, _name, _parent, _shift, 0)
+#define GATE_ICG1(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &infra1_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
-#define GATE_ICG1_FLAGS(_id, _name, _parent, _shift, _flags) {	\
-	.id = _id,						\
-	.name = _name,						\
-	.parent_name = _parent,					\
-	.regs = &infra1_cg_regs,				\
-	.shift = _shift,					\
-	.ops = &mtk_clk_gate_ops_setclr,			\
-	.flags = _flags,					\
-}
+#define GATE_ICG1_FLAGS(_id, _name, _parent, _shift, _flags)		\
+	GATE_MTK_FLAGS(_id, _name, _parent, &infra1_cg_regs, _shift,	\
+		       &mtk_clk_gate_ops_setclr, _flags)
 
-#define GATE_ICG2(_id, _name, _parent, _shift)			\
-	GATE_ICG2_FLAGS(_id, _name, _parent, _shift, 0)
+#define GATE_ICG2(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &infra2_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
-#define GATE_ICG2_FLAGS(_id, _name, _parent, _shift, _flags) {	\
-	.id = _id,						\
-	.name = _name,						\
-	.parent_name = _parent,					\
-	.regs = &infra2_cg_regs,				\
-	.shift = _shift,					\
-	.ops = &mtk_clk_gate_ops_setclr,			\
-	.flags = _flags,					\
-}
+#define GATE_ICG2_FLAGS(_id, _name, _parent, _shift, _flags)		\
+	GATE_MTK_FLAGS(_id, _name, _parent, &infra2_cg_regs, _shift,	\
+		       &mtk_clk_gate_ops_setclr, _flags)
 
 /*
  * Clock gates dramc and dramc_b are needed by the DRAM controller.
diff --git a/drivers/clk/mediatek/clk-mt7622-aud.c b/drivers/clk/mediatek/clk-mt7622-aud.c
index b8aabfeb1cba4..27c543759f2ab 100644
--- a/drivers/clk/mediatek/clk-mt7622-aud.c
+++ b/drivers/clk/mediatek/clk-mt7622-aud.c
@@ -16,41 +16,17 @@
 
 #include <dt-bindings/clock/mt7622-clk.h>
 
-#define GATE_AUDIO0(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &audio0_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr,	\
-	}
+#define GATE_AUDIO0(_id, _name, _parent, _shift)		\
+	GATE_MTK(_id, _name, _parent, &audio0_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr)
 
-#define GATE_AUDIO1(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &audio1_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr,	\
-	}
+#define GATE_AUDIO1(_id, _name, _parent, _shift)		\
+	GATE_MTK(_id, _name, _parent, &audio1_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr)
 
-#define GATE_AUDIO2(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &audio2_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr,	\
-	}
+#define GATE_AUDIO2(_id, _name, _parent, _shift)		\
+	GATE_MTK(_id, _name, _parent, &audio2_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr)
 
-#define GATE_AUDIO3(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &audio3_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr,	\
-	}
+#define GATE_AUDIO3(_id, _name, _parent, _shift)		\
+	GATE_MTK(_id, _name, _parent, &audio3_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr)
 
 static const struct mtk_gate_regs audio0_cg_regs = {
 	.set_ofs = 0x0,
diff --git a/drivers/clk/mediatek/clk-mt7622-eth.c b/drivers/clk/mediatek/clk-mt7622-eth.c
index aee583fa77d0c..66b163cc16330 100644
--- a/drivers/clk/mediatek/clk-mt7622-eth.c
+++ b/drivers/clk/mediatek/clk-mt7622-eth.c
@@ -16,14 +16,8 @@
 
 #include <dt-bindings/clock/mt7622-clk.h>
 
-#define GATE_ETH(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &eth_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr_inv,	\
-	}
+#define GATE_ETH(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &eth_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr_inv)
 
 static const struct mtk_gate_regs eth_cg_regs = {
 	.set_ofs = 0x30,
@@ -45,14 +39,8 @@ static const struct mtk_gate_regs sgmii_cg_regs = {
 	.sta_ofs = 0xE4,
 };
 
-#define GATE_SGMII(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &sgmii_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr_inv,	\
-	}
+#define GATE_SGMII(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &sgmii_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr_inv)
 
 static const struct mtk_gate sgmii_clks[] = {
 	GATE_SGMII(CLK_SGMII_TX250M_EN, "sgmii_tx250m_en",
diff --git a/drivers/clk/mediatek/clk-mt7622-hif.c b/drivers/clk/mediatek/clk-mt7622-hif.c
index ab5cad0c2b1c9..bcd1dfc6e8e0c 100644
--- a/drivers/clk/mediatek/clk-mt7622-hif.c
+++ b/drivers/clk/mediatek/clk-mt7622-hif.c
@@ -16,23 +16,11 @@
 
 #include <dt-bindings/clock/mt7622-clk.h>
 
-#define GATE_PCIE(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &pcie_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr_inv,	\
-	}
-
-#define GATE_SSUSB(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &ssusb_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr_inv,	\
-	}
+#define GATE_PCIE(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &pcie_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr_inv)
+
+#define GATE_SSUSB(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &ssusb_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr_inv)
 
 static const struct mtk_gate_regs pcie_cg_regs = {
 	.set_ofs = 0x30,
diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index 5a82c2270bfbc..41af8d420bbf8 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -50,59 +50,24 @@
 		 _pd_reg, _pd_shift, _tuner_reg, _pcw_reg, _pcw_shift,  \
 		 NULL, "clkxtal")
 
-#define GATE_APMIXED(_id, _name, _parent, _shift) {			\
-		.id = _id,						\
-		.name = _name,						\
-		.parent_name = _parent,					\
-		.regs = &apmixed_cg_regs,				\
-		.shift = _shift,					\
-		.ops = &mtk_clk_gate_ops_no_setclr_inv,			\
-	}
+#define GATE_APMIXED(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &apmixed_cg_regs, _shift,		\
+		 &mtk_clk_gate_ops_no_setclr_inv)
 
-#define GATE_INFRA(_id, _name, _parent, _shift) {			\
-		.id = _id,						\
-		.name = _name,						\
-		.parent_name = _parent,					\
-		.regs = &infra_cg_regs,					\
-		.shift = _shift,					\
-		.ops = &mtk_clk_gate_ops_setclr,			\
-	}
+#define GATE_INFRA(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &infra_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
-#define GATE_TOP0(_id, _name, _parent, _shift) {			\
-		.id = _id,						\
-		.name = _name,						\
-		.parent_name = _parent,					\
-		.regs = &top0_cg_regs,					\
-		.shift = _shift,					\
-		.ops = &mtk_clk_gate_ops_no_setclr,			\
-	}
+#define GATE_TOP0(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &top0_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr)
 
-#define GATE_TOP1(_id, _name, _parent, _shift) {			\
-		.id = _id,						\
-		.name = _name,						\
-		.parent_name = _parent,					\
-		.regs = &top1_cg_regs,					\
-		.shift = _shift,					\
-		.ops = &mtk_clk_gate_ops_no_setclr,			\
-	}
+#define GATE_TOP1(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &top1_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr)
 
-#define GATE_PERI0(_id, _name, _parent, _shift) {			\
-		.id = _id,						\
-		.name = _name,						\
-		.parent_name = _parent,					\
-		.regs = &peri0_cg_regs,					\
-		.shift = _shift,					\
-		.ops = &mtk_clk_gate_ops_setclr,			\
-	}
+#define GATE_PERI0(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &peri0_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
-#define GATE_PERI1(_id, _name, _parent, _shift) {			\
-		.id = _id,						\
-		.name = _name,						\
-		.parent_name = _parent,					\
-		.regs = &peri1_cg_regs,					\
-		.shift = _shift,					\
-		.ops = &mtk_clk_gate_ops_setclr,			\
-	}
+#define GATE_PERI1(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &peri1_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
 static DEFINE_SPINLOCK(mt7622_clk_lock);
 
diff --git a/drivers/clk/mediatek/clk-mt7629-eth.c b/drivers/clk/mediatek/clk-mt7629-eth.c
index a4ae7d6c7a71a..719a47fef7980 100644
--- a/drivers/clk/mediatek/clk-mt7629-eth.c
+++ b/drivers/clk/mediatek/clk-mt7629-eth.c
@@ -16,14 +16,8 @@
 
 #include <dt-bindings/clock/mt7629-clk.h>
 
-#define GATE_ETH(_id, _name, _parent, _shift) {		\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &eth_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr_inv,	\
-	}
+#define GATE_ETH(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &eth_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr_inv)
 
 static const struct mtk_gate_regs eth_cg_regs = {
 	.set_ofs = 0x30,
@@ -45,14 +39,8 @@ static const struct mtk_gate_regs sgmii_cg_regs = {
 	.sta_ofs = 0xE4,
 };
 
-#define GATE_SGMII(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &sgmii_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr_inv,	\
-	}
+#define GATE_SGMII(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &sgmii_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr_inv)
 
 static const struct mtk_gate sgmii_clks[2][4] = {
 	{
diff --git a/drivers/clk/mediatek/clk-mt7629-hif.c b/drivers/clk/mediatek/clk-mt7629-hif.c
index c3eb09ea6036f..78d85542e4f17 100644
--- a/drivers/clk/mediatek/clk-mt7629-hif.c
+++ b/drivers/clk/mediatek/clk-mt7629-hif.c
@@ -16,23 +16,11 @@
 
 #include <dt-bindings/clock/mt7629-clk.h>
 
-#define GATE_PCIE(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &pcie_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr_inv,	\
-	}
-
-#define GATE_SSUSB(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &ssusb_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr_inv,	\
-	}
+#define GATE_PCIE(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &pcie_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr_inv)
+
+#define GATE_SSUSB(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &ssusb_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr_inv)
 
 static const struct mtk_gate_regs pcie_cg_regs = {
 	.set_ofs = 0x30,
diff --git a/drivers/clk/mediatek/clk-mt7629.c b/drivers/clk/mediatek/clk-mt7629.c
index cf062d4a7ecc4..09c85fda43d84 100644
--- a/drivers/clk/mediatek/clk-mt7629.c
+++ b/drivers/clk/mediatek/clk-mt7629.c
@@ -50,41 +50,17 @@
 		_pd_reg, _pd_shift, _tuner_reg, _pcw_reg, _pcw_shift,	\
 		NULL, "clk20m")
 
-#define GATE_APMIXED(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &apmixed_cg_regs,		\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr_inv,	\
-	}
+#define GATE_APMIXED(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &apmixed_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr_inv)
 
-#define GATE_INFRA(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &infra_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
+#define GATE_INFRA(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &infra_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
-#define GATE_PERI0(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &peri0_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
+#define GATE_PERI0(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &peri0_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
-#define GATE_PERI1(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &peri1_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
+#define GATE_PERI1(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &peri1_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
 static DEFINE_SPINLOCK(mt7629_clk_lock);
 
diff --git a/drivers/clk/mediatek/clk-mt7986-eth.c b/drivers/clk/mediatek/clk-mt7986-eth.c
index 703872239ecca..e04bc6845ea6d 100644
--- a/drivers/clk/mediatek/clk-mt7986-eth.c
+++ b/drivers/clk/mediatek/clk-mt7986-eth.c
@@ -22,12 +22,8 @@ static const struct mtk_gate_regs sgmii0_cg_regs = {
 	.sta_ofs = 0xe4,
 };
 
-#define GATE_SGMII0(_id, _name, _parent, _shift)                               \
-	{                                                                      \
-		.id = _id, .name = _name, .parent_name = _parent,              \
-		.regs = &sgmii0_cg_regs, .shift = _shift,                      \
-		.ops = &mtk_clk_gate_ops_no_setclr_inv,                        \
-	}
+#define GATE_SGMII0(_id, _name, _parent, _shift)		\
+	GATE_MTK(_id, _name, _parent, &sgmii0_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr_inv)
 
 static const struct mtk_gate sgmii0_clks[] __initconst = {
 	GATE_SGMII0(CLK_SGMII0_TX250M_EN, "sgmii0_tx250m_en", "top_xtal", 2),
@@ -42,12 +38,8 @@ static const struct mtk_gate_regs sgmii1_cg_regs = {
 	.sta_ofs = 0xe4,
 };
 
-#define GATE_SGMII1(_id, _name, _parent, _shift)                               \
-	{                                                                      \
-		.id = _id, .name = _name, .parent_name = _parent,              \
-		.regs = &sgmii1_cg_regs, .shift = _shift,                      \
-		.ops = &mtk_clk_gate_ops_no_setclr_inv,                        \
-	}
+#define GATE_SGMII1(_id, _name, _parent, _shift)		\
+	GATE_MTK(_id, _name, _parent, &sgmii1_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr_inv)
 
 static const struct mtk_gate sgmii1_clks[] __initconst = {
 	GATE_SGMII1(CLK_SGMII1_TX250M_EN, "sgmii1_tx250m_en", "top_xtal", 2),
@@ -62,12 +54,8 @@ static const struct mtk_gate_regs eth_cg_regs = {
 	.sta_ofs = 0x30,
 };
 
-#define GATE_ETH(_id, _name, _parent, _shift)                                  \
-	{                                                                      \
-		.id = _id, .name = _name, .parent_name = _parent,              \
-		.regs = &eth_cg_regs, .shift = _shift,                         \
-		.ops = &mtk_clk_gate_ops_no_setclr_inv,                        \
-	}
+#define GATE_ETH(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &eth_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr_inv)
 
 static const struct mtk_gate eth_clks[] __initconst = {
 	GATE_ETH(CLK_ETH_FE_EN, "eth_fe_en", "netsys_2x_sel", 6),
diff --git a/drivers/clk/mediatek/clk-mt7986-infracfg.c b/drivers/clk/mediatek/clk-mt7986-infracfg.c
index e80c92167c8fc..0a4bf87ee1607 100644
--- a/drivers/clk/mediatek/clk-mt7986-infracfg.c
+++ b/drivers/clk/mediatek/clk-mt7986-infracfg.c
@@ -87,26 +87,14 @@ static const struct mtk_gate_regs infra2_cg_regs = {
 	.sta_ofs = 0x68,
 };
 
-#define GATE_INFRA0(_id, _name, _parent, _shift)                               \
-	{                                                                      \
-		.id = _id, .name = _name, .parent_name = _parent,              \
-		.regs = &infra0_cg_regs, .shift = _shift,                      \
-		.ops = &mtk_clk_gate_ops_setclr,                               \
-	}
+#define GATE_INFRA0(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &infra0_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
-#define GATE_INFRA1(_id, _name, _parent, _shift)                               \
-	{                                                                      \
-		.id = _id, .name = _name, .parent_name = _parent,              \
-		.regs = &infra1_cg_regs, .shift = _shift,                      \
-		.ops = &mtk_clk_gate_ops_setclr,                               \
-	}
+#define GATE_INFRA1(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &infra1_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
-#define GATE_INFRA2(_id, _name, _parent, _shift)                               \
-	{                                                                      \
-		.id = _id, .name = _name, .parent_name = _parent,              \
-		.regs = &infra2_cg_regs, .shift = _shift,                      \
-		.ops = &mtk_clk_gate_ops_setclr,                               \
-	}
+#define GATE_INFRA2(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &infra2_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
 static const struct mtk_gate infra_clks[] = {
 	/* INFRA0 */
diff --git a/drivers/clk/mediatek/clk-mt8135.c b/drivers/clk/mediatek/clk-mt8135.c
index 2b9c925c2a2ba..97a115d2c3daa 100644
--- a/drivers/clk/mediatek/clk-mt8135.c
+++ b/drivers/clk/mediatek/clk-mt8135.c
@@ -401,14 +401,8 @@ static const struct mtk_gate_regs infra_cg_regs = {
 	.sta_ofs = 0x0048,
 };
 
-#define GATE_ICG(_id, _name, _parent, _shift) {	\
-		.id = _id,					\
-		.name = _name,					\
-		.parent_name = _parent,				\
-		.regs = &infra_cg_regs,				\
-		.shift = _shift,				\
-		.ops = &mtk_clk_gate_ops_setclr,		\
-	}
+#define GATE_ICG(_id, _name, _parent, _shift)	\
+	GATE_MTK(_id, _name, _parent, &infra_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
 static const struct mtk_gate infra_clks[] __initconst = {
 	GATE_ICG(CLK_INFRA_PMIC_WRAP, "pmic_wrap_ck", "axi_sel", 23),
@@ -438,23 +432,11 @@ static const struct mtk_gate_regs peri1_cg_regs = {
 	.sta_ofs = 0x001c,
 };
 
-#define GATE_PERI0(_id, _name, _parent, _shift) {	\
-		.id = _id,					\
-		.name = _name,					\
-		.parent_name = _parent,				\
-		.regs = &peri0_cg_regs,				\
-		.shift = _shift,				\
-		.ops = &mtk_clk_gate_ops_setclr,		\
-	}
+#define GATE_PERI0(_id, _name, _parent, _shift)	\
+	GATE_MTK(_id, _name, _parent, &peri0_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
-#define GATE_PERI1(_id, _name, _parent, _shift) {	\
-		.id = _id,					\
-		.name = _name,					\
-		.parent_name = _parent,				\
-		.regs = &peri1_cg_regs,				\
-		.shift = _shift,				\
-		.ops = &mtk_clk_gate_ops_setclr,		\
-	}
+#define GATE_PERI1(_id, _name, _parent, _shift)	\
+	GATE_MTK(_id, _name, _parent, &peri1_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
 static const struct mtk_gate peri_gates[] __initconst = {
 	/* PERI0 */
diff --git a/drivers/clk/mediatek/clk-mt8167-aud.c b/drivers/clk/mediatek/clk-mt8167-aud.c
index f6bea6e9e6a4e..47a7d89d5777c 100644
--- a/drivers/clk/mediatek/clk-mt8167-aud.c
+++ b/drivers/clk/mediatek/clk-mt8167-aud.c
@@ -23,14 +23,9 @@ static const struct mtk_gate_regs aud_cg_regs = {
 	.sta_ofs = 0x0,
 };
 
-#define GATE_AUD(_id, _name, _parent, _shift) {	\
-		.id = _id,			\
-		.name = _name,			\
-		.parent_name = _parent,		\
-		.regs = &aud_cg_regs,		\
-		.shift = _shift,		\
-		.ops = &mtk_clk_gate_ops_no_setclr,		\
-	}
+#define GATE_AUD(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &aud_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr)
+
 
 static const struct mtk_gate aud_clks[] __initconst = {
 	GATE_AUD(CLK_AUD_AFE, "aud_afe", "clk26m_ck", 2),
diff --git a/drivers/clk/mediatek/clk-mt8167-img.c b/drivers/clk/mediatek/clk-mt8167-img.c
index 77db13b177fcc..e196b3b894a16 100644
--- a/drivers/clk/mediatek/clk-mt8167-img.c
+++ b/drivers/clk/mediatek/clk-mt8167-img.c
@@ -23,14 +23,8 @@ static const struct mtk_gate_regs img_cg_regs = {
 	.sta_ofs = 0x0,
 };
 
-#define GATE_IMG(_id, _name, _parent, _shift) {		\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &img_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
+#define GATE_IMG(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &img_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
 static const struct mtk_gate img_clks[] __initconst = {
 	GATE_IMG(CLK_IMG_LARB1_SMI, "img_larb1_smi", "smi_mm", 0),
diff --git a/drivers/clk/mediatek/clk-mt8167-mfgcfg.c b/drivers/clk/mediatek/clk-mt8167-mfgcfg.c
index 3c23591b02f7f..602d25f4cb2e2 100644
--- a/drivers/clk/mediatek/clk-mt8167-mfgcfg.c
+++ b/drivers/clk/mediatek/clk-mt8167-mfgcfg.c
@@ -23,14 +23,8 @@ static const struct mtk_gate_regs mfg_cg_regs = {
 	.sta_ofs = 0x0,
 };
 
-#define GATE_MFG(_id, _name, _parent, _shift) {		\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &mfg_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
+#define GATE_MFG(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &mfg_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
 static const struct mtk_gate mfg_clks[] __initconst = {
 	GATE_MFG(CLK_MFG_BAXI, "mfg_baxi", "ahb_infra_sel", 0),
diff --git a/drivers/clk/mediatek/clk-mt8167-mm.c b/drivers/clk/mediatek/clk-mt8167-mm.c
index c0b44104c765a..abc70e1221bf9 100644
--- a/drivers/clk/mediatek/clk-mt8167-mm.c
+++ b/drivers/clk/mediatek/clk-mt8167-mm.c
@@ -29,23 +29,11 @@ static const struct mtk_gate_regs mm1_cg_regs = {
 	.sta_ofs = 0x110,
 };
 
-#define GATE_MM0(_id, _name, _parent, _shift) {		\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &mm0_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
-
-#define GATE_MM1(_id, _name, _parent, _shift) {		\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &mm1_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
+#define GATE_MM0(_id, _name, _parent, _shift)	\
+	GATE_MTK(_id, _name, _parent, &mm0_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
+
+#define GATE_MM1(_id, _name, _parent, _shift)	\
+	GATE_MTK(_id, _name, _parent, &mm1_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
 static const struct mtk_gate mm_clks[] = {
 	/* MM0 */
diff --git a/drivers/clk/mediatek/clk-mt8167-vdec.c b/drivers/clk/mediatek/clk-mt8167-vdec.c
index 759e5791599f0..92bc05d997985 100644
--- a/drivers/clk/mediatek/clk-mt8167-vdec.c
+++ b/drivers/clk/mediatek/clk-mt8167-vdec.c
@@ -29,23 +29,11 @@ static const struct mtk_gate_regs vdec1_cg_regs = {
 	.sta_ofs = 0x8,
 };
 
-#define GATE_VDEC0_I(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &vdec0_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr_inv,	\
-	}
+#define GATE_VDEC0_I(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &vdec0_cg_regs, _shift, &mtk_clk_gate_ops_setclr_inv)
 
-#define GATE_VDEC1_I(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &vdec1_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr_inv,	\
-	}
+#define GATE_VDEC1_I(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &vdec1_cg_regs, _shift, &mtk_clk_gate_ops_setclr_inv)
 
 static const struct mtk_gate vdec_clks[] __initconst = {
 	/* VDEC0 */
diff --git a/drivers/clk/mediatek/clk-mt8173-mm.c b/drivers/clk/mediatek/clk-mt8173-mm.c
index 315430ad15814..c11ce453a88aa 100644
--- a/drivers/clk/mediatek/clk-mt8173-mm.c
+++ b/drivers/clk/mediatek/clk-mt8173-mm.c
@@ -25,23 +25,11 @@ static const struct mtk_gate_regs mm1_cg_regs = {
 	.sta_ofs = 0x0110,
 };
 
-#define GATE_MM0(_id, _name, _parent, _shift) {			\
-		.id = _id,					\
-		.name = _name,					\
-		.parent_name = _parent,				\
-		.regs = &mm0_cg_regs,				\
-		.shift = _shift,				\
-		.ops = &mtk_clk_gate_ops_setclr,		\
-	}
-
-#define GATE_MM1(_id, _name, _parent, _shift) {			\
-		.id = _id,					\
-		.name = _name,					\
-		.parent_name = _parent,				\
-		.regs = &mm1_cg_regs,				\
-		.shift = _shift,				\
-		.ops = &mtk_clk_gate_ops_setclr,		\
-	}
+#define GATE_MM0(_id, _name, _parent, _shift)	\
+	GATE_MTK(_id, _name, _parent, &mm0_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
+
+#define GATE_MM1(_id, _name, _parent, _shift)	\
+	GATE_MTK(_id, _name, _parent, &mm1_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
 static const struct mtk_gate mt8173_mm_clks[] = {
 	/* MM0 */
diff --git a/drivers/clk/mediatek/clk-mt8516-aud.c b/drivers/clk/mediatek/clk-mt8516-aud.c
index 00f356fe7c7a6..a6ae8003b9ff6 100644
--- a/drivers/clk/mediatek/clk-mt8516-aud.c
+++ b/drivers/clk/mediatek/clk-mt8516-aud.c
@@ -22,14 +22,8 @@ static const struct mtk_gate_regs aud_cg_regs = {
 	.sta_ofs = 0x0,
 };
 
-#define GATE_AUD(_id, _name, _parent, _shift) {	\
-		.id = _id,			\
-		.name = _name,			\
-		.parent_name = _parent,		\
-		.regs = &aud_cg_regs,		\
-		.shift = _shift,		\
-		.ops = &mtk_clk_gate_ops_no_setclr,		\
-	}
+#define GATE_AUD(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &aud_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr)
 
 static const struct mtk_gate aud_clks[] __initconst = {
 	GATE_AUD(CLK_AUD_AFE, "aud_afe", "clk26m_ck", 2),
diff --git a/drivers/clk/mediatek/clk-mt8516.c b/drivers/clk/mediatek/clk-mt8516.c
index 2c0cae7b3bcfe..6983d3a48dc9a 100644
--- a/drivers/clk/mediatek/clk-mt8516.c
+++ b/drivers/clk/mediatek/clk-mt8516.c
@@ -525,59 +525,23 @@ static const struct mtk_gate_regs top5_cg_regs = {
 	.sta_ofs = 0x44,
 };
 
-#define GATE_TOP1(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &top1_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
+#define GATE_TOP1(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &top1_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
-#define GATE_TOP2(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &top2_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
+#define GATE_TOP2(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &top2_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
-#define GATE_TOP2_I(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &top2_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr_inv,	\
-	}
+#define GATE_TOP2_I(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &top2_cg_regs, _shift, &mtk_clk_gate_ops_setclr_inv)
 
-#define GATE_TOP3(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &top3_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
+#define GATE_TOP3(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &top3_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
-#define GATE_TOP4_I(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &top4_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr_inv,	\
-	}
+#define GATE_TOP4_I(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &top4_cg_regs, _shift, &mtk_clk_gate_ops_setclr_inv)
 
-#define GATE_TOP5(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &top5_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr,	\
-	}
+#define GATE_TOP5(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &top5_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
 static const struct mtk_gate top_clks[] __initconst = {
 	/* TOP1 */
-- 
2.39.2



