Return-Path: <stable+bounces-1708-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F3D7F80FC
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83D98B21B10
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9F0321AD;
	Fri, 24 Nov 2023 18:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ja6nZ7Yo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BFA2E64F;
	Fri, 24 Nov 2023 18:54:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C645CC433C8;
	Fri, 24 Nov 2023 18:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700852077;
	bh=k3WEgCYDlFDkldT9wPWwVSbgdRqqAMmejWDP8suzd5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ja6nZ7YoCs8ksh55v8+WzYhkiI6gdkErXCKT5SsLwTW6BplGIHrMKqjz+iRegA0ip
	 VXynuoXNh+OKJ8uzh0hocm2q0r7ri409PcFwYTMLdN/J8apw4qwTiC/6Lyr1gtgaNU
	 +6HCRz/Gd87jtWucj0jwYDZOANpjDzmQ/Evi2pEs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH 6.1 210/372] clk: qcom: ipq6018: drop the CLK_SET_RATE_PARENT flag from PLL clocks
Date: Fri, 24 Nov 2023 17:49:57 +0000
Message-ID: <20231124172017.466898705@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172010.413667921@linuxfoundation.org>
References: <20231124172010.413667921@linuxfoundation.org>
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
@@ -75,7 +75,6 @@ static struct clk_fixed_factor gpll0_out
 				&gpll0_main.clkr.hw },
 		.num_parents = 1,
 		.ops = &clk_fixed_factor_ops,
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -89,7 +88,6 @@ static struct clk_alpha_pll_postdiv gpll
 				&gpll0_main.clkr.hw },
 		.num_parents = 1,
 		.ops = &clk_alpha_pll_postdiv_ro_ops,
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -164,7 +162,6 @@ static struct clk_alpha_pll_postdiv gpll
 				&gpll6_main.clkr.hw },
 		.num_parents = 1,
 		.ops = &clk_alpha_pll_postdiv_ro_ops,
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -195,7 +192,6 @@ static struct clk_alpha_pll_postdiv gpll
 				&gpll4_main.clkr.hw },
 		.num_parents = 1,
 		.ops = &clk_alpha_pll_postdiv_ro_ops,
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -246,7 +242,6 @@ static struct clk_alpha_pll_postdiv gpll
 				&gpll2_main.clkr.hw },
 		.num_parents = 1,
 		.ops = &clk_alpha_pll_postdiv_ro_ops,
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -277,7 +272,6 @@ static struct clk_alpha_pll_postdiv nss_
 				&nss_crypto_pll_main.clkr.hw },
 		.num_parents = 1,
 		.ops = &clk_alpha_pll_postdiv_ro_ops,
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 



