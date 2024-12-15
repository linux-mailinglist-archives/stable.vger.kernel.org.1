Return-Path: <stable+bounces-104294-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 898E69F267C
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 23:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 947DC16569B
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 22:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EDD1C3C0D;
	Sun, 15 Dec 2024 22:14:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A871BC08B;
	Sun, 15 Dec 2024 22:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734300861; cv=none; b=a6QTISo+KguJ40dwkFoNvcB48GjIBf4Vmmxp8CmOuv6gwIOL9ZRzrQL1wAwDlfcYAueBHRgaDFEi/SzF4LTOC38jdkR9EUM1ziffFwVlvQndMa3mPQkX3HKJHm6FW2Avqxwaf85JhxA7+3DNbakA2QW+sUgye0Q3DM9JFx6kyts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734300861; c=relaxed/simple;
	bh=942bXnQIKNPueWHJnJssgjvToHQd04HsgjzZL01OIbw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PGIrlQivsp8L4Aa1DYncohhZPCDipCVy3eykyLTxEPIARSx7PiBNHrJNYEgS2hZPai+G5uisddNRcg45/Y5vurP04Brq1bQok1XBXq2jGppWu+nIDRha1BDStVBCrRwmg8cv2874eIRqMB2OrCDmdFX/vciJHMbjReCqtYulwd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1tMwsQ-000000002qn-1wDl;
	Sun, 15 Dec 2024 22:14:14 +0000
Date: Sun, 15 Dec 2024 22:14:11 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alexandre Mergnat <amergnat@baylibre.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Daniel Golle <daniel@makrotopia.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Miles Chen <miles.chen@mediatek.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Frank Wunderlich <frank-w@public-files.de>,
	John Crispin <john@phrozen.org>, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, stable@vger.kernel.org
Subject: [PATCH 2/5] clk: mediatek: mt2701-aud: fix conversion to
 mtk_clk_simple_probe
Message-ID: <a07584d803af57b9ce4b5df5e122c09bf5a56ac9.1734300668.git.daniel@makrotopia.org>
References: <b126a5577f3667ef19b1b5feea5e70174084fb03.1734300668.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b126a5577f3667ef19b1b5feea5e70174084fb03.1734300668.git.daniel@makrotopia.org>

Some of the audio subsystem clocks defined in clk-mt2701.h aren't
actually used by the driver. This broke conversion to
mtk_clk_simple_probe which expects that the highest possible clk id is
defined by the ARRAY_SIZE.

Add additional dummy clocks to fill the gaps and remain compatible with
the existing DT bindings.

Fixes: 0f69a423c458 ("clk: mediatek: Switch to mtk_clk_simple_probe() where possible")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/clk/mediatek/clk-mt2701-aud.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt2701-aud.c b/drivers/clk/mediatek/clk-mt2701-aud.c
index 425c69cfb105..e103121cf58e 100644
--- a/drivers/clk/mediatek/clk-mt2701-aud.c
+++ b/drivers/clk/mediatek/clk-mt2701-aud.c
@@ -55,10 +55,16 @@ static const struct mtk_gate audio_clks[] = {
 	GATE_DUMMY(CLK_DUMMY, "aud_dummy"),
 	/* AUDIO0 */
 	GATE_AUDIO0(CLK_AUD_AFE, "audio_afe", "aud_intbus_sel", 2),
+	GATE_DUMMY(CLK_AUD_LRCK_DETECT, "audio_lrck_detect_dummy"),
+	GATE_DUMMY(CLK_AUD_I2S, "audio_i2c_dummy"),
+	GATE_DUMMY(CLK_AUD_APLL_TUNER, "audio_apll_tuner_dummy"),
 	GATE_AUDIO0(CLK_AUD_HDMI, "audio_hdmi", "audpll_sel", 20),
 	GATE_AUDIO0(CLK_AUD_SPDF, "audio_spdf", "audpll_sel", 21),
 	GATE_AUDIO0(CLK_AUD_SPDF2, "audio_spdf2", "audpll_sel", 22),
 	GATE_AUDIO0(CLK_AUD_APLL, "audio_apll", "audpll_sel", 23),
+	GATE_DUMMY(CLK_AUD_TML, "audio_tml_dummy"),
+	GATE_DUMMY(CLK_AUD_AHB_IDLE_EXT, "audio_ahb_idle_ext_dummy"),
+	GATE_DUMMY(CLK_AUD_AHB_IDLE_INT, "audio_ahb_idle_int_dummy"),
 	/* AUDIO1 */
 	GATE_AUDIO1(CLK_AUD_I2SIN1, "audio_i2sin1", "aud_mux1_sel", 0),
 	GATE_AUDIO1(CLK_AUD_I2SIN2, "audio_i2sin2", "aud_mux1_sel", 1),
@@ -76,10 +82,12 @@ static const struct mtk_gate audio_clks[] = {
 	GATE_AUDIO1(CLK_AUD_ASRCI2, "audio_asrci2", "asm_h_sel", 13),
 	GATE_AUDIO1(CLK_AUD_ASRCO1, "audio_asrco1", "asm_h_sel", 14),
 	GATE_AUDIO1(CLK_AUD_ASRCO2, "audio_asrco2", "asm_h_sel", 15),
+	GATE_DUMMY(CLK_AUD_HDMIRX, "audio_hdmirx_dummy"),
 	GATE_AUDIO1(CLK_AUD_INTDIR, "audio_intdir", "intdir_sel", 20),
 	GATE_AUDIO1(CLK_AUD_A1SYS, "audio_a1sys", "aud_mux1_sel", 21),
 	GATE_AUDIO1(CLK_AUD_A2SYS, "audio_a2sys", "aud_mux2_sel", 22),
 	GATE_AUDIO1(CLK_AUD_AFE_CONN, "audio_afe_conn", "aud_mux1_sel", 23),
+	GATE_DUMMY(CLK_AUD_AFE_PCMIF, "audio_afe_pcmif_dummy"),
 	GATE_AUDIO1(CLK_AUD_AFE_MRGIF, "audio_afe_mrgif", "aud_mux1_sel", 25),
 	/* AUDIO2 */
 	GATE_AUDIO2(CLK_AUD_MMIF_UL1, "audio_ul1", "aud_mux1_sel", 0),
@@ -100,6 +108,8 @@ static const struct mtk_gate audio_clks[] = {
 	GATE_AUDIO2(CLK_AUD_MMIF_AWB2, "audio_awb2", "aud_mux1_sel", 15),
 	GATE_AUDIO2(CLK_AUD_MMIF_DAI, "audio_dai", "aud_mux1_sel", 16),
 	/* AUDIO3 */
+	GATE_DUMMY(CLK_AUD_DMIC1, "audio_dmic1_dummy"),
+	GATE_DUMMY(CLK_AUD_DMIC2, "audio_dmic2_dummy"),
 	GATE_AUDIO3(CLK_AUD_ASRCI3, "audio_asrci3", "asm_h_sel", 2),
 	GATE_AUDIO3(CLK_AUD_ASRCI4, "audio_asrci4", "asm_h_sel", 3),
 	GATE_AUDIO3(CLK_AUD_ASRCI5, "audio_asrci5", "asm_h_sel", 4),
-- 
2.47.1

