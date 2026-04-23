Return-Path: <stable+bounces-240437-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNPCLsLR6Wm9kgIAu9opvQ
	(envelope-from <stable+bounces-240437-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 10:01:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D27744E43E
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 10:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 97AB73008C24
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 08:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B25363C40;
	Thu, 23 Apr 2026 08:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kuxhYJmJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E103630A7;
	Thu, 23 Apr 2026 08:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776931256; cv=none; b=AiPrpnoB3Y06BvlBwiYrmPkupRHwJo0gCdW0FCb2cCTSvI5dMn4NuDXgR48tWr9X6DZwAJ0daLmDMt7hUfji4vrmpTCfgzCemrGsp+vHp2bn0JhYkaLEIDv5lmtYIo9XJlvbs4uu8JwCVniYyaPJLTzqeVam+g+if4hCXp08DsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776931256; c=relaxed/simple;
	bh=a84X/P/i35Cjebk4Jk6qux65Owf16nUFeA7GMQ2Bucc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U2qiJoXzxSueM/UwehApVJCbNqLWwSPJLr4nZounzr0bGoUlxbWaZuPJ5ahr1HBjpMswdc2oTuRu23jmLnZNJPV0Yb7FmFUFgM6osqb34Y0Vyu3Osq5tudYIDm0X7VvNjHdwZ2CD/MUk+su3+Y6bFZQEyfwRkrxN97bdOR0kVQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kuxhYJmJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B52C2BCAF;
	Thu, 23 Apr 2026 08:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776931256;
	bh=a84X/P/i35Cjebk4Jk6qux65Owf16nUFeA7GMQ2Bucc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kuxhYJmJ5D/bDOw2fmnMoLdo5USmjI2XW87AsaqkO6U/CMaSQwc5f+1Ll/kkNHwX+
	 +rq/yX+6I6x7Ntds5sPBOoWJkLpIudwWLRElr6sPgg6VTabFSbWFkuQjgYy8sM0XZK
	 Ahe+a6kXUeWye63duWH2qxwTvq1v1Om5yjmP8wSBefDFssjDuUdBnZISWw2NjCghHL
	 IU5yvzapOpyciDpxckbPajHf+NvjX5IP+/Cz73R9DjxvponlORw67qDlcRiaEVJ2PZ
	 jw/F18A0UoAlPhsK65VDvC/asFzyD5MCziOBpBlcQrGwzELfXdZ5yMLcD86fVX77lE
	 ZgoxRFBwgeeYA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wFozW-00000009S0O-08O8;
	Thu, 23 Apr 2026 10:00:54 +0200
Date: Thu, 23 Apr 2026 10:00:54 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] spi: mpc52xx: fix use-after-free on registration failure
Message-ID: <aenRtqDVr-ACBeG9@hovoldconsulting.com>
References: <20260421125800.1537361-1-johan@kernel.org>
 <aejsLE_vnchmCKtN@hovoldconsulting.com>
 <9230f719-2c5f-40d6-9486-612c8fec311a@sirena.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tidtdNHKx6qF0btn"
Content-Disposition: inline
In-Reply-To: <9230f719-2c5f-40d6-9486-612c8fec311a@sirena.org.uk>
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240437-lists,stable=lfdr.de];
	ASN_FAIL(0.00)[74.135.232.172.asn.rspamd.com:query timed out];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 9D27744E43E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--tidtdNHKx6qF0btn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 06:12:58PM +0100, Mark Brown wrote:
> On Wed, Apr 22, 2026 at 05:41:32PM +0200, Johan Hovold wrote:
> > On Tue, Apr 21, 2026 at 02:58:00PM +0200, Johan Hovold wrote:
> > > Make sure to disable and free the interrupts in case controller
> > > registration fails to avoid a potential use-after-free and resource
> > > leak.
>=20
> > This one will need another spin to address some further pre-existing
> > issues flagged by Sashiko.
>=20
> Please do an incremental change, it's already in CI with some merges on
> top of it.

False alarm. Sashiko flagged the freeing of interrupt zero as triggering
a warning, but that should only be the case on x86.

I've sent a clean up patch for this here:

	https://lore.kernel.org/r/20260423075801.2252318-1-johan@kernel.org

Johan

--tidtdNHKx6qF0btn
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQQHbPq+cpGvN/peuzMLxc3C7H1lCAUCaenRsxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQC8XNwux9ZQjTOQD8CgPPLep57HU/zQfJ6ejL
qNBiWUe2dqXa83NMSRP2b6sA/2lf0kDT5OWFiZYEQ61062jtRanRhEsy5Woa3z+M
/IwD
=4B8r
-----END PGP SIGNATURE-----

--tidtdNHKx6qF0btn--

