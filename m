Return-Path: <stable+bounces-139912-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B723AAA21B
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B12D417A262
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 22:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A528F27FD67;
	Mon,  5 May 2025 22:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DGtoKwJJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522E92D5CFC;
	Mon,  5 May 2025 22:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483662; cv=none; b=Kk2pf34QSvbHlJ1A+tETO8oOoFU4vZyia4joWmCbBjRRx8y6CktwfKL3DZBW4EE0jHoR0D2Pc9TtuhVmnLwV8HSVxm4lk+sXSCNZhaQgHfBM6NjDyJn6PyYm2x5WNF0mvjwWLZTlcyRQruubCcLBwxfYZbdBpsIvGqnZAkprJ6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483662; c=relaxed/simple;
	bh=+Gr4Y3Y8+JdvMO7YzjtjUSjG+X3RPJF7oWxj8Pnnan4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fRYZN7l2igGohyEpvTD9tkTD9xRQJiKjW8iNMb/PRQ/Vz772s/tR68wOYdVylO1zC4B0inAWq71Ukw0uByz3gwGzPVocAr3L7Fmhrp+N7MtPdLqNsmBjf1cnpbzwCg1N479Z7fU3V8CyqWrDTqTvEi1XLxdGwYBycNgsAf67PmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DGtoKwJJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82553C4CEE4;
	Mon,  5 May 2025 22:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483662;
	bh=+Gr4Y3Y8+JdvMO7YzjtjUSjG+X3RPJF7oWxj8Pnnan4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DGtoKwJJh1ic4JBTQBQtjKz6DYCsAtK6e8ZF6bIHpFYs/tWu9mL1zp1+3G/MDdpLE
	 1a0O+2YWzZ1tMYQZmt7Ka9HcciPnLRIy4BgSNAgOpxRp5xiVEkOIPWMswGZXaLnSu/
	 opEXb6YUnDN0VmphLdazff1k28eWWL6shpQUqDwsubcPxz9qBdg+tVUCttnJonHmMB
	 zIB3xZPmOReoLmlNQkmMV6l5Uisd7hNDxHatvAsEME9cz9IYvkoBUq0Cer/1B4sTjz
	 RoXeOaZAHxeyMBBka8cjroGZVr8HZ8jO1J/W24zyq20E8XZ3pjciFjECfx/qi2akQV
	 oUBZ1aekr1nug==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jaakko Karrenpalo <jkarrenpalo@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	danishanwar@ti.com,
	aleksander.lobakin@intel.com,
	lukma@denx.de,
	m-karicheri2@ti.com,
	w-kwok2@ti.com,
	wojciech.drewek@intel.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 165/642] net: hsr: Fix PRP duplicate detection
Date: Mon,  5 May 2025 18:06:21 -0400
Message-Id: <20250505221419.2672473-165-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Jaakko Karrenpalo <jkarrenpalo@gmail.com>

[ Upstream commit 05fd00e5e7b1ac60d264f72423fba38cc382b447 ]

Add PRP specific function for handling duplicate
packets. This is needed because of potential
L2 802.1p prioritization done by network switches.

The L2 prioritization can re-order the PRP packets
from a node causing the existing implementation to
discard the frame(s) that have been received 'late'
because the sequence number is before the previous
received packet. This can happen if the node is
sending multiple frames back-to-back with different
priority.

