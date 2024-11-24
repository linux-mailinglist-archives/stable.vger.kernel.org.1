Return-Path: <stable+bounces-95301-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C869D750E
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D7082877A7
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC80F24CD4D;
	Sun, 24 Nov 2024 13:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7hJx88U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9550D24CD45;
	Sun, 24 Nov 2024 13:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456641; cv=none; b=YTL83a3n3jbFfovUrEJHR64sr5aNxK4m6RnFdjPvzGtANbJ53aP0CeF5WsUdlYaXS18RF1LJIasxRSTmUxTOO6pk+4eb35ZRuQTfYemTgmJ5Agswgjz5JvazWJ1mdrLvcQZl9G1rSY8afDwNrFT5i2xq5sVH8Wws0lcU4jaHA1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456641; c=relaxed/simple;
	bh=6UmNZQznBP0m16qkAj863v5OCr3E8dA6Al0Ybc8uqDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pvkmtZ0+JyoCCSaK0uKu8uEkJE9sBzKttG1JT1TSnM0PW+106WUxaxJHdvMZEf4kStnLx9UEsxMcAearBdrbsCYPkzhwONlsaBRaYi96uvASvuqINlwDML9t26EBvoah/eKriAdEGlsyv/qsxHTKlLxjzM9Te1mJBL+96Nf/U/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7hJx88U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7694C4CED1;
	Sun, 24 Nov 2024 13:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456641;
	bh=6UmNZQznBP0m16qkAj863v5OCr3E8dA6Al0Ybc8uqDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E7hJx88UwYf8Gzy1ATvdH+pgKkncyXVT2igNK3LTCgarhb3uW0JloIdKvzTVvi917
	 hEHrRONXXyzwPrvNbYDuFIffgqppZfq/FOC8YKdOTX63uJ3R+/42uDb7Bush6J81aS
	 2FU1lZTOLK6JLqxK8zwlBJ+BJCC5BfASNL5cTIWAx+Q/KVhrXoKD0l2UAs/cDWC4d5
	 m1bDGE6bge5n8kKrAstQe7uEApJOegChRi9DOyMDfVa4SWdkV5WrB3m8SqIHjzYfRA
	 0N+sSHZ8VXbSCpLnEmXftTQwlq4h2ZZIq1g+X68rQQ41sQv7SWdEeXpF2gCU9WPOUx
	 NgxDB7sUKFp0g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ignat Korchagin <ignat@cloudflare.com>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	willemdebruijn.kernel@gmail.com,
	davem@davemloft.net,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 05/21] af_packet: avoid erroring out after sock_init_data() in packet_create()
Date: Sun, 24 Nov 2024 08:56:38 -0500
Message-ID: <20241124135709.3351371-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135709.3351371-1-sashal@kernel.org>
References: <20241124135709.3351371-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.324
Content-Transfer-Encoding: 8bit

From: Ignat Korchagin <ignat@cloudflare.com>

[ Upstream commit 46f2a11cb82b657fd15bab1c47821b635e03838b ]

After sock_init_data() the allocated sk object is attached to the provided
sock object. On error, packet_create() frees the sk object leaving the
dangling pointer in the sock object on return. Some other code may try
to use this pointer and cause use-after-free.

Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20241014153808.51894-2-ignat@cloudflare.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/packet/af_packet.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index b285a6e1a7669..31b2a843611be 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -3346,18 +3346,18 @@ static int packet_create(struct net *net, struct socket *sock, int protocol,
 	if (sock->type == SOCK_PACKET)
 		sock->ops = &packet_ops_spkt;
 
+	po = pkt_sk(sk);
+	err = packet_alloc_pending(po);
+	if (err)
+		goto out_sk_free;
+
 	sock_init_data(sock, sk);
 
-	po = pkt_sk(sk);
 	init_completion(&po->skb_completion);
 	sk->sk_family = PF_PACKET;
 	po->num = proto;
 	po->xmit = dev_queue_xmit;
 
-	err = packet_alloc_pending(po);
-	if (err)
-		goto out2;
-
 	packet_cached_dev_reset(po);
 
 	sk->sk_destruct = packet_sock_destruct;
@@ -3392,7 +3392,7 @@ static int packet_create(struct net *net, struct socket *sock, int protocol,
 	preempt_enable();
 
 	return 0;
-out2:
+out_sk_free:
 	sk_free(sk);
 out:
 	return err;
-- 
2.43.0


