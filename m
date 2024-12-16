Return-Path: <stable+bounces-104334-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D58B9F304F
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 13:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C7C0165CA0
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 12:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1121204592;
	Mon, 16 Dec 2024 12:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sMnXtfZQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4DE34CC4;
	Mon, 16 Dec 2024 12:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734351480; cv=none; b=EBXqTc008qBaquxrZQWznuQ5jMd1K25Yb476xS63EHvp/0vi9Wmm+Sdv8J31mgHyNJCzTQu8LIVOb+kj9s3hRWzIaid3EdLxuAGNhHRbOktOltC7XfyO4sP1mssuXD4oW0UbknFD2zttKMYlgLZ19EUtaVGcL/7VM3+jdkcoaPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734351480; c=relaxed/simple;
	bh=9wUkqB8f8eK0RMLaMON1J/gQnYa58rUUdB2ULEUHmzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i1QlLSy6hpp3+RfuPkmpucFmmyKMFGYngcSfzXOUe8TgQZvhvUHNAUvUfnHu3ygFPaSI0l8dv08CTTIvw7cnoHawBJ4OZRFUbYejPwA75YSlLdDrsU1+kyfCvKMRHWHDj3RV32Tk3jyMXK0yD0jfNQJshjY98lEBsWtr7CtBmeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sMnXtfZQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F4C2C4CED0;
	Mon, 16 Dec 2024 12:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734351478;
	bh=9wUkqB8f8eK0RMLaMON1J/gQnYa58rUUdB2ULEUHmzM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sMnXtfZQp5EbWP1vD5F4aLPSj+F44yU5bQfri0VF6ER9/1j1y1ZVNbZn1oBo2rcQT
	 CmskZUR2XVc5kajkituXx4xSvlLgz2QE7XdhheQfioWU488mqgvrCKhzAeDKzYgITC
	 OtyJimBKhvXRGQf9O47IOIPgurSt0vttH5atAgMmEXWEyxBCoVae7DMe8w+PAVAwRk
	 mzU616Q22h3xl8eGwYfxsLeImgBJeKKc0rUIeuU7dEUi7jQCDQuhR8oCj8eLkKIIe/
	 dQ++IKBJJsKi1z8kp2q8DU9QlfFd3amokbHgc++IbTguzxUyuq8JIqqMShpJYc5IDJ
	 ca/EZ76UnrrcQ==
Date: Mon, 16 Dec 2024 12:17:54 +0000
From: Mark Brown <broonie@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Peter Collingbourne <pcc@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm64/sme: Move storage of reg_smidr to
 __cpuinfo_store_cpu()
Message-ID: <709a0e75-0d0c-4bff-b9fd-3bbb55c97bd5@sirena.org.uk>
References: <20241214-arm64-fix-boot-cpu-smidr-v1-1-0745c40772dd@kernel.org>
 <87a5cysfci.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="E9e43Uydk5bsqLo+"
Content-Disposition: inline
In-Reply-To: <87a5cysfci.wl-maz@kernel.org>
X-Cookie: Be different: conform.


--E9e43Uydk5bsqLo+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 14, 2024 at 10:56:13AM +0000, Marc Zyngier wrote:

> I don't understand the need to single out SMIDR_EL1. It seems to only
> make things even more fragile than they already are by adding more
> synchronisation phases.

> Why isn't the following a good enough fix? It makes it plain that
> boot_cpu_data is only a copy of CPU0's initial boot state.

That would work but it's not clear to me that that is what the intent is
here.  The current ordering seemed like a strange enough decision to be
deliberate, though I couldn't identify the reasoning.

--E9e43Uydk5bsqLo+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdgGnEACgkQJNaLcl1U
h9AYKAf+MF8iAaNQZfOzVcq7lqkYOmJEIvxdmbZaGy4HG4Qyq6EiHhR9proanw9r
zFm1HwS/071AORKmuW4ou3GTTKLbJmbFwX/y4JLpunQxncc0IEUqqPRN5d3ilWgV
avtBILCtQ4ioBR/4BfHUdR3l+pLei3Mm3HiZwzAGt0fcabqieAFGQlrkuu18uum8
7JMff+9Ki1Ndupfh4W8iVVhsf1cAl4DUw3SA3675SmAgjQdNIltbL1CPTiHpELn9
ycs9q/OOYvHexiTmEbud95/2d6tfau1vF1NZxP1lxBshdMf4fTx1KfGhSm/TVv1U
r9VtFi7sySnj59Bjl/JZNJM1Gb22RQ==
=32wj
-----END PGP SIGNATURE-----

--E9e43Uydk5bsqLo+--

