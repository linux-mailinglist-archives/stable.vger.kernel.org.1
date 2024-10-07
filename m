Return-Path: <stable+bounces-81419-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AE199345C
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 19:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A67001C225E6
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 17:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF5C1DC189;
	Mon,  7 Oct 2024 17:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dSKmKOrz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001021DC06F
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 17:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728320675; cv=none; b=Dxmk9WLXhHtW99je2owABU1mBU5Nq0uqFT37mPTnSm2IzjxPeuUzMEOrVjnYAoeNqYqx73ej8VYjt4TQU6ZKhvZ3LWgopZhr1jCdOWIJHsX416saqyyD5uNfmXHgkAxciIRfWmVP1CJjGaTR3KDHGZAD4c2RHLYKUZ4ZK0d0l+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728320675; c=relaxed/simple;
	bh=4FbEguAEk0Rz/WRdtR2Y2dHChLLLegITwldthxyoH2c=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=g73gXqn70wJOP9GGQri9w+5SH18+i6aXCmbYmEaF5dibS43E8MIpsyM7Q/ypetYjSSFqw2G2drUuIUsG6g+fBNwsqZG7jnLxpZlYvFM+BxNMACbE4/gzm8yCQePmFLSn+G3DwJCRNLI2xoHNUsomsleSvrmTHrQC5+yViQTdqzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dSKmKOrz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 644FFC4CEC6;
	Mon,  7 Oct 2024 17:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728320674;
	bh=4FbEguAEk0Rz/WRdtR2Y2dHChLLLegITwldthxyoH2c=;
	h=Subject:To:Cc:From:Date:From;
	b=dSKmKOrzDU3k5TtcGYp3+yTZtqBrIVyjA49dBJr5sskMq9dPdSJXoBGDB0wP8ohGy
	 DrVfWuYcuLIzUGdbu6OgHDjxQwORlCPPwca6f7n+zB+s6klbpbMv2RFLxrxi9Kv38x
	 4XWeWpXAUALVxYwBUz4tLokQpxxNakV/NGoPxKQs=
Subject: FAILED: patch "[PATCH] clk: qcom: gcc-sc8180x: Add GPLL9 support" failed to apply to 6.1-stable tree
To: quic_skakitap@quicinc.com,andersson@kernel.org,dmitry.baryshkov@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 07 Oct 2024 19:04:28 +0200
Message-ID: <2024100727-shock-morality-cfc4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 818a2f8d5e4ad2c1e39a4290158fe8e39a744c70
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100727-shock-morality-cfc4@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


