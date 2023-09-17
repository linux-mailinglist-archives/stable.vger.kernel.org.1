Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB08C7A3A4D
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240333AbjIQUCS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240360AbjIQUBo (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:01:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0986195
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:00:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58CD9C433C8;
        Sun, 17 Sep 2023 20:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980858;
        bh=zN3Kws0VJ8AZiV2HttOJBv0FpVnto5tjsD7g+us9tSA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JxoYbC1q/mlLhgk9oLZy9D+gNi4s1zgZUGH/t9pSdNUwRZ+tAXhOtafMKQHEWflJ1
         31am5fJvNktKNccGAuM7mZw9chDPtxRDdxu11dmsoFR0yw6ZztI0W9qJmmP5l59NqX
         DzFW/2+ecVhf+AqADr0fJFkKLFfHBXtBKZgpVLaw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sheetal <sheetal@nvidia.com>,
        Mohan Kumar D <mkumard@nvidia.com>,
        Sameer Pujar <spujar@nvidia.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.1 029/219] ASoC: tegra: Fix SFC conversion for few rates
Date:   Sun, 17 Sep 2023 21:12:36 +0200
Message-ID: <20230917191042.050557110@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191040.964416434@linuxfoundation.org>
References: <20230917191040.964416434@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sheetal <sheetal@nvidia.com>

commit d900d9a435ca95a386f49424f3689cd17ec201da upstream.

Sample rate conversions for rates greater than 48kHz are found to be
failing. It means x->y conversions fail when either x or y is greater
than 48kHz.

This happens because, tegra210_sfc_rate_to_idx() returns incorrect
index for rates greater than 48kHz. This actually depends on the
tegra210_sfc_rates[] array and it is not in sync with frequency
values of SFC TX/RX register. To be precise, 64kHz entry is missing
in above array defined in the driver. Due to this wrong index is
returned and this results in incorrect programming of coefficients.

To fix this, align the tegra210_sfc_rates[] array with SFC register
specification and thus add 64kHz entry to it. Also, the coefficient
table is updated to reflect that none of the conversions are supported
for 64kHz.

Fixes: b2f74ec53a6c ("ASoC: tegra: Add Tegra210 based SFC driver")
Cc: stable@vger.kernel.org
Signed-off-by: Sheetal <sheetal@nvidia.com>
Reviewed-by: Mohan Kumar D <mkumard@nvidia.com>
Reviewed-by: Sameer Pujar <spujar@nvidia.com>
Link: https://lore.kernel.org/r/Message-Id: <1687433656-7892-2-git-send-email-spujar@nvidia.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/tegra/tegra210_sfc.c |   31 ++++++++++++++++++++++++++++++-
 sound/soc/tegra/tegra210_sfc.h |    4 ++--
 2 files changed, 32 insertions(+), 3 deletions(-)

--- a/sound/soc/tegra/tegra210_sfc.c
+++ b/sound/soc/tegra/tegra210_sfc.c
@@ -2,7 +2,7 @@
 //
 // tegra210_sfc.c - Tegra210 SFC driver
 //
-// Copyright (c) 2021 NVIDIA CORPORATION.  All rights reserved.
+// Copyright (c) 2021-2023 NVIDIA CORPORATION.  All rights reserved.
 
 #include <linux/clk.h>
 #include <linux/device.h>
