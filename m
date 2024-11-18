Return-Path: <stable+bounces-93826-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE009D180F
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 19:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8251C282DE0
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 18:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1CD1E0DF0;
	Mon, 18 Nov 2024 18:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SfUMmS2P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5342E3EB;
	Mon, 18 Nov 2024 18:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731954473; cv=none; b=VVHkrCT+DtoO26oVQVUK3hL9Nrbh7ecEBszKV4kWAoghzpkaawiPqQx7BvLVhS8VGtsTDBxUoWr71Qwzf0xAh37vXLL0JaCk2abK3gPZuPwpU1IPLuZ7X9MppZuGOwVLdtbdp52i+UF3hi+hhPOCr56RJbnfYurXLRAYRLU6QtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731954473; c=relaxed/simple;
	bh=/3vKm4ylPIZa2+7EkL5cjCgtZjnU/uUqzgWYRCC2N2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ljWqua+5PcRkflPo3Wve74mRxIvyWHn0kFsRLE5QsI7epl0XzSDDrIzR4pEPvuregHDX3vUaz5IOXxL5J+WC9KnKGSFfTZFopg76qmr9L9fX9da5vSr5EJCo3XqVhu92aYpcYO7186Rzt/2TgYY8vQR9Q2fXW0Bp8L3s7YL70W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SfUMmS2P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B61C4CED1;
	Mon, 18 Nov 2024 18:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731954473;
	bh=/3vKm4ylPIZa2+7EkL5cjCgtZjnU/uUqzgWYRCC2N2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SfUMmS2PM+4MsuH4G7QONjucezcUrLwU+kHTNhz/o4QEyRXqiAPj1gjE9pyO1dPSG
	 4/1jlRVRhJ7V9h5RCGxwPzwXrKa6HSi78OGiiJD29Xp6EJxC1X3Kz3L0if9QgUaHWo
	 3rLHtporu3jSUJBsGv1BtBgek5A1Qm0eEr/HEJhRVEBR/97om6UopQVpNHG/+ZhBnq
	 ZdF9DqUumDVlUBdFjm96slWRyrQUz2sduDgO02E/mNuHTy+mrRtc383uukE8gSYK7b
	 ftHyVECQ6sn1OmQLrOhQXJE2+r8qlsvYeXlEev84AFrTykJQOZKstJxmwZ+VKK6T0L
	 sSQO7hrcMEfWg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	sashal@kernel.org,
	Matthieu Baerts <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6.y 5/6] mptcp: drop lookup_by_id in lookup_addr
Date: Mon, 18 Nov 2024 19:27:23 +0100
Message-ID: <20241118182718.3011097-13-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241118182718.3011097-8-matttbe@kernel.org>
References: <20241118182718.3011097-8-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2923; i=matttbe@kernel.org; h=from:subject; bh=hZg08X/uvrihXLRHj7mAWzN7ZcWhonPGmdfxZ8g+tg8=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnO4cGcETYB6kQVnX/rRVcS5ysvxTL48mRfMDmH UTbX2JGu0qJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZzuHBgAKCRD2t4JPQmmg c1KXD/9ce6U7OUrs8zuv0YyDSf14DbKZZgaC9UD+OB8eNFoiarcFJbe2zgwUl9cCfm00nxEKoEW AqAl75pWdD6Re5XTgxTOvcohoRYkuhceF0EOcNzyBcS8Zi+jNeBPc2cuUB+bUZuZO2qfhXNheia KQ0lJQpE4h7bqmFEmTxgQNL+QLHzTi3l8UQm06Ybe1GtOmlEyFFf29YOEu5t1TGmMtfzN50upun BLiwQf1PiniayeQ/oGTf2wEoKGvm3UC0jWqGHENG+PeI2F/WikBxXx9bwwc6ilxmqbPs8PcWAKz qZUeUbKGRx+cRfpALlQy9I02ixW4rilWATXJKaHWb17fz4SY8sbFygn2TfTMUBCp2jLkdX8Clyo PnUyILpkxxjfuD8zCR/NQSrBcAHRFWlKQSqVF89jy8VOHW8uO7nr8SDDgK3qwb2rvQZQZBFi8Pj GZKHXcJ09iPovjA2c73p+HV163601TUotHfaDfwJI+pBYweKP+H/STWqZYwOq+BjU0Ew08dpJ0s GLzlNgylOqU0aAkKbktyJW5sVWZJOVV7KdY2t+mrHMI79n/ftszZrJ2hoqDFM3jwRcHh57/hnhZ 9mkbzDAz3eZcy8Qd7F28tfCPeUxN83mkb5ziGNQXANhOSW0L4F2LjmAmWNCL4RqiozOTMiQtDQl ltn67qzb57qfYCQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

commit af250c27ea1c404e210fc3a308b20f772df584d6 upstream.

When the lookup_by_id parameter of __lookup_addr() is true, it's the same
as __lookup_addr_by_id(), it can be replaced by __lookup_addr_by_id()
directly. So drop this parameter, let __lookup_addr() only looks up address
on the local address list by comparing addresses in it, not address ids.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://lore.kernel.org/r/20240305-upstream-net-next-20240304-mptcp-misc-cleanup-v1-4-c436ba5e569b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: db3eab8110bc ("mptcp: pm: use _rcu variant under rcu_read_lock")
[ Conflicts in pm_netlink.c, because commit 6a42477fe449 ("mptcp: update
  set_flags interfaces") is not in this version, and causes too many
  conflicts when backporting it. The conflict is easy to resolve: addr
  is a pointer here here in mptcp_pm_nl_set_flags(), the rest of the
  code is the same. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index d8c47ca86de4..76be4f4412df 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -521,15 +521,12 @@ __lookup_addr_by_id(struct pm_nl_pernet *pernet, unsigned int id)
 }
 
 static struct mptcp_pm_addr_entry *
-__lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info,
-	      bool lookup_by_id)
+__lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info)
 {
 	struct mptcp_pm_addr_entry *entry;
 
 	list_for_each_entry(entry, &pernet->local_addr_list, list) {
-		if ((!lookup_by_id &&
-		     mptcp_addresses_equal(&entry->addr, info, entry->addr.port)) ||
-		    (lookup_by_id && entry->addr.id == info->id))
+		if (mptcp_addresses_equal(&entry->addr, info, entry->addr.port))
 			return entry;
 	}
 	return NULL;
@@ -560,7 +557,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 		mptcp_local_address((struct sock_common *)msk->first, &mpc_addr);
 		rcu_read_lock();
-		entry = __lookup_addr(pernet, &mpc_addr, false);
+		entry = __lookup_addr(pernet, &mpc_addr);
 		if (entry) {
 			__clear_bit(entry->addr.id, msk->pm.id_avail_bitmap);
 			msk->mpc_endpoint_id = entry->addr.id;
@@ -2064,7 +2061,8 @@ int mptcp_pm_nl_set_flags(struct net *net, struct mptcp_pm_addr_entry *addr, u8
 	}
 
 	spin_lock_bh(&pernet->lock);
-	entry = __lookup_addr(pernet, &addr->addr, lookup_by_id);
+	entry = lookup_by_id ? __lookup_addr_by_id(pernet, addr->addr.id) :
+			       __lookup_addr(pernet, &addr->addr);
 	if (!entry) {
 		spin_unlock_bh(&pernet->lock);
 		return -EINVAL;
-- 
2.45.2


