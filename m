Return-Path: <stable+bounces-235572-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPJ9N16Z2GkgfggAu9opvQ
	(envelope-from <stable+bounces-235572-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 08:31:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 374123D2CAA
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 08:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A01D3026C33
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 06:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369FC371896;
	Fri, 10 Apr 2026 06:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EglVSSo0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8E236F413;
	Fri, 10 Apr 2026 06:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775802608; cv=none; b=lB3q2c27KPFf36k55jZie3bLrMe/lIq7Libi3Bj0CMARNJlK0JZWlFj0E8FkUUNcBIz9FmKiI/xZ+RmuhFmx5A1yZc5rlqD+oc09116wKLAyn0xesjuGjH0vww0/HX22a7FTak87TXyGMzhfFpRbluB+2LN4JxaAlHzSSJEaz2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775802608; c=relaxed/simple;
	bh=feD4mgNlEQzQNzjgmjGsuDRJ4e+Z3p2okjdlFisAEks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iOk8JvY250z6lEsd69uxhmpA1iq8r25+DmYy3UyHDnh1TBF5WGFdv+kV/AeXZw331NUsruALJG1xMZ1U4qDQ2H2L+GKAZxQuQuGCF5OC0Q3NEXXtVyNFsCs0pWrC14bN8DcWSFJkJm3jIgqbLI0Yr35Sdu5ftX2J78v6KvnG7/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EglVSSo0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2608C19421;
	Fri, 10 Apr 2026 06:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775802607;
	bh=feD4mgNlEQzQNzjgmjGsuDRJ4e+Z3p2okjdlFisAEks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EglVSSo03/wiH+YGuVoIWBBG81QGPb30n/6FkyGCL/5YzyVAGg7YylNzaqi3JBV5n
	 r+ukp8b6lGWI+2tl5JbnXvwnVBuDN5YFlq/jV27CCMdZN3y6whbWku3EvKaoLbBEx5
	 sooSYf8BTnmDwy49z2H99L14w8Zc1xl0jnbKxGQ2xFBzJeBoLuG3H+/s2hq6svaMSe
	 EvqqYvSYTSh37Vww4WNjfMrFpJMOyppqFVitR8qA4MiwY3o/M5XKkrKvatrRl0XQUR
	 IpUfCc1nEWInJHvYsk8hmkSX8B8q283ETuy67fLkG5Q72QkuPCZAmrGmPvj0kVKgDk
	 6nl1opHe+eStg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wB5NV-000000022Sq-0HEj;
	Fri, 10 Apr 2026 08:30:05 +0200
Date: Fri, 10 Apr 2026 08:30:05 +0200
From: Johan Hovold <johan@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Sunny Luo <sunny.luo@amlogic.com>,
	Xianwei Zhao <xianwei.zhao@amlogic.com>,
	Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
	=?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
	Radu Pirea <radu_nicolae.pirea@upb.ro>,
	William Zhang <william.zhang@broadcom.com>,
	Kursad Oney <kursad.oney@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>
Subject: Re: [PATCH 18/20] spi: microchip-core-qspi: fix controller
 deregistration
Message-ID: <adiY7f1YAn1TivU8@hovoldconsulting.com>
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
	protocol="application/pgp-signature"; boundary="q0GuYTiPUYeAA82O"
Content-Disposition: inline
In-Reply-To: <20260409-unease-salaried-8bcb673e9a5a@spud>
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
	TAGGED_FROM(0.00)[bounces-235572-lists,stable=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hovoldconsulting.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,microchip.com:email]
X-Rspamd-Queue-Id: 374123D2CAA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--q0GuYTiPUYeAA82O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 09, 2026 at 05:13:07PM +0100, Conor Dooley wrote:
> On Thu, Apr 09, 2026 at 02:04:17PM +0200, Johan Hovold wrote:
> > Make sure to deregister the controller before disabling underlying
> > resources like interrupts during driver unbind.
> >=20
> > Fixes: 8596124c4c1b ("spi: microchip-core-qspi: Add support for microch=
ip fpga qspi controllers")
> > Cc: stable@vger.kernel.org	# 6.1
> > Cc: Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>
>=20
> Where are you getting these CCs from? I am listed as maintainer for this
> driver but didn't get CCed, only seeing this because I am CCed on
> another patch in the set. Please use get_maintainer.pl.

As Mark pointed out, the explicit CC above is for the author of the
commit in the Fixes tag.

I do use get_maintainer.pl, but it seems I trimmed the result a bit too
much this time. I sometimes drop what appears to be fall-back entries
(e.g. using pattern matching), but here the driver is indeed explicitly
listed in the platform support entry.

Johan

--q0GuYTiPUYeAA82O
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQQHbPq+cpGvN/peuzMLxc3C7H1lCAUCadiY6RsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQC8XNwux9ZQh58QEAuYmydwwdcpQts912HoSs
SIvBnjs96yFueQH76rnH0Y4BAKd5FPuURw76G15iQgyiIbp41xktdx846jxjEXwQ
QSMG
=WNtJ
-----END PGP SIGNATURE-----

--q0GuYTiPUYeAA82O--

