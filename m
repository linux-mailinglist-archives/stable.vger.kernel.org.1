Return-Path: <stable+bounces-240370-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EG5/FuQB6Wl5SgIAu9opvQ
	(envelope-from <stable+bounces-240370-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 19:14:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B013C449321
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 19:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4031D302410E
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 17:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C57E33A007;
	Wed, 22 Apr 2026 17:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mDOSsl4z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7C62D8385;
	Wed, 22 Apr 2026 17:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776877983; cv=none; b=cZNWy4QdB+6yqKKVwuMIH1wGc6nyrBA2wYdGdg2CbXIHLeV22+J/Jh9lYuYJXzhUfdial8k3srP1PbeP93aeEk0c0xt7D5LefZoPo4X+DAJ03g/VaFypS6Tt05/dpcSNR8ucc7Sjb9zIEXbn0cTk6dx8ikxCZo4WJZgwBHzk1vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776877983; c=relaxed/simple;
	bh=HjIOrqhn+f8xgCu0bhls2WUldXYCMEzSemaAJZDBqEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xl3EbYs5uk1AZa4fsb7vUJ5qcsvOYloa+Q6Os1cIXGCfi9jQBvOIH5ThuebWlSqRMzPEm5k8gcke557GtE/5aljjR1UmyeoV+HLqGCBtqXh8BILNG/fZqK+JobpFL0vWieRKrJqZdSO6xj8WyfBvPj7BZmuEhQWk+Yj8Vo1T2XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mDOSsl4z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90115C19425;
	Wed, 22 Apr 2026 17:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776877982;
	bh=HjIOrqhn+f8xgCu0bhls2WUldXYCMEzSemaAJZDBqEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mDOSsl4zd7HGq01mATKJOntWwnAnu6j26vv1owk3gdcvkvBG/UGuRAInqkepzunIq
	 /Ae1iKuae5PmYkGn3wdhOM7NA4R3d7BZUXKRRaQ5YRN2bBkxT1Z4VLWfxuxMwV6lGN
	 fuw1rJIoMytzxzxOMOJhPDxwxakhPYWD+n8hx5HwJmF4wfmf5KQhabn9cxtjJw0sY+
	 1Tyb+gYjYQ9m8aeM2FyRTDZA7ScGKxcWta/zNuYhpKJN7RQbIXLki7BCt/zSYwlln5
	 bEXVU7pTR1yFnL7RVWaZvefWQCJz4jht1UZoKE4ZbnsiXxASr9jCYrqMWk4JgVd8WJ
	 6985YVnBCE4UA==
Date: Wed, 22 Apr 2026 18:12:58 +0100
From: Mark Brown <broonie@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] spi: mpc52xx: fix use-after-free on registration failure
Message-ID: <9230f719-2c5f-40d6-9486-612c8fec311a@sirena.org.uk>
References: <20260421125800.1537361-1-johan@kernel.org>
 <aejsLE_vnchmCKtN@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MdPjpW5FjVoKVQ+D"
Content-Disposition: inline
In-Reply-To: <aejsLE_vnchmCKtN@hovoldconsulting.com>
X-Cookie: I'm definitely not in Omaha!
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240370-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sirena.org.uk:mid]
X-Rspamd-Queue-Id: B013C449321
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--MdPjpW5FjVoKVQ+D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 22, 2026 at 05:41:32PM +0200, Johan Hovold wrote:
> On Tue, Apr 21, 2026 at 02:58:00PM +0200, Johan Hovold wrote:
> > Make sure to disable and free the interrupts in case controller
> > registration fails to avoid a potential use-after-free and resource
> > leak.

> This one will need another spin to address some further pre-existing
> issues flagged by Sashiko.

Please do an incremental change, it's already in CI with some merges on
top of it.

--MdPjpW5FjVoKVQ+D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnpAZoACgkQJNaLcl1U
h9DPeQf+KsFW8U7Neu5Ml+7cmSc7haG3yrKtZnPZeRhPF9a1O80NPGUpnoChc25L
lxrWA0CV3t1wrmizbi9cnEGIplEIDaljX5hhSBqhjNUzvbIVAs76pMVhJuCj8HfQ
eVYc5D/b1c31hIVgmSM13xINvBUcJdEEdf0nVNaqfGZfMvYyhcmoai/Xio8yYIS2
OfruMmzlMuwXT5dYJYnUufNyMnWgLxstzeEUa7nnUypNV9t3BN18a+lfznUdVX9n
z3pFta1+Qd06t3VXofBsR7yiDZOdDXDR00DhAlGoD/r3NPxlP7FyWAJoMUZs4Yow
yl+3tsr2wjkxEOjeI3w18LEOA4oPuQ==
=Jaci
-----END PGP SIGNATURE-----

--MdPjpW5FjVoKVQ+D--

