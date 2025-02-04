Return-Path: <stable+bounces-112230-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C32BA27996
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 19:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCD557A404C
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 18:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B788C217713;
	Tue,  4 Feb 2025 18:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOTiZah/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7633A217675
	for <stable@vger.kernel.org>; Tue,  4 Feb 2025 18:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738693063; cv=none; b=nwkQnXTuPWw4469UghdETLg5HG7vy+ibdncvkbIjHVNnBSgoGWU5zECdD0wUptIpnMxSHE/rOPv+sxVxGFT/Ch1Z2sLpwKll+lMI7jEO8UC6dilXVLftKqUi5UkxLLmbnFLNr9+J6+0KOvjne/vv7nQZT37ZGoPNM2Bp12ofvxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738693063; c=relaxed/simple;
	bh=Sw8U9kTjkLY6aEnji2ECrHJZ3r/qqqL1tuyXzmBlkqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HfUCr373PXWT5Bwz9hgE6kcXP/yP4Qd+qXlJKrNPXZoOGCVp2ERaSVQ8ykWtZMmg+k/OSNIM2KViKW04wd7q4M7hoedQIv0n7nHIWx5ajIM5xFlHiBwUIYWWOp0xOimxGiLv9pviNT6WhVJWBNumNOJDD8BNDpMSeQ12CnwRKhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nOTiZah/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46D18C4CEDF;
	Tue,  4 Feb 2025 18:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738693062;
	bh=Sw8U9kTjkLY6aEnji2ECrHJZ3r/qqqL1tuyXzmBlkqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nOTiZah/1fWieKswvTMv8qpK6vBxN5vXNT4+ZpHndcpzSXBn2TJ2v0JbMxe8oiRDS
	 3a5/sK48jNgd41BCktAyaG6whT0BmJPe2PKyf6dHBjiB7cpX0wLVRA69dZhp7+s2eo
	 juoWPQGOjr2PKwXivMr/Jxbdmn0P79klUlgHwqBiYSP9QhglT4pQBRARArZ0hP1GNA
	 bCIExgJUaJ/iRlvkY6hcyoWesH1W63R/wBlKo1dNCoUD6mcuFsHN07nU0pTPjQAVch
	 4tT4HTtb6CjhhGTGHZzSKdSFB8fIP5qjbg8vX15IRtKuo/yTC/KJCF2XSgseyfqIht
	 CSRicwMy5muiQ==
Date: Tue, 4 Feb 2025 18:17:37 +0000
From: Mark Brown <broonie@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
	eauger@redhat.com, fweimer@redhat.com, jeremy.linton@arm.com,
	maz@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
	stable@vger.kernel.org, tabba@google.com, wilco.dijkstra@arm.com,
	will@kernel.org
Subject: Re: [PATCH 7/8] KVM: arm64: Mark some header functions as inline
Message-ID: <ebbb173f-20f5-41ae-888e-3f7e17d95305@sirena.org.uk>
References: <20250204152100.705610-1-mark.rutland@arm.com>
 <20250204152100.705610-8-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="b8/wShEAoU0ikRmk"
Content-Disposition: inline
In-Reply-To: <20250204152100.705610-8-mark.rutland@arm.com>
X-Cookie: Spelling is a lossed art.


--b8/wShEAoU0ikRmk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 04, 2025 at 03:20:59PM +0000, Mark Rutland wrote:
> The shared hyp swtich header has a number of static functions which
> might not be used by all files that include the header, and when unused
> they will provoke compiler warnings, e.g.

s/swtich/switch/

Reviewed-by: Mark Brown <broonie@kernel.org>

--b8/wShEAoU0ikRmk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmeiWcAACgkQJNaLcl1U
h9ANAgf+Jy3fodyIBVqokO3f/5/eENAYy6sTyjjmuNLlV4r/icm3MyeBCvmrhN+F
szGJ3biAIfeGG/jVM9VnragsR4LZnrMBA+DnMd5zaUoJKlsI5o5ZJekIhLl24g73
cKcjBQxtcFIP1ZttSJqWQhTlLg9BHvFZ+0oL2PiwzwWU/ArW7Igj+ki9BGzT2J7g
+M/TLjM2y7YEn0vO23tzOiKX5WRGiOQPS0cdMBUr83ipvJhAuknBDKIRBPBW4EwL
ZOTo9iaPC0Gf9jl/0W+JLahF12lDL6IpFXn1GIcfxrTF0krA2XINNgQKyU2NpWa2
JmBtijaFZG/+Z1K5KE06RFLXqi66Bw==
=pvgD
-----END PGP SIGNATURE-----

--b8/wShEAoU0ikRmk--

