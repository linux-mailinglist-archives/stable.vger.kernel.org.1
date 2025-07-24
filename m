Return-Path: <stable+bounces-164689-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8902B111A2
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 21:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33BD35861DA
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 19:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF95C2ED170;
	Thu, 24 Jul 2025 19:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b="KY6Juiov"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C7E2ECD39
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 19:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753385226; cv=none; b=lJjWXzasAJU4E4dk/qe+quX8ac95Y87o/9SKDKXutswzUuEYeNhpHx8XTscSWPmM2Y8g/NjZAbtFMXLdZ3E9VLE1IZJl5ynzKHdF587Y/3V3rYtYcHorV/USOUoerVKcBxm0sPxyBMekcsTFvzRu+twP8r8NJd/e/4mZjA6Vp3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753385226; c=relaxed/simple;
	bh=9/L2QaOh8vR54wMKMQxccd/bgQld3uYLAl5DrSpe5LY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gFUAvxt2R95V19efN8szI/6KHNCjj6LklfGsAjl8vJ7qTkIfPpeUKZ6q42bZM/XT/8+cd/a2fX342oIWdXsa9+xTnCLIPxBoQL5XL5WUFQU92j/rs5eT5Z/KsRRjBEIDniUPxCVxJbSK8mDt15lH07v5gudyya4mSTfRrotGEns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com; spf=pass smtp.mailfrom=mvista.com; dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b=KY6Juiov; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mvista.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-234ae2bf851so227575ad.1
        for <stable@vger.kernel.org>; Thu, 24 Jul 2025 12:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1753385224; x=1753990024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p1u8aehJeykPWWv2vGWmPOhvxfTAWd8ToRQMx4bteog=;
        b=KY6JuiovYjE7bzwL4FtQhkSF4SQXM7UHPlqF/QeX5PHCZdyNxL2tg4LHgeCd/aPxV6
         2I+cch7/Z+WvwuXmJSbeFTRv2FJvm4nLsBXWtpwnbkrYk6gJmdQInGwqV/7VpG06uC8d
         wvoShd9rMTqus9jdAlffn9jYrRnUMUKa76DSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753385224; x=1753990024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p1u8aehJeykPWWv2vGWmPOhvxfTAWd8ToRQMx4bteog=;
        b=ZKKMIw9yQsE1TtfBKEdhzWqxhj9f6DG8r1oMFE2D20It3HkA2QvM1n5Jb0/L4ccHNT
         elu5pLqVZtxzGbS90WWWWzvnwt0InKi2EQ67uDodiBAT/uGnXANRHuVwd5CBzpu2d2r+
         0+dWsRHGjXMuwCgQbvPwd8ZcYssWiMsM+0ZFHhQbGxAJth+eebFBSPRis9sxxc4Of+LG
         +PJYBK11AFdM6VshChnquArbMJ7pll2Apn2d+TYfS4oBS+xrztIDBfbOoZbf7BizDNjO
         Jgbl8qlVt99UPxjyJIqKxm0iey/3xrhP8y1DCLj47K2EHhnK98nL8TFsodX1l5gNp4yT
         HDLg==
X-Gm-Message-State: AOJu0YzRabaoYHwFV7z4vOPpz9v0M0kQ5aNh1mEgHRp2xpO805ZP766a
	NL0+XERxEJopyw7ruwIKabypuHLheJWX4SgolXfPRAPvtLb0XJ5mtfOS8Kl6DDKzQSvd+HRYbtA
	h1SvBl/o=
X-Gm-Gg: ASbGncuN40LzqUb+6hbGg1K1WQtf+vtoV1SKznVIiIS4yHmiW2bjym/BJaNim6OVSFX
	fcJ26gkyVC8DDtvY3c4EyMp1erIAmgt6RKA0AaTeMXelFWiQ6+K7Nv8rE+ZPht9bjXoPOnh63b9
	Jo6Qv94aUHw6l1RkGgZYSOsJRKOkJ4hO3L1T1dKfETkbjnhyYNTA0gDvNIIT6DOw1m0eqc33/nN
	izcf9r0QxpdsQgRY3KFCteW5T9GnrKv9bzHZ0He4NhZ6ZIxf5Sk5zgVcCaY2xJOcidTkozY90jD
	/xqyLn8RKOnrh9x8f7vUWF62t9UmyMF9XX1OShmbJBxm3hAIRaU+0fePbbo2mYSRyc0CzhSHVVQ
	Wb/3H4i18IA8/EMrXO2HB5AUfhtHvfr7AhA==
