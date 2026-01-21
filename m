Return-Path: <stable+bounces-210752-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDzGImjYcGkOaAAAu9opvQ
	(envelope-from <stable+bounces-210752-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 14:45:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FACB57BC3
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 14:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A14DA687D81
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 13:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FFD48A2BA;
	Wed, 21 Jan 2026 13:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="geHUA2+m"
X-Original-To: stable@vger.kernel.org
Received: from mail-4398.protonmail.ch (mail-4398.protonmail.ch [185.70.43.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25F6481FD6
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 13:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769001656; cv=none; b=gM0G3e8rCKoWBLzeYnsk1pjy1/yREfSaB9K0NYQy2Z+piX/yEPnptwmXxmdkdF+6Nz1YF+vibmh1JVvWY/USTFhYKT19vNPYA5/OjEa7e/wxS6ZlUGczIs+7GV/EQV/M/7RcBUxtX7JAqItsYbMBcO6+cB9FRzglMV+m4Ptc/bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769001656; c=relaxed/simple;
	bh=EDqnzZEN7orb7ZGQ+93aCuksK9MrkNnuG8+bzoNPJ5o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kDZekroNnZ6HWWdfjMEoG+lymHVArLgDjA4S6GaRWgCn7x/HsN/WPOs1OT65NR2Bei4Qi9l2qgUCsYisdzsKGqaUhA/4Y9qEFzYHAbPQ8SjBJ10N6scOUPg0Vqb/zp4ev0EtR6eyfTlmNWrrLNephJ1NEH0pQpgYpupGiD3zVpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=geHUA2+m; arc=none smtp.client-ip=185.70.43.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1769001652; x=1769260852;
	bh=VQqC9st29svSgAOcWUIUXHbbKJPCeUzGVN5vug9MHKc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=geHUA2+mJ7+w2S9X2AljL2vbIdOsi103NQ3lUAu3CazCR1vnOh1IAuzaThHzK0Ayz
	 pUh+QSYbcWUxEthLL7pjmCgOSf4uCiQX95bWU2m25k5EOIp4GIdMQY4Be7GZW9tFUj
	 E/Id206d+iqm7wySHK1PyxmeMkDS76F9zXCwg2CH+vOMM9uekda4u8QFT+FBxeY7hY
	 GDcOst/SPMEuKUO/OwOZsssTXGIS3byntLhV05c88IDLMPISxR8DJFtCmy8Ix5R07O
	 uDeQmgp5pTaZE8uImP4RJIIx2LxN3XZ+lOS1OmHAiyLWDotGgijsKH39MiKTyT0sxe
	 hEb5uo7fH5sgA==
Date: Wed, 21 Jan 2026 13:20:50 +0000
To: netdev@vger.kernel.org
From: Paul Moses <p@1g4.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, Paul Moses <p@1g4.org>, stable@vger.kernel.org
Subject: [PATCH net v3 4/7] net/sched: act_gate: read schedule via RCU
Message-ID: <20260121131954.2710459-5-p@1g4.org>
In-Reply-To: <20260121131954.2710459-1-p@1g4.org>
References: <20260121131954.2710459-1-p@1g4.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 35e9f1a5787104e5795d193ad305baffc241ac0c
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
	TAGGED_FROM(0.00)[bounces-210752-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 2FACB57BC3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Switch dump/accessor reads to RCU read-side sections. This matches other
actions that read params under rcu_read_lock(), e.g. act_tunnel_key dump
(commit e97ae742972f6c), act_ctinfo dump (commit 799c94178cf9c9), and
act_skbedit dump (commit 1f376373bd225c).

Dump reads tcf_action via READ_ONCE, following the lockless action reads us=
ed
in act_sample (commit 5c5670fae43027) and act_gact.

Timer logic stays under tcf_lock and uses rcu_dereference_protected(), keep=
ing
RCU readers cheap while preserving lock-serialized timer updates.

Fixes: a51c328df310 ("net: qos: introduce a gate control flow action")
Signed-off-by: Paul Moses <p@1g4.org>
Cc: stable@vger.kernel.org
---
 include/net/tc_act/tc_gate.h | 38 +++++++++++++++++++++++-------------
 net/sched/act_gate.c         | 32 +++++++++++++++---------------
 2 files changed, 40 insertions(+), 30 deletions(-)

diff --git a/include/net/tc_act/tc_gate.h b/include/net/tc_act/tc_gate.h
index 05968b3822392..9587d9e9fa38f 100644
--- a/include/net/tc_act/tc_gate.h
+++ b/include/net/tc_act/tc_gate.h
@@ -57,9 +57,10 @@ static inline s32 tcf_gate_prio(const struct tc_action *=
a)
 =09s32 tcfg_prio;
 =09struct tcf_gate_params *p;
=20
-=09p =3D rcu_dereference_protected(to_gate(a)->param,
-=09=09=09=09      lockdep_rtnl_is_held());
+=09rcu_read_lock();
+=09p =3D rcu_dereference(to_gate(a)->param);
 =09tcfg_prio =3D p->tcfg_priority;
+=09rcu_read_unlock();
=20
 =09return tcfg_prio;
 }
@@ -69,9 +70,10 @@ static inline u64 tcf_gate_basetime(const struct tc_acti=
on *a)
 =09u64 tcfg_basetime;
 =09struct tcf_gate_params *p;
=20
-=09p =3D rcu_dereference_protected(to_gate(a)->param,
-=09=09=09=09      lockdep_rtnl_is_held());
+=09rcu_read_lock();
+=09p =3D rcu_dereference(to_gate(a)->param);
 =09tcfg_basetime =3D p->tcfg_basetime;
+=09rcu_read_unlock();
=20
 =09return tcfg_basetime;
 }
@@ -81,9 +83,10 @@ static inline u64 tcf_gate_cycletime(const struct tc_act=
ion *a)
 =09u64 tcfg_cycletime;
 =09struct tcf_gate_params *p;
=20
-=09p =3D rcu_dereference_protected(to_gate(a)->param,
-=09=09=09=09      lockdep_rtnl_is_held());
+=09rcu_read_lock();
+=09p =3D rcu_dereference(to_gate(a)->param);
 =09tcfg_cycletime =3D p->tcfg_cycletime;
+=09rcu_read_unlock();
=20
 =09return tcfg_cycletime;
 }
@@ -93,9 +96,10 @@ static inline u64 tcf_gate_cycletimeext(const struct tc_=
action *a)
 =09u64 tcfg_cycletimeext;
 =09struct tcf_gate_params *p;
=20
-=09p =3D rcu_dereference_protected(to_gate(a)->param,
-=09=09=09=09      lockdep_rtnl_is_held());
+=09rcu_read_lock();
+=09p =3D rcu_dereference(to_gate(a)->param);
 =09tcfg_cycletimeext =3D p->tcfg_cycletime_ext;
+=09rcu_read_unlock();
=20
 =09return tcfg_cycletimeext;
 }
