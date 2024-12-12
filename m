Return-Path: <stable+bounces-103872-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A229EF976
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7634328DB8E
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1B1221D93;
	Thu, 12 Dec 2024 17:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wB8fo0zt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF7B2080D9;
	Thu, 12 Dec 2024 17:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734025854; cv=none; b=f0kRhMwDH87B0ym3zIERGj0pvDFPnVrrrhNy3YcNMikvAq1bHxeFmy7eKDaTh9+0azzMHDKzT5XaxC1aGHZVnPrzrBcLhAvAC38Pz726Y1Ry9vAMf71cWzF4maOnCe+JQqtTweSgPKOW+8vgjDKNrGypyCw2Wpx3Q0LKWL06yR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734025854; c=relaxed/simple;
	bh=0EjkziOBjv7zo/rbU7Lupu/s0ti0JLlAWvZEqU4T0rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U4jf4CYh45bE0CMurkf6AqMVDk2Ds7zHRv7dtGmD4ZTIUoDsbwmiMM3ezuVdYwRu7l2Wjyyffla0pOxZhlkEBeYio/jH2CaF4vYL9w3wr8obZvKOeNHJh9EiO6LhxAfIFS/gJlKu0AE+07vXmOMahBorIQUxU0e27aamkH1vsmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wB8fo0zt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94BEDC4CECE;
	Thu, 12 Dec 2024 17:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734025854;
	bh=0EjkziOBjv7zo/rbU7Lupu/s0ti0JLlAWvZEqU4T0rw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wB8fo0ztW7C5BOBCj0f3kYirqZSqruGoMqoOjH8m4q3tPwRZy/ylFoTU+M8YW/izY
	 g/3Z7im/S/qDDa2f78bBw82BZlIy6mh3huQvoH6kJ73jI1WwxWKb2kvVfqJPYWJPM3
	 QMWfvHMwoKLCerZkMqTYqX7eu/41z+4I5C+EgsR0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ignat Korchagin <ignat@cloudflare.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 279/321] net: inet6: do not leave a dangling sk pointer in inet6_create()
Date: Thu, 12 Dec 2024 16:03:17 +0100
Message-ID: <20241212144241.001726403@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144229.291682835@linuxfoundation.org>
References: <20241212144229.291682835@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 7ee0bfea9de1d..845d77b0a7f03 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -251,31 +251,29 @@ static int inet6_create(struct net *net, struct socket *sock, int protocol,
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




