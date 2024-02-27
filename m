Return-Path: <stable+bounces-24699-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F7C8695E2
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 15:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C31AC1F23777
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0D3145B2F;
	Tue, 27 Feb 2024 14:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aCPbs2a/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061AB14534D;
	Tue, 27 Feb 2024 14:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709042746; cv=none; b=ugdXtr3kqCxrwTU3LV4Enhkr3WZp3lUB4ek+vJCH0En8d5dOYD86T3T+Q3VLMjwmpI3JAwM1Q6EtPQA/QB0QkQmTzD9HYGPMVDmWvL2t7gw9mFZyquojnpwpMwlQgnre+0dA/EFj3vuRyLE+IcudT2whYZIYOC/hiD8sLp+76rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709042746; c=relaxed/simple;
	bh=YzPsXCzLdxGy76OZH6fZn44oAoeYvtux5gsFbIeLWGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HZWIBPttkZNBVP6m1k7v5wJm635K4D9ZhUql3CmYHc8tzfR8qp20VpZkASYYnhSzDdSeual2driFKLCmbw9MW7xtaI0VWxj1J9Mb86Sx3dfbaEgHK+mOxSI7oFv7A0H23SkSJiTBOtEDZZ6qLc1gblQCoVFSdWGwEYYEfjhfoCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aCPbs2a/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C8FC433F1;
	Tue, 27 Feb 2024 14:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709042745;
	bh=YzPsXCzLdxGy76OZH6fZn44oAoeYvtux5gsFbIeLWGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aCPbs2a/Ldos0ZGJDiKX4Q1744Hph4WnqgCYslcvgR+YSj5eOPUrqLSamBemkJBE7
	 eFxMK1hAHTabjKFNjccrOSD1Qrhdm7ZYrF0kZInT2w9glFoAoS3T8RErAexLMpPvx7
	 YsJ/AKHjexUv8M9qFftChA0VPgG+z2tnUG4hBJo4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 106/245] clk: qcom: gcc-qcs404: disable gpll[04]_out_aux parents
Date: Tue, 27 Feb 2024 14:24:54 +0100
Message-ID: <20240227131618.667118780@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131615.098467438@linuxfoundation.org>
References: <20240227131615.098467438@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit 712c64caf31374de57aa193a9dff57172b2f6f82 ]

On the QCS404 platform the driver for the Global Clock Controller
doens't define gpll0_out_aux and gpll4_out_aux clocks, so it's not
possible to use them as parents. Remove entries for these clocks.

Note: backporting this patch to earlier kernels would also require a
previous patch which switches the gcc driver to use ARRAY_SIZE for
parent data arrays.

