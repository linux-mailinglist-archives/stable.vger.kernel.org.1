Return-Path: <stable+bounces-260009-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id z2diEujyH2pjtAAAu9opvQ
	(envelope-from <stable+bounces-260009-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 11:24:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EED81636228
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 11:24:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sang-engineering.com header.s=k1 header.b=aXnUoJc7;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260009-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-260009-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CDDAF30BF88F
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 09:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC7438399A;
	Wed,  3 Jun 2026 09:19:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CCB328B61
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 09:19:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780478367; cv=none; b=VwjA2qt0Ta0U2EbUZurFgJBSTbu2bVTuR8AGdiMGZZpwCJ8H2Z1pn+Y47iVVQmT+nkI9hl9X7Pq6olfnwkNXNo/buYQWthCDoi1dz4L+bLS0drMxzX60ejIBjGQVkitVdvwSUdlPDxS4Gnc3uXy5Welinkup9zjs9cgW6eXokeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780478367; c=relaxed/simple;
	bh=ox5Hfim7OXzdy4CsWYeM5j5AVPQcn2SoPHZtnHyyhxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mBDaDf8ADNwQ7LnAt8pQTgmK2rFgllfyojsG0nfTLvnl32qKlKlkVbKZKlZs1+Ut+6bkKedDICQbRO/cNj5gB94LSd25VdQHvQERZNEZZRA6RRJg6eSQzIxUgZWc8XtXXUz28Wk8E3N5nYTg+g5NKmW+6+UxsEIvBEKAoI5DpPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=aXnUoJc7; arc=none smtp.client-ip=194.117.254.33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=Uq9f
	U7AXRK7LsWpMVeb6SeERHivJR3tgaFKWpY/Pd4g=; b=aXnUoJc7txPDX9GqT8xI
	z+Oye/s8ic9HTiTcQbbax7u04+1LKa9x6Dfafg4xtHOS46QzbhbGqp0kroi9VWv9
	m3mBCz8Ha3O5SLwqDiM0Pzc53SJtqxY8d+4wsdjMUT7KFNVZpkMiVkavq/+l9xx4
	kmZo0sFEt67ADS2eoeHRtMbdeleoZnV7oZhT5E7fikAqfW6Vr1xSycG18MQ6dw8w
	1LhqyCRoRCz30HhDz0SqELN93JdlAxn48wJsD1qG0JpmRN3PoI9x9KkIzQcScq1R
	FWGoaboLkG3a65mBkKn43JGpVUaosIux59BYyb2yiENQvdmqIbB58YGYdtK5cFlX
	kg==
Received: (qmail 3214735 invoked from network); 3 Jun 2026 11:19:20 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 3 Jun 2026 11:19:20 +0200
X-UD-Smtp-Session: l3s3148p1@BtAx7FVThuEujnsK
Date: Wed, 3 Jun 2026 11:19:20 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Johan Hovold <johan@kernel.org>
Cc: Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Phil Reid <preid@electromag.com.au>
Subject: Re: [PATCH v3 02/10] i2c: core: fix hang on adapter registration
 failure
Message-ID: <ah_xmDHy4awrnb0K@ninjato>
References: <20260511143715.729714-1-johan@kernel.org>
 <20260511143715.729714-3-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EeghvUUimabcsKpa"
Content-Disposition: inline
In-Reply-To: <20260511143715.729714-3-johan@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[sang-engineering.com:s=k1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:johan@kernel.org,m:andi.shyti@kernel.org,m:linux-i2c@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:preid@electromag.com.au,s:lists@lfdr.de];
	DMARC_NA(0.00)[sang-engineering.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[wsa@sang-engineering.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[sang-engineering.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wsa@sang-engineering.com,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-260009-lists,stable=lfdr.de,renesas];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,ninjato:mid,sang-engineering.com:dkim,sang-engineering.com:from_mime,sang-engineering.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EED81636228


--EeghvUUimabcsKpa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 04:37:07PM +0200, Johan Hovold wrote:
> Clients may be registered from bus notifier callbacks when the adapter
> is registered. On a subsequent error during registration, the adapter
> references taken by such clients prevent the wait for the references to
> be released from ever completing.
>=20
> Fix this by refactoring client deregistration and deregistering also on
> late adapter registration failures.
>=20
> Fixes: f8756c67b3de ("i2c: core: call of_i2c_setup_smbus_alert in i2c_reg=
ister_adapter")
> Cc: stable@vger.kernel.org	# 4.15
> Cc: Phil Reid <preid@electromag.com.au>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Until tomorrow noon latest, I will have all patches reviewed.


--EeghvUUimabcsKpa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmof8ZgACgkQFA3kzBSg
KbaP3RAAmknIFw83V3UaTbift1VDhN79cbWs2o8w5IJwBA8lomSb5cI1s7BMiJjL
Xna+h2NYJ41kZYpTatMLHPlGNFLydEfyrStDITH2BcTgJdfilBgGRB9sQqw8K09K
EvCBTxKn7OsNPfbQtyAK929UTRhrILe333Pdvw9JVx8AL1wvsRchHF2WklpYgGjt
fuBi6kNrhGh89NdmL748Vxz5aonGTO8w0x+d4n/rDDroRJndKCd8OrEvSSW4mNJj
ZDVIE27dy/l7ekDVGvTZsNQvFrAv2C+WE14oP3KJ0k3aBjChmC60ilMUHa2WBhlX
ag2+gDmyQ0MUdHJOhcfWaQEFpGfFuuEv1ccBuUy0CY7JUAuG2Lpy0CQ20EKd46co
8RgzC4uVON+uQwo9b91nLbVl//hIVJvNHT6dq5V9Ei+r7gyi5wYYFYvSROP19bkW
N+lBi1x0ijNT6Yv6cHtOG91w5uRyGsnQ5SxDtuC1HO5sU+dDWNutIm6jcAZkiB5k
vbTzFVUssDkeebAfZuXXhWhTtTNJlQkoDBiaLxPqx6fpd30KKoz1hi+3zAjuL7X0
Uz1o9lvxeOaVYOp9goaAss+oOqYffGJaKreprCz5imlIJifTj1eIHMgXJmd+JxWY
6tsPl+hdzgS2OftkYJYhBpt2uTXkHN1w+MqZePsBdW/JpV3WTOU=
=DWLg
-----END PGP SIGNATURE-----

--EeghvUUimabcsKpa--

