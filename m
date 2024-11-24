Return-Path: <stable+bounces-95302-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF2B9D7511
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ABD3164828
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F76324CD76;
	Sun, 24 Nov 2024 13:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jdj0DqqV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE1624CD6D;
	Sun, 24 Nov 2024 13:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456643; cv=none; b=nZ0w30cQsRP4qR5zbvvEaJvG3DjDY+2qD6lUwRCvoymBsUFuOCvrfenXYVFaqkOaz22KIHfL7yEweOxPPK+rJEyrhuavrks1GpUFC3wzooliyDivNlgNQAV+7txzTG+Vwju6tPxn/lx5ZLFVCOjFvsyOdYXtxDnyevOPazKKC74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456643; c=relaxed/simple;
	bh=U6e2xnFycxDT1EdesiOYwuOUuFG13RhEUJmvFb2V1V8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fIQnFUMm5C8jWkX1WVqOokU0mncqB5dDyE/HQkkM9pv2jfK1G4i/9QymYNxQxZM7KfjWA7pNb7HUHjuywSHDfB6BcAgeUZe0Q1YdipCGzMBhXaI062ib4yA1we+symWNtfaiIZzA10a3TDHOtGlA+6dHZGxqvh1UQpnJTNtsFH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jdj0DqqV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1DC9C4CED3;
	Sun, 24 Nov 2024 13:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456642;
	bh=U6e2xnFycxDT1EdesiOYwuOUuFG13RhEUJmvFb2V1V8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jdj0DqqVboG7L1VYHxE+53TqS2JRw1M+rcHuZoyRHFAMEjT3YcZO2dCiaBkegGsrw
	 rEmP4R6QokgDxEIvgLvS1jZ9tT5epwZ1ffjsMEHQubyGChfjqj1hevwrYd4Y6F7oAp
	 42JW11D8+XwlNevjq3td9pWLy8xd2TkKEGONaU6bVpqbIwr4tPYbf6AMh+9tXljsPD
	 u5WJ111CPxWdxyeSVETIscdpEJ7cYpt/bzZrZTFp36rI8J8ceSdrr95r2933MySME9
	 oWANS5shDJhD+lZYGjmKkslx0VNwjzo5tXGUhVgjZL2KpofiyTK0qEBVabyidg3QRY
	 1mTcVvV2JTarQ==
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
Subject: [PATCH AUTOSEL 4.19 06/21] Bluetooth: L2CAP: do not leave dangling sk pointer on error in l2cap_sock_create()
Date: Sun, 24 Nov 2024 08:56:39 -0500
Message-ID: <20241124135709.3351371-6-sashal@kernel.org>
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
index 8dcd3af05d9fc..5a955bd40f7b9 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1659,6 +1659,7 @@ static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
 	chan = l2cap_chan_create();
 	if (!chan) {
 		sk_free(sk);
+		sock->sk = NULL;
 		return NULL;
 	}
 
-- 
2.43.0