Fixes: 652f1813c113 ("clk: qcom: gcc: Add global clock controller driver for QCS404")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20221226042154.2666748-6-dmitry.baryshkov@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/gcc-qcs404.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/clk/qcom/gcc-qcs404.c b/drivers/clk/qcom/gcc-qcs404.c
index 46d314d692505..4299fe8f19274 100644
--- a/drivers/clk/qcom/gcc-qcs404.c
+++ b/drivers/clk/qcom/gcc-qcs404.c
@@ -25,11 +25,9 @@ enum {
 	P_CORE_BI_PLL_TEST_SE,
 	P_DSI0_PHY_PLL_OUT_BYTECLK,
 	P_DSI0_PHY_PLL_OUT_DSICLK,
-	P_GPLL0_OUT_AUX,
 	P_GPLL0_OUT_MAIN,
 	P_GPLL1_OUT_MAIN,
 	P_GPLL3_OUT_MAIN,
-	P_GPLL4_OUT_AUX,
 	P_GPLL4_OUT_MAIN,
 	P_GPLL6_OUT_AUX,
 	P_HDMI_PHY_PLL_CLK,
@@ -109,28 +107,24 @@ static const char * const gcc_parent_names_4[] = {
 static const struct parent_map gcc_parent_map_5[] = {
 	{ P_XO, 0 },
 	{ P_DSI0_PHY_PLL_OUT_BYTECLK, 1 },
-	{ P_GPLL0_OUT_AUX, 2 },
 	{ P_CORE_BI_PLL_TEST_SE, 7 },
 };
 
 static const char * const gcc_parent_names_5[] = {
 	"cxo",
 	"dsi0pll_byteclk_src",
-	"gpll0_out_aux",
 	"core_bi_pll_test_se",
 };
 
 static const struct parent_map gcc_parent_map_6[] = {
 	{ P_XO, 0 },
 	{ P_DSI0_PHY_PLL_OUT_BYTECLK, 2 },
-	{ P_GPLL0_OUT_AUX, 3 },
 	{ P_CORE_BI_PLL_TEST_SE, 7 },
 };
 
 static const char * const gcc_parent_names_6[] = {
 	"cxo",
 	"dsi0_phy_pll_out_byteclk",
-	"gpll0_out_aux",
 	"core_bi_pll_test_se",
 };
 
@@ -139,7 +133,6 @@ static const struct parent_map gcc_parent_map_7[] = {
 	{ P_GPLL0_OUT_MAIN, 1 },
 	{ P_GPLL3_OUT_MAIN, 2 },
 	{ P_GPLL6_OUT_AUX, 3 },
-	{ P_GPLL4_OUT_AUX, 4 },
 	{ P_CORE_BI_PLL_TEST_SE, 7 },
 };
 
@@ -148,7 +141,6 @@ static const char * const gcc_parent_names_7[] = {
 	"gpll0_out_main",
 	"gpll3_out_main",
 	"gpll6_out_aux",
-	"gpll4_out_aux",
 	"core_bi_pll_test_se",
 };
 
@@ -207,14 +199,12 @@ static const char * const gcc_parent_names_11[] = {
 static const struct parent_map gcc_parent_map_12[] = {
 	{ P_XO, 0 },
 	{ P_DSI0_PHY_PLL_OUT_DSICLK, 1 },
-	{ P_GPLL0_OUT_AUX, 2 },
 	{ P_CORE_BI_PLL_TEST_SE, 7 },
 };
 
 static const char * const gcc_parent_names_12[] = {
 	"cxo",
 	"dsi0pll_pclk_src",
-	"gpll0_out_aux",
 	"core_bi_pll_test_se",
 };
 
@@ -237,40 +227,34 @@ static const char * const gcc_parent_names_13[] = {
 static const struct parent_map gcc_parent_map_14[] = {
 	{ P_XO, 0 },
 	{ P_GPLL0_OUT_MAIN, 1 },
-	{ P_GPLL4_OUT_AUX, 2 },
 	{ P_CORE_BI_PLL_TEST_SE, 7 },
 };
 
 static const char * const gcc_parent_names_14[] = {
 	"cxo",
 	"gpll0_out_main",
-	"gpll4_out_aux",
 	"core_bi_pll_test_se",
 };
 
 static const struct parent_map gcc_parent_map_15[] = {
 	{ P_XO, 0 },
-	{ P_GPLL0_OUT_AUX, 2 },
 	{ P_CORE_BI_PLL_TEST_SE, 7 },
 };
 
 static const char * const gcc_parent_names_15[] = {
 	"cxo",
-	"gpll0_out_aux",
 	"core_bi_pll_test_se",
 };
 
 static const struct parent_map gcc_parent_map_16[] = {
 	{ P_XO, 0 },
 	{ P_GPLL0_OUT_MAIN, 1 },
-	{ P_GPLL0_OUT_AUX, 2 },
 	{ P_CORE_BI_PLL_TEST_SE, 7 },
 };
 
 static const char * const gcc_parent_names_16[] = {
 	"cxo",
 	"gpll0_out_main",
-	"gpll0_out_aux",
 	"core_bi_pll_test_se",
 };
 
-- 
2.43.0




