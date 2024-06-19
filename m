Return-Path: <stable+bounces-54179-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4196E90ED0B
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 15:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1115B25BB1
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 13:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EF7143C58;
	Wed, 19 Jun 2024 13:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xI80o10L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89871422B8;
	Wed, 19 Jun 2024 13:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718802816; cv=none; b=Jnie0LvDm1yPYNKO+TVHqddSMMHnN4Ij1eCj4QTrR/hCp40X/gYz8MoHXNr5B7x7nKlvl8/ne7Fwo/boSAjbPIQvV4t9CHehL+Whj1oytX/URy0n7GuDOpGy7wjOhWqJDxbvL5xz0EYaMkMExT5OsskGwNxp3Njo9UODQQ/KfDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718802816; c=relaxed/simple;
	bh=VFqbu6AbrZhvPb7IdxsB7n+TgDFYjrszC7XIqVN+UA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kLzn3EO8MYIkhXFhGKuAT6f4FrUmnvV9N0bTpNkwLQDdmDlV434X5kOH93U22NkusjSttk5Vhn4Jhxnp0o/SuJ4SOMFtyBMl39ns5wQFakApE2BHIFFup6SmdocTkTOV9e5cQOTg+jUtHlc3CwPTSLZSKA+IRHGlcNHD+nljxlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xI80o10L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 666FAC2BBFC;
	Wed, 19 Jun 2024 13:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718802815;
	bh=VFqbu6AbrZhvPb7IdxsB7n+TgDFYjrszC7XIqVN+UA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xI80o10LemS/UkUZAqTgY1FbrmDh/SiNbBgqH8Nn0V5UvCMomRJxFGo7zhN4IvfDa
	 rEahglXeo4Dn9a6VjU0/WMdjduO76RooL86Lzi4ok7CZM/dK5rhttexgm/N+d6qsuw
	 x44xKeYqBj9O1sbhO98kTNqlC77V25q4uCV37x0Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 057/281] af_unix: Set sk->sk_state under unix_state_lock() for truly disconencted peer.
Date: Wed, 19 Jun 2024 14:53:36 +0200
Message-ID: <20240619125612.044439394@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240619125609.836313103@linuxfoundation.org>
References: <20240619125609.836313103@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit 26bfb8b57063f52b867f9b6c8d1742fcb5bd656c ]

When a SOCK_DGRAM socket connect()s to another socket, the both sockets'
sk->sk_state are changed to TCP_ESTABLISHED so that we can register them
to BPF SOCKMAP.

When the socket disconnects from the peer by connect(AF_UNSPEC), the state
is set back to TCP_CLOSE.

Then, the peer's state is also set to TCP_CLOSE, but the update is done
locklessly and unconditionally.

Let's say socket A connect()ed to B, B connect()ed to C, and A disconnects
from B.

After the first two connect()s, all three sockets' sk->sk_state are
TCP_ESTABLISHED:

  $ ss -xa
  Netid State  Recv-Q Send-Q  Local Address:Port  Peer Address:PortProcess
  u_dgr ESTAB  0      0       @A 641              * 642
  u_dgr ESTAB  0      0       @B 642              * 643
  u_dgr ESTAB  0      0       @C 643              * 0

And after the disconnect, B's state is TCP_CLOSE even though it's still
connected to C and C's state is TCP_ESTABLISHED.

  $ ss -xa
  Netid State  Recv-Q Send-Q  Local Address:Port  Peer Address:PortProcess
  u_dgr UNCONN 0      0       @A 641              * 0
  u_dgr UNCONN 0      0       @B 642              * 643
  u_dgr ESTAB  0      0       @C 643              * 0

In this case, we cannot register B to SOCKMAP.

So, when a socket disconnects from the peer, we should not set TCP_CLOSE to
the peer if the peer is connected to yet another socket, and this must be
done under unix_state_lock().

Note that we use WRITE_ONCE() for sk->sk_state as there are many lockless
readers.  These data-races will be fixed in the following patches.

Fixes: 83301b5367a9 ("af_unix: Set TCP_ESTABLISHED for datagram sockets too")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/unix/af_unix.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 439c531744a27..c0cf7137979c7 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -570,7 +570,6 @@ static void unix_dgram_disconnected(struct sock *sk, struct sock *other)
 			sk_error_report(other);
 		}
 	}
-	other->sk_state = TCP_CLOSE;
 }
 
 static void unix_sock_destructor(struct sock *sk)
@@ -1424,8 +1423,15 @@ static int unix_dgram_connect(struct socket *sock, struct sockaddr *addr,
 
 		unix_state_double_unlock(sk, other);
 
-		if (other != old_peer)
+		if (other != old_peer) {
 			unix_dgram_disconnected(sk, old_peer);
+
+			unix_state_lock(old_peer);
+			if (!unix_peer(old_peer))
+				WRITE_ONCE(old_peer->sk_state, TCP_CLOSE);
+			unix_state_unlock(old_peer);
+		}
+
 		sock_put(old_peer);
 	} else {
 		unix_peer(sk) = other;
-- 
2.43.0




