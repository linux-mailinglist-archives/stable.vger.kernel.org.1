Return-Path: <stable+bounces-210755-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MlHHenVcGkOaAAAu9opvQ
	(envelope-from <stable+bounces-210755-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 14:34:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A84A57933
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 14:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 037466C3869
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 13:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B1648BD54;
	Wed, 21 Jan 2026 13:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="UbBXYkbb"
X-Original-To: stable@vger.kernel.org
Received: from mail-07.mail-europe.com (mail-0701.mail-europe.com [51.83.17.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E5641C30E
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 13:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.17.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769001670; cv=none; b=lZogJvemsZa4JqpkG0wqNSoEQVDwUgBvjSpg4FtGENbL5w0IgeYa3D6imVHBADt4jsLbH74/PXjbowL+HHDMTyuCjsjEqIEST1K2V595hv6BKZA45NVfLYxe+9qOM+tdFruM8rm5auDW6R3R239nsJ5HDTAmZzih/vUxQbm/WAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769001670; c=relaxed/simple;
	bh=I2r7cP/avxEfAooDdEHJNIdmgbvA2I/gO0PSjLhEXfo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RNs+vtL7z6WYhO30OxqIgBEb89SP1K5UApmWTZOhwfer65VS0uwKOwTu1gBbX++hJyIAyXpEMrFD0FnOlhcZOD3BaPmpXUrFU0at7oJPQI9+yg4zzUIoybhzoDa2Vz+KcooyqN7fJ9OP6olf9ZSm7O2pzaNAMl6n0EH01bGu4iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=fail smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=UbBXYkbb; arc=none smtp.client-ip=51.83.17.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=1g4.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1769001657; x=1769260857;
	bh=97EnEXfdGOZnSlFj4TNmyaX9AtuuT1NFsPcfG7rTSxY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=UbBXYkbboJzNarrfVp6R3LKDJwLmv8hvF8CWfD0eLP+QUGzEQ58Rve23UEOgSSOIZ
	 FB5itLZOXvS7646dVxmH9rii4L8LBZCWnG+R1dCsJ07ZaMIknoFLE5nwQhrykXherK
	 aIOrOVulBO4IOcsL9y5IY7hX7e7ZDf3M/u+vn3rTgf6hoc1vB65YyUaYQxcT5Pjnew
	 LGWtCv4MsC/zS32RJDEPukUrbJxiol23cArWK0/vDs+exmX5ILWxj3KP0r77RFPF5e
	 2A1WqUYfJZqs2TJM6l3AvHjGffRWwOtHDlXsXNifYltc2pPtLeJmk1mrxITzD+HHUo
	 KevGEMVc8k6YQ==
Date: Wed, 21 Jan 2026 13:20:54 +0000
To: netdev@vger.kernel.org
From: Paul Moses <p@1g4.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, Paul Moses <p@1g4.org>, stable@vger.kernel.org
Subject: [PATCH net v3 5/7] net/sched: act_gate: cancel timer outside tcf_lock
Message-ID: <20260121131954.2710459-6-p@1g4.org>
In-Reply-To: <20260121131954.2710459-1-p@1g4.org>
References: <20260121131954.2710459-1-p@1g4.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 17c3bed5517b3aeac02460dbb1810ac1584a97e5
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
	TAGGED_FROM(0.00)[bounces-210755-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 5A84A57933
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Move hrtimer_cancel() out from under tcf_lock, cancel only on clockid chang=
es,
and always restart using the newly computed start time. For schedule
replacement, bypass the prior expiry clamp so basetime moves forward
without firing the new schedule early.

Other schedulers explicitly cancel hrtimers on reconfig/teardown, e.g.
sch_taprio advance_timer (commit 44d4775ca51805), sch_dualpi2 pi2_timer
(commit 320d031ad6e4d6), and qdisc_watchdog_cancel() (commit 2fbd3da3877ad8=
).

Fixes: a51c328df310 ("net: qos: introduce a gate control flow action")
Signed-off-by: Paul Moses <p@1g4.org>
Cc: stable@vger.kernel.org
---
 net/sched/act_gate.c | 52 ++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 28 deletions(-)

diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
index da4802bbaf4ca..48ff378bb051a 100644
--- a/net/sched/act_gate.c
+++ b/net/sched/act_gate.c
@@ -55,15 +55,17 @@ static void gate_get_start_time(struct tcf_gate *gact,
 =09*start =3D ktime_add_ns(base, (n + 1) * cycle);
 }
=20
-static void gate_start_timer(struct tcf_gate *gact, ktime_t start)
+static void gate_start_timer(struct tcf_gate *gact, ktime_t start, bool re=
place)
 {
 =09ktime_t expires;
=20
-=09expires =3D hrtimer_get_expires(&gact->hitimer);
-=09if (expires =3D=3D 0)
-=09=09expires =3D KTIME_MAX;
+=09if (!replace) {
+=09=09expires =3D hrtimer_get_expires(&gact->hitimer);
+=09=09if (expires =3D=3D 0)
+=09=09=09expires =3D KTIME_MAX;
=20
-=09start =3D min_t(ktime_t, start, expires);
+=09=09start =3D min_t(ktime_t, start, expires);
+=09}
=20
 =09hrtimer_start(&gact->hitimer, start, HRTIMER_MODE_ABS_SOFT);
 }
@@ -307,24 +309,9 @@ static int parse_gate_list(struct nlattr *list_attr,
 =09return err;
 }
=20
-static void gate_setup_timer(struct tcf_gate *gact, u64 basetime,
-=09=09=09     enum tk_offsets tko, s32 clockid,
-=09=09=09     bool do_init)
+static void gate_setup_timer(struct tcf_gate *gact,
+=09=09=09     enum tk_offsets tko, s32 clockid)
 {
-=09struct tcf_gate_params *p;
-
-=09if (!do_init) {
-=09=09p =3D rcu_dereference_protected(gact->param,
-=09=09=09=09=09      lockdep_is_held(&gact->tcf_lock));
-=09=09if (basetime =3D=3D p->tcfg_basetime &&
-=09=09    tko =3D=3D gact->tk_offset &&
-=09=09    clockid =3D=3D p->tcfg_clockid)
-=09=09=09return;
-
-=09=09spin_unlock_bh(&gact->tcf_lock);
-=09=09hrtimer_cancel(&gact->hitimer);
-=09=09spin_lock_bh(&gact->tcf_lock);
-=09}
 =09gact->tk_offset =3D tko;
 =09hrtimer_setup(&gact->hitimer, gate_timer_func, clockid, HRTIMER_MODE_AB=
S_SOFT);
 }
@@ -527,8 +514,19 @@ static int tcf_gate_init(struct net *net, struct nlatt=
r *nla,
 =09=09goto release_mem;
=20
 =09spin_lock_bh(&gact->tcf_lock);
-=09gate_setup_timer(gact, basetime, tk_offset, clockid,
-=09=09=09 ret =3D=3D ACT_P_CREATED);
+
+=09if (ret =3D=3D ACT_P_CREATED) {
+=09=09gate_setup_timer(gact, tk_offset, clockid);
+=09} else {
+=09=09old_p =3D rcu_dereference_protected(gact->param,
+=09=09=09=09=09=09  lockdep_is_held(&gact->tcf_lock));
+=09=09if (!old_p || clockid !=3D old_p->tcfg_clockid) {
+=09=09=09spin_unlock_bh(&gact->tcf_lock);
+=09=09=09hrtimer_cancel(&gact->hitimer);
+=09=09=09spin_lock_bh(&gact->tcf_lock);
+=09=09=09gate_setup_timer(gact, tk_offset, clockid);
+=09=09}
+=09}
 =09gate_get_start_time(gact, p, &start);
=20
 =09old_p =3D rcu_replace_pointer(gact->param, p,
@@ -542,7 +540,7 @@ static int tcf_gate_init(struct net *net, struct nlattr=
 *nla,
=20
 =09goto_ch =3D tcf_action_set_ctrlact(*a, parm->action, goto_ch);
=20
-=09gate_start_timer(gact, start);
+=09gate_start_timer(gact, start, ret !=3D ACT_P_CREATED);
=20
 =09spin_unlock_bh(&gact->tcf_lock);
=20
@@ -562,9 +560,7 @@ static int tcf_gate_init(struct net *net, struct nlattr=
 *nla,
 =09 * without taking tcf_lock.
 =09 */
 =09if (ret =3D=3D ACT_P_CREATED)
-=09=09gate_setup_timer(gact, 0,
-=09=09=09=09 gact->tk_offset, 0,
-=09=09=09=09 true);
+=09=09gate_setup_timer(gact, gact->tk_offset, 0);
 =09tcf_idr_release(*a, bind);
 =09return err;
 }
--=20
2.52.GIT



