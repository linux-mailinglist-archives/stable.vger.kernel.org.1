Return-Path: <stable+bounces-104514-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B9D9F4F29
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 16:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36CC716D378
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 15:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A353E1F76C9;
	Tue, 17 Dec 2024 15:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKPvaHD2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526DB1F76C6;
	Tue, 17 Dec 2024 15:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734448523; cv=none; b=C6LJekvdDLN2UQBZkNVnn3nJqjXB/HuvlHspFZPPvc6d+vFjkkxasMGS58qXD/fg4v+cXAh+mDcpfrsT0LW8Z0lnQfjL1H1HS42wz1QjUxAxwZkJUb19/hSwYWeVaC3n8xEv/jqRSHibDho14CwXUGXUg/kHwBrW1B76NcNTgoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734448523; c=relaxed/simple;
	bh=XyBzWyFm+Oa6HFn+tgcvi4bYVxPgriTe6d6a2vwq+BM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c279B+dzzTDOB3UJWun2LzAvwMwGhXvFdjIHhEEnrNBqd2yK2ZtWkhAjsXljPO7zk23Oxny5R3TAVxAzqe//BDaMzp6znLTqekiAc/ArKV2lUqb/utcC0qgZZWJalNcW2YRzuJcWDPtCW72YuE3gn2fyECG3qqcucOZE9Ou8NHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lKPvaHD2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C81C4CED3;
	Tue, 17 Dec 2024 15:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734448522;
	bh=XyBzWyFm+Oa6HFn+tgcvi4bYVxPgriTe6d6a2vwq+BM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lKPvaHD236KF4bUZyabK77+kri+7LiLeKMKmDk0v8zu5kDHsid6CaSKCC4X+Piq6y
	 kIur1y7Y+7qHTOEo9i/bmQyampISRa+ESBdlR/F+wXfiS9L+NW90ZBodJbExdwcHxl
	 IzKvSszXES41xRybyJ43Y1UIju6peUeAlPwPSMSJDZpKRdT95SinI7GautUnhDuy+9
	 pAkQsKQ9yE3CT1ZhobfymEfgD9iT78lyT8rVZDcEjT+wm78qGuo8smE9X14e0+r5rD
	 nGdXRuMkLk3BA8CXKUhKwnPkphcoCiAjZDUQYhZC4y1wLY0ebD4C5b8i6xBv9gmp+F
	 nQR2cT4BRKHAg==
Date: Tue, 17 Dec 2024 15:15:15 +0000
From: Mark Brown <broonie@kernel.org>
To: Gustavo Padovan <gus@collabora.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, sashal <sashal@kernel.org>,
	"kernelci lists.linux.dev" <kernelci@lists.linux.dev>,
	stable <stable@vger.kernel.org>,
	Engineering - Kernel <kernel@collabora.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: Re: add 'X-KernelTest-Commit' in the stable-rc mail header
Message-ID: <eed95c94-a85c-4b4e-918b-ae57b04d2953@sirena.org.uk>
References: <193d4f2b9cc.10a73fabb1534367.6460832658918619961@collabora.com>
 <2024121731-famine-vacate-c548@gregkh>
 <193d506e75f.b285743e1543989.3693511477622845098@collabora.com>
 <2024121700-spotless-alike-5455@gregkh>
 <193d5237a65.c96d8ccf1557906.2641695653454944180@collabora.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IG0JiZSJllwxcGz1"
Content-Disposition: inline
In-Reply-To: <193d5237a65.c96d8ccf1557906.2641695653454944180@collabora.com>
X-Cookie: The sum of the Universe is zero.


--IG0JiZSJllwxcGz1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 12:01:32PM -0300, Gustavo Padovan wrote:

>  > Ok, in digging, I think I can save off the git id, as I do have it rig=
ht=20
>  > _before_ I create the email.  If you don't do anything with quilt, I=
=20
>  > can try to add it, but for some reason I thought kernelci was handling=
=20
>  > quilt trees in the past.  Did this change?=20

> If you can save the git id that would help us tremoundously right now!
> We understand it is ephemeral, but it helps during the rc test window.

> I don't believe our legacy KernelCI supported quilt either, unless this=
=20
> happened in a remote past. We basically pull git trees and are now
> opening the path to receive patchsets from Patchwork et al.

Yeah, I don't recall us ever supporting qulit.

--IG0JiZSJllwxcGz1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdhlYIACgkQJNaLcl1U
h9CRzgf/SM/P8DMDyq9misDeVCTdYFYwAX42P9MvrFhYBkxbS3lAVwrLm1Y1MFRA
5u9I91nvmfrEokQZyn9xAWmZy2FR8NEj9EoP3sE64SOCpiZDkCQxCbCJNd3RMG5J
Llm3YSxE2DgRn1cDyEgaJqfzso/kCVJKuQCKBavoHo1fJHynWg0ztLRP+0Qgrmwm
aXwsfjI9EO96VikwLxYrLzMtz0rrH+4cQKa2S85wN0Sgb6B6ruEEBB7YhiPSQFse
dl2kZ81TFVu6FZzqVi/sv06/Aq0oFHdzvvRirkgIU7ZAONn/NA8MpyTCZK7gmbzu
/dkzssUSqRswZo5QUJQJigVl/TI+9w==
=SEfN
-----END PGP SIGNATURE-----

--IG0JiZSJllwxcGz1--

