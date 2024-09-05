Return-Path: <stable+bounces-73442-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A393C96D4E5
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 11:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1580AB24806
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 09:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BFD194A5B;
	Thu,  5 Sep 2024 09:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V3ZAe03f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE382194A64;
	Thu,  5 Sep 2024 09:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725530244; cv=none; b=kDX6O6Ynp4DqDQwkn4jv/JmWsdSXswELLCBpglmcmLicUdvqHMONTZ+s9N2MDnXlQqzUeth/ItB0YtpRyn5cg/TrUgGRVDeVS7gzZmDwJJDUDQ/SUOKM5bsF7pUw4rcPm03LshYexylCprITcF9PgvbkxlBf9y/IylOSjxc0CDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725530244; c=relaxed/simple;
	bh=j9QR+EjwnubOYq5sQsbkVts9HusfHERmzfu8viATeTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CmiTWZKMNLGZeEPVggw6Wb9I+V8aKNjqoxnklmB53R5AxBBEFHTDZfjnAB2zt+0+vKEC2QnZLF+i6XzM7SMNJ5FWvgXe8XRk4oQ+jOen2THHaVWBX72OBlKorQH5yDeDTVTn5HWDQqK7IlE+5D9wGEYKSNhrh7UR+ze5R/9gjA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V3ZAe03f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB238C4CEC3;
	Thu,  5 Sep 2024 09:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725530244;
	bh=j9QR+EjwnubOYq5sQsbkVts9HusfHERmzfu8viATeTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V3ZAe03fUcyRNXO2CcvIAXblr9MbjSdCRqkazCLTBAJ9pMSPcJMJwEDaQXEWtS83D
	 ypA2U2XAOYqUjjYgJ8lkApZmEtUh5vTqGLwPV2wB5v6Fw4kjB5yUAnkmEXF1pnowB6
	 WQ6wyRa1WwSJ99IOMIubAx5HRHUxB9n1XO+T4BxU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ma Jun <Jun.Ma2@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Yang Wang <kevinyang.wang@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 067/132] drm/amdgpu/pm: Fix uninitialized variable agc_btc_response
Date: Thu,  5 Sep 2024 11:40:54 +0200
Message-ID: <20240905093724.863003182@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905093722.230767298@linuxfoundation.org>
References: <20240905093722.230767298@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ma Jun <Jun.Ma2@amd.com>

[ Upstream commit df4409d8a04dd39d7f2aa0c5f528a56b99eaaa13 ]

Assign an default value to agc_btc_response in failed case

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index a97e393067e4..6c87b3d4ab36 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -2361,15 +2361,20 @@ static int vega10_acg_enable(struct pp_hwmgr *hwmgr)
 {
 	struct vega10_hwmgr *data = hwmgr->backend;
 	uint32_t agc_btc_response;
+	int ret;
 
 	if (data->smu_features[GNLD_ACG].supported) {
 		if (0 == vega10_enable_smc_features(hwmgr, true,
 					data->smu_features[GNLD_DPM_PREFETCHER].smu_feature_bitmap))
 			data->smu_features[GNLD_DPM_PREFETCHER].enabled = true;
 
-		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_InitializeAcg, NULL);
+		ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_InitializeAcg, NULL);
+		if (ret)
+			return ret;
 
-		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_RunAcgBtc, &agc_btc_response);
+		ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_RunAcgBtc, &agc_btc_response);
+		if (ret)
+			agc_btc_response = 0;
 
 		if (1 == agc_btc_response) {
 			if (1 == data->acg_loop_state)
-- 
2.43.0




