Return-Path: <stable+bounces-164688-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 284B2B111A6
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 21:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3CFF3B7503
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 19:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C972ED172;
	Thu, 24 Jul 2025 19:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b="ApJROeyK"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD04720126A
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 19:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753385220; cv=none; b=VwvjgspCkZmaAm7OE+hm3819cwa3FPR7wgdgeRp3BVqVTKf8H3eIi2gY0Ko9rKVU/1iAe+rJmyhqPehyuUCoH6ruezS6r808p2IDBxd6kxqpZ2cAYDJzaQG3CiF5fZXgTo0zg2jIx2EEzr8NkFhhWY8w99jqR7WH9iIK5WVf0us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753385220; c=relaxed/simple;
	bh=tIBvgWwYpbBGKnZmc+E5i6aZKP/5GyOzXUUwPTlTMeI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qqwxLArB0+oCQ7pVXcYiajMVjLF0PGKU4nXZb0pLFFxwEoB+HgoZI8wcRDMWRdqVHgzONuI0y8cQWgQAEtrS76ZmZo82oNCcemgZjMov56VpumPCg1orTQR2ObuQ6eazIRTN7kFaKi+ZvhnCfPrO9dslF8GSmV2HdAFApP60s4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com; spf=pass smtp.mailfrom=mvista.com; dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b=ApJROeyK; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mvista.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-235ef29524fso274625ad.1
        for <stable@vger.kernel.org>; Thu, 24 Jul 2025 12:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1753385218; x=1753990018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4U9CuHPXd4GIxiOA/bx8U/lTutSJlieSxtUwJabTMSs=;
        b=ApJROeyKa0Eufs34cSeHoUL9ZuSHI1/J/6e41RLyaA8NIL7Q751UZnJQlnFPW2X+QL
         W9sM52TO24mAzspTf/THvAPzi4lSeo7/8+EjJ+loutyL3fCrd63tfpCd5rPXL99Cnx54
         E7bDPb3vOSsx5fmti/HbKls+dtFKfzdo64Yok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753385218; x=1753990018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4U9CuHPXd4GIxiOA/bx8U/lTutSJlieSxtUwJabTMSs=;
        b=pYzak2L0VIl/oraJBOgQCR+2Wnv1NKC2oEwLIYRY1o8Xfvk6p4wyoqUFratCjufG70
         rSL9X7N224ziw02NjBJ6eBrso5x29rYY8oLDhN1z+SzsY4qxbRxC4/DtqwzAffhVFisb
         +x7UDU7173FZjyiPAqVkhnKM9o0ynEVSfsWV5c7CygD98rJksRWx6ZtJvuJmAytY1mkk
         qA0kf3Js2Cxpboe/sHTR17S9iwRMwes60G0ttdN9Gwe2TzikSLtaJb+0KNNC1C2PkBx5
         gH/8qUFT+rQ94gDMGeJI41kucIRQus4jU1A9Zz3kzB+L20bCm4xVQpnPCE2qnQBl4pCK
         ASgw==
X-Gm-Message-State: AOJu0YwosKvz6mt2DPi+N1UKShWA2B3m1J6Gq9RS/0SlVh6+wRAaAOEl
	3G4GO4YoSJzYsPbucBaBzz4YGdeXEK4oov4pSbpxtwjvx2gTEhgLOXy3tIMmqR25XvIbpJvHJwH
	GmEuca/s=
X-Gm-Gg: ASbGncvkylL/E2K403hI4s0Q86NJdtmPwTPY+D1AlWWqNE5WcCR5Ig9Ts8T0wSQK5oW
	cZgTwG6ZIp21J47ecE4HvpOeYMf02ieeHYwuB4gSRW3nz32RTFabt27M90j4KQzvJK4PR2ZBfIS
	AxnTGqFvn/sdT4OmqHepuhkVZ13+44k7oxYQFj1dKQ3K0izn9niNsp2okKMaD4a4WQfNIZvTuwZ
	nni7tPZmIEEfcvaOEb5xl+rYDA8+8Eg616ar2DzVpeJWb9ulT+YQyzP0Pw/YnNTSFtfO+ZWDsN6
	dOdazYpwbe2+yhgoRHT5NV6GZU8EUxKHbesexeca6OXrmee1LvBuRn5tnYJYkNh6jLO44IhOeZf
	/fGR+1co7hy5GCzJ4RUUUbrLVT9wU6O++S8MJjtBY+zj7
X-Google-Smtp-Source: AGHT+IFGH0Dlp8uqSICgDY0br4QSyDz+qCHslz9mtGL8LAuX9N4NebKiydVuch9medVWCisDT+I84Q==
X-Received: by 2002:a17:902:dac9:b0:235:225d:308f with SMTP id d9443c01a7336-23f9813b2camr49361325ad.4.1753385217722;
        Thu, 24 Jul 2025 12:26:57 -0700 (PDT)
