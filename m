Return-Path: <stable+bounces-66731-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3906394F132
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 17:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B5A7B2597F
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 15:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CC2180032;
	Mon, 12 Aug 2024 15:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dPdT9o8q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125CE17CA0B;
	Mon, 12 Aug 2024 15:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474962; cv=none; b=DITZtvQemI5e2irb23ETfGHr74tvinvHc7KPrJwucjcZ0Trx7v5miEkT8QkOGesa1EVLilcSyHxVN5+duWUkqsoshTCuXt4JG/zWLZOgenjRNat5+j+M8Bn7KQA4JAtLIK3G3LUiPHifYUCoddOxgPSYXQcJc5JVOaETy99VNVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474962; c=relaxed/simple;
	bh=sNWy9LH5Q0V4DaL3OS45i1gyY2PkA+WPP2oYW7GcTi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DphJRchDTMunnH2lq6az6M2i1gNbSKB66A+nsif1u6vBMqnHsaUqqfWHcsVvyhK+I//rS4XlK4c/RRscbo2/RjLY2MX8O0fX2xk+ruW7jDRIQ1p3eCd4iXe2c+EiTaa2hc4UGgLBM4IV2zcJ3L1mPGHlWfQndNNDCUzQ6jRNf2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dPdT9o8q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AFF7C4AF0D;
	Mon, 12 Aug 2024 15:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723474961;
	bh=sNWy9LH5Q0V4DaL3OS45i1gyY2PkA+WPP2oYW7GcTi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dPdT9o8qf8bDbCRGcbIRZfPp/5J0i7ijJo7lwV1mDmCTBslhhWAOY5IgpiyY+jtfV
	 4ysalWi5UEGbfwoRn0o0b6b+o34Lkq/oN8MVojZhXQbzLohyaIC03W+lwVojQePVTl
	 kv/KzPjRUhWqFLOyUP6lVMVvQQbjNbKvCEwAken6J0uQVFiVE6pF8vWoaXpE/ZzeAd
	 A6A0pYHJWxRNbmXJHhGMFp2q9hlcPzdMF+aE3I5Q+ZBWnZPAVJEG3Hl0S2OoyHML62
	 MOUvD1zYtaILpaiW6FYf8gPovHeNYO/MbsKrVHjhXPCRmjS9BQWRldIDBiAyRfqN5I
	 FeGpDRaQwnLRw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.10.y 2/5] mptcp: pm: don't try to create sf if alloc failed
Date: Mon, 12 Aug 2024 17:02:16 +0200
Message-ID: <20240812150213.489098-9-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024081244-smock-nearest-c09a@gregkh>
References: <2024081244-smock-nearest-c09a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2526; i=matttbe@kernel.org; h=from:subject; bh=sNWy9LH5Q0V4DaL3OS45i1gyY2PkA+WPP2oYW7GcTi0=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmuiP1XhX+YrEmfNciApgksM0cgDFjGLRJa189c xerb3CSXmeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZroj9QAKCRD2t4JPQmmg c2sXEACq+C68uWiQyE+t9EglMAY5xp38CntxofLQ7IpLBZvQZyCo4MAmdH6h/pytRSuM+DXISgx qXWMX3FiIXXiPmi9fTiuqb+IdPhT3nDLNKuMTQqmVkE4kc3Mzz7JipUIliKsya0nURr4TdvGUEe 17DocXGBP3YWl5LX5vPskt6p8UHbIwwxKj07LA9C2Ci5YwaEfAZCxsgM8n0vM9YECq+rJdDhYYn NxuS2R4S6+1DImKrzKGkVV7UtHidUym8ICtVjhbLSXtzMdgQ2tuUGevQSfr8iQFn6bRdPeL9EDW kO+wIOscZImrLceKChAaDSnI6VVmDNGLXsyvTADZj3qPjnVERcu3EIAY38/M5k+hrWLwMLPm9ps +A3jjAFtMJZCVbEakzthB2hnSfScMWD9PeNQzVQVv0tVmO4O0osi7wWeYZLVLdoNQ8bZww/E86x JjfF2/NX3T8UXMB/VUWoNes11QZaVlNfLNEKb+gQg6bSN21wAh3t7KHYBFrJqmNq61H3oxKjWhG +VVht7Z5H0eR0sV52DMVoktf5/1Jeup58g4uJAByBFykVS+jxyP+UMJYnWv07gnXzExujK7ks5i ggazBqXK9tTtLnOOSh9ieoCGv3hWbgDXQRF9+xjNaAp0YvYpxRqDI+N/PAKLj2wKN6osveFrgWV AEwG97pDXd2Z4qQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit cd7c957f936f8cb80d03e5152f4013aae65bd986 upstream.

It sounds better to avoid wasting cycles and / or put extreme memory
pressure on the system by trying to create new subflows if it was not
possible to add a new item in the announce list.

While at it, a warning is now printed if the entry was already in the
list as it should not happen with the in-kernel path-manager. With this
PM, mptcp_pm_alloc_anno_list() should only fail in case of memory
pressure.

Fixes: b6c08380860b ("mptcp: remove addr and subflow in PM netlink")
Cc: stable@vger.kernel.org
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20240731-upstream-net-20240731-mptcp-endp-subflow-signal-v1-4-c8a9b036493b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 780f4cca165c..2be7af377cda 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -348,7 +348,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 	add_entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
 
 	if (add_entry) {
-		if (mptcp_pm_is_kernel(msk))
+		if (WARN_ON_ONCE(mptcp_pm_is_kernel(msk)))
 			return false;
 
 		sk_reset_timer(sk, &add_entry->add_timer,
@@ -555,8 +555,6 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 	/* check first for announce */
 	if (msk->pm.add_addr_signaled < add_addr_signal_max) {
-		local = select_signal_address(pernet, msk);
-
 		/* due to racing events on both ends we can reach here while
 		 * previous add address is still running: if we invoke now
 		 * mptcp_pm_announce_addr(), that will fail and the
@@ -567,11 +565,15 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		if (msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_SIGNAL))
 			return;
 
+		local = select_signal_address(pernet, msk);
 		if (!local)
 			goto subflow;
 
+		/* If the alloc fails, we are on memory pressure, not worth
+		 * continuing, and trying to create subflows.
+		 */
 		if (!mptcp_pm_alloc_anno_list(msk, &local->addr))
-			goto subflow;
+			return;
 
 		__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
 		msk->pm.add_addr_signaled++;
-- 
2.45.2


