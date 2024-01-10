Return-Path: <stable+bounces-10319-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D37482745D
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 16:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 229341C22E83
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 15:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B3753E1A;
	Mon,  8 Jan 2024 15:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qfXqqeZ3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3784C602;
	Mon,  8 Jan 2024 15:44:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 532BAC433C7;
	Mon,  8 Jan 2024 15:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704728673;
	bh=yNVTm5J+b5cq9oBu/weRLjREVVL+VFaz9p5nzxnIZ2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qfXqqeZ3pJIuJGZpJfMmNhSW/+pKOJiYvyG8o64RzxwEG2igf6sohZtIh1Js/WlxL
	 Z/jbP4w8LiuroDZyUPYvYnphyecbaqwlXRhpvuNivZVuxRO4OCjnyEUBr7z7FZEyB0
	 inwuK+yXehyUAP8qjkx+jSemC0Ixhpmhyq6peulo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vlad Buslov <vladbu@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 123/150] net/sched: act_ct: offload UDP NEW connections
Date: Mon,  8 Jan 2024 16:36:14 +0100
Message-ID: <20240108153516.870712194@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108153511.214254205@linuxfoundation.org>
References: <20240108153511.214254205@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vlad Buslov <vladbu@nvidia.com>

[ Upstream commit 6a9bad0069cf306f3df6ac53cf02438d4e15f296 ]

Modify the offload algorithm of UDP connections to the following:

- Offload NEW connection as unidirectional.

- When connection state changes to ESTABLISHED also update the hardware
flow. However, in order to prevent act_ct from spamming offload add wq for
every packet coming in reply direction in this state verify whether
connection has already been updated to ESTABLISHED in the drivers. If that
it the case, then skip flow_table and let conntrack handle such packets
which will also allow conntrack to potentially promote the connection to
ASSURED.

- When connection state changes to ASSURED set the flow_table flow
NF_FLOW_HW_BIDIRECTIONAL flag which will cause refresh mechanism to offload
the reply direction.

All other protocols have their offload algorithm preserved and are always
offloaded as bidirectional.

Note that this change tries to minimize the load on flow_table add
workqueue. First, it tracks the last ctinfo that was offloaded by using new
flow 'NF_FLOW_HW_ESTABLISHED' flag and doesn't schedule the refresh for
reply direction packets when the offloads have already been updated with
current ctinfo. Second, when 'add' task executes on workqueue it always
update the offload with current flow state (by checking 'bidirectional'
flow flag and obtaining actual ctinfo/cookie through meta action instead of
caching any of these from the moment of scheduling the 'add' work)
preventing the need from scheduling more updates if state changed
concurrently while the 'add' work was pending on workqueue.

Signed-off-by: Vlad Buslov <vladbu@nvidia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 125f1c7f26ff ("net/sched: act_ct: Take per-cb reference to tcf_ct_flow_table")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/act_ct.c | 51 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 39 insertions(+), 12 deletions(-)

diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index 86d269724485a..3c063065f125f 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -365,7 +365,7 @@ static void tcf_ct_flow_tc_ifidx(struct flow_offload *entry,
 
 static void tcf_ct_flow_table_add(struct tcf_ct_flow_table *ct_ft,
 				  struct nf_conn *ct,
-				  bool tcp)
+				  bool tcp, bool bidirectional)
 {
 	struct nf_conn_act_ct_ext *act_ct_ext;
 	struct flow_offload *entry;
@@ -384,6 +384,8 @@ static void tcf_ct_flow_table_add(struct tcf_ct_flow_table *ct_ft,
 		ct->proto.tcp.seen[0].flags |= IP_CT_TCP_FLAG_BE_LIBERAL;
 		ct->proto.tcp.seen[1].flags |= IP_CT_TCP_FLAG_BE_LIBERAL;
 	}
+	if (bidirectional)
+		__set_bit(NF_FLOW_HW_BIDIRECTIONAL, &entry->flags);
 
 	act_ct_ext = nf_conn_act_ct_ext_find(ct);
 	if (act_ct_ext) {
@@ -407,26 +409,34 @@ static void tcf_ct_flow_table_process_conn(struct tcf_ct_flow_table *ct_ft,
 					   struct nf_conn *ct,
 					   enum ip_conntrack_info ctinfo)
 {
-	bool tcp = false;
-
-	if ((ctinfo != IP_CT_ESTABLISHED && ctinfo != IP_CT_ESTABLISHED_REPLY) ||
-	    !test_bit(IPS_ASSURED_BIT, &ct->status))
-		return;
+	bool tcp = false, bidirectional = true;
 
 	switch (nf_ct_protonum(ct)) {
 	case IPPROTO_TCP:
-		tcp = true;
-		if (ct->proto.tcp.state != TCP_CONNTRACK_ESTABLISHED)
+		if ((ctinfo != IP_CT_ESTABLISHED &&
+		     ctinfo != IP_CT_ESTABLISHED_REPLY) ||
+		    !test_bit(IPS_ASSURED_BIT, &ct->status) ||
+		    ct->proto.tcp.state != TCP_CONNTRACK_ESTABLISHED)
 			return;
+
+		tcp = true;
 		break;
 	case IPPROTO_UDP:
+		if (!nf_ct_is_confirmed(ct))
+			return;
+		if (!test_bit(IPS_ASSURED_BIT, &ct->status))
+			bidirectional = false;
 		break;
 #ifdef CONFIG_NF_CT_PROTO_GRE
 	case IPPROTO_GRE: {
 		struct nf_conntrack_tuple *tuple;
 
-		if (ct->status & IPS_NAT_MASK)
+		if ((ctinfo != IP_CT_ESTABLISHED &&
+		     ctinfo != IP_CT_ESTABLISHED_REPLY) ||
+		    !test_bit(IPS_ASSURED_BIT, &ct->status) ||
+		    ct->status & IPS_NAT_MASK)
 			return;
+
 		tuple = &ct->tuplehash[IP_CT_DIR_ORIGINAL].tuple;
 		/* No support for GRE v1 */
 		if (tuple->src.u.gre.key || tuple->dst.u.gre.key)
@@ -442,7 +452,7 @@ static void tcf_ct_flow_table_process_conn(struct tcf_ct_flow_table *ct_ft,
 	    ct->status & IPS_SEQ_ADJUST)
 		return;
 
-	tcf_ct_flow_table_add(ct_ft, ct, tcp);
+	tcf_ct_flow_table_add(ct_ft, ct, tcp, bidirectional);
 }
 
 static bool
@@ -621,13 +631,30 @@ static bool tcf_ct_flow_table_lookup(struct tcf_ct_params *p,
 	flow = container_of(tuplehash, struct flow_offload, tuplehash[dir]);
 	ct = flow->ct;
 
+	if (dir == FLOW_OFFLOAD_DIR_REPLY &&
+	    !test_bit(NF_FLOW_HW_BIDIRECTIONAL, &flow->flags)) {
+		/* Only offload reply direction after connection became
+		 * assured.
+		 */
+		if (test_bit(IPS_ASSURED_BIT, &ct->status))
+			set_bit(NF_FLOW_HW_BIDIRECTIONAL, &flow->flags);
+		else if (test_bit(NF_FLOW_HW_ESTABLISHED, &flow->flags))
+			/* If flow_table flow has already been updated to the
+			 * established state, then don't refresh.
+			 */
+			return false;
+	}
+
 	if (tcph && (unlikely(tcph->fin || tcph->rst))) {
 		flow_offload_teardown(flow);
 		return false;
 	}
 
-	ctinfo = dir == FLOW_OFFLOAD_DIR_ORIGINAL ? IP_CT_ESTABLISHED :
-						    IP_CT_ESTABLISHED_REPLY;
+	if (dir == FLOW_OFFLOAD_DIR_ORIGINAL)
+		ctinfo = test_bit(IPS_SEEN_REPLY_BIT, &ct->status) ?
+			IP_CT_ESTABLISHED : IP_CT_NEW;
+	else
+		ctinfo = IP_CT_ESTABLISHED_REPLY;
 
 	flow_offload_refresh(nf_ft, flow);
 	nf_conntrack_get(&ct->ct_general);
-- 
2.43.0




