Return-Path: <stable+bounces-235444-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJMhLP3Q12mrTAgAu9opvQ
	(envelope-from <stable+bounces-235444-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 18:17:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDC03CD88E
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 18:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 588883080C22
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 16:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0CE3B7741;
	Thu,  9 Apr 2026 16:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T4gN9/0K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7C132FA3C;
	Thu,  9 Apr 2026 16:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775751029; cv=none; b=Uv0ox4IBfXqJ30ASzpYgvkmkKwlYoo2OcPdpOz7jd8zmkZKD/CSvp2GVczuS3+BdIMK0ebaxmVuHBOPLQ18jWfC2Vp7Sg0qV+Pgg/8S9nkJ/cmMuCMs4VGG1OaW+0uKnAbomDLr34yZBzTqAkz+7R77X5ieHs76jQmgy1lb4kMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775751029; c=relaxed/simple;
	bh=Yc6OpYdGPLY+gHVUVeLoCkvBy0sDE3aiVPq0iTkw80A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fhqZ756EX5v9o/SBhgRfFBacNqc0DniLjRMF36Q5yfUhCQMI4fSwgut/KZyipDu24FVvAfihUsj37aDl+XEhed6m1LPIbmktRhgijS3MZWjw6MrXaliBJgKIqpzRL6sb9gPd1f7UG8bWBLkdr8lY3gcnz37s+gnTjeczg+TB4Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T4gN9/0K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28429C4CEF7;
	Thu,  9 Apr 2026 16:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775751028;
	bh=Yc6OpYdGPLY+gHVUVeLoCkvBy0sDE3aiVPq0iTkw80A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T4gN9/0Kye8v+JAWs+ZuDjlBSB5XPY0GiGCFCd4Q4Kt14ngfjkWpFQnSZHICWsGay
	 N84W/Vu7H4fQmjBOyjrx9qFtlqnEyelyduP/y04SaSRrLV0KwWgNKm++4mJu4sUxBJ
	 vpD/5LMU+T6W4veDNrgDtra8/9AdNSi8CBxV0TIdpuBkuLR83PsgsyfvOaGAUcosl/
	 lW3HZOejhZFj5klXy7GtmgaIoIe5F+BTY28zlZIkgSz4aUm/0ZFpu7pfClp7wxKaXy
	 Hb8JB5lpbekeNFbM1i9K9QSvbE42d7SWF0Zas6qMslaEj3vA35rzqADDZwGXi3aX0c
	 XNpZOUys8FCBg==
Date: Thu, 9 Apr 2026 17:10:23 +0100
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
	Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
Subject: Re: [PATCH 19/20] spi: microchip-core-spi: fix controller
 deregistration
Message-ID: <20260409-untouched-anteater-d1af2a00ffcc@spud>
References: <20260409120419.388546-1-johan@kernel.org>
 <20260409120419.388546-20-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SRNgSkvbSM479uIG"
Content-Disposition: inline
In-Reply-To: <20260409120419.388546-20-johan@kernel.org>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235444-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1EDC03CD88E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--SRNgSkvbSM479uIG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 09, 2026 at 02:04:18PM +0200, Johan Hovold wrote:
> Make sure to deregister the controller before disabling underlying
> resources like interrupts during driver unbind.
>=20
> Fixes: 059f545832be ("spi: add support for microchip "soft" spi controlle=
r")
> Cc: stable@vger.kernel.org	# 6.19
> Cc: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--SRNgSkvbSM479uIG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCadfPbwAKCRB4tDGHoIJi
0rJ+AP9mcauj+ZMQFGy0ezVBJfNEYe0htbxSgQ7n1YzbhSoFkQEApNi2PI/Qunk0
lCP4hNEmprG/eeQtWGggjX1IP82fQgI=
=qlP9
-----END PGP SIGNATURE-----

--SRNgSkvbSM479uIG--

