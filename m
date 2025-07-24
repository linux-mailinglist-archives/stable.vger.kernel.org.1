Return-Path: <stable+bounces-164687-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F1DB111AA
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 21:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1558F7B81B1
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 19:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFA22D8795;
	Thu, 24 Jul 2025 19:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b="CV0uQuje"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539272ED151
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 19:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753385216; cv=none; b=L/+s6nmmw54psVqmXiG9vZnD85TG9DmYArWGRlshDpBGQ4zybuVf6CElQx6LfBhWYXl+tm4rtqdi3A65F3FlZVAnoTs42z6ECqoPlChSImgF1K9937GcHE8yBz+IaYhTF27VErda1x9BR7ofUXjjZtSs7m79Tks0Rn4wD0ZOYjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753385216; c=relaxed/simple;
	bh=24aAK0AoPP2HGX4uYW9yfOuI4y3/KMnN/Bg0Tmd55UM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fXhnNNX133XudSgR6WHSyn/30mVmFLFCtWDPrOecqvJAH0Mc5OxHIKZ7hh9Z9RL97glJ2IdYeJ91Hmaco9zIUESpBjUXQlj4n6EOWvR6RDGWS0m7JTXAKOgz2w8IJShZ5lwmMFSfZF1Nlh3zr20FmXHSWiXrpeOCxLQ3wzaxVLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com; spf=pass smtp.mailfrom=mvista.com; dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b=CV0uQuje; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mvista.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-313067339e9so36302a91.2
        for <stable@vger.kernel.org>; Thu, 24 Jul 2025 12:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1753385213; x=1753990013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=89KOqz74AZgN6Y8TQ301pg3IN+uL/uGs5abOkIngeWY=;
        b=CV0uQujeCZL7gW/lZsa57YcSmyeHNr3CMH+9fC59GdGaU8BWtJjM2xs7y5FhjOHtJo
         rzgQFf8RvjC8MMgEuP3okGQj5NdvMN8T0p5dfLvYGGH1neMg9uGrpz3iFbCNxUdTmFVt
         IObkdCBeI7myahc4YSFC5P9lMUNw+cw7sbRUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753385213; x=1753990013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=89KOqz74AZgN6Y8TQ301pg3IN+uL/uGs5abOkIngeWY=;
        b=PKNuzIjKXsf8ZkPgW9isG2fAX7L7v5eVi3Y68PwZoGGY2tx1m80Fs2wzWahVHaIf3o
         VhaObwSx300KHY6CRMvkGOXI5lp1cm7iRxrZW0uGOR3b6h3tES+HdpMzp6LvyXTbdFMV
         bR6OeRkEvlPob6MYNVgaBsLrsKxaqar5sJtzIu/p369uQHAVAqIaEknsu7Sw38tEXrmp
         Yr+CyXq3lBkJt/FhWnagpZIYLTHpU91kptSt8dEGB8+Te31WSZcQlhDdzsfNzQyz+nI+
         jdIOks0+CjayBaYlySgxTTohrbEpTs1B0rjjm3lLaDeE8info34oFiA/ssFzdgjKD2RI
         zvWg==
X-Gm-Message-State: AOJu0YxLlhBom416FTdsjyOCqtEZmRBLBTezTMoLVzbqdlkZnmZ9RAca
	T2oEmQxHO0adwsBUDrg5DTtyER6yjeAiUmM2T+G763guz7OMlbZGu+OmQQreFlGOeqSChXJL49L
	vjJMoEs8=
X-Gm-Gg: ASbGncsOOzTUXhYZVqo0EzyWbcZkg3RgJPK89xLxgyN6MAGAtYVbuj9KTK3Krt/cIJT
	jzji2YClFrRG0YhLKlpTeMJVDZ0yBSJ6G7EMEl3EbQIfkhcAWWIMcKFsMqE8LuvOq8YFgORmSx1
	j0MRgmUmeNxHzBBeVG0cZC1HrNIUqVVGZOgb03RRKQ/fJQ6Rdbo3iKecLtfp08qUlgLDTd3PyMZ
	hBOQTkk6p9ykkuZevt0fB4y+NZ8tdgW406gwx8Z1ecFEqa9A31bgyP9TwwEJQfLbkf77ndpgUh8
	c21c9eQ/LAXPDtfpoQSd0wlAQuq6DtptjWHZf+US1kRLhRmEi7MUxOf69xTZ0mdtOG00XoJgywe
	pYrVOpYSRpAHITtpZrvK9A8SMGvx0Bh8pE0/J5XUKVM0/
X-Google-Smtp-Source: AGHT+IHjFUsbmb5qpjwXP5htj/MMlf21uEhaj8Z8gFm8BXpweLywxzRkRRU6Zb8TSOkR1TNg2qyYQg==
X-Received: by 2002:a17:90b:4b52:b0:311:c5d9:2c8b with SMTP id 98e67ed59e1d1-31e5082c398mr5430489a91.5.1753385213217;
        Thu, 24 Jul 2025 12:26:53 -0700 (PDT)
Received: from shubhamPC.mvista.com ([182.74.28.237])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e6635f0a0sm1945884a91.24.2025.07.24.12.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 12:26:52 -0700 (PDT)
From: skulkarni@mvista.com
To: stable@vger.kernel.org
Cc: akuster@mvista.com,
	cminyard@mvista.com,
	Vlad Buslov <vladbu@mellanox.com>,
	Jiri Pirko <jiri@mellanox.com>,
	"David S . Miller" <davem@davemloft.net>,
	Shubham Kulkarni <skulkarni@mvista.com>
Subject: [PATCH 5.4.y 2/8] net: sched: extract bstats update code into function
Date: Fri, 25 Jul 2025 00:56:13 +0530
Message-Id: <20250724192619.217203-3-skulkarni@mvista.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250724192619.217203-1-skulkarni@mvista.com>
References: <20250724192619.217203-1-skulkarni@mvista.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vlad Buslov <vladbu@mellanox.com>

