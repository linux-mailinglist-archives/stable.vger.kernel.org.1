Return-Path: <stable+bounces-73740-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DDB96EE3C
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 10:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE7C41F21668
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 08:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD48156887;
	Fri,  6 Sep 2024 08:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YFkFEGEX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3F215624B;
	Fri,  6 Sep 2024 08:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725611678; cv=none; b=WtdvaRvo6I7Lh5r841evrXboXbayZW/iWsQcE3+VB0nW/nBhGtJHQ9UWLujk6YfpSSVkfeoO3ToIoZmn86swXayhl5j/x/Cc86Ki9R6hqNtr7xqrNwarqQ77yBMiVlD0Vqhzu0Sdu14fAhqW35RmPfuqqW13yRm7x9a3IykAACo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725611678; c=relaxed/simple;
	bh=s/Xv7q6XNItc09lxfIK3s3Le4fRYrTsy98Ci6oeqlEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hjRBxoVq8N1oW/W1okwhJ7chnLKB1hK3/oYFdIB6YSUwqGHiRDmZGPYyqRZqQMUXk4qg1y0Y5DGKJKz+z+MnsHzBUe1FMEpzOlOg2cwR9aXLPnoeBnpMX3OO53SiZBAlmBCCsPGIisJQYo7LRlWcegm1Nhjd3G2uMG4p34dXUy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YFkFEGEX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA1C4C4CEC4;
	Fri,  6 Sep 2024 08:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725611678;
	bh=s/Xv7q6XNItc09lxfIK3s3Le4fRYrTsy98Ci6oeqlEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YFkFEGEXa7n7lQtalwgMZEI5g1O6y8JLTS6XTID4KoIrrnc7rrLPiTWYd3XVOByBR
	 LW31SU/yhr7fiWHQjstMbU213omQnQpMwL4IzrMvY6CXbTYTcXbjKPaUHOqU0K5k1o
	 r9e4ByvC18XQew2eXDfufVeOQ2Agj+wUZNuZn16O0+OyU+iSramDaVfN6s6LhxXaD9
	 UATR+Mm4qCjjmd59BwnZJ0T2FKhrbuJxC4Jo3Cs+gDzWLZ9Gf33GooX/5TWhv01i86
	 N4FC/NW3e3oHIAGAD7VbVj0t7knzpetIJLYayrXSH86RGwOjGeqJAmkX1hfcjHYaMJ
	 UP+ckp2pNdbbQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	=?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	Mat Martineau <martineau@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 5.15.y] mptcp: avoid duplicated SUB_CLOSED events
Date: Fri,  6 Sep 2024 10:34:31 +0200
Message-ID: <20240906083430.1772159-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024083029-shrank-thirstily-a532@gregkh>
References: <2024083029-shrank-thirstily-a532@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3534; i=matttbe@kernel.org; h=from:subject; bh=s/Xv7q6XNItc09lxfIK3s3Le4fRYrTsy98Ci6oeqlEY=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm2r6WSGy9cI9YcOOX64cWMAQ1LpYeRTaoA84DA +RkI3umyoKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtq+lgAKCRD2t4JPQmmg czcLEACosPRuCLwMen3XCrMUtyy9M5Yyo6wjQoMPexl/Bi/r9BOutYERCQaseidD3RsqxNrsiVb 1CReEZjUu4fgaB6nwMkGPQGHt3Uhz1J0yzZkubZueziciF6AGAtGHF1RD4OohIKsdsGHm7jmB57 J9qCLTqUIRE8CkurJWmVgBH/CmKMDMTKko8k++ZYQIzCtRvJNSGOl/fQiAvsC/9SGU5mAt8n6xF BapG7jZZyx6pv9I0tc8CttZuDxdmWsYfaBkI9U66yXbY1PTvO8jNq89yaC9NYkuSb5ohQaWjuRO NQ4lN0Qv/FcIXXgP1V2EiywFafCN5hTkIsXjNtPisTcWj24hSwFeWFTqP6ZMaYL8GjN+5Mc/CMf 0Exl+CpKdzsNfvMgHiouHSiAF3BUY1xN6mOzvLd+5M3mW61DHxDpVXynVtTr2LzpP3r9FUbiMpk o15nWI4KddA+ZnjdAqLGJ5jIscLPrK5WgPVIIvwUf4Cgi5vEw4skaTK5dE1d5Q8qkOVjmW5RQie 30Hoi6QNyw7war5kyjmc3fByQF3Yjo/2kMv/1yJ8u8Cjnxaw5YeTTOpm8MoSrHo+sfdB3vDhmCL hm2Enq4V2KGfm53odKPUfDR70H/RHAgdPPtfhSTtiVf2rahqUdQzNKZc82VaWvaHBlPljhj+Nqv s+kjCNJ73iKF0DQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit d82809b6c5f2676b382f77a5cbeb1a5d91ed2235 upstream.

