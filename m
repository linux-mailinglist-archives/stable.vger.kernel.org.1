Return-Path: <stable+bounces-230691-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHecNzS1xmnFNwUAu9opvQ
	(envelope-from <stable+bounces-230691-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 17:49:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FCC347CCB
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 17:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E2B293072B92
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 16:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DEF35F184;
	Fri, 27 Mar 2026 16:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHnbF2XL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF1736308A;
	Fri, 27 Mar 2026 16:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774630085; cv=none; b=Ui4GM8hXXoDHHsTKAlrPyu3yuWZvJ1xCK9S4pe/qHkHAxaKXhNM7j74ZigRioJlePldyaLrs2j3iB5WlhThjT71+ujnDrr16iS4965PAp5crsaro59vtQxfiou0Tm8P/4ZFtBiwcRWVU3xe+m8iWNPL85GMhbU10KFySbLyYMGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774630085; c=relaxed/simple;
	bh=d3PijMvDbvxnUEzU6gxuyBsPTheOglT+TbYXjvUHlxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iU02vzkwIEdvP8Xiv9cjkCacV+lI+l/bHbODUSoeo0f8/kVhVD8OUtuIa0z4AijCWienQ6+7Ng7PY/9COoXRaRs/NNwGpz2jgTitz5ga9tDNHqm0VO8mUUyet/WKnBxR8nKgycdDodPVaKaOpL6i79Do42mCBSEOU+YZIrxqUps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHnbF2XL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F9C2C2BCB0;
	Fri, 27 Mar 2026 16:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774630084;
	bh=d3PijMvDbvxnUEzU6gxuyBsPTheOglT+TbYXjvUHlxo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FHnbF2XLg1VpyGIZjp0fO1fyXZ247/0Qx4/UQ8rQAVd/KGIBOhagbnA0bTyP6g9cy
	 6t4/LwHmYL7m1UYXLtYpWzAuNHv6ylaWaq+eucABINGOC0orQoNHJKx8HUCfVo+6uz
	 Is5R7E8vOErjYJmacjGSP5qRgWu4+Wdr9zYL4QceQyfg4dHThlMfeGVsPk3gE/dxAe
	 BXLtndhV16gmg+79HMYObz+j9v8qeseCJsB/LHAbPy9PVa63yIcEDa+tnZO3HVIOBH
	 kCkgW4TPxFD+LwDV8JAAAaE5eaWt5KtexV8supiFW3XTd71IgEJIK5mou+RNU0XkVH
	 o0rro4PxEOf7g==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id E20141AC5731; Fri, 27 Mar 2026 16:48:00 +0000 (GMT)
Date: Fri, 27 Mar 2026 16:48:00 +0000
From: Mark Brown <broonie@kernel.org>
To: "Liao, Bard" <bard.liao@intel.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Paul Olaru <paul.olaru@oss.nxp.com>,
	Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>,
	"sound-open-firmware@alsa-project.org" <sound-open-firmware@alsa-project.org>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] ASoC: SOF: Don't allow pointer operations on
 unconfigured streams
Message-ID: <aca0wNJokCY1ImEk@sirena.co.uk>
References: <20260326-asoc-compress-tstamp-params-v1-1-3dc735b3d599@kernel.org>
 <SJ2PR11MB8424B402A94D8CB8A178BF14FF57A@SJ2PR11MB8424.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6ZUEPrAzetSX6Z5N"
Content-Disposition: inline
In-Reply-To: <SJ2PR11MB8424B402A94D8CB8A178BF14FF57A@SJ2PR11MB8424.namprd11.prod.outlook.com>
X-Cookie: Identify your visitor.
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.intel.com,nxp.com,linux.dev,perex.cz,suse.com,oss.nxp.com,alsa-project.org,vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TAGGED_FROM(0.00)[bounces-230691-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sirena.co.uk:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 99FCC347CCB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--6ZUEPrAzetSX6Z5N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 27, 2026 at 02:09:40AM +0000, Liao, Bard wrote:

> > +	if (!sstream->channels || !sstream->sample_container_bytes)
> > +		return -EBUSY;

> Sorry, but why it is BUSY in this case?

-EBUSY is often "wrong state".  Could also be -EINVAL, it doesn't super
make a difference I think - nobody should actually be doing this.

--6ZUEPrAzetSX6Z5N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnGtMAACgkQJNaLcl1U
h9CaJQf+IVjaqUbzUXV6gRp5wytogHz5dvAUlo/Fe3LMGpzH8kzUtnyNJQ+ACcpG
2RnFIOgX6s6Xnw+i/f02rCj/mKAKbana+RDJLbBi5/qgQSUmsvzKJv9nbhTz1+QM
cYdJ2YBwglKvxdMACR3yX//zYaHeLPSelQ4GmwTh2y+JcV3hyayRkZv5/drDoFID
Ko0oBWAZxerqpPMzq+NmMTl+D4ftEMTZkfjL9ukQ7qHirXgMmreor38/1YSL4nFT
H45AME+nE4LSccbuHqMlL4eMswXBwKYKBPT8QIj3Lv9AS4hmhEpj8a8/aytBvyrY
rtV1zogwH51/VelCkjtydq1gD6HSiA==
=2Sv+
-----END PGP SIGNATURE-----

--6ZUEPrAzetSX6Z5N--

