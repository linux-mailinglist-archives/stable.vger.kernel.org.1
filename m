Return-Path: <stable+bounces-136632-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF612A9BB2D
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 01:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06CA01BA3CC9
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 23:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D275211472;
	Thu, 24 Apr 2025 23:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UfTfiwS9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28856A93D
	for <stable@vger.kernel.org>; Thu, 24 Apr 2025 23:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745536964; cv=none; b=pycGU70CxaKSHXydz7PNxMLOg93evrZtXRSozz/aQTLl92/MhOWQJZLO5W1HC3Y3QU6A/fc6guPooXBKNJvqKsp6kQ+ymbZXE9PR8fSItAa+yRzO6Z8RbOGC4vj/UadgFapGvV3BB6l4ZDtE+rC+zNE0QRw8gLVIVWh3nzxBCQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745536964; c=relaxed/simple;
	bh=jkrVeoy2oFpcYmQpt1qr83w+LObM9c/V9vcgumIkms8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o47GZfapcZ1jrGVlBstpd154FnQljVBEa+u2zM6e8x1WCswpvLgjWh3RF5e0UodGna8RQuS41+wOfI1+VRKLyPTxso3PHqDZcON6saO6RmvliVUwKmgLUwfk8XzVD/3tUbioa9/D72A5JZZjNuZPcn8iIoLU3CW8Lxr5GHzc25A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UfTfiwS9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D245C4CEE3;
	Thu, 24 Apr 2025 23:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745536962;
	bh=jkrVeoy2oFpcYmQpt1qr83w+LObM9c/V9vcgumIkms8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UfTfiwS9hBRMtyVmPVVQex02Et5X06fkSM2V0Wh0pPuzbEOCqTGrQ11X5tJyE9gmO
	 PIBmqLIka/Y5Cw8HbGb6acc3R9T/cLgM7E3M9SDj0//rOcx79pV30ZRw/m//3Iq2hB
	 DS6zb+6nVPDmWb8umJnxoLqtScUnZkxXc/LGv2bQYKol863EY2eu73PsUtc6HLx5nk
	 2a85oyrbmqB/DvE74jl3azoR1jRcvmxSyDX89Iur4pXIugfMViWu88J7FSsKRlkckI
	 qqgLQg7J50JmdTqMMyKfeVp70fA1c/yLqsvUl771CSjzle4HCxqquOFIqx3OFSSGZm
	 nRxD6FMJSP98Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiangyu Chen <xiangyu.chen@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] drm/amd/display: fix double free issue during amdgpu module unload
Date: Thu, 24 Apr 2025 19:22:37 -0400
Message-Id: <20250424174129-703a1047365877da@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250424111502.991982-1-xiangyu.chen@eng.windriver.com>
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

The upstream commit SHA1 provided is correct: 20b5a8f9f4670a8503aa9fa95ca632e77c6bf55d

WARNING: Author mismatch between patch and upstream commit:
Backport author: Xiangyu Chen<xiangyu.chen@eng.windriver.com>
Commit author: Tim Huang<tim.huang@amd.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: cf6f3ebd6312)
6.1.y | Present (different SHA1: df948b5ba685)

Note: The patch differs from the upstream commit:
---
1:  20b5a8f9f4670 ! 1:  5e87d2a20150d drm/amd/display: fix double free issue during amdgpu module unload
    @@ Metadata
      ## Commit message ##
         drm/amd/display: fix double free issue during amdgpu module unload
     
    +    [ Upstream commit 20b5a8f9f4670a8503aa9fa95ca632e77c6bf55d ]
    +
         Flexible endpoints use DIGs from available inflexible endpoints,
         so only the encoders of inflexible links need to be freed.
         Otherwise, a double free issue may occur when unloading the
    @@ Commit message
         Signed-off-by: Roman Li <roman.li@amd.com>
         Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
         Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
    +    [ dc_link_destruct() moved from core/dc_link.c to link/link_factory.c since
    +    commit: 54618888d1ea ("drm/amd/display: break down dc_link.c"), so modified
    +    the path to apply on 5.15.y ]
    +    Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
    - ## drivers/gpu/drm/amd/display/dc/link/link_factory.c ##
    -@@ drivers/gpu/drm/amd/display/dc/link/link_factory.c: static void link_destruct(struct dc_link *link)
    + ## drivers/gpu/drm/amd/display/dc/core/dc_link.c ##
    +@@ drivers/gpu/drm/amd/display/dc/core/dc_link.c: static void dc_link_destruct(struct dc_link *link)
      	if (link->panel_cntl)
      		link->panel_cntl->funcs->destroy(&link->panel_cntl);
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

