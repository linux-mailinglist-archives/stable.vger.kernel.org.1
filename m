Return-Path: <stable+bounces-216283-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIbqGGphj2nNQgEAu9opvQ
	(envelope-from <stable+bounces-216283-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 18:37:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5D7138B29
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 18:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64F34303AB4F
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 17:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE32286409;
	Fri, 13 Feb 2026 17:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="w1UWyG5H"
X-Original-To: stable@vger.kernel.org
Received: from mail-4397.protonmail.ch (mail-4397.protonmail.ch [185.70.43.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663FA26FDBF;
	Fri, 13 Feb 2026 17:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771004259; cv=none; b=byZtGnq6rANikAEXHcxOISkgQIZ/+N9qNH6LapPBPXzj37NC4LoxbCxHH0UWd0ezbiGW4gJt0V4z+bz9t0E/ZT5rvF3r1yAZyel584e08hUC0B21+Bcw9V6ZBm7hiG3p5OvKCjGt4GPcckWnRamisWBCLfTSEhml7SPQCEkieJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771004259; c=relaxed/simple;
	bh=YoKGDML6ZhHAYimZ1SdNKI2gYZwZbzC8OKLBpvtL5vs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q7dpIOy3MXhYmRiHEPJB3UwzUiQ1ZjSWOZw8C9QggTr1/OvYL0JOYmGJ5kqZMAe7c6eDYRRTIBUB3ZzyQHVLCzwE9yiiKuwLtVvvqDuK9M52Tb1GLDrNXmH8C8/YLpN/LMjbH/OXtoXcB4XMHYZOEhizE/lRaIqGpo6jTK3kv24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=w1UWyG5H; arc=none smtp.client-ip=185.70.43.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1771004247; x=1771263447;
	bh=MMwCRDSR1YuIke1zTKxuyT055rx6uuEuLXQFJeWc6eA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=w1UWyG5HdbXoM9L4KDvfI0ZnEDPFYsr5I8m5Ruk9fniX3UiUwdinhSYI7wX+SYkF7
	 lfwf315qzzrgTeoU9MKw84CVwmfTymquualexV035nWevWeGS+rxbqLhN+MMyqjkcm
	 h5yxrmg8zXaz6estIm7aXKmlDwnoSIWyx0lhNUOwPIkGoiJDEYdR9BJi9kiXQKeWdT
	 a1fs8pxrR2CSnDdlGV2VoM3lGNE2yf0xeIGjOu95Fa7rXEPrtfGQWCgza2P/xJ+OMc
	 zBT1jSU/jbBM0fI4lUjL2Ze56Nb6YKzA7XTP5qQtQluogxY3xoLu1NhrpNlCh3ZWtI
	 b9PfxjG7kip8w==
Date: Fri, 13 Feb 2026 17:37:22 +0000
To: Simon Horman <horms@kernel.org>
From: Paul Moses <p@1g4.org>
Cc: jiri@resnulli.us, pabeni@redhat.com, victor@mojatatu.com, jhs@mojatatu.com, davem@davemloft.net, netdev@vger.kernel.org, stable@vger.kernel.org, edumazet@google.com, linux-kernel@vger.kernel.org, kuba@kernel.org, xiyou.wangcong@gmail.com
Subject: Re: [net,v6,1/1] net/sched: act_gate: snapshot parameters with RCU on replace
Message-ID: <BRr95QFZN9_ai_HGUbpS_NTCZ_7nKmODaNT-iE1S9IdeiK8dDJjOCh7C9DDrZE29LUJ3YTRkAav0xpk3azg54ruQSwG74GWNTDB-HpOMasM=@1g4.org>
In-Reply-To: <20260213155528.2515066-1-horms@kernel.org>
References: <20260213113849.136695-2-p@1g4.org> <20260213155528.2515066-1-horms@kernel.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 01095dc8dbdb30e16a022ef4661587a806228001
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[1g4.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[1g4.org:s=protonmail2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216283-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[resnulli.us,redhat.com,mojatatu.com,davemloft.net,vger.kernel.org,google.com,kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[p@1g4.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[1g4.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0A5D7138B29
X-Rspamd-Action: no action

1. I don=E2=80=99t think this is reachable, during create, the IDR slot is =
populated=20
   with ERR_PTR(-EBUSY) by tcf_idr_check_alloc(). The real action pointer i=
s=20
   only published later by tcf_idr_insert_many(), which runs after init()=
=20
   returns and after tcf_gate_init() has already done:

     rcu_replace_pointer(gact->param, p, ...)

   Both the normal lookup path and the dump walker treat ERR_PTR entries as
   =E2=80=9Cnot ready=E2=80=9D: tcf_idr_search() rejects them and the dump =
walker skips.

2. offload_act_setup() is currently called with act->tcfa_lock held in both=
=20
   call chains (net/sched/act_api.c and net/sched/cls_api.c). Since=20
   gact->tcf_lock aliases common.tcfa_lock, the=20
   lockdep_is_held(&gact->tcf_lock) condition in tcf_gate_params_locked()=
=20
   is satisfied.

Thanks,
Paul




On Friday, February 13th, 2026 at 9:55 AM, Simon Horman <horms@kernel.org> =
wrote:

> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>=20
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-loca=
l.html
> ---
> net/sched: act_gate: snapshot parameters with RCU on replace
>=20
> The gate action can be replaced while the hrtimer callback or dump path i=
s
> walking the schedule list.
>=20
> Convert the parameters to an RCU-protected snapshot and swap updates unde=
r
> tcf_lock, freeing the previous snapshot via call_rcu(). When REPLACE omit=
s
> the entry list, preserve the existing schedule so the effective state is
> unchanged.
>=20
> > diff --git a/include/net/tc_act/tc_gate.h b/include/net/tc_act/tc_gate.=
h
> > index c1a67149c6b6..5223c00279d5 100644
> > --- a/include/net/tc_act/tc_gate.h
> > +++ b/include/net/tc_act/tc_gate.h
> > @@ -32,6 +32,7 @@ struct tcf_gate_params {
> >  =09s32=09=09=09tcfg_clockid;
> >  =09size_t=09=09=09num_entries;
> >  =09struct list_head=09entries;
> > +=09struct rcu_head=09=09rcu;
> >  };
> >
> >  #define GATE_ACT_GATE_OPEN=09BIT(0)
> > @@ -39,7 +40,7 @@ struct tcf_gate_params {
> >
> >  struct tcf_gate {
> >  =09struct tc_action=09common;
> > -=09struct tcf_gate_params=09param;
> > +=09struct tcf_gate_params __rcu *param;
> >  =09u8=09=09=09current_gate_status;
> >  =09ktime_t=09=09=09current_close_time;
> >  =09u32=09=09=09current_entry_octets;
> > @@ -51,47 +52,65 @@ struct tcf_gate {
> >
> >  #define to_gate(a) ((struct tcf_gate *)a)
> >
> > +static inline struct tcf_gate_params *tcf_gate_params_locked(const str=
uct tc_action *a)
> > +{
> > +=09struct tcf_gate *gact =3D to_gate(a);
> > +
> > +=09return rcu_dereference_protected(gact->param,
> > +=09=09=09=09=09 lockdep_is_held(&gact->tcf_lock));
> > +}
> > +
> >  static inline s32 tcf_gate_prio(const struct tc_action *a)
> >  {
> > +=09struct tcf_gate_params *p;
> >  =09s32 tcfg_prio;
> >
> > -=09tcfg_prio =3D to_gate(a)->param.tcfg_priority;
> > +=09p =3D tcf_gate_params_locked(a);
> > +=09tcfg_prio =3D p->tcfg_priority;
> >
> >  =09return tcfg_prio;
> >  }
>=20
> [ ... ]
>=20
> > diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
> > index c1f75f272757..60c80e609ec3 100644
> > --- a/net/sched/act_gate.c
> > +++ b/net/sched/act_gate.c
>=20
> [ ... ]
>=20
> > @@ -509,10 +621,9 @@ static int tcf_gate_dump(struct sk_buff *skb, stru=
ct tc_action *a,
> >  =09struct nlattr *entry_list;
> >  =09struct tcf_t t;
> >
> > -=09spin_lock_bh(&gact->tcf_lock);
> > -=09opt.action =3D gact->tcf_action;
> > -
> > -=09p =3D &gact->param;
> > +=09rcu_read_lock();
> > +=09opt.action =3D READ_ONCE(gact->tcf_action);
> > +=09p =3D rcu_dereference(gact->param);
> >
> >  =09if (nla_put(skb, TCA_GATE_PARMS, sizeof(opt), &opt))
> >  =09=09goto nla_put_failure;
> >
> > @@ -552,12 +663,12 @@ static int tcf_gate_dump(struct sk_buff *skb, str=
uct tc_action *a,
> >  =09tcf_tm_dump(&t, &gact->tcf_tm);
> >  =09if (nla_put_64bit(skb, TCA_GATE_TM, sizeof(t), &t, TCA_GATE_PAD))
> >  =09=09goto nla_put_failure;
> > -=09spin_unlock_bh(&gact->tcf_lock);
> > +=09rcu_read_unlock();
> >
> >  =09return skb->len;
> >
> >  nla_put_failure:
> > -=09spin_unlock_bh(&gact->tcf_lock);
> > +=09rcu_read_unlock();
> >  =09nlmsg_trim(skb, b);
> >  =09return -1;
> >  }
>=20
> Can tcf_gate_dump be called before gact->param is initialized?
>=20
> After the conversion to RCU pointers, if tcf_gate_dump is called during
> action initialization (between tcf_idr_create_from_flags and
> rcu_replace_pointer in tcf_gate_init), p will be NULL:
>=20
> net/sched/act_gate.c:tcf_gate_init() {
>     tcf_idr_create_from_flags(...);
>     ...
>     // gact->param still NULL here
>     ...
>     rcu_replace_pointer(gact->param, p, ...);  // line 517
> }
>=20
> net/sched/act_gate.c:tcf_gate_dump() {
>     rcu_read_lock();
>     p =3D rcu_dereference(gact->param);  // can be NULL
>=20
>     if (nla_put_u64_64bit(skb, TCA_GATE_BASE_TIME,
>                           p->tcfg_basetime, TCA_GATE_PAD))  // NULL deref
> }
>=20
> Before the patch, param was an embedded struct that was zero-initialized,
> so dump would return valid (if meaningless) data. After the patch, this
> becomes a NULL pointer dereference.
>=20
> While the tc action framework may prevent dumping partially initialized
> actions through external synchronization, should this code include a NULL
> check to make the initialization window safer?
>=20
> The second issue is in the hardware offload path. Looking at
> net/sched/act_gate.c:tcf_gate_offload_act_setup(), the function calls the
> accessor helpers without holding tcf_lock:
>=20
> net/sched/act_gate.c:tcf_gate_offload_act_setup() {
>     // no lock held here
>     entry->gate.prio =3D tcf_gate_prio(act);           // line 723
>     entry->gate.basetime =3D tcf_gate_basetime(act);
>     entry->gate.cycletime =3D tcf_gate_cycletime(act);
>     ...
> }
>=20
> include/net/tc_act/tc_gate.h:tcf_gate_prio() {
>     p =3D tcf_gate_params_locked(a);  // uses rcu_dereference_protected
>     ...
> }
>=20
> include/net/tc_act/tc_gate.h:tcf_gate_params_locked() {
>     return rcu_dereference_protected(gact->param,
>                                      lockdep_is_held(&gact->tcf_lock));
> }
>=20
> Does tcf_gate_offload_act_setup violate the locking requirements?
>=20
> The accessor functions all use tcf_gate_params_locked(), which requires
> tcf_lock to be held (verified via lockdep_is_held). The offload setup
> function doesn't acquire this lock before calling the accessors.
>=20
> With lockdep enabled, this will trigger warnings. Without lockdep, there'=
s
> a race where param can be replaced via rcu_replace_pointer while the
> offload function is reading it, potentially causing reads of inconsistent
> state.
>=20
> The dump path uses the correct pattern with rcu_read_lock() and
> rcu_dereference(). Should the offload path either acquire tcf_lock or use
> a similar RCU-only approach?
> 

