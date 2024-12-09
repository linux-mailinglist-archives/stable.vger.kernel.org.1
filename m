Return-Path: <stable+bounces-100212-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F069E990E
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 15:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FD761676FA
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 14:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3041B042A;
	Mon,  9 Dec 2024 14:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWrSH5jy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6E31B0413
	for <stable@vger.kernel.org>; Mon,  9 Dec 2024 14:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733754949; cv=none; b=tujnuE90hHgmZMFc/e8dx97xyzABxneQGQ8Wq7CI5sIrA+NYEdaWXixTf0hAzi8lbvQGtYp1Tiw71T43HcvHuuZuRQo7kTk1RknUHO5pMW+/3YZjkvjEw2mEga0Ddmlv0dNF9jjDFMsMyxY34Jqb5VamV/sumOkdfBiJIqg9cp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733754949; c=relaxed/simple;
	bh=oLqrFnbiE84r9WVWV/ZezCkuRH14soiqHI/hsKaxelc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tCMKyirChGsATt1UDR6HtM7cbA88JQwffh8Nw6DzRQ7sGIMw7iG4JDEth3jhoqt068Ya/qKypJ9UxIIQF972AtN4ZOZyDAdekHnyzGkuYnw3lNAhmBkpmyWJlZDgM96BkSPC5h7GpgdI7A1bI4pi/YMbPpekk8sOY4zW+QUVbio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EWrSH5jy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F4BC4CED1;
	Mon,  9 Dec 2024 14:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733754949;
	bh=oLqrFnbiE84r9WVWV/ZezCkuRH14soiqHI/hsKaxelc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EWrSH5jyYnhpFJThBNItooGSVV+02vSr31ShCZqjRtuU6yygjxiGsRQDdS3zE8Wbn
	 CJnsgMtm+TwtShOY6U+TflxT3YRF3GdvXUYOgBV7A4W1XgYVbVLjXUafMlhJTlsCVb
	 3rQCy+JFwhE4WAmkCozVGGxLzqXvidcT2vlk0E9pw+OJxTtVt3KUqfVbCHZzydfotC
	 OP3tZbvLNrXq1aFECTKpO1J5BPyOzMLZTkP4jPGp9ribgPwc0cSElkcRZzU/gviZHP
	 0cHDFt6z309un3Sh+xifT8jGId2jNWbQ6/Jr65FIEIoH4dr9nCY6qC7MwHWeGkyTlY
	 eBtnQdWGgPytg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] drm/amd/display: fixed integer types and null check locations
Date: Mon,  9 Dec 2024 09:35:47 -0500
Message-ID: <20241209080949-597163d753eb44b0@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241209065028.3427316-1-jianqi.ren.cn@windriver.com>
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
6.6.y | Present (different SHA1: 71783d1ff652)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  0484e05d048b6 ! 1:  b1f3599867537 drm/amd/display: fixed integer types and null check locations
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

