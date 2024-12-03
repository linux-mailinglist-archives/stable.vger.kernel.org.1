Return-Path: <stable+bounces-98145-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FFD9E2D11
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 21:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA063B2888C
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 18:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A225F1FC7E4;
	Tue,  3 Dec 2024 18:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OX27v3md"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632371FC7DB
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 18:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733249589; cv=none; b=nlov2znz/el89ahlVlLs4s19gaYFV//MvJXvd2UK5xRzO9VkLNMVzGx8ktt2Pu1ahq/nvbOJtr+8ICGpL/dLgQ1Q4jR2TP4lLvYknez/BRuqpp+ORgqsF2D+kcpntZCkQ3rzEv4shyReRQk0z2Njp/QdEIROAs+PJfDCeATuoCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733249589; c=relaxed/simple;
	bh=1cXnosBnv28vQDSUelihnaI0LMUFMS6ZF8S5yo3Z6Vs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JgiyVyTNvLESqBJLg1zJ6+hb6jyCKz94Fq+cAGutOLw/IDwB+ZQOfMJfbnjz7xjaTqby86EZDNyFYQoaJQ/dnZ6awA7/HEtQvDcgMpHx0hAcceTmec5NG8JbS5v5+ha08YgoI3qr1JB185bnJDR7J8UJJGnNJD+VlJ4ypAMLGoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OX27v3md; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D8DC4CECF;
	Tue,  3 Dec 2024 18:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733249589;
	bh=1cXnosBnv28vQDSUelihnaI0LMUFMS6ZF8S5yo3Z6Vs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OX27v3md4clnlykqjnLivfn1bo+c2GI5YWfVmbpA9hK2DOExC60AeRVzRNNE8Ndln
	 AN3+rTZq+a65hIAv+dKQLA1BbO5REioPlOqoa/5Wq8yhT5tqp54O6uQP8XLyZaRNvq
	 0qvRXYZ5CimKGAUcw62wQyV3As95PTK510NvPRtf6p1OwntlOjyhjvgyHX6cyteO/t
	 qY3gKI4CsS+pisibqvmtQteQzZ3B0bPVR9pknaKAdXxyryhgeBM1+9ulnWtBFV3DH0
	 T2uQHKWk3awElx6b3FnlgaBXDG9NxfmCtj04xyrEpk68gn/AFAa09vHFo8aMgnbaIk
	 wt9BOJF7yB3AQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 1/2] drm/amd/display: Skip Invalid Streams from DSC Policy
Date: Tue,  3 Dec 2024 13:13:07 -0500
Message-ID: <20241202133950-efd84bdcc903fe92@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241202172833.985253-1-alexander.deucher@amd.com>
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

Found matching upstream commit: 9afeda04964281e9f708b92c2a9c4f8a1387b46e

WARNING: Author mismatch between patch and found commit:
Backport author: Alex Deucher <alexander.deucher@amd.com>
Commit author: Fangzhi Zuo <Jerry.Zuo@amd.com>


Status in newer kernel trees:
6.12.y | Present (different SHA1: d3c4a1c71521)

Note: The patch differs from the upstream commit:
---
1:  9afeda0496428 ! 1:  e77a231c8dcab drm/amd/display: Skip Invalid Streams from DSC Policy
    @@ Commit message
         Streams with invalid new connector state should be elimiated from
         dsc policy.
     
    +    Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3405
         Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
         Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
         Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
         Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
         Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
    +    (cherry picked from commit 9afeda04964281e9f708b92c2a9c4f8a1387b46e)
    +    Cc: stable@vger.kernel.org
     
      ## drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c ##
     @@ drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c: static int compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |
| stable/linux-6.11.y       |  Success    |  Success   |
| stable/linux-6.6.y        |  Failed     |  N/A       |
| stable/linux-6.1.y        |  Failed     |  N/A       |
| stable/linux-5.15.y       |  Failed     |  N/A       |
| stable/linux-5.10.y       |  Failed     |  N/A       |
| stable/linux-5.4.y        |  Failed     |  N/A       |
| stable/linux-4.19.y       |  Failed     |  N/A       |

