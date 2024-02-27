Return-Path: <stable+bounces-24532-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8188694FC
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0F2F1C2858D
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 13:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2752713B791;
	Tue, 27 Feb 2024 13:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dnMg0GiA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA46113B2B4;
	Tue, 27 Feb 2024 13:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709042270; cv=none; b=rcvau38WlaSPTU+9DfNQ1hEdxkCfppjW1ypjbxsbXRXR3NKa7lhCNmo0n3joYDxgr4HKuaqNPffnUOltxYotLHKKcVnukiJBmH6zERV6r92/e9bvJZziTkOtd6bzX2s8phOP/OTO0KFAmNvnj7gfQYBvE3jgRL6FqYa6grDssgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709042270; c=relaxed/simple;
	bh=1w2F1V4oZfgDyXBDAO1GwGKZsYIHyoSyOTkKKBxjTh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nz0WHlxKKkmedr7oIaPtnQAneONc/O1Ho1AJG6Ow8GWum1bDpXv2UB0qHJJHf9TVwtGkhjFLhsl8+Hro0UerYxZ1pfu8gKB6+zalxLSfFWSKWlDVQyHLmbvc5Vr/232ejZqwEEJvwreTFXjM6mi+c4WIjDy2zW9jl6bvZMWfVFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dnMg0GiA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66AD1C433C7;
	Tue, 27 Feb 2024 13:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709042270;
	bh=1w2F1V4oZfgDyXBDAO1GwGKZsYIHyoSyOTkKKBxjTh8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dnMg0GiA48zlXmSxUpgtTin+7rsnbj6PX8GW2oX+Qyvwx4YRfJxV+fKN8HnVquxfi
	 unamxaYc888XT3jeGuL7olrT1asrTnqniYop+fzqwP2x3eTuz6wRN6n5nNzsgy6hs7
	 /14yJcUwbkRMNfuNqyEyOp1Bntm/1iE0YN8/I1pE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Pedro Tammela <pctammela@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 238/299] net/sched: act_mirred: Create function tcf_mirred_to_dev and improve readability
Date: Tue, 27 Feb 2024 14:25:49 +0100
Message-ID: <20240227131633.395946795@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131625.847743063@linuxfoundation.org>
References: <20240227131625.847743063@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Victor Nogueira <victor@mojatatu.com>

[ Upstream commit 16085e48cb48aeb50a1178dc276747749910b0f2 ]

As a preparation for adding block ID to mirred, separate the part of
mirred that redirect/mirrors to a dev into a specific function so that it
can be called by blockcast for each dev.

Also improve readability. Eg. rename use_reinsert to dont_clone and skb2
to skb_to_send.

Co-developed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 52f671db1882 ("net/sched: act_mirred: use the backlog for mirred ingress")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/act_mirred.c | 129 +++++++++++++++++++++++------------------
 1 file changed, 72 insertions(+), 57 deletions(-)

diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index 0a711c184c29b..6f2544c1e3961 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -225,48 +225,26 @@ static int tcf_mirred_forward(bool want_ingress, struct sk_buff *skb)
 	return err;
 }
 
