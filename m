Return-Path: <stable+bounces-74189-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 824FE972DF2
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 11:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6E231C244C8
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 09:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F60A188CDC;
	Tue, 10 Sep 2024 09:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1UaG6ksH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF16A1885A6;
	Tue, 10 Sep 2024 09:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725961075; cv=none; b=bZZ67/CfT+KdobfFzNaMfO61DlIAmg68CV/eaUsWZLFePmIO4xurkdhcgGm4N9I4o6P5hmAxDXd28DzlSqExwPTlVFSP7jfTSZHP9gR9Ysy9yY+6QBw1qBok5+HnifUKFi1n9YAjY6Ii58gGKcmZtaHaLcVm+jc9n+MASclNg+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725961075; c=relaxed/simple;
	bh=fYOYzPP/Cw5Ix38OeWN/sKono/aM59Uy3TDtYrKnIyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dUwEdnu+ZmfQGct52hz3ueUlTcCoJetSHCKV4bv7e7Q2stAHjiqsp3Cg/Ttjq2oTL1ou6mxRSg8+SBqMYkVUQoh6pp+A2+t7hZrtMphPxyjyaa3Qj41f6aeclyiGEcy4hy7nXTQdRajD/0H2Mbi4jJwO/0LRIHoU533Qrx8bNxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1UaG6ksH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C5D9C4CEC6;
	Tue, 10 Sep 2024 09:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725961074;
	bh=fYOYzPP/Cw5Ix38OeWN/sKono/aM59Uy3TDtYrKnIyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1UaG6ksH3/UKWuPM2PSC0M9gjHNTw/777XPnugJgvsHoEB/HFUS/GZt7bW9qihnzR
	 s3/R31POTpRw00ueqZwComWrheq/Ner31ni+yH2dXpi5UEmJZnseiikij/BqSx6YKR
	 QQCyMIam7lONJCF5Xq2T0JK/ByT1/3WgR/DugN48=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 45/96] net: bridge: fdb: convert is_local to bitops
Date: Tue, 10 Sep 2024 11:31:47 +0200
Message-ID: <20240910092543.519891302@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092541.383432924@linuxfoundation.org>
References: <20240910092541.383432924@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

[ Upstream commit 6869c3b02b596eba931a754f56875d2e2ac612db ]

The patch adds a new fdb flags field in the hole between the two cache
lines and uses it to convert is_local to bitops.

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: bee2ef946d31 ("net: bridge: br_fdb_external_learn_add(): always set EXT_LEARN")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bridge/br_fdb.c     | 32 +++++++++++++++++++-------------
 net/bridge/br_input.c   |  2 +-
 net/bridge/br_private.h |  9 +++++++--
 3 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index a659e7c4ee43..f01ccf6ca4f4 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -255,7 +255,8 @@ void br_fdb_find_delete_local(struct net_bridge *br,
 
 	spin_lock_bh(&br->hash_lock);
 	f = br_fdb_find(br, addr, vid);
-	if (f && f->is_local && !f->added_by_user && f->dst == p)
+	if (f && test_bit(BR_FDB_LOCAL, &f->flags) &&
+	    !f->added_by_user && f->dst == p)
 		fdb_delete_local(br, p, f);
 	spin_unlock_bh(&br->hash_lock);
 }
