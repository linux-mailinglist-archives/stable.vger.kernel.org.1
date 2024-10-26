Return-Path: <stable+bounces-88217-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4C49B19D1
	for <lists+stable@lfdr.de>; Sat, 26 Oct 2024 18:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4437C1C20E90
	for <lists+stable@lfdr.de>; Sat, 26 Oct 2024 16:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACC41D2B1A;
	Sat, 26 Oct 2024 16:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="gseaGux2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LD/whaHh"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074F97EEFD;
	Sat, 26 Oct 2024 16:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729960487; cv=none; b=OFYhl7KFXmz4ZnmA5pPJpfcyWSzYPkZY2OUQon2WzlHbDaDcYcHscC3EjVWTnwCwSjMxfr8dA+HOiQCp7kLV6fWCCTky6xQfcIfGTN9o/ZNkWA8EeAkbVNFhD6bReGMn0xplneQZ2JtDm5f2OumaygM1Sfk0Xv4i8eXP4xkpbRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729960487; c=relaxed/simple;
	bh=vNgrceLT7NyiegyWFou2xCkb89Ohp0fn6ptOXdHV188=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=J1xoSLytquOKJxson4V39mk6Bi0ZoiNmex9XTeMmbhN6hq+KTHgk/t+qeOSJwUbCvhuIHvVwRdwjHiXDvr/wu/IcnbqL/7KfeLlaZVkAxN0kCgpdLXsCA+Z6TJZ/2sEm1IF0NJYov0rMobY6fIxy7xzRdetgVEr8M+vXEOcVVOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=gseaGux2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LD/whaHh; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B5A2225400BA;
	Sat, 26 Oct 2024 12:34:42 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-09.internal (MEProxy); Sat, 26 Oct 2024 12:34:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1729960482;
	 x=1730046882; bh=vMY0TEX+Z8SplMb7XevFs7EDbNhUuKW7KWJ2IJ9ktLA=; b=
	gseaGux2m/Da+IlBEiwRi6fdmNPnhv5pa/P6gRK4SUref32RPv0hEFmYQr46qc7e
	poTLICJGUgqUNKqOKenImMqIo0RIojBHpp+J56C9YELhhzInva4sgACcbp7FfeJQ
	6xK9DzgVGBceJuUdiYNdOQm3906r+wDgAHYUEeT1pZzRSlURsGybXTTzO/L78EWI
	mmRr0VK1rV4MkByZcnAOIhMT6v/MC4aawUHQkihb6/xrJHV8cJ1DXQzMP6ztSmH6
	gxShOeJ/SQBNLTdlHbe12Rl1N8bOnf0UG6ao6d49WfD17xMCAem7Nd0deydtr9QQ
	+z4FsI7LjxS2SOPhPkSJkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729960482; x=
	1730046882; bh=vMY0TEX+Z8SplMb7XevFs7EDbNhUuKW7KWJ2IJ9ktLA=; b=L
	D/whaHhhHwgsDEfG+JBXvL0X2CO7LBgRBSIoUyGZ5PgvZU5nUcuqZIQdPQXcZJXI
	W0A9xVL7+WajGrIQ4mMDDcbpwRA6JfUVpWDt6t/woI0iMNSFfWWPQbpY5GDIaB9r
	fVtAqAn3/2X7AB3darCiMd+aKz8SqjEa9ppaD43ImWb2ijckzbI+e9Xcdc97KGOH
	YVIk+E8XqyT//hDuItGxgIXErdIbhkOXhgAs8J3x2hV9W3hcLUcgBVkGt+4u29PQ
	xacOtXHpW8lcicKfqLhtOURQ3yKNrPaZKzrD5pVMyQv5jc1pj4kakfvU6iFArA9Z
	DNqCqBEqgGXxg2mq9WpjQ==
X-ME-Sender: <xms:IRodZ2iNbMyZ0wzp2KVz-p3cFDOHBbQm8CYZez_sKJJaN-Xp-6q07w>
    <xme:IRodZ3DBGWVkQPeTx7dHQR2-7M1KVOx2RYPD2HsgNEn_r_ad3WUJT7366eRB8L90w
    QNLQ--SHmyjyqRs8-0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejgedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdflihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgse
    hflhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpedvleefveetudejueelueeg
    ieeihfefheekffefjeelleduleehuddtjeeiieelhfenucffohhmrghinhepkhgvrhhnvg
    hlrdhorhhgpdhpvdhpfhhouhhnuggrthhiohhnrdhnvghtnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhi
    hgohgrthdrtghomhdpnhgspghrtghpthhtohepudefpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopegtohhnughutghtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtvh
    gvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlvggvsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehsrghshhgrlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgvtg
    hurhhithihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhhurghhsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehtohhrvhgrlhgusheslhhinhhugidqfhhouhhnuggrth
    hiohhnrdhorhhgpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhi
    ohhnrdhorhhgpdhrtghpthhtoheptghorhgsvghtsehlfihnrdhnvght
