Return-Path: <stable+bounces-180712-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDABB8B8F6
	for <lists+stable@lfdr.de>; Sat, 20 Sep 2025 00:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D8ED1CC3E5B
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 22:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A492E0927;
	Fri, 19 Sep 2025 22:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dIkpt4lI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757AF2D6604;
	Fri, 19 Sep 2025 22:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758321517; cv=none; b=tt/0vqZnD8gWD5o//cjL73BoK/rFw4fWMfQwbKWUVlY9x8ZFIKK4DFRuCUDMiJY/6YsoI4ikEqUmixn177Pnk3DYrFi420RwNwcvqs7M0ZPRmUaIuFEJGSVi4KZ2uOVs4anH7cqmKQYw0TzE5YGol5ZzD+8dsolMRk3svwpFLUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758321517; c=relaxed/simple;
	bh=XMIFzGqkR2k4A363T4IAId9E8rXgz5W/2zq+W0QBN/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i+gSgAckQLyr4RbR+xddjQyDcuYxD8CAQnGf3s2zmdHXa8cGeXnogiuij9hSiakb5n6QjFzCCy0lC0TBy6HJ+DXIZVVImpdxaRWFl56ATd9sPr7d/te2ijSHDwKmy6zcgqd1mt6Zn8/WEmZh/mABKjDonDz2mCbyGSmA/xcRWR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dIkpt4lI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CB60C4CEF0;
	Fri, 19 Sep 2025 22:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758321517;
	bh=XMIFzGqkR2k4A363T4IAId9E8rXgz5W/2zq+W0QBN/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dIkpt4lI+kR6D8s/bUZh0xDGhrUEPkzn/yv/XORJGYQ4itfidLdwZvEmoSFm9+n8Z
	 l3G+W1/XdTZE8K/PPTBUmdLSnlqtuwrpWmtHyBjPW0mF8unwP10cx+S/dr7X1s3QhM
	 9HrMIqGgMgOAU0z4dAxZb+ulqwEN2ykjbWk0WVDcPz8zVvP/p2fnM5xYHQ46lHfYle
	 t2Gd0TXZvcP6Na4QhCOhTOax5/At5H+BnYkSOImOuasKKfc5utRIPs3voARTppSODg
	 f69lggY1wwZzFOm2nESW01MKu3kijUABv60aKsmoNDYN7oq1p5bFqJL3Ees9FaneKR
	 7eZDXZLRVLP7w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	sashal@kernel.org,
	Marek Majkowski <marek@cloudflare.com>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6.y 1/2] mptcp: pm: nl: announce deny-join-id0 flag
Date: Sat, 20 Sep 2025 00:38:21 +0200
Message-ID: <20250919223819.3679521-5-matttbe@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919223819.3679521-4-matttbe@kernel.org>
References: <20250919223819.3679521-4-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4446; i=matttbe@kernel.org; h=from:subject; bh=XMIFzGqkR2k4A363T4IAId9E8rXgz5W/2zq+W0QBN/c=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLO3o6bm6NiYGw7VdpQ2/RT+uF7f1Y4spS8mt6te+Dnt UVuh5y+dJSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAExknykjQ69bWn76orOvr1+X K5kWK6f45nML76F/gQp+bOd3F+au3cTI0BJ4U7+G83nRh7wnMUukJv+22pyhOoNFbm9d1I1FrR9 3cAIA
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
[ Conflicts in mptcp_pm.yaml, and mptcp_pm.h, because these files have
  been added later by commit bc8aeb2045e2 ("Documentation: netlink: add
  a YAML spec for mptcp"), and commit 9d1ed17f93ce ("uapi: mptcp: use
  header file generated from YAML spec"), which are not in this version.
  Applying the same modifications, but only in mptcp.h.
  Conflict in pm_netlink.c, because of a difference in the context,
  introduced by commit b9f4554356f6 ("mptcp: annotate lockless access
  for token"), which is not in this version. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 include/uapi/linux/mptcp.h | 6 ++++--
 net/mptcp/pm_netlink.c     | 7 +++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index ee9c49f949a2..00d622121673 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -81,6 +81,8 @@ enum {
 
 #define MPTCP_PM_ADDR_ATTR_MAX (__MPTCP_PM_ADDR_ATTR_MAX - 1)
 
+#define MPTCP_PM_EV_FLAG_DENY_JOIN_ID0		_BITUL(0)
+
 #define MPTCP_PM_ADDR_FLAG_SIGNAL			(1 << 0)
 #define MPTCP_PM_ADDR_FLAG_SUBFLOW			(1 << 1)
 #define MPTCP_PM_ADDR_FLAG_BACKUP			(1 << 2)
@@ -132,13 +134,13 @@ struct mptcp_info {
 
 /*
  * MPTCP_EVENT_CREATED: token, family, saddr4 | saddr6, daddr4 | daddr6,
- *                      sport, dport
+ *                      sport, dport, server-side, [flags]
  * A new MPTCP connection has been created. It is the good time to allocate
  * memory and send ADD_ADDR if needed. Depending on the traffic-patterns
  * it can take a long time until the MPTCP_EVENT_ESTABLISHED is sent.
  *
  * MPTCP_EVENT_ESTABLISHED: token, family, saddr4 | saddr6, daddr4 | daddr6,
- *			    sport, dport
+ *			    sport, dport, server-side, [flags]
  * A MPTCP connection is established (can start new subflows).
  *
  * MPTCP_EVENT_CLOSED: token
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index e8042014bd5f..de24989b05a6 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -2252,6 +2252,7 @@ static int mptcp_event_created(struct sk_buff *skb,
 			       const struct sock *ssk)
 {
 	int err = nla_put_u32(skb, MPTCP_ATTR_TOKEN, msk->token);
+	u16 flags = 0;
 
 	if (err)
 		return err;
@@ -2259,6 +2260,12 @@ static int mptcp_event_created(struct sk_buff *skb,
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


