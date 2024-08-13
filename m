Return-Path: <stable+bounces-67440-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BB1950135
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 11:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C517F1F2144F
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 09:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5C717C7CC;
	Tue, 13 Aug 2024 09:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHj/te7T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5985017BB2F;
	Tue, 13 Aug 2024 09:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723541316; cv=none; b=uni31wSFMmZ9OwCjPiLeXho803uHTG+e6lDSvrTDotKFj9QmOmVAYa6QtTLNg4iRv4siKtGOB/B5qF4dOx8WDDF+IhXHWCnkBtoa4C9dirjTq/koPxJflkIo4izlQwMvnnpVc3jcxOqcyOyna+6wyWm9K5zPjh9FIG+S40OxlW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723541316; c=relaxed/simple;
	bh=KKL0QDLjH5+jn/cIEneugjMffYIRrcs8H9Jn78qnhnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZtoF02fcCwl/mbiDkVrTa2oTd+h8GYj9HeQZ4t6gXa3z1t/JKFGNCFAMlgUdy2CdauOT4Ie/l5ot7NDEodqZEETVtUIOmhVYuqMibXMwAsTga4JbEjB9nTnXiCTn6wnaNkvCxCZu8a9TgNsffsnLuzNL2sNFyISCsswyBxoLr60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHj/te7T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ECC1C4AF09;
	Tue, 13 Aug 2024 09:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723541316;
	bh=KKL0QDLjH5+jn/cIEneugjMffYIRrcs8H9Jn78qnhnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gHj/te7T00N8dn3GD10uvflOwFnFOr+HhrWxpXJ0EdYFA2p9ZPAmQpdlnPa2UcrG/
	 ESorIIoDlDd0q5N2yBgdKx4DlEPymebTMAEpgWseqf+Vviipu4P0vYcCzB50uTvz/0
	 KQJisQLVumpCWgbMLqqwPXuenhPVM9w4DAslVzeEcQ9LjbZTyVjE4deahJ2ICZDrHR
	 /UlM/HPZUBPA3cSVs78ir+8lRUHn2Qfel3qqiU/Es6y1gAYJ6D0aKP6R3S1hWV2pgg
	 2bpeP24QAO44NV6DYIAjQXiSb/Vsvf3XziPWiKx0KNfZmbPZt1imPTnCX4o1UXsATd
	 kTl4d2HLfRfBg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1.y 4/5] mptcp: pm: do not ignore 'subflow' if 'signal' flag is also set
Date: Tue, 13 Aug 2024 11:28:20 +0200
Message-ID: <20240813092815.966749-11-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024081245-deem-refinance-8605@gregkh>
References: <2024081245-deem-refinance-8605@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4174; i=matttbe@kernel.org; h=from:subject; bh=KKL0QDLjH5+jn/cIEneugjMffYIRrcs8H9Jn78qnhnY=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmuycvcx0SbHBYY0IFkSPaXEIKfpPzBSai5JaZJ NcLbpGQ3guJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZrsnLwAKCRD2t4JPQmmg cwxCD/9k4WqU+KkqK7ZD9pM1N0mTsKSNlQHfi3Dp7/HVqxkkWxJV8J9n1/PX049AmmBWtVd9Z7M mzmMA34zkwEwWsdYlPjQl/YPy3DmuFshA4Ywx1CGN53hkeFuWijFY81M+v8O2ya3I/6gnCST/sA QIwm508YoePgKb6XhS0s/K3fguh6xeEoIljWdpmjjxGikQhiZCLM/NHS7tr5Zhtqe+HNuJ4g71H SWlbh6ehT8PO63jL3nE4VHRVd/Be4fR5o7FuJ0z/vlYLD8V0crm7o5a4/k/enQjNWPH7sZDplqQ KpNFftqp7EPfsKMnGxflPFcJlm0YgT4zYzFzcoq4rfraNCTDm1tVH6gevxLnMWV/SxDfKE3vqJ8 4G5re8Jo0hjpkmWGleJ1zCuhcbMM8OJ9c9y5GQO/RkVBj08xIxY+FFtd1vZghU3yUrTvx5Nsf4P jppl4G+2rK/uJlwgZQ+reRW8fbOQb5gIhyxDGxrxL1fxFunygWKPJMNVUFxXJdijDLjL7Wbb6Mu Nz3uUr/A5OKrghQo2TgA1ICHYD7IKY+oOcrusnDom1qOpTIT4An562/XFvzmYPZwwJEqewvejgK DW8R3ZRBicEXKjKrbF3E+JHZnfrjbMgVkE87/wZxFeD4sPxXguMw4tpbtZn/XaG91R7ethMdiOU 3I9tyVcUL5qPLhw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit 85df533a787bf07bf4367ce2a02b822ff1fba1a3 upstream.

