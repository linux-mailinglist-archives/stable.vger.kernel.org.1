Return-Path: <stable+bounces-122316-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F8FA59F1C
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99F373A3BB6
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364A9231A51;
	Mon, 10 Mar 2025 17:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EuIO2Z6Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90B82253FE;
	Mon, 10 Mar 2025 17:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741628150; cv=none; b=tfRkGtH0vEIbhhiyQY69Um602iHX7Jn4Fw79HW61vz1Pz5DVZFjyr8jNyU8IbEjC36Qdv+rrkhNxHNJo5qRfdOcR/liRK6SXt3eBkZ+wzfN1ElthHVh2j6PtlLGBOl/9LsSkULKDikb4rpQMWg9dftLoUdEDwQat0SxBTag6KVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741628150; c=relaxed/simple;
	bh=2eEuBdfP7N6j+C+ttqdD7ETJ0cnrFS9hsBtdnKEePls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XaVLdRUgsaIifTJ/7zRNXmGwxBCb7/DK+UHgJB1ylOjXv4dYuEOiGeyS6pAODXaRCgLhghK7n+v8oBsXoIUL5sOiK5L7rsTxCWgOjtF7PhlGrm1c9xeUSkew1YVgVlCaXWpNKO5IpCdla6LNJrdhpvHsx/8jT81Ut/yb5ypVEnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EuIO2Z6Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B317C4CEE5;
	Mon, 10 Mar 2025 17:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741628149;
	bh=2eEuBdfP7N6j+C+ttqdD7ETJ0cnrFS9hsBtdnKEePls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EuIO2Z6ZQyhr0MMLKjbPXU1JrsST7Xo+J5oGVv5G5Sz7afF9S0GqU9n5rszIw2eGj
	 TOQW8Cu/ue/SsUas056IG0LLPAOLP2GNtge6HkqIQdm/z5cObHyGzo5nEVr9H/XV4I
	 FHuvzD2bluU6tGRJ3f8V82PktkwgLc5V8E3cTA3U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+da65c993ae113742a25f@syzkaller.appspotmail.com,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 072/145] llc: do not use skb_get() before dev_queue_xmit()
Date: Mon, 10 Mar 2025 18:06:06 +0100
Message-ID: <20250310170437.656826693@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170434.733307314@linuxfoundation.org>
References: <20250310170434.733307314@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 64e6a754d33d31aa844b3ee66fb93ac84ca1565e ]

syzbot is able to crash hosts [1], using llc and devices
not supporting IFF_TX_SKB_SHARING.

In this case, e1000 driver calls eth_skb_pad(), while
the skb is shared.

Simply replace skb_get() by skb_clone() in net/llc/llc_s_ac.c

Note that e1000 driver might have an issue with pktgen,
because it does not clear IFF_TX_SKB_SHARING, this is an
orthogonal change.

We need to audit other skb_get() uses in net/llc.

[1]

kernel BUG at net/core/skbuff.c:2178 !
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 16371 Comm: syz.2.2764 Not tainted 6.14.0-rc4-syzkaller-00052-gac9c34d1e45a #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
 RIP: 0010:pskb_expand_head+0x6ce/0x1240 net/core/skbuff.c:2178
Call Trace:
 <TASK>
  __skb_pad+0x18a/0x610 net/core/skbuff.c:2466
  __skb_put_padto include/linux/skbuff.h:3843 [inline]
  skb_put_padto include/linux/skbuff.h:3862 [inline]
  eth_skb_pad include/linux/etherdevice.h:656 [inline]
  e1000_xmit_frame+0x2d99/0x5800 drivers/net/ethernet/intel/e1000/e1000_main.c:3128
  __netdev_start_xmit include/linux/netdevice.h:5151 [inline]
  netdev_start_xmit include/linux/netdevice.h:5160 [inline]
  xmit_one net/core/dev.c:3806 [inline]
  dev_hard_start_xmit+0x9a/0x7b0 net/core/dev.c:3822
  sch_direct_xmit+0x1ae/0xc30 net/sched/sch_generic.c:343
  __dev_xmit_skb net/core/dev.c:4045 [inline]
  __dev_queue_xmit+0x13d4/0x43e0 net/core/dev.c:4621
  dev_queue_xmit include/linux/netdevice.h:3313 [inline]
  llc_sap_action_send_test_c+0x268/0x320 net/llc/llc_s_ac.c:144
  llc_exec_sap_trans_actions net/llc/llc_sap.c:153 [inline]
  llc_sap_next_state net/llc/llc_sap.c:182 [inline]
  llc_sap_state_process+0x239/0x510 net/llc/llc_sap.c:209
  llc_ui_sendmsg+0xd0d/0x14e0 net/llc/af_llc.c:993
  sock_sendmsg_nosec net/socket.c:718 [inline]

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+da65c993ae113742a25f@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/67c020c0.050a0220.222324.0011.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/llc/llc_s_ac.c | 49 +++++++++++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/net/llc/llc_s_ac.c b/net/llc/llc_s_ac.c
index 06fb8e6944b06..7a0cae9a81114 100644
--- a/net/llc/llc_s_ac.c
+++ b/net/llc/llc_s_ac.c
@@ -24,7 +24,7 @@
 #include <net/llc_s_ac.h>
 #include <net/llc_s_ev.h>
 #include <net/llc_sap.h>
