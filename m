Return-Path: <stable+bounces-235445-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDqGJqzR12mrTAgAu9opvQ
	(envelope-from <stable+bounces-235445-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 18:19:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9643CD91F
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 18:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B5BE83063A32
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 16:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423863DCD9C;
	Thu,  9 Apr 2026 16:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ri60OXii"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044333BFE3C;
	Thu,  9 Apr 2026 16:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775751192; cv=none; b=SaLx81XDz6fS62LLX4+4O70yzrbua17giS+xKUn+21Mk6337AidiiUt6P+ChK1cLEuUqvIeTaruAXhHDXe3nZqkp0GGefTlye+IwdWpKfj1akR06d+p0x+tuK7+KO/qShart8R2y+T+6Jgb6k9L9acWhi/pCh+Gots05+cESzxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775751192; c=relaxed/simple;
	bh=FLJyHNJP7R51PEKD4gqB+LHcMo0mqxnbMmq8Eu3DxB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQr9ITk5w7utCJr9VRu8BeScwT5+MldV1U5o7J7QGf2dm/e8VCAxDFBxtNlNerDoJjI4N3hFK1D74Ldo3AutF4qonknCU48MRXID0LyqlSK5TjeL7KnRDFlmOXq7Qa57zxeXJ6Ti6a4ceQuuFoBUI8l8Nih4tsj7E+k17VXqV9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ri60OXii; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48FD3C4CEF7;
	Thu,  9 Apr 2026 16:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775751191;
	bh=FLJyHNJP7R51PEKD4gqB+LHcMo0mqxnbMmq8Eu3DxB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ri60OXiiB6rVtTVRAwHJMgrVXQIuD/XeFEoGLRZO/VLTlJDfRGjixU6zqARun5M1A
	 QhcVLdHjvv11YwHy8s6C6mNimr+gKu4tPhilHaSk7TyYBEiW4I1pnIcCjGnGP6/pKY
	 VUORBAo0ieOl0Ydd0MNyD/CPZcByLT8HsZVecd6I+CAQza64JOmXSkTSRceqtj7vz8
	 5kOq8MnlnRpFiY9Cvh7R5HFNXKDCmKConVFHaBqly+Ak+vW0Q8N7VUEOvskRuT77tt
	 +9EIclkYJ7/LX0Yu9VOzGGMKvH5jN+iigewn0bB6p8w98ipUUt+/gdH05VlUe3oYLm
	 ieo3P5KYmfcvg==
Date: Thu, 9 Apr 2026 17:13:07 +0100
From: Conor Dooley <conor@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Sunny Luo <sunny.luo@amlogic.com>,
	Xianwei Zhao <xianwei.zhao@amlogic.com>,
	Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
	=?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
	Radu Pirea <radu_nicolae.pirea@upb.ro>,
	William Zhang <william.zhang@broadcom.com>,
	Kursad Oney <kursad.oney@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>
Subject: Re: [PATCH 18/20] spi: microchip-core-qspi: fix controller
 deregistration
Message-ID: <20260409-unease-salaried-8bcb673e9a5a@spud>
References: <20260409120419.388546-1-johan@kernel.org>
 <20260409120419.388546-19-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+54c3JQ+Sk1k7w4z"
Content-Disposition: inline
In-Reply-To: <20260409120419.388546-19-johan@kernel.org>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235445-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[kernel.org,amlogic.com,aspeedtech.com,kaod.org,upb.ro,broadcom.com,gmail.com,vger.kernel.org,microchip.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0C9643CD91F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--+54c3JQ+Sk1k7w4z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 09, 2026 at 02:04:17PM +0200, Johan Hovold wrote:
> Make sure to deregister the controller before disabling underlying
> resources like interrupts during driver unbind.
>=20
> Fixes: 8596124c4c1b ("spi: microchip-core-qspi: Add support for microchip=
 fpga qspi controllers")
> Cc: stable@vger.kernel.org	# 6.1
> Cc: Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>

Where are you getting these CCs from? I am listed as maintainer for this
driver but didn't get CCed, only seeing this because I am CCed on
another patch in the set. Please use get_maintainer.pl.

> Signed-off-by: Johan Hovold <johan@kernel.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--+54c3JQ+Sk1k7w4z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCadfQEwAKCRB4tDGHoIJi
0rqQAP4w2nQLA5KANNj55Jyxgim0ziwXaZrES8uu9RzKWskNqwD/QfLxBMvB2mWA
EjpLwd22q5E7Qms1zujQZoRucpykwwE=
=f2Yu
-----END PGP SIGNATURE-----

--+54c3JQ+Sk1k7w4z--

