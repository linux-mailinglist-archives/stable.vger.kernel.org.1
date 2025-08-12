Return-Path: <stable+bounces-168392-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38626B234DF
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A2BC1B605FC
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB432FF151;
	Tue, 12 Aug 2025 18:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ndp2jB9e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1ED2FF15D
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 18:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755024025; cv=none; b=QFWm5TsiUe0EPGOZGO0x6hgpyt3S9G4wgIjdGj0AgN1VOvCOgE2XzHhBo88xm6ckvY6UjZdFMjvVlLZFq2S+o02QwTwxz7c6UedXWRORKpSavHWrE/hIPXf9Z3rCpKXa0C9IEqsSEt+mL6iru1YI0/JMPm2URJZPmt47YGP2Nf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755024025; c=relaxed/simple;
	bh=FrwgYH5Tf3DmAJREM2ZN8s2A+9PcAfKsPSpJBOEfRzs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X+PakMXZ5DfabFfLd/SzNhQd3vTLiRx2lhyuhTy0P1k55U3Fqw4cFrEQXkx9DBbfV5pdTyUw8BPSB1K/sA8FDADDYbsQHLlbZIaSAxj+fjjVfy/zvqHZx3G4EULSNSlzLun8N8dPDakwPVpwzsCBcN24aBy6Lf2+OU3w8xs1fIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ndp2jB9e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64F90C4CEF9;
	Tue, 12 Aug 2025 18:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755024024;
	bh=FrwgYH5Tf3DmAJREM2ZN8s2A+9PcAfKsPSpJBOEfRzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ndp2jB9e2faSo+cgIvidXS4tvHqH9cKjr7kbc2zpSxayq/1wGJ84tH33LIM6btVlx
	 cbtP/i5z/mgVAAfupt5CKCggFDAhn5R4odpwUusN2zys6EeSQ/3HqH4VLtuOgitT6W
	 QZrd6dqcnIujVma3XstFCBbqAYbAgwjzvxlp1syOTSEm5Tl6RSi1NcEY+izv8VwutX
	 U4d9ODofzTGhxCOKGU9CqXfYxOOrrmjnDCMwLLUpy2TRya9fucApOJIUyVvkD+wj1j
	 yqYtb4/APLr8BpDJjM1weMgVxPv8GlwOq2Q+FEEGsZc5ZE8LtmsMdU5i7/RpGZNDI2
	 zPC84z0S4cdQA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] net: Add net_passive_inc() and net_passive_dec().
Date: Tue, 12 Aug 2025 14:40:15 -0400
Message-Id: <20250812184017.2025429-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025081245-premises-spoiler-440c@gregkh>
References: <2025081245-premises-spoiler-440c@gregkh>
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
index ce3f84c6eb8e..5ddcadee62b7 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -293,6 +293,7 @@ static inline int check_net(const struct net *net)
 }
 
 void net_drop_ns(void *);
+void net_passive_dec(struct net *net);
 
 #else
 
@@ -322,8 +323,23 @@ static inline int check_net(const struct net *net)
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
index 70ac9d9bc877..20829e0c36cd 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -467,7 +467,7 @@ static void net_complete_free(void)
 
 }
 
-static void net_free(struct net *net)
+void net_passive_dec(struct net *net)
 {
 	if (refcount_dec_and_test(&net->passive)) {
 		kfree(rcu_access_pointer(net->gen));
@@ -485,7 +485,7 @@ void net_drop_ns(void *p)
 	struct net *net = (struct net *)p;
 
 	if (net)
-		net_free(net);
+		net_passive_dec(net);
 }
 
 struct net *copy_net_ns(unsigned long flags,
@@ -527,7 +527,7 @@ struct net *copy_net_ns(unsigned long flags,
 		key_remove_domain(net->key_domain);
 #endif
 		put_user_ns(user_ns);
-		net_free(net);
+		net_passive_dec(net);
 dec_ucounts:
 		dec_net_namespaces(ucounts);
 		return ERR_PTR(rv);
@@ -672,7 +672,7 @@ static void cleanup_net(struct work_struct *work)
 		key_remove_domain(net->key_domain);
 #endif
 		put_user_ns(net->user_ns);
-		net_free(net);
+		net_passive_dec(net);
 	}
 }
 
-- 
2.39.5


