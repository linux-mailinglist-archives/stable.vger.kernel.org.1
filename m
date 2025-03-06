Return-Path: <stable+bounces-121316-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AE1A55645
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 20:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80C5B1750B2
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 19:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9A526D5C3;
	Thu,  6 Mar 2025 19:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQNlv49F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBE325A652
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 19:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741288300; cv=none; b=B7hln/EGcc8Y/BA9n7mi7Mw+Ir2W3XPgS0LobM6ekonfSXZZ4hYhtHbHxfqdm/e76+sylREKPALjrEi6BF/dGf5+xh2OPg6kpqQJUECYYedg+tvbg2hPpF11pIqZ4M28R088WwVZIETY8zJBbXopEJYUtIr3+Q+zWBRG4kVWHaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741288300; c=relaxed/simple;
	bh=Ml1MgMq7+unolRwsEOWdnZaJ6r4YBEwXbp64wQhg7Ac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EPnIyAPivu/U0KeISpYaEhgWR5mZo+d3+FpMvA4HsUXvgjO+Syr0BUD2sIhNvLuEfl4NlbvI/kKsRjSCYzkFeQ9UIzr2sn23C0S0B8eIQt2cZwhPcAwBYtJIZzljE2AVexPxsmCG2QGngdig6uyfferqH+p9xr5qfGXjrDuRnAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQNlv49F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12DFAC4CEE0;
	Thu,  6 Mar 2025 19:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741288300;
	bh=Ml1MgMq7+unolRwsEOWdnZaJ6r4YBEwXbp64wQhg7Ac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AQNlv49F6xcMaPJitkHcJhSoHikFLamuqpidebfzlSREnoYdNzZXnSOgh1jncDsFN
	 JmgkfrI0KOeaHw7lefqbUyby7P/Dfo0SyxxZZmxkmQRgN2h4NF/bUiUKMLBzg2boC6
	 C4YFugfPcHBiCEn9OfFuHdThfqBex77rjoc5pjd17ZJmsa43hvoZo38gcyndpJbOv1
	 BvoZ1f/F5Y5ICLbTme3uq2kW2UdSgSZTM0WOZH33erzIT950Lm1eSADSeoG0iryFPs
	 Yqlgx+SNqabHLy3TLFQzXSR1uR0Y/fbj4R8wIIMJpZzjZJMP0oaGF7jFVTDOknYO60
	 FPcxo8uztEqyg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hagar Hemdan <hagarhem@amazon.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4] sched: sch_cake: add bounds checks to host bulk flow fairness counts
Date: Thu,  6 Mar 2025 14:11:38 -0500
Message-Id: <20250305104345-87a504d21c58b435@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250305110334.31305-3-hagarhem@amazon.com>
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

The upstream commit SHA1 provided is correct: 737d4d91d35b5f7fa5bb442651472277318b0bfd

WARNING: Author mismatch between patch and upstream commit:
Backport author: Hagar Hemdan<hagarhem@amazon.com>
Commit author: Toke Høiland-Jørgensen<toke@redhat.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (different SHA1: 91bb18950b88)
6.6.y | Present (different SHA1: 27202e2e8721)
6.1.y | Present (different SHA1: a777e06dfc72)

Note: The patch differs from the upstream commit:
---
1:  737d4d91d35b5 ! 1:  d4fd1676a9039 sched: sch_cake: add bounds checks to host bulk flow fairness counts
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
| stable/linux-5.4.y        |  Success    |  Success   |

