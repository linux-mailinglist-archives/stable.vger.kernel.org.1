Return-Path: <stable+bounces-95035-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD659D726F
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F9A428BA8D
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFF11FA82C;
	Sun, 24 Nov 2024 13:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHragyZ/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D3B1FA27E;
	Sun, 24 Nov 2024 13:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455780; cv=none; b=WQiUxwVtwGwpe+M9FBkZOMwMizoz28KcNizvQILJFiBcn67mSVzCDEOMm59hUcGcZfog8bqjCEXtIy67CNIAmVzGKCAaw2qIdTw3NTPY/uwnGOrkyvTM3H3fCwRyKAyaJY8Ina8XjireMkQw86dyS8GRFDMWyehmXgFNI5yfrN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455780; c=relaxed/simple;
	bh=zP1Qk43GencFyFiHFgYA4QFV+lKZCBMIlnfbvBiHaXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V3qFzlXh4bDWxEPWMPRbVbHOYVM0/v+8KGDxsWikdCUpLAsDDPRlyiohaw5kteBfKy/Tcqq0hyCPx0L6wET1/ml5QGD8SGhhjdA0gVPRXB2chMJbufLLZGY0rzFA7BP15rCDC8Zih+/agq6cYqBr8DZLCQbNzgyJT8BAixBpA3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHragyZ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B5C6C4CED1;
	Sun, 24 Nov 2024 13:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455779;
	bh=zP1Qk43GencFyFiHFgYA4QFV+lKZCBMIlnfbvBiHaXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LHragyZ/32nfvvY0tpUtIf6TB2EYuMVbQcNJ0Sl7yo/ZpXoF0ToR/LiPuj5NzDjj/
	 XrSDhIKtGq4Po59f0ym01ZPYfUvrp4Sc4SvLqgl0IqyfBwsN51G6lsQA6AqOC72xM5
	 olVL2/a3wFckY6iqil+8HlBHMtLXwcfh9KDwVURpAqF2S6qwo7WI36/C+44OZWn7iY
	 FYee4Z4ro78q1tcyRDP9GWbCuSz8ZzrSCbVsAQrvUyYdycF4NMh+jpx0P8I0hDIewE
	 7WfnClfZIjQ2EdAc2icIoBssSXrpMvjgX+D3KvdpIti3o4Ygjj4bchoELSmEZu0Lbc
	 M2dMOv3VRTP4w==
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
Subject: [PATCH AUTOSEL 6.11 32/87] af_packet: avoid erroring out after sock_init_data() in packet_create()
Date: Sun, 24 Nov 2024 08:38:10 -0500
Message-ID: <20241124134102.3344326-32-sashal@kernel.org>
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
index 4a364cdd445e8..d241d2cb014d4 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -3421,17 +3421,17 @@ static int packet_create(struct net *net, struct socket *sock, int protocol,
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
@@ -3463,7 +3463,7 @@ static int packet_create(struct net *net, struct socket *sock, int protocol,
 	sock_prot_inuse_add(net, &packet_proto, 1);
 
 	return 0;
-out2:
+out_sk_free:
 	sk_free(sk);
 out:
 	return err;
-- 
2.43.0


