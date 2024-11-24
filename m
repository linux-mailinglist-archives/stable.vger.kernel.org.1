Return-Path: <stable+bounces-95109-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 914719D759D
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 17:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C437AB29033
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701401B4159;
	Sun, 24 Nov 2024 13:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dfzoY2x+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE571B4151;
	Sun, 24 Nov 2024 13:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456049; cv=none; b=H63RzSYtFsywgpXdhwOMc7n3KTPoFJCpQ23B9ZsnCxzP5UWge+23txU8jOjVQEtqKt3dheL/JeuZIuZpu6cJZxXQyGQdXhPJjmjgG7Of94xF4CKcXrAA9FOyXAezw91jtx4a2hodVSlwcuVcGSZKbPWOtwLsfwH5Cf4I8iyRQeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456049; c=relaxed/simple;
	bh=ecwTPAfvqROhTuu0WhMT8sH7uLC0y81iRZclusE+ITo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zj7UDvrfJfd3oV8QGakgYAD95WhKlokO7gMY1ZCRW0gNpkw4HC/ugWdGPb0SiyygD6+iYO7/YfoVlKyVUQKLV89pVWU6ctrHg8QzLcwkZkyBfT2z4W7VMq67nxk0kY12UbVvqW3bCWHDHA1Dl7WEBOWFNw0qAwIWF8xJSZkil44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dfzoY2x+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B2DCC4CECC;
	Sun, 24 Nov 2024 13:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456048;
	bh=ecwTPAfvqROhTuu0WhMT8sH7uLC0y81iRZclusE+ITo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dfzoY2x+O1+7EQdskn7vnCz1fCKvQ7nuJO88uBi9kBKLXA3IDgNoZY/u1CoRagxvE
	 1IvnGyg5oCG6ErfLZ1H044KPNP0b+ugPdvczMs1XgZgNxL8aPyop6Xh8A8yekDR3AJ
	 UUJsIjJe6XWu8WZRkDOiZnk0Z84/ILnzgcVP8cdrxIxd9CjNK+tpKCYJoUQNM2nghU
	 kdNF//fgAKUKb1z6g7hoRQFhGOorw079ePn0CHVouMjQ5f2vAXRrF75/cQIYy6nbA8
	 W0lAlMb4csk8ViH+k1ceRUkxQGsLiPywnH0K2jZRYowGYXw4+g+9drxOeRBDPkaQk5
	 Phj3uqFs/mSpA==
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
Subject: [PATCH AUTOSEL 6.6 19/61] af_packet: avoid erroring out after sock_init_data() in packet_create()
Date: Sun, 24 Nov 2024 08:44:54 -0500
Message-ID: <20241124134637.3346391-19-sashal@kernel.org>
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
index 3e5703537e4eb..56e3ae3b6be93 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -3428,17 +3428,17 @@ static int packet_create(struct net *net, struct socket *sock, int protocol,
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
 
-	err = packet_alloc_pending(po);
-	if (err)
-		goto out2;
-
 	packet_cached_dev_reset(po);
 
 	sk->sk_destruct = packet_sock_destruct;
@@ -3470,7 +3470,7 @@ static int packet_create(struct net *net, struct socket *sock, int protocol,
 	sock_prot_inuse_add(net, &packet_proto, 1);
 
 	return 0;
-out2:
+out_sk_free:
 	sk_free(sk);
 out:
 	return err;
-- 
2.43.0


