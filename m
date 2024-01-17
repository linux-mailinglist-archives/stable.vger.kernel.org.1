Return-Path: <stable+bounces-11850-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3180830757
	for <lists+stable@lfdr.de>; Wed, 17 Jan 2024 14:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 814201F258CA
	for <lists+stable@lfdr.de>; Wed, 17 Jan 2024 13:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDC1200D2;
	Wed, 17 Jan 2024 13:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oe+N5bnf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2551E86E
	for <stable@vger.kernel.org>; Wed, 17 Jan 2024 13:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705499584; cv=none; b=ZgdvqibuezUtWDKmU7nhjhqr2Wp2gTyHC7xzpBOxigXm8SbvR3QKUvyycv0iuCrjE5nDU2Ne80W01TgQfsp/YbXoWzVWGqUSSPtPFUoEjV6MXLvXotBBVyLtKayh9kUA4mdlRjqtQNowKW6z1KcMcP/BvXrOhXvVO/LdicBavWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705499584; c=relaxed/simple;
	bh=Koi7qdvNTEeBok9fRfClk9AINVkO/1D9kKzXxJHJbqc=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Cookie; b=DuA8CY02QDNGHnzjaRrkvt+XImOa4I8MHjnNz/d8S1RmBIdAVIa2Gh0rMXMbRcbFChY3G5DNQ1Yqbym30QI/mp721eEXTCKDlXWNZbrZVqoKWZdQ9tjLxmfeB68y5EYDKGkvMgOrKoZdq/lGP5p3idLTGDJ7LS1Wpal4nh8vtUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oe+N5bnf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79359C433F1;
	Wed, 17 Jan 2024 13:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705499583;
	bh=Koi7qdvNTEeBok9fRfClk9AINVkO/1D9kKzXxJHJbqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oe+N5bnfJl1ZV+xcdWqRZtijakd1Nvu8bC94wXLF4ui2dG6vY/KuXW67Ej5nzg2Cp
	 DideslDFB2ADMiP43X/SSlnV6ofGgyo+HWf0oaYpjvttpECX41AT9JpG/lcB9o9uYS
	 8XS+1nL5mWwJYJo0TZMKdR14oodszSQf6HMEKCueK/JXOnL9uvW2mBf2kYGO46MwXy
	 bPifnhPWYySvF0D4sJ2INzYP113/5mNu/UyPRxe3NqAWmBTC1dC2aEbYbqWZ0AX8Is
	 Q7WHd3rL8PZKQOYrg5IlSOf/4gLaNkAmhkYdZIn0vzGnNAR1YvTp82bnfR02YST7xF
	 RKJrJthSOFz5g==
Date: Wed, 17 Jan 2024 13:52:59 +0000
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, kernelci-results@groups.io,
	bot@kernelci.org, stable@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: kernelci/kernelci.org bisection:
 baseline-nfs.bootrr.deferred-probe-empty on at91sam9g20ek
Message-ID: <82cda3d4-2e46-4690-8317-855ca80fd013@sirena.org.uk>
References: <65a6ca18.170a0220.9f7f3.fa9a@mx.google.com>
 <845b3053-d47b-4717-9665-79b120da133b@sirena.org.uk>
 <2024011716-undocked-external-9eae@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TOyMNm2/BhIVCEYy"
Content-Disposition: inline
In-Reply-To: <2024011716-undocked-external-9eae@gregkh>
X-Cookie: Nostalgia isn't what it used to be.


--TOyMNm2/BhIVCEYy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 17, 2024 at 06:55:09AM +0100, Greg Kroah-Hartman wrote:

> This is also in the following kernel releases:
> 	4.19.240 5.4.191 5.10.113
> do they also have issues?  Does 6.1 and newer work properly?

Current kernels work well, I've not had reports generated for the older
kernels but it's possible they may be forthcoming (the bisection does
tend to send issues slowly sometimes).

> And wow, this is old, nice to see it reported, but for a commit that
> landed in April, 2022?  Does that mean that no one uses this hardware?

I suspect it's just me, it's in my test lab.  I don't routinely test
stable (just let KernelCI use it to test stable).

> I'll be glad to revert, but should I also revert for 4.19.y and 5.4.y
> and 5.10.y?

I'd be tempted to, though it's possible it's some other related issue so
it might be safest to hold off until there's an explicit report.  Up to
you.

--TOyMNm2/BhIVCEYy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWn27oACgkQJNaLcl1U
h9CLCwf8CecA6aqF72V9ysuKxFHLzuv/+WVpaUhxn+whbKZKelsK4LKzPByQ/gp6
u58u4O6ALnCZkrz4LF9pnLlT4b+2mEg3/O88eN7a6N4jJ+yJrACzSpUN7Wd8/vNE
92npkRPG+vjcfuj4MxgW46m1eqFVP7zHSUQhZIc+hfp7mGPteCAdgBOE4yHI2+5r
mZHFRgG48w6eJg0xd1ZhMI5vlCQKRPHrRriRL4gOq417FZGC/Hj+fYiY7tbi65wY
gPAL4slf1RAHMb3daaTmvZn8gRMZy6MBz9ndYQkFzFQ1Ct60UtkVhQg/ZJMHOZ8g
JzcKVMmgAW3+pClvFqEyYatqlTSTyQ==
=cMiE
-----END PGP SIGNATURE-----

--TOyMNm2/BhIVCEYy--

