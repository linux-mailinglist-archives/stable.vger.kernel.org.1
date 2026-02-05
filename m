Return-Path: <stable+bounces-214451-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOIyImWKhGl43QMAu9opvQ
	(envelope-from <stable+bounces-214451-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 13:17:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAD8F24FB
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 13:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D3D63023DC1
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 12:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A693ACEE6;
	Thu,  5 Feb 2026 12:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhdcDYKt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080EE283FE2;
	Thu,  5 Feb 2026 12:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770293602; cv=none; b=asYc/Km57doWgsqUL36S0SLKrY8UqtCfZd1rXaKIsi/NyVStTPb+NMjzn0Da9TbVXSduujN4jEg1nRzD8r/1UiC2Bo0QCfA8XH/nWpfl9hQn66uF4pL0TPoI6gFZ5OfZE0HWUCVOIingWyB3BLnS15FOcfhyCQKfVUAwsg8ws2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770293602; c=relaxed/simple;
	bh=3ccopKKNjXYXyxN1zTA+GzpH8MavznmGpE3kd2l1Opk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JhkYXNwlBSvQm6YAjvnhFjXfxo6vGuJDPT/ZMzqiY46e5t+2wrAplkePT741mWPhVns2hvLMr7H4zimJRuKmYeuOdaDQkAmuZW1x97jfTjVK+TlRgt8ZLUzvbsiiqnHUimWWoaHy7JD2GMFFikXg0Op8e7/OY/4+zdkJORGfpy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BhdcDYKt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC438C19423;
	Thu,  5 Feb 2026 12:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770293601;
	bh=3ccopKKNjXYXyxN1zTA+GzpH8MavznmGpE3kd2l1Opk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BhdcDYKt+Ja/jpDQTVj1NUS4x1ucA7iEcbsfR3vkxVgFCki8AHLtcMNYnGiqj6E0U
	 OsK6ZoeiRRjlhUsXBuRV+xslDe3vMIRCl2kqT9WhVAFRNDJ8AusDraAfROiJAxkVdB
	 8J2VgGq03y+Z98ze3zJlR0UFRGfjoqhA0QedGk9tCDjDsucNOUiiR1gUrazXh3G6wS
	 QsjGQeFMYPGQtzdw6SlVZSo0YNyEfA2lkR2CFNy68cMZ0kcQb/2bJQOAJX0zvfJJ3v
	 42xkFGWeD9fEYGI/ej8luoED7CJ2Nnx+ycAcQ+lwu9+QAnxCH/kMcaDnJbVIAbCiFM
	 bIMqAeYmuef7A==
Date: Thu, 5 Feb 2026 12:13:15 +0000
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.12 00/87] 6.12.69-rc1 review
Message-ID: <1189a7d5-ea6f-457d-b0b1-eba6c39b91be@sirena.org.uk>
References: <20260204143846.906385641@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AP0BbJbLYGtHKibF"
Content-Disposition: inline
In-Reply-To: <20260204143846.906385641@linuxfoundation.org>
X-Cookie: Non-sequiturs make me eat lampshades.
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-214451-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,denx.de,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
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
X-Rspamd-Queue-Id: CCAD8F24FB
X-Rspamd-Action: no action


--AP0BbJbLYGtHKibF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 04, 2026 at 03:39:58PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.69 release.
> There are 87 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--AP0BbJbLYGtHKibF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmEiVoACgkQJNaLcl1U
h9CDwAf9EHRIgcQc5P1kVr7YWs6rwKYXIiJCSEgJkIsOeaRHtd6e/aqpBRh8muDM
JCdBJCKoCDxkNVdEBwQLCILdz/cx48WBh/bgkFhWQYH0nlOnvHuAO1ubB3tcSK9H
1i/O0y6MXGV8qAt7mIYdogBaz3iR8fk0rMOPmPR+KbTZgP0nGcLKgmBnRLcYORKG
BY7anwyr+4R7LBly9kC4bY+ydHcx4phgmgOipxdxbtNlzry18ONaN4ZHKuSABT1P
nWYCyQ+sKf/loLupCgTwuVQVIoOmgf2E8io9b85IYdTLHYCKgbbZO1voW3vrBuD2
mRUMHk6CKQHbHV0qw2YdbCyW6+c0zg==
=ydMX
-----END PGP SIGNATURE-----

--AP0BbJbLYGtHKibF--

