Return-Path: <stable+bounces-144047-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABFFAB46BD
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 23:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C00217E2E3
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 21:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9593266B5C;
	Mon, 12 May 2025 21:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQ0nkbtE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7990B22338
	for <stable@vger.kernel.org>; Mon, 12 May 2025 21:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747086723; cv=none; b=fPNv3TJ7iAttO7DyBuer++SndunyPWZ8CuxKdQr8z03w5V4rrtURevDXeh9Kr0tBIXdYrWoHvBCbpNnwPX+Et5U4tET2cmXlEW0Neat4vXOe82xyOn6kepiR0b/9c99pWMPNCIL4QY9Pk1q2y/fOnG+rJUcuEzx2bgqaKwFHteg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747086723; c=relaxed/simple;
	bh=7HzJFDT9zQDjwZfNpL4m8arqZgDQRdb+RuSv3bFbrNA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L9/HcCQwLZ4KRzE1QiXsIB4S8MMRS7FEwve4ZZyPBQuBG4GS4TjRyEb8RF0j68oYBhSQW+O5k8+/D1EDnjzLsZT3mVLtsbdqtRWixQWofQ6EY7SYHqVSn++xvYaQLp9aPk1iSW71ZGtTCZjCj/a3MVuRzKdVTakJiJo/Ehhcqr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQ0nkbtE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F67BC4CEE7;
	Mon, 12 May 2025 21:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747086723;
	bh=7HzJFDT9zQDjwZfNpL4m8arqZgDQRdb+RuSv3bFbrNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EQ0nkbtEuWfFbQtT7f+sFIJbHKEG7AS0aYrw5f+lrNw/PRNa1xrJUMQ7NtRWw+JeU
	 jcceacw9Q8tG6GVg21wQsw/8Os794vsdgZNlFBRbyC9gyD1aN8TvRqUa3IzIxfcrM5
	 Mx8R3ZZOAcsUm/BbI9ugdX+3ashoQ439W0nDkvaBoPZSOAtIIUWtfU+Fr7MTq+xYVI
	 xG1LVJ75TBPCC6nrI8b+wMPdc0TKdwsmNTE4R2W78JB5/dj1UC42jjeQ87Oxq91jYv
	 qUOaaiU05VEeE/JS5JbsqBYfCmeCYUrN3tCZ7QmwAi4cbG2PuonwZl9psO/981vJfC
	 5OXNWootpyHDA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] net/sched: act_mirred: use the backlog for mirred ingress
Date: Mon, 12 May 2025 17:51:57 -0400
Message-Id: <20250512162759-87a9e4204e8a9132@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250512021355.3327681-1-jianqi.ren.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 52f671db18823089a02f07efc04efdb2272ddc17

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Jakub Kicinski<kuba@kernel.org>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 7c787888d164)

Note: The patch differs from the upstream commit:
---
1:  52f671db18823 ! 1:  97f4f1be939a2 net/sched: act_mirred: use the backlog for mirred ingress
    @@ Metadata
      ## Commit message ##
         net/sched: act_mirred: use the backlog for mirred ingress
     
    +    [ Upstream commit 52f671db18823089a02f07efc04efdb2272ddc17 ]
    +
         The test Davide added in commit ca22da2fbd69 ("act_mirred: use the backlog
         for nested calls to mirred ingress") hangs our testing VMs every 10 or so
         runs, with the familiar tcp_v4_rcv -> tcp_v4_rcv deadlock reported by
    @@ Commit message
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
         Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
         Signed-off-by: David S. Miller <davem@davemloft.net>
    +    [Minor conflict resolved due to code context change.]
    +    Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
      ## net/sched/act_mirred.c ##
     @@ net/sched/act_mirred.c: static int tcf_mirred_init(struct net *net, struct nlattr *nla,
    @@ net/sched/act_mirred.c: static int tcf_mirred_init(struct net *net, struct nlatt
      		err = netif_rx(skb);
      	else
      		err = netif_receive_skb(skb);
    -@@ net/sched/act_mirred.c: static int tcf_mirred_to_dev(struct sk_buff *skb, struct tcf_mirred *m,
    - 
    - 		skb_set_redirected(skb_to_send, skb_to_send->tc_at_ingress);
    +@@ net/sched/act_mirred.c: static int tcf_mirred_act(struct sk_buff *skb, const struct tc_action *a,
      
    --		err = tcf_mirred_forward(want_ingress, skb_to_send);
    -+		err = tcf_mirred_forward(at_ingress, want_ingress, skb_to_send);
    - 	} else {
    --		err = tcf_mirred_forward(want_ingress, skb_to_send);
    -+		err = tcf_mirred_forward(at_ingress, want_ingress, skb_to_send);
    + 		/* let's the caller reinsert the packet, if possible */
    + 		if (use_reinsert) {
    +-			err = tcf_mirred_forward(want_ingress, skb);
    ++			err = tcf_mirred_forward(at_ingress, want_ingress, skb);
    + 			if (err)
    + 				tcf_action_inc_overlimit_qstats(&m->common);
    + 			__this_cpu_dec(mirred_nest_level);
    +@@ net/sched/act_mirred.c: static int tcf_mirred_act(struct sk_buff *skb, const struct tc_action *a,
    + 		}
      	}
      
    - 	if (err) {
    +-	err = tcf_mirred_forward(want_ingress, skb2);
    ++	err = tcf_mirred_forward(at_ingress, want_ingress, skb2);
    + 	if (err)
    + 		tcf_action_inc_overlimit_qstats(&m->common);
    + 	__this_cpu_dec(mirred_nest_level);
     
      ## tools/testing/selftests/net/forwarding/tc_actions.sh ##
     @@ tools/testing/selftests/net/forwarding/tc_actions.sh: mirred_egress_to_ingress_tcp_test()
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

