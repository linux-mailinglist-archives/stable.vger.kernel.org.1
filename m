Return-Path: <stable+bounces-214203-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id X+qKBOpug2lgmwMAu9opvQ
	(envelope-from <stable+bounces-214203-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 17:08:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A50DBE9EA0
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 17:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 684013078F5F
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B587342AA9;
	Wed,  4 Feb 2026 15:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vBp6vgQI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791B221ABC9;
	Wed,  4 Feb 2026 15:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218908; cv=none; b=GPZxuAEBfeLznmp7jsrERNz79HXdaOD1iXcs5EvGwhYWEZo0Wcx5cDo3vP+/q6q8oLSUWgGo5Z5ikTeK/OZSXhC7JK0xRXsXP57UDxfTs+JVTfQpx9yL0NTf74vxiOE1OsFdD2euerZ5Dw70MTYKVXY57p1WZa+sboJEmmjwN6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218908; c=relaxed/simple;
	bh=kDpaH8U9SywpTyc0L7oUFs+ZkhwheUzVTTSJs6mO850=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iRiF4MA7bDCQDM23oZn8DG0aQxyJzwxxwJHY2APYhQpYCAvLv2rAPn6rGa2LrnE8rTBhgh3Hi061/mo6qPdfVHnHfVLS5a3yx9GuPEpYiUVT6lRQ86Qrq4QlCAQyPdW8AulkzOHBm9Uy0m1odUX08xqTne1BzKGWgDojRBKwZtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vBp6vgQI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9338C4CEF7;
	Wed,  4 Feb 2026 15:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770218908;
	bh=kDpaH8U9SywpTyc0L7oUFs+ZkhwheUzVTTSJs6mO850=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vBp6vgQIXGsDj3mHd1vLW3HLVDFfP/Qg2+WmgxHNHJvHUXTDYnX3gIAWt4h8vbfg4
	 nDmSGGWc28l/rp0lIiNOwUV1NFCc4ldf1Wk21xtFefCA3Zv11yc5rPZeX3QqqAPV2o
	 PnsrYrjywf3+OoPaqfcEyLhlzokW0zIkiCvyNvKI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	syzbot <syzkaller@googlegroups.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 010/122] bonding: annotate data-races around slave->last_rx
Date: Wed,  4 Feb 2026 15:39:52 +0100
Message-ID: <20260204143852.236300788@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143851.857060534@linuxfoundation.org>
References: <20260204143851.857060534@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214203-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlegroups.com:email,msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: A50DBE9EA0
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit f6c3665b6dc53c3ab7d31b585446a953a74340ef ]

slave->last_rx and slave->target_last_arp_rx[...] can be read and written
locklessly. Add READ_ONCE() and WRITE_ONCE() annotations.

syzbot reported:

BUG: KCSAN: data-race in bond_rcv_validate / bond_rcv_validate

write to 0xffff888149f0d428 of 8 bytes by interrupt on cpu 1:
  bond_rcv_validate+0x202/0x7a0 drivers/net/bonding/bond_main.c:3335
  bond_handle_frame+0xde/0x5e0 drivers/net/bonding/bond_main.c:1533
  __netif_receive_skb_core+0x5b1/0x1950 net/core/dev.c:6039
  __netif_receive_skb_one_core net/core/dev.c:6150 [inline]
  __netif_receive_skb+0x59/0x270 net/core/dev.c:6265
  netif_receive_skb_internal net/core/dev.c:6351 [inline]
  netif_receive_skb+0x4b/0x2d0 net/core/dev.c:6410
...

write to 0xffff888149f0d428 of 8 bytes by interrupt on cpu 0:
  bond_rcv_validate+0x202/0x7a0 drivers/net/bonding/bond_main.c:3335
  bond_handle_frame+0xde/0x5e0 drivers/net/bonding/bond_main.c:1533
  __netif_receive_skb_core+0x5b1/0x1950 net/core/dev.c:6039
  __netif_receive_skb_one_core net/core/dev.c:6150 [inline]
  __netif_receive_skb+0x59/0x270 net/core/dev.c:6265
  netif_receive_skb_internal net/core/dev.c:6351 [inline]
  netif_receive_skb+0x4b/0x2d0 net/core/dev.c:6410
  br_netif_receive_skb net/bridge/br_input.c:30 [inline]
  NF_HOOK include/linux/netfilter.h:318 [inline]
...

value changed: 0x0000000100005365 -> 0x0000000100005366

Fixes: f5b2b966f032 ("[PATCH] bonding: Validate probe replies in ARP monitor")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Link: https://patch.msgid.link/20260122162914.2299312-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/bonding/bond_main.c    | 18 ++++++++++--------
 drivers/net/bonding/bond_options.c |  8 ++++----
 include/net/bonding.h              | 13 +++++++------
 3 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 595fda2444b1f..99adfffcca044 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -3138,8 +3138,8 @@ static void bond_validate_arp(struct bonding *bond, struct slave *slave, __be32
 			   __func__, &sip);
 		return;
 	}
-	slave->last_rx = jiffies;
-	slave->target_last_arp_rx[i] = jiffies;
+	WRITE_ONCE(slave->last_rx, jiffies);
+	WRITE_ONCE(slave->target_last_arp_rx[i], jiffies);
 }
 
 static int bond_arp_rcv(const struct sk_buff *skb, struct bonding *bond,
@@ -3358,8 +3358,8 @@ static void bond_validate_na(struct bonding *bond, struct slave *slave,
 			  __func__, saddr);
 		return;
 	}
