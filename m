Return-Path: <stable+bounces-231404-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDYrF86vy2kpKAYAu9opvQ
	(envelope-from <stable+bounces-231404-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 13:28:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 613C0368BAB
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 13:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AD80F30072B4
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 11:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FE63D1CB3;
	Tue, 31 Mar 2026 11:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qy80zUCy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BF73C3444;
	Tue, 31 Mar 2026 11:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774956346; cv=none; b=Bs0pGgreMjdiUouZlUng15w/+ZSKOD8RrGW8ES5JshAKmiH3CWVLyZ/JUgTotw1m9pPTsz+ZhAZN1iqsN8zUk2ueGt++fBpvGXmZJGC3NzQzUFurgG1wPr3z+wy5aOf/aaqsrHL6n0B+vUZ9ad2pupPqYxIA6fA+pn1Z16e75PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774956346; c=relaxed/simple;
	bh=jORSOCWX0nrMPhxbjMkeh8vtFmMEij4sze4y9DNhN80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VEV2ZSgZSX3w2vTP/hkKzWx+KlqP5rFREpFTeO2sj+NQWIAqqkcSPtk0qEjCOyYjQT/FvmYq0eALfXh1GI432BhZb9zEjY0vJg+EblhwgAlWUyFMzVH5kVcM0M8rWNt1gp+0kr4hmKjDLgp2IXYAOXn26/i96DBEDgkl35kN69U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qy80zUCy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5164C19423;
	Tue, 31 Mar 2026 11:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774956346;
	bh=jORSOCWX0nrMPhxbjMkeh8vtFmMEij4sze4y9DNhN80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qy80zUCyyasjlQNDqM2qHi5WI8JmbEQTrY0jptUMM3Ss46ljCJZcfOx0+N2ZX/JE/
	 3Y9Y3P2ND794Co2DrZkW/6fVTgEUplRRFHTRLuTo9uHfVQX2daMuq/Wudhkb4X2Dt/
	 so82QoTbdVBIBB3zU23eFlAFOmzeI2Rq3oCs6e55LoYnBSwI0h0fT5wbNBBMSukL9o
	 0PoNmXHcYSnrUjA9ui/TtQZsF5WwUyLkH9YVc1TSR/UKVSiR512m6sap3BSCo8nQFu
	 BZz/mcYSJTETEKoaeFE0GWEKcTkVXQWr5dHxbWUKEW7D/bA4qw14RrhSsaZX9IVFCs
	 dm8eCrLEM61PQ==
Date: Tue, 31 Mar 2026 12:25:41 +0100
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
Message-ID: <93b8231c-3b8d-4989-9b2d-f6489cb539d0@sirena.org.uk>
References: <20260326-asoc-compress-tstamp-params-v1-1-3dc735b3d599@kernel.org>
 <3cd96fe7-4575-40f9-a1f2-610fb1fac5c1@linux.intel.com>
 <aca1sW6ca1QJBN9V@sirena.co.uk>
 <e3c69a0a-5ed1-45f7-9180-9268bd671df0@linux.intel.com>
 <bf12ef77-0d28-4454-a910-59bf915b5048@sirena.org.uk>
 <3672d018-d7c2-4bdf-a130-60ed76a9e543@linux.intel.com>
 <accf8fa2-72b2-48a5-bdb7-72784b199347@sirena.org.uk>
 <8f37f7dc-bcac-4344-9532-b59eac7e1ffd@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="61VW4jLsrmvHKl/j"
Content-Disposition: inline
In-Reply-To: <8f37f7dc-bcac-4344-9532-b59eac7e1ffd@linux.intel.com>
X-Cookie: I just had a NOSE JOB!!
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231404-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sirena.org.uk:mid]
X-Rspamd-Queue-Id: 613C0368BAB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--61VW4jLsrmvHKl/j
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 08:12:25AM +0300, P=E9ter Ujfalusi wrote:
> On 30/03/2026 23:11, Mark Brown wrote:

> > Actually already we have a guard preventing userspace from doing an
> > avail() when we're unconfigured but we do it after we've called down
> > into the driver which is less than ideal.  I think that's because we
> > also check for XRUN and the availability check might cause us to notice
> > that we're in a bad state for that.

> I don't see how the avail path checks for XRUN and if the drivers
> supposed to do that, I'm not even sure if XRUN is possible with compress..

Yeah, I was hoping there was something in driver code there but didn't
actually check.  You should at least be able to get a buffer overrun
with compressed streams, and even if I'd expect most things to fill
silence you can undderrun which would be bad for applications like music
playback.

> I did noted that the avail have the state check reversed, making it
> ineffective.

> The other point is that any return code from the driver's pointer
> callback is ignored by the core, the return value of
> stream->ops->pointer() is not even captured, it could be void.
> Looks like a design choice, but I cannot say.

I suppose it's easier to have the error reporting in the drivers in case
you want it later.

> fwiw, the same check should be added to sound/soc/qcom/qdsp6/q6apm-dai.c
> as it does div with prtd->pcm_size (q6apm_dai_compr_pointer), which is
> only initialized in set_params.

Ack, I hadn't looked at any other drivers.  I was actually going to send
out the core patch but even so some defence in depth would make me
happier.

--61VW4jLsrmvHKl/j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnLrzQACgkQJNaLcl1U
h9CYvwf9H0zXjZmaoJ1zuEq28CSpYjvp63hNyTMxFP9+rRvciHqjpFj3Bkn56Od1
+cAT/zU44E3avfS/pqolO1JlW9Dzz5OsR4lHnCrw5HY63h+9Jcwuwtm5Y+aABsXx
XTkWjG8+yBzTpjJ617ZcfPaYirOavlEalRQWBQVtXvYwjinnN+ow94wbGEl/uVcx
xiIa/9FFF+pJI6Cdn/4hWYE/N7Zt48IadCLD5VMafzIWvYK4XOjT0dkt9g5aiZTY
Hx7vprwzBs2XniBQZOgxQ2mRy5CECvhMqIfP+RbEL2Afn9ZktUM8RAecop5W+YHW
HZyZYjlc4/1vEYKHigK0f38mon+flA==
=CmUO
-----END PGP SIGNATURE-----

--61VW4jLsrmvHKl/j--

