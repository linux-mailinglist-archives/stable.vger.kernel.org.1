Return-Path: <stable+bounces-110416-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA06A1BCFE
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 20:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 915463A97FA
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 19:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79952248AC;
	Fri, 24 Jan 2025 19:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHTHv9AV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A715C4A1D
	for <stable@vger.kernel.org>; Fri, 24 Jan 2025 19:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737748325; cv=none; b=A+VTfacUIDMdCaf+8H6pe3PI5PsMlUaybtRQaQtxdWNQxYh+x1xk44rxMGf5R+u1ejLVRF63uaXuWOIImAocgT6VCrMX//dGrGKxMES949+xOTOt4c2XEwH+r40yLHdEbBLSvGVw5xtznTJYJ/L3aOWRHEatUyArnEW/lbqHQy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737748325; c=relaxed/simple;
	bh=V52vYM8wFXWMHNImNm1EMWnrC1j2cFzM7hXvcE8/Xuk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ris4W35MGLe4rW4/1jlvwOvD9H7YDURNqjA2/jqNv3ZO7aVfIC+gHJ0q5+RvmXmujPda3mIrqyh/fnDEpxFkPkdyVY8P/tLwMrE0utxrudn8Z03RbH/aINwnkoaElsB7SP5xn+zmsXUuYn1roov2IYhSjuNAawFDtvVe4CZTY4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHTHv9AV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17396C4CED2;
	Fri, 24 Jan 2025 19:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737748325;
	bh=V52vYM8wFXWMHNImNm1EMWnrC1j2cFzM7hXvcE8/Xuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DHTHv9AVDm6eMNuo7wnde3M+KmDJA7eXs6V7pa7R1fYzYBPYzr1L55IlN0shHs2qb
	 ye40YpdLz626/ojpGY6Pa9vr/OeYeS0wNZYmx9u+Bsj6PeJiMHevo+YHl8DUZna/Ay
	 MRDNq//zU5drjhy6VBps5SeD3iYhvL9xmb3W8sqG6YDFOLl/P4z00o2kwhAkcafBmY
	 CgUQLt7ZHrsVOZFxlgVCN+z91sOkh4/9R8Gzda3tqW0RoVbUp9asrBXhBEKNxDx91z
	 Sp5LheME3hE0HQkJiOGfy2SOQY0RTnJ6k53zrUomyzPREQh7OttnsCJIaT9khMLKmg
	 ilIt8Tig+BTGQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Imkanmod Khan <imkanmodkhan@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] drm/amd/display: fixed integer types and null check locations
Date: Fri, 24 Jan 2025 14:52:03 -0500
Message-Id: <20250124101041-1fef2a4a8d743052@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250124040836.7603-1-imkanmodkhan@gmail.com>
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
Backport author: Imkanmod Khan<imkanmodkhan@gmail.com>
Commit author: Sohaib Nadeem<sohaib.nadeem@amd.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 71783d1ff652)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  0484e05d048b6 ! 1:  1e1b2056735e7 drm/amd/display: fixed integer types and null check locations
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
    +    Signed-off-by: Imkanmod Khan <imkanmodkhan@gmail.com>
     
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

