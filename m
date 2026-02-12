Return-Path: <stable+bounces-215950-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MG+yIfvFjWnT6gAAu9opvQ
	(envelope-from <stable+bounces-215950-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 13:22:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6C212D67C
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 13:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AE9E30C930F
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 12:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68123344D97;
	Thu, 12 Feb 2026 12:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="hKAu2ljP"
X-Original-To: stable@vger.kernel.org
Received: from mail-4397.protonmail.ch (mail-4397.protonmail.ch [185.70.43.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C933570B6;
	Thu, 12 Feb 2026 12:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770898696; cv=none; b=obm2aYD6oxVc6KbRe5qZNtT4WKxLlByAKhPAUysa4ZV/3zN6zawX/Swzavs+JJ+3C7P5tP5GRf1tP6jr3mLG53uiNZtanKWfKQIpOP+qFD5aBQo6+ayEWXAnNyENUy77odryDuHAk25JNMh55EpMF4zMN9i9f0LvkoPGa/HZFyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770898696; c=relaxed/simple;
	bh=Fgp+NowPbYwgCMhWMOsiWJrrq1R0CaAAYKvFqsMquo0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UvZFlScysJXAsSssZkyhY2KCufNAvqP6p4isi5dnb4JbRtoYCnViKMMzM3lGuTQPbh7LBZsjN3TQyaKwklQ9W7Ioml2yDEghg0mTZyd2X4VyXfMKB8OBhxG0FbAcLtg/LJonvZJyOxip4pzRblGcXWSBYkZWESeLVu7Osnyr1OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=hKAu2ljP; arc=none smtp.client-ip=185.70.43.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1770898683; x=1771157883;
	bh=fZ8VB4W/hZRiQ0wYvpHYEcLhoXj9fzTdCw14ccJdOcA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=hKAu2ljPi03hV5sbJzr6xjS5CwhmKp2p8yeI5rCCL7p5jHKDbqni84uFyKrIvlmcL
	 ga/sJKMMhCsfkNqUh465UfImD3sqF7M9hfXi0UlBPTlbI8qI4GxQPVyKqLmIBXTSG7
	 dIFpBX5G89LBKVjoXc1B9uXO8/x3u/dfZWQExT5zcxo0ZFxocdlNcr5ibwINwPkMPs
	 8IGAQoAAceOJ0otb3paKQKsHHfZN86waoV0dV6oZENbNlgdSiMwUewEsoNLGYElxGO
	 Ff0jxrWS1b6INXSjl27aosdLJl6n2oz9OFjcAcKYc8A5M7BphrCVqam4e1/CJxLiTA
	 v6R3jTX09RANw==
Date: Thu, 12 Feb 2026 12:17:59 +0000
To: Victor Nogueira <victor@mojatatu.com>
From: Paul Moses <p@1g4.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v5 1/1] net/sched: act_gate: snapshot parameters with RCU on replace
Message-ID: <nmLWEyw7BWgMgTdbfbxbYI1QqIF-IPdNFFsdf_T8qY8IBncn1bNnTPDe9Bz1AWfsGVt4pgj8wLzhB1DxZ1-RzuZiW2VZLamsaBS4WpjC8lw=@1g4.org>
In-Reply-To: <CA+NMeC_v8bQo2tFUYiD1faMJ0Gd9FFbqmPHCvBUD7HW_yoCx0A@mail.gmail.com>
References: <20260205150958.412278-1-p@1g4.org> <20260205150958.412278-2-p@1g4.org> <CA+NMeC_v8bQo2tFUYiD1faMJ0Gd9FFbqmPHCvBUD7HW_yoCx0A@mail.gmail.com>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 641b4b95da5523bcf2bb07a85c371348fcbfce84
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
	TAGGED_FROM(0.00)[bounces-215950-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,1g4.org:mid,1g4.org:dkim]
X-Rspamd-Queue-Id: DF6C212D67C
X-Rspamd-Action: no action

Proposed changes from v5...v6:
1. Agreed
   -Fixed in (net/sched: act_gate: keep gate_setup_timer helper name)

2. Agreed
   -Fixed in (net/sched: act_gate: drop redundant clockid pre-validation)

3. I was not able to reproduce it. I tended to keep it since NULL became
   representable in the conversion and it was not an expensive branch.
   -Fixed in (net/sched: act_gate: assume params exist on replace path)

4. use_old_entries is true only when REPLACE does not provide a usable new =
entry
   list (missing or empty) and we copy the previous entries into p to prese=
rve
   effective behavior. This block is skipped when new entries are provided,=
 so
   old cycletime is not reused in that case. It could be clearer but I didn=
't
   think it was worth the diff increase.

5. Yes
   -Fixed in (net/sched: act_gate: deduplicate init error cleanup labels)

6. Agreed
   -Fixed in (net/sched: act_gate: align cleanup dereference with act_vlan)

7. Agreed
   -Fixed in (net/sched: act_gate: dump params under rcu read-side lock)

Thanks,
Paul


On Friday, February 6th, 2026 at 4:36 AM, Victor Nogueira <victor@mojatatu.=
com> wrote:

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
> > index c1f75f2727576..4a1a10bfe3e62 100644
> > [...]
> > -static void gate_setup_timer(struct tcf_gate *gact, u64 basetime,
> > -                            enum tk_offsets tko, s32 clockid,
> > -                            bool do_init)
> > [...]
> > +static void gate_timer_setup(struct tcf_gate *gact, s32 clockid,
> > +                            enum tk_offsets tko)
> > [...]
>=20
> I don't believe you need to change the function name here.
>=20
> > [...]
> > @@ -323,20 +370,11 @@ static int tcf_gate_init(struct net *net, struct =
nlattr *nla,
> >
> >         if (tb[TCA_GATE_CLOCKID]) {
> >                 clockid =3D nla_get_s32(tb[TCA_GATE_CLOCKID]);
> > -               switch (clockid) {
> > -               case CLOCK_REALTIME:
> > -                       tk_offset =3D TK_OFFS_REAL;
> > -                       break;
> > -               case CLOCK_MONOTONIC:
> > -                       tk_offset =3D TK_OFFS_MAX;
> > -                       break;
> > -               case CLOCK_BOOTTIME:
> > -                       tk_offset =3D TK_OFFS_BOOT;
> > -                       break;
> > -               case CLOCK_TAI:
> > -                       tk_offset =3D TK_OFFS_TAI;
> > -                       break;
> > -               default:
> > +               clockid_provided =3D true;
> > +               if (clockid !=3D CLOCK_REALTIME &&
> > +                   clockid !=3D CLOCK_MONOTONIC &&
> > +                   clockid !=3D CLOCK_BOOTTIME &&
> > +                   clockid !=3D CLOCK_TAI) {
> >                         NL_SET_ERR_MSG(extack, "Invalid 'clockid'");
> >                         return -EINVAL;
> >                 }
>=20
> This is better than what you had before, however it still
> is redundant given that you do the switch statement later
> and perform the same validation again. If there's no reason to
> keep this code, you probably can also get rid of "clockid_provided".
>=20
> > @@ -366,6 +404,37 @@ static int tcf_gate_init(struct net *net, struct n=
lattr *nla,
> > [...]
> > +
> > +       if (ret !=3D ACT_P_CREATED) {
> > +               rcu_read_lock();
> > +               old_p =3D rcu_dereference(gact->param);
> > +               if (old_p) {
>=20
> When do you believe old_p might be NULL here?
> From what I understand, you can't arrive here while
> a delete for the same action instance is happening in parallel.
> Were you able to create such scenario when testing gate?
>=20
> > [...]
> > +       if (use_old_entries) {
> > +               err =3D tcf_gate_copy_entries(p, old_p, extack);
> > +               if (err)
> > +                       goto unlock;
> > +
> > +               if (!tb[TCA_GATE_CYCLE_TIME])
> > +                       cycletime =3D old_p->tcfg_cycletime;
>=20
> Why did you keep this one as in v4?
> You don't want to reuse the old "cycletime" if the user
> specified new entries?
> Not saying you are necessarily wrong.
> Just trying to understand your logic.
>=20
> > [...]
> > -chain_put:
> > +unlock:
> >         spin_unlock_bh(&gact->tcf_lock);
> >
> >         if (goto_ch)
> >                 tcf_chain_put_by_act(goto_ch);
> > +       release_entry_list(&p->entries);
> > +       kfree(p);
>=20
> The 4 lines above look exactly like what you
> do in err_free. Can't you label them as err_free
> and remove the lines below?
>=20
> > [...]
> > +err_free:
> > +       if (goto_ch)
> > +               tcf_chain_put_by_act(goto_ch);
> > +       release_entry_list(&p->entries);
> > +       kfree(p);
> > +       goto release_idr;
> > +}
> > [...]
> >  static void tcf_gate_cleanup(struct tc_action *a)
> > @@ -458,9 +594,10 @@ static void tcf_gate_cleanup(struct tc_action *a)
> >         struct tcf_gate *gact =3D to_gate(a);
> >         struct tcf_gate_params *p;
> >
> > -       p =3D &gact->param;
> >         hrtimer_cancel(&gact->hitimer);
> > -       release_entry_list(&p->entries);
> > +       p =3D rcu_replace_pointer(gact->param, NULL, 1);
> > +       if (p)
> > +               call_rcu(&p->rcu, tcf_gate_params_free_rcu);
> >  }
>=20
> Sorry, I think I lacked precision in my last comment.
> I meant that you should've removed the rtnl requirement
> (which you did), but also use rcu_dereference_protected as
> act_vlan does. This relates to my previous comment on "old_p"
> being NULL. I don't believe you need to set this to NULL
> unless you were able to reproduce the scenario I described
> earlier.
>=20
> >  static int dumping_entry(struct sk_buff *skb,
> > @@ -512,7 +649,8 @@ static int tcf_gate_dump(struct sk_buff *skb, struc=
t tc_action *a,
> >         spin_lock_bh(&gact->tcf_lock);
> >         opt.action =3D gact->tcf_action;
> >
> > -       p =3D &gact->param;
> > +       p =3D rcu_dereference_protected(gact->param,
> > +                                     lockdep_is_held(&gact->tcf_lock))=
;
>=20
> You could've kept the rcu_read_lock approach here.
> One of the main advantages of making the params rcu
> is being able to dump without the tcf_lock.
>=20
> cheers,
> Victor
> 

