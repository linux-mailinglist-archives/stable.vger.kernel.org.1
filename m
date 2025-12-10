Return-Path: <stable+bounces-200510-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FFFCB1CC3
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 04:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F736301B2FC
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 03:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847EF3081C8;
	Wed, 10 Dec 2025 03:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="Ap1Hz5Z+"
X-Original-To: stable@vger.kernel.org
Received: from mail-07.mail-europe.com (mail-0701.mail-europe.com [51.83.17.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB9E304BA8
	for <stable@vger.kernel.org>; Wed, 10 Dec 2025 03:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.17.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765337485; cv=none; b=FMFzo85O4xPLrkgdUIWLyIT67BtYKkuKzwUiJVDaPnjS/rM84L//Mb9eI4EsqzmVAl3bbEEZTj23CHPA0v3APB3FUgIALekBCR8FV+tSrR6Kqq5AKKcXuM1ibgtGnV7sVJf7GSmR2jbNzI/wZe7qNe1bR+xoTbgSc1Jwp5ayglc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765337485; c=relaxed/simple;
	bh=A0mqf7E8mfIpRkXJLknPSiLEpeEgaE3gaxx8Zgf2Ahc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BKozsXtjpa9X3rXo7bj+bFBC9tMjMlD+2WD7OJmbGC3tgteISW70XWhbW9GQ0RuwhIXHUEg2FfPGF4oJhXU0HSS2ATdJEi/nJL0OlXXB96QU+jsRV89AVw3eY1sRhdjZMib1L/PG43x66K4jRjjsO1C5LwvHlXt3QOgJFrFMJRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=fail smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=Ap1Hz5Z+; arc=none smtp.client-ip=51.83.17.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail2; t=1765337465; x=1765596665;
	bh=A0mqf7E8mfIpRkXJLknPSiLEpeEgaE3gaxx8Zgf2Ahc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Ap1Hz5Z+W6JQ+cZlWiGkSRyW4iFlVBJNdihSaPMJKFnKSO9JOxXBCMfs73aVMw0jQ
	 X+cBSH4DOd69pKuRKgQJaflZtyF3c7KstnMP2+Xpc+3xR+iTrQvr9cpIGobDGlVjW1
	 ZcTFNsglNZ9mm77T0ddDUBl9pwmLYLyu0SiP93NY4FyACF+Pdti6NQFx69lCchJB5G
	 lW5g1wkCragoa+/Tgn6EJNpaTDoByGMH4JWb4+PBoO7cXQeeI2o64/3DJOpslOdzep
	 SjivxQCMZLH1suq37F9MjT8O0sNjMZq9+PuEwuTHDheF4B/Ul8dgT1cVlgVXk9nta+
	 JolIyb/oFvcHg==
Date: Wed, 10 Dec 2025 03:31:02 +0000
To: zyc zyc <zyc199902@zohomail.cn>
From: William Liu <will@willsroot.io>
Cc: Greg KH <gregkh@linuxfoundation.org>, stable <stable@vger.kernel.org>
Subject: =?utf-8?Q?Re:_=E5=9B=9E=E5=A4=8D:6.12.50_regression:_netem:_cannot_mix_duplicating_netems_with_other_netems_in_tree.?=
Message-ID: <_7sb1wYlX1079sj77KxpLIUjYMEqn-J_b431OKc-v1aPiWhfSnwYZ9_C6BAOLW-a2cdngID0Nxqdip95EedRWtV7iMDeIVzFTBTvFbEKczA=@willsroot.io>
In-Reply-To: <19af9ef2e7c.cd495a2b18809.5502831741554587778@zohomail.cn>
References: <19ace674022.114eb26e714992.3171091003233609170@zohomail.cn> <19adda5a1e2.12410b78222774.9191120410578703463@zohomail.cn> <2025120248-operation-explain-1991@gregkh> <19ae2d0c40c.1304ed0542955.1614492155671387965@zohomail.cn> <2025120350-encourage-possible-b043@gregkh> <19aed2c0e0e.136fee88813945.4542830906609965797@zohomail.cn> <19af9ef2e7c.cd495a2b18809.5502831741554587778@zohomail.cn>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: 3b046f99b68503db359d970a8348cf08d69699e5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi zyc,

The netdev maintainers and I are aware of this issue. This change was made =
to prevent a local DOS bug in netem that was extremely trivial to trigger, =
and some maintainers considered your type of configuration as an extremely =
rare use case (but imo still a very valid one). I provided a summary of thi=
s fix as well as other proposed fixes in both the commit log and [1].

There is currently a patch proposed in [2] to resolve this which technicall=
y obeys man page semantics but was previously rejected. Basically, the DOS =
can be easily resolved by enqueuing duplicated packets to the same netem qd=
isc, but other maintainers presented valid concerns about changing user vis=
ible behavior from the past 2 decades and the original commit message menti=
oned enqueuing from root was necessary to "avoid problems with qlen account=
ing with nested qdisc."

tc_skb_extensions sounds like a reasonable solution to me that changes no e=
xisting behavior and adds no additional restrictions [3], but it has not be=
en further explored or checked for soundness. Hypothetically, it would fix =
both the DOS bug and allow packets to retain the behavior of enqueuing from=
 root.

You can follow the status of the fix in [2] - I do not plan to further volu=
nteer myself and my free time in this specific fix process due to the consi=
stent pattern of unprofessional and patronizing emails from Cong Wang. I am=
 confident the other netdev maintainers should reach a resolution soon.

Best,
Will

[1] https://lore.kernel.org/netdev/PKMd5btHYmJcKSiIJdtxQvZBEfuS4RQkBnE4M-TZ=
kjUq_Rdj6Wgm8wDmX-p6rIkSRGDJN8ufn0HcDI6-r2lgibdSk7cn1mHIdbZEohJFKMg=3D@will=
sroot.io/
[2] https://lore.kernel.org/netdev/20251126195244.88124-4-xiyou.wangcong@gm=
ail.com/
[3] https://lore.kernel.org/netdev/CAM0EoMmBdZBzfUAms5-0hH5qF5ODvxWfgqrbHaG=
T6p3-uOD6vg@mail.gmail.com/

On Monday, December 8th, 2025 at 9:59 AM, zyc zyc <zyc199902@zohomail.cn> w=
rote:

>=20
>=20
> ---- zyc zyc zyc199902@zohomail.cn =E5=9C=A8 Fri, 2025-12-05 18:31:00 =
=E5=86=99=E5=88=B0=EF=BC=9A---
>=20
> > ---- Greg KH gregkh@linuxfoundation.org =E5=9C=A8 Wed, 2025-12-03 19:30=
:42 =E5=86=99=E5=88=B0=EF=BC=9A---
>=20
> > > On Wed, Dec 03, 2025 at 07:05:00PM +0800, zyc zyc wrote:
>=20
> > > > ---- Greg KH gregkh@linuxfoundation.org =E5=9C=A8 Tue, 2025-12-02 1=
9:30:09 =E5=86=99=E5=88=B0=EF=BC=9A---
>=20
> > > > > On Tue, Dec 02, 2025 at 06:39:00PM +0800, zyc zyc wrote:
>=20
> > > > > > Hello,
>=20
> > > > > > Resend my last email without HTML.
>=20
> > > > > > ---- zyc zyc zyc199902@zohomail.cn =E5=9C=A8 Sat, 2025-11-29 18=
:57:01 =E5=86=99=E5=88=B0=EF=BC=9A---
>=20
> > > > > > > Hello, maintainer
>=20
> > > > > > > I would like to report what appears to be a regression in 6.1=
2.50 kernel release related to netem.
>=20
> > > > > > > It rejects our configuration with the message:
>=20
> > > > > > > Error: netem: cannot mix duplicating netems with other netems=
 in tree.
>=20
> > > > > > > This breaks setups that previously worked correctly for many =
years.
>=20
> > > > > > > Our team uses multiple netem qdiscs in the same HTB branch, a=
rranged in a parallel fashion using a prio fan-out. Each branch of the prio=
 qdisc has its own distinct netem instance with different duplication chara=
cteristics.
>=20
> > > > > > > This is used to emulate our production conditions where a sin=
gle logical path fans out into two downstream segments, for example:
>=20
> > > > > > > two ECMP next hops with different misbehaviour characteristic=
s, or
>=20
> > > > > > > an HA firewall cluster where only one node is replaying frame=
s, or
>=20
> > > > > > > two LAG / ToR paths where one path intermittently duplicates =
packets.
>=20
> > > > > > > In our environments, only a subset of flows are affected, and=
 different downstream devices may cause different styles of duplication.
>=20
> > > > > > > This regression breaks existing automated tests, training env=
ironments, and network simulation pipelines.
>=20
> > > > > > > I would be happy to provide our reproducer if needed.
>=20
> > > > > > > Thank you for your time and for maintaining Linux kernel.
>=20
> > > > > Can you use 'git bisect' to find the offending commit?
>=20
> > > > > thanks,
>=20
> > > > > greg k-h
>=20
> > > > Hi Greg,
>=20
> > > > The error came from this commit:
>=20
> > > > commit 795cb393e38977aa991e70a9363da0ee734b2114
>=20
> > > > Author: William Liu will@willsroot.io
>=20
> > > > Date: Tue Jul 8 16:43:26 2025 +0000
>=20
> > > > net/sched: Restrict conditions for adding duplicating netems to qdi=
sc tree
>=20
> > > > [ Upstream commit ec8e0e3d7adef940cdf9475e2352c0680189d14e ]
>=20
> > > So is this also an issue for you in the latest 6.17 release (or 6.18)=
?
>=20
> > > If not, what commit fixed this issue? If so, please contact all of th=
e
>=20
> > > developers involved and they will be glad to work to resolve this
>=20
> > > regression in the mainline tree first.
>=20
> > > thanks,
>=20
> > > greg k-h
>=20
> > Hi Greg,
>=20
> > I can only test 6.12 stable kernels. Let me add Will.
>=20
> > Best,
>=20
> > zyc
>=20
>=20
> Hello Will
>=20
> Could you help? This breaks our lab simulation.
>=20
> Best,
> Zhang Yang Chao

