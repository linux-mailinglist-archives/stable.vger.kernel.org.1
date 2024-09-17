Return-Path: <stable+bounces-76550-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1BB97AC02
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 09:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3445A1F22B64
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 07:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B5D130AC8;
	Tue, 17 Sep 2024 07:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TCTWeGvs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E9244C77;
	Tue, 17 Sep 2024 07:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726557995; cv=none; b=OIraNWA42NSHobF/nrCTjkUCHfhlRCZ/QUMqZ8fEMbj0Vvv6f4bgyliCcR7Xo91/Yq99dmTS3C5JxRPBKXgMaT6Sf1i84zwILYugzBMVyLJ+uBMXswaeQqlzyLKr656jtapKzI/gbhHRnXK2yErQ8zEB64+oDd+BYdMU8PTcjug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726557995; c=relaxed/simple;
	bh=yQC6C1oDs8N8CJpFVeygXzUckUyvbnj/h5KN8aDjUKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S+uhlDJGhaA5ZaEq9sbMUyGJilTGsdShLZckWuVCOVH/m97YaPpOubEzQD8i1BPDtZKMN/gs7YtQRpktiXH2HyhIEVhDwddl91/HVUnepH1ehHrJBj4f/hl9XEOz4IsnIydHcJHskFeobu4neMy1YtM2qctTYtZUPOqr9eSlwr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TCTWeGvs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CADF4C4CECE;
	Tue, 17 Sep 2024 07:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726557994;
	bh=yQC6C1oDs8N8CJpFVeygXzUckUyvbnj/h5KN8aDjUKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TCTWeGvsX08YKrg8NbD36/UCXgQzWHRP5tcRQ80YdcWv6d3dEugQc8bARjX8+XNj2
	 BiNFSEaqgSnOiV6z7m2GgZXu97G41javViccalYIcyS8609bYCNarUDCFnUr6yRbIo
	 oM+sZQxrSd+VZs/RKk6WTwam7QkzRV4qHC2XjZfG/ct9Psk+nrbqlqLlE0i7B1mytl
	 T+AJxhw3QYcOgY53APCEe5H9EjRL/tf9S/MpynTjw+jWg/5lc/1A7gjtVVK+Fs67GF
	 BexgIzPQXJMSCEhQwTez4JgmAzbZswcD7iyTKcLMPEj9GWjcaK7vkxEm0ND8scPzIU
	 kh4tHUnnePgwA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+f3a31fb909db9b2a5c4d@syzkaller.appspotmail.com,
	Matthieu Baerts <matttbe@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.10.y 3/3] mptcp: pm: Fix uaf in __timer_delete_sync
Date: Tue, 17 Sep 2024 09:26:11 +0200
Message-ID: <20240917072607.799536-8-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024091330-reps-craftsman-ab67@gregkh>
References: <2024091330-reps-craftsman-ab67@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3594; i=matttbe@kernel.org; h=from:subject; bh=/XXALFUu8RPVQI5mU5wv9GlF5LNXN/xsZH23tllMpa0=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm6S8Q+ceFwtcEWOGj5LrFncR4y5x+eyqvEyHX0 Xq1nWVTvWWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZukvEAAKCRD2t4JPQmmg c1E3D/92EWPaXUVJR8TY+Wqgel/QAM7492r1jd8YgUVpatX3qA3+WOQ/d+jIsnyWNrzuv+NG+Q+ jSVcXEd4pbEwjycEdQH32YNEaoFLaqM8Df9txBALQHoI+G978eYTaLUweFbEMnmK73R67tLYWqD S07CpyW7lYivGK8+ra+ADONVKQeyk+RSwG2yxzRrZjTd8OJFeedJx9qFDsdAJZzbO3U/FTjzXcX 5kfJR8xKg4TGKsXwz0fmuJaVpt23r2krT1IFavG7OlWf7qEkgTaBKzuGKhPQ0c0eRp1i2Nf3zcR k+bzZVGG29zui633vVbURes1/4z55E+HGfmilQ/wijTG9FffU4B8RFhvFmZsbobYtS9rkIv7e8F 7pZ5pUOFqxTOJD5b9UaCTCXXoTsvPCrKeozkb17k6vpbDkoE8Ku0a02O5glIXTPiQbtIh3PUyPq UW3Xol3pCGfGxnnFsKnF1t46u7dwjaa4ypM7oWP/8F1DMPnLne7E1F9pNPDQ7bcG90GKre2aKFI Jqd9RoI97MLdnyOfl8xH5rx1jrjChWM7xwNtSk4RRHyRWAh5I6kNEt/6wpQCVTjSBd54ilIxUgj v4NJckifT55HJ3HlZ93c6n0i8dN/OkPBGLi6sGFou4zkdCenDSt66rMsYdwyAGFYhfG+Vq4P55F LMEfkgEpiNvImqA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Edward Adam Davis <eadavis@qq.com>

