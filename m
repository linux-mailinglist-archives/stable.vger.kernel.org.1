Return-Path: <stable+bounces-180709-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B34B8B65F
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 23:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 514DBA03E1D
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 21:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB02020DD72;
	Fri, 19 Sep 2025 21:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tPhFJwRZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645D11917ED;
	Fri, 19 Sep 2025 21:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758318582; cv=none; b=kHk1NB8hD5deXBU3N2MrouCKfiC9ZLEDJzhkMrrbZmfI0N6YEN8rqFfVwGIoGNTA2EwR2n34T39Y2wRFKyA3rLI/2mfKziQxVLVEdWYbELDn7n4+8KddzubTFgpxE5t1JwOwC78TUYT4tUVuDARl6/FfKj52wO0Rl4zp2vsqxRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758318582; c=relaxed/simple;
	bh=Ek1JREZlTjO/kGvO7PHGPgR6rIY7A7ZouOJ8TApwGWw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bTi2bND1hqPHrnwXoq2FvzH735ACB5Hr1Gr9W1N7m0rYTlyDko1kyfckkAiiuIZQ1lj424oeGUR8mN7ifbVCM7NE4YhU16hvdiUwhqGpgQWFkz6k9cA3dfh/oZIJ26oKaHw5QiOXF1FKijDO3SvDnCgWcvAnhss0JMg8o3iNmq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tPhFJwRZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4402EC4CEF0;
	Fri, 19 Sep 2025 21:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758318581;
	bh=Ek1JREZlTjO/kGvO7PHGPgR6rIY7A7ZouOJ8TApwGWw=;
	h=From:To:Cc:Subject:Date:From;
	b=tPhFJwRZwJA8R75zdRYDDo99+GyCIUQzgvOE0BgHB8xWyU11He3SIwzn1LV+qN3WG
	 VRafg+57wvwvoPRUkpmz8WKP1ybS5GrTIm6io5AoiGIB5+uIJOfjLgRJNzjUdbVrX6
	 M6n/l2iir4CaOlwkyKgb2VhwajyHzU/c91a7eYBUVo5RdupIzqvHtfBX2ZhVChXLzs
	 d9js5cLzvxZxhcPg0nudG1Pm+hxPFqEcCD7SqatvetJ7bMS3do8vmlFQiXCHw4ICGO
	 VPRqiodsrX7q9nJcSKpx+i8A6/4eRdt4CgZnPcPlSuujRBxR+2xVuohAJwl32hSc+n
	 cFIj3yXyJFHCg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Marek Majkowski <marek@cloudflare.com>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.16.y] mptcp: pm: nl: announce deny-join-id0 flag
Date: Fri, 19 Sep 2025 23:49:22 +0200
Message-ID: <20250919214921.3467324-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5495; i=matttbe@kernel.org; h=from:subject; bh=Ek1JREZlTjO/kGvO7PHGPgR6rIY7A7ZouOJ8TApwGWw=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLOnn8Uefbzdn9REQHlRxNX9fScCp6TWt524kUM+8I/T WoCdiEPO0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACby6icjQ09l/e5bupPM8zTe u/RZPPytuHNiYmeuhDv/M4eULwqHPjP8j9IQs3XJK/gy780cF+GupaW7jY///s/C6xXH8vztkiI dPgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit 2293c57484ae64c9a3c847c8807db8c26a3a4d41 upstream.

During the connection establishment, a peer can tell the other one that
it cannot establish new subflows to the initial IP address and port by
setting the 'C' flag [1]. Doing so makes sense when the sender is behind
a strict NAT, operating behind a legacy Layer 4 load balancer, or using
anycast IP address for example.

When this 'C' flag is set, the path-managers must then not try to
establish new subflows to the other peer's initial IP address and port.
The in-kernel PM has access to this info, but the userspace PM didn't.

The RFC8684 [1] is strict about that:

  (...) therefore the receiver MUST NOT try to open any additional
  subflows toward this address and port.

So it is important to tell the userspace about that as it is responsible
for the respect of this flag.

When a new connection is created and established, the Netlink events
now contain the existing but not currently used 'flags' attribute. When
MPTCP_PM_EV_FLAG_DENY_JOIN_ID0 is set, it means no other subflows
to the initial IP address and port -- info that are also part of the
event -- can be established.

