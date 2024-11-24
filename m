Return-Path: <stable+bounces-94936-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AF29D7448
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67647B36866
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCD11D54C2;
	Sun, 24 Nov 2024 13:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NX0LnkIH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD671D517D;
	Sun, 24 Nov 2024 13:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455321; cv=none; b=Toctkzalc96c5jXGOo7a0Gf8dqS87NvD9p17WuGsKp1Au0xGjv9XH7PhLlNg20Tp+of7BPSrsrSCKJwo1i3a5YZ8MPlbqtbTDrV4J5Pm9Fl+ClW+Oc/VS3/zuUwL+oTbJWUYCcXb3RMLiWdSYBLG+ZEBo5g0IwkYpAYQiRmlEh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455321; c=relaxed/simple;
	bh=fd3ZinV+jCcg103teRjr3y+4tPqCObl0riMq17VT/t0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mES9R5Nhere86YOYAgUGwJzgKGcCWjXWTYg3sJZeKqnk7kXV3yQ2mwoLetqddNDaGBLpOWEaJv1KsKbCelMsH11dUkgJoeG7IksUSqET2tjUbwYg1RraK3j/9MWig+sghhVf6crfBlPwmL0giLK0id4i4R7PPIDSm++5FpiGAic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NX0LnkIH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F364C4CED9;
	Sun, 24 Nov 2024 13:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455320;
	bh=fd3ZinV+jCcg103teRjr3y+4tPqCObl0riMq17VT/t0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NX0LnkIHy7Yzsniohsij1jflRPKv7iTUVBWdavojg69M7OS3YEoftLBzOyqnu0YHZ
	 nAFdO3zG64XQvvkwagS0xA0oa2UdEI3/vLlcCNTGES37gJLMMdhPdaBXs27nXcYqzU
	 45VeN8RFmPCk6RDlXONuSRexpaZVknX3Ag4MGe3n7dGSk4tuFBAVeR+vJxrub+YHHI
	 WHnv+H4UORc0i2G8t1uch09YnPwhNLy/jpXhIe4JfvSWbp9wEFvDGE41Y912td+i1f
	 dyqCZ/4T+KKSYt7dPx1PJa7gDSl5q7u4f93TojPgnyM0FEzfmHJVony/YhBxYQ5TMH
	 UssoaL5Re09TQ==
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
	andrew.shadura@collabora.co.uk,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 040/107] Bluetooth: RFCOMM: avoid leaving dangling sk pointer in rfcomm_sock_alloc()
Date: Sun, 24 Nov 2024 08:29:00 -0500
Message-ID: <20241124133301.3341829-40-sashal@kernel.org>
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
index f48250e3f2e10..355e1a1698f56 100644
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


