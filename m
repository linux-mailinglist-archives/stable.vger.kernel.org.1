Return-Path: <stable+bounces-145044-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE69FABD2B3
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 11:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59F8B3BCEFA
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 09:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1ADE265CAC;
	Tue, 20 May 2025 09:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xZQ+Xdtt"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A81625E46A
	for <stable@vger.kernel.org>; Tue, 20 May 2025 09:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747732069; cv=none; b=TuSxypYwpbzACyRYutw6n4H75drcPCmPCaeWarVzcfy99t/N7WHO+Cl6jJtHKKdH1EXDYmLyjnzOo8YdKec4pi0EnGhH6EmHKz231iHEZSuqIpIcWcdt1UvvQZGA90QGD2Vh74wp8aviGDT4Pbv4AwJqtw0inA5EgaKWSSvwCog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747732069; c=relaxed/simple;
	bh=N9ujteMhCBKejVu/8USvsZhZkHo/Zouv/RmtPEYjTDA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S7eEvVSG8sHnXtaEovY5eLZj58XgHrqTkWaDd+nykGNwVPif7nB0qdGEqaUwVI9GLCnVbBAaD6aASctLwLOpAD4rd2Wbhsgqkgyhf86LIWn8hGiZPlUH1Nsin7HLBy9pGMFLyWBmdtc4WPnSSK3tagmeF5FQJu51w3nxB+J5fgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xZQ+Xdtt; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5fb55d8671dso1080010a12.3
        for <stable@vger.kernel.org>; Tue, 20 May 2025 02:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747732066; x=1748336866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TWIMZcWXWHJPpBFkj5suhON9ygcNcJxNJCQlC1Ja84g=;
        b=xZQ+XdttxSjfiyJwR5szmCMjDPGrybM93RESEYn9B454EyiPNb1+2zvhhlLqEC7Oog
         g9jxYYoQJNahhDL+zPIz/9ZuWTOncZbFTao/XsvsHl17eON+ajIR3g4DDQsm6/5uTstj
         wST+9gJhLqgkX47mq8Fy37vfb2EGQtVEqWINDIsCyku/z5VOiYsMGBqokVGg1gSw52BY
         NxTl0+9FcP3cAwmfY01QR0xNAbnMPkHKd3WeNSnCGcSxzQGZ0834SWe9bEb8o4OOZTmV
         YT20Ctbamns3etZFgpCG83UOVQX1kHeUtIed8810khPAJRNrviLE49fWts4ntSGoV0Sc
         n5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747732066; x=1748336866;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TWIMZcWXWHJPpBFkj5suhON9ygcNcJxNJCQlC1Ja84g=;
        b=mA9pYKSPXmPlAflWpiJXJkTvzD8wPPYhxhPo2fLHWSfUb9jN7npht3YYLnkTN88BQH
         uPwwSDiycrJyEQmognkGLwp6Ih0tY+4TqVoIxT1XdmkVGKCJUzCAKOJ6mrkGIEt9mDSB
         ickqzI1qOoLTP0yActZEcR/lLJv9G9SEHmQrxFR9g65Em9bxcUtgG8Gd6mW9cFQ8Zlym
         qkEQBDUeU/htblFSIqoync7xBe1237tORNb2GTZO6JSxL2s0SYaOHV3pSSgh0MaIQpd3
         C4HTbdKSoCRdNoTckfMds2lvlIz18MesMbMAN2i8/LOYanQxmLYmogin819BgBWTa1p/
         59Tg==
X-Gm-Message-State: AOJu0Yw0ggOAobxRnYPDlqx06oQ7wH0bo9P+4HwNg9raGvCBp1sYkn22
	G2H5EakklGIL66UQXgn3wdOPmXf2jx+c+3FcDQ3USdsoKO9c2mXLOmJlaJh81km52ss=
X-Gm-Gg: ASbGncump4pG8vrNxmC1V/KtC2q5MMJOQjPmYdUvbIexxIr5sknv3B8hr7nadOFmZcu
	f5CCW4UVdsA2NXYs9MjUEgM5zAcBKzuJskoR9AGa1BkJhBXTMo2pEkFaGnIbY9oBcXOM7RYqRoM
	qANCtenX8c1Rpzhorh98OXrI21lixroBFshZWaSs9jJKYjBjAKiyBhK+WgJOLW2wQovc8dhdVwz
	gODdZ1jRHrRtIdMnLkebo2TYDLfapOR5k0wB0pqYdnD3zRKtU1U/CZTu1jbGNFVB1CEB1PwF83u
	qOmY/bF7WvuZ/aBd7scQrxjvZUQ8xzh+wi3hHdWMUcoR7uT8rMgz0CtugPd9wA==
X-Google-Smtp-Source: AGHT+IFDWKtjf+GIZ+hmqdWusENVFWvkwZw0IaHDDGHBg4cVXUO+3LikDLu2ftoBC/yId8PIRHI1tQ==
X-Received: by 2002:a05:6402:50cf:b0:5f4:d131:dbef with SMTP id 4fb4d7f45d1cf-6009013eb1fmr5183896a12.8.1747732065651;
        Tue, 20 May 2025 02:07:45 -0700 (PDT)