There are two paths to access mptcp_pm_del_add_timer, result in a race
condition:

     CPU1				CPU2
     ====                               ====
     net_rx_action
     napi_poll                          netlink_sendmsg
     __napi_poll                        netlink_unicast
     process_backlog                    netlink_unicast_kernel
     __netif_receive_skb                genl_rcv
     __netif_receive_skb_one_core       netlink_rcv_skb
     NF_HOOK                            genl_rcv_msg
     ip_local_deliver_finish            genl_family_rcv_msg
     ip_protocol_deliver_rcu            genl_family_rcv_msg_doit
     tcp_v4_rcv                         mptcp_pm_nl_flush_addrs_doit
     tcp_v4_do_rcv                      mptcp_nl_remove_addrs_list
     tcp_rcv_established                mptcp_pm_remove_addrs_and_subflows
     tcp_data_queue                     remove_anno_list_by_saddr
     mptcp_incoming_options             mptcp_pm_del_add_timer
     mptcp_pm_del_add_timer             kfree(entry)

In remove_anno_list_by_saddr(running on CPU2), after leaving the critical
zone protected by "pm.lock", the entry will be released, which leads to the
occurrence of uaf in the mptcp_pm_del_add_timer(running on CPU1).

Keeping a reference to add_timer inside the lock, and calling
sk_stop_timer_sync() with this reference, instead of "entry->add_timer".

Move list_del(&entry->list) to mptcp_pm_del_add_timer and inside the pm lock,
do not directly access any members of the entry outside the pm lock, which
can avoid similar "entry->x" uaf.

Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
Cc: stable@vger.kernel.org
Reported-and-tested-by: syzbot+f3a31fb909db9b2a5c4d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f3a31fb909db9b2a5c4d
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Link: https://patch.msgid.link/tencent_7142963A37944B4A74EF76CD66EA3C253609@qq.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit b4cd80b0338945a94972ac3ed54f8338d2da2076)
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index f4f5cc76870a..bd03fb6df729 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -253,15 +253,21 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 {
 	struct mptcp_pm_add_entry *entry;
 	struct sock *sk = (struct sock *)msk;
+	struct timer_list *add_timer = NULL;
 
 	spin_lock_bh(&msk->pm.lock);
 	entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
-	if (entry && (!check_id || entry->addr.id == addr->id))
+	if (entry && (!check_id || entry->addr.id == addr->id)) {
 		entry->retrans_times = ADD_ADDR_RETRANS_MAX;
+		add_timer = &entry->add_timer;
+	}
+	if (!check_id && entry)
+		list_del(&entry->list);
 	spin_unlock_bh(&msk->pm.lock);
 
-	if (entry && (!check_id || entry->addr.id == addr->id))
-		sk_stop_timer_sync(sk, &entry->add_timer);
+	/* no lock, because sk_stop_timer_sync() is calling del_timer_sync() */
+	if (add_timer)
+		sk_stop_timer_sync(sk, add_timer);
 
 	return entry;
 }
@@ -766,7 +772,6 @@ static bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
 
 	entry = mptcp_pm_del_add_timer(msk, addr, false);
 	if (entry) {
-		list_del(&entry->list);
 		kfree(entry);
 		return true;
 	}
-- 
2.45.2


