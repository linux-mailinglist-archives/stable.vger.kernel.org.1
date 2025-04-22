Return-Path: <stable+bounces-135158-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA06A97315
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 18:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A7C03BA0F8
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 16:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57972918C8;
	Tue, 22 Apr 2025 16:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wylie.me.uk header.i=@wylie.me.uk header.b="m0dTY7cZ"
X-Original-To: stable@vger.kernel.org
Received: from wylie.me.uk (wylie.me.uk [82.68.155.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF47918D63A;
	Tue, 22 Apr 2025 16:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.68.155.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745340727; cv=none; b=sTHoWtwU9McfdLkJEsrFnHsimlLZhi4sFJDHKt2xmQGaRPb/vnZ/2d3Qs0GNvNOch0VSmBaGyjE2tjpAyvJWKG1XcwLaKCdaZbm8TQBL8EvzWXThcHyni7v7httcRKXIiYVIN9vQlkyUX/9VYQCHRE0yFJCtVrLtncfVDKiEnQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745340727; c=relaxed/simple;
	bh=T4Gei4noOURlngmAU8lLrsYIK9+KhrxsvVg1WHk+lhM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s7oayU7aumGNciypbZLQutk7vxbelz90BggsiGXgBbqpHSeI0D0kpUJazZyTN4y0yOqbxLkm56sY7XPrq+ddpobdJqmgYyGRAHYcaS0ortkG5hvQcqmkMHZdTQxrbA85X/uaqw06k3dc6FX/UDGRiGceE6AWQcedMkaAGgpN7sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wylie.me.uk; spf=pass smtp.mailfrom=wylie.me.uk; dkim=pass (2048-bit key) header.d=wylie.me.uk header.i=@wylie.me.uk header.b=m0dTY7cZ; arc=none smtp.client-ip=82.68.155.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wylie.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wylie.me.uk
Received: from frodo.int.wylie.me.uk (frodo.int.wylie.me.uk [192.168.21.2])
	by wylie.me.uk (Postfix) with ESMTP id 7F752120801;
	Tue, 22 Apr 2025 17:51:46 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wylie.me.uk;
	s=mydkim006; t=1745340706;
	bh=T4Gei4noOURlngmAU8lLrsYIK9+KhrxsvVg1WHk+lhM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=m0dTY7cZIdpgs09MArNJseZM9Lw1jjQxBlMju7wpdrCdvSHzyugnQEKDEUSrYTsVl
	 LrGsrMAhtLRUKd8t1JCOWlRl9aCQy6MQ7LWH/tlZ9M/FjP5wPyoQSpHsaHMF9lnr/E
	 cKWdU6WBUwTCitYizkn9E2br5L3avHczeD97QMDqIOv0uER475/mh81WOw71ZvxIZO
	 jEct0OPSGJbsIfCWItiAABrn51KCGASgG1rmUeAQejXxg0Hp8BL49wE19RM/0OV+TA
	 tHwuaLK5zFDZbiwVILCzCX3VOHM3D4r77lFzIxLbNlE0wvdkbCUoTj21O1GnVUQVmS
	 LUu6gOGFEkU4Q==
Date: Tue, 22 Apr 2025 17:51:45 +0100
From: "Alan J. Wylie" <alan@wylie.me.uk>
To: Holger =?UTF-8?B?SG9mZnN0w6R0dGU=?= <holger@applied-asynchrony.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, regressions@lists.linux.dev, Cong
 Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Octavian Purdila
 <tavip@google.com>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?=
 <toke@redhat.com>, stable@vger.kernel.org
Subject: Re: [REGRESSION] 6.14.3 panic - kernel NULL pointer dereference in
 htb_dequeue
Message-ID: <20250422175145.1cb0bd98@frodo.int.wylie.me.uk>
In-Reply-To: <20250421210927.50d6a355@frodo.int.wylie.me.uk>
References: <20250421104019.7880108d@frodo.int.wylie.me.uk>
	<6fa68b02-cf82-aeca-56e6-e3b8565b22f4@applied-asynchrony.com>
	<20250421131000.6299a8e0@frodo.int.wylie.me.uk>
	<20250421200601.5b2e28de@frodo.int.wylie.me.uk>
	<89301960-1758-5b2e-6d91-81ef06843e14@applied-asynchrony.com>
	<20250421210927.50d6a355@frodo.int.wylie.me.uk>
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

On Mon, 21 Apr 2025 21:09:27 +0100
"Alan J. Wylie" <alan@wylie.me.uk> wrote:

> On Mon, 21 Apr 2025 21:47:44 +0200
> Holger Hoffst=C3=A4tte <holger@applied-asynchrony.com> wrote:
>=20
> > > I'm afraid that didn't help. Same panic.   =20
> >=20
> > Bummer :-(
> >=20
> > Might be something else missing then - so for now the only other
> > thing I'd suggest is to revert the removal of the qlen check in
> > fq_codel. =20
>=20
> Like this?
>=20
> $ git diff  sch_fq_codel.c
> diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
> index 6c9029f71e88..4fdf317b82ec 100644
> --- a/net/sched/sch_fq_codel.c
> +++ b/net/sched/sch_fq_codel.c
> @@ -316,7 +316,7 @@ static struct sk_buff *fq_codel_dequeue(struct
> Qdisc *sch) qdisc_bstats_update(sch, skb);
>         flow->deficit -=3D qdisc_pkt_len(skb);
> =20
> -       if (q->cstats.drop_count) {
> +       if (q->cstats.drop_count && sch->q.qlen) {
>                 qdisc_tree_reduce_backlog(sch, q->cstats.drop_count,
>                                           q->cstats.drop_len);
>                 q->cstats.drop_count =3D 0;
> $=20
>=20

It's been about 21 hours and no crash yet. I had an excellent day down
a cave, so there's not been as much Internet traffic as usual, but
there's a good chance the above patch as at least worked around, if not
fixed the issue.

Regards
Alan

--=20
Alan J. Wylie     https://www.wylie.me.uk/     mailto:<alan@wylie.me.uk>

Dance like no-one's watching. / Encrypt like everyone is.
Security is inversely proportional to convenience

