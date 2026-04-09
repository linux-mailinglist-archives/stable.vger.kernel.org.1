Return-Path: <stable+bounces-235446-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNdoBbrR12mrTAgAu9opvQ
	(envelope-from <stable+bounces-235446-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 18:20:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBA03CD92E
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 18:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3679C302B778
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 16:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3953AEF54;
	Thu,  9 Apr 2026 16:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+ccITAa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFB52EB856;
	Thu,  9 Apr 2026 16:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775751215; cv=none; b=N7v3kfRxQKq90xVdbg7MHJKZ//sMn9vumPpCkeGagm1px4d2iCbC6FYVkovCtuyyqQWLvzt1DB4Z+Vu3MWt33aC3qnpbT1t8lkSPaX3ccgrQsnDBPlaoPKNqbIAI3hOspV+kgxkfWgD7vzzo1Lx1fxNvyILlI1caPSqeDoj+9EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775751215; c=relaxed/simple;
	bh=bsD+hBAisiYo70nFqsBcKxqBI3NMZbjrMkhTOdhdQys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qWBf1tNt67igiWHDX6KzAs29mv7s9xdIiRqafHPBVhN/8THMtm3ojapfM+ZuBWMOIxw6qBPvdi0uJP5xx58moCfHmjjiJ5y6B8sWcp9l5eNC9eGU+j/mF7qDZgoZFhI7D5I9C2FnMA8WiRtxKEWVFtZUJnDCmCxDKzwpJPytgEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+ccITAa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA26EC4CEF7;
	Thu,  9 Apr 2026 16:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775751215;
	bh=bsD+hBAisiYo70nFqsBcKxqBI3NMZbjrMkhTOdhdQys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M+ccITAa+U/r0Z+V6XD7LFSezBy2I9Auf7y2bdgwo3f3K6JWntejdpUiPly56wQg0
	 W8uxqIIz6UgdUKTYJiPIEDIR4Exhrbnhe4SFt6X9+AKC3TyyS46YhhRz3myf0XicWY
	 knXk4d5xAxeFOK3oAAEd9aDkQ2RatcnAXdlQmPXbeczwQSR2nCwxGmDoXw6b5wy1iT
	 lme/PD6f4qIvDbLnl0VcmDtnfNKw2mxW2V9dGoxmgpCMYbjUAf5RFyC4jLMZMYJEbi
	 pkEUdnqgE5nFAE11bazhUjeCR7tktqCE9iqUIBzu01PhpDyyeqBDzgxYuPzsonDGu5
	 8C//BRRVCUxfA==
Date: Thu, 9 Apr 2026 17:13:30 +0100
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
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH 20/20] spi: mpfs: fix controller deregistration
Message-ID: <20260409-overbill-although-b0c51fd2a6db@spud>
References: <20260409120419.388546-1-johan@kernel.org>
 <20260409120419.388546-21-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Do9K492Dyn9ifzN7"
Content-Disposition: inline
In-Reply-To: <20260409120419.388546-21-johan@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-235446-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 6EBA03CD92E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--Do9K492Dyn9ifzN7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 09, 2026 at 02:04:19PM +0200, Johan Hovold wrote:
> Make sure to deregister the controller before disabling underlying
> resources like interrupts during driver unbind.
>=20
> Fixes: 9ac8d17694b6 ("spi: add support for microchip fpga spi controllers=
")
> Cc: stable@vger.kernel.org	# 6.0
> Cc: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--Do9K492Dyn9ifzN7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCadfQKQAKCRB4tDGHoIJi
0iBgAQDebcljZem6CQx3Ioi8+ctRDiQgHPe809WtR0e12XlbxwEAxY6ETfHlH3uJ
aPCXkMknsfl51Dk/hsGTXqR7b+5X5gI=
=6k1q
-----END PGP SIGNATURE-----

--Do9K492Dyn9ifzN7--

