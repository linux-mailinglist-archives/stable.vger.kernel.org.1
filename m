Return-Path: <stable+bounces-134784-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8276BA95092
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 14:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68EE51894275
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 12:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E83A264609;
	Mon, 21 Apr 2025 12:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wylie.me.uk header.i=@wylie.me.uk header.b="YjFXxPm8"
X-Original-To: stable@vger.kernel.org
Received: from wylie.me.uk (wylie.me.uk [82.68.155.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A812513C918;
	Mon, 21 Apr 2025 12:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.68.155.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745237416; cv=none; b=JDwBu4Dd4RsnN+GB0l5Md9QX9/u3Bi6PX/8Vm2LlcyxlIJW+0FO0CSTwUMsHU35f/dYNjr6zZPfVpJzoMUI+d4zW05W1lrx1d5/lCCtITeY6mTSKhoydOeBzkwCeoiZR6b0UOAwr0DJkUFEHhvPnipVM7gX3z0ICcnBF3esFojc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745237416; c=relaxed/simple;
	bh=GN+oSxhyQaP1dEE+BYZQp3Hp6FhpAZAswLoJZ2QWsjw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KuqyLmo+vfEIUFZXc5yd3JBRBoQhmoTRBp3LYf0xldEfYR8wQ1akd9UXce24yeiBkvDo/a3IxXYgMH1G/9/mZu6RdyTjOdk0bkvOM8pokRCEmBrMB+rHfP/qADOt00Yx6E24RHchM131qCpuS1ZpKI26I2ULdq/1fkyEPjRZjjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wylie.me.uk; spf=pass smtp.mailfrom=wylie.me.uk; dkim=pass (2048-bit key) header.d=wylie.me.uk header.i=@wylie.me.uk header.b=YjFXxPm8; arc=none smtp.client-ip=82.68.155.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wylie.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wylie.me.uk
Received: from frodo.int.wylie.me.uk (frodo.int.wylie.me.uk [192.168.21.2])
	by wylie.me.uk (Postfix) with ESMTP id 4B5DB120872;
	Mon, 21 Apr 2025 13:10:02 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wylie.me.uk;
	s=mydkim006; t=1745237402;
	bh=GN+oSxhyQaP1dEE+BYZQp3Hp6FhpAZAswLoJZ2QWsjw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YjFXxPm8p8/BxTIqSiSQ5IrU250a4olASovMaI/eLdCFIkaB1fybuCAn1EdwEhJiW
	 XIGZEZXpm6uhofKlHj8fOrsRy6gUSzKmEq++nionR/KIjFVSpmfivxmrhVnxa95H/x
	 sVmrAunlpaYCKBc7CBD1yJzpFa87LSLJAp+PezBCK7Te3JJ2A9tBoSBeTCWl4ac3lV
	 DkCeVwQkrCDiCjRMT+M2gAMHjSnZc0Z70tRDznAwLP/AIt+1ByRMGIDK2q9mPC8BH/
	 X6x7LKdFx4fQ11c4m4D+j8/QiVa6tCp1E6HMaN6OSPfTNP8b9Vwtvbs9nyOCrjnDj4
	 CHSdao/gnWaiA==
Date: Mon, 21 Apr 2025 13:10:00 +0100
From: "Alan J. Wylie" <alan@wylie.me.uk>
To: Holger =?UTF-8?B?SG9mZnN0w6R0dGU=?= <holger@applied-asynchrony.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, regressions@lists.linux.dev, Cong
 Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Octavian Purdila
 <tavip@google.com>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?=
 <toke@redhat.com>, stable@vger.kernel.org
Subject: Re: [REGRESSION] 6.14.3 panic - kernel NULL pointer dereference in
 htb_dequeue
Message-ID: <20250421131000.6299a8e0@frodo.int.wylie.me.uk>
In-Reply-To: <6fa68b02-cf82-aeca-56e6-e3b8565b22f4@applied-asynchrony.com>
References: <20250421104019.7880108d@frodo.int.wylie.me.uk>
	<6fa68b02-cf82-aeca-56e6-e3b8565b22f4@applied-asynchrony.com>
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

On Mon, 21 Apr 2025 13:50:52 +0200
Holger Hoffst=C3=A4tte <holger@applied-asynchrony.com> wrote:

> On 2025-04-21 11:40, Alan J. Wylie wrote:
> > #regzbot introduced: 6.14.2..6.14.3
> >=20
> > Since 6.14.3 I have been seeing random panics, all in htb_dequeue.
> > 6.14.2 was fine. =20
>=20
> 6.14.3 contains:
> "codel: remove sch->q.qlen check before qdisc_tree_reduce_backlog()"
> aka https://web.git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/=
commit/net/sched?h=3Dlinux-6.14.y&id=3Da57fe60ef4cf96bfbb6b58397ec28bdb5a5c=
6b31
>=20
> Is your HTB backed by fq_codel by any chance?

Yes

# grep fq 91-tc.sh=20
quantum=3D300		# fq_codel quantum 300 gives a boost to interactive flows
modprobe sch_fq_codel
tc qdisc add dev "$ext_ingress" parent 1:11 fq_codel quantum $quantum ecn
tc qdisc add dev "$ext" parent 1:11 fq_codel quantum $quantum noecn

> If so, try either reverting the above or adding:
> "sch_htb: make htb_qlen_notify() idempotent" aka
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3D5ba8b837b522d7051ef81bacf3d95383ff8edce5
>=20
> which was successfully not added to 6.14.3, along with the rest of the
> series:
> https://lore.kernel.org/all/20250403211033.166059-2-xiyou.wangcong@gmail.=
com/

"successfully not added"?

$ git cherry-pick  5ba8b837b522d7051ef81bacf3d95383ff8edce5
[linux-6.14.y 2285c724bf7d] sch_htb: make htb_qlen_notify() idempotent
 Author: Cong Wang <xiyou.wangcong@gmail.com>
 Date: Thu Apr 3 14:10:23 2025 -0700
 1 file changed, 2 insertions(+)

It will take a while (perhaps days?) before I can confirm success.

Thanks
Alan

--=20
Alan J. Wylie     https://www.wylie.me.uk/     mailto:<alan@wylie.me.uk>

Dance like no-one's watching. / Encrypt like everyone is.
Security is inversely proportional to convenience

