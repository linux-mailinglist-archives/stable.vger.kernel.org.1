Return-Path: <stable+bounces-224899-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Ew0Ncz4smmLRAAAu9opvQ
	(envelope-from <stable+bounces-224899-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 18:33:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F08427693D
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 18:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D21FC30219FB
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 17:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329A53D3494;
	Thu, 12 Mar 2026 17:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="if1dvv2I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C2638422D;
	Thu, 12 Mar 2026 17:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773336778; cv=none; b=VIHP7GWb3zaaJ2GaRA6Ryp+MNh5XZTTHjq1ghxVgFJyaRiphdxNjcx0fvgir0xK7fXlUIhEMbPWAcTuqyZcSZPJ0OeiuCpX8RLmZESga/y58op5L3QPrx7tpi8ShadVitdYq8G4V2PcAtMkEJJDKyMhgnHa2hmLB8tIXPna8j9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773336778; c=relaxed/simple;
	bh=6OZupW+8nCENOIwIlE2yxZg29RsbpuXi1ug0crETM6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s5Gad1/YvQx2VWMEdWleLUS3jP8eWNBJvu8ja/VOalDiVviyomwYpKIJ3HJUmWwzpbkvZ7GR+A/BSspK2L9R7JxtXFNKulO2+Oby9ywno/H7S0SlAOG69884d/j4iFlufbmAPModKl8tIwNEGeXpQtneiLXQFlxK4bEnhWsI/UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=if1dvv2I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FF47C4CEF7;
	Thu, 12 Mar 2026 17:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773336777;
	bh=6OZupW+8nCENOIwIlE2yxZg29RsbpuXi1ug0crETM6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=if1dvv2IVdmGYizlvi2zGkJ6M4QxH28nxsTzCwb4ugwEeOYw5pkkfHcBhrGIl3CFk
	 nsSv7rTmTbtt8ylDPmq3DgdfLl4Zvq38rCmV/fUfV+oNj6x31dqxRvGvRH+SI4BOPH
	 Byhr+oW2cMCGYNia9KIqcvHwnh2Ji2NcufUXJuyf5txaV8sIj92njqyUb/t50Kf++T
	 XgyH9GB6XP2+oUxciBV7FPM9Ozwbkc8qLlGl98J9OqV+D5xD3nRaZPezI2GBDP9hLB
	 C5HBLXk/Kfha6o/vsgwnA/MvGgy79tmVuuL+kI8ZxvdEUV6wCEXKBtEWwJJeF3RnTB
	 Lt3nwZ2mMtmkA==
Date: Thu, 12 Mar 2026 17:32:53 +0000
From: Mark Brown <broonie@kernel.org>
To: gaggery.tsai@intel.com
Cc: linux-sound@vger.kernel.org, ckeepax@opensource.cirrus.com,
	mstrozek@opensource.cirrus.com, yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: SDCA: Fix NULL pointer dereference in
 sdca_jack_process()
Message-ID: <ef001910-611a-40b4-b7b6-c5dc7d784701@sirena.org.uk>
References: <20260310183829.2907805-1-gaggery.tsai@intel.com>
 <20260312143218.2008222-1-gaggery.tsai@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0Vas4UN21RkwjNkw"
Content-Disposition: inline
In-Reply-To: <20260312143218.2008222-1-gaggery.tsai@intel.com>
X-Cookie: He who hesitates is last.
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-224899-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sirena.org.uk:mid,intel.com:email]
X-Rspamd-Queue-Id: 7F08427693D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--0Vas4UN21RkwjNkw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 12, 2026 at 07:32:18AM -0700, gaggery.tsai@intel.com wrote:

> sdca_jack_process() unconditionally dereferences component->card and
> card->snd_card at the top of the function. This causes a NULL pointer
> dereference when the SDCA IRQ handler fires after the ASoC card has
> been torn down.

Please don't send new patches in reply to old patches or serieses, this
makes it harder for both people and tools to understand what is going
on - it can bury things in mailboxes and make it difficult to keep track
of what current patches are, both for the new patches and the old ones.

> +static void class_function_component_remove(struct snd_soc_component *component)
> +{
> +	struct class_function_drv *drv = snd_soc_component_get_drvdata(component);
> +	struct sdca_class_drv *core = drv->core;
> +
> +	sdca_irq_disable(drv->function, core->irq_info);
> +}

This is an ASoC level remove so the driver itself is never unbound but
I'm not seeing anything that undoes this disable so an ASoC level rebind
will leave the interrupt disabled.  Do we need to start off with the
interrupt disabled and only enable it during bind so we can have the
bind/unbind be symmetric?

--0Vas4UN21RkwjNkw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmy+MQACgkQJNaLcl1U
h9DCAwf+ONMW8/5VxjsKw7Nl6Bha6fc8e+m1Ewb+sp0QFFs50sZ0tochtu7uuFA7
Vg4Kp0Cz1vzniruRLyOcmuo+JhXLV4Q4BhAfYvdCS6LACYsT17/s6wHBr2oW/Cgl
SIsxJkLvZ3vc3Rfhwrbed15hKj8mFyyrUjJ9tez0/hH6w7yb5MvNf1TTRPrW98OM
oNFaZZSG7PAjuHtX+Haf7o7L+W0uNxxFW0W5qwUULIhh8hjamTzyjcAFcHjWAooc
XEvm+Dlq+Jk5t1tCRBDktnLhkNpTMUfZyOAVWFgd/eqv2sL5ljsT4z4ZWjtIw11r
b6lwOzB+bguQ78dQXYBKDn+xBDKlPQ==
=3z5r
-----END PGP SIGNATURE-----

--0Vas4UN21RkwjNkw--

