Return-Path: <stable+bounces-95171-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B7C9D73E4
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A3A316587C
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A4B2346E4;
	Sun, 24 Nov 2024 13:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jn/KPD/e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B6D2346DC;
	Sun, 24 Nov 2024 13:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456231; cv=none; b=t2tBRfmKq2YIN8TXzSQTp3Sb9S8RAu93aYu//uf4Uv0AyamJCTcki0FsGviJR+IWNtGf0rkKP65++lpYaar8j3XzwMh5SE5F3gXzWXdTPHx7zgW0Hr+3GruuZ+vFOIx3zc/TPtdgV9b62zTcHSx6uPow28djStD3V6Cjr9VS6Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456231; c=relaxed/simple;
	bh=JUZVNeNpeTJBEzUAvXjuRqh2n8/fZ5C/MDA19J3Het0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lIQIcYAocPaW6b97pt2J01DRlYvW89NiCnLL1lIUICMAkjq4s3goiUXZqd1Bi7uYULI4EiCMDsTVIYVLGX0yFnINXaX5l11jvjSvjCRJbBjKtU/qz+929MgYPJ68gfvbwuhYfb9EEvskCEO7z8NEU2n/xwIfYIbJF+ymPcb05Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jn/KPD/e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E4EC4CECC;
	Sun, 24 Nov 2024 13:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456231;
	bh=JUZVNeNpeTJBEzUAvXjuRqh2n8/fZ5C/MDA19J3Het0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jn/KPD/e8LMybi+QL8b87D01BBx5pSp14JHrkAaG4rzA+7HsT4FVY26Vp1FbYoA8a
	 Famd3B3bP9Hr1Z5NNDag5cfMvd6+eagaF6vWT4ukh/mjIQm1lsuL27QLUqhbHMelIE
	 ZR+X0KTRzgKQdBGzdZFUZdS2OgOXbRQLtzqC8pCvqvpl35li//Goh/xcJNKXerVORP
	 RMFBxZkS2r8DaD3vE6ANBDRdm5qfwXooXKreBp3s2k95Cq+mXtrpf4zh9/GXlPLedJ
	 Q6LBTmEIMKu8F/FHEFcORcjbwN5JLoyljwWWmlBaAouFrywEYqz2fLSCMKC5JNa+5t
	 G3i0eA+aWh31Q==
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
Subject: [PATCH AUTOSEL 6.1 20/48] net: inet: do not leave a dangling sk pointer in inet_create()
Date: Sun, 24 Nov 2024 08:48:43 -0500
Message-ID: <20241124134950.3348099-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134950.3348099-1-sashal@kernel.org>
References: <20241124134950.3348099-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.119
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
index cc013be9b02c4..4f3c932e37ed5 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -371,32 +371,30 @@ static int inet_create(struct net *net, struct socket *sock, int protocol,
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


