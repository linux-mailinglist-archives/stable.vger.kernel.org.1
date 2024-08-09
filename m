Return-Path: <stable+bounces-66127-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 994BE94CCE3
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 11:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14B22B20C99
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 09:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4305B18F2F2;
	Fri,  9 Aug 2024 09:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RM8IB8Lh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20F8BA41;
	Fri,  9 Aug 2024 09:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723194344; cv=none; b=jrO+zKDKsZkNKvQ48JYvimTGWjRkUBqibez5HkcFDo2cFAEuzSWt5nNWT8zj9GNvpZ/1MeoSOUUav7bSUuOnJimqrdcJ4pp8Dk92D0/tGh5cofm4ZSkuoWC8Tux7KkZUf7qI+KId7F36HPp80QsjvcHyli+pgc2NSYRY8QW1Nl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723194344; c=relaxed/simple;
	bh=sVoi3kpZdm1zbTGQuwjEjMgeSrQ4tpzPRbgKEz6KEIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CGPMuh1xCtBkSFlHtlmaDRCwg5+pR++lvc/cYwuSytzMdEMyqzh69M46h/3FpvVUKKo4TP8r+EgKsFnZqg3mStXjSNmWoN0NeaZ1rC9VBoHzM3aZEpX05IYFhgNy18qqb6qt5GcebYNx3XJdmV5Txi5WZD+m+mDKhMqWC3HsUpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RM8IB8Lh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 127C6C32782;
	Fri,  9 Aug 2024 09:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723194343;
	bh=sVoi3kpZdm1zbTGQuwjEjMgeSrQ4tpzPRbgKEz6KEIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RM8IB8LhyLlW8jzike6XvWg8OOw0zz9gyUCvVuyjfKQkfEjaGKVnvu+/bgQ+07AeU
	 meFk/o7J/ng2O4TxvSexHl3ByaufPbwm/v0qlpoYy5JCk0lVo0ak4f2b1hEzPoA9Ap
	 FUyImWa0SrBqbhFcZVdSO+o9OOQwWxjOABChvVuvsoOXOVP8XHW3BYecK9BpEy5uDy
	 GpGHtqR1oEIf9QgHAvZIs/b4ex4BD+guMvvepW6exFx6UMUFP/LLSw0noLF7vqmLoy
	 NIOkbMGa6n0ziH/5iUHIc/bmvv8ktP3RF4PNjVZFNj0UeikWBmWX56qLJKQt+a3JOq
	 ZSk4ZpHKxepgQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 5.15.y] mptcp: sched: check both directions for backup
Date: Fri,  9 Aug 2024 11:05:31 +0200
Message-ID: <20240809090530.2696742-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024080758-deniable-naming-ddc9@gregkh>
References: <2024080758-deniable-naming-ddc9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3237; i=matttbe@kernel.org; h=from:subject; bh=sVoi3kpZdm1zbTGQuwjEjMgeSrQ4tpzPRbgKEz6KEIY=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmtdvbpl0pu44GC2eJP/Q06uIFyDSa3HIzzJfVF dMU9S/QGpeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZrXb2wAKCRD2t4JPQmmg c29iEADox+7XY3pEDY0hO+HYNgjmodEHJNIh522U+BKBfxBJg+5OQe3AlOR6OwzPwWyift+f+vA 8d1MeqXDsOtMzc/pbXt0zIwCq6LdgZ6E6KuSf/Ip1FGLLWLAXqlZCrVzYRD7tZtNAh868rOfMdl Xb7yKColdQ/pMwg8EZRd+hZ4Ou1+xD/u5R2XL4UyEM4DN0/5tZvn9q4nCffopztFxEYjhVs99Jf sSn67E1UX5+hj5Hbbeyj98Tl4ZQfOKpsPFrmEcFXS6xKc7K9LqIBDdLID0M6oF9M6hq/HLcgXXm MUJH4LwWmy5mjAEqxX0ozHUF2cizkURVAgZnqhb5Qt8CXw+7brGTHovPOBqgQqtVSPH1VhXQR8p OccM8iGho2nBB3Mz0dh8gOa471OShEJz7JMFGX81NfZaRO7VKzcpnmyOFbeO1LiwzypFtpfTxB7 a4FSbNzqri2tH/mX8m6BAewM+0Dr8gXvFNFWU1oGdvbtSgyoATVRCN9YRO90x0W6Qg1vHj8ccIS 80pVmRc0LwvFF30tm515bcVhypob4NsjddUZp+a50GoOO76Kj8lnYx7B3nN0+bqpx4ZwAiOplRL c3i2G2Cbmc+DYmHhVy+lYzv6HS9b1XP65y3Oq00DE/WNmgWm+Rb/j3hXdpJyqgEpdHeDbnKyIj8 4n7L3joxQkpmBbQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit b6a66e521a2032f7fcba2af5a9bcbaeaa19b7ca3 upstream.

