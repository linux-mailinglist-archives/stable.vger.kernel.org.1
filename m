Return-Path: <stable+bounces-233556-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YICSNy/h1GmZyQcAu9opvQ
	(envelope-from <stable+bounces-233556-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 12:49:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0C93AD33A
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 12:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BA6B3035251
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 10:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2AAD3ACA72;
	Tue,  7 Apr 2026 10:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="WNaDDsmG"
X-Original-To: stable@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0013AB27F;
	Tue,  7 Apr 2026 10:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775558599; cv=pass; b=GKRD+pHa0zUXFjEFK6r8ljyOyfmCzhY3Qci43rLdQJGQDUEfFYnO7s0f+VNvbzAPtJ7CsKjEZLs0GgAo+zCk1s5jup19iIS9sEhtEW1ttryaskEA9xTbMwk63vlVfVnPECZ7qr7LigmlqXB07sOeHghVEzu+hwy+8VuyJCGPEPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775558599; c=relaxed/simple;
	bh=jeYLxlBv9LQ/i9NurS9PNbJ2+JYh8uhTISqYpiHQpkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WYET/zg+YYpydkSLm7tAF1ekdADCOvAQhPN3rhWGpGjA3Tr7/3WfBt53JLccaDwKRSF8eymX41bTDBzxpbqpgjS8EBYdb08qnZDpAi8RZ+pth5Ud1drrzFZ3I1rBjU9TLbAVrzOUMg65w3IvGaWQy36gj/ysil5lK252dGE+CUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=WNaDDsmG; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1775558593; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=OTU2145YSyM41TZX8a5XCtO8dvHta4mAxn3nxtzIyzkOG+nNyzG6MmQLsTxmZfMJi1pkQOVpF2vl2uHIWfuLamNh1I3DejB27WGW3/f+UUatCOhomldPKKcdnHclslqwNQijM6O6iE1DA+AKC9CGoNEk/9O4ZcvOIdMTcct8Ns0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1775558593; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=JgfOJxIUdmJfcSvNPFEzIP+9h7cDv7X+vLvfF4070T4=; 
	b=hr+J8Kd647FRXEW+SAnl7+1KRVgtR0PAK0QHky5dKbHviGka0aS9TnUt+JHbD2fw/P3lmx8qfYYOHwErQcy0MWHJcaOrtkehF8e67fUfTKWNUOXtNF9u2SGwP+sCdSeQtCaTJeDlXIzv+cc2BInOfMuBE0a63iG0B6lmqFEgZSA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775558593;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=JgfOJxIUdmJfcSvNPFEzIP+9h7cDv7X+vLvfF4070T4=;
	b=WNaDDsmGjzlgNgaTX/G4v1JSK57dClbYZOpooPVOFrFilj3H85H9IskWTzJymk8q
	kJTz75ZdqwzwkMIaMDHENJhRjosvZBuXVxMYs3q/sWCPoRSngsHIegC4Ykg6YT/b5y/
	4bQ4dUZ6cfy1KDxBrZFgKGPKchtDaMlTZgGjCXKE=
Received: by mx.zohomail.com with SMTPS id 1775558591568667.3665506010035;
	Tue, 7 Apr 2026 03:43:11 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id F39081824E2; Tue, 07 Apr 2026 12:43:08 +0200 (CEST)
Date: Tue, 7 Apr 2026 12:43:08 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Johan Hovold <johan@kernel.org>
Cc: Stephen Boyd <sboyd@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] clk: rk808: fix OF node reference imbalance
Message-ID: <adTfhqoL1YFA6WMG@venus>
References: <20260407095027.2625516-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rjl5qil7dont7k7e"
Content-Disposition: inline
In-Reply-To: <20260407095027.2625516-1-johan@kernel.org>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.2.1.5.2/275.535.27
X-ZohoMailClient: External
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233556-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[collabora.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebastian.reichel@collabora.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:dkim,collabora.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3B0C93AD33A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--rjl5qil7dont7k7e
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] clk: rk808: fix OF node reference imbalance
MIME-Version: 1.0

Hi,

On Tue, Apr 07, 2026 at 11:50:27AM +0200, Johan Hovold wrote:
> The driver reuses the OF node of the parent multi-function device but
> fails to take another reference to balance the one dropped by the
> platform bus code when unbinding the MFD and deregistering the child
> devices.
>=20
> Fix this by using the intended helper for reusing OF nodes.
>=20
> Fixes: 2dc51ca822e4 ("clk: RK808: Reduce 'struct rk808' usage")
> Cc: stable@vger.kernel.org	# 6.5
> Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Greetings,

-- Sebastian

>  drivers/clk/clk-rk808.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/clk-rk808.c b/drivers/clk/clk-rk808.c
> index f7412b137e5e..5a75b5c91555 100644
> --- a/drivers/clk/clk-rk808.c
> +++ b/drivers/clk/clk-rk808.c
> @@ -153,7 +153,7 @@ static int rk808_clkout_probe(struct platform_device =
*pdev)
>  	struct rk808_clkout *rk808_clkout;
>  	int ret;
> =20
> -	dev->of_node =3D pdev->dev.parent->of_node;
> +	device_set_of_node_from_dev(dev, dev->parent);
> =20
>  	rk808_clkout =3D devm_kzalloc(dev,
>  				    sizeof(*rk808_clkout), GFP_KERNEL);
> --=20
> 2.52.0
>=20

--rjl5qil7dont7k7e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmnU37wACgkQ2O7X88g7
+ppeog/+K5sTPyxHI43qLji+CM+YjUy0KFdAiNT6/sOJ+F+LuovKH4DC+9QgEgJI
b/8hPaGrDgRA2m3/dcp0xFxl2dpSIJk5rmXIfUGX90Ulh7DNurUzfN38AbiHvlMg
RotbWGm0bwTgtPHU3pM54O1gdjhau6VcCSfzZQu9Sz7An4WWpif1MiyHF/iUykaz
sHdLmNUxahxKwWOZ4xHr8pkqKE3awSUBrBaJecEbxcocppHDySz7IAwO+AeLUvab
d91JHNpr656lBoq8zPnSCKO3xZVCyZ4pk/X1lMfqRasbGyNCZsppXZsb3WMMeBmJ
KWIonuXaL3FlB/YRXe3RtPSFiI0kKKvDhakHAZsiio+6bXSf4nghmqcXUAbC6kV4
eVgerUf8hCnaTwnNvKufLzWhlpB6L2S2hKw06FXv0fdYfZQPtXMbqtFae+E0cDDQ
SW92nMwl5kkyFIl3UypY3qFcg84+l1epob+0xgtc1ksCLZ1zxYDoZ8ufwPdW7I6O
IpCIJpaW7SVmOxgdswV4AMfxZ4cFZuLNRC434CGEsfjJo6OIALTSXb9lLNlgk0BU
elNU2h+yEXPB1JyIwyIxGawFahvF2PUhWteos4VhhCdEFJ/vJBGEDn9rXxgUqM0l
TUEWbvWUyz3DBzsy8sniaqXiRqrHVnFdLIPx8BKW3nbfmK3L5xw=
=06rL
-----END PGP SIGNATURE-----

--rjl5qil7dont7k7e--

