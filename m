Return-Path: <stable+bounces-135194-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2D0A977FB
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 22:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA58718916C3
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 20:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61892D8DAE;
	Tue, 22 Apr 2025 20:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wylie.me.uk header.i=@wylie.me.uk header.b="ULO8Hh2a"
X-Original-To: stable@vger.kernel.org
Received: from wylie.me.uk (wylie.me.uk [82.68.155.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC27F223DF1;
	Tue, 22 Apr 2025 20:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.68.155.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745354852; cv=none; b=pVse8+vrwT2RJaKtISvrEUNKsP9FfD0FxuyjXaoPTj/xyXeVxpbl7MROU61hVpMDvvd01yLy6iSOvB0Bq+qG6ZEYFvyf41xVAsZSJzE1mau3oD/v256Gkt4bLZ3kYhPa+fbn75uxJ8jD4jAbh3c5B/mApDJcf8C97uD9iB0elfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745354852; c=relaxed/simple;
	bh=jI6WvZRTjseleXVwj2r4KXdhlz//nry7SMVNn90CJK0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lg+UVDDoVpZx9W3dY2Hlg6ef9tkA9AZcjUCZQ0OdetDTCXDiP7GqR7q9N/ogUFyjwIjhWympL/WVw9RQ1FUTtN8B//oMhVqVNdL1yIg90KWdf41HCxA5nkhKApijmm5Js93LxPNmloFUI4C02RCQjDTWb28GTffIpnj3tyI9C/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wylie.me.uk; spf=pass smtp.mailfrom=wylie.me.uk; dkim=pass (2048-bit key) header.d=wylie.me.uk header.i=@wylie.me.uk header.b=ULO8Hh2a; arc=none smtp.client-ip=82.68.155.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wylie.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wylie.me.uk
Received: from frodo.int.wylie.me.uk (frodo.int.wylie.me.uk [192.168.21.2])
	by wylie.me.uk (Postfix) with ESMTP id 78EA0120801;
	Tue, 22 Apr 2025 21:47:17 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wylie.me.uk;
	s=mydkim006; t=1745354837;
	bh=jI6WvZRTjseleXVwj2r4KXdhlz//nry7SMVNn90CJK0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ULO8Hh2aQDgzFQqB3l5JjlzWKsXf9iEEpPxZF+9BrhHF3VZMQYmQvi1M/QFP59P1r
	 WlPgp9XcNhxA5ko/bwOTIIVEyTcqnYonfBWxHFzhDh850931xi3LFslUI7ifcEgjmV
	 NMZ0xROAlD89vjgG0b/83F5zNWVhSTv4C2q5CjWhQp+rbtpsocWF2KGgnUcZWLihIb
	 rYjPNns24elRXWhe5NYGx51uC+rKR4R+hmmB0WBlovtMjXf1GqNK4Lf9H66aacgTAB
	 kJzelemb24BywXoZava1XEdVYhTfOS7Ja36O/wDDPNb7DdV+7lBHWRDV2FUJY8WdI/
	 LWt7W6xi/gO7g==
Date: Tue, 22 Apr 2025 21:47:16 +0100
From: "Alan J. Wylie" <alan@wylie.me.uk>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Holger =?UTF-8?B?SG9mZnN0w6R0dGU=?= <holger@applied-asynchrony.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, regressions@lists.linux.dev, Jiri
 Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Octavian Purdila <tavip@google.com>, Toke
 =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>,
 stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [REGRESSION] 6.14.3 panic - kernel NULL pointer dereference in
 htb_dequeue
Message-ID: <20250422214716.5e181523@frodo.int.wylie.me.uk>
In-Reply-To: <aAf/K7F9TmCJIT+N@pop-os.localdomain>
References: <20250421104019.7880108d@frodo.int.wylie.me.uk>
	<6fa68b02-cf82-aeca-56e6-e3b8565b22f4@applied-asynchrony.com>
	<20250421131000.6299a8e0@frodo.int.wylie.me.uk>
	<20250421200601.5b2e28de@frodo.int.wylie.me.uk>
	<89301960-1758-5b2e-6d91-81ef06843e14@applied-asynchrony.com>
	<20250421210927.50d6a355@frodo.int.wylie.me.uk>
	<20250422175145.1cb0bd98@frodo.int.wylie.me.uk>
	<4e2a6522-d455-f0ce-c77d-b430c3047d7c@applied-asynchrony.com>
	<aAf/K7F9TmCJIT+N@pop-os.localdomain>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 22 Apr 2025 13:42:19 -0700
Cong Wang <xiyou.wangcong@gmail.com> wrote:

> On Tue, Apr 22, 2025 at 07:20:24PM +0200, Holger Hoffst=C3=A4tte wrote:
> > (cc: Greg KH)
> >=20
> > On 2025-04-22 18:51, Alan J. Wylie wrote: =20
> > > On Mon, 21 Apr 2025 21:09:27 +0100
> > > "Alan J. Wylie" <alan@wylie.me.uk> wrote:
> > >  =20
> > > > On Mon, 21 Apr 2025 21:47:44 +0200
> > > > Holger Hoffst=C3=A4tte <holger@applied-asynchrony.com> wrote:
> > > >  =20
> > > > > > I'm afraid that didn't help. Same panic. =20
> > > > >=20
> > > > > Bummer :-(
> > > > >=20
> > > > > Might be something else missing then - so for now the only
> > > > > other thing I'd suggest is to revert the removal of the qlen
> > > > > check in fq_codel. =20
> > > >=20
> > > > Like this?
> > > >=20
> > > > $ git diff  sch_fq_codel.c
> > > > diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
> > > > index 6c9029f71e88..4fdf317b82ec 100644
> > > > --- a/net/sched/sch_fq_codel.c
> > > > +++ b/net/sched/sch_fq_codel.c
> > > > @@ -316,7 +316,7 @@ static struct sk_buff
> > > > *fq_codel_dequeue(struct Qdisc *sch) qdisc_bstats_update(sch,
> > > > skb); flow->deficit -=3D qdisc_pkt_len(skb);
> > > > -       if (q->cstats.drop_count) {
> > > > +       if (q->cstats.drop_count && sch->q.qlen) {
> > > >                  qdisc_tree_reduce_backlog(sch,
> > > > q->cstats.drop_count, q->cstats.drop_len);
> > > >                  q->cstats.drop_count =3D 0;
> > > > $
> > > >  =20
> > >=20
> > > It's been about 21 hours and no crash yet. I had an excellent day
> > > down a cave, so there's not been as much Internet traffic as
> > > usual, but there's a good chance the above patch as at least
> > > worked around, if not fixed the issue. =20
> >=20
> > Thought so .. \o/
> >=20
> > I guess now the question is what to do about it. IIUC the fix
> > series [1] addressed some kind of UAF problem, but obviously was
> > not applied correctly or is missing follow-ups. It's also a bit
> > mysterious why adding the HTB patch didn't work.
> >=20
> > Maybe Cong Wang can advise what to do here? =20
>=20
> I guess my patch caused some regression, I am still decoding the
> crashes reported here.
>=20
> Meanwhile, if you could provide a reliable (and ideally minimum)
> reproducer, it would help me a lot to debug.
>=20
> Thanks!

Sorry. No reproducer. The crashes seemed to be totally random.

I posted the script I use to set up tc in my initial report.

FYI, here's the resulting config.

# tc qdisc show
qdisc noqueue 0: dev lo root refcnt 2=20
qdisc fq_codel 0: dev enp3s0 root refcnt 2 limit 10240p flows 1024 quantum =
6014 target 5ms interval 100ms memory_limit 32Mb ecn drop_batch 64=20
qdisc fq_codel 0: dev enp4s0 root refcnt 2 limit 10240p flows 1024 quantum =
1514 target 5ms interval 100ms memory_limit 32Mb ecn drop_batch 64=20
qdisc fq_codel 0: dev enp5s6f0 root refcnt 2 limit 10240p flows 1024 quantu=
m 1514 target 5ms interval 100ms memory_limit 32Mb ecn drop_batch 64=20
qdisc noqueue 0: dev wlp5s7 root refcnt 2=20
qdisc noqueue 0: dev brdmz root refcnt 2=20
qdisc noqueue 0: dev heipv6 root refcnt 2=20
qdisc fq_codel 0: dev tun0 root refcnt 2 limit 10240p flows 1024 quantum 14=
64 target 5ms interval 100ms memory_limit 32Mb ecn drop_batch 64=20
qdisc htb 1: dev ppp0 root refcnt 2 r2q 10 default 0x11 direct_packets_stat=
 0 direct_qlen 3
qdisc fq_codel 824c: dev ppp0 parent 1:11 limit 10240p flows 1024 quantum 3=
00 target 5ms interval 100ms memory_limit 32Mb drop_batch 64=20
qdisc ingress ffff: dev ppp0 parent ffff:fff1 ----------------=20
qdisc fq_codel 0: dev tun1 root refcnt 2 limit 10240p flows 1024 quantum 15=
00 target 5ms interval 100ms memory_limit 32Mb ecn drop_batch 64=20
qdisc htb 1: dev ppp0ifb0 root refcnt 2 r2q 20 default 0x11 direct_packets_=
stat 0 direct_qlen 32
qdisc fq_codel 824b: dev ppp0ifb0 parent 1:11 limit 10240p flows 1024 quant=
um 300 target 5ms interval 100ms memory_limit 32Mb ecn drop_batch 64=20
#=20



--=20
Alan J. Wylie     https://www.wylie.me.uk/     mailto:<alan@wylie.me.uk>

Dance like no-one's watching. / Encrypt like everyone is.
Security is inversely proportional to convenience