-	slave->last_rx = jiffies;
-	slave->target_last_arp_rx[i] = jiffies;
+	WRITE_ONCE(slave->last_rx, jiffies);
+	WRITE_ONCE(slave->target_last_arp_rx[i], jiffies);
 }
 
 static int bond_na_rcv(const struct sk_buff *skb, struct bonding *bond,
@@ -3429,7 +3429,7 @@ int bond_rcv_validate(const struct sk_buff *skb, struct bonding *bond,
 		    (slave_do_arp_validate_only(bond) && is_ipv6) ||
 #endif
 		    !slave_do_arp_validate_only(bond))
-			slave->last_rx = jiffies;
+			WRITE_ONCE(slave->last_rx, jiffies);
 		return RX_HANDLER_ANOTHER;
 	} else if (is_arp) {
 		return bond_arp_rcv(skb, bond, slave);
@@ -3497,7 +3497,7 @@ static void bond_loadbalance_arp_mon(struct bonding *bond)
 
 		if (slave->link != BOND_LINK_UP) {
 			if (bond_time_in_interval(bond, last_tx, 1) &&
-			    bond_time_in_interval(bond, slave->last_rx, 1)) {
+			    bond_time_in_interval(bond, READ_ONCE(slave->last_rx), 1)) {
 
 				bond_propose_link_state(slave, BOND_LINK_UP);
 				slave_state_changed = 1;
@@ -3521,8 +3521,10 @@ static void bond_loadbalance_arp_mon(struct bonding *bond)
 			 * when the source ip is 0, so don't take the link down
 			 * if we don't know our ip yet
 			 */
-			if (!bond_time_in_interval(bond, last_tx, bond->params.missed_max) ||
-			    !bond_time_in_interval(bond, slave->last_rx, bond->params.missed_max)) {
+			if (!bond_time_in_interval(bond, last_tx,
+						   bond->params.missed_max) ||
+			    !bond_time_in_interval(bond, READ_ONCE(slave->last_rx),
+						   bond->params.missed_max)) {
 
 				bond_propose_link_state(slave, BOND_LINK_DOWN);
 				slave_state_changed = 1;
diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
index 384499c869b8d..f1c6e9d8f6167 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -1152,7 +1152,7 @@ static void _bond_options_arp_ip_target_set(struct bonding *bond, int slot,
 
 	if (slot >= 0 && slot < BOND_MAX_ARP_TARGETS) {
 		bond_for_each_slave(bond, slave, iter)
-			slave->target_last_arp_rx[slot] = last_rx;
+			WRITE_ONCE(slave->target_last_arp_rx[slot], last_rx);
 		targets[slot] = target;
 	}
 }
@@ -1221,8 +1221,8 @@ static int bond_option_arp_ip_target_rem(struct bonding *bond, __be32 target)
 	bond_for_each_slave(bond, slave, iter) {
 		targets_rx = slave->target_last_arp_rx;
 		for (i = ind; (i < BOND_MAX_ARP_TARGETS-1) && targets[i+1]; i++)
-			targets_rx[i] = targets_rx[i+1];
-		targets_rx[i] = 0;
+			WRITE_ONCE(targets_rx[i], READ_ONCE(targets_rx[i+1]));
+		WRITE_ONCE(targets_rx[i], 0);
 	}
 	for (i = ind; (i < BOND_MAX_ARP_TARGETS-1) && targets[i+1]; i++)
 		targets[i] = targets[i+1];
@@ -1377,7 +1377,7 @@ static void _bond_options_ns_ip6_target_set(struct bonding *bond, int slot,
 
 	if (slot >= 0 && slot < BOND_MAX_NS_TARGETS) {
 		bond_for_each_slave(bond, slave, iter) {
-			slave->target_last_arp_rx[slot] = last_rx;
+			WRITE_ONCE(slave->target_last_arp_rx[slot], last_rx);
 			slave_set_ns_maddr(bond, slave, target, &targets[slot]);
 		}
 		targets[slot] = *target;
diff --git a/include/net/bonding.h b/include/net/bonding.h
index 49edc7da05867..4620784035570 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -521,13 +521,14 @@ static inline int bond_is_ip6_target_ok(struct in6_addr *addr)
 static inline unsigned long slave_oldest_target_arp_rx(struct bonding *bond,
 						       struct slave *slave)
 {
+	unsigned long tmp, ret = READ_ONCE(slave->target_last_arp_rx[0]);
 	int i = 1;
-	unsigned long ret = slave->target_last_arp_rx[0];
-
-	for (; (i < BOND_MAX_ARP_TARGETS) && bond->params.arp_targets[i]; i++)
-		if (time_before(slave->target_last_arp_rx[i], ret))
-			ret = slave->target_last_arp_rx[i];
 
+	for (; (i < BOND_MAX_ARP_TARGETS) && bond->params.arp_targets[i]; i++) {
+		tmp = READ_ONCE(slave->target_last_arp_rx[i]);
+		if (time_before(tmp, ret))
+			ret = tmp;
+	}
 	return ret;
 }
 
@@ -537,7 +538,7 @@ static inline unsigned long slave_last_rx(struct bonding *bond,
 	if (bond->params.arp_all_targets == BOND_ARP_TARGETS_ALL)
 		return slave_oldest_target_arp_rx(bond, slave);
 
-	return slave->last_rx;
+	return READ_ONCE(slave->last_rx);
 }
 
 static inline void slave_update_last_tx(struct slave *slave)
-- 
2.51.0




