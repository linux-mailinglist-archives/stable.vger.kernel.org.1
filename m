Return-Path: <stable+bounces-168385-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F1627B23469
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E44B14E3FAB
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CE32FE59E;
	Tue, 12 Aug 2025 18:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DVa4pJOe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30472FD1AD;
	Tue, 12 Aug 2025 18:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755024002; cv=none; b=Uo2UBSTjt1WJZPuZZ4WpC/sjvJzBsRIplhgqj8OeDmUzqsrl58lLOBVGiwU0nwKB11alV7EoApuHhc6UHcGAgJgCAsR8HMNPN86TcEN4kLVX/VKZKCQ9DpgNgDep7cqgiHVCL3nzyWkm5tYr/Pjzaiq4c3nkWz+aoDW+zsMopWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755024002; c=relaxed/simple;
	bh=OVhIQBb+Ix+Rk185ApskI2MYOfC6rYFB2iE/C3XxbZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sEKWKnEJWH/pkCA5NCVzc+stXqAmS9nl8RorWZUjiXhpz+QfHpFpPr+6CFPVPM9dsfqEtmlBZ7Dz6h8G7omB75C2t1havy/RP+qgAv3oaMbyDRpbMnpDGRNn/ngqAhXk663VgsNP3rwoxcAcRnVIi7L1p6a5OHGWvurlVTz2xRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DVa4pJOe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22DE2C4CEF0;
	Tue, 12 Aug 2025 18:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755024002;
	bh=OVhIQBb+Ix+Rk185ApskI2MYOfC6rYFB2iE/C3XxbZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DVa4pJOeGiIBGCgKRzv3wzX6VWWggF5kUlZflvAMzv+UK3ryb7rEIyjLCm3kHQYmA
	 B8p3EOrV+Ui+LjNWy0qtFbb6JLUkd/4N8+LrpSrg9JzLx/KUTBdL+r3AtwGSUm7rn9
	 k8DqjKsHi4nl9ciOnuiSpCbLeINAK+MtE31KFeys=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	William Liu <will@willsroot.io>,
	Savino Dicanosa <savy@syst3mfailure.io>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 211/627] net/sched: Restrict conditions for adding duplicating netems to qdisc tree
Date: Tue, 12 Aug 2025 19:28:26 +0200
Message-ID: <20250812173427.308295030@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812173419.303046420@linuxfoundation.org>
References: <20250812173419.303046420@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: William Liu <will@willsroot.io>

[ Upstream commit ec8e0e3d7adef940cdf9475e2352c0680189d14e ]

netem_enqueue's duplication prevention logic breaks when a netem
resides in a qdisc tree with other netems - this can lead to a
soft lockup and OOM loop in netem_dequeue, as seen in [1].
Ensure that a duplicating netem cannot exist in a tree with other
netems.

Previous approaches suggested in discussions in chronological order:

1) Track duplication status or ttl in the sk_buff struct. Considered
too specific a use case to extend such a struct, though this would
be a resilient fix and address other previous and potential future
DOS bugs like the one described in loopy fun [2].

2) Restrict netem_enqueue recursion depth like in act_mirred with a
per cpu variable. However, netem_dequeue can call enqueue on its
child, and the depth restriction could be bypassed if the child is a
netem.

3) Use the same approach as in 2, but add metadata in netem_skb_cb
to handle the netem_dequeue case and track a packet's involvement
in duplication. This is an overly complex approach, and Jamal
notes that the skb cb can be overwritten to circumvent this
safeguard.

4) Prevent the addition of a netem to a qdisc tree if its ancestral
path contains a netem. However, filters and actions can cause a
packet to change paths when re-enqueued to the root from netem
duplication, leading us to the current solution: prevent a
duplicating netem from inhabiting the same tree as other netems.

[1] https://lore.kernel.org/netdev/8DuRWwfqjoRDLDmBMlIfbrsZg9Gx50DHJc1ilxsEBNe2D6NMoigR_eIRIG0LOjMc3r10nUUZtArXx4oZBIdUfZQrwjcQhdinnMis_0G7VEk=@willsroot.io/
[2] https://lwn.net/Articles/719297/

Fixes: 0afb51e72855 ("[PKT_SCHED]: netem: reinsert for duplication")
Reported-by: William Liu <will@willsroot.io>
Reported-by: Savino Dicanosa <savy@syst3mfailure.io>
Signed-off-by: William Liu <will@willsroot.io>
Signed-off-by: Savino Dicanosa <savy@syst3mfailure.io>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Link: https://patch.msgid.link/20250708164141.875402-1-will@willsroot.io
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_netem.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index fdd79d3ccd8c..eafc316ae319 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -973,6 +973,41 @@ static int parse_attr(struct nlattr *tb[], int maxtype, struct nlattr *nla,
 	return 0;
 }
 
+static const struct Qdisc_class_ops netem_class_ops;
+
+static int check_netem_in_tree(struct Qdisc *sch, bool duplicates,
+			       struct netlink_ext_ack *extack)
+{
+	struct Qdisc *root, *q;
+	unsigned int i;
+
+	root = qdisc_root_sleeping(sch);
+
+	if (sch != root && root->ops->cl_ops == &netem_class_ops) {
+		if (duplicates ||
+		    ((struct netem_sched_data *)qdisc_priv(root))->duplicate)
+			goto err;
+	}
+
+	if (!qdisc_dev(root))
+		return 0;
+
+	hash_for_each(qdisc_dev(root)->qdisc_hash, i, q, hash) {
+		if (sch != q && q->ops->cl_ops == &netem_class_ops) {
+			if (duplicates ||
+			    ((struct netem_sched_data *)qdisc_priv(q))->duplicate)
+				goto err;
+		}
+	}
+
+	return 0;
+
+err:
+	NL_SET_ERR_MSG(extack,
+		       "netem: cannot mix duplicating netems with other netems in tree");
+	return -EINVAL;
+}
+
 /* Parse netlink message to set options */
 static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 			struct netlink_ext_ack *extack)
@@ -1031,6 +1066,11 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 	q->gap = qopt->gap;
 	q->counter = 0;
 	q->loss = qopt->loss;
+
+	ret = check_netem_in_tree(sch, qopt->duplicate, extack);
+	if (ret)
+		goto unlock;
+
 	q->duplicate = qopt->duplicate;
 
 	/* for compatibility with earlier versions.
-- 
2.39.5