X-Google-Smtp-Source: AGHT+IF6Mh6O7C6Sn/VkiypJvdmBNDZKe6HhHLOjAyHLRvOM9/iWSHNpCx2EPtNRFBJxaITf8ZxsCg==
X-Received: by 2002:a17:903:1c6:b0:234:f4a3:f73e with SMTP id d9443c01a7336-23f981ba426mr47956355ad.9.1753385224179;
        Thu, 24 Jul 2025 12:27:04 -0700 (PDT)
Received: from shubhamPC.mvista.com ([182.74.28.237])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e6635f0a0sm1945884a91.24.2025.07.24.12.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 12:27:03 -0700 (PDT)
From: skulkarni@mvista.com
To: stable@vger.kernel.org
Cc: akuster@mvista.com,
	cminyard@mvista.com,
	Vlad Buslov <vladbu@mellanox.com>,
	Jiri Pirko <jiri@mellanox.com>,
	"David S . Miller" <davem@davemloft.net>,
	Shubham Kulkarni <skulkarni@mvista.com>
Subject: [PATCH 5.4.y 4/8] net: sched: don't expose action qstats to skb_tc_reinsert()
Date: Fri, 25 Jul 2025 00:56:15 +0530
Message-Id: <20250724192619.217203-5-skulkarni@mvista.com>
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

[ Upstream commit ef816f3c49c1c404ababc50e10d4cbe5109da678 ]

Previous commit introduced helper function for updating qstats and
refactored set of actions to use the helpers, instead of modifying qstats
directly. However, one of the affected action exposes its qstats to
skb_tc_reinsert(), which then modifies it.

Refactor skb_tc_reinsert() to return integer error code and don't increment
overlimit qstats in case of error, and use the returned error code in
tcf_mirred_act() to manually increment the overlimit counter with new
helper function.

Signed-off-by: Vlad Buslov <vladbu@mellanox.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[ skulkarni: Adjusted patch for file 'sch_generic.h' wrt the mainline commit ]
Stable-dep-of: ca22da2fbd69 ("act_mirred: use the backlog for nested calls to mirred ingress")
Signed-off-by: Shubham Kulkarni <skulkarni@mvista.com>
---
 include/net/sch_generic.h | 12 ++----------
 net/sched/act_mirred.c    |  4 ++--
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 6d934ce54c8d..ee47d65b9b20 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -1320,17 +1320,9 @@ void mini_qdisc_pair_swap(struct mini_Qdisc_pair *miniqp,
 void mini_qdisc_pair_init(struct mini_Qdisc_pair *miniqp, struct Qdisc *qdisc,
 			  struct mini_Qdisc __rcu **p_miniq);
 
-static inline void skb_tc_reinsert(struct sk_buff *skb, struct tcf_result *res)
+static inline int skb_tc_reinsert(struct sk_buff *skb, struct tcf_result *res)
 {
-	struct gnet_stats_queue *stats = res->qstats;
-	int ret;
-
-	if (res->ingress)
-		ret = netif_receive_skb(skb);
-	else
-		ret = dev_queue_xmit(skb);
-	if (ret && stats)
-		qstats_overlimit_inc(res->qstats);
+	return res->ingress ? netif_receive_skb(skb) : dev_queue_xmit(skb);
 }
 
 /* Make sure qdisc is no longer in SCHED state. */
diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index 5602b5de194b..a7e924806c2c 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -295,8 +295,8 @@ static int tcf_mirred_act(struct sk_buff *skb, const struct tc_action *a,
 		/* let's the caller reinsert the packet, if possible */
 		if (use_reinsert) {
 			res->ingress = want_ingress;
-			res->qstats = this_cpu_ptr(m->common.cpu_qstats);
-			skb_tc_reinsert(skb, res);
+			if (skb_tc_reinsert(skb, res))
+				tcf_action_inc_overlimit_qstats(&m->common);
 			__this_cpu_dec(mirred_rec_level);
 			return TC_ACT_CONSUMED;
 		}
-- 
2.25.1


