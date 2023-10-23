Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E25F7D329A
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbjJWLV7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233829AbjJWLV6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:21:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35629C1
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:21:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 781CDC433C8;
        Mon, 23 Oct 2023 11:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060115;
        bh=Fp3HDS8oe9dH6uw5jdmlASJTLsWb0xhJD/gMHf9bK8k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iyhyonfJSwC6hzB5Ms9CjXrPko7+yW9pUKrIbUGnJ4zQke4ZEup+YJjZDK6+RoknR
         K4XoqeKiD8bncHWgTMjvvtE59GhkGZpCsyUMJ2bh2seXNsv9zZtafLH4r95Re94w0N
         MJtge5m8Xek0yzSVJWn9NqQCfIN5QVYxo+cB4MXE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christian Theune <ct@flyingcircus.io>,
        Budimir Markovic <markovicbudimir@gmail.com>,
        Pedro Tammela <pctammela@mojatatu.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1 064/196] net/sched: sch_hfsc: upgrade rt to sc when it becomes a inner curve
Date:   Mon, 23 Oct 2023 12:55:29 +0200
Message-ID: <20231023104830.350678184@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104828.488041585@linuxfoundation.org>
References: <20231023104828.488041585@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pedro Tammela <pctammela@mojatatu.com>

commit a13b67c9a015c4e21601ef9aa4ec9c5d972df1b4 upstream.

Christian Theune says:
   I upgraded from 6.1.38 to 6.1.55 this morning and it broke my traffic shaping script,
   leaving me with a non-functional uplink on a remote router.

A 'rt' curve cannot be used as a inner curve (parent class), but we were
allowing such configurations since the qdisc was introduced. Such
configurations would trigger a UAF as Budimir explains:
   The parent will have vttree_insert() called on it in init_vf(),
   but will not have vttree_remove() called on it in update_vf()
   because it does not have the HFSC_FSC flag set.

The qdisc always assumes that inner classes have the HFSC_FSC flag set.
This is by design as it doesn't make sense 'qdisc wise' for an 'rt'
curve to be an inner curve.

Budimir's original patch disallows users to add classes with a 'rt'
parent, but this is too strict as it breaks users that have been using
'rt' as a inner class. Another approach, taken by this patch, is to
upgrade the inner 'rt' into a 'sc', warning the user in the process.
It avoids the UAF reported by Budimir while also being more permissive
to bad scripts/users/code using 'rt' as a inner class.

Users checking the `tc class ls [...]` or `tc class get [...]` dumps would
observe the curve change and are potentially breaking with this change.

v1->v2: https://lore.kernel.org/all/20231013151057.2611860-1-pctammela@mojatatu.com/
- Correct 'Fixes' tag and merge with revert (Jakub)

Cc: Christian Theune <ct@flyingcircus.io>
Cc: Budimir Markovic <markovicbudimir@gmail.com>
Fixes: b3d26c5702c7 ("net/sched: sch_hfsc: Ensure inner classes have fsc curve")
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Link: https://lore.kernel.org/r/20231017143602.3191556-1-pctammela@mojatatu.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/sch_hfsc.c |   18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -903,6 +903,14 @@ hfsc_change_usc(struct hfsc_class *cl, s
 	cl->cl_flags |= HFSC_USC;
 }
 
+static void
+hfsc_upgrade_rt(struct hfsc_class *cl)
+{
+	cl->cl_fsc = cl->cl_rsc;
+	rtsc_init(&cl->cl_virtual, &cl->cl_fsc, cl->cl_vt, cl->cl_total);
+	cl->cl_flags |= HFSC_FSC;
+}
+
 static const struct nla_policy hfsc_policy[TCA_HFSC_MAX + 1] = {
 	[TCA_HFSC_RSC]	= { .len = sizeof(struct tc_service_curve) },
 	[TCA_HFSC_FSC]	= { .len = sizeof(struct tc_service_curve) },
@@ -1012,10 +1020,6 @@ hfsc_change_class(struct Qdisc *sch, u32
 		if (parent == NULL)
 			return -ENOENT;
 	}
-	if (!(parent->cl_flags & HFSC_FSC) && parent != &q->root) {
-		NL_SET_ERR_MSG(extack, "Invalid parent - parent class must have FSC");
-		return -EINVAL;
-	}
 
 	if (classid == 0 || TC_H_MAJ(classid ^ sch->handle) != 0)
 		return -EINVAL;
@@ -1066,6 +1070,12 @@ hfsc_change_class(struct Qdisc *sch, u32
 	cl->cf_tree = RB_ROOT;
 
 	sch_tree_lock(sch);
+	/* Check if the inner class is a misconfigured 'rt' */
+	if (!(parent->cl_flags & HFSC_FSC) && parent != &q->root) {
+		NL_SET_ERR_MSG(extack,
+			       "Forced curve change on parent 'rt' to 'sc'");
+		hfsc_upgrade_rt(parent);
+	}
 	qdisc_class_hash_insert(&q->clhash, &cl->cl_common);
 	list_add_tail(&cl->siblings, &parent->children);
 	if (parent->level == 0)


