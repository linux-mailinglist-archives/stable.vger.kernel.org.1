Return-Path: <stable+bounces-164686-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41461B111A0
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 21:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26F1A1CE69B3
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 19:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C002ECEB4;
	Thu, 24 Jul 2025 19:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b="QLbetAyA"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E222ECEA8
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 19:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753385208; cv=none; b=t1CURy6nRYptd8zviw01pX8kQLQ8GNuU1DMZYnA/XbvmnqXlpEGhHhTyvsHx8JPt7ghV6ycuPzYg2aOjmij9sdENL9QFTRt+/2C542xNSPyA5/siOfhICEwNtEltkUzwn/9TIsxC8PHKfb3/yNMQQj3Qo8xNTwGl/BBG6RUFezI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753385208; c=relaxed/simple;
	bh=jYMqPIWhn5H/ssCLc27k2Yi1MGaq9zhg8AjYcronS2c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QsVggUyk6px83V1/bwOwHWBR0SanMAHkLAPxzaEU3PuXisecXYunzalSqJuzyKJP02ugoC6ZEw6+/NfNTOm+sqyxoQSMATa6g3ub4UxpLVByyffWhefS0phtwhbCT6S0Xs159iEsnV8i3Onk29NuBXLlu6ATBCKVEvt/lqEtXhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com; spf=pass smtp.mailfrom=mvista.com; dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b=QLbetAyA; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mvista.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2369dd5839dso304625ad.3
        for <stable@vger.kernel.org>; Thu, 24 Jul 2025 12:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1753385205; x=1753990005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBXbz/cuDMZtiRESFVer2S63mki/Y0hGKIowDHXSeWA=;
        b=QLbetAyAY2YnR1756vKCYfKWp850b0GPVILM8/Y9vUAoVva4Cu3f3ym7mKRh7Fa7re
         eS0gLXPA2Nd4VsWLY0ZOGZcSUpPw5FuivJQuu4P2hEYnhSFTLHj+m+EVqHX0u0yNKLmN
         0q0HU8O6LojPRhPh1T4zt9waujAn9Uy38ytbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753385205; x=1753990005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OBXbz/cuDMZtiRESFVer2S63mki/Y0hGKIowDHXSeWA=;
        b=K1lg5E1Ka94s6+T1AdzjkFXeiAeXF/tenezMdNHAhqvHARC5ed7dH1rtqYdEsodmgr
         rtA33yynDo6GBRWdn44AadAvSXwBZHJGbgucpicAZncVuKLsV9p76Cdcq3SUkRSSFjJL
         vtgSNUN3DrfD0lPgZlC/nF7O0yOwtK31VwLAuqoxJ5uW4hVALN/YUCQjTYpq7JYxiwkI
         Xt5E1B84iXbHLZ4BkAVIS+5LN9piUKdwggtCrfabhRSLVHzJCtd0X7h+IfOx+T/Td6FZ
         qeMt3ovmy4yawMHwtp+u3o5bM6TKNdUJZjbY7bwbKpKZ89ncctDt7X8j4C20QGamsRNI
         puDg==
X-Gm-Message-State: AOJu0YzhoNCZVcbPCLnZ0wxl3mnmzwyBEvRaKaU9/aFU8/jVqXiqMpau
	4XoDuokPW9sYGWKEVbRP+j8xaVyk3xljlLjP43SxVIzjVl3BLnAYkMQQxr63pnQRR7ozxTlh5Vz
	ugj8qQ/g=
X-Gm-Gg: ASbGncstGzHSCInJkdpjru6q4sn8I1ChCAe1hf/g9EryYca0Cm4eHgN51UHMaj5nT3j
	nvdWgWJvVBPaZdL9Anl3tTBDcNKsQHebSa6Zzt2px7BW1LF3LRZZeV9dsds6+4pog+Yd96CLpDu
	wiJnTL9KUxguL6b6W7CjQ+pzVN6lzc0jTUa79Xxo3AanleFOcFhdH1UonomSM5fgHWsVx3Q/sb5
	D0z4EfjIMQ6jV6jX3SX+SXLA5Kr4mlfPmeiBwoPp1P7nnEIuElvX4Aq9Rwz57C1uApw/JDyozRD
	Io3gAKlhiMKp1845lyC+w787iSChKU/oA4pVjMzmWzf9T39MFNDmqQ+3J5hcVN/qPH9HCKnECGF
	nvDmK/aeubMc0xbFgrXuCEplXg6EABL1aDw==
