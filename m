Return-Path: <stable+bounces-246627-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aI7+GZV1A2rf5wEAu9opvQ
	(envelope-from <stable+bounces-246627-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:46:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1A452818A
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6100331870A
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCA034572B;
	Tue, 12 May 2026 18:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z8IUAWG8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCD3342501;
	Tue, 12 May 2026 18:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609708; cv=none; b=m5dOTIbmgq3cozzUh4iwcdaWWmYmor5BzLYI+OLJN7tY9QhLolD+eIhVcelAcg6KaEfQYtnCE0aPxzlovjEkf/jpOMMx1qIc8CgF37QYrDhT9JSAWOgplM2Oq/yJjxKUWSBednrufGBlmmyKknUSDDCdeJ1kDEaEweyF3pHHeq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609708; c=relaxed/simple;
	bh=1+0iHQ+QdAZNaZE1cSyzsP+XA/V8k+cf9AGhZyVPDvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sj3jQIKEHbtaClrZE8Od8ArrrEe99WBk+/DPR2gY90wGKZtJUUUYetOdkyOAz8yaWKotS5VsNaG5OPUWg3RHGM4FoMTlhR7GjKp+/DWK6L7f/0pN2YQQl3cKR8uGtlaV0/M0Gm+3GmFYTzPeFFw8/t2/eQlRKsc/XQoYn0kGoNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z8IUAWG8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A3FC2BCB0;
	Tue, 12 May 2026 18:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778609707;
	bh=1+0iHQ+QdAZNaZE1cSyzsP+XA/V8k+cf9AGhZyVPDvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=z8IUAWG8IJAJ4w81WdGP8uEgzy+2Jsogum5tUC4FFcZIFBTP1duQHIebEGKDgHT0C
	 lFYisCmdVF8bkGZ8FSExmi6lRMqIqGQa54IGUTFKEh4X59l2Ht6BNRHfopGyrfFKp9
	 14ss62zKVA34Gf8iGFNv868er0OmgtopX7DZ5Qpg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Yuan Tan <yuantan098@gmail.com>,
	Longxuan Yu <ylong030@ucr.edu>,
	Ren Wei <n05ec@lzu.edu.cn>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 301/307] 8021q: delete cleared egress QoS mappings
Date: Tue, 12 May 2026 19:41:36 +0200
Message-ID: <20260512173946.486024055@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173940.117428952@linuxfoundation.org>
References: <20260512173940.117428952@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EC1A452818A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-246627-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,gmail.com,lzu.edu.cn,ucr.edu,redhat.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,ucr.edu:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,lzu.edu.cn:email]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Longxuan Yu <ylong030@ucr.edu>

[ Upstream commit 7dddc74af369478ba7f9bc136d0fc1dc4570cb66 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/8021q/vlan_dev.c     |   20 ++++++++++++++------
 net/8021q/vlan_netlink.c |    4 ----
 2 files changed, 14 insertions(+), 10 deletions(-)

--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -172,26 +172,34 @@ int vlan_dev_set_egress_priority(const s
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
--- a/net/8021q/vlan_netlink.c
+++ b/net/8021q/vlan_netlink.c
@@ -263,10 +263,6 @@ static int vlan_fill_info(struct sk_buff
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



