Return-Path: <stable+bounces-242864-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uM09KGdQ+GmQsQIAu9opvQ
	(envelope-from <stable+bounces-242864-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 09:53:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA944B9AAA
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 09:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 484B4305581A
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 07:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B962E3033EC;
	Mon,  4 May 2026 07:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qm+B5rM2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649F930595C
	for <stable@vger.kernel.org>; Mon,  4 May 2026 07:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777880847; cv=none; b=U/YmixzzhNRRT9QBMb/aIcrT5kZFnW64rc4wtgztWXBQTrwe3eac8yHJ5dbwwrEWhF/lCu+ZBclerz4BIJJP7TmseqK/fy30+Kw71Msr1d9JEgByfi797uFEyW0pj9Y8uRhzJvpsjEkVBh2YJIPSleL2G33G5Nsty9uEr2Tt4q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777880847; c=relaxed/simple;
	bh=C4YO8RVJDVs9+8e80p6epPrmEs7ArVD/LJWwRMTYlWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IbO+65XLzBXVW5VcgZmylHxfhHJ+i98n6MzyvIAXHqac8J0qBu0uacePwhNEmpYobmeDYqyNLkFMfP+CURDN0PmeyFZbUFtZ5n9BJOHzh06R+mNtEBhqLHb2NU1vC3BP1B1W+VjZf5WqQz8fvF/nrjEVLZIVYPVp4v4W1LR3wiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qm+B5rM2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B64D5C2BCB8;
	Mon,  4 May 2026 07:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777880847;
	bh=C4YO8RVJDVs9+8e80p6epPrmEs7ArVD/LJWwRMTYlWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qm+B5rM2Z2L14zg0rzSLpK0M91KYyr7UKDIfGflVqpL5F02O2z1Lhgx5l8YGGTuKA
	 BTjBqGewfJrwmhGSZ+voMPlkAvAulJD/CIg+2Tq81Du4Xyr6UmLZvMLOsnbvJfwFJO
	 zdJ8MPtUl7WgWIl2iiW4EBMEUfhRMji2PDeafjLQ0/EMzVgyfOnwXojqMCgxvDSlkg
	 aXA4SF5N/tQ0x9Y7paSwQ+M7aI+FnPwHAJjntOaTJ7nGeKLJ/VI9cYf/fQiaztVH44
	 qcay4sslc+TJr2wvmUtdmbsiUz1Cn3x0upPwrWRTlFYLZLGyTCNsDoVpZ2Ssewv0j8
	 ZcWB3L+sOZrsg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhengchuan Liang <zcliangcn@gmail.com>,
	stable@kernel.org,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Yuan Tan <yuantan098@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Ren Wei <enjou1224z@gmail.com>,
	Ren Wei <n05ec@lzu.edu.cn>,
	Ido Schimmel <idosch@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] net: bridge: use a stable FDB dst snapshot in RCU readers
Date: Mon,  4 May 2026 03:47:18 -0400
Message-ID: <20260504074719.1856971-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050100-suave-boaster-8c68@gregkh>
References: <2026050100-suave-boaster-8c68@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0BA944B9AAA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,lzu.edu.cn,nvidia.com,blackwall.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242864-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]

From: Zhengchuan Liang <zcliangcn@gmail.com>

[ Upstream commit df4601653201de21b487c3e7fffd464790cab808 ]

Local FDB entries can be rewritten in place by `fdb_delete_local()`, which
updates `f->dst` to another port or to `NULL` while keeping the entry
alive. Several bridge RCU readers inspect `f->dst`, including
`br_fdb_fillbuf()` through the `brforward_read()` sysfs path.

These readers currently load `f->dst` multiple times and can therefore
observe inconsistent values across the check and later dereference.
In `br_fdb_fillbuf()`, this means a concurrent local-FDB update can change
`f->dst` after the NULL check and before the `port_no` dereference,
leading to a NULL-ptr-deref.

Fix this by taking a single `READ_ONCE()` snapshot of `f->dst` in each
affected RCU reader and using that snapshot for the rest of the access
sequence. Also publish the in-place `f->dst` updates in `fdb_delete_local()`
with `WRITE_ONCE()` so the readers and writer use matching access patterns.

Fixes: 960b589f86c7 ("bridge: Properly check if local fdb entry can be deleted in br_fdb_change_mac_address")
Cc: stable@kernel.org
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Co-developed-by: Yuan Tan <yuantan098@gmail.com>
Signed-off-by: Yuan Tan <yuantan098@gmail.com>
Suggested-by: Xin Liu <bird@lzu.edu.cn>
Tested-by: Ren Wei <enjou1224z@gmail.com>
Signed-off-by: Zhengchuan Liang <zcliangcn@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
Link: https://patch.msgid.link/6570fabb85ecadb8baaf019efe856f407711c7b9.1776043229.git.zcliangcn@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ kept `*idx < cb->args[2]` instead of `*idx < ctx->fdb_idx` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bridge/br_arp_nd_proxy.c |  8 +++++---
 net/bridge/br_fdb.c          | 28 ++++++++++++++++++----------
 2 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/net/bridge/br_arp_nd_proxy.c b/net/bridge/br_arp_nd_proxy.c
