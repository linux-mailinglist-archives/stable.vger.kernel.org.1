Return-Path: <stable+bounces-216647-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNKLA0JekmmUtQEAu9opvQ
	(envelope-from <stable+bounces-216647-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 01:01:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B619314063A
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 01:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DAC4B301F16E
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 00:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F082D77F5;
	Mon, 16 Feb 2026 00:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="eLVOZcBg"
X-Original-To: stable@vger.kernel.org
Received: from mail-10626.protonmail.ch (mail-10626.protonmail.ch [79.135.106.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAA22BEC34;
	Mon, 16 Feb 2026 00:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771200006; cv=none; b=lM1uBqL/6UR1xpqwlwzMuWx90WLd7wa2MsotmGkcOOC3metPC5ARsk80rNEse6FPlB5VRSuws5o0hH75es7j1Dbb9kT5GnZ66A8FR8/H4/sMpgcUSnY1TJ7ENQ5sq20tCOZg+x4NWbyVj8cUeokS/guaGqa0t+d6TLsvj+L0X1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771200006; c=relaxed/simple;
	bh=pIyTiYlPCmwG5BM06DH+2PcY/nU0p1oiKIsZc+1Vfo4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PW+x6xBD/nA3B2mNBf3LKqEaKngnj4HVObPYkj84IjgD5DD7rABfKIQR/knxDtSU36aEIUpPcz3HZDbGDEKQV9kZ9Ty/fE74JZpD23F7ggz1Wx+zv72oeaVLcDJGqrUVr9tTGPzGbZHk2RFgSDOCBFO5y/IbsRiPRNJw/gOSaAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=eLVOZcBg; arc=none smtp.client-ip=79.135.106.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1771199992; x=1771459192;
	bh=Vq4MRGQlwbD9/X9K1AE53pSxNPlwQjtekgVqFl2j9LY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=eLVOZcBgD1I/U+beyo0L5LSDmKDjh24nBCbRYEh0awnhyZDM9ylPOGJrov5KlJ7xJ
	 +AGdj4wolbfy1ncxU1qvvfRoK+lRKRXJruvFE+8Y4Hy35rL3HPhnUR9gQmAkgdPeeN
	 tzeV89g0+0LW+4J3VChX0L279QkTddfDlrnbSQ+/4/T7/gfUDfTtpsAo16jfuqD7Sb
	 bxy5PGYSZkcYwLcNYX6sG8WS7X3YIDnN2g8bxEFQSM2r3TPpUpb2YKgs57SXjQ+yUm
	 jMxL67C9qfwUMQAF/3cv7Xszce6R77bCO9OeIrh86z/9xCps7ktevcLVrr2lS2WLo5
	 bQx1hy3oRkFoA==
Date: Sun, 15 Feb 2026 23:59:47 +0000
To: Victor Nogueira <victor@mojatatu.com>
From: Paul Moses <p@1g4.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v6 1/1] net/sched: act_gate: snapshot parameters with RCU on replace
Message-ID: <6KeZDQIaJkCfZ-04S-pj5o5agVs4F_vy9xt4MfPb_6XS7MKcW-iX-9Av0O0bcURgoTn3T5bcHqRdM4FfSt8BWfjgHmbuHIUG80UYa7Ag-s4=@1g4.org>
In-Reply-To: <CA+NMeC805yf4CECdjJh4EmP0RK1AgxAN25V7n+qvOqNMrhVyNA@mail.gmail.com>
References: <20260213113849.136695-1-p@1g4.org> <20260213113849.136695-2-p@1g4.org> <CA+NMeC805yf4CECdjJh4EmP0RK1AgxAN25V7n+qvOqNMrhVyNA@mail.gmail.com>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 78b7175c3d8ae967ba87ded08884dfae37e7db62
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[1g4.org:s=protonmail2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216647-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[mojatatu.com,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[p@1g4.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[1g4.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,1g4.org:mid,1g4.org:dkim,1g4.org:email]
X-Rspamd-Queue-Id: B619314063A
X-Rspamd-Action: no action

1. hrtimer_get_expires() just returns the stored node.expires and
   hrtimer_cancel() doesn=E2=80=99t clear it, so expires=3D=3D0 is not a re=
liable
   inactivity test. Logic was that although I detected no observable
   behavior difference, relying on stale expires could theoretically
   cause infrequent subtle intermittent misses of intended behavior.
   It's maybe more appropriate to leave it alone for stable or at
   least not in this patch/series?

2. Agreed. This was a mistake.

3. It's the same pattern used in sch_taprio and it's documented in
   Documentation/memory-barriers.txt: the compiler may merge/discard/
   invent/reorder plain accesses and READ_ONCE()/WRITE_ONCE() exist to
   make intentional lockless shared variable accesses well defined.
   Since tk_offset is read with READ_ONCE() outside tcf_lock, the writer
   uses WRITE_ONCE() to pair with that lockless read.

4. Agreed, I=E2=80=99ll remove the redundant guard.

5. goto_ch is initialized to NULL and tcf_action_check_ctrlact() only sets
   it on success, so the current code is safe, but I agree that it's confus=
ing,
   I'll improve.

Thanks
Paul



On Sunday, February 15th, 2026 at 2:45 PM, Victor Nogueira <victor@mojatatu=
.com> wrote:

> On Fri, Feb 13, 2026 at 8:39=E2=80=AFAM Paul Moses <p@1g4.org> wrote:
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
> > [...]
> > diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
> > index c1f75f2727576..60c80e609ec3d 100644
> > --- a/net/sched/act_gate.c
> > +++ b/net/sched/act_gate.c
> > [...]
> > @@ -56,11 +59,10 @@ static void gate_start_timer(struct tcf_gate *gact,=
 ktime_t start)
> >  {
> >         ktime_t expires;
> >
> > -       expires =3D hrtimer_get_expires(&gact->hitimer);
> > -       if (expires =3D=3D 0)
> > -               expires =3D KTIME_MAX;
> > -
> > -       start =3D min_t(ktime_t, start, expires);
> > +       if (hrtimer_active(&gact->hitimer)) {
> > +               expires =3D hrtimer_get_expires(&gact->hitimer);
> > +               start =3D min_t(ktime_t, start, expires);
> > +       }
>=20
> Is this change really necessary?
>=20
> > [...]
> >  static int parse_gate_list(struct nlattr *list_attr,
> >                            struct tcf_gate_params *sched,
> >                            struct netlink_ext_ack *extack)
> > @@ -261,7 +294,6 @@ static int parse_gate_list(struct nlattr *list_attr=
,
> >         }
> >
> >         sched->num_entries =3D i;
> > -
> >         return i;
>=20
> Removing this line also seems unnecessary.
>=20
> > [...]
> > +static void gate_setup_timer(struct tcf_gate *gact, s32 clockid,
> > +                            enum tk_offsets tko)
> > +{
> > +       WRITE_ONCE(gact->tk_offset, tko);
>=20
> Why do you need this WRITE_ONCE?
>=20
> >  static int tcf_gate_init(struct net *net, struct nlattr *nla,
> > [...]
> > @@ -366,6 +407,60 @@ static int tcf_gate_init(struct net *net, struct n=
lattr *nla,
> > [...]
> > +       if (ret !=3D ACT_P_CREATED) {
> > [...]
> > +               if (use_old_entries) {
> > +                       err =3D tcf_gate_copy_entries(p, cur_p, extack)=
;
> > +                       if (!err && !tb[TCA_GATE_CYCLE_TIME])
>=20
> This check for TCA_GATE_CYCLE_TIME seems unnecessary.
> If I understand your code correctly, cycletime will be overwritten
> further down if TCA_GATE_CYCLE_TIME was specified.
>=20
> > +                               cycletime =3D cur_p->tcfg_cycletime;
> > [...]
> > @@ -434,33 +532,47 @@ static int tcf_gate_init(struct net *net, struct =
nlattr *nla,
> > [...]
> > -chain_put:
> > +unlock:
> >         spin_unlock_bh(&gact->tcf_lock);
> >
> > +err_free:
> > +       release_entry_list(&p->entries);
> > +       kfree(p);
> > +release_idr:
> >         if (goto_ch)
> >                 tcf_chain_put_by_act(goto_ch);
> > -release_idr:
> > [...]
>=20
> This looks weird.
> You will go to the release_idr label when tcf_action_check_ctrlact fails,
> so the "if (goto_ch)" part of the code will be reached in that code path.
> I believe it would be better to keep the "chain_put" label and keep
> "release_idr" below it (as it was before your change).
> Something like:
>=20
> chain_put:
>         if (goto_ch)
>                 tcf_chain_put_by_act(goto_ch);
> release_idr:
>         ...
>=20
> cheers,
> Victor
> 

