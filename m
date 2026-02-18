Return-Path: <stable+bounces-217331-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIKSMJ9OlmmbdgIAu9opvQ
	(envelope-from <stable+bounces-217331-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 00:43:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA4E15AFDC
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 00:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A349C3020D45
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 23:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66FA33B6F6;
	Wed, 18 Feb 2026 23:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ek9ZrHmi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759AE33B6EC;
	Wed, 18 Feb 2026 23:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771458198; cv=none; b=c2RGVwFrSCxwpz+uOUOGwyTWdqaLBbq59qqlX6D2I6avOQD/42U+IXRLQ/U/mHcewUZ68fe0HXi2pzJha89JHgk1htdCaUKBR5qcfMXRg15w9BzxrCqrKhwJESHV2MCQNtbUenMjka6TSTsVEIHQGYLgyH9F9aGncaVqM5JGDIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771458198; c=relaxed/simple;
	bh=J+vdngK9xlY97MoUEHPtPajk0Jpc+O66Jq2xBaKy9Es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BR78/i281J6i7p5yJ6TkEDe5UAsxIvZRVaJasczismtRr+CLWgkbHquS5bN5z1LCeFx6vUjSRI4Ig0NyM0uJMrvyNdx8wvCzkzJSOHkpVWe4fTSVPelS6jsGufEX5G3OOEuaEDJ/5SvOkmxaZONUWczQyCZx8AXtP1hmZJ8Kc1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ek9ZrHmi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E822C116D0;
	Wed, 18 Feb 2026 23:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771458198;
	bh=J+vdngK9xlY97MoUEHPtPajk0Jpc+O66Jq2xBaKy9Es=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ek9ZrHmiS2TvE6LYffsGCuTCEm2I6WwwoW6+isfg1TmQ+VUgLCxS9AiAN4jiQVds+
	 Q0WDtDWB4cofjfsQeSaQ5tf5mtKhHXz1PQeVAgbP9qkyP4Hd5x+W0niuK69t6SqAeX
	 Z5qEEMkRb/5I7LLyZO+nDYu1zxqw2/Znr22ccHiu7rgxgD9r8EYB0kYvGxEXUM2aEW
	 6X/cOOonJvkCcJnGgAbNQ2lK1CnjKb653lD8LWZcTN88Op7VPnxOeobBIAm/GQjVlC
	 eUTDVfW0oGNe7Pj5YezylDVU2sjhghUwtKVOq3h7jmYBfoRzJIyioaT/3OWLiBEaoc
	 HH5Li2tc4leyw==
Date: Wed, 18 Feb 2026 23:43:11 +0000
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.12 00/42] 6.12.74-rc1 review
Message-ID: <0ab32ee9-5073-49b7-a33f-2eadaeea4431@sirena.org.uk>
References: <20260217200005.998240758@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rFVZ520gIl0cTu0+"
Content-Disposition: inline
In-Reply-To: <20260217200005.998240758@linuxfoundation.org>
X-Cookie: Avoid contact with eyes.
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217331-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 1CA4E15AFDC
X-Rspamd-Action: no action


--rFVZ520gIl0cTu0+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 17, 2026 at 09:31:51PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.74 release.
> There are 42 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--rFVZ520gIl0cTu0+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmWTo8ACgkQJNaLcl1U
h9AOsQf9FhehBZy5JoteMT3O7M7zA9zPv6B/aezN0WfK/+qO7hPz2gGZ2QZ6rYUo
D/cAUMKMthXDWWlby9LTc3C8i2WH0aa84h7WlbygckVIYNQ2mAJbiLMQnVCuDVsG
kY4QSZwLTWGtCcJvbCqDQdyNzGeEt2y4uzXDxxO0mCFOxCclxZ8CKu0blE4W/Dv8
mxX5IIv9LhtP4Tvm7jH/F6QCuP7+Z6dMJi7OCSTLDFSe86cV8Tq8440isaP29i1L
HuR8RnSPfLU/Lhu+xWvnVl5P7llAJSaKqQSgwJBW+rUz0NM0s4ufaNf5BrWKQGWa
DpQzRBALkoY09ZRN8uTVqakPVFwilQ==
=uVG3
-----END PGP SIGNATURE-----

--rFVZ520gIl0cTu0+--

