Return-Path: <stable+bounces-210753-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMoeM0HYcGmUaQAAu9opvQ
	(envelope-from <stable+bounces-210753-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 14:44:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7627457B7A
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 14:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1145168B0E6
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 13:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB163EFD1B;
	Wed, 21 Jan 2026 13:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="R0JkSntQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-106105.protonmail.ch (mail-106105.protonmail.ch [79.135.106.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DD73D668A
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 13:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769001660; cv=none; b=t61/7ez18R5oFXuEQWwHQjKiaBwYUMv8PhhLo4XehVfFYB3AMExvR4beI9duK/4nJ9VcJvexum0kNV1LZGEOK0P87ZmoK3Mlvug4g4AaPiXUJV7kZhOeHH1lH/uayM1crXOzln6UWNjNAhrqpxDF8Dr1EUc+10iUVT3h3q4/g94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769001660; c=relaxed/simple;
	bh=jCFQmfh2EdjZed4puszkJhORKGrQiKPW5zwgnkEzpF0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VCYsqIouM/CotB6zn2OR5TgcJBMJ40u7Lo+X/p6uG5FOg1Yb9IEM7KVA286Q/4JN4CB99WQG7Ltk8WzNl6EaCiCOFu1z2AmwCalWrMtmeCDb7PfCg+FlmHLr1QjEJIfF5GjpjiiZYordkohSOlb0//oQ5+xSsVavfBEiTIOomAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=R0JkSntQ; arc=none smtp.client-ip=79.135.106.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1769001649; x=1769260849;
	bh=ByI5Y6LRa442jW3BYasuSZquiCEX29TTkkQTPTu1ss0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=R0JkSntQYEYp+tgw1ssgQjsb/HLdcCsobbOCAQ/PuBn75W2VaRVBQ5v8Y/lFDxjSX
	 Zu9QELgC+JhguZShs/55Im2BcHTqZ8ahDYmkd/vKjOzVHZN4p1am8jG+d4RFXx9NCa
	 oUIrciqLrmp+d6VFYev+oO1G4cQF6g2iDjEFfzbDLMeHOq4tIcSHHI3SHXG67AH38f
	 PnKza24GT+lkheUtU3zCO7AuwIS93cVtEntVkpfneOt79YsqiFuSdVJQvqalrDUJr8
	 tH+m9kLedKUT4qxqzokUHeh9x2+KJW6RQe+VbJ3NjmdS88N5EdODvT8QwVdd+1MdYQ
	 LW8MmN9XDuoFg==
Date: Wed, 21 Jan 2026 13:20:43 +0000
To: netdev@vger.kernel.org
From: Paul Moses <p@1g4.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, Paul Moses <p@1g4.org>, stable@vger.kernel.org
Subject: [PATCH net v3 3/7] net/sched: act_gate: build schedule and RCU-swap
Message-ID: <20260121131954.2710459-4-p@1g4.org>
In-Reply-To: <20260121131954.2710459-1-p@1g4.org>
References: <20260121131954.2710459-1-p@1g4.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: e04293c8aae82946e238d7ce6cced05fb0fcd6c0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[1g4.org:s=protonmail2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-210753-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[mojatatu.com,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,1g4.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[1g4.org:+];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[p@1g4.org,stable@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[1g4.org,quarantine];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,1g4.org:email,1g4.org:dkim,1g4.org:mid,act_gate_ops.net_id:url]
X-Rspamd-Queue-Id: 7627457B7A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Build a fresh params snapshot and swap it in with rcu_replace_pointer(),
then free the old snapshot via call_rcu(). This is the same publish+defer
pattern used in taprio sched swapping (sch_taprio.c, commit d5c4546062fd6f)
and in act_pedit param updates (act_pedit.c, commit 52cf89f78c01bf).

When REPLACE omits TCA_GATE_ENTRY_LIST, carry forward the old snapshot fiel=
ds
(basetime/clockid/flags/cycletime/priority) and only override provided attr=
s,
so partial updates don=E2=80=99t reset unrelated state.

Parse entry lists with GFP_KERNEL and explicit error handling, matching tap=
rio=E2=80=99s
schedule parsing (sch_taprio.c, commit 5a781ccbd19e46).

Fixes: a51c328df310 ("net: qos: introduce a gate control flow action")
Signed-off-by: Paul Moses <p@1g4.org>
Cc: stable@vger.kernel.org
---
 net/sched/act_gate.c | 185 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 140 insertions(+), 45 deletions(-)

diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
index faaf34bcaff5d..016708c10a8e0 100644
--- a/net/sched/act_gate.c
+++ b/net/sched/act_gate.c
@@ -32,10 +32,12 @@ static ktime_t gate_get_time(struct tcf_gate *gact)
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
-=09struct tcf_gate_params *param =3D rcu_dereference_protected(gact->param=
,
-=09=09=09=09=09=09=09=09  lockdep_is_held(&gact->tcf_lock));
 =09ktime_t now, base, cycle;
 =09u64 n;
=20
@@ -228,13 +230,44 @@ static void release_entry_list(struct list_head *entr=
ies)
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
+=09=09new =3D kzalloc(sizeof(*new), GFP_KERNEL);
+=09=09if (!new) {
+=09=09=09NL_SET_ERR_MSG(extack, "Not enough memory for entry");
+=09=09=09return -ENOMEM;
+=09=09}
+
+=09=09new->index =3D entry->index;
+=09=09new->gate_state =3D entry->gate_state;
+=09=09new->interval =3D entry->interval;
+=09=09new->ipv =3D entry->ipv;
+=09=09new->maxoctets =3D entry->maxoctets;
+=09=09INIT_LIST_HEAD(&new->list);
+=09=09list_add_tail(&new->list, &dst->entries);
+=09=09i++;
+=09}
+
+=09dst->num_entries =3D i;
+
+=09return i;
+}
+
 static int parse_gate_list(struct nlattr *list_attr,
 =09=09=09   struct tcf_gate_params *sched,
 =09=09=09   struct netlink_ext_ack *extack)
 {
 =09struct tcfg_gate_entry *entry;
 =09struct nlattr *n;
-=09int err, rem;
+=09int err =3D -EINVAL, rem;
 =09int i =3D 0;
=20
 =09if (!list_attr)
@@ -246,7 +279,7 @@ static int parse_gate_list(struct nlattr *list_attr,
 =09=09=09continue;
 =09=09}
=20
-=09=09entry =3D kzalloc(sizeof(*entry), GFP_ATOMIC);
+=09=09entry =3D kzalloc(sizeof(*entry), GFP_KERNEL);
 =09=09if (!entry) {
 =09=09=09NL_SET_ERR_MSG(extack, "Not enough memory for entry");
 =09=09=09err =3D -ENOMEM;
@@ -269,6 +302,7 @@ static int parse_gate_list(struct nlattr *list_attr,
=20
 release_list:
 =09release_entry_list(&sched->entries);
+=09sched->num_entries =3D 0;
=20
 =09return err;
 }
@@ -291,12 +325,6 @@ static void gate_setup_timer(struct tcf_gate *gact, u6=
4 basetime,
 =09=09hrtimer_cancel(&gact->hitimer);
 =09=09spin_lock_bh(&gact->tcf_lock);
 =09}
-=09p =3D rcu_dereference_protected(gact->param,
-=09=09=09=09      lockdep_is_held(&gact->tcf_lock));
-=09if (p) {
-=09=09p->tcfg_basetime =3D basetime;
-=09=09p->tcfg_clockid =3D clockid;
-=09}
 =09gact->tk_offset =3D tko;
 =09hrtimer_setup(&gact->hitimer, gate_timer_func, clockid, HRTIMER_MODE_AB=
S_SOFT);
 }
@@ -307,20 +335,20 @@ static int tcf_gate_init(struct net *net, struct nlat=
tr *nla,
 =09=09=09 struct netlink_ext_ack *extack)
 {
 =09struct tc_action_net *tn =3D net_generic(net, act_gate_ops.net_id);
-=09enum tk_offsets tk_offset =3D TK_OFFS_TAI;
-=09bool bind =3D flags & TCA_ACT_FLAGS_BIND;
-=09struct nlattr *tb[TCA_GATE_MAX + 1];
+=09struct tcf_gate_params *p, *old_p =3D NULL;
 =09struct tcf_chain *goto_ch =3D NULL;
-=09u64 cycletime =3D 0, basetime =3D 0;
-=09struct tcf_gate_params *p;
-=09s32 clockid =3D CLOCK_TAI;
 =09struct tcf_gate *gact;
 =09struct tc_gate *parm;
-=09int ret =3D 0, err;
-=09u32 gflags =3D 0;
-=09s32 prio =3D -1;
+=09struct nlattr *tb[TCA_GATE_MAX + 1];
+=09enum tk_offsets tk_offset =3D TK_OFFS_TAI;
+=09u64 cycletime =3D 0, basetime =3D 0, cycletime_ext =3D 0;
 =09ktime_t start;
+=09s32 clockid =3D CLOCK_TAI;
+=09s32 prio =3D -1;
+=09u32 gflags =3D 0;
 =09u32 index;
+=09int ret =3D 0, err;
+=09bool bind =3D flags & TCA_ACT_FLAGS_BIND;
=20
 =09if (!nla)
 =09=09return -EINVAL;
@@ -388,32 +416,92 @@ static int tcf_gate_init(struct net *net, struct nlat=
tr *nla,
=20
 =09gact =3D to_gate(*a);
=20
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
+=09if (!tb[TCA_GATE_ENTRY_LIST] && ret !=3D ACT_P_CREATED) {
+=09=09const struct tcf_gate_params *old_p_local;
=20
-=09if (ret =3D=3D ACT_P_CREATED) {
-=09=09p =3D kzalloc(sizeof(*p), GFP_ATOMIC);
-=09=09if (!p) {
-=09=09=09err =3D -ENOMEM;
-=09=09=09goto chain_put;
+=09=09old_p_local =3D rcu_dereference_protected(gact->param,
+=09=09=09=09=09=09=09lockdep_rtnl_is_held());
+=09=09if (!old_p_local) {
+=09=09=09NL_SET_ERR_MSG(extack, "Missing schedule entries");
+=09=09=09err =3D -EINVAL;
+=09=09=09goto release_mem;
 =09=09}
-=09=09INIT_LIST_HEAD(&p->entries);
-=09=09rcu_assign_pointer(gact->param, p);
-=09} else {
-=09=09p =3D rcu_dereference_protected(gact->param,
-=09=09=09=09=09      lockdep_is_held(&gact->tcf_lock));
+
+=09=09if (!tb[TCA_GATE_PRIORITY])
+=09=09=09prio =3D old_p_local->tcfg_priority;
+
+=09=09if (!tb[TCA_GATE_BASE_TIME])
+=09=09=09basetime =3D old_p_local->tcfg_basetime;
+
+=09=09if (!tb[TCA_GATE_FLAGS])
+=09=09=09gflags =3D old_p_local->tcfg_flags;
+
+=09=09if (!tb[TCA_GATE_CLOCKID]) {
+=09=09=09clockid =3D old_p_local->tcfg_clockid;
+=09=09=09switch (clockid) {
+=09=09=09case CLOCK_REALTIME:
+=09=09=09=09tk_offset =3D TK_OFFS_REAL;
+=09=09=09=09break;
+=09=09=09case CLOCK_MONOTONIC:
+=09=09=09=09tk_offset =3D TK_OFFS_MAX;
+=09=09=09=09break;
+=09=09=09case CLOCK_BOOTTIME:
+=09=09=09=09tk_offset =3D TK_OFFS_BOOT;
+=09=09=09=09break;
+=09=09=09case CLOCK_TAI:
+=09=09=09=09tk_offset =3D TK_OFFS_TAI;
+=09=09=09=09break;
+=09=09=09default:
+=09=09=09=09NL_SET_ERR_MSG(extack, "Invalid 'clockid'");
+=09=09=09=09err =3D -EINVAL;
+=09=09=09=09goto release_mem;
+=09=09=09}
+=09=09}
+
+=09=09if (!tb[TCA_GATE_CYCLE_TIME])
+=09=09=09cycletime =3D old_p_local->tcfg_cycletime;
+
+=09=09if (!tb[TCA_GATE_CYCLE_TIME_EXT])
+=09=09=09cycletime_ext =3D old_p_local->tcfg_cycletime_ext;
 =09}
=20
+=09p->tcfg_priority =3D prio;
+=09p->tcfg_flags =3D gflags;
+=09p->tcfg_basetime =3D basetime;
+=09p->tcfg_clockid =3D clockid;
+
 =09if (tb[TCA_GATE_CYCLE_TIME])
 =09=09cycletime =3D nla_get_u64(tb[TCA_GATE_CYCLE_TIME]);
=20
 =09if (tb[TCA_GATE_ENTRY_LIST]) {
 =09=09err =3D parse_gate_list(tb[TCA_GATE_ENTRY_LIST], p, extack);
 =09=09if (err < 0)
-=09=09=09goto chain_put;
+=09=09=09goto release_mem;
+=09} else if (ret =3D=3D ACT_P_CREATED) {
+=09=09NL_SET_ERR_MSG(extack, "The entry list is empty");
+=09=09err =3D -EINVAL;
+=09=09goto release_mem;
+=09} else {
+=09=09const struct tcf_gate_params *old_p_local;
+
+=09=09old_p_local =3D rcu_dereference_protected(gact->param,
+=09=09=09=09=09=09=09lockdep_rtnl_is_held());
+=09=09if (!old_p_local) {
+=09=09=09NL_SET_ERR_MSG(extack, "Missing schedule entries");
+=09=09=09err =3D -EINVAL;
+=09=09=09goto release_mem;
+=09=09}
+
+=09=09err =3D tcf_gate_copy_entries(p, old_p_local, extack);
+=09=09if (err < 0)
+=09=09=09goto release_mem;
 =09}
=20
 =09if (!cycletime) {
@@ -425,20 +513,26 @@ static int tcf_gate_init(struct net *net, struct nlat=
tr *nla,
 =09=09cycletime =3D cycle;
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
+=09err =3D tcf_action_check_ctrlact(parm->action, tp, &goto_ch, extack);
+=09if (err < 0)
+=09=09goto release_mem;
+
+=09spin_lock_bh(&gact->tcf_lock);
 =09gate_setup_timer(gact, basetime, tk_offset, clockid,
 =09=09=09 ret =3D=3D ACT_P_CREATED);
-=09p->tcfg_priority =3D prio;
-=09p->tcfg_flags =3D gflags;
-=09gate_get_start_time(gact, &start);
+=09gate_get_start_time(gact, p, &start);
+
+=09old_p =3D rcu_replace_pointer(gact->param, p,
+=09=09=09=09    lockdep_is_held(&gact->tcf_lock));
=20
 =09gact->current_close_time =3D start;
 =09gact->current_gate_status =3D GATE_ACT_GATE_OPEN | GATE_ACT_PENDING;
@@ -455,13 +549,14 @@ static int tcf_gate_init(struct net *net, struct nlat=
tr *nla,
 =09if (goto_ch)
 =09=09tcf_chain_put_by_act(goto_ch);
=20
-=09return ret;
+=09if (old_p)
+=09=09call_rcu(&old_p->rcu, tcf_gate_params_free_rcu);
=20
-chain_put:
-=09spin_unlock_bh(&gact->tcf_lock);
+=09return ret;
=20
-=09if (goto_ch)
-=09=09tcf_chain_put_by_act(goto_ch);
+release_mem:
+=09release_entry_list(&p->entries);
+=09kfree(p);
 release_idr:
 =09/* action is not inserted in any list: it's safe to init hitimer
 =09 * without taking tcf_lock.
--=20
2.52.GIT