The 'mptcp_subflow_context' structure has two items related to the
backup flags:

 - 'backup': the subflow has been marked as backup by the other peer

 - 'request_bkup': the backup flag has been set by the host

Before this patch, the scheduler was only looking at the 'backup' flag.
That can make sense in some cases, but it looks like that's not what we
wanted for the general use, because either the path-manager was setting
both of them when sending an MP_PRIO, or the receiver was duplicating
the 'backup' flag in the subflow request.

Note that the use of these two flags in the path-manager are going to be
fixed in the next commits, but this change here is needed not to modify
the behaviour.

Fixes: f296234c98a8 ("mptcp: Add handling of incoming MP_JOIN requests")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ Conflicts in protocol.c, because the context has changed in commit
  3ce0852c86b9 ("mptcp: enforce HoL-blocking estimation"), which is not
  in this version. This commit is unrelated to this modification. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 include/trace/events/mptcp.h |  2 +-
 net/mptcp/protocol.c         | 10 ++++++----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
index 6bf43176f14c..df26c1dd3d8d 100644
--- a/include/trace/events/mptcp.h
+++ b/include/trace/events/mptcp.h
@@ -34,7 +34,7 @@ TRACE_EVENT(mptcp_subflow_get_send,
 		struct sock *ssk;
 
 		__entry->active = mptcp_subflow_active(subflow);
-		__entry->backup = subflow->backup;
+		__entry->backup = subflow->backup || subflow->request_bkup;
 
 		if (subflow->tcp_sock && sk_fullsock(subflow->tcp_sock))
 			__entry->free = sk_stream_memory_free(subflow->tcp_sock);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 081c8d00472d..b6b708dbfce9 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1514,13 +1514,15 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 		send_info[i].ratio = -1;
 	}
 	mptcp_for_each_subflow(msk, subflow) {
+		bool backup = subflow->backup || subflow->request_bkup;
+
 		trace_mptcp_subflow_get_send(subflow);
 		ssk =  mptcp_subflow_tcp_sock(subflow);
 		if (!mptcp_subflow_active(subflow))
 			continue;
 
 		tout = max(tout, mptcp_timeout_from_subflow(subflow));
-		nr_active += !subflow->backup;
+		nr_active += !backup;
 		if (!sk_stream_memory_free(subflow->tcp_sock) || !tcp_sk(ssk)->snd_wnd)
 			continue;
 
@@ -1530,9 +1532,9 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 
 		ratio = div_u64((u64)READ_ONCE(ssk->sk_wmem_queued) << 32,
 				pace);
-		if (ratio < send_info[subflow->backup].ratio) {
-			send_info[subflow->backup].ssk = ssk;
-			send_info[subflow->backup].ratio = ratio;
+		if (ratio < send_info[backup].ratio) {
+			send_info[backup].ssk = ssk;
+			send_info[backup].ratio = ratio;
 		}
 	}
 	__mptcp_set_timeout(sk, tout);
-- 
2.45.2