The initial subflow might have already been closed, but still in the
connection list. When the worker is instructed to close the subflows
that have been marked as closed, it might then try to close the initial
subflow again.

 A consequence of that is that the SUB_CLOSED event can be seen twice:

  # ip mptcp endpoint
  1.1.1.1 id 1 subflow dev eth0
  2.2.2.2 id 2 subflow dev eth1

  # ip mptcp monitor &
  [         CREATED] remid=0 locid=0 saddr4=1.1.1.1 daddr4=9.9.9.9
  [     ESTABLISHED] remid=0 locid=0 saddr4=1.1.1.1 daddr4=9.9.9.9
  [  SF_ESTABLISHED] remid=0 locid=2 saddr4=2.2.2.2 daddr4=9.9.9.9

  # ip mptcp endpoint delete id 1
  [       SF_CLOSED] remid=0 locid=0 saddr4=1.1.1.1 daddr4=9.9.9.9
  [       SF_CLOSED] remid=0 locid=0 saddr4=1.1.1.1 daddr4=9.9.9.9

The first one is coming from mptcp_pm_nl_rm_subflow_received(), and the
second one from __mptcp_close_subflow().

To avoid doing the post-closed processing twice, the subflow is now
marked as closed the first time.

Note that it is not enough to check if we are dealing with the first
subflow and check its sk_state: the subflow might have been reset or
closed before calling mptcp_close_ssk().

Fixes: b911c97c7dc7 ("mptcp: add netlink event support")
Cc: stable@vger.kernel.org
Tested-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ Conflict in protocol.h due to commit f1f26512a9bf ("mptcp: use plain
  bool instead of custom binary enum"), commit dfc8d0603033 ("mptcp:
  implement delayed seq generation for passive fastopen") and more that
  are not in this version, because they modify the context and the size
  of __unused. The conflict is easy to resolve, by not only adding the
  new field (close_event_done), and __unused. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 6 ++++++
 net/mptcp/protocol.h | 4 +++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 938ca99cc850..5afd49bf4750 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2337,6 +2337,12 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		     struct mptcp_subflow_context *subflow)
 {
+	/* The first subflow can already be closed and still in the list */
+	if (subflow->close_event_done)
+		return;
+
+	subflow->close_event_done = true;
+
 	if (sk->sk_state == TCP_ESTABLISHED)
 		mptcp_event(MPTCP_EVENT_SUB_CLOSED, mptcp_sk(sk), ssk, GFP_KERNEL);
 	__mptcp_close_ssk(sk, ssk, subflow);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3f3e0b8bc62e..d940a059a8f3 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -441,7 +441,9 @@ struct mptcp_subflow_context {
 		can_ack : 1,        /* only after processing the remote a key */
 		disposable : 1,	    /* ctx can be free at ulp release time */
 		stale : 1,	    /* unable to snd/rcv data, do not use for xmit */
-		valid_csum_seen : 1;        /* at least one csum validated */
+		valid_csum_seen : 1,        /* at least one csum validated */
+		close_event_done : 1,       /* has done the post-closed part */
+		__unused : 11;
 	enum mptcp_data_avail data_avail;
 	u32	remote_nonce;
 	u64	thmac;
-- 
2.45.2


