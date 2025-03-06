Return-Path: <stable+bounces-121313-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 828D6A55642
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 20:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A88833A950A
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 19:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB44326BDB5;
	Thu,  6 Mar 2025 19:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBfRwR7t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A95025A652
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 19:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741288294; cv=none; b=oDmNbBYlIBUsHIFeMUVAwVlS6qzT6DDhy+7YULXw7inkJ7Xlx5QRPdVhfMBDXhEHjy3bXVwGu0LZJUxvnf0HWdiarbee8t21EbwUN3Xv54W01fROmlkaW/lWG0exVZr1kdvK9ZAls4O54cq79MnGb8Z/IKwwsftILx3PbZc6et8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741288294; c=relaxed/simple;
	bh=Ua8g/yXnhLraHf9OgAtppITVYLq/f0DRtCmOOLez9a8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q/ZIUI1KYHZqPzVNpNw14xAeoWwRQnsNENTzXKDd9c48lWOge32sTHuIquyKagCBcLPKjZCHBbpgejeADevUpmIsMusXcJ3LOUZCGMiqE4BjRD3Bf0T6as24jvOqx5e3Ht7TpNSHL/3gmnPTaeGt+wb8PbMCc07RBkEtz09C/8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBfRwR7t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E835C4CEE8;
	Thu,  6 Mar 2025 19:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741288294;
	bh=Ua8g/yXnhLraHf9OgAtppITVYLq/f0DRtCmOOLez9a8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RBfRwR7tZ+WYKxABseayj74TIGb6KLsV6qiHrDTAD8JSGO7u5uKD+kK4L91NdybO2
	 Hd7+e2l1mp0j+2CJifkd5REVhXGLENUV5MgCWzdworJPJIRWgcfhqSTNswfW0rgF2g
	 1uQe/Ckti0mTi3YE7EUNNbw6QKcauYGDFAuoELQe34VS0/w0BcLbltr5VKMNnzyY6q
	 pNv/gsbeRUfYu/d2+5B9Hl3JBb9kz/wfj/0vYtsYXXgxEGFC1Metye3gVWvNFpg+52
	 6Guxilheh+TrNY367JDU9ZS4zpi+3C7rzLAMCiSUT7sIlopaTxqcofQV5kh+zTKFpl
	 DdGTRYWLRjjpg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	hagarhem@amazon.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10] sched: sch_cake: add bounds checks to host bulk flow fairness counts
Date: Thu,  6 Mar 2025 14:11:32 -0500
Message-Id: <20250305102355-6e1f1abc555c66f1@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250305110334.31305-2-hagarhem@amazon.com>
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
5.15.y | Not found
5.4.y | Not found

Note: The patch differs from the upstream commit:
---
1:  737d4d91d35b5 ! 1:  9441dfbd9761e sched: sch_cake: add bounds checks to host bulk flow fairness counts
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
| stable/linux-5.10.y       |  Success    |  Success   |

