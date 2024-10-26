Return-Path: <stable+bounces-88214-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D27D99B1875
	for <lists+stable@lfdr.de>; Sat, 26 Oct 2024 15:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92914283A5C
	for <lists+stable@lfdr.de>; Sat, 26 Oct 2024 13:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27161E50B;
	Sat, 26 Oct 2024 13:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="VO/Vx1aB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jKlnaP1F"
X-Original-To: stable@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7571D799D;
	Sat, 26 Oct 2024 13:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729948695; cv=none; b=f6SdgdDZto1RAYWHhCY+f8JEiWX3/6ef19xc66MkrDYeB1C20SFiTsuABVFHagdpVRQDxB9cOHw4mo3F/0U+ShT3rsReyiZVDZHibO7MeLvsx8E9KxvPBim4pAR9aCQUgjHWKLibd0p/eROMMwxZjF5hakKH+vLNARhudd7UeMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729948695; c=relaxed/simple;
	bh=HJRwHJXbUEBjIDmmNwTu1z2WrrERb9aEwOG4fNinBg4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=o6BTIIMmfV/n83L9OnMysMI8kI7orTIrK+ShvmU1m602p/KH/tGOSIEV9/TpMLi3pb7I76E7HMS8IMv17BVEKSs86wHsKChkjORfV7F9PCfO/1UoIb1anyI4Decls2qDSAJ927xjeoozAitgMjHoaZb9C9G+0s8YeJp8UAjTIjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=VO/Vx1aB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jKlnaP1F; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id D078511400C4;
	Sat, 26 Oct 2024 09:18:11 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-09.internal (MEProxy); Sat, 26 Oct 2024 09:18:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1729948691;
	 x=1730035091; bh=HJRwHJXbUEBjIDmmNwTu1z2WrrERb9aEwOG4fNinBg4=; b=
	VO/Vx1aBfiT/v8bZD/g2X7xzvXLfv709PN/3DxozuX/d3oF6kz4iUFnlx3uRxTW5
	WkoHiM5ZA9mlNRkGfFEQL+i7oSWBILpbmghYquwa8ZMaButIXSwWBJl2BZl0eOPw
	vo2ndMEtgfIRkdUYvxBFPoSNga8ZQ8y++8NpO0ySpW5OwG7yK8i984fd2QMBYvE6
	D0Rr2glty3He9xXihwqzVN2FKSABfsvDVmtnA4x3pnoNn3/amCuyToYFcbDQBS3c
	2mv6uPcyGDmkEfkpFO7SiYU+UgVCypSPc26osEMMF6QRZ7I6OMEzc9M292EAXRMN
	Or9xM8UKiJ146hR29Za8Zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729948691; x=
	1730035091; bh=HJRwHJXbUEBjIDmmNwTu1z2WrrERb9aEwOG4fNinBg4=; b=j
	KlnaP1FcCS3bxQUdFEsyV89OWm/CiUffBJ2Pj3Fx4JIzb8TH6JUlYxLEA9K1P5dH
	K80oOMd1fwEl+u6rlpGXI0Ira2qUDMeTRCpgQ4Ha83Euco/tRadVCsXflbYkqqAq
	DUQc5XOQ0n9T14Jj6raDXUmDeP0rBU8uQPWOeipMHmGvmVRBr6F4Ncn3uhd9UqSt
	1aIVhMhf4Qo8y9ZpdUCCkazBsYtz8hwoRjixx+hVjjKIAHydelj2xpdqp6F2jI6W
	+kAARXrlPjgovm3W9/cLo02AQo6JOrn8Jotqndk1EkMGPIy7rkq4za4TFPd9NPyk
	KoT4VWxj0aVyYrUDH7dxg==
X-ME-Sender: <xms:E-wcZ2ZtU8NeXVTVMYcDqHSuTwF6j8TsMu2fOscW4jPILv6kOFcKtQ>
    <xme:E-wcZ5ZUzbS-nSYRGg0ejRz8wq37OBFtQ0sfAjwZLK0ycML3pKrucwPvXbdAKrdmd
    Gh1Mo8k7uouDnZpYEM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejgedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedflfhirgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfh
    hlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepjeehfeduvddtgffgvdffkeet
    hefhlefgvdevvdekuefffeekheehgeevhfevteejnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgr
    thdrtghomhdpnhgspghrtghpthhtohepudefpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopegtohhnughutghtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtvhgvsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhgvvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrshhhrghlsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehsvggtuhhrihhthieskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthho
    rhhvrghlughssehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhope
    hgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrgh
