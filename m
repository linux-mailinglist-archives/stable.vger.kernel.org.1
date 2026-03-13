Return-Path: <stable+bounces-225299-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QC31OPkEtGnjfQAAu9opvQ
	(envelope-from <stable+bounces-225299-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 13:37:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDB4283204
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 13:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4B8D301ECF1
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 12:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A1B396585;
	Fri, 13 Mar 2026 12:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SsaVEiRO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C28394797;
	Fri, 13 Mar 2026 12:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773405388; cv=none; b=ZPlVpeg1DfJvUWJL3HSAE84NOSeojl9X6mehyCl9oQVASutaBz9lnun6dNTbjXmvpFSz/OB69RvTvnrNsOVPfQTP6s+N9Qnb35I3x2tlJSMoDk1k3KtSfxYCiyjDvtisvkmi4DD8CKsEks01JpVhmZCbwnhsSOT6e5JEAAMeEDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773405388; c=relaxed/simple;
	bh=tCuEoq6Tr9oueLQZ+74IEFq9JLFzj4PoA69iJqvvQVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=odjIYtF6iLZtOemZD7U5uOhyyDd4DjA1W9W3VomIDJWKv9PGtC7C0X9mV8pkV2bRhBgDckbdi3e6tZ8TTOYZeZiFSmOwxKOzguzUddgYfEDDZ+K9vPzpZiVgF2d3I932B674QGvUwOJpeEZoGIk5VdMGt6fGIo2gytP+32UpA+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SsaVEiRO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2713CC19421;
	Fri, 13 Mar 2026 12:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773405387;
	bh=tCuEoq6Tr9oueLQZ+74IEFq9JLFzj4PoA69iJqvvQVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SsaVEiRONgy7N+KPntXeo+oyhDid+gonLvoOLva6zqxCbBJEiTIfzuK3IFHnH/Cq6
	 kb4my1TIT3KVw47BPYLM1N4IZy/hGQlORwKbPYeLTEBs55ExuP4AFXkPS0GQdM6jrs
	 bcHGn5U1v/RfADZSG88UulopWrwe93nTgUgsGOlE69mCMqZrXk2OpKcNeSmnZiTNyj
	 tr0ILEvkv229uGy7LSF6uxTxhgkc2jS+S/pA/8A9hb20ivupjj4ees4uUgfPfdNhQP
	 PjnIkCpWK7V1ZlxQibooAVg5A3BUWCnFlcJqq1JkYVLNjGUwodOnY1K4J9edYTmvIF
	 D0cUhEPBk8gIg==
Date: Fri, 13 Mar 2026 12:36:21 +0000
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.19 00/13] 6.19.8-rc1 review
Message-ID: <9acd3ded-c1ea-4574-b9ae-463759f757cb@sirena.org.uk>
References: <20260312200321.671986598@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lmR3NeMjw7W9NlyM"
Content-Disposition: inline
In-Reply-To: <20260312200321.671986598@linuxfoundation.org>
X-Cookie: Monitor not included.
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225299-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sirena.org.uk:mid]
X-Rspamd-Queue-Id: 6DDB4283204
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--lmR3NeMjw7W9NlyM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 12, 2026 at 09:03:32PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.19.8 release.
> There are 13 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--lmR3NeMjw7W9NlyM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmm0BMQACgkQJNaLcl1U
h9BDcgf/cSkn/st+z7nX1Y08852m5XdUgBjDxR/te/WVvwnEpWyifQ1p8BVxsR5M
K+L+2cZ5u1RhWSZ+73MytT8gIYQs4ZvumhwMnLAorJoLXkcf+PxIjl47uIDHOlbB
bYR1QPlnB5Nk7ZZ6FFHcQwzBK61jo+9JfI+/rFSiC4srJL503lHBvhjLNY3RbUsz
+9u0BmYN02LKXDwWzVZeXkrxi0Tw+uZMY16xfWWuvdYiXukSb4oC+YQfIfehKkuo
HviNlhrRxHaMWcDjCbYzMb4RAe9MvqWPW/MMFl7Nbj8VuuXtYs+RFJIPEh2btZGC
pVawvEsni+S6kjgySmUH+UvuhOCiEw==
=Etns
-----END PGP SIGNATURE-----

--lmR3NeMjw7W9NlyM--

