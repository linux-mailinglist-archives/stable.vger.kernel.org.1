Return-Path: <stable+bounces-217295-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YB/zLTHAlWkfUgIAu9opvQ
	(envelope-from <stable+bounces-217295-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 14:35:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB4B156C11
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 14:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D3A7305BA8C
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 13:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C5B32720C;
	Wed, 18 Feb 2026 13:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="m9csE+N7"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4D931A7F8
	for <stable@vger.kernel.org>; Wed, 18 Feb 2026 13:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771421583; cv=pass; b=WD7HZH73PbMOi7xPMJFuBaDCePjy1zyfOrRkmKtI7jqxcKh6f+OsjR9ljQHWk6PFeH1IEhIsLYXjECtEx57FTfHkGg483jcR/62VBgF4wSOm9DmuyQWiaaZdqUCcboxWMY4jxK+JlhTDQ9+LTMqQyKKcTeP3LjfWrdEbcqbuphg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771421583; c=relaxed/simple;
	bh=Xh5p01gjlblJPCd5win9BhFW7XTWUDyKbz8czLev6Kw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ktn6GQO99LXXVATYicUx7sgP18BtCKa/P4U8FCil3ASNUubqWmrTf7X4w62GekxIH14MREHA8H3Nq05WhbF3CsaYgqi3PMY6x0LaApMQPSSayxzC7Wf/ehJ7T7f+IbVSxbRpKp6/6eQ/bWjTcfkAmcPXENpiL8HG18S/hL8kno8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=m9csE+N7; arc=pass smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c70378ddaafso43935a12.3
        for <stable@vger.kernel.org>; Wed, 18 Feb 2026 05:33:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771421581; cv=none;
        d=google.com; s=arc-20240605;
        b=YptFH7bLQWjZXBNtRgBC/OXGVc9gsTgCKDJHm7UASzTLi4dImpeMM01Rf7BhyeYOHc
         PmeGEIWw6zYQdsfmUJME/6jiyk43fsSqkHedqCp6uGGqJRahPRwAll1wvYChA5TJ9X4v
         Vgq2e8ymgi/P/O4HgxEr4+P68jiZwF0hUIW8+DP4whmA033TIRKaI61F+kJpLJmRQImg
         fmlKQdk96zAFPTGj3s+LAMCP3wIff4q1LrFqRD0wV0Bu6Kx4MPx+W7iJmi3IDTs/PjsM
         jZdF8FKr60JDrp1XiI4fVUrtCc7hoRFfDpWna3dEVecudZw3/hfASljrPeyZWuHNtgAG
         BRuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fvMSMw23moFVAI527p/9o996bSUPA/Lihxmu9SRpTuA=;
        fh=2JB3WuKbnJD74g1NjxpVlYQHfr1u8FgLJ0yiI4KXIKk=;
        b=HQSCff0LYV3UFSNZffHa1rMwB5rYIUPhOY0WvmaqB9r8M0M3AumdGl1r8B9JuJJjtB
         KQ8SQddx919H2gn6/uyllUvZAPtsMDi06dbxJXS1dPEz2qoTi692sgs3HmI9wNE7OP9f
         AnXbxHT5UczE2VZ+guNRz/sUg8YLm4W2EzXvMBYXmZCOZGgrHjtvBJKGgj7qBn8gxUvZ
         oGbv9+QvpHSmufDW56Z9zKjPENVCCP6gXi3+6Twe30O1vLiEFgOPLPHVQBAl1nx1CGxu
         2OmcK9oIk4vM38D0tz0KXk9LioNypW/coS8Bfx5CZGLoKo49lma5WMrpuJhfQG2gR1OL
         yInQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1771421581; x=1772026381; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fvMSMw23moFVAI527p/9o996bSUPA/Lihxmu9SRpTuA=;
        b=m9csE+N7Cuxo7fgBnB4vTog5kfJQDEkDKnOmLKPOkSHb2SFg8ANXl7W46PNCJfxpNL
         gnC9MS4U0UOPgY6Lwj+46n+aJukjJ3ZZEMWphGMOeVB4QXUbQpiOgrQ5LmuF66sLRFI/
         MkOX6gGXsup2Bn9NgAOgkYrex8ywopZi8JrcQQ2rRI91g/tlde8VVdoRalvzNtroQ8rz
         zch3PF6xZtNIOhfwlRHfUTfgBJJssrjDN1toh7WSj0O34biViWDmQjSy7OLOBtFvDuGP
         G5wsvpe+mljBefbZMv6cZycDmLqR5JEVWE2ZoqwUmy43JRZtJitHFZfY2+8Qlr0hSfgC
         Txgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771421581; x=1772026381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fvMSMw23moFVAI527p/9o996bSUPA/Lihxmu9SRpTuA=;
        b=Dn9Ilrp9SU8AjqtMXJKJmQm4wdVf4BwjhDWr8TqGauiov7eZmscnjW317yYf30dMRg
         16UhWdMyTscTaUQQzGTlLtMfMboogFSgPNFwQClA68rL2aoyo5mKgQ/us1FtwNA59dB0
         FpqKwgfbDcRZypkmgM7FiigvH310xxp6kIXmS7LPglVGxVNZK2ZgKuMg1C7LPG8XDQt8
         wNMPp+4oyfmdt1Rcskc3BfZ0odRk8Tvw2TssC9VxeoX5JmuKCOsUThlPh1XkJlP0PTUY
         DqkcRAqhm7LCy+vkSuXKnQYhbzjsbd1sYbR1GPckimTEk2F+SgBkwSNDSv2WTpR7m6cU
         gv/w==
X-Forwarded-Encrypted: i=1; AJvYcCXJD3XfI/6DBqSxqN0eahR5I89/AG3NCZuldZ5Zso/aS9N+tcmaEzMcWZg6B0Oi3tl3gnqg8ro=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCTX47ghEcZCtkn8pO1hePDrbNIpRHxLVmB+s6hZDGp/zU3T72
	5ADYwkQZ8WzWEgXahHKWF2vOjEsucdgXGJHNQD/GoHCrTHmFFQIEmN1rNAPbBb8txyI3zxMCe6S
	bqTkFVcRkitoOJf1hoq5XPgUCli20qC6h/dCf/E4k
X-Gm-Gg: AZuq6aLJwFrvnDK2fsTJfZxVb9Yx4kvF1k3Cd6L7YbPdMNfStY+UYYE14iX2xLsYiOa
	ekELuQ+1iD1BXevHqllXIy0T6nH4VL77H+Lf8LKyM9JmSG5JiENu+TeTg6R/RSXSwf9KO+BifnV
	S65Foal80oq88Zk8QwaOPRO8cFQI5A0yVpnoaHcsxjdeav/2OYQrJXp3Sv/LLKPIsNvYnfVFNF2
	9xdJNXyzGHy1H2Zk2IwNuVttbKMPZ/qFaqyJijgfNZFS2mgzk2f3U8su0jhA5KlZUqU5/mUkn82
	7YVSUWoNr09Qtjs=
X-Received: by 2002:a17:902:cf10:b0:2a7:b447:3389 with SMTP id
 d9443c01a7336-2ad17433847mr149623225ad.2.1771421581129; Wed, 18 Feb 2026
 05:33:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260213113849.136695-2-p@1g4.org> <20260213155528.2515066-1-horms@kernel.org>
 <BRr95QFZN9_ai_HGUbpS_NTCZ_7nKmODaNT-iE1S9IdeiK8dDJjOCh7C9DDrZE29LUJ3YTRkAav0xpk3azg54ruQSwG74GWNTDB-HpOMasM=@1g4.org>
In-Reply-To: <BRr95QFZN9_ai_HGUbpS_NTCZ_7nKmODaNT-iE1S9IdeiK8dDJjOCh7C9DDrZE29LUJ3YTRkAav0xpk3azg54ruQSwG74GWNTDB-HpOMasM=@1g4.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 18 Feb 2026 08:32:50 -0500
X-Gm-Features: AaiRm504lTrqeXPJ6sffoXwIj4sofBkq_7-PtyPUoLbU4w_Lr7rV2qmv46TvQuY
Message-ID: <CAM0EoMnZNG5k8_XDYS190HdGn-_7wdo3mqBQ-8KE-CrVDGJUhw@mail.gmail.com>
Subject: Re: [net,v6,1/1] net/sched: act_gate: snapshot parameters with RCU on replace
To: Paul Moses <p@1g4.org>
Cc: Simon Horman <horms@kernel.org>, jiri@resnulli.us, pabeni@redhat.com, 
	victor@mojatatu.com, davem@davemloft.net, netdev@vger.kernel.org, 
	stable@vger.kernel.org, edumazet@google.com, linux-kernel@vger.kernel.org, 
	kuba@kernel.org, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	TAGGED_FROM(0.00)[bounces-217295-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,resnulli.us,redhat.com,mojatatu.com,davemloft.net,vger.kernel.org,google.com,gmail.com];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,1g4.org:email,linux.dev:url]
