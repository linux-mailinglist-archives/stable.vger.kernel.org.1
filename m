Return-Path: <stable+bounces-63329-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1C3941867
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCBF21C23317
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A2718801B;
	Tue, 30 Jul 2024 16:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YhB4MSnb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB5C188013;
	Tue, 30 Jul 2024 16:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722356478; cv=none; b=UoQ5ePbfM7nCofK23tBETBxOWxcU+u2QYLuX90IaUziUDrjBYnHVMNXrvtg4U4PCC2r0v/xuyBsv0HIjPdVmkdOTpIosFEmLT++mWWn9hh2dvECyNyDK1PYpfrnGFBISqVnGWe1tS3XHVtwaxbKA5WkCxcu7e3/CoswPkjs66Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722356478; c=relaxed/simple;
	bh=BTkFYPhFES3Jevnex3EWazpYo6lgAsoOAbdSykqhbcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BpHiVAvaKZLQjYXatjeQ88nc9dDk+URsbRyxA5nUrOP7ce6xkGfmUHLLS2QnsN2PK8U2mcKge2UaB2QiKpkL0XrUq5SEW5TBYCHbF9FDfL70GhjG9pM2l0ZfrK8LY/h4z9rIHz6g66Gr5Nz5XP/a6MK8QnT8s0ocTt2E4F6ApRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YhB4MSnb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6649EC32782;
	Tue, 30 Jul 2024 16:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722356478;
	bh=BTkFYPhFES3Jevnex3EWazpYo6lgAsoOAbdSykqhbcY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YhB4MSnbhQKeDsB11KUvRC9mtQTv/KoCgiupQChd5AqBIB0JDwkW83s5e8CLqg9RT
	 urWqocDzXqtUcINPQ1pPzchpfcdVFlfxKG23YxhdW2oTCbXuDsGfe/pHWClxup42dE
	 Cz/kGevAqWKISEpFtN8lUqMA+apnzX6uiwpKPvdg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Taniya Das <quic_tdas@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 195/440] clk: qcom: gpucc-sm8350: Park RCGs clk source at XO during disable
Date: Tue, 30 Jul 2024 17:47:08 +0200
Message-ID: <20240730151623.488254355@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151615.753688326@linuxfoundation.org>
References: <20240730151615.753688326@linuxfoundation.org>
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
index 5367ce654ac9a..cc9fcbc884650 100644
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




