Return-Path: <stable+bounces-98825-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E75C89E58B9
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 15:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8EAB16C402
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 14:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E7521A421;
	Thu,  5 Dec 2024 14:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tQvSLJgM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB555218ABE
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 14:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733409915; cv=none; b=CuuKf5ULHME+IA6sUqi2SpuQir98xcxcAdUwCudYvsQxtq8/4XvpGDjh04RVBasW/+HEaic6/37LTY72urPbxwyXLX5c4ZHWap2kMTtLOlH2SBAJGBfEK+yhRbXLa1zc1V3qACKukVJhA38O4DK/SVHQF7ce1S8jpk8avef6qis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733409915; c=relaxed/simple;
	bh=hmIFfHnUrbJHf4GsDZPUGQmjNGNPOz1/D3bef7LlM2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DF7/Dj3NLrg/vLy9h5kAlgfEOGdWn053g95SpsTbm/qkNO9k8FSDMif381DagQOa8ykuiu9cesaeI0ITLJm17lhqluN/uEeRSP/WU/bGSdgv3kMVEs8KHuXAdU85ccR2n6Ekxc2iuqWXmjDr8pasyqRfT1sTROTboHWywMvcNM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tQvSLJgM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC14C4CEDC;
	Thu,  5 Dec 2024 14:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733409915;
	bh=hmIFfHnUrbJHf4GsDZPUGQmjNGNPOz1/D3bef7LlM2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tQvSLJgMarkkoOj50o9F4rmVHhFj14iObVzpsujGkoXFn6qkW3a75Zc9GvzFF9Z/2
	 xjf6dkkxiwmsO/7QJYGGN6uCn/RImPSaf+19mRHYJjA1I9Gx01PkeeXMHjyTeUxIZl
	 +dxxkMAPEpwne4JZ11MOBMvdVwZ2730x/o0ZTlU8WtJYZFLARguBqA4n5zlBZAel17
	 TWjJqxEaeemJjD77XV6nIX+Sk2zOpvn0d2DpCfKrdRzRdjtJc6pphb5S6FYhGK1eEi
	 iLFyEO/WDjjZsp4F8R3aO39DEdj4+rnCJdTlPa55kkvOyJoUYYPCAP90w4t6iIbSzV
	 4uz52t6iMYFzQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] drm/amd/display: fixed integer types and null check locations
Date: Thu,  5 Dec 2024 08:33:55 -0500
Message-ID: <20241205070647-f7abbf8ef2cdb962@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241205032629.3496629-1-jianqi.ren.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 0484e05d048b66d01d1f3c1d2306010bb57d8738

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Sohaib Nadeem <sohaib.nadeem@amd.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 71783d1ff652)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  0484e05d048b6 ! 1:  b87ee3f3696bd drm/amd/display: fixed integer types and null check locations
    @@ Metadata
      ## Commit message ##
         drm/amd/display: fixed integer types and null check locations
     
    +    [ Upstream commit 0484e05d048b66d01d1f3c1d2306010bb57d8738 ]
    +
         [why]:
         issues fixed:
         - comparison with wider integer type in loop condition which can cause
    @@ Commit message
         Signed-off-by: Sohaib Nadeem <sohaib.nadeem@amd.com>
         Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
         Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
    +    Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
     
      ## drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c ##
     @@ drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c: static enum bp_result get_firmware_info_v3_2(
    @@ drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c: static enum bp_result get_in
      	info->gpu_cap_info =
      	le32_to_cpu(info_v2_2->gpucapinfo);
      	/*
    -
    - ## drivers/gpu/drm/amd/display/dc/link/link_validation.c ##
    -@@ drivers/gpu/drm/amd/display/dc/link/link_validation.c: bool link_validate_dpia_bandwidth(const struct dc_stream_state *stream, const un
    - 	struct dc_link *dpia_link[MAX_DPIA_NUM] = {0};
    - 	int num_dpias = 0;
    - 
    --	for (uint8_t i = 0; i < num_streams; ++i) {
    -+	for (unsigned int i = 0; i < num_streams; ++i) {
    - 		if (stream[i].signal == SIGNAL_TYPE_DISPLAY_PORT) {
    - 			/* new dpia sst stream, check whether it exceeds max dpia */
    - 			if (num_dpias >= MAX_DPIA_NUM)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

