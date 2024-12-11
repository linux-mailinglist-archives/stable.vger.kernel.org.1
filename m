Return-Path: <stable+bounces-100653-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 738E89ED1DE
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 17:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 905DE188374A
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 16:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1E01DD0EF;
	Wed, 11 Dec 2024 16:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RvAI5O30"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1900E38DE9
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 16:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733934749; cv=none; b=hPvuu2Bh62yJ+/OCjhaLUQRGZS51ZtO5mfPGLm41z+yxm2uv/NT7Cvm9lj3AMi2xa2ToBIpWrX+GsbwmprvT+zqCwywZ9oKfGaXAdWJBAZqmsOZG7H1/MoTndI/JPsHCwBbQf8ar0bGLK5hR/lVGa5iRURfhNMdxBn9pfRxLKCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733934749; c=relaxed/simple;
	bh=QKzjLrKjHwMyuIZ/6lEJpY2SPcjJfF1uWjTu1PvaWsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sUYmncl1xHP0Jp7uOWoMjP/LGh2WKfsFLy8VavPfdOoab8de1I8cA4ToYJPbHMD0pH1lpGsF+kC7MUCHY9RK+dZmqxhDsdfiL6p9tHSZbP03aoXZ62DT9kyHqtENWjKqyhhliNLXCz8pWTh/fRTFAanhK99n1LAKbwrpbz7aDr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RvAI5O30; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 153AFC4CED2;
	Wed, 11 Dec 2024 16:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733934745;
	bh=QKzjLrKjHwMyuIZ/6lEJpY2SPcjJfF1uWjTu1PvaWsY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RvAI5O30FM69l6s2tNffyyYa2KgRsWdu0h4Z8MRNee16k5xSuthXCWzxPThu8KVqX
	 rVxCWkFNgfqjkmoKIsNJyEiDKe679TiAk7egFfP2RvMGAeXoNOWiGRaeGZ5qVyb4ya
	 rjEaS4N/4X2cdpbFzEhML5KJfsyrGt0F9gFzz8JqMABqBecSkTLjaAB7F0MLZpSqtE
	 LlJzXw7ZHKw1FHgulo6bmSnhiNJpZGB5Sy7HYev9QnG4x+/RHUq37Oz73SgbdJb028
	 H0tHfqVT+vJVKeTYPsEPE1QO65bOZG9don+HKzyaOta/mLG5slBGZhJMdbhfxprWRx
	 1RBXKCikiGgow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Matt Fleming <matt@readmodwrite.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] net/mlx5: unique names for per device caches
Date: Wed, 11 Dec 2024 11:32:23 -0500
Message-ID: <20241211080902-2e0f0ddb7bde5096@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241210210723.3227571-1-mfleming@cloudflare.com>
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

The upstream commit SHA1 provided is correct: 25872a079bbbe952eb660249cc9f40fa75623e68

WARNING: Author mismatch between patch and upstream commit:
Backport author: Matt Fleming <matt@readmodwrite.com>
Commit author: Sebastian Ott <sebott@redhat.com>


Status in newer kernel trees:
6.12.y | Not found

Note: The patch differs from the upstream commit:
---
1:  25872a079bbbe ! 1:  48fb546e12d61 net/mlx5: unique names for per device caches
    @@ Metadata
      ## Commit message ##
         net/mlx5: unique names for per device caches
     
    +    [ Upstream commit 25872a079bbbe952eb660249cc9f40fa75623e68 ]
    +
         Add the device name to the per device kmem_cache names to
         ensure their uniqueness. This fixes warnings like this:
         "kmem_cache of name 'mlx5_fs_fgs' already exists".
     
    +    Fixes: 4c39529663b9 ("slab: Warn on duplicate cache names when DEBUG_VM=y")
         Signed-off-by: Sebastian Ott <sebott@redhat.com>
         Reviewed-by: Breno Leitao <leitao@debian.org>
         Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
         Link: https://patch.msgid.link/20241023134146.28448-1-sebott@redhat.com
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    Signed-off-by: Matt Fleming <mfleming@cloudflare.com>
     
      ## drivers/net/ethernet/mellanox/mlx5/core/fs_core.c ##
     @@ drivers/net/ethernet/mellanox/mlx5/core/fs_core.c: void mlx5_fs_core_free(struct mlx5_core_dev *dev)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |
| stable/linux-6.6.y        |  Success    |  Success   |
| stable/linux-6.1.y        |  Success    |  Success   |
| stable/linux-5.15.y       |  Failed     |  N/A       |
| stable/linux-5.10.y       |  Failed     |  N/A       |
| stable/linux-5.4.y        |  Failed     |  N/A       |

