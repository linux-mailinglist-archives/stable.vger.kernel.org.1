Return-Path: <stable+bounces-210036-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDCED30592
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 12:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A2E80300CACE
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 11:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95FBA376BE2;
	Fri, 16 Jan 2026 11:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="vklMK8fl"
X-Original-To: stable@vger.kernel.org
Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6B436D51D
	for <stable@vger.kernel.org>; Fri, 16 Jan 2026 11:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768562783; cv=none; b=l43OCmim6dU+m+MOoslk2yd8wCD7E8w5ys0eOLgSa/k1fzbGzyFkZmZGltmkScwoZQmezhK+deReujOl0aSTrV4JlGHiiKaKfHJ+mkqIH9sF1SCMTzNrBviYhCXvdjxIkXalZ4Hz2BVJixmKUpONKilnxpu9w2NjtOEdSSyj4tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768562783; c=relaxed/simple;
	bh=V1EkULuBXHcG8J1/unC9GUdLi5e6EVG4jiCaSVZDYVw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B3j6MLL+XyuRkfTv7+9eGxOORD83K2ISQJgyiilU50llnPjF1dUS8+9a1lbdCM/SYB2YKHses/gr9Fohl4KEmpdj1+t9reixaywYQcNazJS15HIWhUAPpNR2pkaajTL5Zm5YQUmWI3vaUg6EMwySf9zw0RLV5j7sL3j9HSTcvGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=vklMK8fl; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1768562768; x=1768821968;
	bh=V8UG5WVdkdRnvnalPDJw6tsIH+zkWcfu1E3gYtlXCyQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=vklMK8fliE46/uq6iuWS6iEu0DSRYNALNWnhuRwtTxHAfAAe7FiMsO/2ZfkZiO8xl
	 sYDT+KZZjCYRDkGBZJrbMiYEamBcAtv7+8UN7gmZJkZ0uuYBpEPPniWVps4V0ZRFBS
	 ZJ/R2jotcqvuxRGBQBZnXoKWR7baaOobCU+iBSiQBed8s0YPY4CGJJu3Llz8jQC2jS
	 3o8Lpo530nxnjRZsiKc5I4eU/b38iU8nNMaDcK8D4xlXFqKlTysbPj/hp7QLz5TVxr
	 lU6EFUKgS/oAiP2LioWmFr2WsbHfT8Y5/JuYD3bl6Vz7Hyd3hTGIwKUNi0e2EcZFQT
	 Yw+0ZiYM+wnpw==
Date: Fri, 16 Jan 2026 11:26:03 +0000
To: netdev@vger.kernel.org
From: Paul Moses <p@1g4.org>
Cc: Paul Moses <p@1g4.org>, stable@vger.kernel.org
Subject: [PATCH net v1 2/3] net/sched: act_gate: fix schedule updates with RCU swap
Message-ID: <20260116112522.159480-3-p@1g4.org>
In-Reply-To: <20260116112522.159480-1-p@1g4.org>
References: <20260116112522.159480-1-p@1g4.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: efdbbc63ca228da442a2ea1299b281be95128ad8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Switch act_gate parameters to an RCU-protected pointer and update schedule
changes using a prepare-then-swap pattern. This avoids races between the
timer/data paths and configuration updates, and cancels the hrtimer
before swapping schedules.

A gate action replace could free and swap schedules while the hrtimer
callback or data path still dereferences the old entries, leaving a
use-after-free window during updates. The deferred swap and RCU free
close that window. A reproducer is available on request.

Also clear params on early error for newly created actions to avoid
leaving a dangling reference, and reject overflowing cycle times.

Fixes: a51c328df310 ("net: qos: introduce a gate control flow action")
Cc: stable@vger.kernel.org
Signed-off-by: Paul Moses <p@1g4.org>
---
 include/net/tc_act/tc_gate.h |  43 +++++-
 net/sched/act_gate.c         | 276 +++++++++++++++++++++++++++--------
 2 files changed, 248 insertions(+), 71 deletions(-)

