Return-Path: <stable+bounces-261927-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id e/9AENPFJWq2LgIAu9opvQ
	(envelope-from <stable+bounces-261927-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 21:26:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A5EA06515B8
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 21:26:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261927-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-261927-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 59787300C26F
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 19:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F339E314A8D;
	Sun,  7 Jun 2026 19:25:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833DF31E82A;
	Sun,  7 Jun 2026 19:25:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780860339; cv=none; b=kvGUBrH2aR0lz6QRJd1mcSktarcy84A29Wj1L45+qGEGqJ9T6FygHl3dlCibHqfmYVyYoW0AMPWiZiVII2bNt3RDV177nf2TCP2ZXWbKSwe/NNf8sPGWrqExBG5QqRqclxZrn64vqJwywGAKflKj1Z6aY29tMfJbiPVQVcwngAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780860339; c=relaxed/simple;
	bh=kItBkfEBWJQqGzvbrFgrUnnBq92ByuZqORl4sOYCNms=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gKia5P4coR91GTUpjb3P8/GTo7j48xj2JX4UMi7Op8gcZokW84mo1NXAGGb4X1SeC7lO9n+62qZg4Z14+2UoGO7VkpmuRr0vbyyoSnD/FRRbhl9QAvgiOcOwzX3P1Pd5y4b/uxaEqf7Wjpv1PMK4vLb2evyeasmrrx5T91+l4+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1wWJ7g-001Qav-1t;
	Sun, 07 Jun 2026 19:25:28 +0000
Received: from ben by deadeye with local (Exim 4.99.3)
	(envelope-from <ben@decadent.org.uk>)
	id 1wWJ7d-00000001KJX-41PS;
	Sun, 07 Jun 2026 21:25:25 +0200
Message-ID: <2698831f24c7efea34dc4b34d996ff8327ecc206.camel@decadent.org.uk>
Subject: Re: [PATCH 5.10 503/589] crypto: af_alg - Cap AEAD AD length to
 0x80000000
From: Ben Hutchings <ben@decadent.org.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, Yiming Qian <yimingqian591@gmail.com>, Herbert
 Xu	 <herbert@gondor.apana.org.au>
Date: Sun, 07 Jun 2026 21:25:21 +0200
In-Reply-To: <20260530160237.827417882@linuxfoundation.org>
References: <20260530160224.570625122@linuxfoundation.org>
	 <20260530160237.827417882@linuxfoundation.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-LtUq0f8nztjyMe28E3QX"
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[decadent.org.uk];
	TAGGED_FROM(0.00)[bounces-261927-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:yimingqian591@gmail.com,m:herbert@gondor.apana.org.au,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ben@decadent.org.uk,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,gmail.com,gondor.apana.org.au];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben@decadent.org.uk,stable@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,decadent.org.uk:from_mime,decadent.org.uk:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A5EA06515B8


--=-LtUq0f8nztjyMe28E3QX
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2026-05-30 at 18:06 +0200, Greg Kroah-Hartman wrote:
> 5.10-stable review patch.  If anyone has any objections, please let me kn=
ow.
>=20
> ------------------
>=20
> From: Herbert Xu <herbert@gondor.apana.org.au>
>=20
> commit e4c06479d7059888adf2f22bc1ebcf053bf691a2 upstream.

That is currently only in next, so it's unclear to me how this got a
stable backport already.

Ben.

> In order to prevent arithmetic overflows when checking the TX
> buffer size, cap the associated data length to 0x80000000.
>=20
> Reported-by: Yiming Qian <yimingqian591@gmail.com>
> Fixes: 400c40cf78da ("crypto: algif - add AEAD support")
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  crypto/af_alg.c |    2 ++
>  1 file changed, 2 insertions(+)
>=20
> --- a/crypto/af_alg.c
> +++ b/crypto/af_alg.c
> @@ -478,6 +478,8 @@ static int af_alg_cmsg_send(struct msghd
>  			if (cmsg->cmsg_len < CMSG_LEN(sizeof(u32)))
>  				return -EINVAL;
>  			con->aead_assoclen =3D *(u32 *)CMSG_DATA(cmsg);
> +			if (con->aead_assoclen >=3D 0x80000000u)
> +				return -EINVAL;
>  			break;
> =20
>  		default:
>=20
>=20

--=20
Ben Hutchings
For every action, there is an equal and opposite criticism. - Harrison

--=-LtUq0f8nztjyMe28E3QX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmolxaEACgkQ57/I7JWG
EQn7lBAAmJrUI8dv8flen2Q6+YIS0ara84IFs24zYMKGwNNw1HhuKrGhwvTGwnmU
LMGW7VT/ecKvqqHdo/pcPLyVb2cwfev/J2f/WruoBL/x9pnscClZwX5FKoTjWBr7
x1NXWmwgWHIExOZUsQ5n8M3oq5QAsjmwTSw3VtC00Z8yduseJIeDVsA2ueNoC2o7
ZPw3xR/rFZQrzjIJfNWHBWwYOa0u7ALFr/Drog3wWAgxfrNF27LFhc4ju+T+L+Ka
SyxsM5MexEbwsmrqd4zmflMK1O6bqisRysJgP64Bc3NpPWheYpGnHbQnSRO6+jj0
ZaDOb6aLGHfBFR6N4qLfeDz+qXPpEJkIkOsfkOZcQUA90xYc1dbVhGCYIYebwr2V
CTs2OUWKormMrw+U1jm6m5uKIg0ZQFuqR4ptrTPQ2iIZ8OnTKnJ9PE/cVVghYdA5
H6Hkz9G0KEswBSlfQCMRR8oHbLEa0r/oQr7E892AxcfpdXm+++ld86xH2VpPj2Z+
EUOlQt0yClYWsJNqKoVlcMWG1WaT9v3yLe/h50bLvW4bKBS3PQ6GiAXdCTL6lcX9
KtLaF+VjqG3BTqTI5Q82Dy6zJoWQ5N6K1qpCOtr6GkCGC153VbJEPUMkyu0DRFUw
2Vsy6/MdDicao+s0ifjSU3WAGt+ffbJxS9NSqe9OMHFZNpF3yEU=
=oWsG
-----END PGP SIGNATURE-----

--=-LtUq0f8nztjyMe28E3QX--

