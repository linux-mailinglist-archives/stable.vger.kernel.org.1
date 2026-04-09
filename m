Return-Path: <stable+bounces-235461-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNFlNNXh12lRUQgAu9opvQ
	(envelope-from <stable+bounces-235461-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 19:28:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A303CE210
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 19:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9755330022A8
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 17:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC5F3A9D9D;
	Thu,  9 Apr 2026 17:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzAzUss1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506233368B2;
	Thu,  9 Apr 2026 17:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775755703; cv=none; b=iKGZIxV7nghdbNLk6RXTZPKthhyyV4CVFwPLAAnWS04uIT60sX9JYh1FlIaPvzruLvicmZrAmrT3pk0ZcvI+xJQR8e1PJohoDNUHn/Z8RsWYPWVsS+0Bw9HnAHkN5pd6oO3Q3RMvcMNaTvCJwpuLszrGbuapJ9Dju9kAmQwHtHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775755703; c=relaxed/simple;
	bh=y0PYRGHEEhfr/UPh5rGGI9pOq/mPtSMx5dxO7eD7Pn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I56+Wkfif7ANXbqZskLDDZxZ+KhPWRjzHLWpb0l3OduCdUZuNlCtcGkGqXzNDK3ieU7CdbZWO8pcp280c9vyOH+ucdSf6BD/oEOq2oLd2gLwKkdNa5B7pTZTpWPXhqvnY3aOAy7nm44UFuRKCv+ELX+pJ8XCnwqr7islVsVx8tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzAzUss1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70E85C4CEF7;
	Thu,  9 Apr 2026 17:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775755703;
	bh=y0PYRGHEEhfr/UPh5rGGI9pOq/mPtSMx5dxO7eD7Pn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mzAzUss1f0F1Jh+i2cblS9rT4BDQ3bpDNTkKZY/drShROxFxLbujn3ZIcHfY7uVDr
	 UEdwZHm1gXY1OG8L8KoeCKr6qvNuxqBMjVwqEIdQw/IDvYeRfkOtSCpI/gbhivScTk
	 EZeGL1Wwc0aWuA8BwqJi4AzfRs5xWadvPZSwP5fPI//ePLPi4VlPx1SBreN30MzYP8
	 DnRmTUqw0KKJOrbqEZSRRYjP78S2nF1CxiWKHKG4SwxrfiRPN+yhLK6IXzCz6xQOhv
	 wfCAf6UlkaSTReaXJaDefs8CSZQNHvqGPt4zBrEvwHbQElHbksopjNqgQQtdPe49Ga
	 pUjfrDEvGXT7g==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 36A5D1AC52C8; Thu, 09 Apr 2026 18:27:47 +0100 (BST)
Date: Thu, 9 Apr 2026 18:27:47 +0100
From: Mark Brown <broonie@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, Sunny Luo <sunny.luo@amlogic.com>,
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
Message-ID: <adfhk208Am8lfgES@sirena.co.uk>
References: <20260409120419.388546-1-johan@kernel.org>
 <20260409120419.388546-19-johan@kernel.org>
 <20260409-unease-salaried-8bcb673e9a5a@spud>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NX8g/Nl2V53loNcU"
Content-Disposition: inline
In-Reply-To: <20260409-unease-salaried-8bcb673e9a5a@spud>
X-Cookie: Are we not men?
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235461-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,amlogic.com,aspeedtech.com,kaod.org,upb.ro,broadcom.com,gmail.com,vger.kernel.org,microchip.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sirena.co.uk:mid]
X-Rspamd-Queue-Id: 33A303CE210
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--NX8g/Nl2V53loNcU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 09, 2026 at 05:13:07PM +0100, Conor Dooley wrote:
> On Thu, Apr 09, 2026 at 02:04:17PM +0200, Johan Hovold wrote:
> > Make sure to deregister the controller before disabling underlying
> > resources like interrupts during driver unbind.

> > Fixes: 8596124c4c1b ("spi: microchip-core-qspi: Add support for microchip fpga qspi controllers")
> > Cc: stable@vger.kernel.org	# 6.1
> > Cc: Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>

> Where are you getting these CCs from? I am listed as maintainer for this
> driver but didn't get CCed, only seeing this because I am CCed on
> another patch in the set. Please use get_maintainer.pl.

They're the author of the commit referenced in the Fixes: tag.

--NX8g/Nl2V53loNcU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnX4ZIACgkQJNaLcl1U
h9C62Af/bmwTKGNkq6iZYZN6/trucX+orEfgA4hiHC2hsPSDqS/FpsiyS5D2cmZv
I38Pk2CYhS1cg50wYx7S8BnfhE7713+9XA9cVexzJZ4ZY0lcBMJR4JUg3gSgWMWn
RgPwvYtLSL7Qx9KBHTb8XaIAbcGUwpODnuw6iHrhhvWiRnXq85Ts2QKhN23nJfqe
PrAbyh59xh5Ija9tvS1LvvHy50JTzvnWRxPRPeb46LAs9gFF7kFJRw3zA/5lLW9F
nwRj0JMzaNtjX/fWOG9zyZo0fpVxlwo6+vdTv0pwNO8fhFrhgnLJU+hX/XKxB7H4
J27CrS0qcdfR7kxmobPYXA7BhIYDnw==
=6u6i
-----END PGP SIGNATURE-----

--NX8g/Nl2V53loNcU--