X-ME-Proxy: <xmx:IRodZ-FUYpro75N4_7nkvUu4MhL474va1SaGNI9CUa8tHFf50ztPjg>
    <xmx:IhodZ_S1b7YK-xhJMDftyGtq5qcBftMDmB_3m3uV_Wv-hA_uB7zZFw>
    <xmx:IhodZzx1PZwZ-MyeHi8C8BHS1pVG3yYJLgHfgI_PlSxC9JqWMahSZA>
    <xmx:IhodZ95utVkVt_-w-9dnWqqJOmYwdfeUaEBKSYYjokKjZ0NjZXSdBA>
    <xmx:IhodZ2rV_920bN5F5yxrJujA2guPfAsAsVU4PzKz-GABiyYIN9FMixsS>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D16D21C20066; Sat, 26 Oct 2024 12:34:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 26 Oct 2024 17:33:16 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-kernel@vger.kernel.org, conduct@kernel.org, security@kernel.org,
 cve@kernel.org, linux-doc@vger.kernel.org,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, shuah@kernel.org,
 lee@kernel.org, sashal@kernel.org, "Jonathan Corbet" <corbet@lwn.net>
Message-Id: <522bd817-339a-45b0-84c2-2b1a4a87980a@app.fastmail.com>
In-Reply-To: <20241026145640.GA4029861@mit.edu>
References: <73b8017b-fce9-4cb1-be48-fc8085f1c276@app.fastmail.com>
 <20241026145640.GA4029861@mit.edu>
Subject: Re: Concerns over transparency of informal kernel groups
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



=E5=9C=A82024=E5=B9=B410=E6=9C=8826=E6=97=A5=E5=8D=81=E6=9C=88 =E4=B8=8B=
=E5=8D=883:56=EF=BC=8CTheodore Ts'o=E5=86=99=E9=81=93=EF=BC=9A
> On Fri, Oct 25, 2024 at 04:15:42PM +0100, Jiaxun Yang wrote:
>>=20
>> Over recent events, I've taken a closer look at how our community's g=
overnance
>> operates, only to find that there's remarkably little public informat=
ion available
>> about those informal groups.=20
>

Hi Theodore,

Thanks for detailed comments! This kind of constructive discussions
is what I'm always looking for.

> There's quite a bit of information available in the Linux Kernel
> documentation.  For example:
>
> * https://www.kernel.org/doc/html/latest/process/security-bugs.html
> * https://www.kernel.org/doc/html/latest/process/code-of-conduct.html
> * https://www.kernel.org/code-of-conduct.html

Thank you for the pointers. My concerns actually rooted from the first t=
wo
documents, and I was directed to the third link off-list following my
initial post.

In process/security-bugs, the term "security officers" is consistently m=
entioned,
yet it's unclear who they are, what specific privileges they hold compar=
ed to
regular developers, and how security fixes are expected to reach Linus's=
 tree
during an embargo period.

After reviewing the third link, I now have a clearer understanding of the
CoC Committee, though it's unfortunate that this webpage is not directly
referenced in the kernel documentation.

That being said, I'll try to improve the documentation on these things
based on my observations. My background perhaps makes me particularly
sensitive to some ambiguous language, especially where "constructive
ambiguity" might be involved. Recent events make me started to look
into those aspects in border community.

>
> Ultimately, though, governance model that we've used since the
> founding of the Benevolent Dictator model.  For a description of this,
> see:
>
> * https://wiki.p2pfoundation.net/Benevolent_Dictator
>
> The reason why this model works for Open Source projects is that
> ultimately, the license allows the code to be forked, and someone
> could decide to take the Linux Kernel sources, and declare some new
> version, say: "Tedix".  However, if I was delusional enough to do
> this, it's very likely no one would pay attention to me, and consider
> me a random madman (of which there are many on the Internet). =20
>
> Ultmately, though, the reason why Linus continues to serve as the
> leader of the Linux is that there is a very large number of people
> that respect his judgement and technical acumen.  And unlike in
> physical space where a dictator could (hypothetically) order tanks to
> fire on college-aged students, ultimately no one can force developers
> or companies to continue use or develop Linux.
>
> Everything else follows from this.  So for example, a maintainer or
> maintainer team can refuse to accept patches from a particular source.
> If someone disagrees with a decision, whether it is not accepting a
> patch, or request a patch that it be reverted, they can appeal to
> Linus.  Linus ask the Maintainer for their reasons, or can decide to
> override the decision by accepting the patch into his tree, or
> reverting a patch.  Ultimately, Linus can decide to relieve a
> maintainer of their duties by simply refusing to accept pull request
> from that maintainer, or by remoing the subsytem entirely from his
> sources.

