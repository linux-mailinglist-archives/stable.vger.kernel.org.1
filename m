Return-Path: <stable+bounces-213381-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNerBg5Kg2m0kwMAu9opvQ
	(envelope-from <stable+bounces-213381-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 14:30:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B950E66F2
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 14:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0590530E46A4
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 13:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794B739B48F;
	Wed,  4 Feb 2026 13:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="CJny7VRR"
X-Original-To: stable@vger.kernel.org
Received: from mail-07.mail-europe.com (mail-0701.mail-europe.com [51.83.17.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0F634D38E
	for <stable@vger.kernel.org>; Wed,  4 Feb 2026 13:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.17.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770211513; cv=none; b=Bwo4BySx8EQ+RgW8UQNoSroOcEOAZyitK7uUEfyQBpq8iMiRd2qaVuAQ1a52icsg1Leg3F2IbA04nPYpf7FAQo3i7iVn2W4mSelv1k152ay2506kN9UL+gJBjlLhS8HXNEJwaiSBLbkPkHZxHIEjXF74jNosqunIjPeJkbJebOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770211513; c=relaxed/simple;
	bh=KV0CbcjqjCo0Ob9YhLNc58d7FjNioB9tS11V3MkHbqk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MHNWXYrQjeMZVwIF7jBjFdjsEN7XTO0iGvlyraJXS+OuZwEKQZtfEKjUcE4TaxcY+S4KrG+C9uEpbWD47GosYHDuabvOpflaeu2/swcZyk6h35UERnlle/NHpvXeGSBH981oER4qwdnQrPWpXEr20oCzCqOZtm7JtbbUjDJa2IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=fail smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=CJny7VRR; arc=none smtp.client-ip=51.83.17.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=1g4.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1770211497; x=1770470697;
	bh=k8JHG7Yfy12K/FHVi/TvyMV5PKtsYDKSsR1JOZ0H4yk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=CJny7VRRIkzMjK/8YuiNx8EfLJd+aemTxR1D33QmgX3SIkoDlT9XVq5E9nQ47cFEQ
	 8TDVRa/l+IqOvfRwVyqgda40H9+/V0MllMjq7fv2RURLMxSKLO357cymnplMP+855t
	 REmHlT+ASVVwZdJ9erypnZltezOS6WugBnVB+FzMxbFtbET4O9YSFx6P2kbtiJOM9F
	 5GBXc3LmuYWp63iOdSxDg+q6fd267+y7DNm12hQozG+wiBiL3k96cXBRL47c3hLg2z
	 /bLpc+dT0sD8fo3+gPwv75sNN8JHDa3L4gL7V33lmEJIeX+TMG9XCoLU02j4mmra2F
	 s+YEyXIsSRFlA==
Date: Wed, 04 Feb 2026 13:24:53 +0000
To: Victor Nogueira <victor@mojatatu.com>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>
From: Paul Moses <p@1g4.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Moses <p@1g4.org>, stable@vger.kernel.org
Subject: [PATCH net v4 1/1] net/sched: act_gate: protect parameters with RCU on replace
Message-ID: <20260204132428.224465-2-p@1g4.org>
In-Reply-To: <20260204132428.224465-1-p@1g4.org>
References: <20260204132428.224465-1-p@1g4.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 74d262b01d1b9b65f8b16d77ed67c7a6061460ef
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[1g4.org,quarantine];
	R_DKIM_ALLOW(-0.20)[1g4.org:s=protonmail2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-213381-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[mojatatu.com,gmail.com,resnulli.us];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[1g4.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[p@1g4.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[1g4.org:email,1g4.org:dkim,1g4.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,act_gate_ops.net_id:url]
X-Rspamd-Queue-Id: 6B950E66F2
X-Rspamd-Action: no action

Convert act_gate parameters to an RCU protected snapshot. Allocate a new
snapshot on CREATE and REPLACE, swap it under tcf_lock, and free the old
snapshot via call_rcu() to avoid races with the hrtimer callback and the
dump path.

Fixes: a51c328df310 ("net: qos: introduce a gate control flow action")
Cc: stable@vger.kernel.org
Signed-off-by: Paul Moses <p@1g4.org>
---
 include/net/tc_act/tc_gate.h |  29 +++-
 net/sched/act_gate.c         | 300 ++++++++++++++++++++++++++---------
 2 files changed, 246 insertions(+), 83 deletions(-)

diff --git a/include/net/tc_act/tc_gate.h b/include/net/tc_act/tc_gate.h
index c1a67149c6b62..5f4fc407f7bf6 100644
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
@@ -51,47 +52,60 @@ struct tcf_gate {
=20
 #define to_gate(a) ((struct tcf_gate *)a)
=20
+static inline struct tcf_gate_params *tcf_gate_params_locked(const struct =
tc_action *a)
+{
+=09struct tcf_gate *gact =3D to_gate(a);
+
+=09return rcu_dereference_protected(gact->param,
+=09=09=09=09=09 lockdep_is_held(&gact->tcf_lock));
+}
+
 static inline s32 tcf_gate_prio(const struct tc_action *a)
 {
+=09struct tcf_gate_params *p =3D tcf_gate_params_locked(a);
 =09s32 tcfg_prio;
=20
-=09tcfg_prio =3D to_gate(a)->param.tcfg_priority;
+=09tcfg_prio =3D p->tcfg_priority;
=20
 =09return tcfg_prio;
 }
=20
 static inline u64 tcf_gate_basetime(const struct tc_action *a)
 {
+=09struct tcf_gate_params *p =3D tcf_gate_params_locked(a);
 =09u64 tcfg_basetime;
=20
-=09tcfg_basetime =3D to_gate(a)->param.tcfg_basetime;
+=09tcfg_basetime =3D p->tcfg_basetime;
=20
 =09return tcfg_basetime;
 }
=20
 static inline u64 tcf_gate_cycletime(const struct tc_action *a)
 {
+=09struct tcf_gate_params *p =3D tcf_gate_params_locked(a);
 =09u64 tcfg_cycletime;
=20
-=09tcfg_cycletime =3D to_gate(a)->param.tcfg_cycletime;
+=09tcfg_cycletime =3D p->tcfg_cycletime;
=20
 =09return tcfg_cycletime;
 }
=20
 static inline u64 tcf_gate_cycletimeext(const struct tc_action *a)
 {
+=09struct tcf_gate_params *p =3D tcf_gate_params_locked(a);
 =09u64 tcfg_cycletimeext;
=20
-=09tcfg_cycletimeext =3D to_gate(a)->param.tcfg_cycletime_ext;
+=09tcfg_cycletimeext =3D p->tcfg_cycletime_ext;
=20
 =09return tcfg_cycletimeext;
 }
=20
 static inline u32 tcf_gate_num_entries(const struct tc_action *a)
 {
+=09struct tcf_gate_params *p =3D tcf_gate_params_locked(a);
 =09u32 num_entries;
=20
-=09num_entries =3D to_gate(a)->param.num_entries;
+=09num_entries =3D p->num_entries;
=20
 =09return num_entries;
 }
@@ -100,12 +114,11 @@ static inline struct action_gate_entry
 =09=09=09*tcf_gate_get_list(const struct tc_action *a)
 {
 =09struct action_gate_entry *oe;
-=09struct tcf_gate_params *p;
+=09struct tcf_gate_params *p =3D tcf_gate_params_locked(a);
 =09struct tcfg_gate_entry *entry;
 =09u32 num_entries;
 =09int i =3D 0;
=20
-=09p =3D &to_gate(a)->param;
 =09num_entries =3D p->num_entries;
=20
 =09list_for_each_entry(entry, &p->entries, list)
diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
index c1f75f2727576..e93b77edd0694 100644
--- a/net/sched/act_gate.c
+++ b/net/sched/act_gate.c
@@ -32,9 +32,12 @@ static ktime_t gate_get_time(struct tcf_gate *gact)
 =09return KTIME_MAX;
 }
=20
-static void gate_get_start_time(struct tcf_gate *gact, ktime_t *start)
+static void tcf_gate_params_free_rcu(struct rcu_head *head);
+
+static void gate_get_start_time(struct tcf_gate *gact,
+=09=09=09=09const struct tcf_gate_params *param,
+=09=09=09=09ktime_t *start)
 {
-=09struct tcf_gate_params *param =3D &gact->param;
 =09ktime_t now, base, cycle;
 =09u64 n;
=20
@@ -69,12 +72,14 @@ static enum hrtimer_restart gate_timer_func(struct hrti=
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
@@ -225,6 +230,42 @@ static void release_entry_list(struct list_head *entri=
es)
 =09}
 }
=20
+static int tcf_gate_copy_entries(struct tcf_gate_params *dst,
+=09=09=09=09 const struct tcf_gate_params *src,
+=09=09=09=09 struct netlink_ext_ack *extack)
+{
+=09struct tcfg_gate_entry *entry, *new;
+=09int i =3D 0;
+
+=09list_for_each_entry(entry, &src->entries, list) {
+=09=09new =3D kzalloc(sizeof(*new), GFP_KERNEL);
+=09=09if (!new) {
+=09=09=09NL_SET_ERR_MSG(extack, "Not enough memory for entry");
+=09=09=09goto err_free;
+=09=09}
+
+=09=09new->index =3D entry->index;
+=09=09new->gate_state =3D entry->gate_state;
+=09=09new->interval =3D entry->interval;
+=09=09new->ipv =3D entry->ipv;
+=09=09new->maxoctets =3D entry->maxoctets;
+
+=09=09list_add_tail(&new->list, &dst->entries);
+=09=09i++;
+=09}
+
+=09dst->num_entries =3D i;
+=09return 0;
+
+err_free:
+=09list_for_each_entry_safe(new, entry, &dst->entries, list) {
+=09=09list_del(&new->list);
+=09=09kfree(new);
+=09}
+=09dst->num_entries =3D 0;
+=09return -ENOMEM;
+}
+
 static int parse_gate_list(struct nlattr *list_attr,
 =09=09=09   struct tcf_gate_params *sched,
 =09=09=09   struct netlink_ext_ack *extack)
@@ -243,7 +284,7 @@ static int parse_gate_list(struct nlattr *list_attr,
 =09=09=09continue;
 =09=09}
=20
-=09=09entry =3D kzalloc(sizeof(*entry), GFP_ATOMIC);
+=09=09entry =3D kzalloc(sizeof(*entry), GFP_KERNEL);
 =09=09if (!entry) {
 =09=09=09NL_SET_ERR_MSG(extack, "Not enough memory for entry");
 =09=09=09err =3D -ENOMEM;
@@ -266,6 +307,7 @@ static int parse_gate_list(struct nlattr *list_attr,
=20
 release_list:
 =09release_entry_list(&sched->entries);
+=09sched->num_entries =3D 0;
=20
 =09return err;
 }
@@ -274,36 +316,64 @@ static void gate_setup_timer(struct tcf_gate *gact, u=
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
-
-=09=09spin_unlock_bh(&gact->tcf_lock);
-=09=09hrtimer_cancel(&gact->hitimer);
-=09=09spin_lock_bh(&gact->tcf_lock);
 =09}
-=09gact->param.tcfg_basetime =3D basetime;
-=09gact->param.tcfg_clockid =3D clockid;
 =09gact->tk_offset =3D tko;
 =09hrtimer_setup(&gact->hitimer, gate_timer_func, clockid, HRTIMER_MODE_AB=
S_SOFT);
 }
=20
+static int gate_clockid_to_offset(s32 clockid, enum tk_offsets *off,
+=09=09=09=09  struct netlink_ext_ack *extack)
+{
+=09switch (clockid) {
+=09case CLOCK_REALTIME:
+=09=09*off =3D TK_OFFS_REAL;
+=09=09break;
+=09case CLOCK_MONOTONIC:
+=09=09*off =3D TK_OFFS_MAX;
+=09=09break;
+=09case CLOCK_BOOTTIME:
+=09=09*off =3D TK_OFFS_BOOT;
+=09=09break;
+=09case CLOCK_TAI:
+=09=09*off =3D TK_OFFS_TAI;
+=09=09break;
+=09default:
+=09=09NL_SET_ERR_MSG(extack, "Invalid 'clockid'");
+=09=09return -EINVAL;
+=09}
+
+=09return 0;
+}
+
 static int tcf_gate_init(struct net *net, struct nlattr *nla,
 =09=09=09 struct nlattr *est, struct tc_action **a,
 =09=09=09 struct tcf_proto *tp, u32 flags,
 =09=09=09 struct netlink_ext_ack *extack)
 {
 =09struct tc_action_net *tn =3D net_generic(net, act_gate_ops.net_id);
+=09const struct tcf_gate_params *cur_p =3D NULL;
 =09enum tk_offsets tk_offset =3D TK_OFFS_TAI;
 =09bool bind =3D flags & TCA_ACT_FLAGS_BIND;
 =09struct nlattr *tb[TCA_GATE_MAX + 1];
+=09struct tcf_gate_params *old_p, *p;
 =09struct tcf_chain *goto_ch =3D NULL;
 =09u64 cycletime =3D 0, basetime =3D 0;
-=09struct tcf_gate_params *p;
+=09bool clockid_changed =3D false;
+=09bool use_old_entries =3D false;
+=09bool list_provided =3D false;
 =09s32 clockid =3D CLOCK_TAI;
 =09struct tcf_gate *gact;
+=09u64 cycletime_ext =3D 0;
+=09int parsed =3D -ENOENT;
 =09struct tc_gate *parm;
 =09int ret =3D 0, err;
 =09u32 gflags =3D 0;
@@ -323,23 +393,9 @@ static int tcf_gate_init(struct net *net, struct nlatt=
r *nla,
=20
 =09if (tb[TCA_GATE_CLOCKID]) {
 =09=09clockid =3D nla_get_s32(tb[TCA_GATE_CLOCKID]);
-=09=09switch (clockid) {
-=09=09case CLOCK_REALTIME:
-=09=09=09tk_offset =3D TK_OFFS_REAL;
-=09=09=09break;
-=09=09case CLOCK_MONOTONIC:
-=09=09=09tk_offset =3D TK_OFFS_MAX;
-=09=09=09break;
-=09=09case CLOCK_BOOTTIME:
-=09=09=09tk_offset =3D TK_OFFS_BOOT;
-=09=09=09break;
-=09=09case CLOCK_TAI:
-=09=09=09tk_offset =3D TK_OFFS_TAI;
-=09=09=09break;
-=09=09default:
-=09=09=09NL_SET_ERR_MSG(extack, "Invalid 'clockid'");
-=09=09=09return -EINVAL;
-=09=09}
+=09=09err =3D gate_clockid_to_offset(clockid, &tk_offset, extack);
+=09=09if (err)
+=09=09=09return err;
 =09}
=20
 =09parm =3D nla_data(tb[TCA_GATE_PARMS]);
@@ -376,48 +432,128 @@ static int tcf_gate_init(struct net *net, struct nla=
ttr *nla,
 =09=09gflags =3D nla_get_u32(tb[TCA_GATE_FLAGS]);
=20
 =09gact =3D to_gate(*a);
-=09if (ret =3D=3D ACT_P_CREATED)
-=09=09INIT_LIST_HEAD(&gact->param.entries);
-
-=09err =3D tcf_action_check_ctrlact(parm->action, tp, &goto_ch, extack);
-=09if (err < 0)
+=09p =3D kzalloc(sizeof(*p), GFP_KERNEL);
+=09if (!p) {
+=09=09err =3D -ENOMEM;
 =09=09goto release_idr;
+=09}
+=09INIT_LIST_HEAD(&p->entries);
=20
-=09spin_lock_bh(&gact->tcf_lock);
-=09p =3D &gact->param;
+=09list_provided =3D !!tb[TCA_GATE_ENTRY_LIST];
=20
-=09if (tb[TCA_GATE_CYCLE_TIME])
-=09=09cycletime =3D nla_get_u64(tb[TCA_GATE_CYCLE_TIME]);
+=09if (list_provided) {
+=09=09parsed =3D parse_gate_list(tb[TCA_GATE_ENTRY_LIST], p, extack);
+=09=09if (parsed < 0) {
+=09=09=09err =3D parsed;
+=09=09=09goto release_mem;
+=09=09}
+=09}
=20
-=09if (tb[TCA_GATE_ENTRY_LIST]) {
-=09=09err =3D parse_gate_list(tb[TCA_GATE_ENTRY_LIST], p, extack);
+=09if (!list_provided || parsed =3D=3D 0) {
+=09=09if (ret =3D=3D ACT_P_CREATED) {
+=09=09=09NL_SET_ERR_MSG(extack, "The entry list is empty");
+=09=09=09err =3D -EINVAL;
+=09=09=09goto release_mem;
+=09=09}
+=09=09use_old_entries =3D true;
+=09}
+
+=09if (use_old_entries) {
+=09=09cur_p =3D rcu_dereference_protected(gact->param,
+=09=09=09=09=09=09  lockdep_rtnl_is_held());
+=09=09if (!cur_p) {
+=09=09=09NL_SET_ERR_MSG(extack, "Missing schedule entries");
+=09=09=09err =3D -EINVAL;
+=09=09=09goto release_mem;
+=09=09}
+
+=09=09if (!tb[TCA_GATE_PRIORITY])
+=09=09=09prio =3D cur_p->tcfg_priority;
+
+=09=09if (!tb[TCA_GATE_BASE_TIME])
+=09=09=09basetime =3D cur_p->tcfg_basetime;
+
+=09=09if (!tb[TCA_GATE_FLAGS])
+=09=09=09gflags =3D cur_p->tcfg_flags;
+
+=09=09if (!tb[TCA_GATE_CLOCKID]) {
+=09=09=09clockid =3D cur_p->tcfg_clockid;
+=09=09=09err =3D gate_clockid_to_offset(clockid, &tk_offset, extack);
+=09=09=09if (err)
+=09=09=09=09goto release_mem;
+=09=09}
+
+=09=09if (!tb[TCA_GATE_CYCLE_TIME])
+=09=09=09cycletime =3D cur_p->tcfg_cycletime;
+
+=09=09if (!tb[TCA_GATE_CYCLE_TIME_EXT])
+=09=09=09cycletime_ext =3D cur_p->tcfg_cycletime_ext;
+
+=09=09err =3D tcf_gate_copy_entries(p, cur_p, extack);
 =09=09if (err < 0)
-=09=09=09goto chain_put;
+=09=09=09goto release_mem;
 =09}
=20
+=09p->tcfg_priority =3D prio;
+=09p->tcfg_flags =3D gflags;
+
+=09if (tb[TCA_GATE_CYCLE_TIME])
+=09=09cycletime =3D nla_get_u64(tb[TCA_GATE_CYCLE_TIME]);
+
 =09if (!cycletime) {
 =09=09struct tcfg_gate_entry *entry;
 =09=09ktime_t cycle =3D 0;
=20
-=09=09list_for_each_entry(entry, &p->entries, list)
-=09=09=09cycle =3D ktime_add_ns(cycle, entry->interval);
-=09=09cycletime =3D cycle;
+=09=09if (list_provided && !use_old_entries) {
+=09=09=09list_for_each_entry(entry, &p->entries, list)
+=09=09=09=09cycle =3D ktime_add_ns(cycle, entry->interval);
+=09=09=09cycletime =3D cycle;
+=09=09} else if (cur_p) {
+=09=09=09cycletime =3D cur_p->tcfg_cycletime;
+=09=09}
 =09=09if (!cycletime) {
 =09=09=09err =3D -EINVAL;
-=09=09=09goto chain_put;
+=09=09=09goto release_mem;
 =09=09}
 =09}
 =09p->tcfg_cycletime =3D cycletime;
=20
 =09if (tb[TCA_GATE_CYCLE_TIME_EXT])
-=09=09p->tcfg_cycletime_ext =3D
-=09=09=09nla_get_u64(tb[TCA_GATE_CYCLE_TIME_EXT]);
+=09=09cycletime_ext =3D nla_get_u64(tb[TCA_GATE_CYCLE_TIME_EXT]);
+=09p->tcfg_cycletime_ext =3D cycletime_ext;
=20
-=09gate_setup_timer(gact, basetime, tk_offset, clockid,
-=09=09=09 ret =3D=3D ACT_P_CREATED);
-=09p->tcfg_priority =3D prio;
-=09p->tcfg_flags =3D gflags;
-=09gate_get_start_time(gact, &start);
+=09err =3D tcf_action_check_ctrlact(parm->action, tp, &goto_ch, extack);
+=09if (err < 0)
+=09=09goto release_mem;
+
+=09if (ret !=3D ACT_P_CREATED) {
+=09=09cur_p =3D rcu_dereference_protected(gact->param,
+=09=09=09=09=09=09  lockdep_rtnl_is_held());
+=09=09if (cur_p && clockid !=3D cur_p->tcfg_clockid) {
+=09=09=09hrtimer_cancel(&gact->hitimer);
+=09=09=09clockid_changed =3D true;
+=09=09}
+=09}
+
+=09spin_lock_bh(&gact->tcf_lock);
+=09if (ret =3D=3D ACT_P_CREATED) {
+=09=09gate_setup_timer(gact, basetime, tk_offset, clockid, true);
+=09} else {
+=09=09cur_p =3D rcu_dereference_protected(gact->param,
+=09=09=09=09=09=09  lockdep_is_held(&gact->tcf_lock));
+=09=09if (!cur_p) {
+=09=09=09err =3D -EINVAL;
+=09=09=09goto chain_put;
+=09=09}
+=09=09if (clockid_changed)
+=09=09=09gate_setup_timer(gact, basetime, tk_offset, clockid, false);
+=09}
+=09p->tcfg_basetime =3D basetime;
+=09p->tcfg_clockid =3D clockid;
+=09gate_get_start_time(gact, p, &start);
+
+=09old_p =3D rcu_replace_pointer(gact->param, p,
+=09=09=09=09    lockdep_is_held(&gact->tcf_lock));
=20
 =09gact->current_close_time =3D start;
 =09gact->current_gate_status =3D GATE_ACT_GATE_OPEN | GATE_ACT_PENDING;
@@ -434,6 +570,9 @@ static int tcf_gate_init(struct net *net, struct nlattr=
 *nla,
 =09if (goto_ch)
 =09=09tcf_chain_put_by_act(goto_ch);
=20
+=09if (old_p)
+=09=09call_rcu(&old_p->rcu, tcf_gate_params_free_rcu);
+
 =09return ret;
=20
 chain_put:
@@ -441,26 +580,36 @@ static int tcf_gate_init(struct net *net, struct nlat=
tr *nla,
=20
 =09if (goto_ch)
 =09=09tcf_chain_put_by_act(goto_ch);
+release_mem:
+=09release_entry_list(&p->entries);
+=09kfree(p);
 release_idr:
 =09/* action is not inserted in any list: it's safe to init hitimer
 =09 * without taking tcf_lock.
 =09 */
 =09if (ret =3D=3D ACT_P_CREATED)
-=09=09gate_setup_timer(gact, gact->param.tcfg_basetime,
-=09=09=09=09 gact->tk_offset, gact->param.tcfg_clockid,
-=09=09=09=09 true);
+=09=09gate_setup_timer(gact, basetime, tk_offset, clockid, true);
 =09tcf_idr_release(*a, bind);
 =09return err;
 }
=20
+static void tcf_gate_params_free_rcu(struct rcu_head *head)
+{
+=09struct tcf_gate_params *p =3D container_of(head, struct tcf_gate_params=
, rcu);
+
+=09release_entry_list(&p->entries);
+=09kfree(p);
+}
+
 static void tcf_gate_cleanup(struct tc_action *a)
 {
 =09struct tcf_gate *gact =3D to_gate(a);
 =09struct tcf_gate_params *p;
=20
-=09p =3D &gact->param;
 =09hrtimer_cancel(&gact->hitimer);
-=09release_entry_list(&p->entries);
+=09p =3D rcu_replace_pointer(gact->param, NULL, lockdep_rtnl_is_held());
+=09if (p)
+=09=09call_rcu(&p->rcu, tcf_gate_params_free_rcu);
 }
=20
 static int dumping_entry(struct sk_buff *skb,
@@ -499,65 +648,66 @@ static int tcf_gate_dump(struct sk_buff *skb, struct =
tc_action *a,
 {
 =09unsigned char *b =3D skb_tail_pointer(skb);
 =09struct tcf_gate *gact =3D to_gate(a);
+=09struct tcfg_gate_entry *entry;
+=09struct tcf_gate_params *p;
+=09struct nlattr *entry_list;
 =09struct tc_gate opt =3D {
 =09=09.index    =3D gact->tcf_index,
 =09=09.refcnt   =3D refcount_read(&gact->tcf_refcnt) - ref,
 =09=09.bindcnt  =3D atomic_read(&gact->tcf_bindcnt) - bind,
 =09};
-=09struct tcfg_gate_entry *entry;
-=09struct tcf_gate_params *p;
-=09struct nlattr *entry_list;
 =09struct tcf_t t;
=20
-=09spin_lock_bh(&gact->tcf_lock);
-=09opt.action =3D gact->tcf_action;
-
-=09p =3D &gact->param;
+=09opt.action =3D READ_ONCE(gact->tcf_action);
=20
 =09if (nla_put(skb, TCA_GATE_PARMS, sizeof(opt), &opt))
 =09=09goto nla_put_failure;
=20
+=09rcu_read_lock();
+=09p =3D rcu_dereference(gact->param);
+
 =09if (nla_put_u64_64bit(skb, TCA_GATE_BASE_TIME,
 =09=09=09      p->tcfg_basetime, TCA_GATE_PAD))
-=09=09goto nla_put_failure;
+=09=09goto nla_put_failure_rcu;
=20
 =09if (nla_put_u64_64bit(skb, TCA_GATE_CYCLE_TIME,
 =09=09=09      p->tcfg_cycletime, TCA_GATE_PAD))
-=09=09goto nla_put_failure;
+=09=09goto nla_put_failure_rcu;
=20
 =09if (nla_put_u64_64bit(skb, TCA_GATE_CYCLE_TIME_EXT,
 =09=09=09      p->tcfg_cycletime_ext, TCA_GATE_PAD))
-=09=09goto nla_put_failure;
+=09=09goto nla_put_failure_rcu;
=20
 =09if (nla_put_s32(skb, TCA_GATE_CLOCKID, p->tcfg_clockid))
-=09=09goto nla_put_failure;
+=09=09goto nla_put_failure_rcu;
=20
 =09if (nla_put_u32(skb, TCA_GATE_FLAGS, p->tcfg_flags))
-=09=09goto nla_put_failure;
+=09=09goto nla_put_failure_rcu;
=20
 =09if (nla_put_s32(skb, TCA_GATE_PRIORITY, p->tcfg_priority))
-=09=09goto nla_put_failure;
+=09=09goto nla_put_failure_rcu;
=20
 =09entry_list =3D nla_nest_start_noflag(skb, TCA_GATE_ENTRY_LIST);
 =09if (!entry_list)
-=09=09goto nla_put_failure;
+=09=09goto nla_put_failure_rcu;
=20
 =09list_for_each_entry(entry, &p->entries, list) {
 =09=09if (dumping_entry(skb, entry) < 0)
-=09=09=09goto nla_put_failure;
+=09=09=09goto nla_put_failure_rcu;
 =09}
=20
 =09nla_nest_end(skb, entry_list);
+=09rcu_read_unlock();
=20
 =09tcf_tm_dump(&t, &gact->tcf_tm);
 =09if (nla_put_64bit(skb, TCA_GATE_TM, sizeof(t), &t, TCA_GATE_PAD))
 =09=09goto nla_put_failure;
-=09spin_unlock_bh(&gact->tcf_lock);
=20
 =09return skb->len;
=20
+nla_put_failure_rcu:
+=09rcu_read_unlock();
 nla_put_failure:
-=09spin_unlock_bh(&gact->tcf_lock);
 =09nlmsg_trim(skb, b);
 =09return -1;
 }
--=20
2.52.GIT



