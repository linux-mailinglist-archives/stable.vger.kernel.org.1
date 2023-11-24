Return-Path: <stable+bounces-1335-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BCC7F7F29
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DC37282483
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D882F86B;
	Fri, 24 Nov 2023 18:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AXvSp3a+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D26533CCA;
	Fri, 24 Nov 2023 18:39:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 088D8C433C7;
	Fri, 24 Nov 2023 18:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700851144;
	bh=Q3Qt202i+eJYDcoLBrP2RdytBdFxVZUfGu48wWuES4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AXvSp3a+T4mWe7475lp8wn3OueWRPKpXkM2m6w+dxJMKDYD3g7me5C04S91iOYPg/
	 SLOOqOof37iDzVaQdheBXuAoHRhLlMmOxIXzuAqnrYEurkLmMoOKbSbUgsFmD+i0cD
	 7l7y35LgjpgNLR8VCdbDZqEZQNDeJTm1Ow/Dc95I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH 6.5 296/491] clk: qcom: ipq6018: drop the CLK_SET_RATE_PARENT flag from PLL clocks
Date: Fri, 24 Nov 2023 17:48:52 +0000
Message-ID: <20231124172033.465002275@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172024.664207345@linuxfoundation.org>
References: <20231124172024.664207345@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>

commit 99cd4935cb972d0aafb16838bb2aeadbcaf196ce upstream.

GPLL, NSS crypto PLL clock rates are fixed and shouldn't be scaled based
on the request from dependent clocks. Doing so will result in the
unexpected behaviour. So drop the CLK_SET_RATE_PARENT flag from the PLL
clocks.

Cc: stable@vger.kernel.org
Fixes: d9db07f088af ("clk: qcom: Add ipq6018 Global Clock Controller support")
Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230913-gpll_cleanup-v2-2-c8ceb1a37680@quicinc.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/qcom/gcc-ipq6018.c |    6 ------
 1 file changed, 6 deletions(-)

--- a/drivers/clk/qcom/gcc-ipq6018.c
+++ b/drivers/clk/qcom/gcc-ipq6018.c
@@ -73,7 +73,6 @@ static struct clk_fixed_factor gpll0_out
 				&gpll0_main.clkr.hw },
 		.num_parents = 1,
 		.ops = &clk_fixed_factor_ops,
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -87,7 +86,6 @@ static struct clk_alpha_pll_postdiv gpll
 				&gpll0_main.clkr.hw },
 		.num_parents = 1,
 		.ops = &clk_alpha_pll_postdiv_ro_ops,
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -162,7 +160,6 @@ static struct clk_alpha_pll_postdiv gpll
 				&gpll6_main.clkr.hw },
 		.num_parents = 1,
 		.ops = &clk_alpha_pll_postdiv_ro_ops,
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -193,7 +190,6 @@ static struct clk_alpha_pll_postdiv gpll
 				&gpll4_main.clkr.hw },
 		.num_parents = 1,
 		.ops = &clk_alpha_pll_postdiv_ro_ops,
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -244,7 +240,6 @@ static struct clk_alpha_pll_postdiv gpll
 				&gpll2_main.clkr.hw },
 		.num_parents = 1,
 		.ops = &clk_alpha_pll_postdiv_ro_ops,
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -275,7 +270,6 @@ static struct clk_alpha_pll_postdiv nss_
 				&nss_crypto_pll_main.clkr.hw },
 		.num_parents = 1,
 		.ops = &clk_alpha_pll_postdiv_ro_ops,
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 



