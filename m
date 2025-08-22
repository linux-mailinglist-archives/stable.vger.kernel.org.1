Return-Path: <stable+bounces-172412-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF85B31AF9
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 16:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDB55168125
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 14:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED838303CB6;
	Fri, 22 Aug 2025 14:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJU5Hm9/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95602FF164;
	Fri, 22 Aug 2025 14:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755871878; cv=none; b=ttbWP9GTB+hwQl2y7ITtNmmgXEG7M93247AsOTsKSRrifH0JZev+az7mzG7zc7iwh/ZeGF4V3g0uZZxHsKWq4Zds1W+9x/AN15D6iSPgaumjleYxUakWLFglGk/Fv5/ikKQ+U421AkvgwWoe9PXKg7QHF6GAuafvmi4qITLdYjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755871878; c=relaxed/simple;
	bh=Ot1RVEKYlx9r+8NCw65RIopQDCCPBsCsFzU9yDTd+to=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WCvN4E1IGxqcewYo63e1OOp/q9fdrOgOjQHs6UV3Fmmda3XGCx3UVTVX3jgx8T+WYcsT+L+8MAX/tkEMgCHU1cSQeCxBvERYdy5IvSp40qudm5ftfqIHOVzUSIWMc0WGmGLs/5kyiEvAx7pVQmWq5xrM08WTOyM23bhnkZUjmg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJU5Hm9/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EDEFC4CEED;
	Fri, 22 Aug 2025 14:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755871878;
	bh=Ot1RVEKYlx9r+8NCw65RIopQDCCPBsCsFzU9yDTd+to=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZJU5Hm9/mL7HfQ2OhZn6Mh6DVCUG94Dydn0O2AvXSN058dsKHBTrB+DWT9sd5G7rt
	 LPegT0BTFlJm7Ujb+PTrWA+XryFDKLTZcF9itBM/OY9ftsRIQpE18v1t8jWGEuDVa6
	 1DwteINA96ImR6WscxYKqvYfErFmn1DbAKwg8X3vALt0j+vj/lfuFR+83CwWMyCDoA
	 aOmh6xYM2VBY4QjfpqkIslHQTF4dvVCYSsXxxilOYVlN4FDRxiD9QhRIh+J7vHRsH1
	 Jf5hbySkSX280Z2ZX3tWrugeqnUEBBAa8E0lDbymHPrR1qsza8OL2D17uf6CTYkB7/
	 FPQ6c22sFjFqQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	sashal@kernel.org,
	Matthieu Baerts <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6.y 2/3] mptcp: disable add_addr retransmission when timeout is 0
Date: Fri, 22 Aug 2025 16:11:02 +0200
Message-ID: <20250822141059.48927-7-matttbe@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250822141059.48927-5-matttbe@kernel.org>
References: <20250822141059.48927-5-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3467; i=matttbe@kernel.org; h=from:subject; bh=lLXtdcKyHjBZJd+jfTtWLmZzxTvwgAI4EwxnzVKnMHQ=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJWVJVtn/p268xTnKFP7mre+1TumZj3Wzb5ReoEno2dx xe+ub81vKOUhUGMi0FWTJFFui0yf+bzKt4SLz8LmDmsTCBDGLg4BWAiq5YwMixf0rfgHt8p5klL fi08fP8/16OTpeKBxe8v2i/7oF2+WK2Q4b/TxxcVWY/vs1drRj7O9WM+sYiz6WdOKUNMwGVLeZf pbzgA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

commit f5ce0714623cffd00bf2a83e890d09c609b7f50a upstream.

When add_addr_timeout was set to 0, this caused the ADD_ADDR to be
retransmitted immediately, which looks like a buggy behaviour. Instead,
interpret 0 as "no retransmissions needed".

The documentation is updated to explicitly state that setting the timeout
to 0 disables retransmission.

Fixes: 93f323b9cccc ("mptcp: add a new sysctl add_addr_timeout")
Cc: stable@vger.kernel.org
Suggested-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20250815-net-mptcp-misc-fixes-6-17-rc2-v1-5-521fe9957892@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Before commit e4c28e3d5c09 ("mptcp: pm: move generic PM helpers to
  pm.c"), mptcp_pm_alloc_anno_list() was in pm_netlink.c. The same patch
  can be applied there without conflicts. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 Documentation/networking/mptcp-sysctl.rst |  2 ++
 net/mptcp/pm_netlink.c                    | 13 ++++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
index 15f1919d640c..b797f3dd4b69 100644
--- a/Documentation/networking/mptcp-sysctl.rst
+++ b/Documentation/networking/mptcp-sysctl.rst
@@ -20,6 +20,8 @@ add_addr_timeout - INTEGER (seconds)
 	resent to an MPTCP peer that has not acknowledged a previous
 	ADD_ADDR message.
 
+	Do not retransmit if set to 0.
+
 	The default value matches TCP_RTO_MAX. This is a per-namespace
 	sysctl.
 
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 19c07033e6fa..e8042014bd5f 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -294,6 +294,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	struct mptcp_pm_add_entry *entry = from_timer(entry, timer, add_timer);
 	struct mptcp_sock *msk = entry->sock;
 	struct sock *sk = (struct sock *)msk;
+	unsigned int timeout;
 
 	pr_debug("msk=%p\n", msk);
 
@@ -311,6 +312,10 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 		goto out;
 	}
 
+	timeout = mptcp_get_add_addr_timeout(sock_net(sk));
+	if (!timeout)
+		goto out;
+
 	spin_lock_bh(&msk->pm.lock);
 
 	if (!mptcp_pm_should_add_signal_addr(msk)) {
@@ -322,7 +327,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 
 	if (entry->retrans_times < ADD_ADDR_RETRANS_MAX)
 		sk_reset_timer(sk, timer,
-			       jiffies + mptcp_get_add_addr_timeout(sock_net(sk)));
+			       jiffies + timeout);
 
 	spin_unlock_bh(&msk->pm.lock);
 
@@ -364,6 +369,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 	struct mptcp_pm_add_entry *add_entry = NULL;
 	struct sock *sk = (struct sock *)msk;
 	struct net *net = sock_net(sk);
+	unsigned int timeout;
 
 	lockdep_assert_held(&msk->pm.lock);
 
@@ -388,8 +394,9 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 	timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
 reset_timer:
-	sk_reset_timer(sk, &add_entry->add_timer,
-		       jiffies + mptcp_get_add_addr_timeout(net));
+	timeout = mptcp_get_add_addr_timeout(net);
+	if (timeout)
+		sk_reset_timer(sk, &add_entry->add_timer, jiffies + timeout);
 
 	return true;
 }
-- 
2.50.0


