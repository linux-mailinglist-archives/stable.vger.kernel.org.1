Return-Path: <stable+bounces-95471-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D3C9D9032
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 02:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEA64284A5E
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 01:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0441612E5D;
	Tue, 26 Nov 2024 01:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDfeU4qo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71171171C
	for <stable@vger.kernel.org>; Tue, 26 Nov 2024 01:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732586266; cv=none; b=buqCDlQyGvmeK7VRzrvNmfsqX16vpIaVvBXmGC50JuhlDwrYlBpWRctnqMuzKp0oDl70/7ylFEuiGJ/B1OG36DUJbIkav/NWbpb3pAEc/q2SO6iaNtvIAmhViwlP4prNqEAfFl7/sTpJjTPvYfLSOTMPzPqConImHEBEED9veA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732586266; c=relaxed/simple;
	bh=ZPFfKA4q3hqw1y723MULBRP1IAU0IFJ+zoFjuhJjoU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QVzAKTbKPN9g9iZ3LnG90ibgx5CGrJeiWO4I/QWABJwEalI8YL7kwK+oB4bA3GRB7dxJMYkPDf88rFtP2A/t1XTPO/rqzw2ETzcPR8SnAFoBSXqPosxat1dhNKTblWMroI51LpfB1hFmU9WdP4igVzUMHRUnb1+VMyH54tKmvl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDfeU4qo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3F8AC4CECE;
	Tue, 26 Nov 2024 01:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732586266;
	bh=ZPFfKA4q3hqw1y723MULBRP1IAU0IFJ+zoFjuhJjoU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RDfeU4qouTWMJIIYK4LMduB+96Jma9cBmv6Yv9dG/rIRtYm7/dQlqGrKt7U4Tao/i
	 PBRzIIBO1yjN+PXH1VL0rWKbctdI25Sqfl+/E+iUT++4vn9KO9TdR/QqCM+ciIpn03
	 ZUBkh1V7O1Dr3zwGS3iCSB2Vpn859vZaqh/c6i3+kyKuHnS6Jw+5VPLh7+arN2Cljr
	 CO3orGtjUnoBMcmvAnkviIxrDx/5KBHTyrZdE5K4V9Uj6B3uxlRiUFbvCJVQ6MIWqq
	 8GL4YVchOgEBEGtTr5lQkqaO7r4dCVpUQ5wMGEfQnuonbSVnaYhEHPjwQyFuCfYwM5
	 i4DbLFofa5WRg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bin Lan <bin.lan.cn@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6] drm/amd/display: Don't refer to dc_sink in is_dsc_need_re_compute
Date: Mon, 25 Nov 2024 20:57:44 -0500
Message-ID: <20241125204645-8770a623c4f4abee@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241126013403.423044-1-bin.lan.cn@windriver.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: fcf6a49d79923a234844b8efe830a61f3f0584e4

WARNING: Author mismatch between patch and upstream commit:
Backport author: Bin Lan <bin.lan.cn@windriver.com>
Commit author: Wayne Lin <wayne.lin@amd.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-25 20:41:54.282223961 -0500
+++ /tmp/tmp.tgMf4ggSev	2024-11-25 20:41:54.277757758 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit fcf6a49d79923a234844b8efe830a61f3f0584e4 ]
+
 [Why]
 When unplug one of monitors connected after mst hub, encounter null pointer dereference.
 
@@ -14,15 +16,17 @@
 Signed-off-by: Wayne Lin <wayne.lin@amd.com>
 Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
 Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
+[ Resolve minor conflicts ]
+Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
 ---
- .../drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c  | 12 ++++--------
- 1 file changed, 4 insertions(+), 8 deletions(-)
+ drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 4 ++++
+ 1 file changed, 4 insertions(+)
 
 diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
-index ac60f688660ad..f60d55c17fb4f 100644
+index d390e3d62e56..9ec9792f115a 100644
 --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
 +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
-@@ -182,6 +182,8 @@ amdgpu_dm_mst_connector_early_unregister(struct drm_connector *connector)
+@@ -179,6 +179,8 @@ amdgpu_dm_mst_connector_early_unregister(struct drm_connector *connector)
  		dc_sink_release(dc_sink);
  		aconnector->dc_sink = NULL;
  		aconnector->edid = NULL;
@@ -31,7 +35,7 @@
  	}
  
  	aconnector->mst_status = MST_STATUS_DEFAULT;
-@@ -498,6 +500,8 @@ dm_dp_mst_detect(struct drm_connector *connector,
+@@ -487,6 +489,8 @@ dm_dp_mst_detect(struct drm_connector *connector,
  		dc_sink_release(aconnector->dc_sink);
  		aconnector->dc_sink = NULL;
  		aconnector->edid = NULL;
@@ -40,18 +44,6 @@
  
  		amdgpu_dm_set_mst_status(&aconnector->mst_status,
  			MST_REMOTE_EDID | MST_ALLOCATE_NEW_PAYLOAD | MST_CLEAR_ALLOCATED_PAYLOAD,
-@@ -1238,14 +1242,6 @@ static bool is_dsc_need_re_compute(
- 		if (!aconnector || !aconnector->dsc_aux)
- 			continue;
- 
--		/*
--		 *	check if cached virtual MST DSC caps are available and DSC is supported
--		 *	as per specifications in their Virtual DPCD registers.
--		*/
--		if (!(aconnector->dc_sink->dsc_caps.dsc_dec_caps.is_dsc_supported ||
--			aconnector->dc_link->dpcd_caps.dsc_caps.dsc_basic_caps.fields.dsc_support.DSC_PASSTHROUGH_SUPPORT))
--			continue;
--
- 		stream_on_link[new_stream_on_link_num] = aconnector;
- 		new_stream_on_link_num++;
- 
+-- 
+2.43.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

