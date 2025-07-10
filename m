Return-Path: <stable+bounces-161536-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 792BCAFF9C8
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 08:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDE513A715F
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 06:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C83228727A;
	Thu, 10 Jul 2025 06:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="lgWrsKs4"
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E141C1F948;
	Thu, 10 Jul 2025 06:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752128705; cv=none; b=HF5m05bcSsFWy871596c79XMQIGug848SUROtfatgoutYhRlLi7Dbnhtsu15MxbuWr+QjD5V5X3Ws6NbmpDeD0eS5UPRSF1ohU03MOU5KSVS98MOKx/zvX5S//Sgt/SUobsoO5/9rEMqu1wvW254psEDkl6v6dZxBIIikzbZpCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752128705; c=relaxed/simple;
	bh=nqCX549RmOOq8cria/HxkBcTUqmp4kRW8eldhJ0wq+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IvZ0iolcIQD85ckFq7EKaD0qwhNOKE74gGPzRPbBrlsN7esFP2Be6nunogL2UBKaoROeME/eN49ng0znc5n3ql/TpFPjhvJxa/FfKcHNMHt85KkBzAq0fsWsatzBPkjzIHlIs2iHQ2KwpmR5nSCY+JbTFGwYvw7t/mRMHU9KCw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=lgWrsKs4; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 929F21C00AE; Thu, 10 Jul 2025 08:24:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1752128689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8t9PLmIR7SS6vrRKwi1Pocurl0uTAGeiC9i7x9ZcKWQ=;
	b=lgWrsKs4nLpyZk/sCP0/UPuXSrSbDQzbUaNl7mYZCABfzCFRkZzKBZ9WEqFgcPbTDcNpsk
	diKOnmKzZ31FBXYAPkAU7QVqRQ9FlPBV+f2dpmYeA+eLawWAtqp5wqbQLF1fHsuR8+tb4+
	SJ7BD0ddJTONtYTtys3T2kPFfQZRsVE=
Date: Thu, 10 Jul 2025 08:24:49 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Shuah <shuah@kernel.org>
Cc: sashal@kernel.org, stable@vger.kernel.org,
	kernel list <linux-kernel@vger.kernel.org>, conduct@kernel.org,
	ebiederm@xmission.com
Subject: Re: Sasha Levin is halucinating, non human entity, has no ethics and
 no memory
Message-ID: <aG9csaJGTdOiBnl3@duo.ucw.cz>
References: <aG2B6UDvk2WB7RWx@duo.ucw.cz>
 <46f581c6-bb61-4163-91a5-27b90838dca8@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7NKn0rfxX1P/x+1d"
Content-Disposition: inline
In-Reply-To: <46f581c6-bb61-4163-91a5-27b90838dca8@kernel.org>


--7NKn0rfxX1P/x+1d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2025-07-09 15:14:38, Shuah wrote:
> On 7/8/25 14:39, Pavel Machek wrote:
> > Hi!
> >=20
> > So... I'm afraid subject is pretty accurate. I assume there's actual
> > human being called "Sasha Levin" somewhere, but I interact with him
> > via email, and while some interactions may be by human, some are
> > written by LLM but not clearly marked as such.
> >=20
> > And that's not okay -- because LLMs lie, have no ethics, and no
> > memory, so there's no point arguing with them. Its just wasting
> > everyone's time. People are not very thrilled by 'Markus Elfring' on
> > the lists, as he seems to ignore feedback, but at least that's actual
> > human, not a damn LLM that interacts as human but then ignores
> > everything.
> >=20
>=20
> You aren't talking to an LLM - My understanding is that Sasha is sending
> these patches (generated with LLM assist) and discussing them on mailing
> lists.

Please discuss this with Sasha. My understanding is that he is not
checking the output of the LLM before sending it out, leading to crazy
halucinations being sent from his email address, leading to situations
like this:

Date: Tue, 08 Jul 2025 14:32:02 -0500
# Wow!

# Sasha I think an impersonator has gotten into your account, and
# is just making nonsense up.

# At first glance this reads like an impassioned plea to backport this
# change, from someone who has actually dealt with it.

# Unfortunately reading the justification in detail is an exercise
# in reading falsehoods.

> Do you have links/threads you can share to show how feedback is being
> ignored?

And you can see how he dealt with the feedback: Not by fixing the LLM,
not by checking it more, simply by "oh well, I'll stop Cc ing you".

Of course, other problem is that LLM output is not marked as such, and
even bigger problem is that decisions are taken on basis of
halucinating model. Patches are applied, Signed-off-by: Sasha Levin,
without Sasha Levin checking them.

Here are other examples where feedback was ignored:

Date: Sat, 29 Aug 2020 14:10:20 +0200
Subject: Re: [PATCH AUTOSEL 4.19 08/38] media: pci: ttpci: av7110: fix
possible buffer overflow caused by bad DMA value in debiirq()
Date: Sat, 29 Aug 2020 14:11:23 +0200
Subject: Re: [PATCH AUTOSEL 4.19 34/38] btrfs: file: reserve qgroup
space after the hole punch range is locked
Date: Mon, 10 May 2021 14:03:18 +0200
Subject: Re: [PATCH AUTOSEL 4.19 06/21] usb: dwc3: gadget: Ignore EP
queue requests during bus reset

> > Do we need bot rules on the list?
>=20
> We have to get humans to follow agreed upon rules of conduct before
> coming up with bot rules.

We did not agree on rules with dealing with bots, and those bots are
spreading harmful halucinations; that's what I'm trying to solve.

BR,
							Pavel
--=20
I don't work for Nazis and criminals, and neither should you.
Boycott Putin, Trump, and Musk!

--7NKn0rfxX1P/x+1d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaG9csQAKCRAw5/Bqldv6
8r1MAJ9xvt+80VijeF3ER7NfrKbtR2P7uACfdVNRYATSw2kV1VAJPV4JDVGuexE=
=7V0F
-----END PGP SIGNATURE-----

--7NKn0rfxX1P/x+1d--

