Return-Path: <stable+bounces-100681-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4069ED207
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 17:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32721188A37F
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 16:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63121DDA3C;
	Wed, 11 Dec 2024 16:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjfCiVDC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846BF1D9688
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 16:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733934818; cv=none; b=Qdz3AwW4vu7o6dcytA3KwLU6Ff7HJzepPASdeQib66G3MtDgrcqEoATNp26hb1Ccj3bgtCK5Y7l4NC2ztz7b0orcnHp9WXD7XEgC6ZneOfh/QD/5l73xFhMvRCbCCvYXrzNFpiHPaidcRKt8nb6UoPtETDRUiSclGKaM5FCMH2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733934818; c=relaxed/simple;
	bh=aDJpOcguRC4/+ClySIJSD37PNwlAnUsBaMXs5SzlZrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UfUq9HQHoajhQnkoX/OtvYbI5ydsQ27x8QFpqJdq+Bo84EXQl6QCzH7yz0kzcMarakPKhWeRBqqYfSgDg9H83FZj33HSBOl1mdCZb0EmpvZrXpUSRfTE9muafIRT03JIae6qPBa1/ZaURr5rJhjs+iyc6EZZaAPQeQb5yuufEb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjfCiVDC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE7A2C4CED2;
	Wed, 11 Dec 2024 16:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733934818;
	bh=aDJpOcguRC4/+ClySIJSD37PNwlAnUsBaMXs5SzlZrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fjfCiVDCNh6o8/jnACqi755P50Fn0iSIqDjk8QECKwgy6p6rFXZnTs8pgo4yAxbzs
	 zsQ4ZLo7z4Pfa62x7glAw7atClahjFRKifg7UUzOJTqXW9zKuj8YeM5GloBz3ATk5z
	 7I/p0k4TTuLtiTL347qNTyAqIz5EPAVLUD13wUCdbdNZzZg53XwUJL0jC5DeSoC89/
	 hPaejbp13WLQRElhuAJ7RdKwTx7P9ep6NGNvtdgQOFkQSSl72C6MiLfIn5yLruhX1h
	 6puOVXDhACVgJT7LPJS/Eu0bXpR/XogCe8RZ2criPmBFCVyVviNnWXs9LBW8mmxQ07
	 LGkjqhlZkmyoA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] drm/amd/display: fixed integer types and null check locations
Date: Wed, 11 Dec 2024 11:33:36 -0500
Message-ID: <20241211100403-47321dbd344e797c@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241211100701.2069799-1-jianqi.ren.cn@windriver.com>
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
1:  0484e05d048b6 ! 1:  805353a2cf50e drm/amd/display: fixed integer types and null check locations
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

