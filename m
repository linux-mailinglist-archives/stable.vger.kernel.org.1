Return-Path: <stable+bounces-95040-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A27C59D7281
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7B061649ED
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5833B1FC7E9;
	Sun, 24 Nov 2024 13:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWUdJgdX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132D21FC7E4;
	Sun, 24 Nov 2024 13:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455790; cv=none; b=C+WJGPqn8570L1eEybTOLH5uasWI43VA+mXJDf80NodTu3U4a5M2qIRIR6tw6DIWU17wr5DhFaICRU8yurU+Yfc6DbcD+FKtSJSIMfVh0xsTvjEI9ie/PwYYyOKvgt7cBDQp4/aA1ggoY8HgEXhDOg4NhwAdroz3NQS25NwZ1rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455790; c=relaxed/simple;
	bh=MJkkdr2StmcTjYkJq7eEm8fCAEh5Qpd3Q4t8pexluPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ApzRSU7YZu0qpcM04idbyAT4MPHOME1kCyy1LQnDk1aaXNyO4ujw0lTkGcS45ezhI0A01H/nAEIsRxiqlfvPVW6nE+IrFv2d2BdJVxTPGxUzFlGrrfb9qqDLdd5MNipBE/Do9dpv73LJLgWxKsv3nHiB0ao6vMegNZS0F//UsO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWUdJgdX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87DF2C4CECC;
	Sun, 24 Nov 2024 13:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455789;
	bh=MJkkdr2StmcTjYkJq7eEm8fCAEh5Qpd3Q4t8pexluPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KWUdJgdXc4GSoESe3D2nbuBPKahMVBc8FhPz+JR4gKnUYVZ6VAirdyQ5pKOabk8X6
	 gPzWACozL5XRJZhaPBO6pezIDXhhdt5TUuRmrvlfDV6uQlw7mxk86o7eSZ6t08PqCd
	 AEBR5R6+0RtHBCCbJJr5zrqod+ENZ8QUUanIpFHx4KkBahMErCy0WQGCafAviwQQjL
	 /A6TfOW0Bdu0xsI+UwwaGr6TZZzKsVp9llZ+SC7wsIoaQkyaToAoO10MdaDaDastIZ
	 wEVXwzlKVi2lK/O5obVea9vqPSeKX908a0bt5aU2AymDiODUlMoqPkAhAsSYTZjwrF
	 22ySn6ae47wug==
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
Subject: [PATCH AUTOSEL 6.11 37/87] net: inet: do not leave a dangling sk pointer in inet_create()
Date: Sun, 24 Nov 2024 08:38:15 -0500
Message-ID: <20241124134102.3344326-37-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134102.3344326-1-sashal@kernel.org>
References: <20241124134102.3344326-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
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
index b24d74616637a..8095e82de8083 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -376,32 +376,30 @@ static int inet_create(struct net *net, struct socket *sock, int protocol,
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