X-ME-Proxy: <xmx:E-wcZw8gFHuaJOudIcacyX5UBuB4WxQsfuRbYEPI0VHBvHRsXzq6_g>
    <xmx:E-wcZ4qMFlHqGj5FJ2s4hfCS1jXCR9vdNF7ts0XwvcjnrYTeZ1CkNg>
    <xmx:E-wcZxqXWUD6SWQQW_adqVMk6WBiUhlu4njT8Hio4ag59Lj2oZjS4w>
    <xmx:E-wcZ2ROxTzSAnGao5pQgTqzDlkZIweJMYbWxL3CJjTTptugmwsKJw>
    <xmx:E-wcZ_iEuNjRkA_AfJ4-WrMUnn3orcrcekqsc10tWrFf-z605xRxro0S>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 46CC81C20066; Sat, 26 Oct 2024 09:18:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 26 Oct 2024 14:16:47 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Krzysztof Kozlowski" <krzk@kernel.org>, linux-kernel@vger.kernel.org,
 conduct@kernel.org, security@kernel.org, cve@kernel.org,
 linux-doc@vger.kernel.org, "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, shuah@kernel.org,
 lee@kernel.org, sashal@kernel.org, "Jonathan Corbet" <corbet@lwn.net>
Message-Id: <9b9c034b-19b1-4f02-b7fc-3152526c82c4@app.fastmail.com>
In-Reply-To: <fae122f1-5a8e-4f92-b468-aba3fcb8ac90@kernel.org>
References: <73b8017b-fce9-4cb1-be48-fc8085f1c276@app.fastmail.com>
 <fae122f1-5a8e-4f92-b468-aba3fcb8ac90@kernel.org>
Subject: Re: Concerns over transparency of informal kernel groups
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



=E5=9C=A82024=E5=B9=B410=E6=9C=8826=E6=97=A5=E5=8D=81=E6=9C=88 =E4=B8=8B=
=E5=8D=8812:05=EF=BC=8CKrzysztof Kozlowski=E5=86=99=E9=81=93=EF=BC=9A
>
> Oh, spread more FUD under the cloak of helping the community. Reminds =
me
> something, wait, how was it? zx?

I drafted this email with good will.

While I appreciate any constructive comments, this kind of unfair accusa=
tion
is unacceptable.

I'm not demanding anyone to take action, I'm just trying to be helpful.

>
>> about those informal groups. With the exception of the Linux kernel h=
ardware security
>> team, it seems none of these groups maintain a public list of members=
 that I can
>> easily find.
>>=20
>> Upon digging into the details, I=E2=80=99d like to raise a few concer=
ns and offer some thoughts
>> for further discussion:
>>=20
>> - Absence of a Membership Register
>> Our community is built on mutual trust. Without knowing who comprises=
 these groups,
>> it's understandably difficult for people to have full confidence in t=
heir work.
>
> No, you might have difficulty, not "all people" which you imply. Please
> stop creating sentences like you are speaking for others. You do not
> speak for others.

I never said "all" here, and just to quote:

"I am expressing the views of a number of people I talked to but it's no=
t fair of me
to name them."

The same applies to this email as well. I actually did a private RFC bef=
ore sending it.
Many people are unable to speak up here due to company affiliation and o=
ther concerns.

>
>> A publicly available membership list would not only foster trust but =
also allow us to
>> address our recognition and appreciation.
>
> Nope. For some of the groups it is very intentional to hide the
> membership. It was explained already why and should be pretty obvious.

I might be dumb in this case, do you mind giving me a pointer to the exp=
lanation?
I can draft patch to make it clear in documents.

>
[...]
>
>>=20
>> - No Conflict of Interest Policy
>> Particularly in the case of the Code of Conduct Committee, there may =
arise situations
>> where individuals face challenging decisions involving personal conne=
ctions. A conflict
>> of interest policy would provide valuable guidance in such circumstan=
ces.
>
> Feel free to propose patches instead of claiming there is problem for
> others. If you identify issue, propose a patch.

Thanks, I will. I'm just aiming to gather some feedback before proposing=
 patches.
I also welcome patches from those more qualified than myself.

>
> Several other your replies earlier were in similar tone. I am not going
> to engage in such discussions and probably neither other people, but
> some think that silence is approval or agreement. Thus this reply. for
> me this is just FUD.

Again, I must decline to accept this sort of unfair accusation.

It's indeed not the tone I'm usually speaking on the mailing list. It ou=
ght
to be more straightforward for technical communications. However, in the=
se
particularly challenging times, I'm striving to maintain a humble and re=
spectful
tone whilst ensuring my views are clearly spoken. I'd be grateful for co=
mments
expressing any dissatisfaction with my approach, but I feel that persona=
l attack
ultimately do nothing constructive.

Thanks.
>
> Best regards,
> Krzysztof

--=20
- Jiaxun

