Return-Path: <stable+bounces-94940-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5379D712B
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1496F282C8D
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896511D63E6;
	Sun, 24 Nov 2024 13:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4tG9t8R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B491D618C;
	Sun, 24 Nov 2024 13:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455328; cv=none; b=Q9KBq9X+yVOlJfFos66Ixr3tcd+S2n5/SmvGer8bqsqaW4jBXyV4hwiVEtFrHVUzwaHSPvkse+UUzMNvMYLxcug9UN/undifbd+8umjFIDuDMfBfcqC2/I+7VlBm8BuJOcRS8MfvTiOiKc0j6Gcdk3/QnXlWyDNgf6P3tObmgm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455328; c=relaxed/simple;
	bh=6AvXKilkxx9NwKtZt7nK5GeD+9xzUl/SgqY4EVdyi14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JpDV1lkYzhhqP782xBS/4GPPuPhVkjG/lIHhEiyK4QQT7VhOENlTZWIk0RKjXjOKTJBiYjJnsGLHUeaAas+dKeLNXFj9kVBmie9TT97Di0zZMQYlR2JUaFml5IX10P/eGFCuUBWbHcnV5BZbxEDADYQUaXofSGaAC8g+KWlXLYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4tG9t8R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C879C4CECC;
	Sun, 24 Nov 2024 13:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455327;
	bh=6AvXKilkxx9NwKtZt7nK5GeD+9xzUl/SgqY4EVdyi14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X4tG9t8RmEp6TW6fMo5Qq93RZdP2mJFvYbTCYsxLfBtsVp8v5x6kpCt72QrB5ScCv
	 R2SUXUWvve5jrU7FkKkvfIwJGvwjVzXXzxly0FMr2PKroCFRWB7NL9u3O36Udf83dK
	 2Mci316A9rLGOXAI9Ue90eHGW8IFUfAjUQP+8Ys+dG6AUOggLdEH6zR1YezaTpsthg
	 PdiWEBdvQk/K1O/kLN1frev94S7QFeMowSE3gXCe+MRM2WAWmuwWdd2gQ6cL5qgnsR
	 uN3yykIiGCJvf3DllzFY3sxwUVqJYG25UsVk3o/0O6mrs7GKeKQieFlZHujVw1+R0L
	 GEqAy4b4bncaQ==
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
Subject: [PATCH AUTOSEL 6.12 044/107] net: inet6: do not leave a dangling sk pointer in inet6_create()
Date: Sun, 24 Nov 2024 08:29:04 -0500
Message-ID: <20241124133301.3341829-44-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124133301.3341829-1-sashal@kernel.org>
References: <20241124133301.3341829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
Content-Transfer-Encoding: 8bit

From: Ignat Korchagin <ignat@cloudflare.com>

[ Upstream commit 9df99c395d0f55fb444ef39f4d6f194ca437d884 ]

sock_init_data() attaches the allocated sk pointer to the provided sock
object. If inet6_create() fails later, the sk object is released, but the
sock object retains the dangling sk pointer, which may cause use-after-free
later.

Clear the sock sk pointer on error.

Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20241014153808.51894-8-ignat@cloudflare.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/af_inet6.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index ba69b86f1c7d5..f60ec8b0f8ea4 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -252,31 +252,29 @@ static int inet6_create(struct net *net, struct socket *sock, int protocol,
 		 */
 		inet->inet_sport = htons(inet->inet_num);
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
 
 static int __inet6_bind(struct sock *sk, struct sockaddr *uaddr, int addr_len,
-- 
2.43.0


