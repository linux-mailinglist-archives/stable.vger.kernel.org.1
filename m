Return-Path: <stable+bounces-95830-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2089DEC95
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 21:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98A0C163978
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 20:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE83150994;
	Fri, 29 Nov 2024 20:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MquBLIcb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD4D13DB9F
	for <stable@vger.kernel.org>; Fri, 29 Nov 2024 20:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732910589; cv=none; b=lNu/RJMVAfRuZJx4ru3etIsvlRoAcOlVBb36PvHHdXo1rJ1t2zlk7JMC5Yzb/wyb2anzOYzW2arsbR+ecNPk80s4M0tsX0W96nrFI51M+tt6EpGdsT57B4M6kj0WV03yNLQExRq7O9TF2FmFvmSnurju2VE+rFqbljRvQzgQOQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732910589; c=relaxed/simple;
	bh=Y7uj9D0LjPz47QyrDPz1Q1Y45EAM3gnl4JCr4fR6Ucw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J4INLuzeNtmK30BOudfDRmhP9BLa8c9kGRmeSFnUU07fAqHeVQmN6VcMvNJYBeElM75UEQNbLVv0fyB0gC3WZw29g4fks4gZwbWQuTRVEbwLzs9Trosm3xM7cCFdqbqTyf8zrdWJQKdUntLvzpxJd0erAkONrXHl5c0ODkHP3L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MquBLIcb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A327C4CECF;
	Fri, 29 Nov 2024 20:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732910588;
	bh=Y7uj9D0LjPz47QyrDPz1Q1Y45EAM3gnl4JCr4fR6Ucw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MquBLIcb0GIlLQLX93a6q2cSfPiJVTc80DdyytaondP7dGpJHkQPCwIbboHt1fhDT
	 x/t7WjFDV5iCdfua4KZKSttRB6J1VyV81Bm/c55GIC/wyBrMO/7csWSx/0yTcrLSJ5
	 QIaOIx9pLrJw5s8v96DT+Rwd6flEVKWtLT0+reuMCW7h/DnP5qVK93t+ih64VmuTLd
	 JEseWXIOjJra78kCZv4UbQ+Qkx9eFkhuqaUpwSeHav9at80XPI3PMmc88oDKn11bRQ
	 UEv5sAyiCT6Mh/1ak4oCJQ/cxEjXALx0f78iD7O5HumIwk66RwgNwNlyhs2UI5I7nu
	 kgQKnfwQICkXA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: bin.lan.cn@eng.windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6] drm/amd/display: Add NULL pointer check for kzalloc
Date: Fri, 29 Nov 2024 15:03:06 -0500
Message-ID: <20241129140058-b69db4448612283a@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241129053940.3956690-1-bin.lan.cn@eng.windriver.com>
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

The upstream commit SHA1 provided is correct: 8e65a1b7118acf6af96449e1e66b7adbc9396912

