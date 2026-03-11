Return-Path: <stable+bounces-224719-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QChaEI2ZsWnkDAAAu9opvQ
	(envelope-from <stable+bounces-224719-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 17:34:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B528E267692
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 17:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7351B3074F10
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 16:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A65F221FDE;
	Wed, 11 Mar 2026 16:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jyCaaTbY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D08F175A8F;
	Wed, 11 Mar 2026 16:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773246670; cv=none; b=grE9NVflTUraWf9nnOnh1SSzHcoNw2XBMONb1AxoFe8OaCrpj1MJnx1Wy5qZFtnO4oo5GiIwNZPXqfY0y7RS0Tfpoo4G/Dzeo8qsdu3B9Hr/bp2eEeWSx7OV2IpaNcsxgoRh0PkMCVrcZXv799BawLe++pKsX/tvlO7BYXUUo7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773246670; c=relaxed/simple;
	bh=5gLqgNET2CQykKl+nWcPp1qMSx4eBT8J45/8cK7wTms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dYpZvY6RJaprbutM5ZQ3vxEMQ4rO6JfH3avq6N41uKUtsBWY1bZydfc9/xzl7qyNMYlM4hsGmGcjWOIjmx5cbMCQ/kQNuMaCTYH6iW6AH6Py437DECH/npaOXBi8zkpEQfu/jXlwhYUFDar5W9cI0rdtnpp6TcCe/n+SgZUOOug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jyCaaTbY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDDFEC4CEF7;
	Wed, 11 Mar 2026 16:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773246669;
	bh=5gLqgNET2CQykKl+nWcPp1qMSx4eBT8J45/8cK7wTms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jyCaaTbYHVqWDNxfrKYeMc1WRqz3cwfXTadFxI4/nqxkdok9GIJJWtJPxaieb7EEw
	 z5pl8HEKtgNJUa84A+42iPQ+K7ToY66ee74rj/oGSnXz+Yxvlh3vxHzwKT1N+CjbH7
	 oxX2n3p6eFFQc2P8IXSfJ+xv+BoOXwseaz9zHvlfF24miFPRILJ23Q5w97ArE3J4lc
	 sT6eEefA11B4b8DHYKWSKbnTESVh3jgDARZMJxYRme8pbLxtF9FKT9nPuSselE357f
	 yjyh3RbtxgmTSruBY80rqhUqxIS9dcfyJr/yBEqHcTXvFQBO+gQqttj9ME6hdQR4Tx
	 J6ZBoNfupF2nQ==
Date: Wed, 11 Mar 2026 16:31:05 +0000
From: Mark Brown <broonie@kernel.org>
To: gaggery.tsai@intel.com
Cc: linux-sound@vger.kernel.org, patches@opensource.cirrus.com,
	ckeepax@opensource.cirrus.com, mstrozek@opensource.cirrus.com,
	yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH] ASoC: SDCA: Fix NULL pointer dereference in
 sdca_jack_process()
Message-ID: <02cd505e-4635-4d81-8c70-166bbfeaef85@sirena.org.uk>
References: <20260310183829.2907805-1-gaggery.tsai@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6c9P6KPtFWHiOUUt"
Content-Disposition: inline
In-Reply-To: <20260310183829.2907805-1-gaggery.tsai@intel.com>
X-Cookie: When all else fails, EAT!!!
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-224719-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,sirena.org.uk:mid]
X-Rspamd-Queue-Id: B528E267692
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--6c9P6KPtFWHiOUUt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 10, 2026 at 11:38:29AM -0700, gaggery.tsai@intel.com wrote:

> sdca_jack_process() unconditionally dereferences component->card and
> card->snd_card at the top of the function. This causes a NULL pointer
> dereference when the SDCA IRQ handler fires after the ASoC card has
> been torn down.

> +	if (!card || !card->snd_card) {
> +		dev_dbg(dev, "card not yet bound, deferring jack event\n");
> +		return -ENODEV;
> +	}
> +
> +	rwsem = &card->snd_card->controls_rwsem;
> +	kctl = state->kctl;
> +

Don't we still have a time of check/time of use issue here while the
card is being removed - do we do something to stop interrupts being
delivered after the card is unbound?

--6c9P6KPtFWHiOUUt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmxmMgACgkQJNaLcl1U
h9BrVAf+MY+IfOIGBVGCgVzqUMAnT+MSwy3fhHNmEdDbLRWRfbo/pnNrojLJpP72
CUttAWjl3gyE7+1CAawWfUzML9uxtg+zwdNxC2fPdJGd3yv7IzjBHa0HUTvnT6od
dxKyO6Jj7xfEsf27pfUpYqrgaXb7VyhCG3ZXX3+vxJAWYaKqxyQhqYPCD/CeXDLs
EADc68pu3J7YFwsXAlPp4tItQUbZpr/fuemCxb6CXXfPqZ6PxKWEspgugiow0Y0Q
timhr0wZfzykm5FJGLTm6Sl4cWEs6gPvISnblCfOYCIByqqSTevbQWKyWRnzlf5A
NblbZiIOvYcOtL6uSmPAmkEU+CAjoA==
=TLjD
-----END PGP SIGNATURE-----

--6c9P6KPtFWHiOUUt--

