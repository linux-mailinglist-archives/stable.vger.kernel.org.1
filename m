Return-Path: <stable+bounces-64772-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 928FF9430EA
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 15:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CA4CB24085
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 13:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A32A1B29CF;
	Wed, 31 Jul 2024 13:32:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A9D1AD9CB;
	Wed, 31 Jul 2024 13:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722432722; cv=none; b=S8XQMonQ5ehEdv7PWrLrXKwtkMCRX8Lh9HrdPur4G9RAWjXxoaxu5cyg9HQhArVyl1cLq5Gtsz1/EybidQl10P+A+go6XHr/XMZ6Is2F/ocVVucEK8axQjR0/nefQOTr1V63dyMhpPCztFToVYl9A3XJVoJYgNsublFC9UvA9rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722432722; c=relaxed/simple;
	bh=ZrOrYZWPguaGZbZEYM0RvPWlavBLs7B2YJ4QWINxkJs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gQfRzYSxDK+Sv7obsdbBspyuYS7JFM8/f/8Bkzqg6YtOVCRi8WQpJeYXukKueuZ61eaKTGmwz0cfQ2uL06kdylpkWJrHH+h1cAEtxBwTYKmg9N08U2ZkCwPakAkV4cQYs0TA7naz/UkS3j2j3lp1V2Y7i12u5fXrkFcsxoci2/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Sam James <sam@gentoo.org>
To: Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>
Cc: matoro <matoro_mailinglist_kernel@matoro.tk>,  John David Anglin
 <dave.anglin@bell.net>,  Linux Parisc <linux-parisc@vger.kernel.org>,
  Deller <deller@gmx.de>,  John David Anglin <dave@parisc-linux.org>,
 stable@vger.kernel.org
Subject: Re: Crash on boot with CONFIG_JUMP_LABEL in 6.10
In-Reply-To: <20240731110617.GZ33588@noisy.programming.kicks-ass.net> (Peter
	Zijlstra's message of "Wed, 31 Jul 2024 13:06:17 +0200")
Organization: Gentoo
References: <096cad5aada514255cd7b0b9dbafc768@matoro.tk>
	<bebe64f6-b1e1-4134-901c-f911c4a6d2e6@bell.net>
	<11e13a9d-3942-43a5-b265-c75b10519a19@bell.net>
	<cb2c656129d3a4100af56c74e2ae3060@matoro.tk>
	<20240731110617.GZ33588@noisy.programming.kicks-ass.net>
Date: Wed, 31 Jul 2024 14:31:55 +0100
Message-ID: <877cd1bsc4.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Peter Zijlstra <peterz@infradead.org> writes:

> On Tue, Jul 30, 2024 at 08:36:13PM -0400, matoro wrote:
>> On 2024-07-30 09:50, John David Anglin wrote:
>> > On 2024-07-30 9:41 a.m., John David Anglin wrote:
>> > > On 2024-07-29 7:11 p.m., matoro wrote:
>> > > > Hi all, just bumped to the newest mainline starting with 6.10.2
>> > > > and immediately ran into a crash on boot. Fully reproducible,
>> > > > reverting back to last known good (6.9.8) resolves the issue.=C2=A0
>> > > > Any clue what's going on here?
>> > > > I=C2=A0can=C2=A0provide=C2=A0full=C2=A0boot=C2=A0logs,=C2=A0start=
=C2=A0bisecting,=C2=A0etc=C2=A0if=C2=A0needed...
>> > > 6.10.2 built and booted okay on my c8000 with the attached config.
>> > > You could start
>> > > with it and incrementally add features to try to identify the one
>> > > that causes boot failure.
>> > Oh, I have an experimental clocksource patch installed.=C2=A0 You will=
 need
>> > to regenerate config
>> > with "make oldconfig" to use the current timer code.=C2=A0 Probably, t=
his
>> > would happen automatically.
>> > >=20
>> > > Your config would be needed to duplicate.=C2=A0 =C2=A0 Full boot log=
 would also help.
>> >=20
>> > Dave
>>=20
>> Hi Dave, bisecting quickly revealed the cause here.
>
> https://lkml.kernel.org/r/20240731105557.GY33588@noisy.programming.kicks-=
ass.net

Greg, I see tglx's jump_label fix is queued for 6.10.3 but this one
isn't as it came too late. Is there any chance of chucking it in? It's
pretty nasty.

thanks,
sam

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iOUEARYKAI0WIQQlpruI3Zt2TGtVQcJzhAn1IN+RkAUCZqo8zF8UgAAAAAAuAChp
c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0MjVB
NkJCODhERDlCNzY0QzZCNTU0MUMyNzM4NDA5RjUyMERGOTE5MA8cc2FtQGdlbnRv
by5vcmcACgkQc4QJ9SDfkZAp6gD+Jm3iAhmMIV9r5hvD6WNKeZdCdAYrODOt99Is
RcnaizEA/1U+frbXA8Gr1fY7tf906NsumEtw8yk+6GhBs1nrXY0B
=OHJC
-----END PGP SIGNATURE-----
--=-=-=--

