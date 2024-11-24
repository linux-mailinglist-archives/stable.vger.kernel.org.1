Return-Path: <stable+bounces-94935-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEC39D7105
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2463528303E
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120041D5143;
	Sun, 24 Nov 2024 13:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PM1rtGaO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C071A1D47C8;
	Sun, 24 Nov 2024 13:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455317; cv=none; b=iY9y0sJb570ia4v8bXjVERju6IaJczwXFqHWgYND5xyIqKcwfiiK/k4Y+kbMw3Tg1+5egOyqwM57nLi3AeEfam43dMbdE8Wqqdqcxs2rtTxOZLUezJHOQI18ZpS9r+kZRChys/fCb314+odI+CAktpsNrcuJq0Vd/2f4enXl4h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455317; c=relaxed/simple;
	bh=EiHx87AeMv9RLTj88NFeMze1xpH+0f+7nisEo0+7Tq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M7eDb8xke4cTAB9SQn9UIkzRehC1kl1k9L6nYLkmikI7C+Ji8dlk/QyBlNFoWj2O5CnYOf2mSWddyHP85P7+W0mRIB/JvbuZdrR/4v6Sg/oH3SWQhPwe7F4nwBFVQVUmlpApq8eUph9Q7uDQIQLwMatT7VxXOk6kwv/e0mDylqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PM1rtGaO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F4CEC4CED1;
	Sun, 24 Nov 2024 13:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455317;
	bh=EiHx87AeMv9RLTj88NFeMze1xpH+0f+7nisEo0+7Tq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PM1rtGaOdf051tfbuujRV/P/XffEW4Og09Uox/YOu3mh7LNKjNrM3s7KVwp6ADN4e
	 3qk6nw7ERZEyrXdO+vA6QX8109lKhlwTtcBrFXP5s3D0VwuCTPdpBvC/gDkmA6sprf
	 J1lpvgM4r9WoTXTd64+Piaa+waFhdwJqi+mN9lrcQUqGmDgX2bvHj9j+niHYzGAvv1
	 NJebjKk7fA/5WTa953IhfQQgZ+iFRzkUMvdaVO+ixFBHu5YIUA8YPcUNo/NVICDjkn
	 kL1devWjLRXtWqWYQWciiLqKwkZd/Y26pZiZVMSVsvOLeTTFg3JwWnhTujCW5duzwI
	 0EaG6XOigIrvg==
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
Subject: [PATCH AUTOSEL 6.12 039/107] Bluetooth: L2CAP: do not leave dangling sk pointer on error in l2cap_sock_create()
Date: Sun, 24 Nov 2024 08:28:59 -0500
Message-ID: <20241124133301.3341829-39-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124133301.3341829-1-sashal@kernel.org>
References: <20241124133301.3341829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
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
index ba437c6f6ee59..18e89e764f3b4 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1886,6 +1886,7 @@ static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
 	chan = l2cap_chan_create();
 	if (!chan) {
 		sk_free(sk);
+		sock->sk = NULL;
 		return NULL;
 	}
 
-- 
2.43.0


