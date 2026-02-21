Return-Path: <stable+bounces-217653-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKfCAe4TmmmeYQMAu9opvQ
	(envelope-from <stable+bounces-217653-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 21:22:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5291916DCE4
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 21:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FAB6302D966
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 20:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC167368291;
	Sat, 21 Feb 2026 20:22:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0229F36828A;
	Sat, 21 Feb 2026 20:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771705321; cv=none; b=d47EdjH1kWRMod/Jx4oi22+qpXO3qO2zxK/4K/ZCaWCtnCxya9qUjSipkyU/sFcMQ3T+3wTvFwbf8Fr+/KOwryGo7rBIgsLYAv6rDIsOYCEdiKVtn7k8FshG1aYdk3DL5b0URcsVWqXb5BLKFibPY8Y/YgzQZwKM6pV840xSN4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771705321; c=relaxed/simple;
	bh=vzhOmEvFaSJaDBrwFGbbvRvfotWjUvH6FzZiWbW1yVs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fKWvO6r+71R+kJzpUFLginj8o+VmFHF1NiaGhSPx9ASRfaFYvOX1hpsHEbWu+61sWeUdbCiFeTG/X831H7Z3lcqqsSCSyGpwk5y6LxvwVteggkVNKtaH+KPXb9X27OgQ1ldh7GLod3x1DoEUWYmkjDUvcVFvVsPazOJCtLXpwYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1vttU5-001zor-1N;
	Sat, 21 Feb 2026 20:21:48 +0000
Received: from ben by deadeye with local (Exim 4.99.1)
	(envelope-from <ben@decadent.org.uk>)
	id 1vttU3-00000000PRz-12OF;
	Sat, 21 Feb 2026 21:21:47 +0100
Message-ID: <1a11526ae3d8664f705b541b8d6ea57b847b49a8.camel@decadent.org.uk>
Subject: Re: [PATCH 5.10 02/41] ARM: 9468/1: fix memset64() on big-endian
From: Ben Hutchings <ben@decadent.org.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, Thomas =?ISO-8859-1?Q?Wei=DFschuh?=	
 <thomas.weissschuh@linutronix.de>, "Matthew Wilcox (Oracle)"	
 <willy@infradead.org>, Arnd Bergmann <arnd@arndb.de>, "Russell King
 (Oracle)"	 <rmk+kernel@armlinux.org.uk>
Date: Sat, 21 Feb 2026 21:21:42 +0100
In-Reply-To: <20260209142256.889650945@linuxfoundation.org>
References: <20260209142256.797267956@linuxfoundation.org>
	 <20260209142256.889650945@linuxfoundation.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-X4Nl9z/dMpOFTgxhFOy3"
User-Agent: Evolution 3.56.2-8 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:578:851f:1502:391e:c5f5:10e2:b9a3
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.06 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DMARC_NA(0.00)[decadent.org.uk];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217653-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable,kernel];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben@decadent.org.uk,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.971];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:email]
X-Rspamd-Queue-Id: 5291916DCE4
X-Rspamd-Action: no action


--=-X4Nl9z/dMpOFTgxhFOy3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-02-09 at 15:24 +0100, Greg Kroah-Hartman wrote:
> 5.10-stable review patch.  If anyone has any objections, please let me kn=
ow.
>=20
> ------------------
>=20
> From: Thomas Weissschuh <thomas.weissschuh@linutronix.de>
>=20
> commit 23ea2a4c72323feb6e3e025e8a6f18336513d5ad upstream.
>=20
> On big-endian systems the 32-bit low and high halves need to be swapped
> for the underlying assembly implementation to work correctly.

Now it's broken on little-endian, because CONFIG_CPU_LITTLE_ENDIAN was
only introduced in 5.19.

For 5.10 and 5.15, please revert this or change the condition to
!IS_ENABLED(CONFIG_CPU_BIG_ENDIAN).

Ben.

>=20
> Fixes: fd1d362600e2 ("ARM: implement memset32 & memset64")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  arch/arm/include/asm/string.h |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> --- a/arch/arm/include/asm/string.h
> +++ b/arch/arm/include/asm/string.h
> @@ -36,7 +36,10 @@ static inline void *memset32(uint32_t *p
>  extern void *__memset64(uint64_t *, uint32_t low, __kernel_size_t, uint3=
2_t hi);
>  static inline void *memset64(uint64_t *p, uint64_t v, __kernel_size_t n)
>  {
> -	return __memset64(p, v, n * 8, v >> 32);
> +	if (IS_ENABLED(CONFIG_CPU_LITTLE_ENDIAN))
> +		return __memset64(p, v, n * 8, v >> 32);
> +	else
> +		return __memset64(p, v >> 32, n * 8, v);
>  }
> =20
>  #endif
>=20
>=20

--=20
Ben Hutchings
Who are all these weirdos? - David Bowie, on joining IRC

--=-X4Nl9z/dMpOFTgxhFOy3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmmaE9YACgkQ57/I7JWG
EQnltg/+Kjdukktt3i+v5hb4fe6oRhnhKA3zsPWYEgMEVq8i09u9366O6hFz++pj
7ARXDSJ9G68RugsQSbrnxXwLOAhtfCNg7mVrtgUPzlNyVrpd3Mmu3qAVrnAvkMjy
8vZkdxRVTQPhEJ9L5secO5wBq+FmsFuWnyLWmRJSslZdaKP8qVjyhdjGC+PQkGKy
VvOkqoyvbk7D5aFdVVTiUsvqM0s6vI5C8BkDSTwaJajuRsMmz9/sbopyCwHiVBuf
rHSPLTJSznR2kTmWLAX+b33VRMHcVUZDRb1+ZsjxmL3XzUJ85LLm356pbhdeUNmP
rwuRGrHxm7RAtK+nUg5glEln53MmdBo69wvVC1uJZHtnqN77VWEV7G3xQFyTGmXR
gkzihu+EEUAYtTlc43nL0oCkQAuwbwaG+N0lAu2wh69Fbs5KqNNbpjvL9JE0KkqB
oL2zoUV5mdZR6QfKJntNX+5lMydXqmos7lq3wD6ePdN7I7iBgyjr5P6N6rWMejE1
aO63er2fGGFB82ITKAli3BEzp9Q1gxiptv+O+nFyH061r1wI8ky1CSQD83w/VgyT
WxEA5uJ9da/88KZc00YTjLp3wozk3RdVHL+Ueu+g4h6yk2BD/oneqwyQKVYVDjG+
6HUwvA6Z9IpLQuTGRayc4tr7ZY9LGXE8zIZGSfxY2hU0I8Kgvok=
=dSyq
-----END PGP SIGNATURE-----

--=-X4Nl9z/dMpOFTgxhFOy3--

