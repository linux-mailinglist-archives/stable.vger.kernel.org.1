Return-Path: <stable+bounces-126563-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC44A7021B
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 14:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA70F3B1638
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 13:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A65D25A632;
	Tue, 25 Mar 2025 13:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKRHbPfY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2693B25A627
	for <stable@vger.kernel.org>; Tue, 25 Mar 2025 13:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742907764; cv=none; b=VFG8pdKXtHMgPhK3C7WchTVel62I5gCkl1JMMdM3kvB7EvfYuNA4VPo+Oj9aDom5t5x10TJVeaZApfpuoG27Uz5wviV5yXVOeGsZkqRN/VQYpN5wOYOQAyIm6nRQUANe5LUt5NFDkKnC+Ku4pBMjp1Mr64uOH9bSKYBJA/4FlTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742907764; c=relaxed/simple;
	bh=QRw2WY/ky+7Jq3OHo49BTXSd+eaPtajgoFfGb22uE7I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WBaX8o2ylt5tpHdM9uh0E3mlOr/89Z2Pnv4Ajfu9T7ec0fxw3rAg4CR81KG/G2JpJfMNFQCbz4rSMBoaLkzf0OAUZoi8UnsLtRn/zWJrsv7TX/t1TAqFGaZOI/nPBYbDVmHaV0zEF7XNesQqJI4iHrkaEN2yqQwct5yd9Ag1EUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKRHbPfY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31713C4CEE4;
	Tue, 25 Mar 2025 13:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742907763;
	bh=QRw2WY/ky+7Jq3OHo49BTXSd+eaPtajgoFfGb22uE7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AKRHbPfYJDVNW72TaVeORN9Qh/hjsVBF/ZPTuSzyxQEaoZ75oWzQUSlBBDZCqCHqZ
	 qJCCoyMwPl+lybNlwbQDf+y/rEZkU/VruRW5xR5diQbACESPJde/N1Zam/jVOwxdOY
	 vGeU3cYNkn6buup4/ArNkAdGg0z0l81Ti0OiTzAsaYyEiRC2G0fEqVolWXLlWn3deP
	 9/xlrQ+xVnwRUaLVDko8IPbk7Z6gkSGm1Kuz9KbHa4U2oUvVkFN97IA5V9PgNicAFy
	 PCX74s0XTD2st4RS+SJvRd9vA+HqzSnKaKPCgsTjm7WbdfD3JqrFcdi9kigA3enk4w
	 hr+YrbLFglpCw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: bin.lan.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] bpf, sockmap: Fix race between element replace and close()
Date: Tue, 25 Mar 2025 09:02:41 -0400
Message-Id: <20250325080137-8cae29482cfd40aa@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250325080929.2209140-1-bin.lan.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: ed1fc5d76b81a4d681211333c026202cad4d5649

WARNING: Author mismatch between patch and upstream commit:
Backport author: bin.lan.cn@windriver.com
Commit author: Michal Luczaj<mhal@rbox.co>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (different SHA1: bf2318e288f6)
6.6.y | Present (different SHA1: b015f19fedd2)
6.1.y | Present (different SHA1: b79a0d1e9a37)

Note: The patch differs from the upstream commit:
---
1:  ed1fc5d76b81a ! 1:  73ba52105b298 bpf, sockmap: Fix race between element replace and close()
    @@ Metadata
      ## Commit message ##
         bpf, sockmap: Fix race between element replace and close()
     
    +    [ Upstream commit ed1fc5d76b81a4d681211333c026202cad4d5649 ]
    +
         Element replace (with a socket different from the one stored) may race
         with socket's close() link popping & unlinking. __sock_map_delete()
         unconditionally unrefs the (wrong) element:
    @@ Commit message
         Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
         Reviewed-by: John Fastabend <john.fastabend@gmail.com>
         Link: https://lore.kernel.org/bpf/20241202-sockmap-replace-v1-3-1e88579e7bd5@rbox.co
    +    Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
      ## net/core/sock_map.c ##
     @@ net/core/sock_map.c: static void *sock_map_lookup_sys(struct bpf_map *map, void *key)
    @@ net/core/sock_map.c: static void *sock_map_lookup_sys(struct bpf_map *map, void
     +	struct sock *sk = NULL;
      	int err = 0;
      
    - 	spin_lock_bh(&stab->lock);
    + 	if (irqs_disabled())
    + 		return -EOPNOTSUPP; /* locks here are hardirq-unsafe */
    + 
    + 	raw_spin_lock_bh(&stab->lock);
     -	sk = *psk;
     -	if (!sk_test || sk_test == sk)
     +	if (!sk_test || sk_test == *psk)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

