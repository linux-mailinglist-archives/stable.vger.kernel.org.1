Return-Path: <stable+bounces-67437-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C60950132
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 11:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1470C1F22175
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 09:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5692D17C21C;
	Tue, 13 Aug 2024 09:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9SHwdBU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1306217B43F;
	Tue, 13 Aug 2024 09:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723541310; cv=none; b=P77+vvYb6Nqnqfu4Mb6b8GRqWv1XacQu3v4fNI+LBt9SjtqhwCra+b40uETjY/fy6cYyzOqyQxB1jUW6bc0pquwfKv6W3p0C3ECiDoS/CkItCpKhCNv+yV1k6L4qX6q9DOFRzehm16tlUvIffuqgg6PaPCF4X7AXPSkRqGUoTAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723541310; c=relaxed/simple;
	bh=a1PEwV3yecnCihgpjQ0nmSgjBy8Up3qKb1qSnUJGHt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oq05YXzxUyTTjrLxMzkBiFeXtPJmHwTsFOemHZo3hkVkyNP7qB71afHGy20azG4zfYh6kGeTXXgD5wCkh4eHYwXo24R+igdKmV8/EyFPWUCGU1sxwkiQzakz8I0oG7xtQ4jC+t17EFdXvey/Tf7EkDHtMhu+hr+hNNc3vYVPEkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9SHwdBU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8048C4AF11;
	Tue, 13 Aug 2024 09:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723541309;
	bh=a1PEwV3yecnCihgpjQ0nmSgjBy8Up3qKb1qSnUJGHt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W9SHwdBUo0vVHRbSW+uUxUsAthQQ2H1DHzV4CbbkL5yeXXX2L5LSxmeBNodVhfHXp
	 SBRPfXpAkBlu7F56LIu9s5Xt3v4KLIAQot2Dn4295hqEL7PAEk6TXm8zH+1GUaLILk
	 dazPuhSDvTyRl6o10ni8STFKbox0rL3WmCAaRT8UVBQncdGiXqKJaQaeoIBNyyKglT
	 LVX9qF3ZKq3YmBhDL7xwqAcmC+j11EoXU2+tiUcLISrMovxGFKfj1QNjfdvY7edEB6
	 CwZgAnMUt+Up5GRGSfyKRtl0rGYrDL2a+gX67mx7M/mtRJJqxkzwb12K2ow28HA7i6
	 3J51b17H+XRfA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Geliang Tang <geliang.tang@suse.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH 6.1.y 1/5] mptcp: pass addr to mptcp_pm_alloc_anno_list
Date: Tue, 13 Aug 2024 11:28:17 +0200
Message-ID: <20240813092815.966749-8-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024081245-deem-refinance-8605@gregkh>
References: <2024081245-deem-refinance-8605@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3417; i=matttbe@kernel.org; h=from:subject; bh=C30vkwnXtmOEEDiv0V9T4U7CG8iQnZ1vQNqDcGVQiCA=; b=kA0DAAgB9reCT0JpoHMByyZiAGa7Jy+jrHocevuc3/Vt5+/5SG3SQ9RDqtnmf8lJ3rxt6wuem okCMwQAAQgAHRYhBOjLhfdodwV6bif3eva3gk9CaaBzBQJmuycvAAoJEPa3gk9CaaBz8rwP/1La mJ5b5FzLPZ9bqJx4zMT68yqG+hVxt7Hffj+mz3oXhAR8EY5SHU+NPvyyY/BpZ8JIP+daazBe2bA HEd8NX5B/a/4ZX6b/kWNDiwMqDQ+CAfx8XNWTuaRqIOlKhup62U7v7vbXRO0vcvUU1J7Qt/VgbS ENclobvnDi70z9eEAKSZwLvkDHMXhG85kU0yjgp3VPdHp3MH/ebZaSFaQKgN55OeBKK3IBEWTfD Xh5WnHehEOHov/89uF/a5iHl2r5TIaDvmrbHzOJQmF62Bf5GNa0BJOvAjkxFBrJhOzVwoo1xIAc 3090+Km+JWT2aTpU0BCeLGiIwwOjTojQKsqYPjdq7xRxUtp8/Y8gIfSq8sAySL2lu1l757NvYr3 /pt/LX4D85flfjOLp/BxQLuqvTK+2a03hvJVKLaGHpiQiXdsbcKWPVsQs1WMLU2lu0oqZcJBzwZ 11DSP6X+pYSmQ/SmwbUhlwPsi2ZFa7FXdMRZOek0MNIAo4QU91JWjnlBHZHfdyLelbTDU2WviTy 2ynmcMsGzLl4NUp902L4Zd8y9zGdiGRW1mKZ5flRl8xc9UiM/hqPrDY6R3pK9Xh9LfPXZ4Of4bc m/Ol7FP/bOeOmEGq9xXPpEr2Pu2t45PB0no9bUicYzEVr0C2Z++HCbIhx5K/WO7qRjW+LM74rva yUBVD
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang.tang@suse.com>