-
+#include <net/sock.h>
 
 /**
  *	llc_sap_action_unitdata_ind - forward UI PDU to network layer
@@ -40,6 +40,26 @@ int llc_sap_action_unitdata_ind(struct llc_sap *sap, struct sk_buff *skb)
 	return 0;
 }
 
+static int llc_prepare_and_xmit(struct sk_buff *skb)
+{
+	struct llc_sap_state_ev *ev = llc_sap_ev(skb);
+	struct sk_buff *nskb;
+	int rc;
+
+	rc = llc_mac_hdr_init(skb, ev->saddr.mac, ev->daddr.mac);
+	if (rc)
+		return rc;
+
+	nskb = skb_clone(skb, GFP_ATOMIC);
+	if (!nskb)
+		return -ENOMEM;
+
+	if (skb->sk)
+		skb_set_owner_w(nskb, skb->sk);
+
+	return dev_queue_xmit(nskb);
+}
+
 /**
  *	llc_sap_action_send_ui - sends UI PDU resp to UNITDATA REQ to MAC layer
  *	@sap: SAP
@@ -52,17 +72,12 @@ int llc_sap_action_unitdata_ind(struct llc_sap *sap, struct sk_buff *skb)
 int llc_sap_action_send_ui(struct llc_sap *sap, struct sk_buff *skb)
 {
 	struct llc_sap_state_ev *ev = llc_sap_ev(skb);
-	int rc;
 
 	llc_pdu_header_init(skb, LLC_PDU_TYPE_U, ev->saddr.lsap,
 			    ev->daddr.lsap, LLC_PDU_CMD);
 	llc_pdu_init_as_ui_cmd(skb);
-	rc = llc_mac_hdr_init(skb, ev->saddr.mac, ev->daddr.mac);
-	if (likely(!rc)) {
-		skb_get(skb);
-		rc = dev_queue_xmit(skb);
-	}
-	return rc;
+
+	return llc_prepare_and_xmit(skb);
 }
 
 /**
@@ -77,17 +92,12 @@ int llc_sap_action_send_ui(struct llc_sap *sap, struct sk_buff *skb)
 int llc_sap_action_send_xid_c(struct llc_sap *sap, struct sk_buff *skb)
 {
 	struct llc_sap_state_ev *ev = llc_sap_ev(skb);
-	int rc;
 
 	llc_pdu_header_init(skb, LLC_PDU_TYPE_U_XID, ev->saddr.lsap,
 			    ev->daddr.lsap, LLC_PDU_CMD);
 	llc_pdu_init_as_xid_cmd(skb, LLC_XID_NULL_CLASS_2, 0);
-	rc = llc_mac_hdr_init(skb, ev->saddr.mac, ev->daddr.mac);
-	if (likely(!rc)) {
-		skb_get(skb);
-		rc = dev_queue_xmit(skb);
-	}
-	return rc;
+
+	return llc_prepare_and_xmit(skb);
 }
 
 /**
@@ -133,17 +143,12 @@ int llc_sap_action_send_xid_r(struct llc_sap *sap, struct sk_buff *skb)
 int llc_sap_action_send_test_c(struct llc_sap *sap, struct sk_buff *skb)
 {
 	struct llc_sap_state_ev *ev = llc_sap_ev(skb);
-	int rc;
 
 	llc_pdu_header_init(skb, LLC_PDU_TYPE_U, ev->saddr.lsap,
 			    ev->daddr.lsap, LLC_PDU_CMD);
 	llc_pdu_init_as_test_cmd(skb);
-	rc = llc_mac_hdr_init(skb, ev->saddr.mac, ev->daddr.mac);
-	if (likely(!rc)) {
-		skb_get(skb);
-		rc = dev_queue_xmit(skb);
-	}
-	return rc;
+
+	return llc_prepare_and_xmit(skb);
 }
 
 int llc_sap_action_send_test_r(struct llc_sap *sap, struct sk_buff *skb)
-- 
2.39.5




