Return-Path: <stable+bounces-95114-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 701569D7367
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 352F3283673
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474EF228370;
	Sun, 24 Nov 2024 13:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZRrLLH1M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F349F228369;
	Sun, 24 Nov 2024 13:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456059; cv=none; b=H5IzKsCUblAipdFY9R1ST9TN7ffP/v8NQSSPuSQR8DnHG0g6EdL5il/yaUuqC+m1qR0rGS6/tyDgeJJxco7chkcPA97HGUOV0rrsvSuo0lvDX50t6qYnc/q1Q+uTR7Vj6zUlFL9gNfoPlKHhkef4EosaUb354dOvDTsvzh2ZvXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456059; c=relaxed/simple;
	bh=EiUnMsAYYWhG+UbW1hF/ADVOUWcobG1nkR1NnCL4Gas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UJ8EUSIhnKDjYLVZh2QkBrOmLYc6TecUdx3hP3yUis/lHi0KNIVB1uHhqOo5p1Yb9hf55g/tUqcDJpYfgJ6UAAHQG6fwUEPjUs+seb0LRmtGmP5IKzL/uHiqRWcI+ceDnOXgOcX1Osu15tSQnBF0q+JLuMKl+XlK5UKyMZNMpz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZRrLLH1M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B9DC4CECC;
	Sun, 24 Nov 2024 13:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456058;
	bh=EiUnMsAYYWhG+UbW1hF/ADVOUWcobG1nkR1NnCL4Gas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZRrLLH1M4Q1IM6CUdMCiYk8qAK+Zd/42RYtFF6WlpdYIcx++gEpYS/aWqxlJ30ll2
	 QVabmjA7vzoatm84PLThQxC1d1D5nEmwjI4QC2u+cgeZaiHjqm/tme2BEfjwAsdtc9
	 E4TRg/iBaMQcXIRGqexxXA9vqfK90ByAWlxxMeGQOpQYOmE87y+QHBC2qf/t5CoiOO
	 qDfp74UI9yiw8a1kbEPxF7Ohgk4oEJcCTfhx3cK6qGUJaJYxOMkYudeE2MZPyG3sFw
	 RMsWKgZMbtg88sW9FRhbAP4PZZ/aiccdxFo1yy/artfBu0Bu4igeSYK1W+igTcgiC1
	 0Pd4NXWpRwbWg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ignat Korchagin <ignat@cloudflare.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	dsahern@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 24/61] net: inet: do not leave a dangling sk pointer in inet_create()
Date: Sun, 24 Nov 2024 08:44:59 -0500
Message-ID: <20241124134637.3346391-24-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134637.3346391-1-sashal@kernel.org>
References: <20241124134637.3346391-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
Content-Transfer-Encoding: 8bit

From: Ignat Korchagin <ignat@cloudflare.com>

[ Upstream commit 9365fa510c6f82e3aa550a09d0c5c6b44dbc78ff ]

sock_init_data() attaches the allocated sk object to the provided sock
object. If inet_create() fails later, the sk object is freed, but the
sock object retains the dangling pointer, which may create use-after-free
later.

Clear the sk pointer in the sock object on error.

Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20241014153808.51894-7-ignat@cloudflare.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/af_inet.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 3feff7f738a48..f336b2ddf9724 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -375,32 +375,30 @@ static int inet_create(struct net *net, struct socket *sock, int protocol,
 		inet->inet_sport = htons(inet->inet_num);
 		/* Add to protocol hash chains. */
 		err = sk->sk_prot->hash(sk);
-		if (err) {
-			sk_common_release(sk);
-			goto out;
-		}
+		if (err)
+			goto out_sk_release;
 	}
 
 	if (sk->sk_prot->init) {
 		err = sk->sk_prot->init(sk);
-		if (err) {
-			sk_common_release(sk);
-			goto out;
-		}
+		if (err)
+			goto out_sk_release;
 	}
 
 	if (!kern) {
 		err = BPF_CGROUP_RUN_PROG_INET_SOCK(sk);
-		if (err) {
-			sk_common_release(sk);
-			goto out;
-		}
+		if (err)
+			goto out_sk_release;
 	}
 out:
 	return err;
 out_rcu_unlock:
 	rcu_read_unlock();
 	goto out;
+out_sk_release:
+	sk_common_release(sk);
+	sock->sk = NULL;
+	goto out;
 }
 
 
-- 
2.43.0


