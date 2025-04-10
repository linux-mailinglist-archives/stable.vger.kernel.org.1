Return-Path: <stable+bounces-132149-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F51A848C0
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 17:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E0AF7B4FD3
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 15:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3631B1EDA2F;
	Thu, 10 Apr 2025 15:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUxPlU+t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA87A1EDA2B
	for <stable@vger.kernel.org>; Thu, 10 Apr 2025 15:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744300432; cv=none; b=g6LEOeeixDDF7p1dD+jFXq5QFBwzZr3yJT/56pAk0kJlqfEugEWW2PShmNYz3o1chQCdn4BTM/6y8jtQscUWC2uBgW7lem6QDUj5kcziG+EFO0po0tdVSSpJMszUbwBVzYy+oZAjN0Ky9M7+mndi3pHGu8gGDI9jdifxL4wjkVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744300432; c=relaxed/simple;
	bh=ssHpch7n04mvtuA4R9+qALG58X3yXRVzZ5ZJ6vqZwFk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tyi8WSs6Qed9rcbv7kjk7vwvbeYCfS3yOLArm+TMS7tBUy/GvX+SqbyoDmKHbKjBTR4qGRjq75uKPFcJPYCdWJkVaALvaus9V922bpSZ5O47W0foFJtCMxdLoAtf69G2iHvVhx1mc3tvR6JQph0VvsuMGwNWttzCmG4KWMP7iko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUxPlU+t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B1CBC4CEDD;
	Thu, 10 Apr 2025 15:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744300431;
	bh=ssHpch7n04mvtuA4R9+qALG58X3yXRVzZ5ZJ6vqZwFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GUxPlU+tb8FaJENw03mqUig6kV+fYuZn4NwsdXTNc0AMg8upa2BMeQShQuJpq5lOO
	 mHRkqc6AmjMJTOlc6oTHcJkodVhb+BliWHpItIhYlrZojPEyL/xpXoNqC8kAQCo/CI
	 j/uOVYUprzVRVh+muncnRNNjkhQXA+Jgssv9DWSnhNrBpeyufWRhbnQU3Q9Vx66O8g
	 2hf9Z3HWQcD7sdp8THX/oXcn6LuU15q/72mxV0TVUmJX5tSMSanET+E3iNEjR7rgj7
	 xquak2aKbNwG9Yedar18JePackU1fW4Wt00dQ/jEYWvyTbAu/BjQR00R/wBRsSPcWb
	 a/gDQv0afCRug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] drm/amd/pm: Fix negative array index read
Date: Thu, 10 Apr 2025 11:53:49 -0400
Message-Id: <20250409230916-8840d2154bb4e7b4@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250408005916.3362084-1-jianqi.ren.cn@windriver.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: c8c19ebf7c0b202a6a2d37a52ca112432723db5f

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Jesse Zhang<jesse.zhang@amd.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 4711b1347cb9)
6.1.y | Present (different SHA1: 60f4a4bc3329)
5.15.y | Present (different SHA1: d7f112ac4f8a)

Note: The patch differs from the upstream commit:
---
1:  c8c19ebf7c0b2 ! 1:  c12cb5c0d5794 drm/amd/pm: Fix negative array index read
    @@ Metadata
      ## Commit message ##
         drm/amd/pm: Fix negative array index read
     
    +    [ Upstream commit c8c19ebf7c0b202a6a2d37a52ca112432723db5f ]
    +
         Avoid using the negative values
         for clk_idex as an index into an array pptable->DpmDescriptor.
     
    @@ Commit message
         Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
         Reviewed-by: Tim Huang <Tim.Huang@amd.com>
         Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
    +    [Minor conflict resolved due to code context change.]
    +    Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
      ## drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c ##
     @@ drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c: static int navi10_get_current_clk_freq_by_table(struct smu_context *smu,
    @@ drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c: static int navi10_get_current_c
      	dpm_desc = &pptable->DpmDescriptor[clk_index];
      
      	/* 0 - Fine grained DPM, 1 - Discrete DPM */
    --	return dpm_desc->SnapToDiscrete == 0;
    +-	return dpm_desc->SnapToDiscrete == 0 ? true : false;
     +	return dpm_desc->SnapToDiscrete == 0 ? 1 : 0;
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
| stable/linux-5.10.y       |  Success    |  Success   |

