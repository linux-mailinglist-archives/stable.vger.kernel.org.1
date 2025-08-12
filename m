Return-Path: <stable+bounces-168247-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7644DB23420
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53834560AB3
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF5F2F5481;
	Tue, 12 Aug 2025 18:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CWIE6U6i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CEF2F4A0A
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 18:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755023541; cv=none; b=XKBlzzuojEaf88zUvse0Wb40eyb3pgiPsbf95QP4HlAdO24MX+Hc0qB+kHus4d8xi23uXRL+94pSSwhXUctbIgCarcAAbsWIWMYXnZ3po1UAcnGHFO0xEMHv8AtiS7cenr4LxJ+iE0oPUmJFJjfDKOJ7/k39vS4UGDB1NFWrWvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755023541; c=relaxed/simple;
	bh=S+OJbQRqmrYSedW4Yd3kVzgk/FGIutfiKK1g6VCePrc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NRkvZaF/eczEnWdWIBqySz5OFOCS4VWuujXfngR3cSrTn3xtfAkhQiAQIaZX5MR6d9YFHi9i/Xj0R3CZTYV+cN1lVFXSRe6IKG5soj8ug0dS+X49AbKpyZgy2lz/Rc4uRmRAUv9HC8nlhIjrTQpmEe8shRSmlHU/B6BjLY7Ri9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CWIE6U6i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43292C4CEF9;
	Tue, 12 Aug 2025 18:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755023540;
	bh=S+OJbQRqmrYSedW4Yd3kVzgk/FGIutfiKK1g6VCePrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CWIE6U6inXfyzV9QvBQ04Ov+C/4XsZSXeUmuTthq6q7BKAzHB9eRnHBkAMQv4xlUZ
	 F5wSoX8hn+VFcJNJ2Lmh1Wf7Fead3X2PcyA0qwbmoWzPY0xaqHgQRHa1wqLFhzgZ88
	 EVuDgtZfmosa/Cxh4Wt0n8yaj2av1tQ+hRfEjZc8qO3T2ElIVZJDOWiUUoSVQLcFrz
	 dZP7hwbakYJojgF0Ssum6AlaXSHQPL/U0hqvbPd5y3X3xI68ZCZSqCYMjlpyxPnNVk
	 sWTaDTN/E04OIyvNl2ZXNpj9X3YNc8PGfs/L67DyqFb/dvQopiIZ+o1y2SniJUm20i
	 1JMaKrsuNUMgw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] net: Add net_passive_inc() and net_passive_dec().
Date: Tue, 12 Aug 2025 14:32:05 -0400
Message-Id: <20250812183207.2024870-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025081230-dentist-cautious-7bb4@gregkh>
References: <2025081230-dentist-cautious-7bb4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit e57a6320215c3967f51ab0edeff87db2095440e4 ]

net_drop_ns() is NULL when CONFIG_NET_NS is disabled.

The next patch introduces a function that increments
and decrements net->passive.

As a prep, let's rename and export net_free() to
net_passive_dec() and add net_passive_inc().

Suggested-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/netdev/CANn89i+oUCt2VGvrbrweniTendZFEh+nwS=uonc004-aPkWy-Q@mail.gmail.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20250217191129.19967-2-kuniyu@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 59b33fab4ca4 ("smb: client: fix netns refcount leak after net_passive changes")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/net_namespace.h | 16 ++++++++++++++++
 net/core/net_namespace.c    |  8 ++++----
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index da93873df4db..022ee2fc627c 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -291,6 +291,7 @@ static inline int check_net(const struct net *net)
 }
 
 void net_drop_ns(void *);
+void net_passive_dec(struct net *net);
 
 #else
 
@@ -320,8 +321,23 @@ static inline int check_net(const struct net *net)
 }
 
 #define net_drop_ns NULL
+
+static inline void net_passive_dec(struct net *net)
+{
+	refcount_dec(&net->passive);
+}
 #endif
 
+static inline void net_passive_inc(struct net *net)
+{
+	refcount_inc(&net->passive);
+}
+
+/* Returns true if the netns initialization is completed successfully */
+static inline bool net_initialized(const struct net *net)
+{
+	return READ_ONCE(net->list.next);
+}
 
 static inline void __netns_tracker_alloc(struct net *net,
 					 netns_tracker *tracker,
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 70fea7c1a4b0..ee3c1b37d06c 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -458,7 +458,7 @@ static void net_complete_free(void)
 
 }
 
-static void net_free(struct net *net)
+void net_passive_dec(struct net *net)
 {
 	if (refcount_dec_and_test(&net->passive)) {
 		kfree(rcu_access_pointer(net->gen));
@@ -476,7 +476,7 @@ void net_drop_ns(void *p)
 	struct net *net = (struct net *)p;
 
 	if (net)
-		net_free(net);
+		net_passive_dec(net);
 }
 
 struct net *copy_net_ns(unsigned long flags,
@@ -517,7 +517,7 @@ struct net *copy_net_ns(unsigned long flags,
 		key_remove_domain(net->key_domain);
 #endif
 		put_user_ns(user_ns);
-		net_free(net);
+		net_passive_dec(net);
 dec_ucounts:
 		dec_net_namespaces(ucounts);
 		return ERR_PTR(rv);
@@ -662,7 +662,7 @@ static void cleanup_net(struct work_struct *work)
 		key_remove_domain(net->key_domain);
 #endif
 		put_user_ns(net->user_ns);
-		net_free(net);
+		net_passive_dec(net);
 	}
 }
 
-- 
2.39.5


