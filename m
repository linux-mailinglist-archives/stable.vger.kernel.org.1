Return-Path: <stable+bounces-21120-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5048085C736
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 22:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC4C61F229C1
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 21:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D021A151CF9;
	Tue, 20 Feb 2024 21:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OLGALcOK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C57152DE8;
	Tue, 20 Feb 2024 21:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708463416; cv=none; b=p69/4s4+846eoM8XJaVrC4bmvMfnJvLeVXaYmMbTHv1rBQ4fViyk0uyj6L+lpMGsHMvtwBFXlA62omaNSJj8dGMEE3ZMQSIy3bLaUWLSXa/qYvzLyq/DoFPXzkmft+e6kC/u9AH31TVjLjgPUVhY3BGpq1pZFKWGXnw7HlBj0Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708463416; c=relaxed/simple;
	bh=2rEuN7zFtA9vklIpAascVFyO6DPCWVL+pRNuznlpfZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E2AiQ57A6XTNcAO6Qv5VoLTWgBKnckSEllHFF03o321E9O4c+4r2eY/XZ7y3gHLhhMwLpGZr5ULp7HXFluHpWQYDEV6HWrAr97BRYNvzh0MGt3K1o8/Jn6HqKXJ8zV1+jWIIczgZVxolOo2mIcZVaRfkeyMV+z3V/MHBuW6mm90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OLGALcOK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FCBEC43390;
	Tue, 20 Feb 2024 21:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708463415;
	bh=2rEuN7zFtA9vklIpAascVFyO6DPCWVL+pRNuznlpfZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OLGALcOKpqavMk+xeQj9QdUif54LOkAUQ/6V4UWDPwXayNxH+ItDcDDBfK/7Y4P6r
	 uGv95m9bTdAzWioDDKIRqSirND7xYuw2ey5hfNEJCaCJC+H0QfTUI07VsLj6Kacw0c
	 Fm39IqbdxTqpO8K804TtpL/nlHGs/a1FylucRnQI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aaron Conole <aconole@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 037/331] net: openvswitch: limit the number of recursions from action sets
Date: Tue, 20 Feb 2024 21:52:33 +0100
Message-ID: <20240220205638.771195994@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240220205637.572693592@linuxfoundation.org>
References: <20240220205637.572693592@linuxfoundation.org>
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

From: Aaron Conole <aconole@redhat.com>

[ Upstream commit 6e2f90d31fe09f2b852de25125ca875aabd81367 ]

The ovs module allows for some actions to recursively contain an action
list for complex scenarios, such as sampling, checking lengths, etc.
When these actions are copied into the internal flow table, they are
evaluated to validate that such actions make sense, and these calls
happen recursively.

The ovs-vswitchd userspace won't emit more than 16 recursion levels
deep.  However, the module has no such limit and will happily accept
limits larger than 16 levels nested.  Prevent this by tracking the
number of recursions happening and manually limiting it to 16 levels
nested.

The initial implementation of the sample action would track this depth
and prevent more than 3 levels of recursion, but this was removed to
support the clone use case, rather than limited at the current userspace
limit.

Fixes: 798c166173ff ("openvswitch: Optimize sample action for the clone use cases")
Signed-off-by: Aaron Conole <aconole@redhat.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20240207132416.1488485-2-aconole@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/openvswitch/flow_netlink.c | 49 +++++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 16 deletions(-)

diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_netlink.c
index 88965e2068ac..ebc5728aab4e 100644
--- a/net/openvswitch/flow_netlink.c
+++ b/net/openvswitch/flow_netlink.c
@@ -48,6 +48,7 @@ struct ovs_len_tbl {
 
 #define OVS_ATTR_NESTED -1
 #define OVS_ATTR_VARIABLE -2
+#define OVS_COPY_ACTIONS_MAX_DEPTH 16
 
 static bool actions_may_change_flow(const struct nlattr *actions)
 {
@@ -2545,13 +2546,15 @@ static int __ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
 				  const struct sw_flow_key *key,
 				  struct sw_flow_actions **sfa,
 				  __be16 eth_type, __be16 vlan_tci,
-				  u32 mpls_label_count, bool log);
+				  u32 mpls_label_count, bool log,
+				  u32 depth);
 
 static int validate_and_copy_sample(struct net *net, const struct nlattr *attr,
 				    const struct sw_flow_key *key,
 				    struct sw_flow_actions **sfa,
 				    __be16 eth_type, __be16 vlan_tci,
-				    u32 mpls_label_count, bool log, bool last)
+				    u32 mpls_label_count, bool log, bool last,
+				    u32 depth)
 {
 	const struct nlattr *attrs[OVS_SAMPLE_ATTR_MAX + 1];
 	const struct nlattr *probability, *actions;
@@ -2602,7 +2605,8 @@ static int validate_and_copy_sample(struct net *net, const struct nlattr *attr,
 		return err;
 
 	err = __ovs_nla_copy_actions(net, actions, key, sfa,
-				     eth_type, vlan_tci, mpls_label_count, log);
+				     eth_type, vlan_tci, mpls_label_count, log,
+				     depth + 1);
 
 	if (err)
 		return err;
@@ -2617,7 +2621,8 @@ static int validate_and_copy_dec_ttl(struct net *net,
 				     const struct sw_flow_key *key,
 				     struct sw_flow_actions **sfa,
 				     __be16 eth_type, __be16 vlan_tci,
-				     u32 mpls_label_count, bool log)
+				     u32 mpls_label_count, bool log,
+				     u32 depth)
 {
 	const struct nlattr *attrs[OVS_DEC_TTL_ATTR_MAX + 1];
 	int start, action_start, err, rem;
@@ -2660,7 +2665,8 @@ static int validate_and_copy_dec_ttl(struct net *net,
 		return action_start;
 
 	err = __ovs_nla_copy_actions(net, actions, key, sfa, eth_type,
-				     vlan_tci, mpls_label_count, log);
+				     vlan_tci, mpls_label_count, log,
+				     depth + 1);
 	if (err)
 		return err;
 
@@ -2674,7 +2680,8 @@ static int validate_and_copy_clone(struct net *net,
 				   const struct sw_flow_key *key,
 				   struct sw_flow_actions **sfa,
 				   __be16 eth_type, __be16 vlan_tci,
-				   u32 mpls_label_count, bool log, bool last)
+				   u32 mpls_label_count, bool log, bool last,
+				   u32 depth)
 {
 	int start, err;
 	u32 exec;
@@ -2694,7 +2701,8 @@ static int validate_and_copy_clone(struct net *net,
 		return err;
 
 	err = __ovs_nla_copy_actions(net, attr, key, sfa,
-				     eth_type, vlan_tci, mpls_label_count, log);
+				     eth_type, vlan_tci, mpls_label_count, log,
+				     depth + 1);
 	if (err)
 		return err;
 
@@ -3063,7 +3071,7 @@ static int validate_and_copy_check_pkt_len(struct net *net,
 					   struct sw_flow_actions **sfa,
 					   __be16 eth_type, __be16 vlan_tci,
 					   u32 mpls_label_count,
-					   bool log, bool last)
+					   bool log, bool last, u32 depth)
 {
 	const struct nlattr *acts_if_greater, *acts_if_lesser_eq;
 	struct nlattr *a[OVS_CHECK_PKT_LEN_ATTR_MAX + 1];
@@ -3111,7 +3119,8 @@ static int validate_and_copy_check_pkt_len(struct net *net,
 		return nested_acts_start;
 
 	err = __ovs_nla_copy_actions(net, acts_if_lesser_eq, key, sfa,
-				     eth_type, vlan_tci, mpls_label_count, log);
+				     eth_type, vlan_tci, mpls_label_count, log,
+				     depth + 1);
 
 	if (err)
 		return err;
@@ -3124,7 +3133,8 @@ static int validate_and_copy_check_pkt_len(struct net *net,
 		return nested_acts_start;
 
 	err = __ovs_nla_copy_actions(net, acts_if_greater, key, sfa,
-				     eth_type, vlan_tci, mpls_label_count, log);
+				     eth_type, vlan_tci, mpls_label_count, log,
+				     depth + 1);
 
 	if (err)
 		return err;
@@ -3152,12 +3162,16 @@ static int __ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
 				  const struct sw_flow_key *key,
 				  struct sw_flow_actions **sfa,
 				  __be16 eth_type, __be16 vlan_tci,
-				  u32 mpls_label_count, bool log)
+				  u32 mpls_label_count, bool log,
+				  u32 depth)
 {
 	u8 mac_proto = ovs_key_mac_proto(key);
 	const struct nlattr *a;
 	int rem, err;
 
+	if (depth > OVS_COPY_ACTIONS_MAX_DEPTH)
+		return -EOVERFLOW;
+
 	nla_for_each_nested(a, attr, rem) {
 		/* Expected argument lengths, (u32)-1 for variable length. */
 		static const u32 action_lens[OVS_ACTION_ATTR_MAX + 1] = {
@@ -3355,7 +3369,7 @@ static int __ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
 			err = validate_and_copy_sample(net, a, key, sfa,
 						       eth_type, vlan_tci,
 						       mpls_label_count,
-						       log, last);
+						       log, last, depth);
 			if (err)
 				return err;
 			skip_copy = true;
@@ -3426,7 +3440,7 @@ static int __ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
 			err = validate_and_copy_clone(net, a, key, sfa,
 						      eth_type, vlan_tci,
 						      mpls_label_count,
-						      log, last);
+						      log, last, depth);
 			if (err)
 				return err;
 			skip_copy = true;
@@ -3440,7 +3454,8 @@ static int __ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
 							      eth_type,
 							      vlan_tci,
 							      mpls_label_count,
-							      log, last);
+							      log, last,
+							      depth);
 			if (err)
 				return err;
 			skip_copy = true;
@@ -3450,7 +3465,8 @@ static int __ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
 		case OVS_ACTION_ATTR_DEC_TTL:
 			err = validate_and_copy_dec_ttl(net, a, key, sfa,
 							eth_type, vlan_tci,
-							mpls_label_count, log);
+							mpls_label_count, log,
+							depth);
 			if (err)
 				return err;
 			skip_copy = true;
@@ -3495,7 +3511,8 @@ int ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
 
 	(*sfa)->orig_len = nla_len(attr);
 	err = __ovs_nla_copy_actions(net, attr, key, sfa, key->eth.type,
-				     key->eth.vlan.tci, mpls_label_count, log);
+				     key->eth.vlan.tci, mpls_label_count, log,
+				     0);
 	if (err)
 		ovs_nla_free_flow_actions(*sfa);
 
-- 
2.43.0




