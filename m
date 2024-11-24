Return-Path: <stable+bounces-95111-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1254C9D735C
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAD872856CE
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332741B414C;
	Sun, 24 Nov 2024 13:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3MYgjHu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA14F226DC8;
	Sun, 24 Nov 2024 13:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456053; cv=none; b=e8LlL/28/H1sUhR7PTOz1sTU9Lp0B/bYGyJaWxpwD9ifE4K7cpGQOH+PySuFpaaenw3uudHRI7guHyj0xAaSw+1DussxjLQFtqGSG/pLMyVwzcww2RT5Lv+JHFEZBQHUpFLHyqe21aRm9kMDbRsR439+sf8y7hEDZn85A5PumaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456053; c=relaxed/simple;
	bh=jETAs1hLlG5NMPCKGkBYO+lM7/ghq/KRXjS3pPC5aI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ICniGaFcLGEq4bf7bS/97zl8yU208oPLjdOm4atogX5yKpEocXFGKhgBmnqHCmjVqRfIpejPmfVk7/9wsi9L9OuoaevUvYpcoVK1mbU391HzaJFqyQDC6rf8sLECWUnYtXXCwsKtZW7IdetoY9o7gUKka/6kBbKZJws+Kz+Kdio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3MYgjHu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E277AC4CECC;
	Sun, 24 Nov 2024 13:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456053;
	bh=jETAs1hLlG5NMPCKGkBYO+lM7/ghq/KRXjS3pPC5aI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N3MYgjHuirWIuqbpvtoAiwCUoUkcwmT8NjTdohE2RfPJn7PMOMtoZRVPf5OVX1KyC
	 fo691B05dkUDzN9PorQREs1qpE/cdRxncu0f/QjLpT0MJCpKfBMqU9Jo7IkL90Uz++
	 enIcadDRM68FYyH56jQZL6sfkLH0ZBg69vF3MtpqumTC8QsdCsNu64CyElvBo0wpvk
	 gipwZ3vQcrX6KTRn1xkh7e46kjoEGbZ+HB9yq1WBdsj6oG4BxcEYg6NylS6VXJsiEl
	 gr3IyiDgejO4KaajZCAaNlYHijrEVm+CNPCmOWAajjEKw+QZBwRDWfkafBNXRODCtW
	 JhYUR1haO+4IA==
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
	axboe@kernel.dk,
	nathan@kernel.org,
	andrew.shadura@collabora.co.uk,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 21/61] Bluetooth: RFCOMM: avoid leaving dangling sk pointer in rfcomm_sock_alloc()
Date: Sun, 24 Nov 2024 08:44:56 -0500
Message-ID: <20241124134637.3346391-21-sashal@kernel.org>
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


