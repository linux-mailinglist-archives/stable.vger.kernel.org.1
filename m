Return-Path: <stable+bounces-95250-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59AD59D775B
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 19:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1409CB80944
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415E1243404;
	Sun, 24 Nov 2024 13:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhCHubxz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65452429F2;
	Sun, 24 Nov 2024 13:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456479; cv=none; b=iV1vDvqOlRkt+Utp0Dm7aGA3TrIF2ORQRW4GnseYVRmpTlqKapJuhF/qAabOJ5ZxXOI4uIbeKx13C4klW9EpiTK3M9wFEl8R0qMJHfRaIRR0kdg3x5iDAAY/gJp4pXblxJOdYOvey1Inh80n8VPKg+r6Y/KGhw1c57+SA77/zOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456479; c=relaxed/simple;
	bh=09RO+i5P915v4Jzvzgp5M9tJXWCbQ5DycbawjKltiOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=svu6XBoZ7KJKE4eV9RejZ5pd3sdvF0zj/tj9Q3fp9mDOFK2+LBSK8GBWJXV0B7tk44gRBxd/7lNDkXeUd8EhYpnBhfrAanwQBiQ3cdhTvb3fff0sQhPJ1Uy5Uh5Txu3UUNMsnjAAz4lwix7CM10sQU41gG0IP5gKtv07DgMEGo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhCHubxz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D041C4CED1;
	Sun, 24 Nov 2024 13:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456478;
	bh=09RO+i5P915v4Jzvzgp5M9tJXWCbQ5DycbawjKltiOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mhCHubxzTlW90Depkw7yBc9sFH8EyaYQhu03qoBa7ig+/ZjCmllrcfE7YiFsa4dYx
	 ih4hFo963Gmpvug/IAk6nNhgjS+h8O4E9XO7sshq7WZzJjEvJ7Lp5xS/hce1K0xerF
	 MHUffGThy00pLX4rxJVfMb/MmEwvMfdjl+lGoLNAcTKeCvtLNP3DsFd/QGrA4h/LpG
	 1sXPZwMH8aJbbZa1ur1UJE14FBTKKRBcaPKkresFGUEJEz8OxC7lK8JsJhGibMJISV
	 1xBvhN98gDVAHaNRv5PVRQl20Yr73XFspMK2tFQZrOUjBbQTsxV01BZcXo1rN8NqUK
	 lkrRlB2fHHkrw==
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
Subject: [PATCH AUTOSEL 5.10 15/33] net: inet6: do not leave a dangling sk pointer in inet6_create()
Date: Sun, 24 Nov 2024 08:53:27 -0500
Message-ID: <20241124135410.3349976-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135410.3349976-1-sashal@kernel.org>
References: <20241124135410.3349976-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.230
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
index 32da2b66fa2fb..5fd203ddc0757 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -257,31 +257,29 @@ static int inet6_create(struct net *net, struct socket *sock, int protocol,
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


