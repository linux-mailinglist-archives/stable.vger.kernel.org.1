Return-Path: <stable+bounces-95281-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EA59D74DA
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7D322812B8
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3181D248F05;
	Sun, 24 Nov 2024 13:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjxWWmjH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD53D248362;
	Sun, 24 Nov 2024 13:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456575; cv=none; b=cLPJgEb3jmQgaC3q554Jsckp42O8Xg+X/fvRIOYFlKBuLkv5tGxLAyW5/5RDHj2HkNAJNOiy+qEILnUSxCd57YezmnSxPTURnMgWh855b9pYnSq033rI1c2Aamm1MdAmbOcWPyVr4sDd+evJCqIvsXuxoozFu2ue02KmVEjdOJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456575; c=relaxed/simple;
	bh=vb6nFAQRKxt/olsyS36qmWgyo11KDXaPGNXwy1cxJag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qtlg3UZVL+0l3HKjfTwS4bFmXepZ9NywroFgBCvs80SGw+wWBUw2TdK8rGImifUHbgOcoecn2r4ekf0GHT82/h9LlT1tO3itwReRHaTPpX0H18+jarnvP9QhMQyGyPLMAaFStxXe/40C8ou985PuIbOY6b6Cc34Uv1SvH+ZJdFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjxWWmjH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95FF7C4CED1;
	Sun, 24 Nov 2024 13:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456574;
	bh=vb6nFAQRKxt/olsyS36qmWgyo11KDXaPGNXwy1cxJag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kjxWWmjHNfLHBrOrs8JTUqbCuQwr1ubcuqglfX1NHeDHJOnyHiNaUBu0MNmZBDdaU
	 CrBk9PaL13zL00hzMF6vvAu2RedNBXElOFFN09DVwaxtW7gLRk8zEFpjQmIKresSOJ
	 gZQbEG50q7gC04TSALyW7/gUYrn+4/MjdojDIqOrspBVwNC7oYAKTx5Q4cw5wlya1D
	 RMp823GnCELjtJ3kWA99hyWtKBrkRPKwigvm36l/Jc4YytJLgXqR1lizTZrADeElop
	 Ni9Y2A/r2bYGO9EzUVNEQwws1GS2PXKQvxnSTOoeL2aWaIFiQAm67PNpdg3QuQxv0h
	 kwYkzXUkLeTmQ==
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
Subject: [PATCH AUTOSEL 5.4 13/28] net: inet6: do not leave a dangling sk pointer in inet6_create()
Date: Sun, 24 Nov 2024 08:55:13 -0500
Message-ID: <20241124135549.3350700-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135549.3350700-1-sashal@kernel.org>
References: <20241124135549.3350700-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.286
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