X-Rspamd-Queue-Id: 1CB4B156C11
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 12:37=E2=80=AFPM Paul Moses <p@1g4.org> wrote:
>
> 1. I don=E2=80=99t think this is reachable, during create, the IDR slot i=
s populated
>    with ERR_PTR(-EBUSY) by tcf_idr_check_alloc(). The real action pointer=
 is
>    only published later by tcf_idr_insert_many(), which runs after init()
>    returns and after tcf_gate_init() has already done:
>
>      rcu_replace_pointer(gact->param, p, ...)
>
>    Both the normal lookup path and the dump walker treat ERR_PTR entries =
as
>    =E2=80=9Cnot ready=E2=80=9D: tcf_idr_search() rejects them and the dum=
p walker skips.
>

Correct.


> 2. offload_act_setup() is currently called with act->tcfa_lock held in bo=
th
>    call chains (net/sched/act_api.c and net/sched/cls_api.c). Since
>    gact->tcf_lock aliases common.tcfa_lock, the
>    lockdep_is_held(&gact->tcf_lock) condition in tcf_gate_params_locked()
>    is satisfied.
>

The spinlock will catch it as stated.

The AI is clearly hallucinating..

cheers,
jamal

> Thanks,
> Paul
>
>
>
>
> On Friday, February 13th, 2026 at 9:55 AM, Simon Horman <horms@kernel.org=
> wrote:
>
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> >
> > For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-lo=
cal.html
> > ---
> > net/sched: act_gate: snapshot parameters with RCU on replace
> >
> > The gate action can be replaced while the hrtimer callback or dump path=
 is
