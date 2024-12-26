Return-Path: <stable+bounces-106116-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0071A9FC75C
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 02:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 105837A130A
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 01:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5AEC8F0;
	Thu, 26 Dec 2024 01:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="emtrKK4i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877CA8F49
	for <stable@vger.kernel.org>; Thu, 26 Dec 2024 01:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735176114; cv=none; b=ei76NaYUBpN2VTq8ahXSAeWtu+13FKplxxkwT9bZlpdouQCoW2qZa+DgQ/H3vThUvJIqYLCW7YGidyVJh1aMqdH+9byBqdeViQT9UNBONBVN+w+2TO4S10eNYSsBHNDYzJPTT0cRL9JxEAXeXI+WlOlHC4f0vLa4fqPvDhmsxFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735176114; c=relaxed/simple;
	bh=WuFneQOlr34hEuz98tjbO0YvWmFd1ByTdsyaKOROSvM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mc+DVSM3DR0E7zDjgtGKcS6qLrH663OvHCzCvDixt64rIj0BiG/lS5DSUcrNzKsMLyU9vqUEZnhVisV2t+h/NPjmkgcYQ6IGvzt1S8X6PmMoBnFJhSruodB7kyFDSqujPXlfXRQoLv2z2ox7T3G5/1trJtXSKdF1kRyKlfqjL0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=emtrKK4i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0015C4CECD;
	Thu, 26 Dec 2024 01:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735176114;
	bh=WuFneQOlr34hEuz98tjbO0YvWmFd1ByTdsyaKOROSvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=emtrKK4i/8niSGVlTwTL0+QIjKBTyywaW6Paf9zITvpUrzdGECwAnqmEZbHQPnMR+
	 M9PrfJLpuGebNQ/VWIphXRc1bSZquHXuXH7QtTeBVd7otcfDr9ntwnqBgcM9G8z9q/
	 9F5wkom3t+oHofZsQXfNuN36377mWVNbM8Fq0/PGFMp4MUDpXmo5n7vfPrYkaHzpGw
	 R8pT8li3unU39mgXoOPZTgqXEnqMG5pERdmJDeJJkaZsD34Iw3ZaEVBDFGF2xS0auT
	 2IUps0VU9tE/ACSAhBx6cs9bEvn+0XZtXw3NvsoHHq/tab1yO4HAPrJDYXJBe8EGrg
	 c+CwDlRdkL+yg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y 5.10.y 1/4] skbuff: introduce skb_expand_head()
Date: Wed, 25 Dec 2024 20:21:52 -0500
Message-Id: <20241225192848-210522801797f885@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20241225051624.127745-2-harshvardhan.j.jha@oracle.com>
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

The upstream commit SHA1 provided is correct: f1260ff15a71b8fc122b2c9abd8a7abffb6e0168

WARNING: Author mismatch between patch and upstream commit:
Backport author: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
Commit author: Vasily Averin <vvs@virtuozzo.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Present (exact SHA1)
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  f1260ff15a71 ! 1:  ee7ccf9396c7 skbuff: introduce skb_expand_head()
    @@ Metadata
      ## Commit message ##
         skbuff: introduce skb_expand_head()
     
    +    [ Upstream commit f1260ff15a71b8fc122b2c9abd8a7abffb6e0168 ]
    +
         Like skb_realloc_headroom(), new helper increases headroom of specified skb.
         Unlike skb_realloc_headroom(), it does not allocate a new skb if possible;
         copies skb->sk on new skb when as needed and frees original skb in case
    @@ Commit message
     
         Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
         Signed-off-by: David S. Miller <davem@davemloft.net>
    +    (cherry picked from commit f1260ff15a71b8fc122b2c9abd8a7abffb6e0168)
    +    Signed-off-by: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
     
      ## include/linux/skbuff.h ##
     @@ include/linux/skbuff.h: static inline struct sk_buff *__pskb_copy(struct sk_buff *skb, int headroom,
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |
| stable/linux-5.4.y        |  Success    |  Success   |

