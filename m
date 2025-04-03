Return-Path: <stable+bounces-127696-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D45CA7A722
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 17:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A595B3B30E3
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 15:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D393250BE5;
	Thu,  3 Apr 2025 15:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="auWeL/tJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFABF24EF7E
	for <stable@vger.kernel.org>; Thu,  3 Apr 2025 15:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743694776; cv=none; b=YIlFBjgnKED723Tth9gfmjqXz/tMPtHbxhCUAIhRFTHVErUcjBlpeEVWbRkLyQ5zUWeCzG91BvDyO62JZonvuxUExLdn0/KVDEki0fRMVt/nGu4Nph5BKB7wFPlLrdSeP4lConvRGZvMKyTmR0DfFTR1HFdi0uaZBaVcme8/1i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743694776; c=relaxed/simple;
	bh=w3UtyGt2s7Vju24XNVZWhlQueOXsURcKZ8hEnONEtqU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JsG9C54aDHp6cgX2ujEa8WZbsMeUi0JQ0psyGWGeA92dCkmF4hBLA8l7AcJM6xetlmFV6RthfsQ8JPcV35lTbDRWlOAb6UWW+oRvgJc/FRmiOdzy9qgNoUSnPJ7h3tA3iv1gjlKHiP6kf4kxREBpQe5IQzoFE42HFbg8w3L2Dkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=auWeL/tJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F28ABC4CEE3;
	Thu,  3 Apr 2025 15:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743694775;
	bh=w3UtyGt2s7Vju24XNVZWhlQueOXsURcKZ8hEnONEtqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=auWeL/tJccAToX0Ktk7MPEY0ek+TMpVYJa8AakLDbUjd4qOMTkW/gmJGc7bcrFEOJ
	 lbAodNWCeAtEYJ/P7WUnrafFbT0ykSK4noD5Q09kCgeTnca//qE1G1nqAwqO2PkBLq
	 sldEiUomhPYxQY2soLtclSC/GkfcGdNekQ388l228DydEZXJWB6FOy8huweJW1Xn2x
	 s+6m8Nzj8OO0Fo565fq/6DIcBaw+z5rgJiSA73rqDyBW4KnSuRGP4IH4m585hEQjAs
	 +C/KMSRUztTYqTBwZF+UyXX0uFRxtBwoYcCuqNDFnm4izLbqg7jvR/ku3fZDItOdX0
	 1kaPfdIBavFxw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiangyu Chen <xiangyu.chen@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y 1/2] net: make sock_inuse_add() available
Date: Thu,  3 Apr 2025 11:39:31 -0400
Message-Id: <20250403113141-894936cb38c5c675@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250403064736.3716535-2-xiangyu.chen@eng.windriver.com>
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

The upstream commit SHA1 provided is correct: d477eb9004845cb2dc92ad5eed79a437738a868a

WARNING: Author mismatch between patch and upstream commit:
Backport author: Xiangyu Chen<xiangyu.chen@eng.windriver.com>
Commit author: Eric Dumazet<edumazet@google.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  d477eb9004845 ! 1:  1bd213f58a064 net: make sock_inuse_add() available
    @@ Metadata
      ## Commit message ##
         net: make sock_inuse_add() available
     
    +    commit d477eb9004845cb2dc92ad5eed79a437738a868a upstream.
    +
         MPTCP hard codes it, let us instead provide this helper.
     
         Signed-off-by: Eric Dumazet <edumazet@google.com>
         Signed-off-by: David S. Miller <davem@davemloft.net>
    +    Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
    +    [ cherry-pick from amazon-linux amazon-5.15.y/mainline ]
    +    Link: https://github.com/amazonlinux/linux/commit/7154d8eaac16
    +    Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
      ## include/net/sock.h ##
     @@ include/net/sock.h: static inline void sock_prot_inuse_add(const struct net *net,
      {
    - 	__this_cpu_add(net->core.prot_inuse->val[prot->inuse_idx], val);
    + 	this_cpu_add(net->core.prot_inuse->val[prot->inuse_idx], val);
      }
     +
     +static inline void sock_inuse_add(const struct net *net, int val)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