> > walking the schedule list.
> >
> > Convert the parameters to an RCU-protected snapshot and swap updates un=
der
> > tcf_lock, freeing the previous snapshot via call_rcu(). When REPLACE om=
its
> > the entry list, preserve the existing schedule so the effective state i=
s
> > unchanged.
> >
> > > diff --git a/include/net/tc_act/tc_gate.h b/include/net/tc_act/tc_gat=
e.h
> > > index c1a67149c6b6..5223c00279d5 100644
> > > --- a/include/net/tc_act/tc_gate.h
> > > +++ b/include/net/tc_act/tc_gate.h
> > > @@ -32,6 +32,7 @@ struct tcf_gate_params {
> > >     s32                     tcfg_clockid;
> > >     size_t                  num_entries;
> > >     struct list_head        entries;
> > > +   struct rcu_head         rcu;
> > >  };
> > >
> > >  #define GATE_ACT_GATE_OPEN BIT(0)
> > > @@ -39,7 +40,7 @@ struct tcf_gate_params {
> > >
> > >  struct tcf_gate {
> > >     struct tc_action        common;
> > > -   struct tcf_gate_params  param;
> > > +   struct tcf_gate_params __rcu *param;
> > >     u8                      current_gate_status;
> > >     ktime_t                 current_close_time;
> > >     u32                     current_entry_octets;
> > > @@ -51,47 +52,65 @@ struct tcf_gate {
> > >
> > >  #define to_gate(a) ((struct tcf_gate *)a)
> > >
> > > +static inline struct tcf_gate_params *tcf_gate_params_locked(const s=
truct tc_action *a)
> > > +{
> > > +   struct tcf_gate *gact =3D to_gate(a);
> > > +
> > > +   return rcu_dereference_protected(gact->param,
> > > +                                    lockdep_is_held(&gact->tcf_lock)=
);
> > > +}
> > > +
> > >  static inline s32 tcf_gate_prio(const struct tc_action *a)
> > >  {
> > > +   struct tcf_gate_params *p;
> > >     s32 tcfg_prio;
> > >
> > > -   tcfg_prio =3D to_gate(a)->param.tcfg_priority;
> > > +   p =3D tcf_gate_params_locked(a);
> > > +   tcfg_prio =3D p->tcfg_priority;
> > >
> > >     return tcfg_prio;
> > >  }
> >
> > [ ... ]
> >
> > > diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
> > > index c1f75f272757..60c80e609ec3 100644
> > > --- a/net/sched/act_gate.c
> > > +++ b/net/sched/act_gate.c
> >
> > [ ... ]
> >
> > > @@ -509,10 +621,9 @@ static int tcf_gate_dump(struct sk_buff *skb, st=
ruct tc_action *a,
> > >     struct nlattr *entry_list;
> > >     struct tcf_t t;
> > >
> > > -   spin_lock_bh(&gact->tcf_lock);
> > > -   opt.action =3D gact->tcf_action;
> > > -
> > > -   p =3D &gact->param;
> > > +   rcu_read_lock();
> > > +   opt.action =3D READ_ONCE(gact->tcf_action);
> > > +   p =3D rcu_dereference(gact->param);
> > >
> > >     if (nla_put(skb, TCA_GATE_PARMS, sizeof(opt), &opt))
> > >             goto nla_put_failure;
> > >
> > > @@ -552,12 +663,12 @@ static int tcf_gate_dump(struct sk_buff *skb, s=
truct tc_action *a,
> > >     tcf_tm_dump(&t, &gact->tcf_tm);
> > >     if (nla_put_64bit(skb, TCA_GATE_TM, sizeof(t), &t, TCA_GATE_PAD))
> > >             goto nla_put_failure;
> > > -   spin_unlock_bh(&gact->tcf_lock);
> > > +   rcu_read_unlock();
> > >
> > >     return skb->len;
> > >
> > >  nla_put_failure:
> > > -   spin_unlock_bh(&gact->tcf_lock);
> > > +   rcu_read_unlock();
> > >     nlmsg_trim(skb, b);
> > >     return -1;
> > >  }
> >
> > Can tcf_gate_dump be called before gact->param is initialized?
> >
> > After the conversion to RCU pointers, if tcf_gate_dump is called during
> > action initialization (between tcf_idr_create_from_flags and
> > rcu_replace_pointer in tcf_gate_init), p will be NULL:
> >
> > net/sched/act_gate.c:tcf_gate_init() {
> >     tcf_idr_create_from_flags(...);
> >     ...
> >     // gact->param still NULL here
> >     ...
> >     rcu_replace_pointer(gact->param, p, ...);  // line 517
> > }
> >
> > net/sched/act_gate.c:tcf_gate_dump() {
> >     rcu_read_lock();
> >     p =3D rcu_dereference(gact->param);  // can be NULL
> >
> >     if (nla_put_u64_64bit(skb, TCA_GATE_BASE_TIME,
> >                           p->tcfg_basetime, TCA_GATE_PAD))  // NULL der=
ef
> > }
> >
> > Before the patch, param was an embedded struct that was zero-initialize=
d,
> > so dump would return valid (if meaningless) data. After the patch, this
> > becomes a NULL pointer dereference.
> >
> > While the tc action framework may prevent dumping partially initialized
> > actions through external synchronization, should this code include a NU=
LL
> > check to make the initialization window safer?
> >
> > The second issue is in the hardware offload path. Looking at
> > net/sched/act_gate.c:tcf_gate_offload_act_setup(), the function calls t=
he
> > accessor helpers without holding tcf_lock:
> >
> > net/sched/act_gate.c:tcf_gate_offload_act_setup() {
> >     // no lock held here
> >     entry->gate.prio =3D tcf_gate_prio(act);           // line 723
> >     entry->gate.basetime =3D tcf_gate_basetime(act);
> >     entry->gate.cycletime =3D tcf_gate_cycletime(act);
> >     ...
> > }
> >
> > include/net/tc_act/tc_gate.h:tcf_gate_prio() {
> >     p =3D tcf_gate_params_locked(a);  // uses rcu_dereference_protected
> >     ...
> > }
> >
> > include/net/tc_act/tc_gate.h:tcf_gate_params_locked() {
> >     return rcu_dereference_protected(gact->param,
> >                                      lockdep_is_held(&gact->tcf_lock));
> > }
> >
> > Does tcf_gate_offload_act_setup violate the locking requirements?
> >
> > The accessor functions all use tcf_gate_params_locked(), which requires
> > tcf_lock to be held (verified via lockdep_is_held). The offload setup
> > function doesn't acquire this lock before calling the accessors.
> >
> > With lockdep enabled, this will trigger warnings. Without lockdep, ther=
e's
> > a race where param can be replaced via rcu_replace_pointer while the
> > offload function is reading it, potentially causing reads of inconsiste=
nt
> > state.
> >
> > The dump path uses the correct pattern with rcu_read_lock() and
> > rcu_dereference(). Should the offload path either acquire tcf_lock or u=
se
> > a similar RCU-only approach?
> >

