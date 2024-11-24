Return-Path: <stable+bounces-95110-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B22709D735D
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89A1C165CC7
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC474226DD4;
	Sun, 24 Nov 2024 13:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZJBv0mB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9FC226DC8;
	Sun, 24 Nov 2024 13:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456050; cv=none; b=lzLr75vm3yVoTHdDu97g9O4vcbPi42MsFWWHR4I1lCSe6uPL3cfqDmxXF6rGhJIpdyd886n8+Q+drv8i2YBBteeUo1AaI8wZ2nx0BR8NHNE2Roflpm3dpeAbvkfQ6MREj0S13qEdqAuLA9HNmjTYMfSHBaSkmpYn3vqTtFZHps0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456050; c=relaxed/simple;
	bh=c3T2NzTxMY3DDzIYj2q2r6k3laAGbv3Lv46B90UVZHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RsVxP0s6tBMvOMXPj054YDoZdDW0aAhZqwvm4nzihj7r+dALcdy18KcvaAuwIF0ztH1bS5YbL7BvGMaLc19fdEutBjxR+eIvfNevJDwXgyHKnj4es7V0oMMWjUA5AghHh1ls1YxttUX+V2IO6aSNnDEzESO9VNMas4Zd0h5EonI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZJBv0mB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C0B4C4CED3;
	Sun, 24 Nov 2024 13:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456050;
	bh=c3T2NzTxMY3DDzIYj2q2r6k3laAGbv3Lv46B90UVZHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bZJBv0mB8XwMFszVi+Zok77wXrLwfBk6YNl2wLzIJ8uffKKiakUhAHjWGeZJt3nat
	 lNeSJGfI3FhJ27KksxuSUSnTcVcfk7debspHm8HcdT73PyV5VlLIyohTOflwkN01qn
	 A1jOIVviMVFIrEJO9etMIrHtcH8kxcb6vXPZWxbdNQRwyq9+Bf9iiIgYeFt1W3aJd0
	 aJwvWA4uakKagfpaAQzdsvDmCEbYvSONSkYCJznua1G0+GL1tfz6T3ksPq1z91QPQ7
	 tz0kRbI4RzDpcBZeayd+a57nHucpdciq41SMJYwi45LR3OT/fL23y2A3E30YFOo3AI
	 bLwU787qBMydw==
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
Subject: [PATCH AUTOSEL 6.6 20/61] Bluetooth: L2CAP: do not leave dangling sk pointer on error in l2cap_sock_create()
Date: Sun, 24 Nov 2024 08:44:55 -0500
Message-ID: <20241124134637.3346391-20-sashal@kernel.org>
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
index f04ce84267988..379ca86c41cd5 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1885,6 +1885,7 @@ static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
 	chan = l2cap_chan_create();
 	if (!chan) {
 		sk_free(sk);
+		sock->sk = NULL;
 		return NULL;
 	}
 
-- 
2.43.0