diff --git a/include/net/tc_act/tc_gate.h b/include/net/tc_act/tc_gate.h
index c1a67149c6b62..5fa6a500b9288 100644
--- a/include/net/tc_act/tc_gate.h
+++ b/include/net/tc_act/tc_gate.h
@@ -32,6 +32,7 @@ struct tcf_gate_params {
 =09s32=09=09=09tcfg_clockid;
 =09size_t=09=09=09num_entries;
 =09struct list_head=09entries;
+=09struct rcu_head=09=09rcu;
 };
=20
 #define GATE_ACT_GATE_OPEN=09BIT(0)
@@ -39,7 +40,7 @@ struct tcf_gate_params {
=20
 struct tcf_gate {
 =09struct tc_action=09common;
-=09struct tcf_gate_params=09param;
+=09struct tcf_gate_params __rcu *param;
 =09u8=09=09=09current_gate_status;
 =09ktime_t=09=09=09current_close_time;
 =09u32=09=09=09current_entry_octets;
@@ -53,45 +54,70 @@ struct tcf_gate {
=20
 static inline s32 tcf_gate_prio(const struct tc_action *a)
 {
+=09struct tcf_gate *gact =3D to_gate(a);
+=09struct tcf_gate_params *p;
 =09s32 tcfg_prio;
=20
-=09tcfg_prio =3D to_gate(a)->param.tcfg_priority;
+=09p =3D rcu_dereference_protected(gact->param,
+=09=09=09=09      lockdep_is_held(&a->tcfa_lock) ||
+=09=09=09=09      lockdep_rtnl_is_held());
+=09tcfg_prio =3D p->tcfg_priority;
=20
 =09return tcfg_prio;
 }
=20
 static inline u64 tcf_gate_basetime(const struct tc_action *a)
 {
+=09struct tcf_gate *gact =3D to_gate(a);
+=09struct tcf_gate_params *p;
 =09u64 tcfg_basetime;
=20
-=09tcfg_basetime =3D to_gate(a)->param.tcfg_basetime;
+=09p =3D rcu_dereference_protected(gact->param,
+=09=09=09=09      lockdep_is_held(&a->tcfa_lock) ||
+=09=09=09=09      lockdep_rtnl_is_held());
+=09tcfg_basetime =3D p->tcfg_basetime;
=20
 =09return tcfg_basetime;
 }
=20
 static inline u64 tcf_gate_cycletime(const struct tc_action *a)
 {
+=09struct tcf_gate *gact =3D to_gate(a);
+=09struct tcf_gate_params *p;
 =09u64 tcfg_cycletime;
=20
-=09tcfg_cycletime =3D to_gate(a)->param.tcfg_cycletime;
+=09p =3D rcu_dereference_protected(gact->param,
+=09=09=09=09      lockdep_is_held(&a->tcfa_lock) ||
+=09=09=09=09      lockdep_rtnl_is_held());
+=09tcfg_cycletime =3D p->tcfg_cycletime;
=20
 =09return tcfg_cycletime;
 }
=20
 static inline u64 tcf_gate_cycletimeext(const struct tc_action *a)
 {
+=09struct tcf_gate *gact =3D to_gate(a);
+=09struct tcf_gate_params *p;
 =09u64 tcfg_cycletimeext;
=20
-=09tcfg_cycletimeext =3D to_gate(a)->param.tcfg_cycletime_ext;
+=09p =3D rcu_dereference_protected(gact->param,
+=09=09=09=09      lockdep_is_held(&a->tcfa_lock) ||
+=09=09=09=09      lockdep_rtnl_is_held());
+=09tcfg_cycletimeext =3D p->tcfg_cycletime_ext;
=20
 =09return tcfg_cycletimeext;
 }
=20
 static inline u32 tcf_gate_num_entries(const struct tc_action *a)
 {
+=09struct tcf_gate *gact =3D to_gate(a);
+=09struct tcf_gate_params *p;
 =09u32 num_entries;
=20
-=09num_entries =3D to_gate(a)->param.num_entries;
+=09p =3D rcu_dereference_protected(gact->param,
+=09=09=09=09      lockdep_is_held(&a->tcfa_lock) ||
+=09=09=09=09      lockdep_rtnl_is_held());
+=09num_entries =3D p->num_entries;
=20
 =09return num_entries;
 }
@@ -100,12 +126,15 @@ static inline struct action_gate_entry
 =09=09=09*tcf_gate_get_list(const struct tc_action *a)
 {
 =09struct action_gate_entry *oe;
+=09struct tcf_gate *gact =3D to_gate(a);
 =09struct tcf_gate_params *p;
 =09struct tcfg_gate_entry *entry;
 =09u32 num_entries;
 =09int i =3D 0;
=20
-=09p =3D &to_gate(a)->param;
+=09p =3D rcu_dereference_protected(gact->param,
+=09=09=09=09      lockdep_is_held(&a->tcfa_lock) ||
+=09=09=09=09      lockdep_rtnl_is_held());
 =09num_entries =3D p->num_entries;
=20
 =09list_for_each_entry(entry, &p->entries, list)
diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
index c1f75f2727576..6934df233df5e 100644
--- a/net/sched/act_gate.c
+++ b/net/sched/act_gate.c
@@ -6,6 +6,7 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/errno.h>
+#include <linux/overflow.h>
 #include <linux/skbuff.h>
 #include <linux/rtnetlink.h>
 #include <linux/init.h>
@@ -32,9 +33,10 @@ static ktime_t gate_get_time(struct tcf_gate *gact)
 =09return KTIME_MAX;
 }
=20
-static void gate_get_start_time(struct tcf_gate *gact, ktime_t *start)
+static void gate_get_start_time(struct tcf_gate *gact,
+=09=09=09=09struct tcf_gate_params *param,
+=09=09=09=09ktime_t *start)
 {
-=09struct tcf_gate_params *param =3D &gact->param;
 =09ktime_t now, base, cycle;
 =09u64 n;
=20
@@ -69,12 +71,14 @@ static enum hrtimer_restart gate_timer_func(struct hrti=
mer *timer)
 {
 =09struct tcf_gate *gact =3D container_of(timer, struct tcf_gate,
 =09=09=09=09=09     hitimer);
-=09struct tcf_gate_params *p =3D &gact->param;
+=09struct tcf_gate_params *p;
 =09struct tcfg_gate_entry *next;
 =09ktime_t close_time, now;
=20
 =09spin_lock(&gact->tcf_lock);
=20
+=09p =3D rcu_dereference_protected(gact->param,
+=09=09=09=09      lockdep_is_held(&gact->tcf_lock));
 =09next =3D gact->next_entry;
=20
 =09/* cycle start, clear pending bit, clear total octets */
@@ -225,6 +229,14 @@ static void release_entry_list(struct list_head *entri=
es)
 =09}
 }
=20
+static void tcf_gate_params_release(struct rcu_head *rcu)
+{
+=09struct tcf_gate_params *p =3D container_of(rcu, struct tcf_gate_params,=
 rcu);
+
+=09release_entry_list(&p->entries);
+=09kfree(p);
+}
+
 static int parse_gate_list(struct nlattr *list_attr,
 =09=09=09   struct tcf_gate_params *sched,
 =09=09=09   struct netlink_ext_ack *extack)
@@ -274,42 +286,65 @@ static void gate_setup_timer(struct tcf_gate *gact, u=
64 basetime,
 =09=09=09     enum tk_offsets tko, s32 clockid,
 =09=09=09     bool do_init)
 {
+=09struct tcf_gate_params *p;
+
 =09if (!do_init) {
-=09=09if (basetime =3D=3D gact->param.tcfg_basetime &&
+=09=09p =3D rcu_dereference_protected(gact->param,
+=09=09=09=09=09      lockdep_is_held(&gact->tcf_lock));
+=09=09if (basetime =3D=3D p->tcfg_basetime &&
 =09=09    tko =3D=3D gact->tk_offset &&
-=09=09    clockid =3D=3D gact->param.tcfg_clockid)
+=09=09    clockid =3D=3D p->tcfg_clockid)
 =09=09=09return;
=20
 =09=09spin_unlock_bh(&gact->tcf_lock);
 =09=09hrtimer_cancel(&gact->hitimer);
 =09=09spin_lock_bh(&gact->tcf_lock);
 =09}
-=09gact->param.tcfg_basetime =3D basetime;
-=09gact->param.tcfg_clockid =3D clockid;
 =09gact->tk_offset =3D tko;
 =09hrtimer_setup(&gact->hitimer, gate_timer_func, clockid, HRTIMER_MODE_AB=
S_SOFT);
 }
=20
+static int gate_calc_cycletime(struct list_head *entries, u64 *cycletime)
+{
+=09struct tcfg_gate_entry *entry;
+=09u64 sum =3D 0;
+
+=09list_for_each_entry(entry, entries, list) {
+=09=09if (check_add_overflow(sum, (u64)entry->interval, &sum))
+=09=09=09return -EOVERFLOW;
+=09}
+
+=09if (!sum)
+=09=09return -EINVAL;
+
+=09*cycletime =3D sum;
+=09return 0;
+}
+
 static int tcf_gate_init(struct net *net, struct nlattr *nla,
 =09=09=09 struct nlattr *est, struct tc_action **a,
 =09=09=09 struct tcf_proto *tp, u32 flags,
 =09=09=09 struct netlink_ext_ack *extack)
 {
 =09struct tc_action_net *tn =3D net_generic(net, act_gate_ops.net_id);
-=09enum tk_offsets tk_offset =3D TK_OFFS_TAI;
-=09bool bind =3D flags & TCA_ACT_FLAGS_BIND;
 =09struct nlattr *tb[TCA_GATE_MAX + 1];
 =09struct tcf_chain *goto_ch =3D NULL;
-=09u64 cycletime =3D 0, basetime =3D 0;
-=09struct tcf_gate_params *p;
-=09s32 clockid =3D CLOCK_TAI;
+=09struct tcf_gate_params *p, *oldp;
 =09struct tcf_gate *gact;
 =09struct tc_gate *parm;
-=09int ret =3D 0, err;
-=09u32 gflags =3D 0;
-=09s32 prio =3D -1;
+=09struct tcf_gate_params newp =3D { };
 =09ktime_t start;
+=09u64 cycletime =3D 0, basetime =3D 0, cycletime_ext =3D 0;
+=09enum tk_offsets tk_offset =3D TK_OFFS_TAI;
+=09s32 clockid =3D CLOCK_TAI;
+=09u32 gflags =3D 0;
 =09u32 index;
+=09s32 prio =3D -1;
+=09bool bind =3D flags & TCA_ACT_FLAGS_BIND;
+=09bool clockid_set =3D false;
+=09int ret =3D 0, err;
+
+=09INIT_LIST_HEAD(&newp.entries);
=20
 =09if (!nla)
 =09=09return -EINVAL;
@@ -323,6 +358,7 @@ static int tcf_gate_init(struct net *net, struct nlattr=
 *nla,
=20
 =09if (tb[TCA_GATE_CLOCKID]) {
 =09=09clockid =3D nla_get_s32(tb[TCA_GATE_CLOCKID]);
+=09=09clockid_set =3D true;
 =09=09switch (clockid) {
 =09=09case CLOCK_REALTIME:
 =09=09=09tk_offset =3D TK_OFFS_REAL;
@@ -349,9 +385,6 @@ static int tcf_gate_init(struct net *net, struct nlattr=
 *nla,
 =09if (err < 0)
 =09=09return err;
=20
-=09if (err && bind)
-=09=09return ACT_P_BOUND;
-
 =09if (!err) {
 =09=09ret =3D tcf_idr_create_from_flags(tn, index, est, a,
 =09=09=09=09=09=09&act_gate_ops, bind, flags);
@@ -361,94 +394,206 @@ static int tcf_gate_init(struct net *net, struct nla=
ttr *nla,
 =09=09}
=20
 =09=09ret =3D ACT_P_CREATED;
-=09} else if (!(flags & TCA_ACT_FLAGS_REPLACE)) {
-=09=09tcf_idr_release(*a, bind);
-=09=09return -EEXIST;
+=09=09gact =3D to_gate(*a);
+=09=09p =3D kzalloc(sizeof(*p), GFP_KERNEL);
+=09=09if (!p) {
+=09=09=09tcf_idr_release(*a, bind);
+=09=09=09return -ENOMEM;
+=09=09}
+=09=09INIT_LIST_HEAD(&p->entries);
+=09=09rcu_assign_pointer(gact->param, p);
+=09=09gate_setup_timer(gact, basetime, tk_offset, clockid, true);
+=09} else {
+=09=09if (bind)
+=09=09=09return ACT_P_BOUND;
+
+=09=09if (!(flags & TCA_ACT_FLAGS_REPLACE)) {
+=09=09=09tcf_idr_release(*a, bind);
+=09=09=09return -EEXIST;
+=09=09}
+=09=09gact =3D to_gate(*a);
 =09}
=20
+=09err =3D tcf_action_check_ctrlact(parm->action, tp, &goto_ch, extack);
+=09if (err < 0)
+=09=09goto release_idr;
+
+=09oldp =3D rcu_dereference_protected(gact->param,
+=09=09=09=09=09 lockdep_is_held(&gact->common.tcfa_lock));
+
 =09if (tb[TCA_GATE_PRIORITY])
 =09=09prio =3D nla_get_s32(tb[TCA_GATE_PRIORITY]);
+=09else if (ret !=3D ACT_P_CREATED)
+=09=09prio =3D oldp->tcfg_priority;
=20
 =09if (tb[TCA_GATE_BASE_TIME])
 =09=09basetime =3D nla_get_u64(tb[TCA_GATE_BASE_TIME]);
+=09else if (ret !=3D ACT_P_CREATED)
+=09=09basetime =3D oldp->tcfg_basetime;
=20
 =09if (tb[TCA_GATE_FLAGS])
 =09=09gflags =3D nla_get_u32(tb[TCA_GATE_FLAGS]);
+=09else if (ret !=3D ACT_P_CREATED)
+=09=09gflags =3D oldp->tcfg_flags;
+
+=09if (!clockid_set) {
+=09=09if (ret !=3D ACT_P_CREATED)
+=09=09=09clockid =3D oldp->tcfg_clockid;
+=09=09else
+=09=09=09clockid =3D CLOCK_TAI;
+=09=09switch (clockid) {
+=09=09case CLOCK_REALTIME:
+=09=09=09tk_offset =3D TK_OFFS_REAL;
+=09=09=09break;
+=09=09case CLOCK_MONOTONIC:
+=09=09=09tk_offset =3D TK_OFFS_MAX;
+=09=09=09break;
+=09=09case CLOCK_BOOTTIME:
+=09=09=09tk_offset =3D TK_OFFS_BOOT;
+=09=09=09break;
+=09=09case CLOCK_TAI:
+=09=09=09tk_offset =3D TK_OFFS_TAI;
+=09=09=09break;
+=09=09default:
+=09=09=09NL_SET_ERR_MSG(extack, "Invalid 'clockid'");
+=09=09=09err =3D -EINVAL;
+=09=09=09goto put_chain;
+=09=09}
+=09}
=20
-=09gact =3D to_gate(*a);
-=09if (ret =3D=3D ACT_P_CREATED)
-=09=09INIT_LIST_HEAD(&gact->param.entries);
-
-=09err =3D tcf_action_check_ctrlact(parm->action, tp, &goto_ch, extack);
-=09if (err < 0)
-=09=09goto release_idr;
+=09if (ret !=3D ACT_P_CREATED && clockid_set &&
+=09    clockid !=3D oldp->tcfg_clockid) {
+=09=09NL_SET_ERR_MSG(extack, "Clockid change is not supported");
+=09=09err =3D -EINVAL;
+=09=09goto put_chain;
+=09}
=20
-=09spin_lock_bh(&gact->tcf_lock);
-=09p =3D &gact->param;
+=09if (tb[TCA_GATE_ENTRY_LIST]) {
+=09=09INIT_LIST_HEAD(&newp.entries);
+=09=09err =3D parse_gate_list(tb[TCA_GATE_ENTRY_LIST], &newp, extack);
+=09=09if (err <=3D 0) {
+=09=09=09if (!err)
+=09=09=09=09NL_SET_ERR_MSG(extack,
+=09=09=09=09=09       "Missing gate schedule (entry list)");
+=09=09=09err =3D -EINVAL;
+=09=09=09goto put_chain;
+=09=09}
+=09=09newp.num_entries =3D err;
+=09} else if (ret =3D=3D ACT_P_CREATED) {
+=09=09NL_SET_ERR_MSG(extack, "Missing schedule entry list");
+=09=09err =3D -EINVAL;
+=09=09goto put_chain;
+=09}
=20
 =09if (tb[TCA_GATE_CYCLE_TIME])
 =09=09cycletime =3D nla_get_u64(tb[TCA_GATE_CYCLE_TIME]);
=20
-=09if (tb[TCA_GATE_ENTRY_LIST]) {
-=09=09err =3D parse_gate_list(tb[TCA_GATE_ENTRY_LIST], p, extack);
-=09=09if (err < 0)
-=09=09=09goto chain_put;
-=09}
+=09if (tb[TCA_GATE_CYCLE_TIME_EXT])
+=09=09cycletime_ext =3D nla_get_u64(tb[TCA_GATE_CYCLE_TIME_EXT]);
+=09else if (ret !=3D ACT_P_CREATED)
+=09=09cycletime_ext =3D oldp->tcfg_cycletime_ext;
=20
 =09if (!cycletime) {
-=09=09struct tcfg_gate_entry *entry;
-=09=09ktime_t cycle =3D 0;
+=09=09struct list_head *entries;
=20
-=09=09list_for_each_entry(entry, &p->entries, list)
-=09=09=09cycle =3D ktime_add_ns(cycle, entry->interval);
-=09=09cycletime =3D cycle;
-=09=09if (!cycletime) {
+=09=09if (!list_empty(&newp.entries))
+=09=09=09entries =3D &newp.entries;
+=09=09else if (ret !=3D ACT_P_CREATED)
+=09=09=09entries =3D &oldp->entries;
+=09=09else
+=09=09=09entries =3D NULL;
+
+=09=09if (!entries) {
+=09=09=09NL_SET_ERR_MSG(extack, "Invalid cycle time");
 =09=09=09err =3D -EINVAL;
-=09=09=09goto chain_put;
+=09=09=09goto release_new_entries;
+=09=09}
+
+=09=09err =3D gate_calc_cycletime(entries, &cycletime);
+=09=09if (err < 0) {
+=09=09=09NL_SET_ERR_MSG(extack, "Invalid cycle time");
+=09=09=09goto release_new_entries;
 =09=09}
 =09}
-=09p->tcfg_cycletime =3D cycletime;
=20
-=09if (tb[TCA_GATE_CYCLE_TIME_EXT])
-=09=09p->tcfg_cycletime_ext =3D
-=09=09=09nla_get_u64(tb[TCA_GATE_CYCLE_TIME_EXT]);
+=09if (ret !=3D ACT_P_CREATED)
+=09=09hrtimer_cancel(&gact->hitimer);
+
+=09p =3D kzalloc(sizeof(*p), GFP_KERNEL);
+=09if (!p) {
+=09=09err =3D -ENOMEM;
+=09=09goto release_new_entries;
+=09}
=20
-=09gate_setup_timer(gact, basetime, tk_offset, clockid,
-=09=09=09 ret =3D=3D ACT_P_CREATED);
+=09INIT_LIST_HEAD(&p->entries);
 =09p->tcfg_priority =3D prio;
+=09p->tcfg_basetime =3D basetime;
+=09p->tcfg_cycletime =3D cycletime;
+=09p->tcfg_cycletime_ext =3D cycletime_ext;
 =09p->tcfg_flags =3D gflags;
-=09gate_get_start_time(gact, &start);
+=09p->tcfg_clockid =3D clockid;
+
+=09if (!list_empty(&newp.entries)) {
+=09=09list_splice_init(&newp.entries, &p->entries);
+=09=09p->num_entries =3D newp.num_entries;
+=09} else if (ret !=3D ACT_P_CREATED) {
+=09=09struct tcfg_gate_entry *entry, *ne;
+
+=09=09list_for_each_entry(entry, &oldp->entries, list) {
+=09=09=09ne =3D kmemdup(entry, sizeof(*ne), GFP_KERNEL);
+=09=09=09if (!ne) {
+=09=09=09=09err =3D -ENOMEM;
+=09=09=09=09goto free_p;
+=09=09=09}
+=09=09=09INIT_LIST_HEAD(&ne->list);
+=09=09=09list_add_tail(&ne->list, &p->entries);
+=09=09}
+=09=09p->num_entries =3D oldp->num_entries;
+=09}
=20
-=09gact->current_close_time =3D start;
-=09gact->current_gate_status =3D GATE_ACT_GATE_OPEN | GATE_ACT_PENDING;
+=09spin_lock_bh(&gact->tcf_lock);
+=09gate_setup_timer(gact, basetime, tk_offset, clockid, ret =3D=3D ACT_P_C=
REATED);
=20
+=09gate_get_start_time(gact, p, &start);
+=09gact->current_close_time =3D start;
 =09gact->next_entry =3D list_first_entry(&p->entries,
 =09=09=09=09=09    struct tcfg_gate_entry, list);
+=09gact->current_entry_octets =3D 0;
+=09gact->current_gate_status =3D GATE_ACT_PENDING;
=20
 =09goto_ch =3D tcf_action_set_ctrlact(*a, parm->action, goto_ch);
=20
 =09gate_start_timer(gact, start);
=20
+=09oldp =3D rcu_replace_pointer(gact->param, p,
+=09=09=09=09   lockdep_is_held(&gact->tcf_lock));
+
 =09spin_unlock_bh(&gact->tcf_lock);
=20
+=09if (oldp)
+=09=09call_rcu(&oldp->rcu, tcf_gate_params_release);
+
 =09if (goto_ch)
 =09=09tcf_chain_put_by_act(goto_ch);
=20
 =09return ret;
=20
-chain_put:
-=09spin_unlock_bh(&gact->tcf_lock);
-
+free_p:
+=09kfree(p);
+release_new_entries:
+=09release_entry_list(&newp.entries);
+put_chain:
 =09if (goto_ch)
 =09=09tcf_chain_put_by_act(goto_ch);
 release_idr:
-=09/* action is not inserted in any list: it's safe to init hitimer
-=09 * without taking tcf_lock.
-=09 */
-=09if (ret =3D=3D ACT_P_CREATED)
-=09=09gate_setup_timer(gact, gact->param.tcfg_basetime,
-=09=09=09=09 gact->tk_offset, gact->param.tcfg_clockid,
-=09=09=09=09 true);
+=09if (ret =3D=3D ACT_P_CREATED) {
+=09=09p =3D rcu_dereference_protected(gact->param, 1);
+=09=09if (p) {
+=09=09=09release_entry_list(&p->entries);
+=09=09=09kfree(p);
+=09=09=09rcu_assign_pointer(gact->param, NULL);
+=09=09}
+=09}
 =09tcf_idr_release(*a, bind);
 =09return err;
 }
@@ -458,9 +603,11 @@ static void tcf_gate_cleanup(struct tc_action *a)
 =09struct tcf_gate *gact =3D to_gate(a);
 =09struct tcf_gate_params *p;
=20
-=09p =3D &gact->param;
 =09hrtimer_cancel(&gact->hitimer);
-=09release_entry_list(&p->entries);
+
+=09p =3D rcu_dereference_protected(gact->param, 1);
+=09if (p)
+=09=09call_rcu(&p->rcu, tcf_gate_params_release);
 }
=20
 static int dumping_entry(struct sk_buff *skb,
@@ -512,7 +659,8 @@ static int tcf_gate_dump(struct sk_buff *skb, struct tc=
_action *a,
 =09spin_lock_bh(&gact->tcf_lock);
 =09opt.action =3D gact->tcf_action;
=20
-=09p =3D &gact->param;
+=09p =3D rcu_dereference_protected(gact->param,
+=09=09=09=09      lockdep_is_held(&gact->tcf_lock));
=20
 =09if (nla_put(skb, TCA_GATE_PARMS, sizeof(opt), &opt))
 =09=09goto nla_put_failure;
--=20
2.52.GIT



