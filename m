Return-Path: <stable+bounces-219593-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJ70H9PgnmmCXgQAu9opvQ
	(envelope-from <stable+bounces-219593-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 12:45:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CA3196CE7
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 12:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFCBE302494E
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 11:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66DF396B65;
	Wed, 25 Feb 2026 11:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="txGgfxua"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC539396B7C;
	Wed, 25 Feb 2026 11:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772019798; cv=none; b=QEoPJUesS8dqT4cfkqMPLcCyer3vi1iIStL2j4LzcRzbZef5zORIaln7aUS3JbPcbkXaRL3WyjFcAo1LqmDFsExbqVqGTDQsXv50hfbNEaMqCP9g3cbQtyp6RH6kephetM6WksJRRhjoovABI/qK8yLTUeTEYI9D0rECO0FU278=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772019798; c=relaxed/simple;
	bh=zz8EydAPl3MV3Fr68dgL9OzVrvHxLae1+94Mq6XnURg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OK8GSOf65sxYV6XG1oH+PAL881UzdCOefmjFMA+84l8hLVbiBm88I24K9JWdk1TnVLnTBMc7iEWWY0qOfkz/Anyjp8RgYXPf8/ZpFmcDDLhxjppzaRFBa4DXvR7NEX4KrN6KI0+pp2MiTU/1fHf4ia41pt8IQvHDxxBUYC87qv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=txGgfxua; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D47C116D0;
	Wed, 25 Feb 2026 11:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772019798;
	bh=zz8EydAPl3MV3Fr68dgL9OzVrvHxLae1+94Mq6XnURg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=txGgfxua/8cF/MA4o1Oz9VbVKEhhcvMq3HTHsCTzWoD9XN7QvmavFYtCRRbfnNsdn
	 FUk1IYrSC0Ydjysmf1Pe8kk+C7W5lCaCQ+0+9PUgkXse7CvS0mEWFUv+jCaC6vgsr4
	 QFx7uRUP/kMdkyN7twncOk1YwaMmV3jpma+Y/6qYZTm5rJQPiq1CClhPRAXy4lpWnb
	 UIswNC7JLv0BCOAZr/LrJzDAfpZD3t88tBcLSJNJPGq53uz8cUyuxHCGY7mYnJ4p2c
	 HcN0VH+xoPxf7Q0fP1bFrtEpbC9Z8dpMAqMvCb/HQsCWrTqkSsRXPWL+ih1EJZIV2r
	 Grzk5LMbRb8WQ==
Date: Wed, 25 Feb 2026 11:43:11 +0000
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.18 000/641] 6.18.14-rc1 review
Message-ID: <457362d4-c400-47a2-834b-327ded7d6192@sirena.org.uk>
References: <20260225012348.915798704@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="e7VJNWWj2VJ4Z7WY"
Content-Disposition: inline
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
X-Cookie: From concentrate.
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219593-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arm.com:email,sirena.org.uk:mid]
X-Rspamd-Queue-Id: C9CA3196CE7
X-Rspamd-Action: no action


--e7VJNWWj2VJ4Z7WY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 05:15:26PM -0800, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.14 release.
> There are 641 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

> Kevin Brodsky <kevin.brodsky@arm.com>
>     selftests/mm: fix faulting-in code in pagemap_ioctl test

This breaks the build of the mm selftests:

  CC       pagemap_ioctl
pagemap_ioctl.c: In function =E2=80=98sanity_tests=E2=80=99:
pagemap_ioctl.c:1169:9: error: implicit declaration of function =E2=80=98fo=
rce_read_pages=E2=80=99 [-Wimplicit-function-declaration]
 1169 |         force_read_pages(fmem, nr_pages, page_size);
      |         ^~~~~~~~~~~~~~~~

IIRC there was a patch adding that function.

--e7VJNWWj2VJ4Z7WY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmme4E8ACgkQJNaLcl1U
h9DQGAf9FeGTkDXEir9kS60ZUjm/vCivAMAYVcB2d1KOA4u/YjTu8BFXhghdkBAQ
a9GoRTAU6xYdN/Xf/HFQQxv7BEC9tpiM1ugTqLaa2091ZjNjh2Omc9Ys1KmoPHHi
YwseObb2AgdrXZmUd2FPA14NUOCsF/zFhSBPTL+dKeFRsNmOqdPfG9Q3wmfnPoSp
QIi591V9ys/SjZMrJJJC/wPXb5Ca6HdXpO0PDiqlKpPlPZls9h7duksJdpbsVKMq
BuUGoKxvPTVMyLHlbjHYEr/Xt7sdGODN8niyUODlYi6t6Ukv+GI6wFHt4j5Kt539
FtDtbKan5oMzFffkw+0FRtN9dTxwwQ==
=J4eN
-----END PGP SIGNATURE-----

--e7VJNWWj2VJ4Z7WY--

