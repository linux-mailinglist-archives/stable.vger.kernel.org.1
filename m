Return-Path: <stable+bounces-3675-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 826348013D7
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 21:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DABC1F20F1D
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 20:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B082F51C21;
	Fri,  1 Dec 2023 20:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0yVGh7M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7337654BC1
	for <stable@vger.kernel.org>; Fri,  1 Dec 2023 20:01:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8AF5C433C8;
	Fri,  1 Dec 2023 20:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701460901;
	bh=eO0+A/HoDSUXkRzZYBTH4WJttajSMnTAC/ilJrr2b+g=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=Z0yVGh7M8sUHaxzmBGXP/uhJvlMZo1QvDo+u38ssMkZSwc4XX7TlReiKiCdk6P/2k
	 VU7OFp+IfVGwH55/whD1sHyzxSVso4oGqclMT4LZHeEph5Xx6rgwZnKxbCj+r6Lqio
	 UrZGc58gBfjaCTR/yuGRok0EZ2SvS9R4+5lSA0aEfm+DlJOWuvaAjsdgHHZpwV2S0q
	 bw9lEmUSZnYJJSloJarRf7YkQ5S6GG2N/kl5CHZm/xWdoPcEPtsL/uqp7siUZw3h9h
	 m98lDoPMJCfy3ngUCOXKGybzXiMH6au43I9kcBaECH5HMnfrUexYgqhyx0Faxgi2hx
	 kL77x2GoS4cYA==
Date: Fri, 1 Dec 2023 20:01:36 +0000
From: Mark Brown <broonie@kernel.org>
To: Matthias Reichl <hias@horus.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	torvalds@linux-foundation.org, stable@vger.kernel.org,
	jslaby@suse.cz
Subject: Re: Linux 6.6.3
Message-ID: <dea2db44-2e13-47c1-be0b-8548bfd54473@sirena.org.uk>
References: <2023112811-ecosphere-defender-a75a@gregkh>
 <ZWo45hiK-n8W_yWJ@camel3.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yLjAKkh/iKJFbDI8"
Content-Disposition: inline
In-Reply-To: <ZWo45hiK-n8W_yWJ@camel3.lan>
X-Cookie: The early worm gets the late bird.


--yLjAKkh/iKJFbDI8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 01, 2023 at 08:49:58PM +0100, Matthias Reichl wrote:

> I'm not familiar with the regcache code but it looks a bit like the
> return value from the regcache_read check is leaking out - not
> assigning the value to ret seems to resolve the issue, too
> (no idea though if that would be the correct fix):

That looks sensible, can you submit as a proper patch please?

--yLjAKkh/iKJFbDI8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVqO58ACgkQJNaLcl1U
h9BZUAf/R0pVAXDalAF0Bfn7Of6eKAwLqYXSIdXvgq+CKZ6wfJlzAO6nKAbnEIc0
R/dhGkURtTHhE9XNVoFYLiIx5xfOxlAi0D03I753lKOYmTspm0alp+BgoVvFWnpy
uE2Kl8mCycb7BwO17BFIc1Lf8PPdHTzGEhDiG4uWX/2wnjGVBnKaYuTNdOIr4jc/
iC0PdgWCJxvGYKz67wJ4DSO8lKV9/oky4Etcgcix1ZOCrvAgXXICsgzpDDuc1BDJ
29Cm77qEqckdPfyt8UO5ziZtPQeBxw93QDpFTJOtUo9rhtKrwPUObNqJNNFhuqEM
Sh5gua5CigMj0MpxQOPDTF/QTiZEFQ==
=FoTj
-----END PGP SIGNATURE-----

--yLjAKkh/iKJFbDI8--

