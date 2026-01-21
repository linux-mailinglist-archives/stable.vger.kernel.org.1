Return-Path: <stable+bounces-210751-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yP9REybacGnCaQAAu9opvQ
	(envelope-from <stable+bounces-210751-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 14:52:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2955D57F1F
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 14:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 31DA662B370
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 13:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5731A481AA8;
	Wed, 21 Jan 2026 13:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="VCfohR/n"
X-Original-To: stable@vger.kernel.org
Received: from mail-4396.protonmail.ch (mail-4396.protonmail.ch [185.70.43.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB48410D3A
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 13:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769001652; cv=none; b=Dq7HOBjuMmaKi/a+gnsLJmRPDqnPIvavDRSAKqf6J9i7saN0+pbILRkQOgedvhb6Wx8sh0hMO0PJjNj89Oj9qvulULlskUYQRH1y0s5RmytwxAMkFxL4oIab4rmXGmGERkLy+0oQ0roTvywqToCjJAsu6WvA2PPXmIRiFTSVWow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769001652; c=relaxed/simple;
	bh=CByq8Rjc7VnWJfDcxQGqjCghF/JuTIVolRuNii0tPg4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pYnF28nUtHcotKdikUuPGQiHyVNrXKxT74lRmnnw/rEwd9/37rF3h4X1i7edLWXUpS5g5invqByED/fz59UXYW2fNDm2qgKP5N0W30282M+M2hDA4Uh6iXzIM5X+kxB4JYWXE8DZMSOP7bnTQhYeEY1kHACnIvwPBxlcbE5v1Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=VCfohR/n; arc=none smtp.client-ip=185.70.43.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1769001643; x=1769260843;
	bh=U370DSssnpJ04+nHhdTe4tH1gCzAdqbKpil7xi9UpNU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=VCfohR/nwz52wB3iLx37KLtEnpqLoKsBh2rvzOM8SOIA2+kAsV9ES5i/9osHfqS7c
	 2Tnet479Ed/fWeohSy2qA2a19D3sPx+HUQ29jv7pbxwkt6TEE2SDn5IpXvE8S74up4
	 /Oy8NcltDzfd3nNlrmjVNYHMF6jrPktM2rYEViTCWfcRA+HVEUHD2TFZghYR6z8Ofy
	 tnCIJdHKT+Fn2AbABu2Bz0L+IzFjdJDnaSDTR2Vl8QmfXnfuvl+cvdRbyGNPSUcRdt
	 KZ3BnmomXTIQuShiP5jOnfGOprQ6dPxUkQL4KsutmCsvER5e/eCQbs8x/kAw38yraL
	 rE0NV6t/IN7Lg==
Date: Wed, 21 Jan 2026 13:20:39 +0000
To: netdev@vger.kernel.org
From: Paul Moses <p@1g4.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, Paul Moses <p@1g4.org>, stable@vger.kernel.org
Subject: [PATCH net v3 2/7] net/sched: act_gate: add RCU support for parameter update
Message-ID: <20260121131954.2710459-3-p@1g4.org>
In-Reply-To: <20260121131954.2710459-1-p@1g4.org>
References: <20260121131954.2710459-1-p@1g4.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 13488128ec5e4befd59ea54409ca5ada35b66313
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
	TAGGED_FROM(0.00)[bounces-210751-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,1g4.org:email,1g4.org:dkim,1g4.org:mid]
X-Rspamd-Queue-Id: 2955D57F1F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Make gact->param RCU-protected and reclaim old params via call_rcu(). This
follows the pattern used by other actions: act_pedit swaps params with
rcu_replace_pointer() and defers free via call_rcu() (commit 52cf89f78c01bf=
),
act_connmark uses rcu_replace_pointer() under tcf_lock (commit 288864effe33=
88),
and act_tunnel_key does the same under lockdep (commit 445d3749315f34).

Dump readers in act_ct and act_pedit already use rcu_read_lock() +
rcu_dereference() (commits 554e66bad84ce4 and 9d096746572616), so act_gate
must keep old params alive past updates as well.

Fixes: a51c328df310 ("net: qos: introduce a gate control flow action")
Signed-off-by: Paul Moses <p@1g4.org>
Cc: stable@vger.kernel.org
---
 include/net/tc_act/tc_gate.h | 31 ++++++++++++++-----
 net/sched/act_gate.c         | 59 +++++++++++++++++++++++++++---------
 2 files changed, 69 insertions(+), 21 deletions(-)

diff --git a/include/net/tc_act/tc_gate.h b/include/net/tc_act/tc_gate.h
index c1a67149c6b62..05968b3822392 100644
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
@@ -54,8 +55,11 @@ struct tcf_gate {
 static inline s32 tcf_gate_prio(const struct tc_action *a)
 {
 =09s32 tcfg_prio;
+=09struct tcf_gate_params *p;
=20
-=09tcfg_prio =3D to_gate(a)->param.tcfg_priority;
+=09p =3D rcu_dereference_protected(to_gate(a)->param,
+=09=09=09=09      lockdep_rtnl_is_held());
+=09tcfg_prio =3D p->tcfg_priority;
=20
 =09return tcfg_prio;
 }
@@ -63,8 +67,11 @@ static inline s32 tcf_gate_prio(const struct tc_action *=
a)
 static inline u64 tcf_gate_basetime(const struct tc_action *a)
 {
 =09u64 tcfg_basetime;
+=09struct tcf_gate_params *p;
=20
-=09tcfg_basetime =3D to_gate(a)->param.tcfg_basetime;
+=09p =3D rcu_dereference_protected(to_gate(a)->param,
+=09=09=09=09      lockdep_rtnl_is_held());
+=09tcfg_basetime =3D p->tcfg_basetime;
=20
 =09return tcfg_basetime;
 }
@@ -72,8 +79,11 @@ static inline u64 tcf_gate_basetime(const struct tc_acti=
on *a)
 static inline u64 tcf_gate_cycletime(const struct tc_action *a)
 {
 =09u64 tcfg_cycletime;
+=09struct tcf_gate_params *p;
=20
-=09tcfg_cycletime =3D to_gate(a)->param.tcfg_cycletime;
+=09p =3D rcu_dereference_protected(to_gate(a)->param,
+=09=09=09=09      lockdep_rtnl_is_held());
+=09tcfg_cycletime =3D p->tcfg_cycletime;
=20
 =09return tcfg_cycletime;
 }
@@ -81,8 +91,11 @@ static inline u64 tcf_gate_cycletime(const struct tc_act=
ion *a)
 static inline u64 tcf_gate_cycletimeext(const struct tc_action *a)
 {
 =09u64 tcfg_cycletimeext;
+=09struct tcf_gate_params *p;
=20
-=09tcfg_cycletimeext =3D to_gate(a)->param.tcfg_cycletime_ext;
+=09p =3D rcu_dereference_protected(to_gate(a)->param,
+=09=09=09=09      lockdep_rtnl_is_held());
+=09tcfg_cycletimeext =3D p->tcfg_cycletime_ext;
=20
 =09return tcfg_cycletimeext;
 }
@@ -90,8 +103,11 @@ static inline u64 tcf_gate_cycletimeext(const struct tc=
_action *a)
 static inline u32 tcf_gate_num_entries(const struct tc_action *a)
 {
 =09u32 num_entries;
+=09struct tcf_gate_params *p;
=20
-=09num_entries =3D to_gate(a)->param.num_entries;
+=09p =3D rcu_dereference_protected(to_gate(a)->param,
+=09=09=09=09      lockdep_rtnl_is_held());
+=09num_entries =3D p->num_entries;
=20
 =09return num_entries;
 }
@@ -105,7 +121,8 @@ static inline struct action_gate_entry
 =09u32 num_entries;
 =09int i =3D 0;
=20
-=09p =3D &to_gate(a)->param;
+=09p =3D rcu_dereference_protected(to_gate(a)->param,
+=09=09=09=09      lockdep_rtnl_is_held());
 =09num_entries =3D p->num_entries;
=20
 =09list_for_each_entry(entry, &p->entries, list)
diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
index aacd57e5f4374..faaf34bcaff5d 100644
--- a/net/sched/act_gate.c
+++ b/net/sched/act_gate.c
@@ -34,7 +34,8 @@ static ktime_t gate_get_time(struct tcf_gate *gact)
=20
 static void gate_get_start_time(struct tcf_gate *gact, ktime_t *start)
 {
-=09struct tcf_gate_params *param =3D &gact->param;
+=09struct tcf_gate_params *param =3D rcu_dereference_protected(gact->param=
,
+=09=09=09=09=09=09=09=09  lockdep_is_held(&gact->tcf_lock));
 =09ktime_t now, base, cycle;
 =09u64 n;
=20
@@ -69,12 +70,14 @@ static enum hrtimer_restart gate_timer_func(struct hrti=
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
@@ -274,18 +277,26 @@ static void gate_setup_timer(struct tcf_gate *gact, u=
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
+=09p =3D rcu_dereference_protected(gact->param,
+=09=09=09=09      lockdep_is_held(&gact->tcf_lock));
+=09if (p) {
+=09=09p->tcfg_basetime =3D basetime;
+=09=09p->tcfg_clockid =3D clockid;
+=09}
 =09gact->tk_offset =3D tko;
 =09hrtimer_setup(&gact->hitimer, gate_timer_func, clockid, HRTIMER_MODE_AB=
S_SOFT);
 }
@@ -376,15 +387,25 @@ static int tcf_gate_init(struct net *net, struct nlat=
tr *nla,
 =09=09gflags =3D nla_get_u32(tb[TCA_GATE_FLAGS]);
=20
 =09gact =3D to_gate(*a);
-=09if (ret =3D=3D ACT_P_CREATED)
-=09=09INIT_LIST_HEAD(&gact->param.entries);
=20
 =09err =3D tcf_action_check_ctrlact(parm->action, tp, &goto_ch, extack);
 =09if (err < 0)
 =09=09goto release_idr;
=20
 =09spin_lock_bh(&gact->tcf_lock);
-=09p =3D &gact->param;
+
+=09if (ret =3D=3D ACT_P_CREATED) {
+=09=09p =3D kzalloc(sizeof(*p), GFP_ATOMIC);
+=09=09if (!p) {
+=09=09=09err =3D -ENOMEM;
+=09=09=09goto chain_put;
+=09=09}
+=09=09INIT_LIST_HEAD(&p->entries);
+=09=09rcu_assign_pointer(gact->param, p);
+=09} else {
+=09=09p =3D rcu_dereference_protected(gact->param,
+=09=09=09=09=09      lockdep_is_held(&gact->tcf_lock));
+=09}
=20
 =09if (tb[TCA_GATE_CYCLE_TIME])
 =09=09cycletime =3D nla_get_u64(tb[TCA_GATE_CYCLE_TIME]);
@@ -446,21 +467,30 @@ static int tcf_gate_init(struct net *net, struct nlat=
tr *nla,
 =09 * without taking tcf_lock.
 =09 */
 =09if (ret =3D=3D ACT_P_CREATED)
-=09=09gate_setup_timer(gact, gact->param.tcfg_basetime,
-=09=09=09=09 gact->tk_offset, gact->param.tcfg_clockid,
+=09=09gate_setup_timer(gact, 0,
+=09=09=09=09 gact->tk_offset, 0,
 =09=09=09=09 true);
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
+=09p =3D rcu_replace_pointer(gact->param, NULL, lockdep_rtnl_is_held());
 =09hrtimer_cancel(&gact->hitimer);
-=09release_entry_list(&p->entries);
+=09if (p)
+=09=09call_rcu(&p->rcu, tcf_gate_params_free_rcu);
 }
=20
 static int dumping_entry(struct sk_buff *skb,
@@ -512,7 +542,8 @@ static int tcf_gate_dump(struct sk_buff *skb, struct tc=
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



