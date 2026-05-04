Return-Path: <stable+bounces-243003-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLFyB+2K+Gl+wQIAu9opvQ
	(envelope-from <stable+bounces-243003-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 14:02:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9FA4BCB93
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 14:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 71C0D301451D
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 12:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DD63CCFBA;
	Mon,  4 May 2026 12:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Y6cd8qRS"
X-Original-To: stable@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07F13C198C
	for <stable@vger.kernel.org>; Mon,  4 May 2026 12:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777896170; cv=none; b=JJeEsFA/ocb09uBgLXvuaqd1a/qhfHjG9G7w5aANcCOGSz9UpkzP5BnAQKQJjZtdhm6hk5b3NjNd79ceERz2gsd+fFVqhU5Qn8r8J3P8QR4tzUznHBHBSZiStF4yyuttcI0gLuIvQ2blp0AQkq32lYKv2R+BtQPGGqe/9K6cMGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777896170; c=relaxed/simple;
	bh=olCbkCWISbkFgW2JM8v+xUYNgHLBzLcDRxs8yUm3/p0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ab6u5HaQHdxirwLnyU7RHjb2Ry0HfrRqZo70gMCN3ywsxpM9xjnzzYuX+0SmIh/P8j9IWero6XVFfCuKHjbug6VE/eNCpB8o/0sYNiffR6aI5qo7uSn6ybunGwj4551NMS41RgVrFVGPba4EfiJ/p5rWg+DLeTcQIH+mJXMZTgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Y6cd8qRS; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=rnzE
	3fagmRQ4MynxdSY2IA23lAMp8yjSa1dYK89grj0=; b=Y6cd8qRS7qfD2QlarjE9
	nZebitcDfoml2x4gEpe31NN6N9DU9R0EdkGqpTtAOmaS9G+OiJ0Gpvd0upXwzLS7
	xS7Kg5P4gbfhiwdyRicsXlG+hZNgpH+nbKqvZtTqymkhTmKxi4/KOGomDD/LkYcg
	puG9gLchoaih7ytzbLimb9u1XqYdF91fCmfCHKxugRqeFSfiLdy5ut8hD032Fvfj
	U08zRtG79A9V+RUZnnal7wDNFPoT3fXnyKTfq+QQFM/DcSBIJztqGlgOVkBsJXT6
	JHjwiBCUdHu3y/O5JaXLrzyhZ6JaxBfzAu8ovp/vYxax4BirK6f8NN0wHgyfWSjf
	TA==
Received: (qmail 2187862 invoked from network); 4 May 2026 14:02:44 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 May 2026 14:02:44 +0200
X-UD-Smtp-Session: l3s3148p1@NqpMtfxQytUujnvR
Date: Mon, 4 May 2026 14:02:43 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: Xiang Mei <xmei5@asu.edu>, linux-i2c@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] i2c: smbus: reject oversized block transfers in the
 common path
Message-ID: <afiK49_aMEZYDQAg@ninjato>
References: <20260330042622.2608889-1-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eMUX46Q21S3g+g0m"
Content-Disposition: inline
In-Reply-To: <20260330042622.2608889-1-bestswngs@gmail.com>
X-Rspamd-Queue-Id: 8B9FA4BCB93
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[sang-engineering.com:s=k1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[sang-engineering.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TAGGED_FROM(0.00)[bounces-243003-lists,stable=lfdr.de,renesas];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[sang-engineering.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wsa@sang-engineering.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]


--eMUX46Q21S3g+g0m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

thank you for fixing this issue!

> +	if (data && (protocol == I2C_SMBUS_BLOCK_DATA ||
> +		     protocol == I2C_SMBUS_BLOCK_PROC_CALL ||
> +		     protocol == I2C_SMBUS_I2C_BLOCK_DATA) &&
> +	    data->block[0] > I2C_SMBUS_BLOCK_MAX)
> +		return -EINVAL;

Like with your other patch, we should also reject if the length is 0.

Happy hacking,

   Wolfram


--eMUX46Q21S3g+g0m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmn4it8ACgkQFA3kzBSg
KbYpRhAAqpSlOB8BKuT/yHV9fk64YKylspo+CilLrT6J7NXoRaCTj7jLTZAtCrQa
tryXCryDrIXvRyEL4MNMRdBNVY1FssbxENzT90jY/uNHTY+IIZyYiiuPsPZ/ntxI
KOrt+m9kIGO6SMF9HwlaUQmXKqzhev+qEoo3jVZgmSPx2rwxcht+ZUKvVBw3NOUf
eVPToDCxPrF/SaxA+TcOUWlyYmqT+5I9XJW6l19X+p3yZw580F3jNyCzTgUqZdgT
1naTEZkwkS3HmLnnSiKwavDW1KqsKTRHxvpwggO8r03R05Z584eEnDf3kt/hjm6D
sgEmyfJunDoMV/nVvc2lRdavU9W5isS2pTCVpMweayg+NWEElf6ARB3/NRHZPJIq
YWi7ySyKkeJdzm11pUHQ+Bw87rBQbDoLZIkqmhG0utSSE07Pie1YpBvEMPyFwuaI
nZSBdG9WgYF3zFVgclkpT8aFG1B0R5CJFk8K4aOkRmRUXax8Hvj39uaYL+vkx9N7
w6p7Ljcm/I9efwXw0Eqar00M3Qbs76LdWqb3BTxXX5zHc1219X6DTRmqYrrjSfiv
fRSLk0Wqp1jYc6eD4gGb2viGaTTZRF70/dBn02W/vu+/+miDF+jnab1kcULhv4+l
DD+PBg+3TWa+GLPuYxizUzv/3LDY3pmYdZf/wi1cVSgs1/COPy4=
=gtKk
-----END PGP SIGNATURE-----

--eMUX46Q21S3g+g0m--

