Return-Path: <stable+bounces-95249-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DCC9D7492
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D321A167E87
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94833242E84;
	Sun, 24 Nov 2024 13:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXgKgwgM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6C2242E78;
	Sun, 24 Nov 2024 13:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456477; cv=none; b=R7rSVy1esuRToyVs8ChCrThkWv2c8JLiwmq0hoqABrTEcZnnGvm+aFpf9f+ml76QXDWzeu8BaXmc9xaPL01K2e0vVwZTMkd+9kD6bYY1RNO+IjEfqHLTwYI5E4cZuAq8xguWpl8CGDwnIoRwFxetca7ey0imlNyzpm98j4XtWx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456477; c=relaxed/simple;
	bh=a6oNqJIP3Qw2yJl0cxh8SmFzcezwOryIXQJl0P7ECiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JzTREaaVHIpJoHiTNWRLttSp4dL9V3iJg8FqNQamRLmtq9uXhrDFK1fOZpH7bF6k16tY58WgkmvVSTE2Yiowf6J9XYIk+n9N6FsvOITBVfs9NnmbVshM85oBoxcLDdoD710doD+HHIvQZ+xrrSL95Hvrmjc75rmHh1mYhB8E1/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iXgKgwgM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE03C4CED3;
	Sun, 24 Nov 2024 13:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456477;
	bh=a6oNqJIP3Qw2yJl0cxh8SmFzcezwOryIXQJl0P7ECiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iXgKgwgMY0Ex8Bfq5CKH2QSuf3gkRHDKwMrHwr+FPjpecZaTCgacKkmfbjaaw/txC
	 NGhIH3wpnghJdtla2kAXAiq7Oqlz2xwZ6mcCO8bXM81ikpub2ANKuRY2w5/CJBXN1b
	 wyLy74W7rHJWZC2aXvQQdV3HF0tNABHrKL+XyDW2TTEFTIKIjb6SWuGC+ePR16BWpj
	 2G9h+TgTJ3IQfzbagP2nLwntPeXejGvNYtwoBlSLu+mQxnaIQLqOios29k7uqq0iBv
	 mqJ46QoAw2IEc28fQNnIgib5lZS6rjtXVfHoxmJU2CDhOYOZ6UHjNeOvmuAArHx9Kg
	 RUpwnoDShQl9g==
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
Subject: [PATCH AUTOSEL 5.10 14/33] net: inet: do not leave a dangling sk pointer in inet_create()
Date: Sun, 24 Nov 2024 08:53:26 -0500
Message-ID: <20241124135410.3349976-14-sashal@kernel.org>
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
index 58dfca09093c2..c64a52b30ddc9 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -373,32 +373,30 @@ static int inet_create(struct net *net, struct socket *sock, int protocol,
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