X-Google-Smtp-Source: AGHT+IGTt9FKP/E+VYuUAbtEFW6fbyqqE6TzW8HdvBYyKEDr5Y9VsBylSvBECCv+0Mh8TzMvv8eE9g==
X-Received: by 2002:a17:902:fc85:b0:234:bfcb:5c0a with SMTP id d9443c01a7336-23f9813b655mr51474065ad.5.1753385204996;
        Thu, 24 Jul 2025 12:26:44 -0700 (PDT)
Received: from shubhamPC.mvista.com ([182.74.28.237])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e6635f0a0sm1945884a91.24.2025.07.24.12.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 12:26:44 -0700 (PDT)
From: skulkarni@mvista.com
To: stable@vger.kernel.org
Cc: akuster@mvista.com,
	cminyard@mvista.com,
	Vlad Buslov <vladbu@mellanox.com>,
	Jiri Pirko <jiri@mellanox.com>,
	"David S . Miller" <davem@davemloft.net>,
	Shubham Kulkarni <skulkarni@mvista.com>
Subject: [PATCH 5.4.y 1/8] net: sched: extract common action counters update code into function
Date: Fri, 25 Jul 2025 00:56:12 +0530
Message-Id: <20250724192619.217203-2-skulkarni@mvista.com>
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

[ Upstream commit c8ecebd04cbb6badb46d42fe54282e7883ed63cc ]

Currently, all implementations of tc_action_ops->stats_update() callback
have almost exactly the same implementation of counters update
code (besides gact which also updates drop counter). In order to simplify
support for using both percpu-allocated and regular action counters
depending on run-time flag in following patches, extract action counters
update code into standalone function in act API.

This commit doesn't change functionality.

