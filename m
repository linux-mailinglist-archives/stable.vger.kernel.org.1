Return-Path: <stable+bounces-165126-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E512B153A8
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 21:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE330173C1A
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 19:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B835298CA2;
	Tue, 29 Jul 2025 19:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Na/jQv3p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA8C295504
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 19:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753817854; cv=none; b=ku644Ze6abMuuEzR1vmJ+t7pEXGxKXClQz3wX6lDu5TF4MrwuLCLgiyMgzK7R7LGR1fTLHTXFk618iiHP7mCM/+CcdNVH9CQWaK8Q75Zzi+mPir9xntx76Zs5F6ZvxGxQZfeLIu4MAEEXHDNXAs30Xz3tWLPbUkFWs4ydpGHAoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753817854; c=relaxed/simple;
	bh=l24oEAZFE0WVRfUvn82xzr/kE3XZbKElwXFEtKJV7Qw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TnjJoT9cS4grDv+H2IVAtjJdMl3QcaTFfEzHyhRIa1e6T6odXez2sMCvBCYjdGF/4+1P6pRkTUqRzR5DFVpC2y9Mj+3F4h/VKssT/GBUC+1Vx+/wNyn97oG8RcRclqpZd70dxnfffgM2NLVK++4lPq3yMjYWPMLpoN+6e1oO7IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Na/jQv3p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9805C4CEF8;
	Tue, 29 Jul 2025 19:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753817854;
	bh=l24oEAZFE0WVRfUvn82xzr/kE3XZbKElwXFEtKJV7Qw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Na/jQv3peruFY3FhkBBf5Jqbevdnm+Poh8qeESMgVpc8EZlGalUaqt3Nq3iLoVs+l
	 XVevCJC2z9qoT7zjk1oW1Li7LRntH4MtkNYrrUw9jM6m9BDXFZbD0YJLxJf3mvrPSn
	 ZOh6fz4HTMIkYsTyCBOhfdc9vpKkV9WdZqN3dFCJrUj0qNAa/CCxMpZ7XEI+ka5qKQ
	 ECHiP2SMC2sf3kmxB8CVrm/gWK/sB2Yu/SUjhs9tINiibSlzyQ/TZEHJFR6wGaghju
	 tcTT11BimYeab6fIUa3k4N3sLHpek2MAj0+Z2u6ksbiwPZadVOxL2GTvDbOQ4Yfg+Y
	 yNug2KEKw4eQQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1/6.6] drm/amd/display: Add null check for head_pipe in dcn32_acquire_idle_pipe_for_head_pipe_in_layer
Date: Tue, 29 Jul 2025 15:37:31 -0400
Message-Id: <1753807571-ee8892f9@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250729114924.138111-1-d.dulov@aladdin.ru>
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

The upstream commit SHA1 provided is correct: ac2140449184a26eac99585b7f69814bd3ba8f2d

WARNING: Author mismatch between patch and upstream commit:
Backport author: Daniil Dulov <d.dulov@aladdin.ru>
Commit author: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  ac2140449184 ! 1:  7a19ddcf0b97 drm/amd/display: Add null check for head_pipe in dcn32_acquire_idle_pipe_for_head_pipe_in_layer
    @@ Metadata
      ## Commit message ##
         drm/amd/display: Add null check for head_pipe in dcn32_acquire_idle_pipe_for_head_pipe_in_layer
     
    +    commit ac2140449184a26eac99585b7f69814bd3ba8f2d upstream.
    +
         This commit addresses a potential null pointer dereference issue in the
         `dcn32_acquire_idle_pipe_for_head_pipe_in_layer` function. The issue
         could occur when `head_pipe` is null.
    @@ Commit message
         Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
         Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>
         Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
    +    [ Daniil: dcn32 was moved from drivers/gpu/drm/amd/display/dc to
    +      drivers/gpu/drm/amd/display/dc/resource since commit
    +      8b8eed05a1c6 ("drm/amd/display: Refactor resource into component directory").
    +      The path is changed accordingly to apply the patch on 6.1.y. and 6.6.y ]
    +    Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
     
    - ## drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c ##
    -@@ drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c: static struct pipe_ctx *dcn32_acquire_idle_pipe_for_head_pipe_in_layer(
    + ## drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c ##
    +@@ drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c: static struct pipe_ctx *dcn32_acquire_idle_pipe_for_head_pipe_in_layer(
      	struct resource_context *old_ctx = &stream->ctx->dc->current_state->res_ctx;
      	int head_index;
      

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| origin/linux-6.1.y        | Success     | Success    |
| origin/linux-6.6.y        | Success     | Success    |

