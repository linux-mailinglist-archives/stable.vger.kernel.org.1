Return-Path: <stable+bounces-12189-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83258831B63
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 15:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B197D1C213C6
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 14:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F5939B;
	Thu, 18 Jan 2024 14:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cujLm8GW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C24370
	for <stable@vger.kernel.org>; Thu, 18 Jan 2024 14:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705588402; cv=none; b=JECIdGuqYC7bTkRXGDr8HAP40yJWugHE2+319xk5VZwI/PaoYAxxBbwp35c+H3183tcYbtCGRjFDUrCg1rniB3VQ8o4mVfiKP8EBjTqjwDNqd9g9xjO8sXmfxCWSe6IMjcjKOvppWg64wG+yzQtQ0Khe774a+zaZqEkYVw5Xl1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705588402; c=relaxed/simple;
	bh=MIG8l6nmrNn7lYT/nKSCX4PbrTY8Ix+7cWQ/iiL/nU0=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Cookie; b=PVZbT70AxK88YXl9lF+zNkyr0KLdWzdMS0SmUBHgd6CPUaUVHSO1CWNtFgMU+Ji0Nlg7Tw4m6Yg8Uu+yzhazn+hMhGCW7S9HbO/iHpkaE0N4VC20Pg+EMU9DjXsBHFY5e3ptN1f4tXfYA+SOFTEzyKZAstV+wcnYFPk3hd8vWDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cujLm8GW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A19C9C433F1;
	Thu, 18 Jan 2024 14:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705588402;
	bh=MIG8l6nmrNn7lYT/nKSCX4PbrTY8Ix+7cWQ/iiL/nU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cujLm8GWbnwUERBichoaOhYy4uRQRiB+9nhVdhurReCoGZJoS9Tpb1xCtT+3wa5m1
	 KkdcnclSZIblhf5MQLw6P8/WrAaABl+dWOsOvmQ/mv3xJ93rnf/04ezaZUWp7q5+IU
	 Z7BCCR4ZQCcvHUU10hziB8EoAJzuybTB2wkTpeYzQlCnoWaP8D2PZRculsNj+RYnL5
	 I7sqy0Mu4QJNvYTLP5SM9ErkdFfC1m8u3Q6vFjy65vWxJPQs8zZBP2e5BHxuonYM3y
	 qAevdOC4D+ZQW5ElqqLbM/MBokY3bxpC3igoW+yr9bFqkKOu+SUtBZQrzfh09+l+Kh
	 WA1xmtd9PSrow==
Date: Thu, 18 Jan 2024 14:33:17 +0000
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, kernelci-results@groups.io,
	bot@kernelci.org, stable@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: kernelci/kernelci.org bisection:
 baseline-nfs.bootrr.deferred-probe-empty on at91sam9g20ek
Message-ID: <3c7cf19d-cd94-4d94-b4f5-1e0946fd0963@sirena.org.uk>
References: <65a6ca18.170a0220.9f7f3.fa9a@mx.google.com>
 <845b3053-d47b-4717-9665-79b120da133b@sirena.org.uk>
 <2024011716-undocked-external-9eae@gregkh>
 <82cda3d4-2e46-4690-8317-855ca80fd013@sirena.org.uk>
 <2024011816-overstate-move-4df8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w+U4ZqyVzO4Jtn1S"
Content-Disposition: inline
In-Reply-To: <2024011816-overstate-move-4df8@gregkh>
X-Cookie: FEELINGS are cascading over me!!!


--w+U4ZqyVzO4Jtn1S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 18, 2024 at 11:16:29AM +0100, Greg Kroah-Hartman wrote:
> On Wed, Jan 17, 2024 at 01:52:59PM +0000, Mark Brown wrote:

> > > I'll be glad to revert, but should I also revert for 4.19.y and 5.4.y
> > > and 5.10.y?

> > I'd be tempted to, though it's possible it's some other related issue so
> > it might be safest to hold off until there's an explicit report.  Up to
> > you.

> I'll just drop it from 5.15.y for now, thanks!

Thanks.  I've actually just seen that it's also failing on v4.19, and
went looking and found that v5.4 and v5.10 look like they never passed
which means it didn't trigger as a report there.

--w+U4ZqyVzO4Jtn1S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWpNqwACgkQJNaLcl1U
h9DOKQf/f+nuMbCRYaskeplgeWy/jNCrVYUGOBw9hMpfQC/+SfhKzCuKzjgBcs1f
PwWPq8pQngN344lTqTNdskB8D2Ox0emqMQyEhE3TLNeJZaC6BfDXc6k2iTwdEvPK
phDwjXYmkC0rnTqvyyEOQFIb9UHK5Yi+BgEVJQBG24NqWl6BB5dVh8gUfJ6AyTMg
UC7JufAxOjHRi+iETXHk1UEivchkrIsR5bDscX21C++GmgTfWE/gxXCoh6999nYv
249k4lp+RbkwnnrnKZFJxZ3pP8TlOMN8URBJfG+p00l9o2QPECzO94Bsdps/OqtY
QunETQ8tTX85kI5noAkdmjR3a+Or1g==
=5Ls8
-----END PGP SIGNATURE-----

--w+U4ZqyVzO4Jtn1S--