commit 528cb5f2a1e859522f36f091f29f5c81ec6d4a4c upstream.

Pass addr parameter to mptcp_pm_alloc_anno_list() instead of entry. We
can reduce the scope, e.g. in mptcp_pm_alloc_anno_list(), we only access
"entry->addr", we can then restrict to the pointer to "addr" then.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: c95eb32ced82 ("mptcp: pm: reduce indentation blocks")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c   | 8 ++++----
 net/mptcp/pm_userspace.c | 2 +-
 net/mptcp/protocol.h     | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 2b5a5680f09a..7891e1a50872 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -352,7 +352,7 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 }
 
 bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
-			      const struct mptcp_pm_addr_entry *entry)
+			      const struct mptcp_addr_info *addr)
 {
 	struct mptcp_pm_add_entry *add_entry = NULL;
 	struct sock *sk = (struct sock *)msk;
@@ -360,7 +360,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 	lockdep_assert_held(&msk->pm.lock);
 
-	add_entry = mptcp_lookup_anno_list_by_saddr(msk, &entry->addr);
+	add_entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
 
 	if (add_entry) {
 		if (mptcp_pm_is_kernel(msk))
@@ -377,7 +377,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 	list_add(&add_entry->list, &msk->pm.anno_list);
 
-	add_entry->addr = entry->addr;
+	add_entry->addr = *addr;
 	add_entry->sock = msk;
 	add_entry->retrans_times = 0;
 
@@ -580,7 +580,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 			return;
 
 		if (local) {
-			if (mptcp_pm_alloc_anno_list(msk, local)) {
+			if (mptcp_pm_alloc_anno_list(msk, &local->addr)) {
 				__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
 				msk->pm.add_addr_signaled++;
 				mptcp_pm_announce_addr(msk, &local->addr, false);
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 278ba5955dfd..f2b90053ecae 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -225,7 +225,7 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
 	lock_sock((struct sock *)msk);
 	spin_lock_bh(&msk->pm.lock);
 
-	if (mptcp_pm_alloc_anno_list(msk, &addr_val)) {
+	if (mptcp_pm_alloc_anno_list(msk, &addr_val.addr)) {
 		msk->pm.add_addr_signaled++;
 		mptcp_pm_announce_addr(msk, &addr_val.addr, false);
 		mptcp_pm_nl_addr_send_ack(msk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 9e582725ccb4..4515cc6b649f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -812,7 +812,7 @@ int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 				 struct mptcp_addr_info *rem,
 				 u8 bkup);
 bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
-			      const struct mptcp_pm_addr_entry *entry);
+			      const struct mptcp_addr_info *addr);
 void mptcp_pm_free_anno_list(struct mptcp_sock *msk);
 bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk);
 struct mptcp_pm_add_entry *
-- 
2.45.2


