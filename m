Return-Path: <stable+bounces-64146-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD74941C4C
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 19:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B990C1F246EB
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 17:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459A3187FF6;
	Tue, 30 Jul 2024 17:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yue6gxpQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EE81E86F;
	Tue, 30 Jul 2024 17:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722359146; cv=none; b=iueG0UiMNBq+VJq+ZnyQ3ByK/ARwU9AqSAUkNh9OQ+gGB9rlfjSos0rZdkEiTxjz1h2I4ezWqXM4Eaw1TXDvcsgYyL8wTD5QGlRlJqSkDD2sJDqxWs96abOfnOZYpsDDUmsh2nxaOCUG6JZsVzO7fYOkRhYfDLhHN2UPpoYvBcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722359146; c=relaxed/simple;
	bh=/9n9gx1sel7kvmRxjClr6YClerXXAgk8B06kp2fXC1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u0zoLmlmMm9cU9daBg13RsH5F2l6DA+3AF3LUmommgoeB+7q2mhiMIzsLKOwWcADx+nUE9G6JOwYCVgMq4m+Uj+A4PO9sOQe6cAebgMwpwDGUOwM79CHqh/8afr6EAnEUMfyZVldrFhV3skYiPHyf2G3WZcQLVaPESlhEFpTqzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yue6gxpQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42B1AC32782;
	Tue, 30 Jul 2024 17:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722359145;
	bh=/9n9gx1sel7kvmRxjClr6YClerXXAgk8B06kp2fXC1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yue6gxpQrvfLS4mVjE9DWHBNTgULZKr58PVNxKkuN/Lp1amuwzO59urhlYY2bx7yg
	 kAQDjst7t94jwwuGSZZN2giWzurb55wQG/vP9bsJ1SWkuzkflt4Ap6hg3pCs2wydBi
	 2moRZq/3LWQLN2W5Ht3bgqSNmKPYwYsLINSmGj8c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Taniya Das <quic_tdas@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 412/809] clk: qcom: gpucc-sm8350: Park RCGs clk source at XO during disable
Date: Tue, 30 Jul 2024 17:44:48 +0200
Message-ID: <20240730151740.963766050@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151724.637682316@linuxfoundation.org>
References: <20240730151724.637682316@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Taniya Das <quic_tdas@quicinc.com>

[ Upstream commit 313e2909023bef36ef7b6d1d9ff2d98febcaa28d ]

The RCG's clk src has to be parked at XO while disabling as per the
HW recommendation, hence use clk_rcg2_shared_ops to achieve the same.

Fixes: 160758b05ab1 ("clk: qcom: add support for SM8350 GPUCC")
Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org> # SM8350-HDK
Link: https://lore.kernel.org/r/20240621-sm8350-gpucc-fixes-v1-1-22db60c7c5d3@quicinc.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/gpucc-sm8350.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/gpucc-sm8350.c b/drivers/clk/qcom/gpucc-sm8350.c
index 38505d1388b67..8d9dcff40dd0b 100644
--- a/drivers/clk/qcom/gpucc-sm8350.c
+++ b/drivers/clk/qcom/gpucc-sm8350.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (c) 2019-2020, The Linux Foundation. All rights reserved.
  * Copyright (c) 2022, Linaro Limited
+ * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/clk.h>
@@ -147,7 +148,7 @@ static struct clk_rcg2 gpu_cc_gmu_clk_src = {
 		.parent_data = gpu_cc_parent_data_0,
 		.num_parents = ARRAY_SIZE(gpu_cc_parent_data_0),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -169,7 +170,7 @@ static struct clk_rcg2 gpu_cc_hub_clk_src = {
 		.parent_data = gpu_cc_parent_data_1,
 		.num_parents = ARRAY_SIZE(gpu_cc_parent_data_1),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
-- 
2.43.0