Signed-off-by: Vlad Buslov <vladbu@mellanox.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: ca22da2fbd69 ("act_mirred: use the backlog for nested calls to mirred ingress")
Signed-off-by: Shubham Kulkarni <skulkarni@mvista.com>
---
 include/net/act_api.h  |  2 ++
 net/sched/act_api.c    | 14 ++++++++++++++
 net/sched/act_ct.c     |  6 +-----
 net/sched/act_gact.c   | 10 +---------
 net/sched/act_mirred.c |  5 +----
 net/sched/act_police.c |  5 +----
 net/sched/act_vlan.c   |  5 +----
 7 files changed, 21 insertions(+), 26 deletions(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index 4dabe4730f00..39374348510c 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -186,6 +186,8 @@ int tcf_action_dump(struct sk_buff *skb, struct tc_action *actions[], int bind,
 		    int ref);
 int tcf_action_dump_old(struct sk_buff *skb, struct tc_action *a, int, int);
 int tcf_action_dump_1(struct sk_buff *skb, struct tc_action *a, int, int);
+void tcf_action_update_stats(struct tc_action *a, u64 bytes, u32 packets,
+			     bool drop, bool hw);
 int tcf_action_copy_stats(struct sk_buff *, struct tc_action *, int);
 
 int tcf_action_check_ctrlact(int action, struct tcf_proto *tp,
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 52394e45bac5..b2a537f1a1ea 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -1032,6 +1032,20 @@ int tcf_action_init(struct net *net, struct tcf_proto *tp, struct nlattr *nla,
 	return err;
 }
 
+void tcf_action_update_stats(struct tc_action *a, u64 bytes, u32 packets,
+			     bool drop, bool hw)
+{
+	_bstats_cpu_update(this_cpu_ptr(a->cpu_bstats), bytes, packets);
+
+	if (drop)
+		this_cpu_ptr(a->cpu_qstats)->drops += packets;
+
+	if (hw)
+		_bstats_cpu_update(this_cpu_ptr(a->cpu_bstats_hw),
+				   bytes, packets);
+}
+EXPORT_SYMBOL(tcf_action_update_stats);
+
 int tcf_action_copy_stats(struct sk_buff *skb, struct tc_action *p,
 			  int compat_mode)
 {
diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index 02d4491991b5..d72c9888fad2 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -917,11 +917,7 @@ static void tcf_stats_update(struct tc_action *a, u64 bytes, u32 packets,
 {
 	struct tcf_ct *c = to_ct(a);
 
-	_bstats_cpu_update(this_cpu_ptr(a->cpu_bstats), bytes, packets);
-
-	if (hw)
-		_bstats_cpu_update(this_cpu_ptr(a->cpu_bstats_hw),
-				   bytes, packets);
+	tcf_action_update_stats(a, bytes, packets, false, hw);
 	c->tcf_tm.lastuse = max_t(u64, c->tcf_tm.lastuse, lastuse);
 }
 
diff --git a/net/sched/act_gact.c b/net/sched/act_gact.c
index faf68a44b845..d58a6c75349f 100644
--- a/net/sched/act_gact.c
+++ b/net/sched/act_gact.c
@@ -175,15 +175,7 @@ static void tcf_gact_stats_update(struct tc_action *a, u64 bytes, u32 packets,
 	int action = READ_ONCE(gact->tcf_action);
 	struct tcf_t *tm = &gact->tcf_tm;
 
-	_bstats_cpu_update(this_cpu_ptr(gact->common.cpu_bstats), bytes,
-			   packets);
-	if (action == TC_ACT_SHOT)
-		this_cpu_ptr(gact->common.cpu_qstats)->drops += packets;
-
-	if (hw)
-		_bstats_cpu_update(this_cpu_ptr(gact->common.cpu_bstats_hw),
-				   bytes, packets);
-
+	tcf_action_update_stats(a, bytes, packets, action == TC_ACT_SHOT, hw);
 	tm->lastuse = max_t(u64, tm->lastuse, lastuse);
 }
 
diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index e3f28cb03f7e..f38fd459ea45 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -324,10 +324,7 @@ static void tcf_stats_update(struct tc_action *a, u64 bytes, u32 packets,
 	struct tcf_mirred *m = to_mirred(a);
 	struct tcf_t *tm = &m->tcf_tm;
 
-	_bstats_cpu_update(this_cpu_ptr(a->cpu_bstats), bytes, packets);
-	if (hw)
-		_bstats_cpu_update(this_cpu_ptr(a->cpu_bstats_hw),
-				   bytes, packets);
+	tcf_action_update_stats(a, bytes, packets, false, hw);
 	tm->lastuse = max_t(u64, tm->lastuse, lastuse);
 }
 
diff --git a/net/sched/act_police.c b/net/sched/act_police.c
index a7660b602237..b67da92955b1 100644
--- a/net/sched/act_police.c
+++ b/net/sched/act_police.c
@@ -306,10 +306,7 @@ static void tcf_police_stats_update(struct tc_action *a,
 	struct tcf_police *police = to_police(a);
 	struct tcf_t *tm = &police->tcf_tm;
 
-	_bstats_cpu_update(this_cpu_ptr(a->cpu_bstats), bytes, packets);
-	if (hw)
-		_bstats_cpu_update(this_cpu_ptr(a->cpu_bstats_hw),
-				   bytes, packets);
+	tcf_action_update_stats(a, bytes, packets, false, hw);
 	tm->lastuse = max_t(u64, tm->lastuse, lastuse);
 }
 
diff --git a/net/sched/act_vlan.c b/net/sched/act_vlan.c
index 7dc76c68ec52..43c5be18241b 100644
--- a/net/sched/act_vlan.c
+++ b/net/sched/act_vlan.c
@@ -308,10 +308,7 @@ static void tcf_vlan_stats_update(struct tc_action *a, u64 bytes, u32 packets,
 	struct tcf_vlan *v = to_vlan(a);
 	struct tcf_t *tm = &v->tcf_tm;
 
-	_bstats_cpu_update(this_cpu_ptr(a->cpu_bstats), bytes, packets);
-	if (hw)
-		_bstats_cpu_update(this_cpu_ptr(a->cpu_bstats_hw),
-				   bytes, packets);
+	tcf_action_update_stats(a, bytes, packets, false, hw);
 	tm->lastuse = max_t(u64, tm->lastuse, lastuse);
 }
 
-- 
2.25.1


