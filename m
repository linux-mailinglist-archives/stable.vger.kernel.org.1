Return-Path: <stable+bounces-164812-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10360B12854
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 03:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF7DD3BECE8
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 01:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382CE3595B;
	Sat, 26 Jul 2025 01:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sdrlq/yB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE75F2E36E6
	for <stable@vger.kernel.org>; Sat, 26 Jul 2025 01:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753491692; cv=none; b=O9K1I3HcFvll42mdG9UzE7Wj3G6H/8KLCCvnCIX3QD1Ob7PxfciERgR0Wc4Zuz5UeO8VrTvMLAHnTBxaZT6Kh/DlVY6OLy+VRnyIMDh2aA2YG2kI/fcTSMfkpiGQ8+0SjULHjqJRkFm5ACExSqTyw121GoP6QKQ9xByd5j19eDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753491692; c=relaxed/simple;
	bh=6MlQLca2Ts0dRkumcbkx1Vrwa/pXM3FhoLhjYp0F4Rw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JRnHttnLfwKgmq6MvrP6YZo5Feo8bKOoRfkEQCfWq1EYiJu4Bo18VqaHBS30EoeEGIbL2QQNJkVarPUDFioQHGfEhgalc64IZaNXpncKsp4wp4K2JtGEB1LrSVFrt9lTohoPFSO2VvNvLsIy+XYWBg7UdMf6pM+qct6IO7s90d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sdrlq/yB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42CB0C4CEE7;
	Sat, 26 Jul 2025 01:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753491691;
	bh=6MlQLca2Ts0dRkumcbkx1Vrwa/pXM3FhoLhjYp0F4Rw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sdrlq/yBtuD0H0qeENAgmZLf5Nh63OAQEMmJqkCU5dD6vIho6v5PYAPem/PEjgBRU
	 Ex66ARVTENqAWOBZ6v76wcgSG/PysEpDTpC7XMO87EDorP+c7JU0FEBifVPDG2ww9K
	 3eIdgdbmHtw2egJIA97Gc9MSfGX90/HT6Rxa1SIuShKU10l/AwF9L974fI6dgCAVUX
	 pj+pKAlul1JzJpWbTJP//qKW4TRhuJT0Jrlh5M8X1uZL0FuTKh3WyBM/KA9QcIJZ52
	 DoNSDCOh0vXiumQ1d/HJHNhvuMvfzpaVhYDMW7s1pkGoWGVXi3BdUaSkm6C4Rby+yp
	 vbd41oBR2vGgw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y 4/8] net: sched: don't expose action qstats to skb_tc_reinsert()
Date: Fri, 25 Jul 2025 21:01:29 -0400
Message-Id: <1753463810-386603e6@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250724192619.217203-5-skulkarni@mvista.com>
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

The upstream commit SHA1 provided is correct: ef816f3c49c1c404ababc50e10d4cbe5109da678

WARNING: Author mismatch between patch and upstream commit:
Backport author: <skulkarni@mvista.com>
Commit author: Vlad Buslov <vladbu@mellanox.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Present (exact SHA1)
5.10.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  ef816f3c49c1 ! 1:  6b25ed64fd0d net: sched: don't expose action qstats to skb_tc_reinsert()
    @@ Metadata
      ## Commit message ##
         net: sched: don't expose action qstats to skb_tc_reinsert()
     
    +    [ Upstream commit ef816f3c49c1c404ababc50e10d4cbe5109da678 ]
    +
         Previous commit introduced helper function for updating qstats and
         refactored set of actions to use the helpers, instead of modifying qstats
         directly. However, one of the affected action exposes its qstats to
    @@ Commit message
         Signed-off-by: Vlad Buslov <vladbu@mellanox.com>
         Acked-by: Jiri Pirko <jiri@mellanox.com>
         Signed-off-by: David S. Miller <davem@davemloft.net>
    +    [ skulkarni: Adjusted patch for file 'sch_generic.h' wrt the mainline commit ]
    +    Stable-dep-of: ca22da2fbd69 ("act_mirred: use the backlog for nested calls to mirred ingress")
    +    Signed-off-by: Shubham Kulkarni <skulkarni@mvista.com>
     
      ## include/net/sch_generic.h ##
     @@ include/net/sch_generic.h: void mini_qdisc_pair_swap(struct mini_Qdisc_pair *miniqp,
    @@ include/net/sch_generic.h: void mini_qdisc_pair_swap(struct mini_Qdisc_pair *min
     +	return res->ingress ? netif_receive_skb(skb) : dev_queue_xmit(skb);
      }
      
    - #endif
    + /* Make sure qdisc is no longer in SCHED state. */
     
      ## net/sched/act_mirred.c ##
     @@ net/sched/act_mirred.c: static int tcf_mirred_act(struct sk_buff *skb, const struct tc_action *a,

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 5.4                       | Success     | Success    |