Signed-off-by: Jaakko Karrenpalo <jkarrenpalo@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250307161700.1045-1-jkarrenpalo@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/hsr/hsr_device.c   |  2 +
 net/hsr/hsr_forward.c  |  4 +-
 net/hsr/hsr_framereg.c | 95 ++++++++++++++++++++++++++++++++++++++++--
 net/hsr/hsr_framereg.h |  8 +++-
 net/hsr/hsr_main.h     |  2 +
 5 files changed, 104 insertions(+), 7 deletions(-)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index b6fb18469439a..2c43776b7c4fb 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -616,6 +616,7 @@ static struct hsr_proto_ops hsr_ops = {
 	.drop_frame = hsr_drop_frame,
 	.fill_frame_info = hsr_fill_frame_info,
 	.invalid_dan_ingress_frame = hsr_invalid_dan_ingress_frame,
+	.register_frame_out = hsr_register_frame_out,
 };
 
 static struct hsr_proto_ops prp_ops = {
@@ -626,6 +627,7 @@ static struct hsr_proto_ops prp_ops = {
 	.fill_frame_info = prp_fill_frame_info,
 	.handle_san_frame = prp_handle_san_frame,
 	.update_san_info = prp_update_san_info,
+	.register_frame_out = prp_register_frame_out,
 };
 
 void hsr_dev_setup(struct net_device *dev)
diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index a4bacf1985558..c67c0d35921de 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -536,8 +536,8 @@ static void hsr_forward_do(struct hsr_frame_info *frame)
 		 * Also for SAN, this shouldn't be done.
 		 */
 		if (!frame->is_from_san &&
-		    hsr_register_frame_out(port, frame->node_src,
-					   frame->sequence_nr))
+		    hsr->proto_ops->register_frame_out &&
+		    hsr->proto_ops->register_frame_out(port, frame))
 			continue;
 
 		if (frame->is_supervision && port->type == HSR_PT_MASTER &&
diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index 73bc6f659812f..85991fab7db58 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -35,6 +35,7 @@ static bool seq_nr_after(u16 a, u16 b)
 
 #define seq_nr_before(a, b)		seq_nr_after((b), (a))
 #define seq_nr_before_or_eq(a, b)	(!seq_nr_after((a), (b)))
+#define PRP_DROP_WINDOW_LEN 32768
 
 bool hsr_addr_is_redbox(struct hsr_priv *hsr, unsigned char *addr)
 {
@@ -176,8 +177,11 @@ static struct hsr_node *hsr_add_node(struct hsr_priv *hsr,
 		new_node->time_in[i] = now;
 		new_node->time_out[i] = now;
 	}
-	for (i = 0; i < HSR_PT_PORTS; i++)
+	for (i = 0; i < HSR_PT_PORTS; i++) {
 		new_node->seq_out[i] = seq_out;
+		new_node->seq_expected[i] = seq_out + 1;
+		new_node->seq_start[i] = seq_out + 1;
+	}
 
 	if (san && hsr->proto_ops->handle_san_frame)
 		hsr->proto_ops->handle_san_frame(san, rx_port, new_node);
@@ -482,9 +486,11 @@ void hsr_register_frame_in(struct hsr_node *node, struct hsr_port *port,
  *	 0 otherwise, or
  *	 negative error code on error
  */
-int hsr_register_frame_out(struct hsr_port *port, struct hsr_node *node,
-			   u16 sequence_nr)
+int hsr_register_frame_out(struct hsr_port *port, struct hsr_frame_info *frame)
 {
+	struct hsr_node *node = frame->node_src;
+	u16 sequence_nr = frame->sequence_nr;
+
 	spin_lock_bh(&node->seq_out_lock);
 	if (seq_nr_before_or_eq(sequence_nr, node->seq_out[port->type]) &&
 	    time_is_after_jiffies(node->time_out[port->type] +
@@ -499,6 +505,89 @@ int hsr_register_frame_out(struct hsr_port *port, struct hsr_node *node,
 	return 0;
 }
 
+/* Adaptation of the PRP duplicate discard algorithm described in wireshark
+ * wiki (https://wiki.wireshark.org/PRP)
+ *
+ * A drop window is maintained for both LANs with start sequence set to the
+ * first sequence accepted on the LAN that has not been seen on the other LAN,
+ * and expected sequence set to the latest received sequence number plus one.
+ *
+ * When a frame is received on either LAN it is compared against the received
+ * frames on the other LAN. If it is outside the drop window of the other LAN
+ * the frame is accepted and the drop window is updated.
+ * The drop window for the other LAN is reset.
+ *
+ * 'port' is the outgoing interface
+ * 'frame' is the frame to be sent
+ *
+ * Return:
+ *	 1 if frame can be shown to have been sent recently on this interface,
+ *	 0 otherwise
+ */
+int prp_register_frame_out(struct hsr_port *port, struct hsr_frame_info *frame)
+{
+	enum hsr_port_type other_port;
+	enum hsr_port_type rcv_port;
+	struct hsr_node *node;
+	u16 sequence_diff;
+	u16 sequence_exp;
+	u16 sequence_nr;
+
+	/* out-going frames are always in order
+	 * and can be checked the same way as for HSR
+	 */
+	if (frame->port_rcv->type == HSR_PT_MASTER)
+		return hsr_register_frame_out(port, frame);
+
+	/* for PRP we should only forward frames from the slave ports
+	 * to the master port
+	 */
+	if (port->type != HSR_PT_MASTER)
+		return 1;
+
+	node = frame->node_src;
+	sequence_nr = frame->sequence_nr;
+	sequence_exp = sequence_nr + 1;
+	rcv_port = frame->port_rcv->type;
+	other_port = rcv_port == HSR_PT_SLAVE_A ? HSR_PT_SLAVE_B :
+				 HSR_PT_SLAVE_A;
+
+	spin_lock_bh(&node->seq_out_lock);
+	if (time_is_before_jiffies(node->time_out[port->type] +
+	    msecs_to_jiffies(HSR_ENTRY_FORGET_TIME)) ||
+	    (node->seq_start[rcv_port] == node->seq_expected[rcv_port] &&
+	     node->seq_start[other_port] == node->seq_expected[other_port])) {
+		/* the node hasn't been sending for a while
+		 * or both drop windows are empty, forward the frame
+		 */
+		node->seq_start[rcv_port] = sequence_nr;
+	} else if (seq_nr_before(sequence_nr, node->seq_expected[other_port]) &&
+		   seq_nr_before_or_eq(node->seq_start[other_port], sequence_nr)) {
+		/* drop the frame, update the drop window for the other port
+		 * and reset our drop window
+		 */
+		node->seq_start[other_port] = sequence_exp;
+		node->seq_expected[rcv_port] = sequence_exp;
+		node->seq_start[rcv_port] = node->seq_expected[rcv_port];
+		spin_unlock_bh(&node->seq_out_lock);
+		return 1;
+	}
+
+	/* update the drop window for the port where this frame was received
+	 * and clear the drop window for the other port
+	 */
+	node->seq_start[other_port] = node->seq_expected[other_port];
+	node->seq_expected[rcv_port] = sequence_exp;
+	sequence_diff = sequence_exp - node->seq_start[rcv_port];
+	if (sequence_diff > PRP_DROP_WINDOW_LEN)
+		node->seq_start[rcv_port] = sequence_exp - PRP_DROP_WINDOW_LEN;
+
+	node->time_out[port->type] = jiffies;
+	node->seq_out[port->type] = sequence_nr;
+	spin_unlock_bh(&node->seq_out_lock);
+	return 0;
+}
+
 static struct hsr_port *get_late_port(struct hsr_priv *hsr,
 				      struct hsr_node *node)
 {
diff --git a/net/hsr/hsr_framereg.h b/net/hsr/hsr_framereg.h
index 993fa950d8144..b04948659d84d 100644
--- a/net/hsr/hsr_framereg.h
+++ b/net/hsr/hsr_framereg.h
@@ -44,8 +44,7 @@ void hsr_addr_subst_dest(struct hsr_node *node_src, struct sk_buff *skb,
 
 void hsr_register_frame_in(struct hsr_node *node, struct hsr_port *port,
 			   u16 sequence_nr);
-int hsr_register_frame_out(struct hsr_port *port, struct hsr_node *node,
-			   u16 sequence_nr);
+int hsr_register_frame_out(struct hsr_port *port, struct hsr_frame_info *frame);
 
 void hsr_prune_nodes(struct timer_list *t);
 void hsr_prune_proxy_nodes(struct timer_list *t);
@@ -73,6 +72,8 @@ void prp_update_san_info(struct hsr_node *node, bool is_sup);
 bool hsr_is_node_in_db(struct list_head *node_db,
 		       const unsigned char addr[ETH_ALEN]);
 
+int prp_register_frame_out(struct hsr_port *port, struct hsr_frame_info *frame);
+
 struct hsr_node {
 	struct list_head	mac_list;
 	/* Protect R/W access to seq_out */
@@ -89,6 +90,9 @@ struct hsr_node {
 	bool			san_b;
 	u16			seq_out[HSR_PT_PORTS];
 	bool			removed;
+	/* PRP specific duplicate handling */
+	u16			seq_expected[HSR_PT_PORTS];
+	u16			seq_start[HSR_PT_PORTS];
 	struct rcu_head		rcu_head;
 };
 
diff --git a/net/hsr/hsr_main.h b/net/hsr/hsr_main.h
index 7561845b8bf6f..1bc47b17a2968 100644
--- a/net/hsr/hsr_main.h
+++ b/net/hsr/hsr_main.h
@@ -175,6 +175,8 @@ struct hsr_proto_ops {
 			       struct hsr_frame_info *frame);
 	bool (*invalid_dan_ingress_frame)(__be16 protocol);
 	void (*update_san_info)(struct hsr_node *node, bool is_sup);
+	int (*register_frame_out)(struct hsr_port *port,
+				  struct hsr_frame_info *frame);
 };
 
 struct hsr_self_node {
-- 
2.39.5


