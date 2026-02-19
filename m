Return-Path: <stable+bounces-217383-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mER0HYh2lmkIfwIAu9opvQ
	(envelope-from <stable+bounces-217383-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 03:33:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F1915BBF3
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 03:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44EC83055C98
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 02:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA34E72621;
	Thu, 19 Feb 2026 02:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="JCqOKvgn"
X-Original-To: stable@vger.kernel.org
Received: from mail-07.mail-europe.com (mail-0701.mail-europe.com [51.83.17.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E21274FE9
	for <stable@vger.kernel.org>; Thu, 19 Feb 2026 02:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.17.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771468352; cv=none; b=lW+qGEAoMv7Moym21hM8isu2Ve3cqEopw38Y/G6T82h+NbK2IMx/cyGQq++nDL9mHryMu0xOV+ckv7d5s/vNJBjBoAmRZsTsD1dG6x57caVIuNpGgGQ5D66/D41IlAF97wjt+2zjSUDBSjDSP7qsmhinTLItEeqEKdOarspZaYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771468352; c=relaxed/simple;
	bh=zxXGhjODAFgRIRQlyCUi7xW+J+ssegJPyceuyk6h1+0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gKm9EMNR7HjeI5k2ggdj2s+HD5s6CrRrfOffJg9VkAXDYGeeeD+cbFSt+aq7iaq02AhULv7kI7TWOZnu9FTjXJqbtqV51NYHAg4qB4ozdz0sQNrRfNjsbE4Rq0L/ssax/izWvGz2tKIt9ztGGdEfno+Qvb8/+lav4XdipF0OTfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=fail smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=JCqOKvgn; arc=none smtp.client-ip=51.83.17.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=1g4.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1771468334; x=1771727534;
	bh=Nyt2Zgb+VrQyg0+HBjMXHqr7fYWEnhcPuzgEaaKtc7c=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=JCqOKvgnpsQo77k+xGEuY7IL8TeW05oYqXeRsFDBbYo0T0FHm/8vmN5ZKeTXq6MsJ
	 HZMoBJJ6B0DbyXigofAovKdl6LluXZkwmRpltE1cXjxd5LTnx10R3knuHxJN4bfdBa
	 iSGXqiC/aFkV4BerfW2gwyx5RSCVt9L9E3RcmF1x3dJ+RB+eJcurhen7Angqs0qH//
	 c+lmjX9mvsfPAEQjWz0VlhOgsItkhvsZ9ypylyM4nQPF/zznvcU7N6U8cM2WBaWRBK
	 dfCU4x1TQsAM9o0yVgIZQlpmIdT2OLWprjLgnCl5Xv03Z0mRQ47lKCUkn+eCKzKRse
	 Ps+1BWDlXzFdg==
Date: Thu, 19 Feb 2026 02:32:09 +0000
To: Victor Nogueira <victor@mojatatu.com>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>
From: Paul Moses <p@1g4.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Moses <p@1g4.org>, stable@vger.kernel.org
Subject: [PATCH net v7 1/1] net/sched: act_gate: snapshot parameters with RCU on replace
Message-ID: <20260219023151.171753-2-p@1g4.org>
In-Reply-To: <20260219023151.171753-1-p@1g4.org>
References: <20260219023151.171753-1-p@1g4.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: bd5fe6c9b83aae3586d623f4e86634153844c92d
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217383-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[1g4.org:mid,1g4.org:dkim,1g4.org:email]
X-Rspamd-Queue-Id: C7F1915BBF3
X-Rspamd-Action: no action

The gate action can be replaced while the hrtimer callback or dump path is
walking the schedule list.

Convert the parameters to an RCU-protected snapshot and swap updates under
tcf_lock, freeing the previous snapshot via call_rcu(). When REPLACE omits
the entry list, preserve the existing schedule so the effective state is
unchanged.

Fixes: a51c328df310 ("net: qos: introduce a gate control flow action")
Cc: stable@vger.kernel.org
Signed-off-by: Paul Moses <p@1g4.org>
---
 include/net/tc_act/tc_gate.h |  33 ++++-
 net/sched/act_gate.c         | 265 +++++++++++++++++++++++++----------
 2 files changed, 215 insertions(+), 83 deletions(-)

diff --git a/include/net/tc_act/tc_gate.h b/include/net/tc_act/tc_gate.h
index c1a67149c6b62..5223c00279d5a 100644
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
@@ -51,47 +52,65 @@ struct tcf_gate {
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
+=09struct tcf_gate_params *p;
 =09s32 tcfg_prio;
=20
-=09tcfg_prio =3D to_gate(a)->param.tcfg_priority;
+=09p =3D tcf_gate_params_locked(a);
+=09tcfg_prio =3D p->tcfg_priority;
=20
 =09return tcfg_prio;
 }
=20
 static inline u64 tcf_gate_basetime(const struct tc_action *a)
 {
+=09struct tcf_gate_params *p;
 =09u64 tcfg_basetime;
=20
-=09tcfg_basetime =3D to_gate(a)->param.tcfg_basetime;
+=09p =3D tcf_gate_params_locked(a);
+=09tcfg_basetime =3D p->tcfg_basetime;
=20
 =09return tcfg_basetime;
 }
=20
 static inline u64 tcf_gate_cycletime(const struct tc_action *a)
 {
+=09struct tcf_gate_params *p;
 =09u64 tcfg_cycletime;
=20
-=09tcfg_cycletime =3D to_gate(a)->param.tcfg_cycletime;
+=09p =3D tcf_gate_params_locked(a);
+=09tcfg_cycletime =3D p->tcfg_cycletime;
=20
 =09return tcfg_cycletime;
 }
=20
 static inline u64 tcf_gate_cycletimeext(const struct tc_action *a)
 {
+=09struct tcf_gate_params *p;
 =09u64 tcfg_cycletimeext;
=20
-=09tcfg_cycletimeext =3D to_gate(a)->param.tcfg_cycletime_ext;
+=09p =3D tcf_gate_params_locked(a);
+=09tcfg_cycletimeext =3D p->tcfg_cycletime_ext;
=20
 =09return tcfg_cycletimeext;
 }
=20
 static inline u32 tcf_gate_num_entries(const struct tc_action *a)
 {
+=09struct tcf_gate_params *p;
 =09u32 num_entries;
=20
-=09num_entries =3D to_gate(a)->param.num_entries;
+=09p =3D tcf_gate_params_locked(a);
+=09num_entries =3D p->num_entries;
=20
 =09return num_entries;
 }
@@ -105,7 +124,7 @@ static inline struct action_gate_entry
 =09u32 num_entries;
 =09int i =3D 0;
=20
-=09p =3D &to_gate(a)->param;
+=09p =3D tcf_gate_params_locked(a);
 =09num_entries =3D p->num_entries;
=20
 =09list_for_each_entry(entry, &p->entries, list)
diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
index c1f75f2727576..917974b68c3fd 100644
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
 =09struct tcfg_gate_entry *next;
+=09struct tcf_gate_params *p;
 =09ktime_t close_time, now;
=20
 =09spin_lock(&gact->tcf_lock);
=20
+=09p =3D rcu_dereference_protected(gact->param,
+=09=09=09=09      lockdep_is_held(&gact->tcf_lock));
 =09next =3D gact->next_entry;
=20
 =09/* cycle start, clear pending bit, clear total octets */
@@ -225,6 +230,35 @@ static void release_entry_list(struct list_head *entri=
es)
 =09}
 }
=20
+static int tcf_gate_copy_entries(struct tcf_gate_params *dst,
+=09=09=09=09 const struct tcf_gate_params *src,
+=09=09=09=09 struct netlink_ext_ack *extack)
+{
+=09struct tcfg_gate_entry *entry;
+=09int i =3D 0;
+
+=09list_for_each_entry(entry, &src->entries, list) {
+=09=09struct tcfg_gate_entry *new;
+
+=09=09new =3D kzalloc(sizeof(*new), GFP_ATOMIC);
+=09=09if (!new) {
+=09=09=09NL_SET_ERR_MSG(extack, "Not enough memory for entry");
+=09=09=09return -ENOMEM;
+=09=09}
+
+=09=09new->index      =3D entry->index;
+=09=09new->gate_state =3D entry->gate_state;
+=09=09new->interval   =3D entry->interval;
+=09=09new->ipv        =3D entry->ipv;
+=09=09new->maxoctets  =3D entry->maxoctets;
+=09=09list_add_tail(&new->list, &dst->entries);
+=09=09i++;
+=09}
+
+=09dst->num_entries =3D i;
+=09return 0;
+}
+
 static int parse_gate_list(struct nlattr *list_attr,
 =09=09=09   struct tcf_gate_params *sched,
 =09=09=09   struct netlink_ext_ack *extack)
@@ -270,24 +304,44 @@ static int parse_gate_list(struct nlattr *list_attr,
 =09return err;
 }
=20
-static void gate_setup_timer(struct tcf_gate *gact, u64 basetime,
-=09=09=09     enum tk_offsets tko, s32 clockid,
-=09=09=09     bool do_init)
+static bool gate_timer_needs_cancel(u64 basetime, u64 old_basetime,
+=09=09=09=09    enum tk_offsets tko,
+=09=09=09=09    enum tk_offsets old_tko,
+=09=09=09=09    s32 clockid, s32 old_clockid)
 {
-=09if (!do_init) {
-=09=09if (basetime =3D=3D gact->param.tcfg_basetime &&
-=09=09    tko =3D=3D gact->tk_offset &&
-=09=09    clockid =3D=3D gact->param.tcfg_clockid)
-=09=09=09return;
+=09return basetime !=3D old_basetime ||
+=09       clockid !=3D old_clockid ||
+=09       tko !=3D old_tko;
+}
=20
-=09=09spin_unlock_bh(&gact->tcf_lock);
-=09=09hrtimer_cancel(&gact->hitimer);
-=09=09spin_lock_bh(&gact->tcf_lock);
+static int gate_clock_resolve(s32 clockid, enum tk_offsets *tko,
+=09=09=09      struct netlink_ext_ack *extack)
+{
+=09switch (clockid) {
+=09case CLOCK_REALTIME:
+=09=09*tko =3D TK_OFFS_REAL;
+=09=09return 0;
+=09case CLOCK_MONOTONIC:
+=09=09*tko =3D TK_OFFS_MAX;
+=09=09return 0;
+=09case CLOCK_BOOTTIME:
+=09=09*tko =3D TK_OFFS_BOOT;
+=09=09return 0;
+=09case CLOCK_TAI:
+=09=09*tko =3D TK_OFFS_TAI;
+=09=09return 0;
+=09default:
+=09=09NL_SET_ERR_MSG(extack, "Invalid 'clockid'");
+=09=09return -EINVAL;
 =09}
-=09gact->param.tcfg_basetime =3D basetime;
-=09gact->param.tcfg_clockid =3D clockid;
-=09gact->tk_offset =3D tko;
-=09hrtimer_setup(&gact->hitimer, gate_timer_func, clockid, HRTIMER_MODE_AB=
S_SOFT);
+}
+
+static void gate_setup_timer(struct tcf_gate *gact, s32 clockid,
+=09=09=09     enum tk_offsets tko)
+{
+=09WRITE_ONCE(gact->tk_offset, tko);
+=09hrtimer_setup(&gact->hitimer, gate_timer_func, clockid,
+=09=09      HRTIMER_MODE_ABS_SOFT);
 }
=20
 static int tcf_gate_init(struct net *net, struct nlattr *nla,
@@ -296,15 +350,22 @@ static int tcf_gate_init(struct net *net, struct nlat=
tr *nla,
 =09=09=09 struct netlink_ext_ack *extack)
 {
 =09struct tc_action_net *tn =3D net_generic(net, act_gate_ops.net_id);
-=09enum tk_offsets tk_offset =3D TK_OFFS_TAI;
+=09u64 cycletime =3D 0, basetime =3D 0, cycletime_ext =3D 0;
+=09struct tcf_gate_params *p =3D NULL, *old_p =3D NULL;
+=09enum tk_offsets old_tk_offset =3D TK_OFFS_TAI;
+=09const struct tcf_gate_params *cur_p =3D NULL;
 =09bool bind =3D flags & TCA_ACT_FLAGS_BIND;
 =09struct nlattr *tb[TCA_GATE_MAX + 1];
+=09enum tk_offsets tko =3D TK_OFFS_TAI;
 =09struct tcf_chain *goto_ch =3D NULL;
-=09u64 cycletime =3D 0, basetime =3D 0;
-=09struct tcf_gate_params *p;
+=09s32 timer_clockid =3D CLOCK_TAI;
+=09bool use_old_entries =3D false;
+=09s32 old_clockid =3D CLOCK_TAI;
+=09bool need_cancel =3D false;
 =09s32 clockid =3D CLOCK_TAI;
 =09struct tcf_gate *gact;
 =09struct tc_gate *parm;
+=09u64 old_basetime =3D 0;
 =09int ret =3D 0, err;
 =09u32 gflags =3D 0;
 =09s32 prio =3D -1;
@@ -321,26 +382,8 @@ static int tcf_gate_init(struct net *net, struct nlatt=
r *nla,
 =09if (!tb[TCA_GATE_PARMS])
 =09=09return -EINVAL;
=20
-=09if (tb[TCA_GATE_CLOCKID]) {
+=09if (tb[TCA_GATE_CLOCKID])
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
-=09}
=20
 =09parm =3D nla_data(tb[TCA_GATE_PARMS]);
 =09index =3D parm->index;
@@ -366,6 +409,60 @@ static int tcf_gate_init(struct net *net, struct nlatt=
r *nla,
 =09=09return -EEXIST;
 =09}
=20
+=09gact =3D to_gate(*a);
+
+=09err =3D tcf_action_check_ctrlact(parm->action, tp, &goto_ch, extack);
+=09if (err < 0)
+=09=09goto release_idr;
+
+=09p =3D kzalloc(sizeof(*p), GFP_KERNEL);
+=09if (!p) {
+=09=09err =3D -ENOMEM;
+=09=09goto chain_put;
+=09}
+=09INIT_LIST_HEAD(&p->entries);
+
+=09use_old_entries =3D !tb[TCA_GATE_ENTRY_LIST];
+=09if (!use_old_entries) {
+=09=09err =3D parse_gate_list(tb[TCA_GATE_ENTRY_LIST], p, extack);
+=09=09if (err < 0)
+=09=09=09goto err_free;
+=09=09use_old_entries =3D !err;
+=09}
+
+=09if (ret =3D=3D ACT_P_CREATED && use_old_entries) {
+=09=09NL_SET_ERR_MSG(extack, "The entry list is empty");
+=09=09err =3D -EINVAL;
+=09=09goto err_free;
+=09}
+
+=09if (ret !=3D ACT_P_CREATED) {
+=09=09rcu_read_lock();
+=09=09cur_p =3D rcu_dereference(gact->param);
+
+=09=09old_basetime  =3D cur_p->tcfg_basetime;
+=09=09old_clockid   =3D cur_p->tcfg_clockid;
+=09=09old_tk_offset =3D READ_ONCE(gact->tk_offset);
+
+=09=09basetime      =3D old_basetime;
+=09=09cycletime_ext =3D cur_p->tcfg_cycletime_ext;
+=09=09prio          =3D cur_p->tcfg_priority;
+=09=09gflags        =3D cur_p->tcfg_flags;
+
+=09=09if (!tb[TCA_GATE_CLOCKID])
+=09=09=09clockid =3D old_clockid;
+
+=09=09err =3D 0;
+=09=09if (use_old_entries) {
+=09=09=09err =3D tcf_gate_copy_entries(p, cur_p, extack);
+=09=09=09if (!err && !tb[TCA_GATE_CYCLE_TIME])
+=09=09=09=09cycletime =3D cur_p->tcfg_cycletime;
+=09=09}
+=09=09rcu_read_unlock();
+=09=09if (err)
+=09=09=09goto err_free;
+=09}
+
 =09if (tb[TCA_GATE_PRIORITY])
 =09=09prio =3D nla_get_s32(tb[TCA_GATE_PRIORITY]);
=20
@@ -375,25 +472,26 @@ static int tcf_gate_init(struct net *net, struct nlat=
tr *nla,
 =09if (tb[TCA_GATE_FLAGS])
 =09=09gflags =3D nla_get_u32(tb[TCA_GATE_FLAGS]);
=20
-=09gact =3D to_gate(*a);
-=09if (ret =3D=3D ACT_P_CREATED)
-=09=09INIT_LIST_HEAD(&gact->param.entries);
+=09if (tb[TCA_GATE_CYCLE_TIME])
+=09=09cycletime =3D nla_get_u64(tb[TCA_GATE_CYCLE_TIME]);
=20
-=09err =3D tcf_action_check_ctrlact(parm->action, tp, &goto_ch, extack);
-=09if (err < 0)
-=09=09goto release_idr;
+=09if (tb[TCA_GATE_CYCLE_TIME_EXT])
+=09=09cycletime_ext =3D nla_get_u64(tb[TCA_GATE_CYCLE_TIME_EXT]);
=20
-=09spin_lock_bh(&gact->tcf_lock);
-=09p =3D &gact->param;
+=09err =3D gate_clock_resolve(clockid, &tko, extack);
+=09if (err)
+=09=09goto err_free;
+=09timer_clockid =3D clockid;
=20
-=09if (tb[TCA_GATE_CYCLE_TIME])
-=09=09cycletime =3D nla_get_u64(tb[TCA_GATE_CYCLE_TIME]);
+=09need_cancel =3D ret !=3D ACT_P_CREATED &&
+=09=09      gate_timer_needs_cancel(basetime, old_basetime,
+=09=09=09=09=09      tko, old_tk_offset,
+=09=09=09=09=09      timer_clockid, old_clockid);
=20
-=09if (tb[TCA_GATE_ENTRY_LIST]) {
-=09=09err =3D parse_gate_list(tb[TCA_GATE_ENTRY_LIST], p, extack);
-=09=09if (err < 0)
-=09=09=09goto chain_put;
-=09}
+=09if (need_cancel)
+=09=09hrtimer_cancel(&gact->hitimer);
+
+=09spin_lock_bh(&gact->tcf_lock);
=20
 =09if (!cycletime) {
 =09=09struct tcfg_gate_entry *entry;
@@ -404,20 +502,22 @@ static int tcf_gate_init(struct net *net, struct nlat=
tr *nla,
 =09=09cycletime =3D cycle;
 =09=09if (!cycletime) {
 =09=09=09err =3D -EINVAL;
-=09=09=09goto chain_put;
+=09=09=09goto unlock;
 =09=09}
 =09}
 =09p->tcfg_cycletime =3D cycletime;
+=09p->tcfg_cycletime_ext =3D cycletime_ext;
=20
-=09if (tb[TCA_GATE_CYCLE_TIME_EXT])
-=09=09p->tcfg_cycletime_ext =3D
-=09=09=09nla_get_u64(tb[TCA_GATE_CYCLE_TIME_EXT]);
-
-=09gate_setup_timer(gact, basetime, tk_offset, clockid,
-=09=09=09 ret =3D=3D ACT_P_CREATED);
+=09if (need_cancel || ret =3D=3D ACT_P_CREATED)
+=09=09gate_setup_timer(gact, timer_clockid, tko);
 =09p->tcfg_priority =3D prio;
 =09p->tcfg_flags =3D gflags;
-=09gate_get_start_time(gact, &start);
+=09p->tcfg_basetime =3D basetime;
+=09p->tcfg_clockid =3D timer_clockid;
+=09gate_get_start_time(gact, p, &start);
+
+=09old_p =3D rcu_replace_pointer(gact->param, p,
+=09=09=09=09    lockdep_is_held(&gact->tcf_lock));
=20
 =09gact->current_close_time =3D start;
 =09gact->current_gate_status =3D GATE_ACT_GATE_OPEN | GATE_ACT_PENDING;
@@ -434,11 +534,17 @@ static int tcf_gate_init(struct net *net, struct nlat=
tr *nla,
 =09if (goto_ch)
 =09=09tcf_chain_put_by_act(goto_ch);
=20
+=09if (old_p)
+=09=09call_rcu(&old_p->rcu, tcf_gate_params_free_rcu);
+
 =09return ret;
=20
-chain_put:
+unlock:
 =09spin_unlock_bh(&gact->tcf_lock);
-
+err_free:
+=09release_entry_list(&p->entries);
+=09kfree(p);
+chain_put:
 =09if (goto_ch)
 =09=09tcf_chain_put_by_act(goto_ch);
 release_idr:
@@ -446,21 +552,29 @@ static int tcf_gate_init(struct net *net, struct nlat=
tr *nla,
 =09 * without taking tcf_lock.
 =09 */
 =09if (ret =3D=3D ACT_P_CREATED)
-=09=09gate_setup_timer(gact, gact->param.tcfg_basetime,
-=09=09=09=09 gact->tk_offset, gact->param.tcfg_clockid,
-=09=09=09=09 true);
+=09=09gate_setup_timer(gact, timer_clockid, tko);
+
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
+=09p =3D rcu_dereference_protected(gact->param, 1);
+=09if (p)
+=09=09call_rcu(&p->rcu, tcf_gate_params_free_rcu);
 }
=20
 static int dumping_entry(struct sk_buff *skb,
@@ -509,10 +623,9 @@ static int tcf_gate_dump(struct sk_buff *skb, struct t=
c_action *a,
 =09struct nlattr *entry_list;
 =09struct tcf_t t;
=20
-=09spin_lock_bh(&gact->tcf_lock);
-=09opt.action =3D gact->tcf_action;
-
-=09p =3D &gact->param;
+=09rcu_read_lock();
+=09opt.action =3D READ_ONCE(gact->tcf_action);
+=09p =3D rcu_dereference(gact->param);
=20
 =09if (nla_put(skb, TCA_GATE_PARMS, sizeof(opt), &opt))
 =09=09goto nla_put_failure;
@@ -552,12 +665,12 @@ static int tcf_gate_dump(struct sk_buff *skb, struct =
tc_action *a,
 =09tcf_tm_dump(&t, &gact->tcf_tm);
 =09if (nla_put_64bit(skb, TCA_GATE_TM, sizeof(t), &t, TCA_GATE_PAD))
 =09=09goto nla_put_failure;
-=09spin_unlock_bh(&gact->tcf_lock);
+=09rcu_read_unlock();
=20
 =09return skb->len;
=20
 nla_put_failure:
-=09spin_unlock_bh(&gact->tcf_lock);
+=09rcu_read_unlock();
 =09nlmsg_trim(skb, b);
 =09return -1;
 }
--=20
2.53.0



