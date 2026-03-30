Return-Path: <stable+bounces-231271-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IMGAPTYymmWAgYAu9opvQ
	(envelope-from <stable+bounces-231271-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 22:11:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72776360DD7
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 22:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 258B6301E5E7
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 20:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2E039E6F8;
	Mon, 30 Mar 2026 20:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="paiLX+yt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C440C377023;
	Mon, 30 Mar 2026 20:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774901467; cv=none; b=fLpDzgwmwj/iYYxEGEYq84MmKLTNeph3sCuSU+xzRVmIqo16zJwUoSJI6b5Fk94i5PXkjmRPn8uElISfjXa3YlEWPvIhp/+vqECdIOBlcXUHUkfuDorqidihtQ04MIv87Pf+bNR5+EW19bucq44UtutVLH5sHvRuXtGezzRXalQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774901467; c=relaxed/simple;
	bh=IN1+dGGaMpxJFBTBzBGcPa/4b1jsaS/540s9r++o8S8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GR51RXz2aGqYKaEdKRBn03E6GLU4QlNPhnvljugIjkNgg74R4+0YE5mE2/Bea7c/5MzeJfH3gFV1tPo4QWRdMvVItfmnOGwlexpA3lQ1OmDQtIkbCg8nUs9L8M0vhq1INiEscl3+LRt2sUnHd/I76Y5NF4XFe4DL5DuPpMniTJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=paiLX+yt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C332C2BCB0;
	Mon, 30 Mar 2026 20:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774901467;
	bh=IN1+dGGaMpxJFBTBzBGcPa/4b1jsaS/540s9r++o8S8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=paiLX+ytaph6U3agF9rMOH+kbIHvcgOaBeqJHtvSw16Dfx26lSHDLw+78TXLnCQJK
	 +mgDJ/s34izzNT2f0nxXdUfb+v/Yb8l11dlUl9peGV9u+E4Caua6kkFan36ZHj7vWa
	 Xjky1AiRoMKUHQLkvqF0pTOG/WkMgmoWhsAqbpzw2TLpLCRefJ3J8FNsxpwY0GrujH
	 y51RiFdhsCo07tuwvlYT907Mbk4HttJSlRnmSA6DPAI3EciAfr5/b/RHDj0okaJdBt
	 ycL2qOljkrBlff2aqB8wYwADjlbsh5vE0yT3JAKoie6GUadZ1s0CFYaeEJx6Ge/oZQ
	 1pePcrUlC3/Wg==
Date: Mon, 30 Mar 2026 21:11:01 +0100
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Paul Olaru <paul.olaru@oss.nxp.com>,
	Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>,
	sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] ASoC: SOF: Don't allow pointer operations on
 unconfigured streams
Message-ID: <accf8fa2-72b2-48a5-bdb7-72784b199347@sirena.org.uk>
References: <20260326-asoc-compress-tstamp-params-v1-1-3dc735b3d599@kernel.org>
 <3cd96fe7-4575-40f9-a1f2-610fb1fac5c1@linux.intel.com>
 <aca1sW6ca1QJBN9V@sirena.co.uk>
 <e3c69a0a-5ed1-45f7-9180-9268bd671df0@linux.intel.com>
 <bf12ef77-0d28-4454-a910-59bf915b5048@sirena.org.uk>
 <3672d018-d7c2-4bdf-a130-60ed76a9e543@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lksPGGP5NBzzpekZ"
Content-Disposition: inline
In-Reply-To: <3672d018-d7c2-4bdf-a130-60ed76a9e543@linux.intel.com>
X-Cookie: HUGH BEAUMONT died in 1982!!
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231271-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.intel.com,nxp.com,linux.dev,perex.cz,suse.com,oss.nxp.com,alsa-project.org,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sirena.org.uk:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 72776360DD7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--lksPGGP5NBzzpekZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 02:50:15PM +0300, P=E9ter Ujfalusi wrote:
> On 30/03/2026 14:05, Mark Brown wrote:

> > We don't generally guard calls based on the state the stream is in,

> compress does this quite much, just avail and tstamp is exempt for some
> reason.

Actually already we have a guard preventing userspace from doing an
avail() when we're unconfigured but we do it after we've called down
into the driver which is less than ideal.  I think that's because we
also check for XRUN and the availability check might cause us to notice
that we're in a bad state for that.

--lksPGGP5NBzzpekZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnK2NQACgkQJNaLcl1U
h9BFjwf+JSOUd94NjXUifLDKPti3az9zkUHPwe3mXahlME2TgApneOgNfhrD9SLD
XWSUJrJLrSSU/nEh+iwJeQ2Ee07cYgQq89L20JE83X18pFJo5IIFUgLh+IsPycUT
SZ127AbqyN8fjjVclg0r4emFrFM2ZCy5J5W9+JpfyLR1MLAHweXln5G2FfpQku+O
G2U6hIlZusUxBE1uCp+OQ6uaXu3vK/s7q1O+XAmuE85Te0rfpMl7josVYE8x/HHo
tQeDLz0Qz1AXmikFMDpH7JnMHeGZXM3qSGPNfPr0jEcaaySU7uMhzIjOP1LSi3EM
5qG4BXIfq0Vmh87/Vs/YIw++agvoSw==
=GUhY
-----END PGP SIGNATURE-----

--lksPGGP5NBzzpekZ--

