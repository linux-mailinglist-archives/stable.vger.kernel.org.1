Return-Path: <stable+bounces-215659-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKWmKOsti2lEQgAAu9opvQ
	(envelope-from <stable+bounces-215659-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 14:08:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE6311B1CA
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 14:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D851F303E75D
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 13:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4023D32825B;
	Tue, 10 Feb 2026 13:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="keBeqUhR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D81322B69;
	Tue, 10 Feb 2026 13:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770728933; cv=none; b=tXKU+iZjnXzy81yk4PbL8/qePsvig1ZKqxbL3+1LQnPb6BUK1U3XxoWeRsKgcx5EXmxjj4TZTGwG61FmepaJ27R5rUOwTPxOSWUKd/XJe0Ws4gbwSoHvwgKSsEq6dr4jpHYcmyNF3pLA3iBNssB+aj2J7yNik3ZejLNaBOgG3Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770728933; c=relaxed/simple;
	bh=j4MXU09S9c0zF8GAzFp12MKGoRK4tkhmKERNcW9ZbCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kPydbIf50eOv8pAra8eeX5ljHyTlP3VXZ6Z37skTgBHq/YRd9O4zNaDe4As0w59UU/cuS6wnq8sYdj5Lg0FvB4ofAPlpYNIlj1SnTtHT5q4f10cfqHiMxxrojqRTJA3ny4ka/GVaw8HxCZQ2xOqEBV+Bk50/EkEyteDwMOxhQDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=keBeqUhR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 020EAC116C6;
	Tue, 10 Feb 2026 13:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770728932;
	bh=j4MXU09S9c0zF8GAzFp12MKGoRK4tkhmKERNcW9ZbCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=keBeqUhRut8WX3YAs5gU4n9ySUMPSDwkhY6cYTdqee/e5Sw2+8u5/wH2ro5CBqN90
	 PzW6jUkryFCB2yaztC0KWfn31V0qUEL/R1loqu7BC61I9CFA8JXp2hWinxpFdBXzsr
	 dddbfM+cGVQnwN8voXIicSm6zX8Hl5xW9KyYrg+WjgS7UMUNgZcPxeD/JFJR/U6fbt
	 +89Hzf3un876TJE1YxAr7QS3ySagwfmm5PhbJy9Miv2Y8pJNlVLCQvDvv9A5giPPFY
	 2bP7LBfmVRU3WN7kaji4hKWqHLNyvcLOA/hPf03PhQW83KNJpeL+JNBNnn4T8yKRQp
	 LdZNhtqIVbh7w==
Date: Tue, 10 Feb 2026 13:08:46 +0000
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.1 00/69] 6.1.163-rc1 review
Message-ID: <7ffb9087-02a7-4227-b61f-79a2bd178461@sirena.org.uk>
References: <20260209142301.913348974@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oMw0Mlucv+gxgM+I"
Content-Disposition: inline
In-Reply-To: <20260209142301.913348974@linuxfoundation.org>
X-Cookie: Spelling is a lossed art.
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215659-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 1DE6311B1CA
X-Rspamd-Action: no action


--oMw0Mlucv+gxgM+I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 09, 2026 at 03:23:28PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.163 release.
> There are 69 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--oMw0Mlucv+gxgM+I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmLLd0ACgkQJNaLcl1U
h9B5vgf/b+aYzwPBeBnxIa5rTbhDYY0JsfYf6jy5Ytj0JyE5Nn7iFQB8vBmXr14B
YIzcZb6eg6nqagdd+Ji6qFCgje5zBh1Wb1CMbifa/aPMvI/JbLzoMCVAmejg9aWz
c8PF8efD4snYbM/XGL7Pj06o2f+xx09EdllcSCricV2H2ABVbO9FaUl35PllSl0W
bO9Io9tm53IS5P9R8DtnItPcXHhHFf6E7s9MaPwNsZmG2qO22Sq1xtEycGrpEwhC
fKwlbT9Urp+GfEdU66gneNKZY9KVP15+9hqCR1f9KZ2lPvtXsmYJLg4dcRyKlBNm
3kcFPhh2oOAzaRVpQuC4qt+lsukDbQ==
=AXwh
-----END PGP SIGNATURE-----

--oMw0Mlucv+gxgM+I--

