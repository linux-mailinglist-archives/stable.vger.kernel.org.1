Return-Path: <stable+bounces-65051-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A266D943DDA
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5813A1F21612
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CC31CFC86;
	Thu,  1 Aug 2024 00:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JgAk2+Oe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2671CFC7D;
	Thu,  1 Aug 2024 00:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472184; cv=none; b=KpnLMDPcVUMkFCmDJdFob8xWW5uv8mRgHnrTtfI2F7X3PZ7fH1VJVJOKI87M4MonwEdlNcztD688cs1IWx8K00N2y861m1hKdAXyixOF3/oZEQCbJTKtsZCmN3S3iLPqM901YAd2iMcl5bwQ4M7MdjSChjmLxxM4qztQJIchMls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472184; c=relaxed/simple;
	bh=NU3aPticgVgYNvIZkxbxiXk6RwXYtUdZnU25RGk9jOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AUFGXVJFmTJPg6zUiTdceA9TqSWVpKFfGYxMoX0Yu283m60CF1WLfpz0rUq5yKPo1hFUbWFsOflJuK/YDAHisW33U4wNq8IKY1CoRp0tBWBWmu9Qf7S1Xz1i4zLOYZ+vueQDf9UZgdc2Mky0vqairpnDRgLC+bh1CZ2c1U/RPC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JgAk2+Oe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B87FC116B1;
	Thu,  1 Aug 2024 00:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472183;
	bh=NU3aPticgVgYNvIZkxbxiXk6RwXYtUdZnU25RGk9jOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JgAk2+OeudnKpBlLkAGNI0Zs1cyxoHzcMbpj8XBeYSg7C0iNpKlrk8djju0LkOG7U
	 pPcWVDi7+rFawbHjWx58j/JxfduGPv5P4/ISc+oqW9UoH6S0E+QfO+vDsJvWUl24dX
	 Xf2ME+wECd+LfljByng36KOgtZL14vo/+YJKQpqmEiqrAwS8ORlxNqr3rL9WrHFNuC
	 bimPblgwzPRDvYdG7N2J+BhbjMPjSBHf475gKb0JFEvkJlOuW1u7r+gzLUK6UhaJgW
	 uS+G8camw79WEwjykThFwCUVhD/d5dxZxLfBUsw2PyQyoK266jD39fGNZaqMyvlRSA
	 FhoXI9wJX7m0w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ma Jun <Jun.Ma2@amd.com>,
	Yang Wang <kevinyang.wang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	kenneth.feng@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	mario.limonciello@amd.com,
	Tim.Huang@amd.com,
	alexious@zju.edu.cn,
	jesse.zhang@amd.com,
	sunran001@208suo.com,
	lijo.lazar@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 22/61] drm/amdgpu/pm: Check input value for CUSTOM profile mode setting on legacy SOCs
Date: Wed, 31 Jul 2024 20:25:40 -0400
Message-ID: <20240801002803.3935985-22-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002803.3935985-1-sashal@kernel.org>
References: <20240801002803.3935985-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.102
Content-Transfer-Encoding: 8bit

From: Ma Jun <Jun.Ma2@amd.com>

[ Upstream commit df0a9bd92fbbd3fcafcb2bce6463c9228a3e6868 ]

Check the input value for CUSTOM profile mode setting on legacy
SOCs. Otherwise we may use uninitalized value of input[]

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 2 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c | 8 ++++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 5e9410117712c..2abb6ef1845f1 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -5638,7 +5638,7 @@ static int smu7_set_power_profile_mode(struct pp_hwmgr *hwmgr, long *input, uint
 	mode = input[size];
 	switch (mode) {
 	case PP_SMC_POWER_PROFILE_CUSTOM:
-		if (size < 8 && size != 0)
+		if (size != 8 && size != 0)
 			return -EINVAL;
 		/* If only CUSTOM is passed in, use the saved values. Check
 		 * that we actually have a CUSTOM profile by ensuring that
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
index ff77a3683efd5..f6c7701aba9ae 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
@@ -4084,9 +4084,11 @@ static int vega20_set_power_profile_mode(struct pp_hwmgr *hwmgr, long *input, ui
 	if (power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
 		struct vega20_hwmgr *data =
 			(struct vega20_hwmgr *)(hwmgr->backend);
-		if (size == 0 && !data->is_custom_profile_set)
+
+		if (size != 10 && size != 0)
 			return -EINVAL;
-		if (size < 10 && size != 0)
+
+		if (size == 0 && !data->is_custom_profile_set)
 			return -EINVAL;
 
 		result = vega20_get_activity_monitor_coeff(hwmgr,
@@ -4148,6 +4150,8 @@ static int vega20_set_power_profile_mode(struct pp_hwmgr *hwmgr, long *input, ui
 			activity_monitor.Fclk_PD_Data_error_coeff = input[8];
 			activity_monitor.Fclk_PD_Data_error_rate_coeff = input[9];
 			break;
+		default:
+			return -EINVAL;
 		}
 
 		result = vega20_set_activity_monitor_coeff(hwmgr,
-- 
2.43.0


