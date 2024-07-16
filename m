Return-Path: <stable+bounces-60012-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0074B932CFB
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 17:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 247DC1C22192
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 15:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7555519B59C;
	Tue, 16 Jul 2024 15:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tgevCifX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320D11DA4D;
	Tue, 16 Jul 2024 15:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721145588; cv=none; b=rQEA9Ikt4oSxi6AKWZHi+UTOJpnSCc3tlOt1G4l3/lVthVH5oEBKc+K6RE5oJJy7AIPqzDQAtm53nRgKg4g9c4TPFE7rlwfNlu5p8i76q4+0/CikyuH0mG+4UPsqmtsS0N/pOWgGku9y+sZ5HdV/ECeCfrsG+pbH6MwCsm4oQgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721145588; c=relaxed/simple;
	bh=8+w+Resj0h/jsaFtV7o68LtcF4xxU5Llk7IU/Qr8GVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TTmpTD6W21bLEd1/3dF5hEa1aklrox9tn3gHslVtJ5pyPmAupSQ30kTTxrZllVCLUKkuFcN/6vSwKHcrCwvsNFeAsL4PkMITuQC4rMqKAnOA0ZDf7YgcXO73CUFXj22wKfNcn+rXGEjiuA7//YV77uJFmRQfsNJzkM3UYLU2fAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tgevCifX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A33D4C4AF0D;
	Tue, 16 Jul 2024 15:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721145588;
	bh=8+w+Resj0h/jsaFtV7o68LtcF4xxU5Llk7IU/Qr8GVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tgevCifXZO7bOUjNbqOafrpcJBk2LXZ5Ll3OGkJmzDGiiYjJoMenz8DGoyWf5nv4t
	 fgEyu7KF8WZQWybdot7Dp02/bVygu6Mqg4FX6aXCGbbdIHIfsTBAZ/lOSiTXSBftlL
	 glYp5U14/gUO/GTOGedOX5Z/Ql7PkpLBSFiqqbus=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pedro Pinto <xten@osec.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Hyunwoo Kim <v4bel@theori.io>,
	Wongi Lee <qwerty@theori.io>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 019/121] bpf: Fix too early release of tcx_entry
Date: Tue, 16 Jul 2024 17:31:21 +0200
Message-ID: <20240716152752.059767166@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716152751.312512071@linuxfoundation.org>
References: <20240716152751.312512071@linuxfoundation.org>
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

From: Daniel Borkmann <daniel@iogearbox.net>

[ Upstream commit 1cb6f0bae50441f4b4b32a28315853b279c7404e ]

Pedro Pinto and later independently also Hyunwoo Kim and Wongi Lee reported
an issue that the tcx_entry can be released too early leading to a use
after free (UAF) when an active old-style ingress or clsact qdisc with a
shared tc block is later replaced by another ingress or clsact instance.

Essentially, the sequence to trigger the UAF (one example) can be as follows:

  1. A network namespace is created
  2. An ingress qdisc is created. This allocates a tcx_entry, and
     &tcx_entry->miniq is stored in the qdisc's miniqp->p_miniq. At the
     same time, a tcf block with index 1 is created.
  3. chain0 is attached to the tcf block. chain0 must be connected to
     the block linked to the ingress qdisc to later reach the function
     tcf_chain0_head_change_cb_del() which triggers the UAF.
  4. Create and graft a clsact qdisc. This causes the ingress qdisc
     created in step 1 to be removed, thus freeing the previously linked
     tcx_entry:

     rtnetlink_rcv_msg()
       => tc_modify_qdisc()
         => qdisc_create()
           => clsact_init() [a]
         => qdisc_graft()
           => qdisc_destroy()
             => __qdisc_destroy()
               => ingress_destroy() [b]
                 => tcx_entry_free()
                   => kfree_rcu() // tcx_entry freed

  5. Finally, the network namespace is closed. This registers the
     cleanup_net worker, and during the process of releasing the
     remaining clsact qdisc, it accesses the tcx_entry that was
     already freed in step 4, causing the UAF to occur:

     cleanup_net()
       => ops_exit_list()
         => default_device_exit_batch()
           => unregister_netdevice_many()
             => unregister_netdevice_many_notify()
               => dev_shutdown()
                 => qdisc_put()
                   => clsact_destroy() [c]
                     => tcf_block_put_ext()
                       => tcf_chain0_head_change_cb_del()
                         => tcf_chain_head_change_item()
                           => clsact_chain_head_change()
                             => mini_qdisc_pair_swap() // UAF

There are also other variants, the gist is to add an ingress (or clsact)
qdisc with a specific shared block, then to replace that qdisc, waiting
for the tcx_entry kfree_rcu() to be executed and subsequently accessing
the current active qdisc's miniq one way or another.

The correct fix is to turn the miniq_active boolean into a counter. What
can be observed, at step 2 above, the counter transitions from 0->1, at
step [a] from 1->2 (in order for the miniq object to remain active during
the replacement), then in [b] from 2->1 and finally [c] 1->0 with the
eventual release. The reference counter in general ranges from [0,2] and
it does not need to be atomic since all access to the counter is protected
by the rtnl mutex. With this in place, there is no longer a UAF happening
and the tcx_entry is freed at the correct time.

