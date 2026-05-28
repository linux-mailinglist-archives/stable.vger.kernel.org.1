Return-Path: <stable+bounces-254897-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GB1yNbErGGqwfAgAu9opvQ
	(envelope-from <stable+bounces-254897-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:49:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DD25F1882
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8BE78301A0BA
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 11:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1533D330B;
	Thu, 28 May 2026 11:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="FsOrJlAj"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FA931E848;
	Thu, 28 May 2026 11:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779968940; cv=none; b=U7e7wVVUUzzcBTdpJBEROMgD4EQC5G3DdxtA6gZ2jSW5BNVh8JivYE9vcTDWpOcICg19T9DY6wsXSMZaGmqCTwQHh1uTZcy04rGanWMGW5RfAtMpWjZYDaOyK2lNU19Ke/o3WOHpS7edQMl1butSTn/S68hIPEyCc2EQ1UpprPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779968940; c=relaxed/simple;
	bh=eSXo8IE48/tHB0cYAMy+I+WmKhe7bqq5D9ZhZhdiBM0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UH+mbE8AIDkYcSuCJFxsKcXwQideevMu0JEBbG6Y+ySVANr2coCiE6Q+gI3AGgyF05QXq8E+rnzWq8LrHIq6edHh0hOJBFvp4Pw14du15MoWZWRlhwspg+k+9auIUSYGDMciFgei4UVa021QB1z2RX6Gt8xdzQhL8+KzcuNwdW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=FsOrJlAj; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=abI9NJHgTWUu7tD5+NeIjshvFD1KUOMKg6Z9ql/UO7Q=; b=FsOrJlAjieNFlMdTQo1ZlejoPc
	OjyojR2/8j+ieIsT+yY8x8FN+djRRWTeVX1cCJGsks6PkqwJBlXsbWiLm9ihfJk0d3ueG8PmcT5UU
	sFs8bwDq5ay5MIVHmdStXp6K1ft4Ms2ygE7ay3EL0cakW/h22LtIELF72XBF8OwH9OUeChFa8b/n1
	QbX2CwaXT8ORz/U2K7L5R8Ac19s7S9jlVDZGEedx0bL5PSFiIqsZdO5KQkc0BquVW2ej8+WeKJgbm
	iXRZTKtTgyQVktWgLI26vcNXtzWI2en6+WwmmEp+2/1/Sk5xqPoR7kY8Mkn+3jlEGWgR9rQraq6ux
	EyTNJ+cg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benh@debian.org>)
	id 1wSZEL-0040op-1P;
	Thu, 28 May 2026 11:48:54 +0000
Message-ID: <a26366c3a1b70db57fc27f2ad4ef4f21185ebc9c.camel@debian.org>
Subject: Re: [PATCH 5.15.y] net: usb: lan78xx: Fix double free issue with
 interrupt buffer allocation
From: Ben Hutchings <benh@debian.org>
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: netdev@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>, John
 Efstathiades <john.efstathiades@pebblebay.com>, Jakub Kicinski
 <kuba@kernel.org>, Wenshan Lan	 <jetlan9@163.com>
