Return-Path: <stable+bounces-164624-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC32B10E61
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 17:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16014AA4AB5
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 15:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B9C2E973A;
	Thu, 24 Jul 2025 15:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="il5s9Jdk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755D42D5423
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 15:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753370118; cv=none; b=d1Wq5CnBZbHjSPkDC6NFfM4v2e+yJN91zaetCufDIxn2JqcACUVCM8puWzeKN5tEGFC0xsh7GF4hz3WF4O2DDZ/RaPJ5ppdwePx6IMUnrwuetv0A/Z8DJtSmdDwjKQ86xTo9Z0bAe5esMbIRyTpNFBjtJyc4iPa+ns/VyuwIZEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753370118; c=relaxed/simple;
	bh=lEuSNfyZqXVIQ6pim/s1i2RvQBm20QDRZ9mPE/FA8PA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X+d/rVXHH92Mxhg440T4k8X7TaK1iC2Ci/7s6hvl7aYerJm4Q+0QNP4coHQKkSR9sdUl4Cj+fFoanNJOG5lCflPVEaW+p/SPqSlpmQuPryT66xQGsxI50AQ8LBXsoMX744fcEHpvbqmAaIbFw/ErPMOzTir3wuzqCHpUSLAFpk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=il5s9Jdk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC7AC4CEEF;
	Thu, 24 Jul 2025 15:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753370117;
	bh=lEuSNfyZqXVIQ6pim/s1i2RvQBm20QDRZ9mPE/FA8PA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=il5s9Jdk1aAwjW34Jp7cZMNy0FOHufPjqOBavxbJKhTrf4Kevi8+7SHeRteNQ2uLf
	 Cpf3Op2vxTMFWp6YecAMg9H7dYTugFCZukHbMAZDRqfQBTmm32VJi456moeXcocQif
	 WOzMJKUnNnFTKJ7VyYerK/6bCBUAlan40VXCwV8H84gUw3oI6h//pOV3a/X3h5h0vU
	 OkyNLC6aXT2bzd1ybrWCAV/P8TDEbsl37EWK6KYldeVlzx9Tewua4ucbAOHnMrjAYl
	 MgSfoVVEHtwqgJ77p5FyuByMotTpjlOHCWC4UgqPvLxrdAUNzzWmKObi52JRSZtO6X
	 DNmzP2ohqx57A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15/6.1] drm/amd/display: Pass non-null to dcn20_validate_apply_pipe_split_flags
Date: Thu, 24 Jul 2025 11:15:14 -0400
Message-Id: <1753367066-8e275eec@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250724102449.63028-2-d.dulov@aladdin.ru>
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

The upstream commit SHA1 provided is correct: 5559598742fb4538e4c51c48ef70563c49c2af23

WARNING: Author mismatch between patch and upstream commit:
Backport author: Daniil Dulov <d.dulov@aladdin.ru>
Commit author: Alex Hung <alex.hung@amd.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 39a580cd1539)

Note: The patch differs from the upstream commit:
---
1:  5559598742fb ! 1:  011d5796b713 drm/amd/display: Pass non-null to dcn20_validate_apply_pipe_split_flags
    @@ Metadata
      ## Commit message ##
         drm/amd/display: Pass non-null to dcn20_validate_apply_pipe_split_flags
     
    +    commit 5559598742fb4538e4c51c48ef70563c49c2af23 upstream.
    +
         [WHAT & HOW]
         "dcn20_validate_apply_pipe_split_flags" dereferences merge, and thus it
         cannot be a null pointer. Let's pass a valid pointer to avoid null
    @@ Commit message
         Signed-off-by: Alex Hung <alex.hung@amd.com>
         Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
         Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
    +    [ Daniil: dcn20 and dcn21 were moved from drivers/gpu/drm/amd/display/dc to
    +      drivers/gpu/drm/amd/display/dc/resource since commit
    +      8b8eed05a1c6 ("drm/amd/display: Refactor resource into component directory").
    +      The path is changed accordingly to apply the patch on 5.15.y and 6.1.y. ]
    +    Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
     
    - ## drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c ##
    -@@ drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c: bool dcn20_fast_validate_bw(
    + ## drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c ##
    +@@ drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c: bool dcn20_fast_validate_bw(
      {
      	bool out = false;
      	int split[MAX_PIPES] = { 0 };
    @@ drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c: bool dcn20_fast_
      	int pipe_cnt, i, pipe_idx, vlevel;
      
      	ASSERT(pipes);
    -@@ drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c: bool dcn20_fast_validate_bw(
    +@@ drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c: bool dcn20_fast_validate_bw(
      	if (vlevel > context->bw_ctx.dml.soc.num_states)
      		goto validate_fail;
      
    @@ drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c: bool dcn20_fast_
      	/*initialize pipe_just_split_from to invalid idx*/
      	for (i = 0; i < MAX_PIPES; i++)
     
    - ## drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c ##
    -@@ drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c: bool dcn21_fast_validate_bw(struct dc *dc,
    + ## drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c ##
    +@@ drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c: bool dcn21_fast_validate_bw(struct dc *dc,
      {
      	bool out = false;
      	int split[MAX_PIPES] = { 0 };
    @@ drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c: bool dcn21_fast_
      	int pipe_cnt, i, pipe_idx, vlevel;
      
      	ASSERT(pipes);
    -@@ drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c: bool dcn21_fast_validate_bw(struct dc *dc,
    +@@ drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c: bool dcn21_fast_validate_bw(struct dc *dc,
      			goto validate_fail;
      	}
      

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| origin/linux-5.15.y       | Success     | Success    |
| origin/linux-6.1.y        | Success     | Success    |