-TC_INDIRECT_SCOPE int tcf_mirred_act(struct sk_buff *skb,
-				     const struct tc_action *a,
-				     struct tcf_result *res)
+static int tcf_mirred_to_dev(struct sk_buff *skb, struct tcf_mirred *m,
+			     struct net_device *dev,
+			     const bool m_mac_header_xmit, int m_eaction,
+			     int retval)
 {
-	struct tcf_mirred *m = to_mirred(a);
-	struct sk_buff *skb2 = skb;
-	bool m_mac_header_xmit;
-	struct net_device *dev;
-	unsigned int nest_level;
-	int retval, err = 0;
-	bool use_reinsert;
+	struct sk_buff *skb_to_send = skb;
 	bool want_ingress;
 	bool is_redirect;
 	bool expects_nh;
 	bool at_ingress;
-	int m_eaction;
+	bool dont_clone;
 	int mac_len;
 	bool at_nh;
+	int err;
 
-	nest_level = __this_cpu_inc_return(mirred_nest_level);
-	if (unlikely(nest_level > MIRRED_NEST_LIMIT)) {
-		net_warn_ratelimited("Packet exceeded mirred recursion limit on dev %s\n",
-				     netdev_name(skb->dev));
-		__this_cpu_dec(mirred_nest_level);
-		return TC_ACT_SHOT;
-	}
-
-	tcf_lastuse_update(&m->tcf_tm);
-	tcf_action_update_bstats(&m->common, skb);
-
-	m_mac_header_xmit = READ_ONCE(m->tcfm_mac_header_xmit);
-	m_eaction = READ_ONCE(m->tcfm_eaction);
-	retval = READ_ONCE(m->tcf_action);
-	dev = rcu_dereference_bh(m->tcfm_dev);
-	if (unlikely(!dev)) {
-		pr_notice_once("tc mirred: target device is gone\n");
-		goto out;
-	}
-
+	is_redirect = tcf_mirred_is_act_redirect(m_eaction);
 	if (unlikely(!(dev->flags & IFF_UP)) || !netif_carrier_ok(dev)) {
 		net_notice_ratelimited("tc mirred to Houston: device %s is down\n",
 				       dev->name);
+		err = -ENODEV;
 		goto out;
 	}
 
@@ -274,61 +252,98 @@ TC_INDIRECT_SCOPE int tcf_mirred_act(struct sk_buff *skb,
 	 * since we can't easily detect the clsact caller, skip clone only for
 	 * ingress - that covers the TC S/W datapath.
 	 */
-	is_redirect = tcf_mirred_is_act_redirect(m_eaction);
 	at_ingress = skb_at_tc_ingress(skb);
-	use_reinsert = at_ingress && is_redirect &&
-		       tcf_mirred_can_reinsert(retval);
-	if (!use_reinsert) {
-		skb2 = skb_clone(skb, GFP_ATOMIC);
-		if (!skb2)
+	dont_clone = skb_at_tc_ingress(skb) && is_redirect &&
+		tcf_mirred_can_reinsert(retval);
+	if (!dont_clone) {
+		skb_to_send = skb_clone(skb, GFP_ATOMIC);
+		if (!skb_to_send) {
+			err =  -ENOMEM;
 			goto out;
+		}
 	}
 
 	want_ingress = tcf_mirred_act_wants_ingress(m_eaction);
 
 	/* All mirred/redirected skbs should clear previous ct info */
-	nf_reset_ct(skb2);
+	nf_reset_ct(skb_to_send);
 	if (want_ingress && !at_ingress) /* drop dst for egress -> ingress */
-		skb_dst_drop(skb2);
+		skb_dst_drop(skb_to_send);
 
 	expects_nh = want_ingress || !m_mac_header_xmit;
 	at_nh = skb->data == skb_network_header(skb);
 	if (at_nh != expects_nh) {
-		mac_len = skb_at_tc_ingress(skb) ? skb->mac_len :
+		mac_len = at_ingress ? skb->mac_len :
 			  skb_network_offset(skb);
 		if (expects_nh) {
 			/* target device/action expect data at nh */
-			skb_pull_rcsum(skb2, mac_len);
+			skb_pull_rcsum(skb_to_send, mac_len);
 		} else {
 			/* target device/action expect data at mac */
-			skb_push_rcsum(skb2, mac_len);
+			skb_push_rcsum(skb_to_send, mac_len);
 		}
 	}
 
-	skb2->skb_iif = skb->dev->ifindex;
-	skb2->dev = dev;
+	skb_to_send->skb_iif = skb->dev->ifindex;
+	skb_to_send->dev = dev;
 
-	/* mirror is always swallowed */
 	if (is_redirect) {
-		skb_set_redirected(skb2, skb2->tc_at_ingress);
-
-		/* let's the caller reinsert the packet, if possible */
-		if (use_reinsert) {
-			err = tcf_mirred_forward(want_ingress, skb);
-			if (err)
-				tcf_action_inc_overlimit_qstats(&m->common);
-			__this_cpu_dec(mirred_nest_level);
-			return TC_ACT_CONSUMED;
-		}
+		if (skb == skb_to_send)
+			retval = TC_ACT_CONSUMED;
+
+		skb_set_redirected(skb_to_send, skb_to_send->tc_at_ingress);
+
+		err = tcf_mirred_forward(want_ingress, skb_to_send);
+	} else {
+		err = tcf_mirred_forward(want_ingress, skb_to_send);
 	}
 
-	err = tcf_mirred_forward(want_ingress, skb2);
 	if (err) {
 out:
 		tcf_action_inc_overlimit_qstats(&m->common);
-		if (tcf_mirred_is_act_redirect(m_eaction))
+		if (is_redirect)
 			retval = TC_ACT_SHOT;
 	}
+
+	return retval;
+}
+
+TC_INDIRECT_SCOPE int tcf_mirred_act(struct sk_buff *skb,
+				     const struct tc_action *a,
+				     struct tcf_result *res)
+{
+	struct tcf_mirred *m = to_mirred(a);
+	int retval = READ_ONCE(m->tcf_action);
+	unsigned int nest_level;
+	bool m_mac_header_xmit;
+	struct net_device *dev;
+	int m_eaction;
+
+	nest_level = __this_cpu_inc_return(mirred_nest_level);
+	if (unlikely(nest_level > MIRRED_NEST_LIMIT)) {
+		net_warn_ratelimited("Packet exceeded mirred recursion limit on dev %s\n",
+				     netdev_name(skb->dev));
+		retval = TC_ACT_SHOT;
+		goto dec_nest_level;
+	}
+
+	tcf_lastuse_update(&m->tcf_tm);
+	tcf_action_update_bstats(&m->common, skb);
+
+	dev = rcu_dereference_bh(m->tcfm_dev);
+	if (unlikely(!dev)) {
+		pr_notice_once("tc mirred: target device is gone\n");
+		tcf_action_inc_overlimit_qstats(&m->common);
+		goto dec_nest_level;
+	}
+
+	m_mac_header_xmit = READ_ONCE(m->tcfm_mac_header_xmit);
+	m_eaction = READ_ONCE(m->tcfm_eaction);
+
+	retval = tcf_mirred_to_dev(skb, m, dev, m_mac_header_xmit, m_eaction,
+				   retval);
+
+dec_nest_level:
 	__this_cpu_dec(mirred_nest_level);
 
 	return retval;
-- 
2.43.0




