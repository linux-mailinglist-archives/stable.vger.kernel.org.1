Return-Path: <stable+bounces-95036-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E6D9D7275
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0BD016462C
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C6D1FAC43;
	Sun, 24 Nov 2024 13:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DhvCFk09"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09061FAC3D;
	Sun, 24 Nov 2024 13:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455781; cv=none; b=M11x1yrXaH/58idPoVt2eYAgk50uBg6JHRMBDUas2egsbVFJcgui9aJtESKiVlR/HeftU7j9270muJlYGDXQEZZu8mx0bmVv0bIMGisS86Nh5Bn/4SIn95DCRMCEC8iC+s2IAeQPzYF2lH5IZfOe9d8VDw1ZpoNGD7jOuqVHjhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455781; c=relaxed/simple;
	bh=EiHx87AeMv9RLTj88NFeMze1xpH+0f+7nisEo0+7Tq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RvhNO3HoQXaF2BrIhjWK4qvKdD1VJZlkmxx3ki3p43AyeiR3nHBEa3zwiPXH2cOIqWYi71p4gFEYu3mBvUWyRJ2ZivRwrcFTBmzGfe4i36kZssDLM021SNCo5bS3xIBsBUHnezndJiJqnD0Mqb305h4GzBN73w4d531jsz+iPDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DhvCFk09; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A7DC4CED3;
	Sun, 24 Nov 2024 13:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455781;
	bh=EiHx87AeMv9RLTj88NFeMze1xpH+0f+7nisEo0+7Tq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DhvCFk09DRy9NfWReQQc9RpEGxqlk+d75eJ5nl8E6Imq8pqHl+8KN2eY5qN5Bb92o
	 pAtcXDr7k/U4cKmoAubfZ8ycvAQUMvpHNVM6ESaf0pUA1FeCyeYNjO9F9oqFN2q6U1
	 +1VvMhGqGKpMqmitz0MDwPWtyO8prQPsaQeUazGBARU6XMsGV6lAphdSpeOSSVsgYR
	 ZmFwa5bcuUHihHGozkGOySYcqFZsieEiw2WMR1JI5KsrxYJuCAwEF0C1jq35ehZiMJ
	 woKtrv7U2Sq7Bc4S8KPi9hkjq8GAhVYaPqPBZRPKaD4tNNc7GRfmdqt1pkLVV6plj5
	 Ta7hE01dECEUw==
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
Subject: [PATCH AUTOSEL 6.11 33/87] Bluetooth: L2CAP: do not leave dangling sk pointer on error in l2cap_sock_create()
Date: Sun, 24 Nov 2024 08:38:11 -0500
Message-ID: <20241124134102.3344326-33-sashal@kernel.org>
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


