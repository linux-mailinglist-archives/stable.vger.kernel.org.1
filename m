Return-Path: <stable+bounces-124479-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 259B6A62140
	for <lists+stable@lfdr.de>; Sat, 15 Mar 2025 00:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A90193BC695
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 23:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220CF1A23B7;
	Fri, 14 Mar 2025 23:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxEqPFq6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EBF15D5C4
	for <stable@vger.kernel.org>; Fri, 14 Mar 2025 23:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741993810; cv=none; b=YkFgzu0YPv3z111/6rRWX7Gc1MQEsrYFK5GZT9vQMd+FvQKpLGtJIRRgu16qdWSBYA6qgm5uW7RXYgJNlWFKYuZeSIKBYHNlarYSQXr+OIGDJ5cwpvlXki6dJRwg11tP1Ktey7IXv//YqNTnMiCMjzhZ53RQ6/QREaS26WubLgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741993810; c=relaxed/simple;
	bh=w3RqoW+BE4TOePOyTUCyk4WBuhMqo3OkJHHVrdbuTb8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CLMn0usJuH956HikL9qPookOSMbqPF0R232xnIbXyKJMkwrhd14cuRb74h10YgEHTNMzYgseidEWncgLcWt85t6ppmh9TPVcfKg3IFw6UInnyBwxHJqXmthBNaZb1OzbzVgWsnMfiqfP0N8EZ/jAyiyGNWia9yVkJxbvSMYJSsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JxEqPFq6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A55C4CEE3;
	Fri, 14 Mar 2025 23:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741993810;
	bh=w3RqoW+BE4TOePOyTUCyk4WBuhMqo3OkJHHVrdbuTb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JxEqPFq6DbRH/Fz25Ae3MqG6knCjY5325P/pUMchPLaeUktPQJPpyLZjfSIzBn06R
	 jaf3H2KW6c5Key3hx6CBUynrvZHv9Ub0jeNs/jxv8yyBRTa2VOVFtlB9mdG+FuJRGe
	 bSvoZWcbITJJhjJBKrBFoZwcAbc75j1dnYf+bPyjZ6WjhJc4+wf+AVRJWV5nE/HiHm
	 x4aiGyZkKJ7+CfBaQGBxc89zi0X8Flvz6Qii2ymo37p/9dcutd9OnZes4C3m8zs174
	 863xscpIjbzubXay2t56FVQKifkZDdPn0ESTS3el6VfETIOQprggExTAkuWSHozrHy
	 /3R6clceSmEPA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	youngmin.nam@samsung.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 1/2] tcp: fix races in tcp_abort()
Date: Fri, 14 Mar 2025 19:10:08 -0400
Message-Id: <20250314121501-9fdf46a34dedcb9e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250314092446.852230-1-youngmin.nam@samsung.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Summary of potential issues:
❌ Build failures detected

The upstream commit SHA1 provided is correct: 5ce4645c23cf5f048eb8e9ce49e514bababdee85

WARNING: Author mismatch between patch and upstream commit:
Backport author: Youngmin Nam<youngmin.nam@samsung.com>
Commit author: Eric Dumazet<edumazet@google.com>

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly.
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.13.y       |  Failed     |  N/A       |
| stable/linux-6.12.y       |  Failed     |  N/A       |
| stable/linux-6.6.y        |  Success    |  Success   |
| stable/linux-6.1.y        |  Success    |  Success   |
| stable/linux-5.15.y       |  Success    |  Success   |
| stable/linux-5.10.y       |  Failed     |  N/A       |
| stable/linux-5.4.y        |  Failed     |  N/A       |

Build Errors:
Patch failed to apply on stable/linux-6.13.y. Reject:

diff a/net/ipv4/tcp.c b/net/ipv4/tcp.c	(rejected hunks)
@@ -4630,13 +4630,9 @@ int tcp_abort(struct sock *sk, int err)
 	bh_lock_sock(sk);
 
 	if (!sock_flag(sk, SOCK_DEAD)) {
-		WRITE_ONCE(sk->sk_err, err);
-		/* This barrier is coupled with smp_rmb() in tcp_poll() */
-		smp_wmb();
-		sk_error_report(sk);
 		if (tcp_need_reset(sk->sk_state))
 			tcp_send_active_reset(sk, GFP_ATOMIC);
-		tcp_done(sk);
+		tcp_done_with_error(sk, err);
 	}
 
 	bh_unlock_sock(sk);
Patch failed to apply on stable/linux-6.12.y. Reject:

diff a/net/ipv4/tcp.c b/net/ipv4/tcp.c	(rejected hunks)
@@ -4630,13 +4630,9 @@ int tcp_abort(struct sock *sk, int err)
 	bh_lock_sock(sk);
 
 	if (!sock_flag(sk, SOCK_DEAD)) {
-		WRITE_ONCE(sk->sk_err, err);
-		/* This barrier is coupled with smp_rmb() in tcp_poll() */
-		smp_wmb();
-		sk_error_report(sk);
 		if (tcp_need_reset(sk->sk_state))
 			tcp_send_active_reset(sk, GFP_ATOMIC);
-		tcp_done(sk);
+		tcp_done_with_error(sk, err);
 	}
 
 	bh_unlock_sock(sk);
Patch failed to apply on stable/linux-5.10.y. Reject:

diff a/net/ipv4/tcp.c b/net/ipv4/tcp.c	(rejected hunks)
@@ -4630,13 +4630,9 @@ int tcp_abort(struct sock *sk, int err)
 	bh_lock_sock(sk);
 
 	if (!sock_flag(sk, SOCK_DEAD)) {
-		WRITE_ONCE(sk->sk_err, err);
-		/* This barrier is coupled with smp_rmb() in tcp_poll() */
-		smp_wmb();
-		sk_error_report(sk);
 		if (tcp_need_reset(sk->sk_state))
 			tcp_send_active_reset(sk, GFP_ATOMIC);
-		tcp_done(sk);
+		tcp_done_with_error(sk, err);
 	}
 
 	bh_unlock_sock(sk);
Patch failed to apply on stable/linux-5.4.y. Reject:

diff a/net/ipv4/tcp.c b/net/ipv4/tcp.c	(rejected hunks)
@@ -4630,13 +4630,9 @@ int tcp_abort(struct sock *sk, int err)
 	bh_lock_sock(sk);
 
 	if (!sock_flag(sk, SOCK_DEAD)) {
-		WRITE_ONCE(sk->sk_err, err);
-		/* This barrier is coupled with smp_rmb() in tcp_poll() */
-		smp_wmb();
-		sk_error_report(sk);
 		if (tcp_need_reset(sk->sk_state))
 			tcp_send_active_reset(sk, GFP_ATOMIC);
-		tcp_done(sk);
+		tcp_done_with_error(sk, err);
 	}
 
 	bh_unlock_sock(sk);

