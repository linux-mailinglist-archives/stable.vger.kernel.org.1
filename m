Return-Path: <stable+bounces-248883-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIlfCfNVB2p7zAIAu9opvQ
	(envelope-from <stable+bounces-248883-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:20:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE37554DEC
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 21920303ABDC
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 17:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C917932ABC0;
	Fri, 15 May 2026 17:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7aTIZxC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86691380FC7
	for <stable@vger.kernel.org>; Fri, 15 May 2026 17:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778864721; cv=none; b=LBfLNtviyTluYuKOTpQM8z6yzni0jI2HcDOhY6/ArX4mXPijZmdqst5uYLF1k65yTm27TAmHdneU2NncIk7klVeCIGUTdDiUwxatgDhU9h7IJPjZD4gHan2WfGqDE0+pN8TteFrnnBGJu8FgH9zGGm3mkSqzk06W6k2dEfZWnZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778864721; c=relaxed/simple;
	bh=eJ0IAC8UqcsVev9hgqWTXzo7piwrzk27IDKUsFlcXzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Duw4zkbhUJanq69ArwsyW72HYfcC0zmyNGtyZBuvz8cGDyd+f39M5qFqZS3lhYT5t4EOCpPbIoqaPgnmr0baKEBl1CPOufKPxkhXNL9m8/vIJUqTtqlgcyJKDZ4HOp2MCrY39omoEqF7SxPltDm6T2nSVRdekll72uUsmkYzajM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7aTIZxC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8179C2BCB0;
	Fri, 15 May 2026 17:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778864721;
	bh=eJ0IAC8UqcsVev9hgqWTXzo7piwrzk27IDKUsFlcXzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d7aTIZxCGuuXVF9+8J3hP9OJM3n4TU2pBwg1uk8SgafjyhoZQ4QuBvtRyndv5rTH7
	 ETRDb9ke9yc52Qa/mjiQFfHbh0kB41L79v0ryyJXPePivXHtwolfd/dGAWYUWoHpiW
	 FxFxQmdIcCqA19A3LLoCecujuNjVex0314MFfluHBDI1mWERYk0pq0B6aYEm2FjeCz
	 qFcuzvAGLEcMXzzi01pCC9+FBoj3oyM2yAAFGpX+5QHg91wAB1v8iAjUe976lPZwfr
	 SZenoB77ZSbnAZdJGxyObD/sC18qyGtv07GYziE984sBf05fwbzZ7qpGFhFttqcFJJ
	 5Du4LpVG2COPA==
Date: Fri, 15 May 2026 19:05:18 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, 
	"Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>
Subject: Re: [PATCH 6.6.y] pwm: imx-tpm: Count the number of enabled channels
 in probe
Message-ID: <agdSJR7uOo5vlfYX@monoceros>
References: <2026050332-duly-bobbing-50af@gregkh>
 <20260503154403.942608-2-ukleinek@kernel.org>
 <2026051538-hamster-grimacing-cfcf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dk2besdivozfypon"
Content-Disposition: inline
In-Reply-To: <2026051538-hamster-grimacing-cfcf@gregkh>
X-Rspamd-Queue-Id: 2FE37554DEC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-248883-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nxp.com:email,msgid.link:url]
X-Rspamd-Action: no action


--dk2besdivozfypon
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 6.6.y] pwm: imx-tpm: Count the number of enabled channels
 in probe
MIME-Version: 1.0

On Fri, May 15, 2026 at 04:51:50PM +0200, Greg KH wrote:
> On Sun, May 03, 2026 at 05:44:04PM +0200, Uwe Kleine-K=F6nig wrote:
> > From: "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>
> >=20
> > On a soft reset TPM PWM IP may preserve its internal state from previous
> > runtime, therefore on a subsequent OS boot and driver probe
> > "enable_count" value and TPM PWM IP internal channels "enabled" states
> > may get unaligned. In consequence on a suspend/resume cycle the call "if
> > (--tpm->enable_count =3D=3D 0)" may lead to "enable_count" overflow the
> > system being blocked from entering suspend due to:
> >=20
> >    if (tpm->enable_count > 0)
> >        return -EBUSY;
> >=20
> > Fix the problem by counting the enabled channels in probe function.
> >=20
> > Signed-off-by: Viorel Suman (OSS) <viorel.suman@oss.nxp.com>
> > Fixes: 738a1cfec2ed ("pwm: Add i.MX TPM PWM driver support")
> > Link: https://patch.msgid.link/20260311123309.348904-1-viorel.suman@oss=
=2Enxp.com
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Uwe Kleine-K=F6nig <ukleinek@kernel.org>
> > [ukleinek: backport to linux-6.6.y]
> > Signed-off-by: Uwe Kleine-K=F6nig <ukleinek@kernel.org>
> > ---
> >  drivers/pwm/pwm-imx-tpm.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
>=20
> What is the git id of this commit?

oops, sorry, I forgot to mention that

It's 3962c24f2d14e8a7f8a23f56b7ce320523947342.

Best regards
Uwe



--dk2besdivozfypon
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoHUkwACgkQj4D7WH0S
/k7piAgAgX0YD9XQ+7TGKeutyY2bzGTMEo6KBDozexjNvlxSqJOzE/J1mPUdNJXd
GLhTyM8vhie9M1I3vAfJo1MR5e/HPkd7aKzHykBQg85u3eV9RzZmjVEf31uB8PvJ
PXwLUs6watnS2ye5CbF4UMULJL5TJYMSuVHq+3CdkHyMV53zzq66hIivGt+2BadW
HytqzjRbyUCu6OnYkfniOvO4WJqwydRh5M6tY+7rKqPuro3pZDlHMWuGvKWfkv6W
o7QPoiy6ALrBLOXO68blnPItJhZjtPlKeLoprnVuIjIKkgyr82itsB0Rze2WT3BZ
gQ5rwMTOdZQMRSVhWZ4AGOhleMgcAQ==
=ikZV
-----END PGP SIGNATURE-----

--dk2besdivozfypon--

