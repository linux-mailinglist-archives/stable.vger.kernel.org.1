Return-Path: <stable+bounces-20652-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFBE85AAC9
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 19:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BBFFB20BCE
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 18:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2066E481AF;
	Mon, 19 Feb 2024 18:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RCJ60ivL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B3C4779F
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 18:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708366799; cv=none; b=opsAAszK3HnG5oVCYh++sYmYk7mk/31/IwbDcmNLfo4J68BRvOu3rzZNCBJa8b23268rtsEZxTumRoOUu8efO0Te1GZwtMbtYA60gFKMMlHCesT+uCWmSzmocXdalmS5KNw6VcntQ8u9zNmdtPY15GBixdC9Bagu+RGBqjflfX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708366799; c=relaxed/simple;
	bh=bWgNOccCAJIR5zvl4mtECKzqnRVBRsp7L31PKPsJqjI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=McIQoSQAZN32cdwU1jXNDZAlRTXdZKsrOoLnFw8fJS53/KOKXmom5iuEKlQtxyIvlB0lNC2w7TVZAphpS8KJkWBctek75WH7JvtDAO6PmF1KG+NSQjqCDx/toYssZ2JDevSNSVrDcnil65wyDKMlhknPQHiLTp8lHe9gyzZU7AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RCJ60ivL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026F9C433F1;
	Mon, 19 Feb 2024 18:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708366799;
	bh=bWgNOccCAJIR5zvl4mtECKzqnRVBRsp7L31PKPsJqjI=;
	h=Subject:To:Cc:From:Date:From;
	b=RCJ60ivLIgtWGDxu5PQOgPHF86V6hoYldvUHuMERfslrZIuyqfa3k8XeMsXzkShuF
	 YlGeGdbxz+nsS/0Wh75RdOv9u2sAuyqPrSAwi5Sb34bNeUtF3ThgOjXhuImJQjHMzF
	 I6QiJEzj0xWPuZ9bSNlSzFMBxJkfzxztSY+ObbdU=
Subject: FAILED: patch "[PATCH] nfp: flower: add hardware offload check for post ct entry" failed to apply to 6.1-stable tree
To: hui.zhou@corigine.com,kuba@kernel.org,louis.peens@corigine.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 19:19:56 +0100
Message-ID: <2024021956-product-barstool-9b9c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x cefa98e806fd4e2a5e2047457a11ae5f17b8f621
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021956-product-barstool-9b9c@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

cefa98e806fd ("nfp: flower: add hardware offload check for post ct entry")
3e44d19934b9 ("nfp: flower: add goto_chain_index for ct entry")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cefa98e806fd4e2a5e2047457a11ae5f17b8f621 Mon Sep 17 00:00:00 2001
From: Hui Zhou <hui.zhou@corigine.com>
Date: Wed, 24 Jan 2024 17:19:08 +0200
Subject: [PATCH] nfp: flower: add hardware offload check for post ct entry

The nfp offload flow pay will not allocate a mask id when the out port
is openvswitch internal port. This is because these flows are used to
configure the pre_tun table and are never actually send to the firmware
as an add-flow message. When a tc rule which action contains ct and
the post ct entry's out port is openvswitch internal port, the merge
offload flow pay with the wrong mask id of 0 will be send to the
firmware. Actually, the nfp can not support hardware offload for this
situation, so return EOPNOTSUPP.

Fixes: bd0fe7f96a3c ("nfp: flower-ct: add zone table entry when handling pre/post_ct flows")
CC: stable@vger.kernel.org # 5.14+
Signed-off-by: Hui Zhou <hui.zhou@corigine.com>
Signed-off-by: Louis Peens <louis.peens@corigine.com>
Link: https://lore.kernel.org/r/20240124151909.31603-2-louis.peens@corigine.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/ethernet/netronome/nfp/flower/conntrack.c b/drivers/net/ethernet/netronome/nfp/flower/conntrack.c
index 2967bab72505..726d8cdf0b9c 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/conntrack.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/conntrack.c
@@ -1864,10 +1864,30 @@ int nfp_fl_ct_handle_post_ct(struct nfp_flower_priv *priv,
 {
 	struct flow_rule *rule = flow_cls_offload_flow_rule(flow);
 	struct nfp_fl_ct_flow_entry *ct_entry;
+	struct flow_action_entry *ct_goto;
 	struct nfp_fl_ct_zone_entry *zt;
+	struct flow_action_entry *act;
 	bool wildcarded = false;
 	struct flow_match_ct ct;
-	struct flow_action_entry *ct_goto;
+	int i;
+
+	flow_action_for_each(i, act, &rule->action) {
+		switch (act->id) {
+		case FLOW_ACTION_REDIRECT:
+		case FLOW_ACTION_REDIRECT_INGRESS:
+		case FLOW_ACTION_MIRRED:
+		case FLOW_ACTION_MIRRED_INGRESS:
+			if (act->dev->rtnl_link_ops &&
+			    !strcmp(act->dev->rtnl_link_ops->kind, "openvswitch")) {
+				NL_SET_ERR_MSG_MOD(extack,
+						   "unsupported offload: out port is openvswitch internal port");
+				return -EOPNOTSUPP;
+			}
+			break;
+		default:
+			break;
+		}
+	}
 
 	flow_rule_match_ct(rule, &ct);
 	if (!ct.mask->ct_zone) {


