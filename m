Return-Path: <stable+bounces-119886-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53ECCA490AD
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 06:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDD2E3B7A87
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 04:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CB61ADFE0;
	Fri, 28 Feb 2025 05:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRYd/jSo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CEF1ADC90
	for <stable@vger.kernel.org>; Fri, 28 Feb 2025 05:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740718804; cv=none; b=bo16be9iHp8ugHBuQwXfNhQHzOwBnq8WgSA2xtlF1yrHSam0Fm86NCSg9x/FfcCnzcA6DwLJ32vEgj7sVRZj/76qw3Gf8USCu6ORtG7plAMX6koali1tKVIBxpo9TWF+9/xzDoAmaAC7AXf1XVRkiDbXqgEdLaePzliDM99teIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740718804; c=relaxed/simple;
	bh=iuXAtEaQoX5igi2lQssHtBtYMl1bu8PHr7BodhwxuF8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AJlQ4M3+KsOBqQhCzFKwaSXlQzhapluH3BiUYlM75zX0EpTzYuqD6+4bqdVTOLvqAaprgmPu4yYy03v4WIiW/ymZ/M7pDlmBYAFPfsc/OBiSR4uOz8HRD1/Se2d7liiyfj9TrWFArsmolLHO52bL/37X4WQj1C6mSGuhl0xmqIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CRYd/jSo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A03EC4CED6;
	Fri, 28 Feb 2025 05:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740718803;
	bh=iuXAtEaQoX5igi2lQssHtBtYMl1bu8PHr7BodhwxuF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CRYd/jSoBkobzm++LJu6zVJkoVDKXgNV5SlWQlyWXjf3aD7ldRYK7gn+iNNXPs5J1
	 gElR+KzyBy5xxei9+zKELG/pnlEZkJwPBtUIzMshb9hPGAvFYmV9TUuiysKiYm45iE
	 TA9Xil7NxoypoI/c9K5Ra0+YAMrbQBEeqPa6hvOGWlZrxgIGnXc0O+xl0p5l8bc0yT
	 iEnnpZb347kZDzuQ+RG99OA59KtPIjiylWGPdyTOoRngEFIIXN9JeZMGH6QWhntjdA
	 6gFsSgGP0qh3qPLAoiKoeIiNSdSL3wOpIF67a+PM+TD+9kMI+lLBOAplKBJYFBZkna
	 UmTYZjNk+dCyA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] drm/amd/display: fixed integer types and null check locations
Date: Thu, 27 Feb 2025 23:56:18 -0500
Message-Id: <20250227133645-9b43abeb6f84ccfa@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250227032633.4176866-1-jianqi.ren.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 0484e05d048b66d01d1f3c1d2306010bb57d8738

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Sohaib Nadeem<sohaib.nadeem@amd.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 71783d1ff652)

Note: The patch differs from the upstream commit:
---
1:  0484e05d048b6 ! 1:  9365664c803ec drm/amd/display: fixed integer types and null check locations
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
    +    [ To fix CVE-2024-26767, delete changes made in drivers/gpu/drm/amd/display/dc/link/link_validation.c
    +     for this file is deleted in linux-6.1 ]
    +    Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
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

