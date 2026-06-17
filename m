Return-Path: <stable+bounces-266678-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8+YYAM5iMmpQzQUAu9opvQ
	(envelope-from <stable+bounces-266678-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 11:03:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA0E697BDF
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 11:03:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266678-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-266678-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 386BE30615F9
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 09:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1D639C002;
	Wed, 17 Jun 2026 09:02:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454A93955E7;
	Wed, 17 Jun 2026 09:02:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781686928; cv=none; b=QnuN5MxzfYLSaKANMf5lI/wS8XlZXCBldx9vkG7lD3g+YdpIM/VvUHOumx7ZDIjRDZR0z9D/4mxhW532bPDwOz5hCevBw/7TKXWUe1GIdUUt4q0t/SILD1RKTxt7yDL7lulo2LWxHvxOHtE8dmwOu8K418lxYnl80EKGGcAmeqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781686928; c=relaxed/simple;
	bh=z/p7pQd+vCs9Kswco7/cAbbNwSgcMe22MOwH0+GDHl0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EUjYWlUicKy2tt8NvZJda/D9UTmqqxAD4qIP38zFahYgyubfmLKrEliKkfWBJjttBJILfm7plsE2rKZj4QC2msH37sDkLScjnPUSWU1WFl/aXSXXhkPk8VZxI0/vhwvOHTz3yZiR7XKV/QkAGg5DVUy2VEkTMHyfH8VUGqqG5R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Received: from [2a02:a03f:8fba:4c00:9e56:df29:1317:540b] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1wZm9t-002tbJ-05;
	Wed, 17 Jun 2026 09:02:05 +0000
Received: from ben by deadeye with local (Exim 4.99.3)
	(envelope-from <ben@decadent.org.uk>)
	id 1wZm9r-00000006g5e-0UdM;
	Wed, 17 Jun 2026 11:02:03 +0200
Message-ID: <3374d4b14a7c54f82fb016ab66f3b262f55145fe.camel@decadent.org.uk>
Subject: Re: [PATCH 5.10 036/342] batman-adv: tp_meter: avoid role confusion
 in tp_list
From: Ben Hutchings <ben@decadent.org.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, stable@kernel.org, Sven Eckelmann
	 <sven@narfation.org>, Sasha Levin <sashal@kernel.org>
Date: Wed, 17 Jun 2026 11:02:02 +0200
In-Reply-To: <20260616145049.935960564@linuxfoundation.org>
References: <20260616145048.348037099@linuxfoundation.org>
	 <20260616145049.935960564@linuxfoundation.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-paXuxt4w3a0PMY2tdaGu"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:a03f:8fba:4c00:9e56:df29:1317:540b
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[decadent.org.uk];
	TAGGED_FROM(0.00)[bounces-266678-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:stable@kernel.org,m:sven@narfation.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ben@decadent.org.uk,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben@decadent.org.uk,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,narfation.org:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,decadent.org.uk:mid,decadent.org.uk:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7DA0E697BDF


--=-paXuxt4w3a0PMY2tdaGu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-06-16 at 20:25 +0530, Greg Kroah-Hartman wrote:
> 5.10-stable review patch.  If anyone has any objections, please let me kn=
ow.
>=20
> ------------------
>=20
> From: Sven Eckelmann <sven@narfation.org>
>=20
> commit ff24f2ecfd94c07a2b89bac497433e3b23271cac upstream.
[...]

No objection, but this is missing from the 5.15 and 6.1 queues.  (It was
already applied to 6.12 and later, and is queued for 6.6.)

Ben.

--=20
Ben Hutchings
Humour is the best antidote to reality.

--=-paXuxt4w3a0PMY2tdaGu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmoyYooACgkQ57/I7JWG
EQkaAhAAtE/nws6KPLiju+z76q7GtJf4MDbImRKm/5SBcNi1uusqPYRkStUvXEpo
KDUPsMryjWnQDQwO48eVNQ7BhNppFDElCgeWmKUzT0dzi8TE9R3n8ca1V7MGIc1i
iy0JpR6TWLVnJZZGG+DHbjrAGS8ngTYvSx2k0+Ci7zjNMKEVXQSd7AgD6nNq42eT
DtvR2iw7AjeQVqq7AyJ8ulaqP9pmsF0Gs6MN+pL/KkulzYFIc9/hrruEmNN3FRGK
NYJSNa4Tq8DArXv2dlohAzJSpRzNHT0sDBvEc1YcDQaew31xjCY7OEJDlb7ngwFx
9lvEI28g7oNG785xVnyENmOkFuKKOyoL/H0KzQt724qbrTn6FdO0z/DavN/jwyym
yDnhmJxo0pwY5NDiZpzdMOlVz6hHXBfj2J6CtG9+8q/FtTh7iixPdewNwVnm3ohX
3WVzWN8r1Upqtzy2ZGYIfoToq8sUXXwkyHvhoY+HEQPnwdIg/qy3tUrv13VjWwWw
qG1Q8XVHftfvoiW4D0QJGFQtyeYWXwb9x+FSmgvscFeNO/0znmaq0s+IFwveDGOr
XFLaLDreft90bMW3qTeXIRYok/2n74FLV1q3psePkhQ7KoOO5YLsXGAxgAU6MKRG
z0NxYzcLaL4H6b/C7b8BoQH7Jpw4lGa0WN081FfqEFkBY4/1TCA=
=K/xe
-----END PGP SIGNATURE-----

--=-paXuxt4w3a0PMY2tdaGu--

