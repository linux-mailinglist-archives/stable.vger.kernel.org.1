Return-Path: <stable+bounces-244864-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JrnFYqE/mlYsQAAu9opvQ
	(envelope-from <stable+bounces-244864-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 02:49:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A98F44FD1D4
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 02:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46D223016529
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 00:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EC322D792;
	Sat,  9 May 2026 00:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VqBf0Cr9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C3B18A92F
	for <stable@vger.kernel.org>; Sat,  9 May 2026 00:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778287751; cv=none; b=UcSa9/NAWmDYYx3dvcWSgsH6phmBoHPyqaK9nJ3/ngKjTyhlEVCXAX0R2fk6aesvs6OvyKlEKTvtt4e1Q0mzgW99lAmEscDDkyC8GjXxDuCH0fMMjO8OO22UqEkpCa9X7aqZ29TNYccTJl/V1UAkag+AXpX+8yTFp3uxRUL5V9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778287751; c=relaxed/simple;
	bh=je0QOvlYju3v6GKYGtVPDezMHi47SPorcg+YF1dU168=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ogzLWF4WQz5nRc2CbX4i150mGuEw+HJAfGVHXU37olN9DHCFLU8EWMbzCSgT3QbFgdtaIJhtrQJAFX5D8lfDCPKLsjEeS9YNi6m70Jvb8mjCwDWNe8ZoGaTXfIsFihxmTer8DIhvaW9hkr6kokok7Lk6eTJ9u/gBu5pSZDAU0V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VqBf0Cr9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F5B2C2BCB0;
	Sat,  9 May 2026 00:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778287751;
	bh=je0QOvlYju3v6GKYGtVPDezMHi47SPorcg+YF1dU168=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VqBf0Cr9e50+xj+HUN5JJYYlcXFTRhbtM4aYzmhnS7K5SCbz9jUW9g5eAYL3Oi/5s
	 cs9904XorSk4IhwYG8vp18c/VlJ+gHVhBedFTfX11U2uUDMM2V8Np6XWJvBT6jVH0u
	 mooG45nhv2fD3prYUkGi3Z0LrCJERj0vN23SC7wK4Bx4lQx8vNL96kxiBp87FecW7o
	 tEbwjgITVosGFQUR2XBGNJSfsBU44j4DU78PsxOJZYImmRfdQRvg40rWdifCnzVbb+
	 sdP5YDSicyedWdOQkkQaCK4YcTh1KSaba1Lufb6pnFEZSCu/QpBjDxGphQUt7R8JQo
	 QLV0VlhqC0zbQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Longxuan Yu <ylong030@ucr.edu>,
	Yuan Tan <yuantan098@gmail.com>,
	Ren Wei <n05ec@lzu.edu.cn>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0.y 1/2] 8021q: use RCU for egress QoS mappings
Date: Fri,  8 May 2026 20:49:06 -0400
Message-ID: <20260509004907.2449764-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050408-speak-purging-28a1@gregkh>
References: <2026050408-speak-purging-28a1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A98F44FD1D4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[ucr.edu,gmail.com,lzu.edu.cn,redhat.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-244864-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ucr.edu:email,lzu.edu.cn:email]
X-Rspamd-Action: no action

From: Longxuan Yu <ylong030@ucr.edu>

[ Upstream commit fc69decc811b155a0ed8eef17ee940f28c4f6dbc ]

The TX fast path and reporting paths walk egress QoS mappings without
RTNL. Convert the mapping lists to RCU-protected pointers, use RCU
reader annotations in readers, and defer freeing mapping nodes with an
embedded rcu_head.

This prepares the egress QoS mapping code for safe removal of mapping
nodes in a follow-up change while preserving the current behavior.

Co-developed-by: Yuan Tan <yuantan098@gmail.com>
Signed-off-by: Yuan Tan <yuantan098@gmail.com>
Signed-off-by: Longxuan Yu <ylong030@ucr.edu>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Link: https://patch.msgid.link/9136768189f8c6d3f824f476c62d2fa1111688e8.1776647968.git.yuantan098@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Stable-dep-of: 7dddc74af369 ("8021q: delete cleared egress QoS mappings")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/if_vlan.h  | 25 ++++++++++++++++---------
 net/8021q/vlan_dev.c     | 31 ++++++++++++++++---------------
 net/8021q/vlan_netlink.c | 10 ++++++----
 net/8021q/vlanproc.c     | 12 ++++++++----
 4 files changed, 46 insertions(+), 32 deletions(-)

diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index e6272f9c5e42c..20cc16ea4e5ab 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -147,11 +147,13 @@ extern __be16 vlan_dev_vlan_proto(const struct net_device *dev);
  *	@priority: skb priority
  *	@vlan_qos: vlan priority: (skb->priority << 13) & 0xE000
  *	@next: pointer to next struct
+ *	@rcu: used for deferred freeing of mapping nodes
  */
 struct vlan_priority_tci_mapping {
 	u32					priority;
 	u16					vlan_qos;
-	struct vlan_priority_tci_mapping	*next;
+	struct vlan_priority_tci_mapping __rcu	*next;
+	struct rcu_head			rcu;
 };
 
 struct proc_dir_entry;
@@ -177,7 +179,7 @@ struct vlan_dev_priv {
 	unsigned int				nr_ingress_mappings;
 	u32					ingress_priority_map[8];
 	unsigned int				nr_egress_mappings;
-	struct vlan_priority_tci_mapping	*egress_priority_map[16];
+	struct vlan_priority_tci_mapping __rcu	*egress_priority_map[16];
 
 	__be16					vlan_proto;
 	u16					vlan_id;
@@ -209,19 +211,24 @@ static inline u16
 vlan_dev_get_egress_qos_mask(struct net_device *dev, u32 skprio)
 {
 	struct vlan_priority_tci_mapping *mp;
+	u16 vlan_qos = 0;
 
-	smp_rmb(); /* coupled with smp_wmb() in vlan_dev_set_egress_priority() */
+	rcu_read_lock();
 
-	mp = vlan_dev_priv(dev)->egress_priority_map[(skprio & 0xF)];
+	mp = rcu_dereference(vlan_dev_priv(dev)->egress_priority_map[skprio & 0xF]);
 	while (mp) {
 		if (mp->priority == skprio) {
-			return mp->vlan_qos; /* This should already be shifted
-					      * to mask correctly with the
-					      * VLAN's TCI */
+			vlan_qos = READ_ONCE(mp->vlan_qos);
+			break;
 		}
-		mp = mp->next;
+		mp = rcu_dereference(mp->next);
 	}
-	return 0;
+	rcu_read_unlock();
+
+	/* This should already be shifted to mask correctly with
+	 * the VLAN's TCI.
+	 */
+	return vlan_qos;
 }
 
 extern bool vlan_do_receive(struct sk_buff **skb);
diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index c40f7d5c4fca5..a5340932b657a 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -172,39 +172,34 @@ int vlan_dev_set_egress_priority(const struct net_device *dev,
 				 u32 skb_prio, u16 vlan_prio)
 {
 	struct vlan_dev_priv *vlan = vlan_dev_priv(dev);
-	struct vlan_priority_tci_mapping *mp = NULL;
+	struct vlan_priority_tci_mapping *mp;
 	struct vlan_priority_tci_mapping *np;
+	u32 bucket = skb_prio & 0xF;
 	u32 vlan_qos = (vlan_prio << VLAN_PRIO_SHIFT) & VLAN_PRIO_MASK;
 
 	/* See if a priority mapping exists.. */
-	mp = vlan->egress_priority_map[skb_prio & 0xF];
+	mp = rtnl_dereference(vlan->egress_priority_map[bucket]);
 	while (mp) {
 		if (mp->priority == skb_prio) {
 			if (mp->vlan_qos && !vlan_qos)
 				vlan->nr_egress_mappings--;
 			else if (!mp->vlan_qos && vlan_qos)
 				vlan->nr_egress_mappings++;
-			mp->vlan_qos = vlan_qos;
+			WRITE_ONCE(mp->vlan_qos, vlan_qos);
 			return 0;
 		}
-		mp = mp->next;
+		mp = rtnl_dereference(mp->next);
 	}
 
 	/* Create a new mapping then. */
-	mp = vlan->egress_priority_map[skb_prio & 0xF];
 	np = kmalloc_obj(struct vlan_priority_tci_mapping);
 	if (!np)
 		return -ENOBUFS;
 
-	np->next = mp;
 	np->priority = skb_prio;
 	np->vlan_qos = vlan_qos;
-	/* Before inserting this element in hash table, make sure all its fields
-	 * are committed to memory.
-	 * coupled with smp_rmb() in vlan_dev_get_egress_qos_mask()
-	 */
-	smp_wmb();
-	vlan->egress_priority_map[skb_prio & 0xF] = np;
+	RCU_INIT_POINTER(np->next, rtnl_dereference(vlan->egress_priority_map[bucket]));
+	rcu_assign_pointer(vlan->egress_priority_map[bucket], np);
 	if (vlan_qos)
 		vlan->nr_egress_mappings++;
 	return 0;
@@ -604,11 +599,17 @@ void vlan_dev_free_egress_priority(const struct net_device *dev)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(vlan->egress_priority_map); i++) {
-		while ((pm = vlan->egress_priority_map[i]) != NULL) {
-			vlan->egress_priority_map[i] = pm->next;
-			kfree(pm);
+		pm = rtnl_dereference(vlan->egress_priority_map[i]);
+		RCU_INIT_POINTER(vlan->egress_priority_map[i], NULL);
+		while (pm) {
+			struct vlan_priority_tci_mapping *next;
+
+			next = rtnl_dereference(pm->next);
+			kfree_rcu(pm, rcu);
+			pm = next;
 		}
 	}
+	vlan->nr_egress_mappings = 0;
 }
 
 static void vlan_dev_uninit(struct net_device *dev)
diff --git a/net/8021q/vlan_netlink.c b/net/8021q/vlan_netlink.c
index a000b1ef05206..a5b16833e2cee 100644
--- a/net/8021q/vlan_netlink.c
+++ b/net/8021q/vlan_netlink.c
@@ -260,13 +260,15 @@ static int vlan_fill_info(struct sk_buff *skb, const struct net_device *dev)
 			goto nla_put_failure;
 
 		for (i = 0; i < ARRAY_SIZE(vlan->egress_priority_map); i++) {
-			for (pm = vlan->egress_priority_map[i]; pm;
-			     pm = pm->next) {
-				if (!pm->vlan_qos)
+			for (pm = rcu_dereference_rtnl(vlan->egress_priority_map[i]); pm;
+			     pm = rcu_dereference_rtnl(pm->next)) {
+				u16 vlan_qos = READ_ONCE(pm->vlan_qos);
+
+				if (!vlan_qos)
 					continue;
 
 				m.from = pm->priority;
-				m.to   = (pm->vlan_qos >> 13) & 0x7;
+				m.to   = (vlan_qos >> 13) & 0x7;
 				if (nla_put(skb, IFLA_VLAN_QOS_MAPPING,
 					    sizeof(m), &m))
 					goto nla_put_failure;
diff --git a/net/8021q/vlanproc.c b/net/8021q/vlanproc.c
index fa67374bda494..0e424e0895b7e 100644
--- a/net/8021q/vlanproc.c
+++ b/net/8021q/vlanproc.c
@@ -262,15 +262,19 @@ static int vlandev_seq_show(struct seq_file *seq, void *offset)
 		   vlan->ingress_priority_map[7]);
 
 	seq_printf(seq, " EGRESS priority mappings: ");
+	rcu_read_lock();
 	for (i = 0; i < 16; i++) {
-		const struct vlan_priority_tci_mapping *mp
-			= vlan->egress_priority_map[i];
+		const struct vlan_priority_tci_mapping *mp =
+			rcu_dereference(vlan->egress_priority_map[i]);
 		while (mp) {
+			u16 vlan_qos = READ_ONCE(mp->vlan_qos);
+
 			seq_printf(seq, "%u:%d ",
-				   mp->priority, ((mp->vlan_qos >> 13) & 0x7));
-			mp = mp->next;
+				   mp->priority, ((vlan_qos >> 13) & 0x7));
+			mp = rcu_dereference(mp->next);
 		}
 	}
+	rcu_read_unlock();
 	seq_puts(seq, "\n");
 
 	return 0;
-- 
2.53.0