index f033a51675602..985aaf7ff1564 100644
--- a/net/bridge/br_arp_nd_proxy.c
+++ b/net/bridge/br_arp_nd_proxy.c
@@ -199,11 +199,12 @@ void br_do_proxy_suppress_arp(struct sk_buff *skb, struct net_bridge *br,
 
 		f = br_fdb_find_rcu(br, n->ha, vid);
 		if (f) {
+			const struct net_bridge_port *dst = READ_ONCE(f->dst);
 			bool replied = false;
 
 			if ((p && (p->flags & BR_PROXYARP)) ||
-			    (f->dst && (f->dst->flags & BR_PROXYARP_WIFI)) ||
-			    br_is_neigh_suppress_enabled(f->dst, vid)) {
+			    (dst && (dst->flags & BR_PROXYARP_WIFI)) ||
+			    br_is_neigh_suppress_enabled(dst, vid)) {
 				if (!vid)
 					br_arp_send(br, p, skb->dev, sip, tip,
 						    sha, n->ha, sha, 0, 0);
@@ -463,9 +464,10 @@ void br_do_suppress_nd(struct sk_buff *skb, struct net_bridge *br,
 
 		f = br_fdb_find_rcu(br, n->ha, vid);
 		if (f) {
+			const struct net_bridge_port *dst = READ_ONCE(f->dst);
 			bool replied = false;
 
-			if (br_is_neigh_suppress_enabled(f->dst, vid)) {
+			if (br_is_neigh_suppress_enabled(dst, vid)) {
 				if (vid != 0)
 					br_nd_send(br, p, skb, n,
 						   skb->vlan_proto,
diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index fa2970db21301..0a51f648c57ec 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -246,6 +246,7 @@ struct net_device *br_fdb_find_port(const struct net_device *br_dev,
 				    const unsigned char *addr,
 				    __u16 vid)
 {
+	const struct net_bridge_port *dst;
 	struct net_bridge_fdb_entry *f;
 	struct net_device *dev = NULL;
 	struct net_bridge *br;
@@ -258,8 +259,11 @@ struct net_device *br_fdb_find_port(const struct net_device *br_dev,
 	br = netdev_priv(br_dev);
 	rcu_read_lock();
 	f = br_fdb_find_rcu(br, addr, vid);
-	if (f && f->dst)
-		dev = f->dst->dev;
+	if (f) {
+		dst = READ_ONCE(f->dst);
+		if (dst)
+			dev = dst->dev;
+	}
 	rcu_read_unlock();
 
 	return dev;
@@ -349,7 +353,7 @@ static void fdb_delete_local(struct net_bridge *br,
 		vg = nbp_vlan_group(op);
 		if (op != p && ether_addr_equal(op->dev->dev_addr, addr) &&
 		    (!vid || br_vlan_find(vg, vid))) {
-			f->dst = op;
+			WRITE_ONCE(f->dst, op);
 			clear_bit(BR_FDB_ADDED_BY_USER, &f->flags);
 			return;
 		}
@@ -360,7 +364,7 @@ static void fdb_delete_local(struct net_bridge *br,
 	/* Maybe bridge device has same hw addr? */
 	if (p && ether_addr_equal(br->dev->dev_addr, addr) &&
 	    (!vid || (v && br_vlan_should_use(v)))) {
-		f->dst = NULL;
+		WRITE_ONCE(f->dst, NULL);
 		clear_bit(BR_FDB_ADDED_BY_USER, &f->flags);
 		return;
 	}
@@ -790,6 +794,7 @@ int br_fdb_test_addr(struct net_device *dev, unsigned char *addr)
 int br_fdb_fillbuf(struct net_bridge *br, void *buf,
 		   unsigned long maxnum, unsigned long skip)
 {
+	const struct net_bridge_port *dst;
 	struct net_bridge_fdb_entry *f;
 	struct __fdb_entry *fe = buf;
 	unsigned long delta;
@@ -806,7 +811,8 @@ int br_fdb_fillbuf(struct net_bridge *br, void *buf,
 			continue;
 
 		/* ignore pseudo entry for local MAC address */
-		if (!f->dst)
+		dst = READ_ONCE(f->dst);
+		if (!dst)
 			continue;
 
 		if (skip) {
@@ -818,8 +824,8 @@ int br_fdb_fillbuf(struct net_bridge *br, void *buf,
 		memcpy(fe->mac_addr, f->key.addr.addr, ETH_ALEN);
 
 		/* due to ABI compat need to split into hi/lo */
-		fe->port_no = f->dst->port_no;
-		fe->port_hi = f->dst->port_no >> 8;
+		fe->port_no = dst->port_no;
+		fe->port_hi = dst->port_no >> 8;
 
 		fe->is_local = test_bit(BR_FDB_LOCAL, &f->flags);
 		if (!test_bit(BR_FDB_STATIC, &f->flags)) {
@@ -940,9 +946,11 @@ int br_fdb_dump(struct sk_buff *skb,
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(f, &br->fdb_list, fdb_node) {
+		const struct net_bridge_port *dst = READ_ONCE(f->dst);
+
 		if (*idx < cb->args[2])
 			goto skip;
-		if (filter_dev && (!f->dst || f->dst->dev != filter_dev)) {
+		if (filter_dev && (!dst || dst->dev != filter_dev)) {
 			if (filter_dev != dev)
 				goto skip;
 			/* !f->dst is a special case for bridge
@@ -950,10 +958,10 @@ int br_fdb_dump(struct sk_buff *skb,
 			 * Therefore need a little more filtering
 			 * we only want to dump the !f->dst case
 			 */
-			if (f->dst)
+			if (dst)
 				goto skip;
 		}
-		if (!filter_dev && f->dst)
+		if (!filter_dev && dst)
 			goto skip;
 
 		err = fdb_fill_info(skb, br, f,
-- 
2.53.0


