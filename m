Return-Path: <stable+bounces-66753-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D82D94F1C4
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 17:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 729F51C221B1
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 15:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AF01862BB;
	Mon, 12 Aug 2024 15:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LoTg0OET"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94CE1474C3;
	Mon, 12 Aug 2024 15:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723476664; cv=none; b=e/DV/dBHvIaP7VASGNqf7ooqIRBAdhnn770eaa9m7dVYtOLREo5flRMkxpjDfEOqWVLWL4Z0v/sWSMPJglw9nvhvrfWPpvLrd09Z8XUSzJBVgu3uBUJiffqy9B0tV7OdgpTZHij8N15HtY9oQ98gdCcru/rP4sDW0+vFnVQR4Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723476664; c=relaxed/simple;
	bh=LoOhskoq0xdMO+vDO6MdulkGC6tGrI29NGXdO4lliZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I0bqb0LvKtLk2OhgELXsDLtP1WuLAU7tBtlcUvFoUMsK5QtUpIIYSmnAADrrKtTseVkb4bCSJ/lZHA4l1Y8EL5QvSzKhtrFxXcA9HLYZ2zRRQ7H131urEvwHX6S4Pjld7anBgIJq0qEniv0qb1b54V0Fqcik3YmxtfQN75n54R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LoTg0OET; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3EE3C4AF17;
	Mon, 12 Aug 2024 15:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723476663;
	bh=LoOhskoq0xdMO+vDO6MdulkGC6tGrI29NGXdO4lliZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LoTg0OET7AjQg/D+1gUiKhzOZHtEgkEuBy9I9DMn9XPe4ty/TyMvuf/ytPeI6dB1O
	 mCGha4rUADm2NJCm/brnN/E8awEKmyu0/jmQG+vHT5Srz2MWhTZti7VAnwlKEfP+f3
	 6nLdrwPlRO8GIgNyh057gA7uVVvFkAAmcF6IRfEPlf0NkAbhMjxgB20xU8B4rFZP5v
	 v9ak7xghIqVBQq6lVEOJg4QtQipvRxrKob3VUy/1QtY+4hBh6/oJYFtJoBiE0xIhaB
	 XFZHc4iFEdAtEbr3o7/pe9G1MbT9S6gKqGN+CgRjNiG4/EWra2t8302M3vsx8dH31L
	 4Ac6mevxTMAsg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6.y 3/5] mptcp: pm: do not ignore 'subflow' if 'signal' flag is also set
Date: Mon, 12 Aug 2024 17:30:54 +0200
Message-ID: <20240812153050.573404-10-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024081244-uncertain-snarl-e4f6@gregkh>
References: <2024081244-uncertain-snarl-e4f6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4174; i=matttbe@kernel.org; h=from:subject; bh=LoOhskoq0xdMO+vDO6MdulkGC6tGrI29NGXdO4lliZc=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmuiqrOKwznQwNBbvJCFhESuz1uefqj0B4m3C82 cLtBiuHlcWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZroqqwAKCRD2t4JPQmmg cwKFD/9oXoIVHHdPxXeUkyjZxLPyDxCz9NsAmdVh2lgtA1mlNQLddZK+bIIynGl6anROPrT861B MtGYz3+vzQo/UwTlPeWPkWutZ/88C5B+5mb5qPZq09kHykFGA28TywLJYfBG+g+c6GJHEhHVHJs LEPYseoBVcuHnvUrqmTwGXesvzAAQqtxy2w2c0ykOC/pyhrGROwhH0pfjehCoORTgE2GDkhtU/J 5xVkLMzKubNdIL9NU8Dn/edRYmFXWv8j5wfZevyVweKeYy3Vst8r0OJFtw/MykThzoB/veeDCvz i1bhedPQkIusCvfQb1xEhM6b1jZdvDd8BlZxz6MY2l/1wM35MAFqipcrqDVxt+lPpTMYHYssWI6 XJcOtrOdjveiWkGQ3sHPgPwA/k1gjVOJyquee4p18klBuXt1v/Np01X35rJP9RxBhdy8px4/rho RTsYB9q8TU+ryJ5zxggH3gS78/bQpWaML5hTKjT4Vc1HEW5uvAn/c6qVz/XNeEqvX7Hfm3ARKIY 1I/nDVq7zRjvKY3vnkCE130dnhDIzsjDAPcT4E8W9+ybicFp9ZvQ4gxquQYIV9bb+r0hX6jokdG 6mk3I5CHjRMd09CtOHdPYUvJYtBzx3KbAx5DFnTMALtnowU4eCQwtpMOqLko6q0nW3JjZV4Pth9 iYrWb7De7NmmnJw==
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
index 83210485cde8..2c49182c674f 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -520,8 +520,8 @@ __lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info,
 
 static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 {
+	struct mptcp_pm_addr_entry *local, *signal_and_subflow = NULL;
 	struct sock *sk = (struct sock *)msk;
-	struct mptcp_pm_addr_entry *local;
 	unsigned int add_addr_signal_max;
 	unsigned int local_addr_max;
 	struct pm_nl_pernet *pernet;
@@ -587,6 +587,9 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		msk->pm.add_addr_signaled++;
 		mptcp_pm_announce_addr(msk, &local->addr, false);
 		mptcp_pm_nl_addr_send_ack(msk);
+
+		if (local->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)
+			signal_and_subflow = local;
 	}
 
 subflow:
@@ -597,9 +600,14 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
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


