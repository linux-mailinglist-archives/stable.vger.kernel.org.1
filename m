Return-Path: <stable+bounces-95545-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 888FF9D9A88
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 16:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E469282913
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 15:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DAD1D6DA1;
	Tue, 26 Nov 2024 15:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TnXL6+ve"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1326D1D63F1
	for <stable@vger.kernel.org>; Tue, 26 Nov 2024 15:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732635570; cv=none; b=DM4t6RnRQch381Qipxr4SnsVE8HQyp4QcOyIDkKiNqlQjORs0c2QaxZ67pMymQXDUN5RnGtEG1FMOsPVCCSrjPiNpXc6TLcXiD2THss8/vjOrFiMzhjAi++rCGw8v17ByrA6QjuAGTEg/9QNuntqnL3D5gWnomK1AW1RRL5rV48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732635570; c=relaxed/simple;
	bh=Lfc8GaVCUDcFXaArw2c2KL30BgwECoac4zR5c2lLGCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GHj5E3C3HkQ/3pgA/5alfm1uHyNWwtpIQe68PgmKOzpdAUmkEIwQE6EfcDOP0eaoy3lYCU/1QpRS2MqUboDqnVPdAu3ynoV1eOPhiDNMLeaIELxjXi08Cn8Vk6UdTqvTeRhd7AusEcy75dk8paVi9dljl5uN22uLukaazekTcMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TnXL6+ve; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24427C4CECF;
	Tue, 26 Nov 2024 15:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732635567;
	bh=Lfc8GaVCUDcFXaArw2c2KL30BgwECoac4zR5c2lLGCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TnXL6+veQ+dgRb+JB8jSKFBPO723ou8kC6BC+gRWmEYNAT0Wbagj+bWkwQ4FrXgew
	 hMEJj25UYyb3XSIKShWtvgEpXqDUPIiSftK+7dVdCzBiovcqXZYKEL8Pg0M0c6AZOo
	 zYjrcCnRDSGBTfNs2SE3oGF25kcKag9yp8khhT+pHE6r8q7+ZneuNMZ59pu7q7e9hA
	 memQeIac8TMmkYFh6w9YgldQn1c9fhR1rT67BXZABWYMRRo2tW5+iBekl3bzaZd6q6
	 70ROaQCarrrPlM4PKBzNdKE2DZzletejN+yeodgdBZN0xkbj5ETxJTPMlzqSBIp9Cm
	 ACk3PBXKjlIKA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiangyu Chen <xiangyu.chen@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6/6.1] drm/amd/display: Initialize denominators' default to 1
Date: Tue, 26 Nov 2024 10:39:25 -0500
Message-ID: <20241126075228-b348ab60f6ff7025@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241126093605.2137050-1-xiangyu.chen@eng.windriver.com>
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

The upstream commit SHA1 provided is correct: b995c0a6de6c74656a0c39cd57a0626351b13e3c

WARNING: Author mismatch between patch and upstream commit:
Backport author: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
Commit author: Alex Hung <alex.hung@amd.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (different SHA1: 7f8e93b862ab)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-26 07:45:10.201552745 -0500
+++ /tmp/tmp.QctaUrZnRu	2024-11-26 07:45:10.196531312 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit b995c0a6de6c74656a0c39cd57a0626351b13e3c ]
+
 [WHAT & HOW]
 Variables used as denominators and maybe not assigned to other values,
 should not be 0. Change their default to 1 so they are never 0.
@@ -9,14 +11,16 @@
 Signed-off-by: Alex Hung <alex.hung@amd.com>
 Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
 Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
+[Xiangyu: Bp to fix CVE: CVE-2024-49899
+Discard the dml2_core/dml2_core_shared.c due to this file no exists]
+Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
 ---
- .../gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c | 2 +-
- drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c | 2 +-
- .../display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c    | 4 ++--
- 3 files changed, 4 insertions(+), 4 deletions(-)
+ .../gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c   | 2 +-
+ drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c   | 2 +-
+ 2 files changed, 2 insertions(+), 2 deletions(-)
 
 diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
-index 7c56ad0f88122..e7019c95ba79e 100644
+index 548cdef8a8ad..543ce9a08cfd 100644
 --- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
 +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
 @@ -78,7 +78,7 @@ static void calculate_ttu_cursor(struct display_mode_lib *mode_lib,
@@ -29,7 +33,7 @@
  	if (source_format == dm_444_16) {
  		if (!is_chroma)
 diff --git a/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c b/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c
-index dae13f202220e..d8bfc85e5dcd0 100644
+index 3df559c591f8..70df992f859d 100644
 --- a/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c
 +++ b/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c
 @@ -39,7 +39,7 @@
@@ -41,18 +45,6 @@
  
  	if (source_format == dm_444_16) {
  		if (!is_chroma)
-diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c
-index 81f0a6f19f87b..679b200319034 100644
---- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c
-+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c
-@@ -9386,8 +9386,8 @@ static void CalculateVMGroupAndRequestTimes(
- 	double TimePerVMRequestVBlank[],
- 	double TimePerVMRequestFlip[])
- {
--	unsigned int num_group_per_lower_vm_stage = 0;
--	unsigned int num_req_per_lower_vm_stage = 0;
-+	unsigned int num_group_per_lower_vm_stage = 1;
-+	unsigned int num_req_per_lower_vm_stage = 1;
- 
- #ifdef __DML_VBA_DEBUG__
- 	dml2_printf("DML::%s: NumberOfActiveSurfaces = %u\n", __func__, NumberOfActiveSurfaces);
+-- 
+2.43.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |
| stable/linux-6.1.y        |  Success    |  Success   |