Link: https://datatracker.ietf.org/doc/html/rfc8684#section-3.1-20.6 [1]
Fixes: 702c2f646d42 ("mptcp: netlink: allow userspace-driven subflow establishment")
Reported-by: Marek Majkowski <marek@cloudflare.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/532
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20250912-net-mptcp-pm-uspace-deny_join_id0-v1-2-40171884ade8@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts in mptcp_pm.yaml, because the indentation has been modified
  in commit ec362192aa9e ("netlink: specs: fix up indentation errors"),
  which is not in this version. Applying the same modifications, but at
  a different level. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 Documentation/netlink/specs/mptcp_pm.yaml | 4 ++--
 include/uapi/linux/mptcp.h                | 2 ++
 include/uapi/linux/mptcp_pm.h             | 4 ++--
 net/mptcp/pm_netlink.c                    | 7 +++++++
 4 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/Documentation/netlink/specs/mptcp_pm.yaml b/Documentation/netlink/specs/mptcp_pm.yaml
index ecfe5ee33de2..c77f32cfcae9 100644
--- a/Documentation/netlink/specs/mptcp_pm.yaml
+++ b/Documentation/netlink/specs/mptcp_pm.yaml
@@ -28,13 +28,13 @@ definitions:
         traffic-patterns it can take a long time until the
         MPTCP_EVENT_ESTABLISHED is sent.
         Attributes: token, family, saddr4 | saddr6, daddr4 | daddr6, sport,
-        dport, server-side.
+        dport, server-side, [flags].
      -
       name: established
       doc: >-
         A MPTCP connection is established (can start new subflows).
         Attributes: token, family, saddr4 | saddr6, daddr4 | daddr6, sport,
-        dport, server-side.
+        dport, server-side, [flags].
      -
       name: closed
       doc: >-
diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 67d015df8893..5fd5b4cf75ca 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -31,6 +31,8 @@
 #define MPTCP_INFO_FLAG_FALLBACK		_BITUL(0)
 #define MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED	_BITUL(1)
 
+#define MPTCP_PM_EV_FLAG_DENY_JOIN_ID0		_BITUL(0)
+
 #define MPTCP_PM_ADDR_FLAG_SIGNAL                      (1 << 0)
 #define MPTCP_PM_ADDR_FLAG_SUBFLOW                     (1 << 1)
 #define MPTCP_PM_ADDR_FLAG_BACKUP                      (1 << 2)
diff --git a/include/uapi/linux/mptcp_pm.h b/include/uapi/linux/mptcp_pm.h
index 6ac84b2f636c..7359d34da446 100644
--- a/include/uapi/linux/mptcp_pm.h
+++ b/include/uapi/linux/mptcp_pm.h
@@ -16,10 +16,10 @@
  *   good time to allocate memory and send ADD_ADDR if needed. Depending on the
  *   traffic-patterns it can take a long time until the MPTCP_EVENT_ESTABLISHED
  *   is sent. Attributes: token, family, saddr4 | saddr6, daddr4 | daddr6,
- *   sport, dport, server-side.
+ *   sport, dport, server-side, [flags].
  * @MPTCP_EVENT_ESTABLISHED: A MPTCP connection is established (can start new
  *   subflows). Attributes: token, family, saddr4 | saddr6, daddr4 | daddr6,
- *   sport, dport, server-side.
+ *   sport, dport, server-side, [flags].
  * @MPTCP_EVENT_CLOSED: A MPTCP connection has stopped. Attribute: token.
  * @MPTCP_EVENT_ANNOUNCED: A new address has been announced by the peer.
  *   Attributes: token, rem_id, family, daddr4 | daddr6 [, dport].
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 50aaf259959a..ce7d42d3bd00 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -408,6 +408,7 @@ static int mptcp_event_created(struct sk_buff *skb,
 			       const struct sock *ssk)
 {
 	int err = nla_put_u32(skb, MPTCP_ATTR_TOKEN, READ_ONCE(msk->token));
+	u16 flags = 0;
 
 	if (err)
 		return err;
@@ -415,6 +416,12 @@ static int mptcp_event_created(struct sk_buff *skb,
 	if (nla_put_u8(skb, MPTCP_ATTR_SERVER_SIDE, READ_ONCE(msk->pm.server_side)))
 		return -EMSGSIZE;
 
+	if (READ_ONCE(msk->pm.remote_deny_join_id0))
+		flags |= MPTCP_PM_EV_FLAG_DENY_JOIN_ID0;
+
+	if (flags && nla_put_u16(skb, MPTCP_ATTR_FLAGS, flags))
+		return -EMSGSIZE;
+
 	return mptcp_event_add_subflow(skb, ssk);
 }
 
-- 
2.51.0