WARNING: Author mismatch between patch and upstream commit:
Backport author: bin.lan.cn@eng.windriver.com
Commit author: Hersen Wu <hersenxs.wu@amd.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  8e65a1b7118ac ! 1:  a22a302a24281 drm/amd/display: Add NULL pointer check for kzalloc
    @@ Metadata
      ## Commit message ##
         drm/amd/display: Add NULL pointer check for kzalloc
     
    +    [ Upstream commit 8e65a1b7118acf6af96449e1e66b7adbc9396912 ]
    +
         [Why & How]
         Check return pointer of kzalloc before using it.
     
    @@ Commit message
         Acked-by: Wayne Lin <wayne.lin@amd.com>
         Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
         Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
    +    [ Resolve minor conflicts ]
    +    Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
     
      ## drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c ##
     @@ drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c: void dcn3_clk_mgr_construct(
    @@ drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c: void dcn32_clk_mgr
      
      void dcn32_clk_mgr_destroy(struct clk_mgr_internal *clk_mgr)
     
    - ## drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c ##
    -@@ drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c: bool dcn30_validate_bandwidth(struct dc *dc,
    + ## drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c ##
    +@@ drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c: bool dcn30_validate_bandwidth(struct dc *dc,
      
      	BW_VAL_TRACE_COUNT();
      
    @@ drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c: bool dcn30_valid
      	out = dcn30_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel, fast_validate, true);
      	DC_FP_END();
     
    - ## drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c ##
    -@@ drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c: static struct hpo_dp_link_encoder *dcn31_hpo_dp_link_encoder_create(
    + ## drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c ##
    +@@ drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c: static struct hpo_dp_link_encoder *dcn31_hpo_dp_link_encoder_create(
      
      	/* allocate HPO link encoder */
      	hpo_dp_enc31 = kzalloc(sizeof(struct dcn31_hpo_dp_link_encoder), GFP_KERNEL);
    @@ drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c: static struct hp
      
      	hpo_dp_link_encoder31_construct(hpo_dp_enc31, ctx, inst,
      					&hpo_dp_link_enc_regs[inst],
    -@@ drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c: bool dcn31_validate_bandwidth(struct dc *dc,
    +@@ drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c: bool dcn31_validate_bandwidth(struct dc *dc,
      
      	BW_VAL_TRACE_COUNT();
      
    @@ drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c: bool dcn31_valid
      	out = dcn30_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel, fast_validate, true);
      	DC_FP_END();
     
    - ## drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c ##
    -@@ drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c: static struct hpo_dp_link_encoder *dcn31_hpo_dp_link_encoder_create(
    + ## drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c ##
    +@@ drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c: static struct hpo_dp_link_encoder *dcn31_hpo_dp_link_encoder_create(
      
      	/* allocate HPO link encoder */
      	hpo_dp_enc31 = kzalloc(sizeof(struct dcn31_hpo_dp_link_encoder), GFP_KERNEL);
    @@ drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c: static struct
      
      	hpo_dp_link_encoder31_construct(hpo_dp_enc31, ctx, inst,
      					&hpo_dp_link_enc_regs[inst],
    -@@ drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c: bool dcn314_validate_bandwidth(struct dc *dc,
    +@@ drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c: bool dcn314_validate_bandwidth(struct dc *dc,
      
      	BW_VAL_TRACE_COUNT();
      
    @@ drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c: bool dcn314_va
      		goto validate_fail;
      
     
    - ## drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c ##
    -@@ drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c: static struct hpo_dp_link_encoder *dcn31_hpo_dp_link_encoder_create(
    + ## drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c ##
    +@@ drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c: static struct hpo_dp_link_encoder *dcn31_hpo_dp_link_encoder_create(
      
      	/* allocate HPO link encoder */
      	hpo_dp_enc31 = kzalloc(sizeof(struct dcn31_hpo_dp_link_encoder), GFP_KERNEL);
    @@ drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c: static struct
      	hpo_dp_link_encoder31_construct(hpo_dp_enc31, ctx, inst,
      					&hpo_dp_link_enc_regs[inst],
     
    - ## drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c ##
    -@@ drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c: static struct hpo_dp_link_encoder *dcn31_hpo_dp_link_encoder_create(
    + ## drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c ##
    +@@ drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c: static struct hpo_dp_link_encoder *dcn31_hpo_dp_link_encoder_create(
      
      	/* allocate HPO link encoder */
      	hpo_dp_enc31 = kzalloc(sizeof(struct dcn31_hpo_dp_link_encoder), GFP_KERNEL);
    @@ drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c: static struct
      	hpo_dp_link_encoder31_construct(hpo_dp_enc31, ctx, inst,
      					&hpo_dp_link_enc_regs[inst],
     
    - ## drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c ##
    -@@ drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c: static struct hpo_dp_link_encoder *dcn32_hpo_dp_link_encoder_create(
    + ## drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c ##
    +@@ drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c: static struct hpo_dp_link_encoder *dcn32_hpo_dp_link_encoder_create(
      
      	/* allocate HPO link encoder */
      	hpo_dp_enc31 = kzalloc(sizeof(struct dcn31_hpo_dp_link_encoder), GFP_KERNEL);
    @@ drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c: static struct hp
      
      #undef REG_STRUCT
      #define REG_STRUCT hpo_dp_link_enc_regs
    -@@ drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c: static bool dml1_validate(struct dc *dc, struct dc_state *context, bool fast_val
    +@@ drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c: bool dcn32_validate_bandwidth(struct dc *dc,
      
      	BW_VAL_TRACE_COUNT();
      
    @@ drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c: static bool dml1
      	out = dcn32_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel, fast_validate);
      	DC_FP_END();
     
    - ## drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c ##
    -@@ drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c: static struct hpo_dp_link_encoder *dcn321_hpo_dp_link_encoder_create(
    - 
    - 	/* allocate HPO link encoder */
    - 	hpo_dp_enc31 = kzalloc(sizeof(struct dcn31_hpo_dp_link_encoder), GFP_KERNEL);
    -+	if (!hpo_dp_enc31)
    -+		return NULL; /* out of memory */
    - 
    - #undef REG_STRUCT
    - #define REG_STRUCT hpo_dp_link_enc_regs
    -
    - ## drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c ##
    -@@ drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c: static struct hpo_dp_link_encoder *dcn31_hpo_dp_link_encoder_create(
    - 
    - 	/* allocate HPO link encoder */
    - 	hpo_dp_enc31 = kzalloc(sizeof(struct dcn31_hpo_dp_link_encoder), GFP_KERNEL);
    -+	if (!hpo_dp_enc31)
    -+		return NULL; /* out of memory */
    - 
    - #undef REG_STRUCT
    - #define REG_STRUCT hpo_dp_link_enc_regs
    -
    - ## drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c ##
    -@@ drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c: static struct hpo_dp_link_encoder *dcn31_hpo_dp_link_encoder_create(
    + ## drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c ##
    +@@ drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c: static struct hpo_dp_link_encoder *dcn321_hpo_dp_link_encoder_create(
      
      	/* allocate HPO link encoder */
      	hpo_dp_enc31 = kzalloc(sizeof(struct dcn31_hpo_dp_link_encoder), GFP_KERNEL);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