Up to the 'Fixes' commit, having an endpoint with both the 'signal' and
'subflow' flags, resulted in the creation of a subflow and an address
announcement using the address linked to this endpoint. After this
commit, only the address announcement was done, ignoring the 'subflow'
flag.

That's because the same bitmap is used for the two flags. It is OK to
keep this single bitmap, the already selected local endpoint simply have
to be re-used, but not via select_local_address() not to look at the
just modified bitmap.

Note that it is unusual to set the two flags together: creating a new
subflow using a new local address will implicitly advertise it to the
other peer. So in theory, no need to advertise it explicitly as well.
Maybe there are use-cases -- the subflow might not reach the other peer
that way, we can ask the other peer to try initiating the new subflow
without delay -- or very likely the user is confused, and put both flags
"just to be sure at least the right one is set". Still, if it is
allowed, the kernel should do what has been asked: using this endpoint
to announce the address and to create a new subflow from it.

An alternative is to forbid the use of the two flags together, but
that's probably too late, there are maybe use-cases, and it was working
before. This patch will avoid people complaining subflows are not
created using the endpoint they added with the 'subflow' and 'signal'
flag.

Note that with the current patch, the subflow might not be created in
some corner cases, e.g. if the 'subflows' limit was reached when sending
the ADD_ADDR, but changed later on. It is probably not worth splitting
id_avail_bitmap per target ('signal', 'subflow'), which will add another
large field to the msk "just" to track (again) endpoints. Anyway,
currently when the limits are changed, the kernel doesn't check if new
subflows can be created or removed, because we would need to keep track
of the received ADD_ADDR, and more. It sounds OK to assume that the
limits should be properly configured before establishing new
connections.

Fixes: 86e39e04482b ("mptcp: keep track of local endpoint still available for each msk")
Cc: stable@vger.kernel.org
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20240731-upstream-net-20240731-mptcp-endp-subflow-signal-v1-5-c8a9b036493b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 8c04e8fb4488..368886d3faac 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -524,8 +524,8 @@ __lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info,
 
 static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 {
+	struct mptcp_pm_addr_entry *local, *signal_and_subflow = NULL;
 	struct sock *sk = (struct sock *)msk;
-	struct mptcp_pm_addr_entry *local;
 	unsigned int add_addr_signal_max;
 	unsigned int local_addr_max;
 	struct pm_nl_pernet *pernet;
@@ -591,6 +591,9 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		msk->pm.add_addr_signaled++;
 		mptcp_pm_announce_addr(msk, &local->addr, false);
 		mptcp_pm_nl_addr_send_ack(msk);
+
+		if (local->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)
+			signal_and_subflow = local;
 	}
 
 subflow:
@@ -601,9 +604,14 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		bool fullmesh;
 		int i, nr;
 
-		local = select_local_address(pernet, msk);
-		if (!local)
-			break;
+		if (signal_and_subflow) {
+			local = signal_and_subflow;
+			signal_and_subflow = NULL;
+		} else {
+			local = select_local_address(pernet, msk);
+			if (!local)
+				break;
+		}
 
 		fullmesh = !!(local->flags & MPTCP_PM_ADDR_FLAG_FULLMESH);
 
-- 
2.45.2


