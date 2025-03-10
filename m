Return-Path: <stable+bounces-122051-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6049BA59DA6
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ADB23A687B
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFC3230BC3;
	Mon, 10 Mar 2025 17:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ssTS0NxK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3FD1B3927;
	Mon, 10 Mar 2025 17:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741627386; cv=none; b=SaKD20zxSjnWubvCtE3K0K+DUnC/1JE2dup41hMnrqHdwOAPzfM5YYxvCIRNlnPn+N8TizxTiZRISvWGW0j062XsaCvu++zHT7WAc8B9bHW3JIsiaCT+t7526J4o1XFBpZd5qgP0pRVjfvDjDjfD3w6MtZikoXEAQ7oBpof9r6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741627386; c=relaxed/simple;
	bh=jlzWbQi6FSX4pGVuiIfsnBv+KXTDLyfqFbdvUJu/6wA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQExZ5lXUELg2xKwrxBImLVu21urib8SrrO44tgFexOFJz7LRQ5hJnEQ9O4els++5+SgnbxaHoxHE0mC7gEvX3jmmQy5SIa2l3yyoyPcuHAvpMsOm4UpolRiZRCT67fcw7+8yXJDsNCFvvp3KBOeKtM4lMIuldyZyQzVuuWHvLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ssTS0NxK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E22F2C4CEEC;
	Mon, 10 Mar 2025 17:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741627386;
	bh=jlzWbQi6FSX4pGVuiIfsnBv+KXTDLyfqFbdvUJu/6wA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ssTS0NxKGh6DuuYColWaTucMp0yRzZVsJCU4D50CjkLlg0ByMw+YfL5+v1lDYEw1B
	 fHPNE0z1rlQOgj3/dGO0N38d2GIYnO02i8vIzJ2Z0LFQ4dJ+mqakOXZQ8XvS5ZQmeC
	 sX6cnLkN5Ta9DnaJmRa/8m4H3MqXiek/rp9QYuuNpD+SrIfnFAgge+ALxwjXF0pL91
	 e6QidE5cndhV4wilVLZ+4Da08gPO2DL0TKg1P+oycokt/brtvErI9lEiEmdHUlBe1R
	 i6ZlE+0wU3bMYpPQCERWje26bLn7+gMu3f8pG+NJZxk87qCOM4NCkdlHTfS4He/od2
	 wUgRDZC3zlFXg==
Date: Mon, 10 Mar 2025 17:23:02 +0000
From: Mark Brown <broonie@kernel.org>
To: Christian Eggers <ceggers@arri.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] regulator: assert that dummy regulator has been
 probed before using it
Message-ID: <3d195bf7-de99-4fe9-87b0-291e156f083c@sirena.org.uk>
References: <20250310163302.15276-1-ceggers@arri.de>
 <20250310163302.15276-2-ceggers@arri.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xdmiKqSCkyIynQfL"
Content-Disposition: inline
In-Reply-To: <20250310163302.15276-2-ceggers@arri.de>
X-Cookie: Dieters live life in the fasting lane.


--xdmiKqSCkyIynQfL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 10, 2025 at 05:33:02PM +0100, Christian Eggers wrote:
> Due to asynchronous driver probing there is a chance that the dummy
> regulator hasn't already been probed when first accessing it.

>  		if (have_full_constraints()) {
>  			r = dummy_regulator_rdev;
> +			BUG_ON(!r);
>  			get_device(&r->dev);
>  		} else {
>  			dev_err(dev, "Failed to resolve %s-supply for %s\n",
> @@ -2086,6 +2087,7 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
>  			goto out;
>  		}
>  		r = dummy_regulator_rdev;
> +		BUG_ON(!r);

This doesn't actually help anything - I'd expect this to trigger probe
deferral.

--xdmiKqSCkyIynQfL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfPH/UACgkQJNaLcl1U
h9BENwf+Pnz6DsxLngVcoZ/7H2J0VK8TSBaKvObZBWu2F1oJrk3GhqO3u+2lhxHF
mbzQSgJLRAm2y4BSd8mbQ8Hnlxz5bQbZJ6pGuOprzgT22Pc57SC0jxRnNBaGhMcf
3tApPPS4FbbV0ZtLa/jVJhRaRAwqwzUlpDtu7Rgp+v8ji8WyrX2NOIq9ZU0/D8Ge
oQq0sBEyMQzw3LYFB1qW3a4XLhWMfBOw8xVcb3NyTPZmNKM7VbtV0cqOvnczanJJ
4r313TnbeRgEEyBhWOrq4xgMkKYYKnQWmDLpSbFURRgQj+DQ8HV+mdmkir85z/Se
2XUWUzjizWHlhlNsJlNXzv85ouxerw==
=nw3j
-----END PGP SIGNATURE-----

--xdmiKqSCkyIynQfL--

