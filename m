Return-Path: <stable+bounces-238092-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gG8WNuVm32lSSgAAu9opvQ
	(envelope-from <stable+bounces-238092-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 12:22:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0FA403379
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 12:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 68EAD3021A3F
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 10:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BAD342517;
	Wed, 15 Apr 2026 10:22:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04916337BB5;
	Wed, 15 Apr 2026 10:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776248547; cv=none; b=h02ngr8/ED5CBe2UUy26NkLsOXn4wnHZPelhODCf1+u8x1TICgYe8/y35QI/aZRsQY8rXppXIHTLDgSwxDQpUc2r7Swl7/6kpWfpX/28v0wvv0l11HrjOTJQZsuHygTbyYIaST3Jh6wJEzxOfwYO36BRtkTBoq+uQpwNnjhxVUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776248547; c=relaxed/simple;
	bh=+bsK7pj06MoS1zp0BhM4JtpjlhYpLx975TpfaF/5/mI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j/KU2drhrqRg8S7Zekc/z2X89FosOLtcOfICCkeBOcTFGZ6BnZIj4oiBSaqLcET2zRFq42qpDuavFbX9/mai2IyisEvwnq/v4Yv1w8laaOgTUyahq2+mznvFm+A4te8h/WLlH59YzDaiYgkC7k90SDkJtCqiWDNmUXiFGOZKXFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1wCxO3-004xWm-2p;
	Wed, 15 Apr 2026 10:22:22 +0000
Received: from ben by deadeye with local (Exim 4.99.1)
	(envelope-from <ben@decadent.org.uk>)
	id 1wCxO1-00000003Vny-1fBA;
	Wed, 15 Apr 2026 12:22:21 +0200
Message-ID: <9c5431bb22e2c1470f608a60f872c441c21550ff.camel@decadent.org.uk>
Subject: Re: [PATCH 5.10 153/491] gve: defer interrupt enabling until NAPI
 registration
From: Ben Hutchings <ben@decadent.org.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, Ankit Garg <nktgrg@google.com>, Jordan Rhee	
 <jordanrhee@google.com>, Joshua Washington <joshwash@google.com>, Harshitha
 Ramamurthy <hramamurthy@google.com>, Paolo Abeni <pabeni@redhat.com>
Date: Wed, 15 Apr 2026 12:22:16 +0200
In-Reply-To: <20260413155824.759485387@linuxfoundation.org>
References: <20260413155819.042779211@linuxfoundation.org>
	 <20260413155824.759485387@linuxfoundation.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-leS3f6qP9AucP8AJCK9m"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:578:851f:1502:391e:c5f5:10e2:b9a3
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false
X-Spamd-Result: default: False [-3.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_FROM(0.00)[bounces-238092-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DMARC_NA(0.00)[decadent.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben@decadent.org.uk,stable@vger.kernel.org];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[decadent.org.uk:mid]
X-Rspamd-Queue-Id: 6E0FA403379
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--=-leS3f6qP9AucP8AJCK9m
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-04-13 at 17:56 +0200, Greg Kroah-Hartman wrote:
> 5.10-stable review patch.  If anyone has any objections, please let me kn=
ow.
>=20
> ------------------
>=20
> From: Ankit Garg <nktgrg@google.com>
>=20
> commit 3d970eda003441f66551a91fda16478ac0711617 upstream.
[...]
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
[...]
> @@ -420,6 +422,7 @@ static void gve_remove_napi(struct gve_p
>  	struct gve_notify_block *block =3D &priv->ntfy_blocks[ntfy_idx];
> =20
>  	netif_napi_del(&block->napi);
> +	disable_irq(block->irq);

The disable_irq() belongs before the netif_napi_del().  (The upstream
version got this right.)

Ben.

>  }
> =20
>  static int gve_register_qpls(struct gve_priv *priv)
>=20
>=20

--=20
Ben Hutchings
The obvious mathematical breakthrough [to break modern encryption]
would be development of an easy way to factor large prime numbers.
                                                           - Bill Gates

--=-leS3f6qP9AucP8AJCK9m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmnfZtgACgkQ57/I7JWG
EQkMmRAAiF0kQgxSyE1UWpzGrBJiooGuzVq2iRZVYsN9yPSeUtitdjvA11Xl3rv4
zv9TRK9YtsFVwX7yYGtDguBKi6ShkHrqF8Z7G+Yz+24fGtpE8pkcoP57bmJEgA5M
q0e18WbtRmjNfw8WE73dQ8/yKmRqRtUehoCxt90LPlfXkGQPXJHggLt7YEk4IROj
1KGdpddMFAsXYMctCz+mZI5MfhTsH2UsXGfvb55mWirDueqjDCQ9gXHEFSryvBkr
hAn61ZKMQMwE6Qg6f67Cml9dVTMh4TWjd98DNOdtH82c+LkNJEYRod1w+lO+NuA7
Aocp3f4gAsC+PIcGRdNytlSNmW+l0m7MOjytRZO/FQ7GDW+NDGO2BULdjXTNEn9X
BqCPdzzc66Kkpiu7oAfjqtIxxTNKwCQ8I0907h9ic19s9dVmduV4jALqPPldeBGg
QMgOh/67abT+jeOciwYZOzqlA1Bk5OfifwBiYNcl9vfB5EC1/yVYywVna7gSG2dd
E5fzRYtK9b6xmb6ys0mSx/40PMnOhWfvdO1xZBQXKYrmVb1jbiFU6Rd5Pc7vthbp
7bxThR4JxaISFZRyjIltgI+2WDQf1aD7el8ZFBDdDzZr3YDHQRxhyYq/k5yWLPWK
MPmi0LuqUuI85PK2JdZYI45nAviyUUExHNJBeMTfx1NG9BetbNQ=
=+gU6
-----END PGP SIGNATURE-----

--=-leS3f6qP9AucP8AJCK9m--

