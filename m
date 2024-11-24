Return-Path: <stable+bounces-95245-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2AD9D7489
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51D99164BAA
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7211FC107;
	Sun, 24 Nov 2024 13:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDecrjvn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5EA1FC0FC;
	Sun, 24 Nov 2024 13:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456470; cv=none; b=CbXDoaHR+qj9kdurZG6nKzKnw9hU2/bPq4a5uW02H9SpRK78mPokvU+ipFMd7vziitcePbhKfiiMI1eIpu/X/I2kM4s70HQeNwu+DOUCMCXc+tNmG68WlwURP+5bB6Qji6X/2rPKeJq1QNh9QXhWEqwyM0YqGxa5OIa3fldd9Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456470; c=relaxed/simple;
	bh=LVs397VnGF5bbebkIY0frZQiSZOCLGCs0BU7w//bOU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OjWPezy3G77c7FOgV2PmIS5QSrkSBw9xoMMdzd+QR7FWjLtIHZzMjZfkyvlAVD4K21cwQ/G1BEK9mk+5zlDueFMU2NkSCGAPg5N0HDSFmE/77HWDEm7zMEq5K7qokltBqxKe1NnQ0LQEvO76s4Lwe276lzZxcHH5R6rp6qt+21U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDecrjvn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8AD9C4CECC;
	Sun, 24 Nov 2024 13:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456470;
	bh=LVs397VnGF5bbebkIY0frZQiSZOCLGCs0BU7w//bOU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fDecrjvnX8MtT7vsvmT+nSyV2DTJD27fNI+LLpV4EB6QvYkJh9fUw9YmUYCQQBp5z
	 CTTE2Uimj3TFvLa/kSU0V1E8mAYCZo2JpmiaTRrHVMmm6jog/+pvQnRzNBVEB8ajjC
	 XBhKd+jjhZMEs1coqq78TGYfwWgF6MieLW4izpeGN5xUTVoHIACjGJY42Ddre3rSpr
	 W7PQizv4J/J62nNeAmqsP44Jkd+Yzx7ZKjTU2TO1DtxVy4zygJ4ofWBMm+iRTackW4
	 cawGhsxJFKWJGRxHmFOaAYFgjrzxGL6o0f/Fj9CoWaHUKjJwDSSwf/ByKNhnQbF9Mu
	 TYGG4MDsceSJA==
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
Subject: [PATCH AUTOSEL 5.10 10/33] af_packet: avoid erroring out after sock_init_data() in packet_create()
Date: Sun, 24 Nov 2024 08:53:22 -0500
Message-ID: <20241124135410.3349976-10-sashal@kernel.org>
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
index ce3e20bcde4ab..01a191c8194b4 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -3386,18 +3386,18 @@ static int packet_create(struct net *net, struct socket *sock, int protocol,
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
@@ -3432,7 +3432,7 @@ static int packet_create(struct net *net, struct socket *sock, int protocol,
 	preempt_enable();
 
 	return 0;
-out2:
+out_sk_free:
 	sk_free(sk);
 out:
 	return err;
-- 
2.43.0


