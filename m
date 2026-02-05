Return-Path: <stable+bounces-214557-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULZWNCwHhWlW7gMAu9opvQ
	(envelope-from <stable+bounces-214557-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 22:10:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0410AF77AD
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 22:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CC152300BC99
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 21:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C555330313;
	Thu,  5 Feb 2026 21:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOo6omMN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F194F32D0C4;
	Thu,  5 Feb 2026 21:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770325784; cv=none; b=hk7cfAZW9eclV88pw1sjn6VQlrVe1UY34yj2GkO+yUYapTq5B8euCyfZ+EVt0cj9eAWKFoDKR8YX8pPTX5t8kJZA4G4Y2B/+mJlmDthZdd7B7qZuono6zcRd7mw99RxEKPGYLfLHVyLda9AAuO4GKu+FxqAM6szh95Acvd+7YQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770325784; c=relaxed/simple;
	bh=ozSFKEI79GoTdl4Ai30BuX7ki/qCvNy6lAkaQXc0be8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gx1QYZ3+DnT3XszNIi79dy3xBWuhtnGe4RkKi7QwFyH7PQ/nszV4idnHzqKb/pPiVJkuD6bV6YhD9WcnPEwGjgMNHB69iPan2m/QZ7K9kHJjveB2AQ0bONeuQdngYHsCjIAMneaBm3onadpRBJWBbO1BOI1taqEsUIQLi4E41NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BOo6omMN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 196E1C4CEF7;
	Thu,  5 Feb 2026 21:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770325783;
	bh=ozSFKEI79GoTdl4Ai30BuX7ki/qCvNy6lAkaQXc0be8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BOo6omMNOU/V7Y3wvJqieGrGTh7T7mPJ/Y7tCghO376ClRhel8CFZDM6qmtTPTiPR
	 x4l2PZgz/0PHUtpqZrIGY229PLfMIMHRYER67BfSspL+WIgOzSDk7/lIqC4DAg09q3
	 f1YD3QfRScn0J78jsm2ZbAZrS2auy/mBRabCCjque5965zP4WuyUcxpaC6keEPXtrI
	 6ot1iyRuQbWMjwTq9SARqPSJjRlCT45VV8gy3O4yDoi2haB26gPl91o7yrC6NbmMDB
	 XyUl11y1rwG8LA2gNe+We9e1kI7f/ublc8dEQV1nP9OpT2p0sNAvmJFNbsfS9gb2w/
	 LAVrEeXyLVI7A==
Date: Thu, 5 Feb 2026 21:09:37 +0000
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.1 000/276] 6.1.162-rc2 review
Message-ID: <cc9f247e-6114-4551-84a9-db465fdf4a36@sirena.org.uk>
References: <20260205143450.492803005@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="V8TIBEyu2wGfbch6"
Content-Disposition: inline
In-Reply-To: <20260205143450.492803005@linuxfoundation.org>
X-Cookie: Non-sequiturs make me eat lampshades.
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214557-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sirena.org.uk:mid]
X-Rspamd-Queue-Id: 0410AF77AD
X-Rspamd-Action: no action


--V8TIBEyu2wGfbch6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 05, 2026 at 03:44:40PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.162 release.
> There are 276 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--V8TIBEyu2wGfbch6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmFBxAACgkQJNaLcl1U
h9CJrwf9EYlVag8HvfadlHgRLZo52PMDPFcNdhUrM6x0APXb1GfwJQOsMVrx7KU0
lDU/K6N+MGBQa7aVm4rfZryCMuN3f1Z12uxQCBKtfvImxhbOzvuvgNDbfaxS2kem
FKGIRQjhQtBXDpWOIJ1zOlw2bfTbIir1Eeer5vFraFQNvZ1nwsbYiaH9BGBXcvV+
WDD4lYnMA8sGhX9bFEw/L6m6of+xg/PdVMVFdddP8RyoAV7Cu2NXqVA9bDgcHymU
FCxXg3Zn3KPE43CrS9TQwCYzGdAJO9MxiD4j7+0zK/pxSuonSX8wcii75pCxGZha
g+2rnLN6dsePxR7HgFRM9PQekcw4jw==
=zspQ
-----END PGP SIGNATURE-----

--V8TIBEyu2wGfbch6--