Fixes: e420bed02507 ("bpf: Add fd-based tcx multi-prog infra with link support")
Reported-by: Pedro Pinto <xten@osec.io>
Co-developed-by: Pedro Pinto <xten@osec.io>
Signed-off-by: Pedro Pinto <xten@osec.io>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Hyunwoo Kim <v4bel@theori.io>
Cc: Wongi Lee <qwerty@theori.io>
Cc: Martin KaFai Lau <martin.lau@kernel.org>
Link: https://lore.kernel.org/r/20240708133130.11609-1-daniel@iogearbox.net
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/tcx.h       | 13 +++++++++----
 net/sched/sch_ingress.c | 12 ++++++------
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/include/net/tcx.h b/include/net/tcx.h
index 264f147953bae..a0f78fd5cb287 100644
--- a/include/net/tcx.h
+++ b/include/net/tcx.h
@@ -13,7 +13,7 @@ struct mini_Qdisc;
 struct tcx_entry {
 	struct mini_Qdisc __rcu *miniq;
 	struct bpf_mprog_bundle bundle;
-	bool miniq_active;
+	u32 miniq_active;
 	struct rcu_head rcu;
 };
 
@@ -129,11 +129,16 @@ static inline void tcx_skeys_dec(bool ingress)
 	tcx_dec();
 }
 
-static inline void tcx_miniq_set_active(struct bpf_mprog_entry *entry,
-					const bool active)
+static inline void tcx_miniq_inc(struct bpf_mprog_entry *entry)
 {
 	ASSERT_RTNL();
-	tcx_entry(entry)->miniq_active = active;
+	tcx_entry(entry)->miniq_active++;
+}
+
+static inline void tcx_miniq_dec(struct bpf_mprog_entry *entry)
+{
+	ASSERT_RTNL();
+	tcx_entry(entry)->miniq_active--;
 }
 
 static inline bool tcx_entry_is_active(struct bpf_mprog_entry *entry)
diff --git a/net/sched/sch_ingress.c b/net/sched/sch_ingress.c
index a463a63192c3c..8dde3548dc11c 100644
--- a/net/sched/sch_ingress.c
+++ b/net/sched/sch_ingress.c
@@ -91,7 +91,7 @@ static int ingress_init(struct Qdisc *sch, struct nlattr *opt,
 	entry = tcx_entry_fetch_or_create(dev, true, &created);
 	if (!entry)
 		return -ENOMEM;
-	tcx_miniq_set_active(entry, true);
+	tcx_miniq_inc(entry);
 	mini_qdisc_pair_init(&q->miniqp, sch, &tcx_entry(entry)->miniq);
 	if (created)
 		tcx_entry_update(dev, entry, true);
@@ -121,7 +121,7 @@ static void ingress_destroy(struct Qdisc *sch)
 	tcf_block_put_ext(q->block, sch, &q->block_info);
 
 	if (entry) {
-		tcx_miniq_set_active(entry, false);
+		tcx_miniq_dec(entry);
 		if (!tcx_entry_is_active(entry)) {
 			tcx_entry_update(dev, NULL, true);
 			tcx_entry_free(entry);
@@ -256,7 +256,7 @@ static int clsact_init(struct Qdisc *sch, struct nlattr *opt,
 	entry = tcx_entry_fetch_or_create(dev, true, &created);
 	if (!entry)
 		return -ENOMEM;
-	tcx_miniq_set_active(entry, true);
+	tcx_miniq_inc(entry);
 	mini_qdisc_pair_init(&q->miniqp_ingress, sch, &tcx_entry(entry)->miniq);
 	if (created)
 		tcx_entry_update(dev, entry, true);
@@ -275,7 +275,7 @@ static int clsact_init(struct Qdisc *sch, struct nlattr *opt,
 	entry = tcx_entry_fetch_or_create(dev, false, &created);
 	if (!entry)
 		return -ENOMEM;
-	tcx_miniq_set_active(entry, true);
+	tcx_miniq_inc(entry);
 	mini_qdisc_pair_init(&q->miniqp_egress, sch, &tcx_entry(entry)->miniq);
 	if (created)
 		tcx_entry_update(dev, entry, false);
@@ -301,7 +301,7 @@ static void clsact_destroy(struct Qdisc *sch)
 	tcf_block_put_ext(q->egress_block, sch, &q->egress_block_info);
 
 	if (ingress_entry) {
-		tcx_miniq_set_active(ingress_entry, false);
+		tcx_miniq_dec(ingress_entry);
 		if (!tcx_entry_is_active(ingress_entry)) {
 			tcx_entry_update(dev, NULL, true);
 			tcx_entry_free(ingress_entry);
@@ -309,7 +309,7 @@ static void clsact_destroy(struct Qdisc *sch)
 	}
 
 	if (egress_entry) {
-		tcx_miniq_set_active(egress_entry, false);
+		tcx_miniq_dec(egress_entry);
 		if (!tcx_entry_is_active(egress_entry)) {
 			tcx_entry_update(dev, NULL, false);
 			tcx_entry_free(egress_entry);
-- 
2.43.0




