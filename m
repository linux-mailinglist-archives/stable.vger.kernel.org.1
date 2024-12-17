Return-Path: <stable+bounces-105070-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5DE9F58A0
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 22:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06DD3166305
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 21:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5B81F9EDC;
	Tue, 17 Dec 2024 21:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="DSJ0Il+o"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD6D1DA61D;
	Tue, 17 Dec 2024 21:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734470423; cv=none; b=aiHzo1aRWPS5jUGSWA7hGJHvi88FauLKr0vG8TFMKQl9WVHUwtzcR7BkancI/IhYF/cuiNE7hffpsRjciz/26JViSMoPklWLUQ36Pmj1KxwNDjczoClqKe24T/0df+D5HXJGTTwil6vjeMrEFTjdsbfVQPYQAPTPmarCFaujsgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734470423; c=relaxed/simple;
	bh=RgbePHvvaBeK0+l594OFpDIFAeIwpggIMOhdYkR0pjI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s8kmMFtiApTy1kLcWJSfonIHVgFWqtXUL4xDKaB6YDt4MMTWZO3PtR2HCzAqNedwBODdAW4vVoM3Dkgx9hwL8Cxdlv0JOnWDyYfx9u9Rda0l8AODZSCQkNoYaaaP1OI+ZkFQ9Cai3kw+tT4e6wuqL0cOPjCDaV6r7bHalr7MJuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=DSJ0Il+o; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fpc.intra.ispras.ru (unknown [10.10.165.15])
	by mail.ispras.ru (Postfix) with ESMTPSA id 9BC4A40777B2;
	Tue, 17 Dec 2024 21:20:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 9BC4A40777B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1734470408;
	bh=ZIM6X6jHhJs3zfT8dqSZ/6JFwa46VTqpC1EF5WvsU/c=;
	h=From:To:Cc:Subject:Date:From;
	b=DSJ0Il+oThkN8V9hzYtc2EQ7xMgatryrZ7MYUH06Su/R9PZmqIcgmuTBDrsQTWYsh
	 Z93ZNg8azPUCkIraS/9AeUk3hbG71KAprj7dzFoC/5Z3rG/r/IEeGbKnhmB8EaiP+G
	 9GNw93O2PMZwCxLoEaqBTLqwOjsCCThSbGZEvmR8=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Ignat Korchagin <ignat@cloudflare.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Eric Dumazet <edumazet@google.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: L2CAP: handle NULL sock pointer in l2cap_sock_alloc
Date: Wed, 18 Dec 2024 00:19:59 +0300
Message-Id: <20241217211959.279881-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A NULL sock pointer is passed into l2cap_sock_alloc() when it is called
from l2cap_sock_new_connection_cb() and the error handling paths should
also be aware of it.

Seemingly a more elegant solution would be to swap bt_sock_alloc() and
l2cap_chan_create() calls since they are not interdependent to that moment
but then l2cap_chan_create() adds the soon to be deallocated and still
dummy-initialized channel to the global list accessible by many L2CAP
paths. The channel would be removed from the list in short period of time
but be a bit more straight-forward here and just check for NULL instead of
changing the order of function calls.

Found by Linux Verification Center (linuxtesting.org) with SVACE static
analysis tool.

Fixes: 7c4f78cdb8e7 ("Bluetooth: L2CAP: do not leave dangling sk pointer on error in l2cap_sock_create()")
Cc: stable@vger.kernel.org
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 net/bluetooth/l2cap_sock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 3d2553dcdb1b..49f97d4138ea 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1888,7 +1888,8 @@ static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
 	chan = l2cap_chan_create();
 	if (!chan) {
 		sk_free(sk);
-		sock->sk = NULL;
+		if (sock)
+			sock->sk = NULL;
 		return NULL;
 	}
 
-- 
2.39.5


