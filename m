Return-Path: <stable+bounces-196920-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 431FCC85D7F
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 16:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 186E634FD06
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 15:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476E81CAA6C;
	Tue, 25 Nov 2025 15:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CqKoTVR6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077A233EC
	for <stable@vger.kernel.org>; Tue, 25 Nov 2025 15:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764086072; cv=none; b=tEP9rCen64f27UBTVaRdN+x/WNruvy6G62BkJuu1OevBxAP/dueBJ6a0aJikMi6zf3XAomRR+IdV0Vo/eXIbvycepB0OI03P4fICorVxADMiMKZNpWE2WSkv+U0vjg2uXqlg/f6gd672gmiQ3TS31gIfrmRYoFNWNVu+FdrAYPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764086072; c=relaxed/simple;
	bh=AwRGPTfDdIKnMP6YBZU4dzQMQ9mLsyJiU+5Ro5bzW+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sSVZLl0Qbt9QEUWfik7cZbUr/kLd0JXvHed7i3WaCyvTtuvTfIPDk5+im1Lb3UwhrK6ndPAtPV5LTNuXXCVsfPFUefD3hByDdSESrYJpYwdbTFTYuDSsuLcxd+660cEsNW9aXRVyaXxpk9jHB+8LRZ/LQudZAAgkcu64TbKPxq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CqKoTVR6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B8DC4CEF1;
	Tue, 25 Nov 2025 15:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764086071;
	bh=AwRGPTfDdIKnMP6YBZU4dzQMQ9mLsyJiU+5Ro5bzW+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CqKoTVR6fmNbGZ+VRm/YBoiH4DNyOL+aPyNG6/lgNVe37qAuGQCnP2p14nJC4UOEv
	 M5AzPL6VZCTOHlsLrpD4m2kPhmqQpaflpo7sMwo1qbrifByP7LyiZApe908CSwoRzm
	 znj4KRvWEJS/UmOjoTYYt9PDxFM+EtcT/4RfIIC9i8NqXyUgRgniu/cwmauGJ869zv
	 3h4evRZRaU/eAzp5OADMCUjppQtq1Z9ix7NnizHGIGDQ6/HGzMFn6XE7l2Ob51r2jO
	 LizrjBPvM+XmVOWBOAKLZt3wkyWUEF5ZwE3ca72RyQOC33pF5eXSuDNJSvtFCVwYNP
	 70qxqUpItsVhA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	Geliang Tang <geliang@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mptcp: decouple mptcp fastclose from tcp close
Date: Tue, 25 Nov 2025 10:54:29 -0500
Message-ID: <20251125155429.693062-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112412-trough-caloric-1503@gregkh>
References: <2025112412-trough-caloric-1503@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit fff0c87996672816a84c3386797a5e69751c5888 ]

With the current fastclose implementation, the mptcp_do_fastclose()
helper is in charge of two distinct actions: send the fastclose reset
and cleanup the subflows.

Formally decouple the two steps, ensuring that mptcp explicitly closes
all the subflows after the mentioned helper.

This will make the upcoming fix simpler, and allows dropping the 2nd
argument from mptcp_destroy_common(). The Fixes tag is then the same as
in the next commit to help with the backports.

Fixes: d21f83485518 ("mptcp: use fastclose on more edge scenarios")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Geliang Tang <geliang@kernel.org>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20251118-net-mptcp-misc-fixes-6-18-rc6-v1-5-806d3781c95f@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/protocol.c | 13 +++++++++----
 net/mptcp/protocol.h |  2 +-
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ea715a1282425..a4d2dd2bc9eac 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2810,8 +2810,12 @@ static void mptcp_worker(struct work_struct *work)
 		__mptcp_close_subflow(sk);
 
 	if (mptcp_close_tout_expired(sk)) {
+		struct mptcp_subflow_context *subflow, *tmp;
+
 		inet_sk_state_store(sk, TCP_CLOSE);
 		mptcp_do_fastclose(sk);
+		mptcp_for_each_subflow_safe(msk, subflow, tmp)
+			__mptcp_close_ssk(sk, subflow->tcp_sock, subflow, 0);
 		mptcp_close_wake_up(sk);
 	}
 
@@ -3217,7 +3221,8 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	/* msk->subflow is still intact, the following will not free the first
 	 * subflow
 	 */
-	mptcp_destroy_common(msk, MPTCP_CF_FASTCLOSE);
+	mptcp_do_fastclose(sk);
+	mptcp_destroy_common(msk);
 	msk->last_snd = NULL;
 
 	/* The first subflow is already in TCP_CLOSE status, the following
@@ -3440,7 +3445,7 @@ static struct sock *mptcp_accept(struct sock *sk, int flags, int *err,
 	return newsk;
 }
 
-void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags)
+void mptcp_destroy_common(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow, *tmp;
 	struct sock *sk = (struct sock *)msk;
@@ -3449,7 +3454,7 @@ void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags)
 
 	/* join list will be eventually flushed (with rst) at sock lock release time */
 	mptcp_for_each_subflow_safe(msk, subflow, tmp)
-		__mptcp_close_ssk(sk, mptcp_subflow_tcp_sock(subflow), subflow, flags);
+		__mptcp_close_ssk(sk, mptcp_subflow_tcp_sock(subflow), subflow, 0);
 
 	/* move to sk_receive_queue, sk_stream_kill_queues will purge it */
 	mptcp_data_lock(sk);
@@ -3476,7 +3481,7 @@ static void mptcp_destroy(struct sock *sk)
 
 	/* allow the following to close even the initial subflow */
 	msk->free_first = 1;
-	mptcp_destroy_common(msk, 0);
+	mptcp_destroy_common(msk);
 	sk_sockets_allocated_dec(sk);
 }
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 81507419c465e..fc84c9a3f0a35 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -761,7 +761,7 @@ static inline void mptcp_write_space(struct sock *sk)
 	}
 }
 
-void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags);
+void mptcp_destroy_common(struct mptcp_sock *msk);
 
 #define MPTCP_TOKEN_MAX_RETRIES	4
 
-- 
2.51.0


