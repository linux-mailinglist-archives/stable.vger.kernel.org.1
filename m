Return-Path: <stable+bounces-81420-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A21A499345E
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 19:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA09A1C2379C
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 17:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4571DC1A7;
	Mon,  7 Oct 2024 17:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bTWdf1hS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAB61DC190
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 17:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728320678; cv=none; b=UpIW88ns1OaesrDMtS1so/CkNYVFvo8duHGfPlWIyN8LH5kDvvZZuviKqyjZ/ICKbfjkj8ewt4DcUs+RIfh0+v23irDywieatzFKIGiLMEFq+2qvadUXIwhbU+kK1ddkxfY1FS9hq/DfNEBanXGhUdb728yHguahceMiD17LzLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728320678; c=relaxed/simple;
	bh=veiiMLHJzwnRfeil8doj0L0jw1+sNTfdNk+pMjGaX+s=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uwf8WbRQ79SEp/7N84nCHcwFBo3sIPgQ1VzDARBJq5QMZ2G5xK8Cf8sb4hwX7bSW52tymenFN+Hiu18758wGmWPHP+xSJ11x/vwr3kVJgIe2PMJ+7rU4lWCR4Ke2V8GdYCuqD0Vpi+uTj0F4YVNli++R6ShSb5Vl5nQjaaTHpII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bTWdf1hS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C251FC4CECC;
	Mon,  7 Oct 2024 17:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728320678;
	bh=veiiMLHJzwnRfeil8doj0L0jw1+sNTfdNk+pMjGaX+s=;
	h=Subject:To:Cc:From:Date:From;
	b=bTWdf1hSyoFAApMw5YZEqiF7zY98CU3xN7g9PcFARl8kpXLNXmA56+UkLdGEcu4nY
	 6v0Puhm9smJcNzWg+uwnWvSR/dYAjVA7d0eE7/tjqegVlrxvKfOvqM4waSlYKfNC5z
	 3o9PeabictrUrJhQs3Q7P12+04SNI9vk27ko3qcI=
Subject: FAILED: patch "[PATCH] clk: qcom: gcc-sc8180x: Add GPLL9 support" failed to apply to 6.6-stable tree
To: quic_skakitap@quicinc.com,andersson@kernel.org,dmitry.baryshkov@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 07 Oct 2024 19:04:28 +0200
Message-ID: <2024100728-catatonic-catacomb-dc01@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 818a2f8d5e4ad2c1e39a4290158fe8e39a744c70
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100728-catatonic-catacomb-dc01@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

818a2f8d5e4a ("clk: qcom: gcc-sc8180x: Add GPLL9 support")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 818a2f8d5e4ad2c1e39a4290158fe8e39a744c70 Mon Sep 17 00:00:00 2001
From: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Date: Mon, 12 Aug 2024 10:43:03 +0530
Subject: [PATCH] clk: qcom: gcc-sc8180x: Add GPLL9 support

Add the missing GPLL9 pll and fix the gcc_parents_7 data to use
the correct pll hw.

Fixes: 4433594bbe5d ("clk: qcom: gcc: Add global clock controller driver for SC8180x")
Cc: stable@vger.kernel.org
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Link: https://lore.kernel.org/r/20240812-gcc-sc8180x-fixes-v2-3-8b3eaa5fb856@quicinc.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>

diff --git a/drivers/clk/qcom/gcc-sc8180x.c b/drivers/clk/qcom/gcc-sc8180x.c
index d25c5dc37f91..0596427f8922 100644
--- a/drivers/clk/qcom/gcc-sc8180x.c
+++ b/drivers/clk/qcom/gcc-sc8180x.c
@@ -142,6 +142,23 @@ static struct clk_alpha_pll gpll7 = {
 	},
 };
 
+static struct clk_alpha_pll gpll9 = {
+	.offset = 0x1c000,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_TRION],
+	.clkr = {
+		.enable_reg = 0x52000,
+		.enable_mask = BIT(9),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gpll9",
+			.parent_data = &(const struct clk_parent_data) {
+				.fw_name = "bi_tcxo",
+			},
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_fixed_trion_ops,
+		},
+	},
+};
+
 static const struct parent_map gcc_parent_map_0[] = {
 	{ P_BI_TCXO, 0 },
 	{ P_GPLL0_OUT_MAIN, 1 },
@@ -241,7 +258,7 @@ static const struct parent_map gcc_parent_map_7[] = {
 static const struct clk_parent_data gcc_parents_7[] = {
 	{ .fw_name = "bi_tcxo", },
 	{ .hw = &gpll0.clkr.hw },
-	{ .name = "gppl9" },
+	{ .hw = &gpll9.clkr.hw },
 	{ .hw = &gpll4.clkr.hw },
 	{ .hw = &gpll0_out_even.clkr.hw },
 };
@@ -4552,6 +4569,7 @@ static struct clk_regmap *gcc_sc8180x_clocks[] = {
 	[GPLL1] = &gpll1.clkr,
 	[GPLL4] = &gpll4.clkr,
 	[GPLL7] = &gpll7.clkr,
+	[GPLL9] = &gpll9.clkr,
 };
 
 static const struct qcom_reset_map gcc_sc8180x_resets[] = {


