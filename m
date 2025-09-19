Return-Path: <stable+bounces-180710-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBC6B8B69E
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 23:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F6B41C84D12
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 21:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867C72D3230;
	Fri, 19 Sep 2025 21:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vJgJUH0x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4021A23FC54;
	Fri, 19 Sep 2025 21:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758318760; cv=none; b=A79vl302cqBG75GWOh9g9btBOBsTjWKqqCzM/rYDSH0cdJDOJlewslvmivW59/LPq01DXKPhMjXEJfG8lrNIBWkJSbrv6aGpAAVoYnrn1RMzpfMHjU642PdkyE36dzsist5luUAeFgaw3LK2OXJR5T49tL/90cQoxjxdul40qbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758318760; c=relaxed/simple;
	bh=2z2U0bZQN1RwovVwvOxtmAnueQkPU1EBiHMMoDkFq+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BUDPmgNvOo4vKJDQXWdxCQkgsPCtPQDee2vI+RG6cGQqINbLKrYeqCiJUd3fL9IEiwrumE6NPuXPg/6ENm3cd5pvkeZqysrS9Lo8ljHP1C1rzkqNTGdPru4vbl/FMtDTZ3vvOOwcsyYlPc+hukz9FLB+EwAYMvAew9mgngUqzDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vJgJUH0x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83606C4CEF0;
	Fri, 19 Sep 2025 21:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758318760;
	bh=2z2U0bZQN1RwovVwvOxtmAnueQkPU1EBiHMMoDkFq+k=;
	h=From:To:Cc:Subject:Date:From;
	b=vJgJUH0x+JSmlfQDTEsG5AOsjj0Sd5fGsvTvMBAdhoRL1BGUWHZoOV+MLuLzG/IE9
	 hu7g9qAmcAJEc5rD4/HkAFZ3bTbT43KnlFX9eSJ0ZF1rZjjh9nmk7ER9nPSmXibvAn
	 F4BEapNsgeNHLdoPjxG71rij3zjSTlh+2ZC0ng3DRwDHBM7r6D2hCTBaZsa+jo3qyg
	 NMZse5BbLjxyDoXy+qN6dITD9+/P6wW78SP3VqB2jlwH9Xc1JCV672Edo3XN+UZ1Dt
	 ac82JosJCndxNgLAf137ocIjdzp8vAPhHKL7t2y6r2ctYZW+TJLzQXEvbS2edclKjQ
	 k0prgDhsjzS/A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Marek Majkowski <marek@cloudflare.com>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.12.y] mptcp: pm: nl: announce deny-join-id0 flag
Date: Fri, 19 Sep 2025 23:52:23 +0200
Message-ID: <20250919215222.3519719-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5499; i=matttbe@kernel.org; h=from:subject; bh=2z2U0bZQN1RwovVwvOxtmAnueQkPU1EBiHMMoDkFq+k=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLOXpi203Lz55bJJt/uPZp/8sCzw0fb1N0/HOQ4UHOjX OCeYdiaPx2lLAxiXAyyYoos0m2R+TOfV/GWePlZwMxhZQIZwsDFKQAT6TJl+Ke9tdFa5trSdMPz xlNc1lx49CZ30scFPVHLy72VD7hx1c1l+O/1O+O3/qUIZq2qJcainLnv3U7elxDjjrgbJBq/peb sXy4A
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
index 7e295bad8b29..a670a9bbe01b 100644
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
index b763729b85e0..463c2e7956d5 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -2211,6 +2211,7 @@ static int mptcp_event_created(struct sk_buff *skb,
 			       const struct sock *ssk)
 {
 	int err = nla_put_u32(skb, MPTCP_ATTR_TOKEN, READ_ONCE(msk->token));
+	u16 flags = 0;
 
 	if (err)
 		return err;
@@ -2218,6 +2219,12 @@ static int mptcp_event_created(struct sk_buff *skb,
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


