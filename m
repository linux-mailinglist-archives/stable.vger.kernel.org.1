Return-Path: <stable+bounces-121315-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC45A55644
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 20:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2138B1896D14
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 19:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31C526BDB5;
	Thu,  6 Mar 2025 19:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WcLUyzg5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A393025A652
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 19:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741288298; cv=none; b=HleWpwBfCECBxuDIoU/v2YwW/9ZyIAVgzsGIAfSMOdWcwHNIcOqRmXvX+7NeHqUnd/rtHyakFW8ZniEaGxFnW0v3cBkdqep1McHjdfy7+D1Taxv6Llgv5vAlt5UNiFm/xvyQPskqh7BNSEW3AT/ropbPKylE7Z9qSKB6GlCv7iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741288298; c=relaxed/simple;
	bh=PukJNYCYE8ztdEEe6ZSwuuXNo51sTYGgGKPhrn1aIUM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a1ToO/uyobi2pFrElh2t9odGustbi8UCqepCsO9UQMsrR1H3BVEAIO401euXWpb2Msxu7rIjddlBQN+usHpjJpsuh69HnhDhRLJzIeDOM7ePnrc/1oOanvRv1jeqw5tW6J1Qr+s8+DVwjE/4IkyQDWeRAqZpx9+ICXlttM547r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WcLUyzg5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C7F4C4CEE0;
	Thu,  6 Mar 2025 19:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741288298;
	bh=PukJNYCYE8ztdEEe6ZSwuuXNo51sTYGgGKPhrn1aIUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WcLUyzg5fy3dIQA9AlO4S6l2Zj1JsrPVM1vZwm96VkPlly893SrCwwwzwk1ZvhflT
	 5U5KrkvWuGy9hptXxL14jnbGn9YuSYoS39T2+K3XF1gN36p9yg9NsbRn+zb0FCz4r6
	 d3jBHKVb7ZQIRkzFEcu3nCkQxD7GG89rGAFk9Q588gyzWCssNQwBFo2IpazCz+4kIg
	 mU1448uLPAGULT2o4uMjiOYB6RCWBqoADg9eJV8oN9DUdiDjVcNCKw4PRjcXM7h93X
	 gNxEEyG7zRLox3rs4sBERH2pKt4MjUaJDrqwxsLSFZ5rdjdCbXMMDLupJuxquKscM7
	 8FRr1+JbNdqWA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	hagarhem@amazon.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15] sched: sch_cake: add bounds checks to host bulk flow fairness counts
Date: Thu,  6 Mar 2025 14:11:36 -0500
Message-Id: <20250305103017-c2d532a4a94399b7@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250305110334.31305-1-hagarhem@amazon.com>
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

Summary of potential issues:
ℹ️ Patch is missing in 6.13.y (ignore if backport was sent)
⚠️ Commit missing in all newer stable branches

The upstream commit SHA1 provided is correct: 737d4d91d35b5f7fa5bb442651472277318b0bfd

WARNING: Author mismatch between patch and upstream commit:
Backport author: Hagar Hemdan<hagarhem@amazon.com>
Commit author: Toke Høiland-Jørgensen<toke@redhat.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (different SHA1: 91bb18950b88)
6.6.y | Present (different SHA1: 27202e2e8721)
6.1.y | Present (different SHA1: a777e06dfc72)
5.4.y | Not found

Note: The patch differs from the upstream commit:
---
1:  737d4d91d35b5 ! 1:  a165fe282a0a4 sched: sch_cake: add bounds checks to host bulk flow fairness counts
    @@ Metadata
      ## Commit message ##
         sched: sch_cake: add bounds checks to host bulk flow fairness counts
     
    +    [ Upstream commit 737d4d91d35b5f7fa5bb442651472277318b0bfd ]
    +
         Even though we fixed a logic error in the commit cited below, syzbot
         still managed to trigger an underflow of the per-host bulk flow
         counters, leading to an out of bounds memory access.
    @@ Commit message
         Acked-by: Dave Taht <dave.taht@gmail.com>
         Link: https://patch.msgid.link/20250107120105.70685-1-toke@redhat.com
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    [Hagar: needed contextual fixes due to missing commit 7e3cf0843fe5]
    +    Signed-off-by: Hagar Hemdan <hagarhem@amazon.com>
     
      ## net/sched/sch_cake.c ##
     @@ net/sched/sch_cake.c: static bool cake_ddst(int flow_mode)
    @@ net/sched/sch_cake.c: static bool cake_ddst(int flow_mode)
     +		host_load = max(host_load,
     +				q->hosts[flow->dsthost].dsthost_bulk_flow_count);
     +
    -+	/* The get_random_u16() is a way to apply dithering to avoid
    ++	/* The shifted prandom_u32() is a way to apply dithering to avoid
     +	 * accumulating roundoff errors
     +	 */
     +	return (q->flow_quantum * quantum_div[host_load] +
    -+		get_random_u16()) >> 16;
    ++		(prandom_u32() >> 16)) >> 16;
     +}
     +
      static u32 cake_hash(struct cake_tin_data *q, const struct sk_buff *skb,
    @@ net/sched/sch_cake.c: static struct sk_buff *cake_dequeue(struct Qdisc *sch)
     -
     -		WARN_ON(host_load > CAKE_QUEUES);
     -
    --		/* The get_random_u16() is a way to apply dithering to avoid
    --		 * accumulating roundoff errors
    +-		/* The shifted prandom_u32() is a way to apply dithering to
    +-		 * avoid accumulating roundoff errors
     -		 */
     -		flow->deficit += (b->flow_quantum * quantum_div[host_load] +
    --				  get_random_u16()) >> 16;
    +-				  (prandom_u32() >> 16)) >> 16;
     +		flow->deficit += cake_get_flow_quantum(b, flow, q->flow_mode);
      		list_move_tail(&flow->flowchain, &b->old_flows);
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