That aligns well with my understanding. I've witnessed many "escalations=
 to
Linus" and have been involved a few times myself. I'd say we (maybe not =
all)
benefit from having a respected individual to make those difficult final
decisions.

I have no intention of criticizing the system here.

>
> As another example, the Code of Conduct committee has no inherent
> power to sanction developers, other than to make recommendations to
> people who actually do the work --- namely, Linus Torvalds, other
> maintainers, the people who run the mailing lists, etc.  Like with
> Maintainers, their "power" comes from the respect that individuals on
> that body have with Linus and the other maintainers.

That's new to me. The `Enforcement` section in the CoC document initially
gave me the impression that all participants were obligated to follow th=
eir
decisions, but it turns out that's not the case.

I appreciate the clarification.

>
> Yet another body which you didn't mention is the Linux Foundation
> Technical Advisory board.  That body is elected, but the TAB has
> always made it clear that the primary power comes from the reputation
> and moral authority of the people who are elected to the TAB.  Sure,
> The TAB chair has an at-large seat on the Linux Foundation board, but
> any influence that the TAB through the TAB chair might have is more
> because of their work and the force of their arguments.

I reviewed the TAB information pages before making that post and saw
a clear membership list and guidelines for TAB, so I didn't view it as
an "informal group". I even suggested that this could be a topic for
TAB discussion at the end of my original post.

>
>
> More broadly, the model that I like to use is "servant leadership",
> and that's why I tell people who want to pursue taking up leadership
> roles in Linux.  Most of the senior leadership spend a huge amount of
> their personal time, and have often made career choices that have
> prioritized working on Linux and other Open Source projects over
> monetary renumeration.  Speaking for myself, I could have progressed
> farther in terms of position and salary.  I made choices that traded
> the freedom and ability to work on Linux because that was more
> important to me, and there is an awful lot of what I do as a leader is
> to serve those people in the ext4 development community.

Thank you for sharing this insight on servant leadership, it genuinely
resonates. I deeply appreciate the personal sacrifices and commitment
that you, other leaders and everyone involved, have made to prioritise
the advancement of Linux and open-source projects over conventional care=
er
progression. It's truly inspiring to witness such dedication.

>
> This is not true just in Linux; previously, I've served on the
> Security Area Advisory Group for the IETF, the standards body for the
> internet, and as working group chair for the ipsec working group when
> the IPSec protocols were first being standardied.  Sure, I was part of
> the "governance" of the IETF, but one of the things you learn very
> quickly is that as a volunteer leader, your primary power is to stop
> things from happening.  Hopefully, you're only stopping bad things
> from happening, and you can try to encourage and cajole volunteers
> spend time on what's necessary to make forward progress.  And of
> course, you can spend your own personal time smoothing the way to
> enable the members of the community to make forward progress.  And
> that takes us back to "servant leadership".

It's fortunate that people like you tirelessly contribute to driving
the world forward. I think we can all agree that, despite the disputes
all over the world, we're each striving to make the world a better place
in our own ways.

I'm sorry this matter has taken up your attention, I'll see what I can do
on my end.

Thanks
>
> Cheers,
>
> 					- Ted
>
> P.S.  Note that when I say "volunteer', I'm using this in a fairly
> broad/informal fashion.  Yes, some members of the community have
> companies that pay our salaries to work on Linux.  But as the ext4
> maintainer, I don't have magement authority over the ext4 developer.
> I can refuse to take a patch; I can spend time creating testing
> infrastruture to make it easier for ext4 contributors to test their
> work; I can point out ways that some particular design might be good
> for ext4, and good for their company's business objectives, to the
> extent that I know their companies goals or they are willing to share
> those goals with me.  But I can't *force* someone at SuSE or Oracle or
> IBM or Huawei to work on some particular ext4 feature or bug.
> Ultimately, either individuals (who might be hobbists) or companies,
> voluntarily choose to contribute to ext4, or the IPSec standard.  And
> so that's why I call Linux and the IETF have much in common with a
> pure 100% volunteer organization, such as Doctors without Borders.

--=20
- Jiaxun

