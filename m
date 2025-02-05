Return-Path: <stable+bounces-112507-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6A9A28D16
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E37A1889855
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 13:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC861537AC;
	Wed,  5 Feb 2025 13:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NCKoijR8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED901519AA;
	Wed,  5 Feb 2025 13:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738763798; cv=none; b=XIPM14yo1YsVxMPUuchA5FKsBs7KNhDjAmT8mLuPAhVzq1jiYjTdhczao+sEmM/af7posz3MJlzFQCia/sAYVPeGChQefDv/HVZLycjkOBn6qMj3xqEqjycKRGRsfwhknCuPqkM1ghjqV9yeSlu9d6FKFQPQ7Ev/Y2OLw40SXcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738763798; c=relaxed/simple;
	bh=yVghiiqdY8WEprh+pkEmFCgOAev4bnIEA74I34CptR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HFsruNAIMyqlQh/tCjYI4AgaAgucIBs9YTyEuYBM6M8Lxx2n9oyTu375AE+1c8+1B+bFN+0GgvwhcIKj5YiUJ4WVNPDyAIVhx8yOMH5Luo58nH3UguL/r+iZkENh2RgwE7x9vQNyN3Zyzq9IhMBnaermoEeOtQ9jHZQYXUb/v6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NCKoijR8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C17B2C4CED1;
	Wed,  5 Feb 2025 13:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738763798;
	bh=yVghiiqdY8WEprh+pkEmFCgOAev4bnIEA74I34CptR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NCKoijR81ozSwvU+idFEWSRLSJfZeXG9UUSd4AX95EJGE/AIGGqFGt7IxjL489hjX
	 X+VYUe2sRLtdCyGXkipP5Y2VS+YWB5fjDg/QAtckOn4XDYp+HVJF6LmW1/lo02ebh3
	 h1GOwEBjjs3H+qaptfzdF4RJCsr7I2HTXe6TodVo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 058/590] drm/msm/dpu: provide DSPP and correct LM config for SDM670
Date: Wed,  5 Feb 2025 14:36:53 +0100
Message-ID: <20250205134457.477922126@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134455.220373560@linuxfoundation.org>
References: <20250205134455.220373560@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit 9a20f33495bfd45ca6712213f30697f686d0b6fd ]

On SDM670 the DPU has two DSPP blocks compared to 4 DSPP blocks on
SDM845. Currently SDM670 just reuses LMs and DSPPs from SDM845. Define
platform-specific configuration for those blocks.

Fixes: e140b7e496b7 ("drm/msm/dpu: Add hw revision 4.1 (SDM670)")
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Patchwork: https://patchwork.freedesktop.org/patch/629951/
Link: https://lore.kernel.org/r/20241220-dpu-fix-catalog-v2-1-38fa961ea992@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../msm/disp/dpu1/catalog/dpu_4_1_sdm670.h    | 54 ++++++++++++++++++-
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_1_sdm670.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_1_sdm670.h
index cbbdaebe357ec..daef07924886a 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_1_sdm670.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_1_sdm670.h
@@ -65,6 +65,54 @@ static const struct dpu_sspp_cfg sdm670_sspp[] = {
 	},
 };
 
+static const struct dpu_lm_cfg sdm670_lm[] = {
+	{
+		.name = "lm_0", .id = LM_0,
+		.base = 0x44000, .len = 0x320,
+		.features = MIXER_SDM845_MASK,
+		.sblk = &sdm845_lm_sblk,
+		.lm_pair = LM_1,
+		.pingpong = PINGPONG_0,
+		.dspp = DSPP_0,
+	}, {
+		.name = "lm_1", .id = LM_1,
+		.base = 0x45000, .len = 0x320,
+		.features = MIXER_SDM845_MASK,
+		.sblk = &sdm845_lm_sblk,
+		.lm_pair = LM_0,
+		.pingpong = PINGPONG_1,
+		.dspp = DSPP_1,
+	}, {
+		.name = "lm_2", .id = LM_2,
+		.base = 0x46000, .len = 0x320,
+		.features = MIXER_SDM845_MASK,
+		.sblk = &sdm845_lm_sblk,
+		.lm_pair = LM_5,
+		.pingpong = PINGPONG_2,
+	}, {
+		.name = "lm_5", .id = LM_5,
+		.base = 0x49000, .len = 0x320,
+		.features = MIXER_SDM845_MASK,
+		.sblk = &sdm845_lm_sblk,
+		.lm_pair = LM_2,
+		.pingpong = PINGPONG_3,
+	},
+};
+
+static const struct dpu_dspp_cfg sdm670_dspp[] = {
+	{
+		.name = "dspp_0", .id = DSPP_0,
+		.base = 0x54000, .len = 0x1800,
+		.features = DSPP_SC7180_MASK,
+		.sblk = &sdm845_dspp_sblk,
+	}, {
+		.name = "dspp_1", .id = DSPP_1,
+		.base = 0x56000, .len = 0x1800,
+		.features = DSPP_SC7180_MASK,
+		.sblk = &sdm845_dspp_sblk,
+	},
+};
+
 static const struct dpu_dsc_cfg sdm670_dsc[] = {
 	{
 		.name = "dsc_0", .id = DSC_0,
@@ -88,8 +136,10 @@ const struct dpu_mdss_cfg dpu_sdm670_cfg = {
 	.ctl = sdm845_ctl,
 	.sspp_count = ARRAY_SIZE(sdm670_sspp),
 	.sspp = sdm670_sspp,
-	.mixer_count = ARRAY_SIZE(sdm845_lm),
-	.mixer = sdm845_lm,
+	.mixer_count = ARRAY_SIZE(sdm670_lm),
+	.mixer = sdm670_lm,
+	.dspp_count = ARRAY_SIZE(sdm670_dspp),
+	.dspp = sdm670_dspp,
 	.pingpong_count = ARRAY_SIZE(sdm845_pp),
 	.pingpong = sdm845_pp,
 	.dsc_count = ARRAY_SIZE(sdm670_dsc),
-- 
2.39.5




