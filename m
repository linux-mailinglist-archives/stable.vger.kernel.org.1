Return-Path: <stable+bounces-210615-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aB4GAKEIcGlyUwAAu9opvQ
	(envelope-from <stable+bounces-210615-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 23:58:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 905CD4D5B8
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 23:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5022A9613BB
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 22:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8619E3A7F55;
	Tue, 20 Jan 2026 22:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="nzcu8OmS"
X-Original-To: stable@vger.kernel.org
Received: from mail-07.mail-europe.com (mail-0701.mail-europe.com [51.83.17.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C592E2F0C6E
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 22:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.17.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768949265; cv=none; b=lAjyjntdNX7UyUyHV3q9ZDqeezr/b9ZalHddW3NMfYTYqKj00mC9Ma2HlhUQuYqGHFRQ5boznbATr26/EBtZCD+6x0TUSR9sbRgw1MPlyQ8UrGfCcg/KM1Z/EzqA+sB/Cm81kZBoqjrOpvrx0XwPslaRTf4i20NlMZBbxzlUI6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768949265; c=relaxed/simple;
	bh=KfEzSf2Psni+NH58GWquJU9gb7ZJf/dDBWnlpGF8ajY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XoRjVp2rVEbGknYN0oiw5Bs2p+kXBuWi9caJU30TKIbN6U6eyAY5sKw9j3cAC9tBFuPQVZd7puPyKcFuLZTq5Qey3QDwCuLealeEehhCyOvFJykEbpVBLk91Ppo5NMYSu/4YtPjEDjc3lMn+VqQmedzcV7AXcSNZt4jKIw/aqkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=fail smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=nzcu8OmS; arc=none smtp.client-ip=51.83.17.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=1g4.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1768949246; x=1769208446;
	bh=lPRtFBw9Utc5TQLt3X4PQUZMdzsfO4LaX087YkLyS0w=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=nzcu8OmSg9Ro4dLyDyMHg2mRQlm7wwDn5ZQF5KKvBMlvUu9gyL75coacoxz/ApNo+
	 pQ00GY2ddBZF061x4S+7TDBrh3cWDVv9WR8O/80DTFrolz9hEK2EhEIoEOv2vKonKa
	 Pv68oksbxrejCLV6oNNyuU3dTCFdhgy3/O0yutV+jQA5QIjcBoFM/dMqdohszww1FS
	 3/eHH4hYOyqfAbJWNsNT+4xclSkHl6vJgcFQSa/S4IWRe/u126XfidKF2bIiRTz7of
	 lW+qCrQawoRe7wwgB2FPBzGBRoAqHVxlGvKXrqiz7Mf9lV1GURKSMOsGLfQQQoL4vY
	 vZFBh2jd/+mug==
Date: Tue, 20 Jan 2026 22:47:19 +0000
To: Victor Nogueira <victor@mojatatu.com>
From: Paul Moses <p@1g4.org>
Cc: netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] net/sched: act_gate: fix schedule updates with RCU swap
Message-ID: <gwO399q2_pH73eDkd2OatN9SsR8aHtm8CbVIEPOf0nuxXjqbjY6vgCqNyFya75mMVicn8NwUgG8zaNFkR_JuZmFk0UcWNCHlpzSxFbaycf4=@1g4.org>
In-Reply-To: <bff53f0a-2c94-46b2-bb49-b05d10ae420e@mojatatu.com>
References: <20260120004720.1886632-1-p@1g4.org> <20260120004720.1886632-2-p@1g4.org> <bff53f0a-2c94-46b2-bb49-b05d10ae420e@mojatatu.com>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 002e9e46bde3210a0919590bb776202a3ae03279
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[1g4.org:s=protonmail2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-210615-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mojatatu.com,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[1g4.org,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[p@1g4.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[1g4.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,1g4.org:mid,1g4.org:dkim,act_gate_ops.net_id:url,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 905CD4D5B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

act_gate is not just a list and a timer. It is a small state machine that k=
eeps runtime gating insulated from control plane updates using tcf_lock, th=
e hrtimer, and the PENDING bit. The live decision variables are protected, =
but the schedule backing store (the entries list) was still being mutated o=
r freed on the control path, so updates were not transactional and could ex=
pose partially constructed schedules or freed nodes to concurrent readers. =
The fix is to treat the schedule as an immutable published object: validate=
 and build off to the side, publish atomically, then retire after readers d=
rain (RCU). That preserves the original goal of not interfering with the ga=
te.

I=E2=80=99m trying to strike the right balance of input validation for stab=
le. I kept this as one patch because the validate and build before publish =
path is part of making the RCU update model correct. I did try implementing=
 the additional validation independently first, but it did not meaningfully=
 reduce the size or complexity because the RCU swap still requires a fully =
formed schedule object before publish. Without preliminary validation, it i=
s easy to corrupt the timer state or end up with undefined schedule behavio=
r. At minimum, I think we need:
  - interval > 0: prevents zero length entries and immediate refire loops
  - at least one entry: avoids empty schedule deref and undefined state
  - cycle time > 0: required for division and close time computations
  - overflow checks: prevent wrap or underflow in close time arithmetic

I can do the conversion without these checks, but the resulting behavior wo=
uld be fragile. If there is guidance on what validation level you would pre=
fer here (minimal representable range checks vs stricter sane inputs), I am=
 happy to align with it.

thanks
Paul


On Tuesday, January 20th, 2026 at 3:04 PM, Victor Nogueira <victor@mojatatu=
.com> wrote:

>=20
>=20
> On 19/01/2026 21:48, Paul Moses wrote:
>=20
> > Switch act_gate parameters to an RCU-protected pointer and update sched=
ule
> > changes using a prepare-then-swap pattern. This avoids races between th=
e
> > timer/data paths and configuration updates, and cancels the hrtimer
> > before swapping schedules.
> >=20
> > A gate action replace could free and swap schedules while the hrtimer
> > callback or data path still dereferences the old entries, leaving a
> > use-after-free window during updates. The deferred swap and RCU free
> > close that window. A reproducer is available on request.
> >=20
> > Also clear params on early error for newly created actions to avoid
> > leaving a dangling reference.
> > [...]
> > diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
> > index c1f75f2727576..3ee07c3deaf97 100644
> > --- a/net/sched/act_gate.c
> > +++ b/net/sched/act_gate.c
> > @@ -6,6 +6,7 @@
> > #include <linux/kernel.h>
> > #include <linux/string.h>
> > #include <linux/errno.h>
> > +#include <linux/limits.h>
>=20
>=20
> Do you really need to include this?
>=20
> > [...]
> > @@ -69,12 +71,14 @@ static enum hrtimer_restart gate_timer_func(struct =
hrtimer *timer)
> > {
> > struct tcf_gate *gact =3D container_of(timer, struct tcf_gate,
> > hitimer);
> > - struct tcf_gate_params *p =3D &gact->param;
> > + struct tcf_gate_params *p;
>=20
>=20
> When adding/editing local variables, you should adhere to the
> reverse xmas tree style [1].
>=20
> > spin_lock(&gact->tcf_lock);
>=20
>=20
> Shouldn't you call rcu_read_lock before this line now?
>=20
> > + p =3D rcu_dereference_protected(gact->param,
> > + lockdep_is_held(&gact->tcf_lock));
> > [...]
> > static int tcf_gate_init(struct net *net, struct nlattr *nla,
> > @@ -296,20 +296,26 @@ static int tcf_gate_init(struct net *net, struct =
nlattr *nla,
> > struct netlink_ext_ack *extack)
> > {
> > struct tc_action_net *tn =3D net_generic(net, act_gate_ops.net_id);
> > - enum tk_offsets tk_offset =3D TK_OFFS_TAI;
> > - bool bind =3D flags & TCA_ACT_FLAGS_BIND;
> > struct nlattr *tb[TCA_GATE_MAX + 1];
> > struct tcf_chain *goto_ch =3D NULL;
> > - u64 cycletime =3D 0, basetime =3D 0;
> > - struct tcf_gate_params *p;
> > - s32 clockid =3D CLOCK_TAI;
> > + struct tcf_gate_params *p, *oldp;
> > struct tcf_gate *gact;
> > struct tc_gate *parm;
> > - int ret =3D 0, err;
> > - u32 gflags =3D 0;
> > - s32 prio =3D -1;
> > + struct tcf_gate_params newp =3D { };
>=20
>=20
> Abide by reverse xmas tree when adding local variables.
>=20
> > [...]
> > + bool clockid_set =3D false;
>=20
>=20
> I could be missing something, but I don't believe you need this
> boolean.
>=20
> > [...]
> > @@ -323,6 +329,7 @@ static int tcf_gate_init(struct net *net, struct nl=
attr *nla,
> >=20
> > if (tb[TCA_GATE_CLOCKID]) {
> > clockid =3D nla_get_s32(tb[TCA_GATE_CLOCKID]);
> > + clockid_set =3D true;
> > switch (clockid) {
>=20
>=20
> Instead of using clockid_set and repeating the switch statament.
> You could put this if-statement after you already have oldp and do the
> following:
>=20
> if (tb[TCA_GATE_CLOCKID]) {
> clockid =3D nla_get_s32(tb[TCA_GATE_CLOCKID]);
> switch (clockid) {
> case CLOCK_REALTIME:
> tk_offset =3D TK_OFFS_REAL;
> break;
> case CLOCK_MONOTONIC:
> tk_offset =3D TK_OFFS_MAX;
> break;
> case CLOCK_BOOTTIME:
> tk_offset =3D TK_OFFS_BOOT;
> break;
> case CLOCK_TAI:
> tk_offset =3D TK_OFFS_TAI;
> break;
> default:
> NL_SET_ERR_MSG(extack, "Invalid 'clockid'");
> return -EINVAL;
> }
> } else if (ret !=3D ACT_P_CREATED) {
> clockid =3D oldp->tcfg_clockid;
>=20
> tk_offset =3D gact->tk_offset;
>=20
> }
>=20
> > [...]
> > - if (tb[TCA_GATE_CYCLE_TIME])
> > + if (ret =3D=3D ACT_P_CREATED)
> > + update_timer =3D true;
> > [...]
>=20
>=20
> Here you are assigning update_timer to true when the op is a create...
>=20
> > [...]
> > + if (update_timer && ret !=3D ACT_P_CREATED)
> > + hrtimer_cancel(&gact->hitimer);
>=20
>=20
> .. however in the if-statement where it is used you are only allowing
> updates. This looks weird.
>=20
> > [...]
> > +free_p:
> > + release_entry_list(&p->entries);
> > + kfree(p);
>=20
>=20
> The 2 lines of code above are being repeated below and in
> tcf_gate_params_release. You should put them in a common function.
>=20
> > +release_new_entries:
> > + release_entry_list(&newp.entries);
> > +put_chain:
> > if (goto_ch)
> > tcf_chain_put_by_act(goto_ch);
> > release_idr:
> > - /* action is not inserted in any list: it's safe to init hitimer
> > - * without taking tcf_lock.
> > - */
> > - if (ret =3D=3D ACT_P_CREATED)
> > - gate_setup_timer(gact, gact->param.tcfg_basetime,
> > - gact->tk_offset, gact->param.tcfg_clockid,
> > - true);
> > + if (ret =3D=3D ACT_P_CREATED) {
> > + p =3D rcu_dereference_protected(gact->param, 1);
> > + if (p) {
> > + release_entry_list(&p->entries);
> > + kfree(p);
> > + rcu_assign_pointer(gact->param, NULL);
> > + }
> > + }
> > tcf_idr_release(*a, bind);
>=20
>=20
> Also, the AI review [2] pointed out a real issue.
> It's easy to reproduce by running something like:
>=20
> tc action add action gate base-time 200000000000ns \
> sched-entry close 0ns index 10
>=20
> I think overall you have the right idea - RCU seems like a good fit here.
> The issue is that this patch is confusing because it seems like you are
> trying to fix the bug and perform cleanups at the same time.
> If that is the case, can you try breaking this patch into two? Do one to
> fix the bug (introducing RCU and etc) and another for the cleanups.
>=20
> [1]
> https://www.kernel.org/doc/html/v6.3/process/maintainer-netdev.html#local=
-variable-ordering-reverse-xmas-tree-rcs
> [2]
> https://netdev-ai.bots.linux.dev/ai-review.html?id=3Dcdc17d0d-fd59-41a8-9=
c8d-1a42699167fd#patch-0
>=20
> cheers,
> Victor

