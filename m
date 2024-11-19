Return-Path: <stable+bounces-93954-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1E69D25D0
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 13:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2AED28470D
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 12:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E067E1CB9E8;
	Tue, 19 Nov 2024 12:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0Pza640"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBFA1C2454
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 12:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732019435; cv=none; b=RBRPxEIhlIWv+B++qIG8QZ4Tf5/RiyajEBhziZpONUxkRR6CYDHdzW4tbik/ILq6TPnEYJZYMHzm9sSeY6fwcT/ZSPINuqNbeO6HNRmgtFHRse7HtxAwiR/FB7XhrH9EimzzCBeoIWoK98qgDeSZecP56BOEWqkddJVJofvS3tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732019435; c=relaxed/simple;
	bh=k/ALDy8sfA1ShV/LnJOY9Qa3JewI1wbcfxRrKFarIxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=misSswYJJ1QzMdw/NsHEw4TDewoa7TIi3upkKFKazpD8Cu9+4i88Vh/9h6ngJ946/XnUm/5EjuuYhD5trKf5eWWooPlQQyizg/qxycZ3o8tKySW6L9X85hoNY0kSfX1QfkEJlF3mqPxliyS1FHmNxMO7QbwFgLD/MsoZQlbc08c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0Pza640; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2164C4CECF;
	Tue, 19 Nov 2024 12:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732019435;
	bh=k/ALDy8sfA1ShV/LnJOY9Qa3JewI1wbcfxRrKFarIxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V0Pza640gI2wu3XFcinfC7GA+nunzg4QgwisZKsozpCnbz/Q+r4480bWad+tEIUUa
	 lqzLlsS/bveFlIchtLyAHjour42Vz+4+lAxobfe2+hxuQpHKqB2hgIb4nnWp6Dq1MT
	 eKmeoF+BCgmJ0Sw8/Gf9drSPAi5mMFMVfDqzSXffPRxxhL5axLAmZTP6GqKTRXCO1L
	 uHJ8iwa876dM6hpx2OY/Y8zyfUJTj+56Zyu3q4mYF4NLtiFLnUx2BPf9XZLVHc9jrN
	 kb5aL5kh9HQziS8F8fo1UPcz4kSocyiXFOB/M5PnMDos3NiEg2TJ/KGlAxPiBSYLgF
	 2yhCL1F1lcF/g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bin Lan <bin.lan.cn@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6] drm/amd/pm: Vangogh: Fix kernel memory out of bounds write
Date: Tue, 19 Nov 2024 07:30:33 -0500
Message-ID: <20241118080812.960909-1-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241118080812.960909-1-bin.lan.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 4aa923a6e6406b43566ef6ac35a3d9a3197fa3e8

WARNING: Author mismatch between patch and upstream commit:
Backport author: Bin Lan <bin.lan.cn@windriver.com>
Commit author: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Commit in newer trees:

|-----------------|----------------------------------------------|
| 6.11.y          |  Present (different SHA1: f8fd9f0d57af)      |
| 6.6.y           |  Not found                                   |
|-----------------|----------------------------------------------|

Note: The patch differs from the upstream commit:
---
--- -	2024-11-19 01:29:31.214989752 -0500
+++ /tmp/tmp.Mb6tGDeJWC	2024-11-19 01:29:31.209354467 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit 4aa923a6e6406b43566ef6ac35a3d9a3197fa3e8 ]
+
 KASAN reports that the GPU metrics table allocated in
 vangogh_tables_init() is not large enough for the memset done in
 smu_cmn_init_soft_gpu_metrics(). Condensed report follows:
@@ -66,22 +68,29 @@
 Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
 (cherry picked from commit 0880f58f9609f0200483a49429af0f050d281703)
 Cc: stable@vger.kernel.org # v6.6+
+Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
 ---
- drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 4 +++-
- 1 file changed, 3 insertions(+), 1 deletion(-)
+ drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 7 +++----
+ 1 file changed, 3 insertions(+), 4 deletions(-)
 
 diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
-index 22737b11b1bfb..1fe020f1f4dbe 100644
+index f46cda889483..454216bd6f1d 100644
 --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
 +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
-@@ -242,7 +242,9 @@ static int vangogh_tables_init(struct smu_context *smu)
+@@ -256,10 +256,9 @@ static int vangogh_tables_init(struct smu_context *smu)
  		goto err0_out;
  	smu_table->metrics_time = 0;
  
--	smu_table->gpu_metrics_table_size = max(sizeof(struct gpu_metrics_v2_3), sizeof(struct gpu_metrics_v2_2));
+-	if (smu_version >= 0x043F3E00)
+-		smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v2_3);
+-	else
+-		smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v2_2);
 +	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v2_2);
 +	smu_table->gpu_metrics_table_size = max(smu_table->gpu_metrics_table_size, sizeof(struct gpu_metrics_v2_3));
 +	smu_table->gpu_metrics_table_size = max(smu_table->gpu_metrics_table_size, sizeof(struct gpu_metrics_v2_4));
  	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
  	if (!smu_table->gpu_metrics_table)
  		goto err1_out;
+-- 
+2.43.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