@@ -42,6 +42,7 @@ static const int tegra210_sfc_rates[TEGR
 	32000,
 	44100,
 	48000,
+	64000,
 	88200,
 	96000,
 	176400,
@@ -2857,6 +2858,7 @@ static s32 *coef_addr_table[TEGRA210_SFC
 		coef_8to32,
 		coef_8to44,
 		coef_8to48,
+		UNSUPP_CONV,
 		coef_8to88,
 		coef_8to96,
 		UNSUPP_CONV,
@@ -2872,6 +2874,7 @@ static s32 *coef_addr_table[TEGRA210_SFC
 		coef_11to32,
 		coef_11to44,
 		coef_11to48,
+		UNSUPP_CONV,
 		coef_11to88,
 		coef_11to96,
 		UNSUPP_CONV,
@@ -2887,6 +2890,7 @@ static s32 *coef_addr_table[TEGRA210_SFC
 		coef_16to32,
 		coef_16to44,
 		coef_16to48,
+		UNSUPP_CONV,
 		coef_16to88,
 		coef_16to96,
 		coef_16to176,
@@ -2902,6 +2906,7 @@ static s32 *coef_addr_table[TEGRA210_SFC
 		coef_22to32,
 		coef_22to44,
 		coef_22to48,
+		UNSUPP_CONV,
 		coef_22to88,
 		coef_22to96,
 		coef_22to176,
@@ -2917,6 +2922,7 @@ static s32 *coef_addr_table[TEGRA210_SFC
 		coef_24to32,
 		coef_24to44,
 		coef_24to48,
+		UNSUPP_CONV,
 		coef_24to88,
 		coef_24to96,
 		coef_24to176,
@@ -2932,6 +2938,7 @@ static s32 *coef_addr_table[TEGRA210_SFC
 		BYPASS_CONV,
 		coef_32to44,
 		coef_32to48,
+		UNSUPP_CONV,
 		coef_32to88,
 		coef_32to96,
 		coef_32to176,
@@ -2947,6 +2954,7 @@ static s32 *coef_addr_table[TEGRA210_SFC
 		coef_44to32,
 		BYPASS_CONV,
 		coef_44to48,
+		UNSUPP_CONV,
 		coef_44to88,
 		coef_44to96,
 		coef_44to176,
@@ -2962,11 +2970,28 @@ static s32 *coef_addr_table[TEGRA210_SFC
 		coef_48to32,
 		coef_48to44,
 		BYPASS_CONV,
+		UNSUPP_CONV,
 		coef_48to88,
 		coef_48to96,
 		coef_48to176,
 		coef_48to192,
 	},
+	/* Convertions from 64 kHz */
+	{
+		UNSUPP_CONV,
+		UNSUPP_CONV,
+		UNSUPP_CONV,
+		UNSUPP_CONV,
+		UNSUPP_CONV,
+		UNSUPP_CONV,
+		UNSUPP_CONV,
+		UNSUPP_CONV,
+		UNSUPP_CONV,
+		UNSUPP_CONV,
+		UNSUPP_CONV,
+		UNSUPP_CONV,
+		UNSUPP_CONV,
+	},
 	/* Convertions from 88.2 kHz */
 	{
 		coef_88to8,
@@ -2977,6 +3002,7 @@ static s32 *coef_addr_table[TEGRA210_SFC
 		coef_88to32,
 		coef_88to44,
 		coef_88to48,
+		UNSUPP_CONV,
 		BYPASS_CONV,
 		coef_88to96,
 		coef_88to176,
@@ -2991,6 +3017,7 @@ static s32 *coef_addr_table[TEGRA210_SFC
 		coef_96to32,
 		coef_96to44,
 		coef_96to48,
+		UNSUPP_CONV,
 		coef_96to88,
 		BYPASS_CONV,
 		coef_96to176,
@@ -3006,6 +3033,7 @@ static s32 *coef_addr_table[TEGRA210_SFC
 		coef_176to32,
 		coef_176to44,
 		coef_176to48,
+		UNSUPP_CONV,
 		coef_176to88,
 		coef_176to96,
 		BYPASS_CONV,
@@ -3021,6 +3049,7 @@ static s32 *coef_addr_table[TEGRA210_SFC
 		coef_192to32,
 		coef_192to44,
 		coef_192to48,
+		UNSUPP_CONV,
 		coef_192to88,
 		coef_192to96,
 		coef_192to176,
--- a/sound/soc/tegra/tegra210_sfc.h
+++ b/sound/soc/tegra/tegra210_sfc.h
@@ -2,7 +2,7 @@
 /*
  * tegra210_sfc.h - Definitions for Tegra210 SFC driver
  *
- * Copyright (c) 2021 NVIDIA CORPORATION.  All rights reserved.
+ * Copyright (c) 2021-2023 NVIDIA CORPORATION.  All rights reserved.
  *
  */
 
@@ -47,7 +47,7 @@
 #define TEGRA210_SFC_EN_SHIFT			0
 #define TEGRA210_SFC_EN				(1 << TEGRA210_SFC_EN_SHIFT)
 
-#define TEGRA210_SFC_NUM_RATES 12
+#define TEGRA210_SFC_NUM_RATES 13
 
 /* Fields in TEGRA210_SFC_COEF_RAM */
 #define TEGRA210_SFC_COEF_RAM_EN		BIT(0)


