Return-Path: <stable+bounces-164853-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9104BB12EC5
	for <lists+stable@lfdr.de>; Sun, 27 Jul 2025 11:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9998189BA4E
	for <lists+stable@lfdr.de>; Sun, 27 Jul 2025 09:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187EA1F0E2E;
	Sun, 27 Jul 2025 09:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="TPOpbOeS"
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DDA1F2380;
	Sun, 27 Jul 2025 09:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753607302; cv=none; b=FvreDSO1eP/tgXA2dMoThcuyMLZCMVhX5oxd1vvU07YJgqVPa2InPENjriqDAG1UyjxK+fj/ANT4RHktoBNTc3F+33F9fKD89vzsajsbvM42f6Plp2wlWTWSZkHAocRZZPBAtih/SyfywMJarpotYCYNqLRHXLX4v55UGdJuJFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753607302; c=relaxed/simple;
	bh=K9PlRa+9ZaJmgDkDOtR4k2UtVpS/I9VeGUFo/MGRstE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dzdxCRk8ut7VPi1bC+b86Bu21ZgckSY5i6901cNC+YuC3QxBzueUUaglBDqkWAoZa4goxy/Mkob6R5j78saWxoT2bGMEPwHxfLgryZreHnepCJEeCUyoRYOJ+3TXd2BS615yXrmQ4TDZnyIsoau5hEexAC76l+zKfMVFxMgERcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=TPOpbOeS; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 9AD341C00BE; Sun, 27 Jul 2025 11:08:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1753607296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pwfznIqT1WHSu85SCkFMT1obzC6Ufc9ybSMALetFPLk=;
	b=TPOpbOeSixGaROaEgCBlHnvWLPJXjq86toXl3HsLe/Bgc9cQn3MF5OJ8r/xGSZGm9odNus
	/Dlx5N4vdxG/E6u9H/xK/naBlq7cye1Hohy2SaueVpU8VgJ/G09mi//eLfBNq6kFt6zJDs
	tWd/VyL0LOH8k39MOnf0zQnR0q6ZOcY=
Date: Sun, 27 Jul 2025 11:08:16 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Shuah <shuah@kernel.org>
Cc: sashal@kernel.org, stable@vger.kernel.org,
	kernel list <linux-kernel@vger.kernel.org>, conduct@kernel.org,
	ebiederm@xmission.com
Subject: Re: Sasha Levin is halucinating, non human entity, has no ethics and
 no memory
Message-ID: <aIXsgI1n68Dy3l7+@duo.ucw.cz>
References: <aG2B6UDvk2WB7RWx@duo.ucw.cz>
 <46f581c6-bb61-4163-91a5-27b90838dca8@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xVgcL36Ud9roh48b"
Content-Disposition: inline
In-Reply-To: <46f581c6-bb61-4163-91a5-27b90838dca8@kernel.org>


--xVgcL36Ud9roh48b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

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

At this point, I'd like to know (a) what steps (if any) were taken to
prevent LLM hallucinations from reaching the lists, and (b) what steps
(if any) were taken to make sure patches Signed-off by developer were
actually reviewed by said developer, and not applied simply due to
said hallucinations.

Confusion caused LLM hallucinations can be seen for example in thread
"[PATCH AUTOSEL 6.15 6/8] PM: Restrict swap use to later in the
suspend sequence", it includes as great stuff as fake http links.

I have seen solution proposed for (a), but have not seen any solution
proposed for (b) and that's actually more serious problem.

One solution would be to use separate email address "Autosel bot <>"
for both From and Signed-off, so there's no confusion between content
generated by developer and content generated by LLM.

Best regards,
								Pavel
--=20
I don't work for Nazis and criminals, and neither should you.
Boycott Putin, Trump, and Musk!

--xVgcL36Ud9roh48b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaIXsgAAKCRAw5/Bqldv6
8vqyAJ4zNA738s6/rUurqqoSLmV7Y+2yoQCgiCwleQIU95B+Ov5tKouUJjeSzCs=
=zdB9
-----END PGP SIGNATURE-----

--xVgcL36Ud9roh48b--

