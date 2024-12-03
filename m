Return-Path: <stable+bounces-98157-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 490F29E2B7E
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 19:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EDBFB3A0B4
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 18:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12211FA840;
	Tue,  3 Dec 2024 18:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRJ9+O9p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D641F8901
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 18:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733249615; cv=none; b=TklTOEmQZyiQfGpAHThx2h0VQm55qPbwrlmJCm2kvzTbfNijIZ3HnjWGBUozWa9n7D1PF2meGVF96hRhpmFM6avKUWaCTMhvJ/4JPXgZHmcraiOgE20XkJ54RbRpH6txtjnbJ+4V11BokFvu34GOzXLNtrVYmLIGBq5podXWyUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733249615; c=relaxed/simple;
	bh=FTGm79TK90ZJLru2BA8IrxuuzEfAi0FptzKj/r/cRYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IWbvyh+ya5XpyVLH9I9KGK3fceP7WWA/NacJaYkvLqTk6icjxyz2fykxKuHCmpem1guhrAXi+1zaqUlqiBtnkrOOhBVfidxoCi8PEYB1YYFJZsUkGybu5oB65rsmDRGpvGa4IAm+j7KytsFcT4flcd776tE8iGiHelnL4GcKVdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iRJ9+O9p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A1D9C4CECF;
	Tue,  3 Dec 2024 18:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733249615;
	bh=FTGm79TK90ZJLru2BA8IrxuuzEfAi0FptzKj/r/cRYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iRJ9+O9pYq50as2w82GiTD86JEdI7imMpJgsjC6cgJPfWWm1nLB2DyHHQTysaK0GW
	 bsD7LeMNpyJlWugMS7d7ldqcAC2Qc+ZuqXQeXqZ9WriEWz3e0yVMa3u5m1Rxd6iz7z
	 VwxDk8cUfPETdGvepjPEzeBVb7c11euhHngm7qboP7CxwFqsxJbjzVBJ8OitR+Lfbp
	 PmRgUZVlvgPVkUNnLMNAxhpa7oXW9FTHyLGhZNeBP8XgJQVSnrSSbTF0PgypeTM39g
	 9r93RKl9pDaZ9LmYBWzTk03oRASPkHduBZnxg/+5SHjd9TrhphNpmLBEK0WdpiplUz
	 Bcw/cVeArB4mg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: bin.lan.cn@eng.windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6] crypto: starfive - Do not free stack buffer
Date: Tue,  3 Dec 2024 13:13:33 -0500
Message-ID: <20241203073530-2e4fab4b9d39837f@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241203065213.67046-1-bin.lan.cn@eng.windriver.com>
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

The upstream commit SHA1 provided is correct: d7f01649f4eaf1878472d3d3f480ae1e50d98f6c

WARNING: Author mismatch between patch and upstream commit:
Backport author: bin.lan.cn@eng.windriver.com
Commit author: Jia Jie Ho <jiajie.ho@starfivetech.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  d7f01649f4eaf ! 1:  f914a30081e60 crypto: starfive - Do not free stack buffer
    @@ Metadata
      ## Commit message ##
         crypto: starfive - Do not free stack buffer
     
    +    [ Upstream commit d7f01649f4eaf1878472d3d3f480ae1e50d98f6c ]
    +
         RSA text data uses variable length buffer allocated in software stack.
         Calling kfree on it causes undefined behaviour in subsequent operations.
     
         Cc: <stable@vger.kernel.org> #6.7+
         Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
         Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
    +    Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
     
      ## drivers/crypto/starfive/jh7110-rsa.c ##
     @@ drivers/crypto/starfive/jh7110-rsa.c: static int starfive_rsa_enc_core(struct starfive_cryp_ctx *ctx, int enc)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Failed    |

Build Errors:
Build error for stable/linux-6.6.y:
    