Date: Thu, 28 May 2026 13:48:43 +0200
In-Reply-To: <20260323080021.1172236-1-jetlan9@163.com>
References: <20260323080021.1172236-1-jetlan9@163.com>
Organization: Debian
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-UtWHfZcUWAnqFwI5vB2w"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Debian-User: benh
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,pengutronix.de,pebblebay.com,kernel.org,163.com];
	TAGGED_FROM(0.00)[bounces-254897-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benh@debian.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:email,pebblebay.com:email,msgid.link:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 80DD25F1882
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--=-UtWHfZcUWAnqFwI5vB2w
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Please also apply this backport to 5.10.

Ben.

On Mon, 2026-03-23 at 16:00 +0800, Wenshan Lan wrote:
> From: Oleksij Rempel <o.rempel@pengutronix.de>
>=20
> [ Upstream commit 03819abbeb11117dcbba40bfe322b88c0c88a6b6 ]
>=20
> In lan78xx_probe(), the buffer `buf` was being freed twice: once
> implicitly through `usb_free_urb(dev->urb_intr)` with the
> `URB_FREE_BUFFER` flag and again explicitly by `kfree(buf)`. This caused
> a double free issue.
>=20
> To resolve this, reordered `kmalloc()` and `usb_alloc_urb()` calls to
> simplify the initialization sequence and removed the redundant
> `kfree(buf)`.  Now, `buf` is allocated after `usb_alloc_urb()`, ensuring
> it is correctly managed by  `usb_fill_int_urb()` and freed by
> `usb_free_urb()` as intended.
>=20
> Fixes: a6df95cae40b ("lan78xx: Fix memory allocation bug")
> Cc: John Efstathiades <john.efstathiades@pebblebay.com>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Link: https://patch.msgid.link/20241116130558.1352230-1-o.rempel@pengutro=
nix.de
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> [ Adjust context. Make the function usb_alloc_urb() call before
> kmalloc(). ]
> Signed-off-by: Wenshan Lan <jetlan9@163.com>
> ---
>  drivers/net/usb/lan78xx.c | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
> index dbd9bd23e60c..b160d7a94f32 100644
> --- a/drivers/net/usb/lan78xx.c
> +++ b/drivers/net/usb/lan78xx.c
> @@ -4105,29 +4105,30 @@ static int lan78xx_probe(struct usb_interface *in=
tf,
> =20
>  	period =3D ep_intr->desc.bInterval;
>  	maxp =3D usb_maxpacket(dev->udev, dev->pipe_intr, 0);
> -	buf =3D kmalloc(maxp, GFP_KERNEL);
> -	if (!buf) {
> +
> +	dev->urb_intr =3D usb_alloc_urb(0, GFP_KERNEL);
> +	if (!dev->urb_intr) {
>  		ret =3D -ENOMEM;
>  		goto out3;
>  	}
> =20
> -	dev->urb_intr =3D usb_alloc_urb(0, GFP_KERNEL);
> -	if (!dev->urb_intr) {
> +	buf =3D kmalloc(maxp, GFP_KERNEL);
> +	if (!buf) {
>  		ret =3D -ENOMEM;
> -		goto out4;
> -	} else {
> -		usb_fill_int_urb(dev->urb_intr, dev->udev,
> -				 dev->pipe_intr, buf, maxp,
> -				 intr_complete, dev, period);
> -		dev->urb_intr->transfer_flags |=3D URB_FREE_BUFFER;
> +		goto free_urbs;
>  	}
> =20
> +	usb_fill_int_urb(dev->urb_intr, dev->udev,
> +			 dev->pipe_intr, buf, maxp,
> +			 intr_complete, dev, period);
> +	dev->urb_intr->transfer_flags |=3D URB_FREE_BUFFER;
> +
>  	dev->maxpacket =3D usb_maxpacket(dev->udev, dev->pipe_out, 1);
> =20
>  	/* Reject broken descriptors. */
>  	if (dev->maxpacket =3D=3D 0) {
>  		ret =3D -ENODEV;
> -		goto out5;
> +		goto free_urbs;
>  	}
> =20
>  	/* driver requires remote-wakeup capability during autosuspend. */
> @@ -4135,7 +4136,7 @@ static int lan78xx_probe(struct usb_interface *intf=
,
> =20
>  	ret =3D lan78xx_phy_init(dev);
>  	if (ret < 0)
> -		goto out5;
> +		goto free_urbs;
> =20
>  	ret =3D register_netdev(netdev);
>  	if (ret !=3D 0) {
> @@ -4157,10 +4158,8 @@ static int lan78xx_probe(struct usb_interface *int=
f,
> =20
>  out6:
>  	phy_disconnect(netdev->phydev);
> -out5:
> +free_urbs:
>  	usb_free_urb(dev->urb_intr);
> -out4:
> -	kfree(buf);
>  out3:
>  	lan78xx_unbind(dev, intf);
>  out2:

--=20
Ben Hutchings - Debian developer, member of kernel, installer and LTS
teams

--=-UtWHfZcUWAnqFwI5vB2w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmoYK5sACgkQ57/I7JWG
EQm27A/6At1lLFLVXuZvc6gNhi8n8TILztarPpb+ZCeqlragnVx/UR4fugD+61uk
1WDqyeHp4lSUhz2ks/IXab0DgVmhLT6k74Y5hGYOcU9s8JJ/aI2+gFWwpRb9zHPX
hJJs4bydKnHhftf7/6VuUrkdR2O23WMyi3qCA2K0+kXXXG6x4xHGUQUsGOneCVBL
WTmpw9oFVliPnst7UeEfCyuFj3GuaY6DNga/EFBgsoqNZJ/G/JQWBYG8KttJmHl4
IMNbmvNsckCiFNbSLBeFHtij1il88ri4Me3VODKy/qKptioSdunT7uVgCEtuktvN
OdBbSexOuRJcNpP1U+nfCc9yeaKnPJE89c6M2WCD9hCDFozdBj2QliqPWoJ+JJcW
f9NUUERNOd8gCPXd6G07K7M7MQ1pJzEIhI6Bw8RPdIdempMo4T+9YnkjQ2URkL94
UVGf1bRXyxo+fSS70KLs7ZnZCMDKZQSkbrqq3nVSB0nXQkpcSpmsXg3HsUlxLgHc
XWBeESpK/pgcDUA0Qg19s7eWdwY1zhTs5LjdB40mjTcPeR++J3BrBwDnTaFUMDb+
O4ksPISGN/gxioZvlLJXL9TlG/4u9ljy4vhLH4is3Q/OEvMdPdVuQqUrxnaixoSy
LzxB10Tuayt6KYmydgNN0xmnMtbsehzESEBCnfANLw4FRyxSixg=
=pExS
-----END PGP SIGNATURE-----

--=-UtWHfZcUWAnqFwI5vB2w--

