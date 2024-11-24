Return-Path: <stable+bounces-95168-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7669D73DD
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 399B7165C6B
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BD61F80E2;
	Sun, 24 Nov 2024 13:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9/ELSnI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCEF1E1A28;
	Sun, 24 Nov 2024 13:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456226; cv=none; b=YDlA9q9S4vfFL8TCyyFmyjZygwQYfXkogvNJRB0zh+w7xMc/Ppf8YGVKSzfVLrg5VpK1MTguYTw5jbdLacGojhx3RrEwge2ghKE8mRmjev+5krCBNa+gZzQPUvnZ4iKmgGKfaJKYh/N6PKn4aNbYQXFqtzBE292eQ1er2RzV/DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456226; c=relaxed/simple;
	bh=jETAs1hLlG5NMPCKGkBYO+lM7/ghq/KRXjS3pPC5aI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=suqjxspA164d1ACxUS33EoS9dq8wVt0ElpOurTE1z1a0lckJPS0lK5Yz+/21EM5Tqm4dThh/pD0+zxO6expvqtyzJzj21ocVcj2Q/tqQPYxUFcHA6bYic1Nh0nG580kAEVpAm+9aobfhZhZYN1Mi4IruigEZU50DGkbVSbcpN0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9/ELSnI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB7FFC4CED3;
	Sun, 24 Nov 2024 13:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456226;
	bh=jETAs1hLlG5NMPCKGkBYO+lM7/ghq/KRXjS3pPC5aI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y9/ELSnIC9B2KjAqAGgKguk8FOwIv9UFYfL0c/DiE2Q2eveasm4t3depTVN1kjA6q
	 WchDluhsKWtebz8jFLKu5dmXOinMhSZWbNndnmF3m9609zElHF9JM0wlzwrEZodr2K
	 Ww6YYW2i9nCBbgem7tzkcdzM8mjUz6ahbhFZBkD54KIfiMTXl6wJOsxb6cKz4xFgiw
	 YJ1MLXi6qt/FknE02+XXBeQNijdYEjLtum5B1gKgmqWpbRHoM0o1moT4KXrdS5Mqt0
	 lgoG7qFlJaLejn5DS7l3XS9inZdi/WEngwwe9WnFoJVzTZTnGxZAX1ojLzHWV5ksO0
	 VrGFO7pWpRtmA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ignat Korchagin <ignat@cloudflare.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	andrew.shadura@collabora.co.uk,
	axboe@kernel.dk,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 17/48] Bluetooth: RFCOMM: avoid leaving dangling sk pointer in rfcomm_sock_alloc()
Date: Sun, 24 Nov 2024 08:48:40 -0500
Message-ID: <20241124134950.3348099-17-sashal@kernel.org>
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

[ Upstream commit 3945c799f12b8d1f49a3b48369ca494d981ac465 ]

bt_sock_alloc() attaches allocated sk object to the provided sock object.
If rfcomm_dlc_alloc() fails, we release the sk object, but leave the
dangling pointer in the sock object, which may cause use-after-free.

Fix this by swapping calls to bt_sock_alloc() and rfcomm_dlc_alloc().

Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20241014153808.51894-4-ignat@cloudflare.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/rfcomm/sock.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index cbff37b327340..c32a2374638b7 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -274,13 +274,13 @@ static struct sock *rfcomm_sock_alloc(struct net *net, struct socket *sock,
 	struct rfcomm_dlc *d;
 	struct sock *sk;
 
-	sk = bt_sock_alloc(net, sock, &rfcomm_proto, proto, prio, kern);
-	if (!sk)
+	d = rfcomm_dlc_alloc(prio);
+	if (!d)
 		return NULL;
 
-	d = rfcomm_dlc_alloc(prio);
-	if (!d) {
-		sk_free(sk);
+	sk = bt_sock_alloc(net, sock, &rfcomm_proto, proto, prio, kern);
+	if (!sk) {
+		rfcomm_dlc_free(d);
 		return NULL;
 	}
 
-- 
2.43.0