@@ -105,9 +109,10 @@ static inline u32 tcf_gate_num_entries(const struct tc=
_action *a)
 =09u32 num_entries;
 =09struct tcf_gate_params *p;
=20
-=09p =3D rcu_dereference_protected(to_gate(a)->param,
-=09=09=09=09      lockdep_rtnl_is_held());
+=09rcu_read_lock();
+=09p =3D rcu_dereference(to_gate(a)->param);
 =09num_entries =3D p->num_entries;
+=09rcu_read_unlock();
=20
 =09return num_entries;
 }
@@ -121,19 +126,23 @@ static inline struct action_gate_entry
 =09u32 num_entries;
 =09int i =3D 0;
=20
-=09p =3D rcu_dereference_protected(to_gate(a)->param,
-=09=09=09=09      lockdep_rtnl_is_held());
+=09rcu_read_lock();
+=09p =3D rcu_dereference(to_gate(a)->param);
 =09num_entries =3D p->num_entries;
=20
 =09list_for_each_entry(entry, &p->entries, list)
 =09=09i++;
=20
-=09if (i !=3D num_entries)
+=09if (i !=3D num_entries) {
+=09=09rcu_read_unlock();
 =09=09return NULL;
+=09}
=20
 =09oe =3D kcalloc(num_entries, sizeof(*oe), GFP_ATOMIC);
-=09if (!oe)
+=09if (!oe) {
+=09=09rcu_read_unlock();
 =09=09return NULL;
+=09}
=20
 =09i =3D 0;
 =09list_for_each_entry(entry, &p->entries, list) {
@@ -143,6 +152,7 @@ static inline struct action_gate_entry
 =09=09oe[i].maxoctets =3D entry->maxoctets;
 =09=09i++;
 =09}
+=09rcu_read_unlock();
=20
 =09return oe;
 }
diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
index 016708c10a8e0..da4802bbaf4ca 100644
--- a/net/sched/act_gate.c
+++ b/net/sched/act_gate.c
@@ -624,66 +624,66 @@ static int tcf_gate_dump(struct sk_buff *skb, struct =
tc_action *a,
 {
 =09unsigned char *b =3D skb_tail_pointer(skb);
 =09struct tcf_gate *gact =3D to_gate(a);
-=09struct tc_gate opt =3D { };
 =09struct tcfg_gate_entry *entry;
 =09struct tcf_gate_params *p;
 =09struct nlattr *entry_list;
+=09struct tc_gate opt =3D { };
 =09struct tcf_t t;
=20
 =09opt.index =3D gact->tcf_index;
 =09opt.refcnt =3D refcount_read(&gact->tcf_refcnt) - ref;
 =09opt.bindcnt =3D atomic_read(&gact->tcf_bindcnt) - bind;
=20
-=09spin_lock_bh(&gact->tcf_lock);
-=09opt.action =3D gact->tcf_action;
-
-=09p =3D rcu_dereference_protected(gact->param,
-=09=09=09=09      lockdep_is_held(&gact->tcf_lock));
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