@@ -270,7 +271,8 @@ void br_fdb_changeaddr(struct net_bridge_port *p, const unsigned char *newaddr)
 	spin_lock_bh(&br->hash_lock);
 	vg = nbp_vlan_group(p);
 	hlist_for_each_entry(f, &br->fdb_list, fdb_node) {
-		if (f->dst == p && f->is_local && !f->added_by_user) {
+		if (f->dst == p && test_bit(BR_FDB_LOCAL, &f->flags) &&
+		    !f->added_by_user) {
 			/* delete old one */
 			fdb_delete_local(br, p, f);
 
@@ -311,7 +313,8 @@ void br_fdb_change_mac_address(struct net_bridge *br, const u8 *newaddr)
 
 	/* If old entry was unassociated with any port, then delete it. */
 	f = br_fdb_find(br, br->dev->dev_addr, 0);
-	if (f && f->is_local && !f->dst && !f->added_by_user)
+	if (f && test_bit(BR_FDB_LOCAL, &f->flags) &&
+	    !f->dst && !f->added_by_user)
 		fdb_delete_local(br, NULL, f);
 
 	fdb_insert(br, NULL, newaddr, 0);
@@ -326,7 +329,8 @@ void br_fdb_change_mac_address(struct net_bridge *br, const u8 *newaddr)
 		if (!br_vlan_should_use(v))
 			continue;
 		f = br_fdb_find(br, br->dev->dev_addr, v->vid);
-		if (f && f->is_local && !f->dst && !f->added_by_user)
+		if (f && test_bit(BR_FDB_LOCAL, &f->flags) &&
+		    !f->dst && !f->added_by_user)
 			fdb_delete_local(br, NULL, f);
 		fdb_insert(br, NULL, newaddr, v->vid);
 	}
@@ -405,7 +409,7 @@ void br_fdb_delete_by_port(struct net_bridge *br,
 			if (f->is_static || (vid && f->key.vlan_id != vid))
 				continue;
 
-		if (f->is_local)
+		if (test_bit(BR_FDB_LOCAL, &f->flags))
 			fdb_delete_local(br, p, f);
 		else
 			fdb_delete(br, f, true);
@@ -474,7 +478,7 @@ int br_fdb_fillbuf(struct net_bridge *br, void *buf,
 		fe->port_no = f->dst->port_no;
 		fe->port_hi = f->dst->port_no >> 8;
 
-		fe->is_local = f->is_local;
+		fe->is_local = test_bit(BR_FDB_LOCAL, &f->flags);
 		if (!f->is_static)
 			fe->ageing_timer_value = jiffies_delta_to_clock_t(jiffies - f->updated);
 		++fe;
@@ -499,7 +503,9 @@ static struct net_bridge_fdb_entry *fdb_create(struct net_bridge *br,
 		memcpy(fdb->key.addr.addr, addr, ETH_ALEN);
 		fdb->dst = source;
 		fdb->key.vlan_id = vid;
-		fdb->is_local = is_local;
+		fdb->flags = 0;
+		if (is_local)
+			set_bit(BR_FDB_LOCAL, &fdb->flags);
 		fdb->is_static = is_static;
 		fdb->added_by_user = 0;
 		fdb->added_by_external_learn = 0;
@@ -530,7 +536,7 @@ static int fdb_insert(struct net_bridge *br, struct net_bridge_port *source,
 		/* it is okay to have multiple ports with same
 		 * address, just use the first one.
 		 */
-		if (fdb->is_local)
+		if (test_bit(BR_FDB_LOCAL, &fdb->flags))
 			return 0;
 		br_warn(br, "adding interface %s with same address as a received packet (addr:%pM, vlan:%u)\n",
 		       source ? source->dev->name : br->dev->name, addr, vid);
@@ -576,7 +582,7 @@ void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
 	fdb = fdb_find_rcu(&br->fdb_hash_tbl, addr, vid);
 	if (likely(fdb)) {
 		/* attempt to update an entry for a local interface */
-		if (unlikely(fdb->is_local)) {
+		if (unlikely(test_bit(BR_FDB_LOCAL, &fdb->flags))) {
 			if (net_ratelimit())
 				br_warn(br, "received packet on %s with own address as source address (addr:%pM, vlan:%u)\n",
 					source->dev->name, addr, vid);
@@ -620,7 +626,7 @@ void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
 static int fdb_to_nud(const struct net_bridge *br,
 		      const struct net_bridge_fdb_entry *fdb)
 {
-	if (fdb->is_local)
+	if (test_bit(BR_FDB_LOCAL, &fdb->flags))
 		return NUD_PERMANENT;
 	else if (fdb->is_static)
 		return NUD_NOARP;
@@ -818,19 +824,19 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_port *source,
 
 	if (fdb_to_nud(br, fdb) != state) {
 		if (state & NUD_PERMANENT) {
-			fdb->is_local = 1;
+			set_bit(BR_FDB_LOCAL, &fdb->flags);
 			if (!fdb->is_static) {
 				fdb->is_static = 1;
 				fdb_add_hw_addr(br, addr);
 			}
 		} else if (state & NUD_NOARP) {
-			fdb->is_local = 0;
+			clear_bit(BR_FDB_LOCAL, &fdb->flags);
 			if (!fdb->is_static) {
 				fdb->is_static = 1;
 				fdb_add_hw_addr(br, addr);
 			}
 		} else {
-			fdb->is_local = 0;
+			clear_bit(BR_FDB_LOCAL, &fdb->flags);
 			if (fdb->is_static) {
 				fdb->is_static = 0;
 				fdb_del_hw_addr(br, addr);
diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index f3938337ff87..e126ba0bd486 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -163,7 +163,7 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 	if (dst) {
 		unsigned long now = jiffies;
 
-		if (dst->is_local)
+		if (test_bit(BR_FDB_LOCAL, &dst->flags))
 			return br_pass_frame_up(skb);
 
 		if (now != dst->used)
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index f5e258ca3043..6a38ea247a9e 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -168,6 +168,11 @@ struct net_bridge_vlan_group {
 	u16				pvid;
 };
 
+/* bridge fdb flags */
+enum {
+	BR_FDB_LOCAL,
+};
+
 struct net_bridge_fdb_key {
 	mac_addr addr;
 	u16 vlan_id;
@@ -179,8 +184,8 @@ struct net_bridge_fdb_entry {
 
 	struct net_bridge_fdb_key	key;
 	struct hlist_node		fdb_node;
-	unsigned char			is_local:1,
-					is_static:1,
+	unsigned long			flags;
+	unsigned char			is_static:1,
 					is_sticky:1,
 					added_by_user:1,
 					added_by_external_learn:1,
-- 
2.43.0