Received: from kuoka.. ([178.197.223.125])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6004d501f0dsm6944875a12.21.2025.05.20.02.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 02:07:45 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <lumag@kernel.org>
Subject: [PATCH v6] clk: qcom: dispcc-sm8750: Fix setting rate byte and pixel clocks
Date: Tue, 20 May 2025 11:07:42 +0200
Message-ID: <20250520090741.45820-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2997; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=N9ujteMhCBKejVu/8USvsZhZkHo/Zouv/RmtPEYjTDA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoLEZdW9vZjhTlxiVJQUjnkfg0QHRUFDmTGntZM
 74WyCS4AZyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaCxGXQAKCRDBN2bmhouD
 1/IZEACINMCMKaTwiOSimXOh8GaE6v0tAFFTzOHWlL0jwRm7bUvELVemxFp8ZvEje41v+YJsZY1
 aNWedMVSL1zAa4P9K0/ItTVtH3n5JMMIEcqRBd4fVQfVOcL0UD/jGvva0PPftkzF7lfUqHMUZOv
 B6BQp2X2VArvpweJ5tvL7HC78L03rsNjlGUJKKx2dDjSvwMIZVrNcmkFgtYZkeiF8MRaLgPC+hf
 EulVGG4/MoECuVWPbXIR+qKBexXGaDPFbf+hfKodLGGjH717WNZ0sfAr0fAPHWeKizKlGzdcYLa
 0VLCKjJXz9+QMgBvEcAD0l5kwD4nbAGYZjW1e2jaDOZedKQqtCq9CDBHhnrkE+pujWE5j9SiElj
 zXuUj/FLuHyRjQrsGufCg/uBRgAR6ANjbkj9HJHwxC10mqKenJ7Sh+F6wLwVkoORdSnTDQ3lWMJ
 kXcNgE0zJM14Ku7FI5bFeJS7e4z3fRXT3nfKnSU4N1KCgCYLEk/fumUIpNc9Z0BayHiIqlQ+5UK
 +gv6eUlc40zi5c2kiJpqKYYM+KlOmuSj8wWCJYWhb8Bke8u0VjbmRbj5+07ISgM3q7PMTtjgA9R
 OblsU6pU44zHv0j6T/5BZDRO5hyS16SUbUoN7PXnQcKUvyarM3h1PEyPAlqc2cxHLsx/b9bTUPI tnOOZhUNsie9Vzw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

On SM8750 the setting rate of pixel and byte clocks, while the parent
DSI PHY PLL, fails with:

  disp_cc_mdss_byte0_clk_src: rcg didn't update its configuration.

DSI PHY PLL has to be unprepared and its "PLL Power Down" bits in
CMN_CTRL_0 asserted.

Mark these clocks with CLK_OPS_PARENT_ENABLE to ensure the parent is
enabled during rate changes.

Cc: <stable@vger.kernel.org>
Fixes: f1080d8dab0f ("clk: qcom: dispcc-sm8750: Add SM8750 Display clock controller")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v6:
1. Add CLK_OPS_PARENT_ENABLE also to pclk1, pclk2 and byte1.
2. Add Fixes tag and cc-stable

Previously part of v5 (thus b4 diff might not work nice here):
https://lore.kernel.org/r/20250430-b4-sm8750-display-v5-6-8cab30c3e4df@linaro.org/

Changes in v5:
1. New patch in above patchset.

Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Dmitry Baryshkov <lumag@kernel.org>
---
 drivers/clk/qcom/dispcc-sm8750.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/qcom/dispcc-sm8750.c b/drivers/clk/qcom/dispcc-sm8750.c
index 877b40d50e6f..ca09da111a50 100644
--- a/drivers/clk/qcom/dispcc-sm8750.c
+++ b/drivers/clk/qcom/dispcc-sm8750.c
@@ -393,7 +393,7 @@ static struct clk_rcg2 disp_cc_mdss_byte0_clk_src = {
 		.name = "disp_cc_mdss_byte0_clk_src",
 		.parent_data = disp_cc_parent_data_1,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_1),
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
 		.ops = &clk_byte2_ops,
 	},
 };
@@ -408,7 +408,7 @@ static struct clk_rcg2 disp_cc_mdss_byte1_clk_src = {
 		.name = "disp_cc_mdss_byte1_clk_src",
 		.parent_data = disp_cc_parent_data_1,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_1),
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
 		.ops = &clk_byte2_ops,
 	},
 };
@@ -712,7 +712,7 @@ static struct clk_rcg2 disp_cc_mdss_pclk0_clk_src = {
 		.name = "disp_cc_mdss_pclk0_clk_src",
 		.parent_data = disp_cc_parent_data_1,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_1),
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
 		.ops = &clk_pixel_ops,
 	},
 };
@@ -727,7 +727,7 @@ static struct clk_rcg2 disp_cc_mdss_pclk1_clk_src = {
 		.name = "disp_cc_mdss_pclk1_clk_src",
 		.parent_data = disp_cc_parent_data_1,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_1),
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
 		.ops = &clk_pixel_ops,
 	},
 };
@@ -742,7 +742,7 @@ static struct clk_rcg2 disp_cc_mdss_pclk2_clk_src = {
 		.name = "disp_cc_mdss_pclk2_clk_src",
 		.parent_data = disp_cc_parent_data_1,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_1),
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
 		.ops = &clk_pixel_ops,
 	},
 };
-- 
2.45.2


