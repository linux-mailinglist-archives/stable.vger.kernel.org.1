Return-Path: <stable+bounces-95276-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EB89D74CD
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8757028C443
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BEE247DBF;
	Sun, 24 Nov 2024 13:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCZJlvCU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1D3247DB7;
	Sun, 24 Nov 2024 13:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456566; cv=none; b=QRYBPHKHcx6KCD5k92/Ob3eQBaQwzNNTwTuLrrPVgDfzv3e4EQ0eHoB1elr3bZXi2NsTXqup2UoKFvfZLyUAOJkBhhrI1cvXqfC2aGUhJH+G+kFqD4Ee34JiE+eRIkjjgIVyMtg7AT1rjN41pUyuCKvPMrbUIqQnX4eEjSVXZWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456566; c=relaxed/simple;
	bh=vkGfBLxA4IwBZDnDH6pRj7CQifYQsFIWUEaaPvbO11s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DkiMB11E5em8O38eLG/yHEGkE3Tk1pZVcQj1wHdPyTh9fDFLYmGkkyjoGD4Hb9A5DVYB7Xju6YhFKr2Fm6mazo3kiymZaOmWEh/fkorVi47J1GmTnhv/DLp+YSJwSFtnTAvGEiMLj6p4YVxKAJ0WBfK/LcW4ciizCVEP1XSrP6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCZJlvCU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB8BC4CECC;
	Sun, 24 Nov 2024 13:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456566;
	bh=vkGfBLxA4IwBZDnDH6pRj7CQifYQsFIWUEaaPvbO11s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RCZJlvCUcwxRiYCoPjgSmfF/UxuDyfzIXB7miWTCw0waCYJPLHykUlHKW1284zH7N
	 JLFDJbllRuZtWfrSOz/v1x7EovX0ID7Z8pQn8vv+vcB99w9yaktGlxeYVxHt2npzF3
	 A+o8YnAAX6aVWNV1E90Or6rIbZTbhYSn2gIfG19Jgyacnp+1Wn0JCd7kbUgRYuTcJV
	 fROQLUFevaeN7jeaXDBCUnyIuMGnLq6sMPaF4rBZQgdC2AnQXQJnGyUK+93B6RJOTG
	 QMuXR/R7iGvWAR/VOFunWILFAB+GpGcAr0lIrzH71leaPbCVtr0z7pMMZEH9GGhmxh
	 0DUedbJFyt7cA==
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
Subject: [PATCH AUTOSEL 5.4 08/28] af_packet: avoid erroring out after sock_init_data() in packet_create()
Date: Sun, 24 Nov 2024 08:55:08 -0500
Message-ID: <20241124135549.3350700-8-sashal@kernel.org>
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
index 6aed6a36ea456..88bc4a21dda45 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -3357,18 +3357,18 @@ static int packet_create(struct net *net, struct socket *sock, int protocol,
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
@@ -3403,7 +3403,7 @@ static int packet_create(struct net *net, struct socket *sock, int protocol,
 	preempt_enable();
 
 	return 0;
-out2:
+out_sk_free:
 	sk_free(sk);
 out:
 	return err;
-- 
2.43.0


