Return-Path: <stable+bounces-98148-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8499E2C19
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 20:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01E6FB2D866
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 18:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8D11F8EE3;
	Tue,  3 Dec 2024 18:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nz3sDZkW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611271F8901
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 18:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733249596; cv=none; b=qq4BBoxIIKLiyneL2WeTeqIJIkPztapqMZZLJErLhMeDE6+rQxRgTSWWPGvE4103pmfgAp4Mxt9HuwKzzYctfvZQgFlUXBfWAk2skimAPSRfgEl/KmZYkLDrB8pEVfA5lQeox0sUhrsM4xXMGIE1Yc6hvQyaqB6NpgzR5B+Um3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733249596; c=relaxed/simple;
	bh=r4vqq3LmqkBJTPhcu2ZhTbA1wuYSSU6amBnSA3V/Lbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nPbmmSK+1bcHPQIc1TQCCTqJDUZ4PdZiZovQON3+tIQMT3/2/+paEnU5TKKe3Ma+1zjHaAEhNuSEFPDoqR4XsUU2fZisgWXL6XG8W1gevPV45IyCZzy0lNR3Kf0eeROWDaC/RRxfDpa69ogwAtAG36AIjso67mrKzsuEd+g50gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nz3sDZkW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0250C4CECF;
	Tue,  3 Dec 2024 18:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733249596;
	bh=r4vqq3LmqkBJTPhcu2ZhTbA1wuYSSU6amBnSA3V/Lbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nz3sDZkWfiXuKWomxr5mgNd9Sbm7QYKSTEgDZ/+sY9Ar2PzWTYl/8u+0PchwNdsBF
	 X/V5zvKgqkldHeX5T70ozbyGCBQWXV43Cxt8xVYWgqZ7MClfmFJP/oV3w5ApTpTSsM
	 qnQ1YFmyzzvpuA5yhLI2FsrpYXadXGpKgjBGjtlqFdyQdcqoTsxsJq2szChPSyDx0A
	 YuWMDJ1KFAmjAC5H4DzV70kk6Tmy4zf99SqIiNw4GOm/qhiPuJ8Mi6D2WBeZ969iwD
	 A0u4bn5yHGDEUDI3Yxk7aycpGi3imtdNnEkCe3pQJgOjd2XmEJbZeVk8/LeTQ9PkFA
	 ANfFcHtmg5sUw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: mingli.yu@eng.windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15] drm/amd/pm: Fix negative array index read
Date: Tue,  3 Dec 2024 13:13:14 -0500
Message-ID: <20241203122342-a4a1aad7c4357eae@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241203070534.1915215-1-mingli.yu@eng.windriver.com>
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

Found matching upstream commit: c8c19ebf7c0b202a6a2d37a52ca112432723db5f

WARNING: Author mismatch between patch and found commit:
Backport author: <mingli.yu@eng.windriver.com>
Commit author: Jesse Zhang <jesse.zhang@amd.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 4711b1347cb9)
6.1.y | Present (different SHA1: 60f4a4bc3329)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  c8c19ebf7c0b2 ! 1:  3574a55cbee45 drm/amd/pm: Fix negative array index read
    @@ Commit message
         Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
         Reviewed-by: Tim Huang <Tim.Huang@amd.com>
         Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
    +    [Don't intruduce the change for navi10_emit_clk_levels which doesn't exist]
    +    Signed-off-by: Mingli Yu <mingli.yu@windriver.com>
     
      ## drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c ##
     @@ drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c: static int navi10_get_current_clk_freq_by_table(struct smu_context *smu,
    @@ drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c: static int navi10_get_current_c
      }
      
      static inline bool navi10_od_feature_is_supported(struct smu_11_0_overdrive_table *od_table, enum SMU_11_0_ODFEATURE_CAP cap)
    -@@ drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c: static int navi10_emit_clk_levels(struct smu_context *smu,
    - 		if (ret)
    - 			return ret;
    - 
    --		if (!navi10_is_support_fine_grained_dpm(smu, clk_type)) {
    -+		ret = navi10_is_support_fine_grained_dpm(smu, clk_type);
    -+		if (ret < 0)
    -+			return ret;
    -+
    -+		if (!ret) {
    - 			for (i = 0; i < count; i++) {
    - 				ret = smu_v11_0_get_dpm_freq_by_index(smu,
    - 								      clk_type, i, &value);
     @@ drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c: static int navi10_print_clk_levels(struct smu_context *smu,
      		if (ret)
      			return size;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