[ Upstream commit 5e1ad95b630e652d3467d1fd1f0b5e5ea2c441e2 ]

Extract common code that increments cpu_bstats counter into standalone act
API function. Change hardware offloaded actions that use percpu counter
allocation to use the new function instead of incrementing cpu_bstats
directly.

This commit doesn't change functionality.

Signed-off-by: Vlad Buslov <vladbu@mellanox.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: ca22da2fbd69 ("act_mirred: use the backlog for nested calls to mirred ingress")
Signed-off-by: Shubham Kulkarni <skulkarni@mvista.com>
---
 include/net/act_api.h      | 7 +++++++
 net/sched/act_csum.c       | 2 +-
 net/sched/act_ct.c         | 2 +-
 net/sched/act_gact.c       | 2 +-
 net/sched/act_mirred.c     | 2 +-
 net/sched/act_tunnel_key.c | 2 +-
 net/sched/act_vlan.c       | 2 +-
 7 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index 39374348510c..46009acb198b 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -186,6 +186,13 @@ int tcf_action_dump(struct sk_buff *skb, struct tc_action *actions[], int bind,
 		    int ref);
 int tcf_action_dump_old(struct sk_buff *skb, struct tc_action *a, int, int);
 int tcf_action_dump_1(struct sk_buff *skb, struct tc_action *a, int, int);
+
+static inline void tcf_action_update_bstats(struct tc_action *a,
+					    struct sk_buff *skb)
+{
+	bstats_cpu_update(this_cpu_ptr(a->cpu_bstats), skb);
+}
+
 void tcf_action_update_stats(struct tc_action *a, u64 bytes, u32 packets,
 			     bool drop, bool hw);
 int tcf_action_copy_stats(struct sk_buff *, struct tc_action *, int);
diff --git a/net/sched/act_csum.c b/net/sched/act_csum.c
index fa1b1fd10c44..e502e256ad67 100644
--- a/net/sched/act_csum.c
+++ b/net/sched/act_csum.c
@@ -577,7 +577,7 @@ static int tcf_csum_act(struct sk_buff *skb, const struct tc_action *a,
 	params = rcu_dereference_bh(p->params);
 
 	tcf_lastuse_update(&p->tcf_tm);
-	bstats_cpu_update(this_cpu_ptr(p->common.cpu_bstats), skb);
+	tcf_action_update_bstats(&p->common, skb);
 
 	action = READ_ONCE(p->tcf_action);
 	if (unlikely(action == TC_ACT_SHOT))
diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index d72c9888fad2..0727a2516736 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -482,7 +482,7 @@ static int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
 	skb_push_rcsum(skb, nh_ofs);
 
 out:
-	bstats_cpu_update(this_cpu_ptr(a->cpu_bstats), skb);
+	tcf_action_update_bstats(&c->common, skb);
 	return retval;
 
 drop:
diff --git a/net/sched/act_gact.c b/net/sched/act_gact.c
index d58a6c75349f..ff78de432871 100644
--- a/net/sched/act_gact.c
+++ b/net/sched/act_gact.c
@@ -159,7 +159,7 @@ static int tcf_gact_act(struct sk_buff *skb, const struct tc_action *a,
 		action = gact_rand[ptype](gact);
 	}
 #endif
-	bstats_cpu_update(this_cpu_ptr(gact->common.cpu_bstats), skb);
+	tcf_action_update_bstats(&gact->common, skb);
 	if (action == TC_ACT_SHOT)
 		qstats_drop_inc(this_cpu_ptr(gact->common.cpu_qstats));
 
diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index f38fd459ea45..52830e0339f9 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -233,7 +233,7 @@ static int tcf_mirred_act(struct sk_buff *skb, const struct tc_action *a,
 	}
 
 	tcf_lastuse_update(&m->tcf_tm);
-	bstats_cpu_update(this_cpu_ptr(m->common.cpu_bstats), skb);
+	tcf_action_update_bstats(&m->common, skb);
 
 	m_mac_header_xmit = READ_ONCE(m->tcfm_mac_header_xmit);
 	m_eaction = READ_ONCE(m->tcfm_eaction);
diff --git a/net/sched/act_tunnel_key.c b/net/sched/act_tunnel_key.c
index a5a2bf01eb9b..e5b0c13d6d58 100644
--- a/net/sched/act_tunnel_key.c
+++ b/net/sched/act_tunnel_key.c
@@ -31,7 +31,7 @@ static int tunnel_key_act(struct sk_buff *skb, const struct tc_action *a,
 	params = rcu_dereference_bh(t->params);
 
 	tcf_lastuse_update(&t->tcf_tm);
-	bstats_cpu_update(this_cpu_ptr(t->common.cpu_bstats), skb);
+	tcf_action_update_bstats(&t->common, skb);
 	action = READ_ONCE(t->tcf_action);
 
 	switch (params->tcft_action) {
diff --git a/net/sched/act_vlan.c b/net/sched/act_vlan.c
index 43c5be18241b..ffa5df8765b7 100644
--- a/net/sched/act_vlan.c
+++ b/net/sched/act_vlan.c
@@ -29,7 +29,7 @@ static int tcf_vlan_act(struct sk_buff *skb, const struct tc_action *a,
 	u16 tci;
 
 	tcf_lastuse_update(&v->tcf_tm);
-	bstats_cpu_update(this_cpu_ptr(v->common.cpu_bstats), skb);
+	tcf_action_update_bstats(&v->common, skb);
 
 	/* Ensure 'data' points at mac_header prior calling vlan manipulating
 	 * functions.
-- 
2.25.1


