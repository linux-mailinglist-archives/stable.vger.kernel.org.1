Return-Path: <stable+bounces-115799-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CD8A345B8
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 16:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A84A16C81A
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 15:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2766E26B0BE;
	Thu, 13 Feb 2025 15:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KVuOkXkj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D909C26B080;
	Thu, 13 Feb 2025 15:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739459293; cv=none; b=JiyXCxTMQJ6p1p6rXImtOLLdo++0runEOMzpAfpKMqxy5eqZxPttTsuzZnfoFlo3z7mgDBXfKOQDBBqzGINe2I0j/hfRzAW7hl6RjhnBJSH6U+G8nsdodM9N/e/Np/CF/mb25YvrGGgQssGwWfK1/A7yJxHe7GUvLMyxIwbl7HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739459293; c=relaxed/simple;
	bh=azO2qdeXifJy5+ZMCKbc3nBAxQpSt4nIs5ahCUmM0vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mWqunPbrSBkg0i9+N4kO97Oza1IAwVPEZk723KxQxm7sEi6yIePsVB4HtIVb0nWhN+Hw6VTbXpSDgpS+Qf7Fatvr8ndzVWTXV8envbhTAHSofjWGLX1w1vqDUoMTowNhstCa5qfHdjfu4PjW2m/CFtE7SxTQ8P+7vSIi9rDoSOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KVuOkXkj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AA59C4CED1;
	Thu, 13 Feb 2025 15:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739459293;
	bh=azO2qdeXifJy5+ZMCKbc3nBAxQpSt4nIs5ahCUmM0vc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KVuOkXkj4yl0Uhn5MDT2JPoroWoYI3aRvujBRDONXNNXnTY9WXATQvb2zSOwLxRjg
	 tr2wPYqIyOYL5Ekm16DkSSOs1gk3zBvpatNqIE6LbOdfHwqPJ4sIGTV/MNmtyECGU6
	 TU6x5f23232aW7xQC+102sKY9WiDboZ1keVGiyEk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniel Golle <daniel@makrotopia.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 6.13 205/443] clk: mediatek: mt2701-aud: fix conversion to mtk_clk_simple_probe
Date: Thu, 13 Feb 2025 15:26:10 +0100
Message-ID: <20250213142448.526066108@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213142440.609878115@linuxfoundation.org>
References: <20250213142440.609878115@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Golle <daniel@makrotopia.org>

commit 5fba40be5fbad563914e3ce9d5129a6baaea1ff5 upstream.

Some of the audio subsystem clocks defined in clk-mt2701.h aren't
actually used by the driver. This broke conversion to
mtk_clk_simple_probe which expects that the highest possible clk id is
defined by the ARRAY_SIZE.

Add additional dummy clocks to fill the gaps and remain compatible with
the existing DT bindings.

Fixes: 0f69a423c458 ("clk: mediatek: Switch to mtk_clk_simple_probe() where possible")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Link: https://lore.kernel.org/r/a07584d803af57b9ce4b5df5e122c09bf5a56ac9.1734300668.git.daniel@makrotopia.org
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/mediatek/clk-mt2701-aud.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/drivers/clk/mediatek/clk-mt2701-aud.c
+++ b/drivers/clk/mediatek/clk-mt2701-aud.c
@@ -55,10 +55,16 @@ static const struct mtk_gate audio_clks[
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
@@ -76,10 +82,12 @@ static const struct mtk_gate audio_clks[
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
@@ -100,6 +108,8 @@ static const struct mtk_gate audio_clks[
 	GATE_AUDIO2(CLK_AUD_MMIF_AWB2, "audio_awb2", "aud_mux1_sel", 15),
 	GATE_AUDIO2(CLK_AUD_MMIF_DAI, "audio_dai", "aud_mux1_sel", 16),
 	/* AUDIO3 */
+	GATE_DUMMY(CLK_AUD_DMIC1, "audio_dmic1_dummy"),
+	GATE_DUMMY(CLK_AUD_DMIC2, "audio_dmic2_dummy"),
 	GATE_AUDIO3(CLK_AUD_ASRCI3, "audio_asrci3", "asm_h_sel", 2),
 	GATE_AUDIO3(CLK_AUD_ASRCI4, "audio_asrci4", "asm_h_sel", 3),
 	GATE_AUDIO3(CLK_AUD_ASRCI5, "audio_asrci5", "asm_h_sel", 4),



