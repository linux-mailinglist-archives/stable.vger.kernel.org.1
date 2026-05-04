Return-Path: <stable+bounces-242907-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJ9WM2dc+GnatQIAu9opvQ
	(envelope-from <stable+bounces-242907-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 10:44:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 803934BA6EB
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 10:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C16C30088A5
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 08:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2083451CC;
	Mon,  4 May 2026 08:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vRxTbMpz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61815344DB7
	for <stable@vger.kernel.org>; Mon,  4 May 2026 08:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777884259; cv=none; b=tImix4FvuVeT0IJ75x21OYUckKK0ncNBbVyM/WJf+pgSD6prtVWx6TlOGSgf5Wl8g+UlCt3+k8m1LPv3yv+hzLRJq3cVxMW0o8UH1Ck4O7GJ8Zqz+8a781koMJIxyqZhBI5yw5GbkoTTHDh5LW6pyrynwAkfXL8l9JF4eG5KgA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777884259; c=relaxed/simple;
	bh=7aY0oLHOz3Rb/ZVXiP2+yMu8emcn9C5+AF6e5T7V+vs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=I9SoOjzXqfMvWe0mV2s3Swba4gZWv7N6dJ7fB3Ybd304jfVq36x0w0EOWrH3zfNFSXbvhdOYDg7aCmKmxdpeEvgfSYx7Wo7ezyR0haD0KXney8MbVCRjDU5B8Bf6B+MhrCyaCbINovbM2QP1Il5zM2+D4DMV9FEvZZIKnJzySXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vRxTbMpz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA1ADC2BCB8;
	Mon,  4 May 2026 08:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777884259;
	bh=7aY0oLHOz3Rb/ZVXiP2+yMu8emcn9C5+AF6e5T7V+vs=;
	h=Subject:To:Cc:From:Date:From;
	b=vRxTbMpzNNb44EXHSE1bZRIB+8cEuNnqapsAL1KhM209d9mEbrYTIcQp7DIb6xjqa
	 KywcAY5WpEZdgITNBqPZQ/kRbMOHs5L3iDkNsuEQZf0qHDD/o7G/MDlXJx8fatZuj2
	 X8SKzc1cq2SNYq8r5Ru7/qX1WLeMBhxQY5u/qPwU=
Subject: FAILED: patch "[PATCH] 8021q: delete cleared egress QoS mappings" failed to apply to 6.1-stable tree
To: ylong030@ucr.edu,bird@lzu.edu.cn,n05ec@lzu.edu.cn,pabeni@redhat.com,tomapufckgml@gmail.com,yifanwucs@gmail.com,yuantan098@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 04 May 2026 10:44:10 +0200
Message-ID: <2026050410-squirt-upper-3593@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 803934BA6EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242907-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[ucr.edu,lzu.edu.cn,redhat.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,lzu.edu.cn:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 7dddc74af369478ba7f9bc136d0fc1dc4570cb66
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050410-squirt-upper-3593@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7dddc74af369478ba7f9bc136d0fc1dc4570cb66 Mon Sep 17 00:00:00 2001
From: Longxuan Yu <ylong030@ucr.edu>
Date: Mon, 20 Apr 2026 11:18:46 +0800
Subject: [PATCH] 8021q: delete cleared egress QoS mappings

vlan_dev_set_egress_priority() currently keeps cleared egress
priority mappings in the hash as tombstones. Repeated set/clear cycles
with distinct skb priorities therefore accumulate mapping nodes until
device teardown and leak memory.

Delete mappings when vlan_prio is cleared instead of keeping tombstones.
Now that the egress mapping lists are RCU protected, the node can be
unlinked safely and freed after a grace period.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@kernel.org
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Co-developed-by: Yuan Tan <yuantan098@gmail.com>
Signed-off-by: Yuan Tan <yuantan098@gmail.com>
Signed-off-by: Longxuan Yu <ylong030@ucr.edu>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Link: https://patch.msgid.link/ecfa6f6ce2467a42647ff4c5221238ae85b79a59.1776647968.git.yuantan098@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index a5340932b657..7aa3af8b10ea 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -172,26 +172,34 @@ int vlan_dev_set_egress_priority(const struct net_device *dev,
 				 u32 skb_prio, u16 vlan_prio)
 {
 	struct vlan_dev_priv *vlan = vlan_dev_priv(dev);
+	struct vlan_priority_tci_mapping __rcu **mpp;
 	struct vlan_priority_tci_mapping *mp;
 	struct vlan_priority_tci_mapping *np;
 	u32 bucket = skb_prio & 0xF;
 	u32 vlan_qos = (vlan_prio << VLAN_PRIO_SHIFT) & VLAN_PRIO_MASK;
 
 	/* See if a priority mapping exists.. */
-	mp = rtnl_dereference(vlan->egress_priority_map[bucket]);
+	mpp = &vlan->egress_priority_map[bucket];
+	mp = rtnl_dereference(*mpp);
 	while (mp) {
 		if (mp->priority == skb_prio) {
-			if (mp->vlan_qos && !vlan_qos)
+			if (!vlan_qos) {
+				rcu_assign_pointer(*mpp, rtnl_dereference(mp->next));
 				vlan->nr_egress_mappings--;
-			else if (!mp->vlan_qos && vlan_qos)
-				vlan->nr_egress_mappings++;
-			WRITE_ONCE(mp->vlan_qos, vlan_qos);
+				kfree_rcu(mp, rcu);
+			} else {
+				WRITE_ONCE(mp->vlan_qos, vlan_qos);
+			}
 			return 0;
 		}
-		mp = rtnl_dereference(mp->next);
+		mpp = &mp->next;
+		mp = rtnl_dereference(*mpp);
 	}
 
 	/* Create a new mapping then. */
+	if (!vlan_qos)
+		return 0;
+
 	np = kmalloc_obj(struct vlan_priority_tci_mapping);
 	if (!np)
 		return -ENOBUFS;
diff --git a/net/8021q/vlan_netlink.c b/net/8021q/vlan_netlink.c
index a5b16833e2ce..368d53ca7d87 100644
--- a/net/8021q/vlan_netlink.c
+++ b/net/8021q/vlan_netlink.c
@@ -263,10 +263,6 @@ static int vlan_fill_info(struct sk_buff *skb, const struct net_device *dev)
 			for (pm = rcu_dereference_rtnl(vlan->egress_priority_map[i]); pm;
 			     pm = rcu_dereference_rtnl(pm->next)) {
 				u16 vlan_qos = READ_ONCE(pm->vlan_qos);
-
-				if (!vlan_qos)
-					continue;
-
 				m.from = pm->priority;
 				m.to   = (vlan_qos >> 13) & 0x7;
 				if (nla_put(skb, IFLA_VLAN_QOS_MAPPING,


