Return-Path: <stable+bounces-260349-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sfDuDX0+IWpKBwEAu9opvQ
	(envelope-from <stable+bounces-260349-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 10:59:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2926763E422
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 10:59:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sang-engineering.com header.s=k1 header.b=bmVe0QZH;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260349-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260349-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 77C4B305CF26
	for <lists+stable@lfdr.de>; Thu,  4 Jun 2026 08:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDE53D88FC;
	Thu,  4 Jun 2026 08:50:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5821B3E714C
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 08:50:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780563026; cv=none; b=ZbCmqMxYF0XW+VeJfJciECOW7AxQVTf3gqyVQDKlxoz6Y4dcfOh9JXnOF0yl6W5B/M/QR4gPhmpjile97mMsV6OdaSxeAxgHYxWddjjWs13OPkK0efxx3XzAXpDoFROP98XnMhUH/sbPqE6PDv1kL1QEi/mFUATCZDUg1xnFAmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780563026; c=relaxed/simple;
	bh=KqjJAe3ETWh1gIe4NGpbA+GtXNqDE7rgeB0eA1XbZp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hc8ISnFP+EVQH+ozvs2blPvIHkeVVr8wnqYsyEZS0pUbiRttxARVe0aAZUGOhhzxT11CDpfAx6tVA92cZ8gqnTSGRIWyj2Fp4uGiTWeHha5dT9yZ+zIj2yZos49PFrMDrD+jMtQe6JchB7WSVFJ2NCt7r3KEPIheVGuJ3m20nMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=bmVe0QZH; arc=none smtp.client-ip=194.117.254.33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=O3f4
	byr7kkBmRb2f4hBg3QG0cNL48Wc/X98/FKQyD4c=; b=bmVe0QZHKNzubsEYxM/F
	+/dObd2ZOFOsjLevfmU0V2CuTHagOxLvFKMs5rDcfBoTvPdEOjmqb8SFLGbWMH5s
	gP/02/AogtllDbbXnHkS8/5bXDuKKdSUqpzzRFtPJ3sw5k+PHAwerbQc9a+DtgJr
	cdozeLN54I1rvatjAT7JJEETq7SpDll4rxzqEakTy+q13WcVEitTlOFxc25jHm+D
	xetGutL2IrIMTiMElg2lS+3VMskcPqVsWG7cI2OLf/g0z22WRbDfCNyFVliSfJ32
	FGUEIxgJ5/Fcovafljq1u09NfSFyMOZHft8C+psXiMCHvHsVZHJnp1V4w861wWzM
	Gw==
Received: (qmail 3573633 invoked from network); 4 Jun 2026 10:50:23 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 Jun 2026 10:50:23 +0200
X-UD-Smtp-Session: l3s3148p1@yemBomlT4MQujnsi
Date: Thu, 4 Jun 2026 10:50:23 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Johan Hovold <johan@kernel.org>
Cc: Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH v3 08/10] i2c: core: fix adapter deregistration race
Message-ID: <aiE8T746hHDeKZ2r@ninjato>
References: <20260511143715.729714-1-johan@kernel.org>
 <20260511143715.729714-9-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SnHQPAVJrYRK8KrC"
Content-Disposition: inline
In-Reply-To: <20260511143715.729714-9-johan@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[sang-engineering.com:s=k1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:johan@kernel.org,m:andi.shyti@kernel.org,m:linux-i2c@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:khali@linux-fr.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
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
	TAGGED_FROM(0.00)[bounces-260349-lists,stable=lfdr.de,renesas];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux-fr.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2926763E422


--SnHQPAVJrYRK8KrC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 04:37:13PM +0200, Johan Hovold wrote:
> Adapters can be looked up by their id using i2c_get_adapter() which
> takes a reference to the embedded struct device.
>=20
> Remove the adapter from the IDR before tearing it down during
> deregistration (and on registration failure) to make sure its resources
> are not accessed after having been freed (e.g. the device name).
>=20
> Fixes: 35fc37f81881 ("i2c: Limit core locking to the necessary sections")
> Cc: stable@vger.kernel.org	# 2.6.31
> Cc: Jean Delvare <khali@linux-fr.org>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--SnHQPAVJrYRK8KrC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmohPE8ACgkQFA3kzBSg
KbZU5A/7BjNYY1tUuUaZSb2urmYlttbu+GVKWGBjHLchv4OOc3hgwirQQWsj9Iuy
V6t8mjcDigZwX/89VyyeDir89UgtDjxPQ/tfO7ESLrx9u7v4pQVappo3BZH8iR8U
WsmK2lVNKE5BDp839NW5joiBXTN1mlr4CQzN0dP9JaxrwmYRIIqBJPedvQsUce+4
J842bdg2P6Ecdf8+hsiSUqwzmnQlHklpO+dVdNMVUryCYVcRzdxI009k0BmeA8qA
Bzy1NvI4R/tEg5WbGp4HJSS1kU/p8CEGykJN7cfZjK79GBOlokH5vIlGTj0Oce+G
DpuZaLEu8AU+LN+MmCd3lEEeqnTO2diI+LhOl72FOwJZgiDhRlHypXHos46AdAPa
as6pN4XrBiS8NLJUbAg6N0GDJtGDtIDa+nnsA5VfdL+2vcRcop24u20tWwtz24EC
Ygaz336nX0hfnr2+fenSSyB2JENrt0isBASgblcvdze7Z0dqvHZ5l2lNur5PQ8BD
7fmrF0w2cQpYFyXX4k8nzbnZ6LxauaJgJnjkFgQgx/hvD+vo7tzSAUGvC1saxeky
5CtvM4xE+nXLTuO7gikkKuTv2oz1z6rbByFU19SQ18xesbvq+rhRgdy0eIyp0F9h
BpFYpCrzIeBDBPevev/f0X16Ri36DknVqwuDTSOL6AzkFWQcxyo=
=P7Cl
-----END PGP SIGNATURE-----

--SnHQPAVJrYRK8KrC--