Received: from shubhamPC.mvista.com ([182.74.28.237])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e6635f0a0sm1945884a91.24.2025.07.24.12.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 12:26:57 -0700 (PDT)
From: skulkarni@mvista.com
To: stable@vger.kernel.org
Cc: akuster@mvista.com,
	cminyard@mvista.com,
	Vlad Buslov <vladbu@mellanox.com>,
	Jiri Pirko <jiri@mellanox.com>,
	"David S . Miller" <davem@davemloft.net>,
	Shubham Kulkarni <skulkarni@mvista.com>
Subject: [PATCH 5.4.y 3/8] net: sched: extract qstats update code into functions
Date: Fri, 25 Jul 2025 00:56:14 +0530
Message-Id: <20250724192619.217203-4-skulkarni@mvista.com>
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

[ Upstream commit 26b537a88ca5b7399c7ab0656e06dbd9da9513c1 ]

Extract common code that increments cpu_qstats counters into standalone act
API functions. Change hardware offloaded actions that use percpu counter
allocation to use the new functions instead of accessing cpu_qstats
directly.

This commit doesn't change functionality.

Signed-off-by: Vlad Buslov <vladbu@mellanox.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: ca22da2fbd69 ("act_mirred: use the backlog for nested calls to mirred ingress")
Signed-off-by: Shubham Kulkarni <skulkarni@mvista.com>
---
 include/net/act_api.h  | 16 ++++++++++++++++
 net/sched/act_csum.c   |  2 +-
 net/sched/act_ct.c     |  2 +-
 net/sched/act_gact.c   |  2 +-
 net/sched/act_mirred.c |  2 +-
 net/sched/act_vlan.c   |  2 +-
 6 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index 46009acb198b..25d9a12118ba 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -193,6 +193,22 @@ static inline void tcf_action_update_bstats(struct tc_action *a,
 	bstats_cpu_update(this_cpu_ptr(a->cpu_bstats), skb);
 }
 
+static inline struct gnet_stats_queue *
+tcf_action_get_qstats(struct tc_action *a)
+{
+	return this_cpu_ptr(a->cpu_qstats);
+}
+
+static inline void tcf_action_inc_drop_qstats(struct tc_action *a)
+{
+	qstats_drop_inc(this_cpu_ptr(a->cpu_qstats));
+}
+
+static inline void tcf_action_inc_overlimit_qstats(struct tc_action *a)
+{
+	qstats_overlimit_inc(this_cpu_ptr(a->cpu_qstats));
+}
+
 void tcf_action_update_stats(struct tc_action *a, u64 bytes, u32 packets,
 			     bool drop, bool hw);
 int tcf_action_copy_stats(struct sk_buff *, struct tc_action *, int);
diff --git a/net/sched/act_csum.c b/net/sched/act_csum.c
index e502e256ad67..5a1f9c8be8b7 100644
--- a/net/sched/act_csum.c
+++ b/net/sched/act_csum.c
@@ -621,7 +621,7 @@ static int tcf_csum_act(struct sk_buff *skb, const struct tc_action *a,
 	return action;
 
 drop:
-	qstats_drop_inc(this_cpu_ptr(p->common.cpu_qstats));
+	tcf_action_inc_drop_qstats(&p->common);
 	action = TC_ACT_SHOT;
 	goto out;
 }
diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index 0727a2516736..077cef97527f 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -486,7 +486,7 @@ static int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
 	return retval;
 
 drop:
-	qstats_drop_inc(this_cpu_ptr(a->cpu_qstats));
+	tcf_action_inc_drop_qstats(&c->common);
 	return TC_ACT_SHOT;
 }
 
diff --git a/net/sched/act_gact.c b/net/sched/act_gact.c
index ff78de432871..ef08fd58f28a 100644
--- a/net/sched/act_gact.c
+++ b/net/sched/act_gact.c
@@ -161,7 +161,7 @@ static int tcf_gact_act(struct sk_buff *skb, const struct tc_action *a,
 #endif
 	tcf_action_update_bstats(&gact->common, skb);
 	if (action == TC_ACT_SHOT)
-		qstats_drop_inc(this_cpu_ptr(gact->common.cpu_qstats));
+		tcf_action_inc_drop_qstats(&gact->common);
 
 	tcf_lastuse_update(&gact->tcf_tm);
 
diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index 52830e0339f9..5602b5de194b 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -309,7 +309,7 @@ static int tcf_mirred_act(struct sk_buff *skb, const struct tc_action *a,
 
 	if (err) {
 out:
-		qstats_overlimit_inc(this_cpu_ptr(m->common.cpu_qstats));
+		tcf_action_inc_overlimit_qstats(&m->common);
 		if (tcf_mirred_is_act_redirect(m_eaction))
 			retval = TC_ACT_SHOT;
 	}
diff --git a/net/sched/act_vlan.c b/net/sched/act_vlan.c
index ffa5df8765b7..b4b09c0c8589 100644
--- a/net/sched/act_vlan.c
+++ b/net/sched/act_vlan.c
@@ -88,7 +88,7 @@ static int tcf_vlan_act(struct sk_buff *skb, const struct tc_action *a,
 	return action;
 
 drop:
-	qstats_drop_inc(this_cpu_ptr(v->common.cpu_qstats));
+	tcf_action_inc_drop_qstats(&v->common);
 	return TC_ACT_SHOT;
 }
 
-- 
2.25.1


