Return-Path: <stable+bounces-222473-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLOsEm1npGlcfgUAu9opvQ
	(envelope-from <stable+bounces-222473-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 17:21:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EBC1D0979
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 17:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 769EE3012CDA
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 16:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D1733291F;
	Sun,  1 Mar 2026 16:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3hkcp29"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53484332629;
	Sun,  1 Mar 2026 16:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772382034; cv=none; b=XUHfoyhBfy1taspD9qMH9VENf2TwTWJbNWXMyOW66rluTcYH9nQ0KuraCaApBKGvtvYM/es0lylaKAjoXKiOOkmHVpCK3fpuqPb5FMBLAXlfBhV3mYCHmSlZ+0iLJShemxdFfPaF/cGYKyFnD9Q1unG/jZBObyFTaSLhLohTSBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772382034; c=relaxed/simple;
	bh=OHnRHFrYC6glnsMCUEwpsr4r4ZAcDMkIrINt16eHBt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cvGeiixXl2mecjKC2MR6z0vyWtdWCaYW9XTUUkeqgFxr1cc/F40LELqRDeoD0udMf27JLQ2yI5+Ht6FNm5m1n1g7139qqQBXdNQ+pD/IRUSaNivcigsgMIu4VbFSe4GPGNGYTKVyq3gkcd+UF1AoMp580vG65VlNAZqjP/i/Lt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i3hkcp29; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18EE7C116C6;
	Sun,  1 Mar 2026 16:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772382033;
	bh=OHnRHFrYC6glnsMCUEwpsr4r4ZAcDMkIrINt16eHBt0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i3hkcp292V5I2MSIREFNM0Mp00Rm0O9MqMlAcA1R6Kd7I0UGE5DdQuzFRTcz6GEOi
	 o6f8kJSZ3++mo85gDGWDXuOi7mdYfi+VOI8zmAqbUdTKH2m/ayBo6gplCcYNkcOYgU
	 BtNR6NlH44Dbd3CzEQgyldl6RdETu4DbjSS51stxcwClAHjHVvGw2IseX+tJ2YYxFT
	 F1dlfeV7qLzo3sNPBXezwunPYleTzi/AbTT4/LUUPMprbCMnTt+Z6VTJIF2Xoq5yR8
	 kFM6Ii1IlGeCNzHEgy1B9k2jxorZH5MpAbekXQzkLeDe1T5AjysI8B9U8pP5n01Qrp
	 igcMiLL0EWYMw==
Date: Sun, 1 Mar 2026 16:20:27 +0000
From: Mark Brown <broonie@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Peter Schneider <pschneider1968@googlemail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	patches@lists.linux.dev, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.19 000/844] 6.19.6-rc1 review
Message-ID: <9c67aab0-7199-4958-a2ca-81da34ba1ca0@sirena.org.uk>
References: <20260228173244.1509663-1-sashal@kernel.org>
 <aaQriDS9IOr6tI4x@sirena.co.uk>
 <055deed0-4b00-422e-8afb-5c3e577a6046@googlemail.com>
 <aaRlIJFcOpBVlD9f@laps>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/Hy1HOMXoJc1WvVv"
Content-Disposition: inline
In-Reply-To: <aaRlIJFcOpBVlD9f@laps>
X-Cookie: Sic Transit Gloria Thursdi.
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222473-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[googlemail.com,linuxfoundation.org,vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B4EBC1D0979
X-Rspamd-Action: no action


--/Hy1HOMXoJc1WvVv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 01, 2026 at 11:11:12AM -0500, Sasha Levin wrote:

> For the release deadline, you definitely shouldn't sacrifice personal time to
> test: at the end of the day, releasing is a judgement call, and if we don't see
> the usual reports then we will hold off the release for a bit until we know
> what is going on.

I know that I will be put off looking at things if I see the deadline
has passed, it always seems likely that either the release happened
already (as happened with the ones I mentioned where there was a
regression, I only reported that because there were a bunch of very
clear reports about an issue I knew about from my tooling) or it'll race
with me checking.

--/Hy1HOMXoJc1WvVv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmkZ0oACgkQJNaLcl1U
h9D6pgf8CnfYumYkuZGVW06FH6iZQ5BQRCswzm9Q4yT9va1Ebpqvx8Nnsraq+U51
28/SWFCeRqcwiDx1AgFe6zVhdk15LxtxRLEKdbzHqVRlD/VDscmxub3EvZ3JRNFz
awhTFo5gMvo+CjfCUwLjKIURzyQ9CTTVE0NTJ4gWeJNidYvkuJI3mfy2cd9Qhz1Q
Y9uje9U6Od6Ra0A2wiQUIwAET0VRePlZF7q4CODEvUX/YfPdjgnuX6awxPQC23FS
YkKZdGnYtIT3Z/GkWcDn1WkrTT2+m1snAZsYg9WQEgOA5eFCs1FI4yuGj7Mkt/AM
SZi88+VrxbwSLvP23QUHSeYL6+I7Vw==
=+mA/
-----END PGP SIGNATURE-----

--/Hy1HOMXoJc1WvVv--

