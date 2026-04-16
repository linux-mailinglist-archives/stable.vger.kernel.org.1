Return-Path: <stable+bounces-238313-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAbbEgLl4GlhnAAAu9opvQ
	(envelope-from <stable+bounces-238313-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 15:32:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A47D340EDD3
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 15:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B71513014854
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 13:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3AD3BF686;
	Thu, 16 Apr 2026 13:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jN5L9trE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744B01F192E;
	Thu, 16 Apr 2026 13:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776346337; cv=none; b=nvuXdkD144U4Skh6JE+hN1uW81Yg/E9VV3geYDo1NaVIs0oX2CL2t3ZkkZf5/hLOqavakdiIdrRFdYBHAPSWBw+4S4Lc7YaSeX+S2PoIWtw58/tChxgEe/EchGG7IJhKO316nNjnz1/nQnb6ySEvNlTDs5b8NYqlCNEed8OfPaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776346337; c=relaxed/simple;
	bh=5jsNdZAvPN/aQ7v/9RuVBlZFv683BHPvvfUu6mF73hI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lugV3lUXiQ0AYsvGavi6aIFKNg9YYUhegFalFR+YdJG+OquNdqHnkYXtvgvWztfwDhDmhlj/YXeelpHmIjdHAG0vS713eZOz8Q5pszMHxox1OaukscxssgO0Cvj2fGS8gIGgnTrhEabbmjcNUMyiavnSO3O7QtzAIFu6WVyEvDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jN5L9trE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93233C2BCAF;
	Thu, 16 Apr 2026 13:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776346337;
	bh=5jsNdZAvPN/aQ7v/9RuVBlZFv683BHPvvfUu6mF73hI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jN5L9trElGou4obH5qOghM3n6P7ClcTzG3YlITNqughPsg6inyd+UhrYDn6V0Tt7A
	 wwI1iFhkAym3xTYfgJVeISrLNtYzfsVxvitCY51WeF7sUCLBvSm0RTCorAzpXBNtjx
	 HXInbIbidFRVsuKMclvwIFQqbCGjN0k2m8f2JJYuRFcyu5UaJpUYNaucQ3rUCgz0n8
	 ikzATsi+Fc3vLWEnpOn1vQ9n4KPm3IsYuwgfTST9Kc2mt6p+JBclpX9Jo8VBQlyB0S
	 XQ/cffFP6xgQnN7dByUI0DW0ByPq1D/wm3DMmeOmO+5TnkepuhiOs7jymCa+2XoAga
	 rKPpNITXZoIWg==
Date: Thu, 16 Apr 2026 14:32:13 +0100
From: Conor Dooley <conor@kernel.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] soc: microchip: mpfs-sys-controller: fix reference leak
 on failed device registration
Message-ID: <20260416-wish-impatient-f69a28478f89@spud>
References: <20260415181635.3699592-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FonTAm9wP9KVSW0Z"
Content-Disposition: inline
In-Reply-To: <20260415181635.3699592-1-lgs201920130244@gmail.com>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238313-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A47D340EDD3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--FonTAm9wP9KVSW0Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2026 at 02:16:35AM +0800, Guangshuo Li wrote:
> When platform_device_register() fails in mpfs_sys_controller_probe(),
> the embedded struct device in subdevs[i] has already been initialized by
> device_initialize(), but the failure path only reports the error and
> does not drop the device reference for the current platform device:

Patch looks reasonable, but not urgent so I will pick it up after -rc1.
Looking around it doesn't look like this will be a unique patch, so for
other I would suggest that...

>   mpfs_sys_controller_probe()
>     -> platform_device_register(&subdevs[i])
>        -> device_initialize(&subdevs[i].dev)
>        -> setup_pdev_dma_masks(&subdevs[i])
>        -> platform_device_add(&subdevs[i])

=2E..you redo this section, as it's not clear to me what this actually
is trying to communicate. AFAIU, what's wrong here is that
device_initialize() calls kobject_init(), which needs a kobject_put()
to clean up after it on failure. But this code snippet doesn't tell me
that, I had to go look for where the reference count was actually
incremented.

>=20
> This leads to a reference leak when platform_device_register() fails.
> Fix this by calling platform_device_put() after reporting the error.
>=20
> The issue was identified by a static analysis tool I developed and
> confirmed by manual review.
>=20
> Fixes: d0054a470c339 ("soc: add microchip polarfire soc system controller=
")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/soc/microchip/mpfs-sys-controller.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/soc/microchip/mpfs-sys-controller.c b/drivers/soc/mi=
crochip/mpfs-sys-controller.c
> index 10b2fc39da66..404c31daf459 100644
> --- a/drivers/soc/microchip/mpfs-sys-controller.c
> +++ b/drivers/soc/microchip/mpfs-sys-controller.c
> @@ -168,8 +168,10 @@ static int mpfs_sys_controller_probe(struct platform=
_device *pdev)
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(subdevs); i++) {
>  		subdevs[i].dev.parent =3D dev;
> -		if (platform_device_register(&subdevs[i]))
> +		if (platform_device_register(&subdevs[i])) {
>  			dev_warn(dev, "Error registering sub device %s\n", subdevs[i].name);
> +			platform_device_put(&subdevs[i]);
> +		}
>  	}
> =20
>  	dev_info(&pdev->dev, "Registered MPFS system controller\n");
> --=20
> 2.43.0
>=20

--FonTAm9wP9KVSW0Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaeDk2QAKCRB4tDGHoIJi
0uYlAP9jlC5TikxBBsshD3f6NCvCqkS5wpSKKXQ+4PDgxaTRsQEAmdxEMQNOD5Rz
WSFeZN4GxrQyxQZbhSI/TV4vWuk9UA0=
=cUvj
-----END PGP SIGNATURE-----

--FonTAm9wP9KVSW0Z--

