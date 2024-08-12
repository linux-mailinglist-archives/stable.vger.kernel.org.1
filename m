Return-Path: <stable+bounces-66752-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF8994F1C3
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 17:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBC5B1F24DEC
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 15:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB941862B8;
	Mon, 12 Aug 2024 15:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQMfP4zc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C742F186295;
	Mon, 12 Aug 2024 15:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723476661; cv=none; b=tOFew2LT1NIr6MWoltwcDRYk0CJhopScwcsPRQQyHxXUY9Beg3U5zQw9fM8tst+cYCpXwEJ4Ijzh2b2jU1Lqxa61zEHfuHclMMH0DiM6jzc7OglAF+ZQ7/HF4mnDZDHmUdbCc7CVLZN3UavVK7waWvO/DdGE9YBmqOVqsuf1Fj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723476661; c=relaxed/simple;
	bh=nfACMYravBEwOVrjontM2SAeSGBYziSMJqXyS0SQw+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DDPbc3pbeK1HzS2N7TBszMrzJmSyiyNXOM0GKbwJW+usDSBKtbwwhk2jziPEB/R6j+r0EcIM6w2dobulZOKX57gWM+sTMwrcQQK0KeBazhvYTjPSWObAw6OIAn4JVcAeYnkyonu/MrHkconXNWZctgKVdGVuwQ3JcsCDgUYZOlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQMfP4zc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5DE3C32782;
	Mon, 12 Aug 2024 15:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723476661;
	bh=nfACMYravBEwOVrjontM2SAeSGBYziSMJqXyS0SQw+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EQMfP4zcUF3e4nYPkp7ZPCoRrz7+o14p177ktB1mM7N2Zk0WwvDfKiyiZ7dk/Q/oy
	 tm0JORdZeDEq82A2S3PFKYZN2A+7YvgOnW2sG63csZPl0rDmwZRkAbMIzDy2Uqth1K
	 W5UC6WZtB1bqVjZxkqqxU7GTUB2kG03T+2v0Cd1g3g8cLevSvwseMIZ8DdrH3Yl6VQ
	 wWADWSG/ettBIaoA8ut49EvHjHIRqapii8t3TtvP+Zaq68YtkMZphRjsNDIoys8RgW
	 Zui1g9lkLQZrXZ8B/E1AmTyZiLdwMkV7sabxD1atZy7k/mb65BxoAHWSJLlHk7rKO1
	 IK9llgcaRaPAQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6.y 2/5] mptcp: pm: don't try to create sf if alloc failed
Date: Mon, 12 Aug 2024 17:30:53 +0200
Message-ID: <20240812153050.573404-9-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024081244-uncertain-snarl-e4f6@gregkh>
References: <2024081244-uncertain-snarl-e4f6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2526; i=matttbe@kernel.org; h=from:subject; bh=nfACMYravBEwOVrjontM2SAeSGBYziSMJqXyS0SQw+A=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmuiqrF/SM8OkxFmEYbBmQ1soqRnoG43Il2iTGu KArpfEoucKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZroqqwAKCRD2t4JPQmmg c61HEACt/JbHtMv6WWbQIHzhw1U56I9BZjimJFeb2HCyZPRMaXXo/2h1ER36Zq35IqY03WloPlw mEg23tveCf0BxxvJcG6ZguUb0IT/XDxVdehf5Hfd1m/i72AclG73ueDoCg0wx8gLLXaGNAoIarJ B1Xrp8p98+vlHjRHepsEy7nsLhdyrGhEqodu7uaa9p9nmxN6ZmRsFpY4LfxyeHwkHDBif/VrGi/ PYlwnBGtdNsRsGQ8HsN5S8fIM/ObRolZiNa9DxUD+6qmvZSWiBbpztnm9wZ5SXzuz21IW0Mfs6e qObwRO+KZYWDXwYb9n3bC/qcXLewmRVipe4g1z6ADu5dIIh8FoEOQ1raXRcfGtcMnGm0bz7ETfw nC3/oeCSl98dwznTwaemt7CfOhXQNXERUGBIZDeINfcuRR7tzN+dzZehEygZTmTl3bObx1bKCgl c+Sj8Y2NJDRvheG730QXplFPehLFz0tjo8MZgvWhqkhttTqQ4zlmhhmIIjiypYcZXvfIGjZflL+ yHQcnBdfKQjIP3qShIwBZS2ZtYDh41tjkY+aEsazwq7zY5JYZNNhLspjgG7h+MsI7fSP1tzCNUb tIKULePh6aqoo5JZ5zIdBTL715zqVwhWp61QA0zCT1kM8TuGNzOvRHptZ+kCJZ6ZWQxT/VOGSIo pmgNc0hzDl1r8fA==
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
index 6d5c75a40bc6..83210485cde8 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -353,7 +353,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 	add_entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
 
 	if (add_entry) {
-		if (mptcp_pm_is_kernel(msk))
+		if (WARN_ON_ONCE(mptcp_pm_is_kernel(msk)))
 			return false;
 
 		sk_reset_timer(sk, &add_entry->add_timer,
@@ -563,8 +563,6 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 	/* check first for announce */
 	if (msk->pm.add_addr_signaled < add_addr_signal_max) {
-		local = select_signal_address(pernet, msk);
-
 		/* due to racing events on both ends we can reach here while
 		 * previous add address is still running: if we invoke now
 		 * mptcp_pm_announce_addr(), that will fail and the
@@ -575,11 +573,15 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
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


