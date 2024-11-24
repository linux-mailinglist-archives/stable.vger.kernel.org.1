Return-Path: <stable+bounces-95246-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A0A9D7488
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34662282F3B
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514C71FC119;
	Sun, 24 Nov 2024 13:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIH+/sZP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38721FC118;
	Sun, 24 Nov 2024 13:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456472; cv=none; b=VeLSfIODKT3v1rlNBSjp6RfuqNX8ewpP1SLdGlvbBCRsQuzLr6CBklh60f+IGmwFLVccAr+tWhlFUd1h4nHzfwsG7UynTFUFzbIV+nzoAiGBFkofJrazFJmbP9gvXOsfwF4pA2QKWPDPh01+PorcdP4954HWl+cI2kwNwhpR3Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456472; c=relaxed/simple;
	bh=BX53M5ImCt7cmLZgxt6msll3beRVbgYBYhHYm0vhaHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CANOkfcT8otTfGwx0nv5CaJUcQmCFxbZImMf0xkuWhp/1WWFESEhRH+Y150AXlVd1/ymeEqUBywd0EZ3VJOAfUDVHb4KAAlD4uhbqt/Muot+1kObM3Kmo0KWJzp/m7pOGngJrmpZ/M8HmOPCiY2jwxieny3dtN5E9CwIBH8aM1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bIH+/sZP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5990C4CED1;
	Sun, 24 Nov 2024 13:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456471;
	bh=BX53M5ImCt7cmLZgxt6msll3beRVbgYBYhHYm0vhaHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bIH+/sZPtWD85wEV5Kx8NxKm4TCYzeKDtKh0XC7MCzgyMF7o72Fj7uAv/WJUXZvNk
	 GzNOd/cEcYI2qL7rGE+95sr6ji7Zv4fNUaZVpfSR+XiOSnHpLtLfChZ93N6lNtObrz
	 KmYySxoAnD8g0twMQfOXKAw/yuM3Z9NGeCUMfeo3qqdqEuvzqzeRwJNig1BztUR06n
	 Z3hiLz7Qcj/oY6VEx/n1WJ7xQJs89Gy+E5gE1gViFq7SC8E+k31Dc7cwsMeRzYhGIg
	 jjCb7dxZl9trs0Vmt4MTqHp7nIRCs2VYiCd4od9gy19GguYGO7E2IIjbPs5bcvbSCz
	 q+qITAP3Qx7wg==
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
	linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 11/33] Bluetooth: L2CAP: do not leave dangling sk pointer on error in l2cap_sock_create()
Date: Sun, 24 Nov 2024 08:53:23 -0500
Message-ID: <20241124135410.3349976-11-sashal@kernel.org>
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

[ Upstream commit 7c4f78cdb8e7501e9f92d291a7d956591bf73be9 ]

bt_sock_alloc() allocates the sk object and attaches it to the provided
sock object. On error l2cap_sock_alloc() frees the sk object, but the
dangling pointer is still attached to the sock object, which may create
use-after-free in other code.

Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20241014153808.51894-3-ignat@cloudflare.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/l2cap_sock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 93afa52c04660..cbaefbba6f4db 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1864,6 +1864,7 @@ static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
 	chan = l2cap_chan_create();
 	if (!chan) {
 		sk_free(sk);
+		sock->sk = NULL;
 		return NULL;
 	}
 
-- 
2.43.0


