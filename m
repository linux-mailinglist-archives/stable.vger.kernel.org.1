Return-Path: <stable+bounces-167123-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 641E7B224B3
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 12:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CECB3AF5D2
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 10:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0A82EBB90;
	Tue, 12 Aug 2025 10:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLLLPtQv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA80311C27;
	Tue, 12 Aug 2025 10:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754995012; cv=none; b=RTLqOlGJr4rq5gpuX0Q0NDHU4AxpbT2l9RCctPV4LbqKi8nfdEFLZLfsotQ5gw3V3qgvVSXRdkjYTWRlnrSNf9eG9ymUkPRnwVGYfU52BMk5qUPTmz5zstopZK8HvDaLqBX1woc64+OO/6G0KVr00uiZLXTxP8UABwcIa7hOI74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754995012; c=relaxed/simple;
	bh=OFretCNfXEy+7WAgxha0BEDu5axRqDUYgdbF/L5SJLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WCimSX8iLredBuuwcJDrzRwfPck5J6nZkKxKLWzx4K8M5xICdnvHo9gWSUkpMoh6KH0v/phFkpG2/2nT5gdzXZrpgo+yMDjgV/EE+pz2q3UHAYcP3eVKKZvJm8+EggXojlrM6YcMW7g5Pc10UxAfBjTsT+/Ww++Fr03cWsj83Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLLLPtQv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35911C4CEF0;
	Tue, 12 Aug 2025 10:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754995011;
	bh=OFretCNfXEy+7WAgxha0BEDu5axRqDUYgdbF/L5SJLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZLLLPtQvD1Abvx9U5zycPlODfxhKkHb41FkrJX3gQS9u5RQf00n+3/AG5aq4A5FXY
	 svplmQ3op5e5aJn2SsJWdpu/KMaLDRMYVcwGjiL8uGaeMDoPl103btLwY/6JhC+kyI
	 mlVws48ItOLX6GX168HCIxgzuOaFz007pZM6xT4RyKxc3bWbeNr3v54Vje8WXdY3vi
	 YGBtcb56KPRVJbSgIbVYEUpExCrxWNFWojt1K5Kl5JK65eTPwS975v9NXSj2knKziP
	 w+AUCMgqmEAU8d9F6pLOgbefoOIqv94vKp3WFWjejhXg7jGAOToZC4DvygenEPqz6L
	 aismFdpQSw8TA==
Date: Tue, 12 Aug 2025 12:36:48 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org, 
	nicolas.frattaroli@collabora.com, Heiko Stuebner <heiko@sntech.de>
Subject: Re: Patch "pwm: rockchip: Round period/duty down on apply, up on
 get" has been added to the 6.16-stable tree
Message-ID: <tjogt2ovj4afxo3lz7ydwsqtk4b52gjvga47es6x3ogdbfopyb@weiw3effavjh>
References: <20250808223033.1417018-1-sashal@kernel.org>
 <c5s7efnva5gluplw65g6qqxjqpmcgprgtm6tsajkbdqibe73lb@lw5afb6b725i>
 <2025081236-moneyless-enigmatic-891b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fdxsqeksetlwy3w6"
Content-Disposition: inline
In-Reply-To: <2025081236-moneyless-enigmatic-891b@gregkh>


--fdxsqeksetlwy3w6
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: Patch "pwm: rockchip: Round period/duty down on apply, up on
 get" has been added to the 6.16-stable tree
MIME-Version: 1.0

Hello Greg,

On Tue, Aug 12, 2025 at 10:53:11AM +0200, Greg KH wrote:
> On Sat, Aug 09, 2025 at 11:45:23AM +0200, Uwe Kleine-K=F6nig wrote:
> > while the new code makes the driver match the PWM rules now, I'd be
> > conservative and not backport that patch because while I consider it a
> > (very minor) fix that's a change in behaviour and maybe people depend on
> > that old behaviour. So let's not break our user's workflows and reserve
> > that for a major release. Please drop this patch from your queue.
>=20
> Now dropped, but note, any behavior change is ok for ANY kernel version
> as we guarantee they all work the same :)

Your statement makes no sense, I guess you missed to add a "don't".
Otherwise I'd like to know who "we" is :-)

> So good luck with your users in the 6.17 release...

Yeah, thanks. I still like reducing the changes in stable that have
little benefit and the potential to subtly break workflows. I don't like
that potential breakage for 6.17 either, but there it's better
justifiable and that's the only way to get the improvement in at all.

Best regards
Uwe

--fdxsqeksetlwy3w6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmibGT0ACgkQj4D7WH0S
/k6Pmwf/TIdg/OTpD/yvxFOq2cBfoOf0dOp3RcVaqut1waVKjayKeSy43LFtDpBM
FzikjXJ9pYQ1eMHQRTNCAjfPJ2uJD4pii1EigVQeROPeUDRJDkKqbIKbA7m40XQw
caDTx54C7OE0kZRuU4x4JlF9bV6TQNVDUbaf0RX2VTM8hguL6p7FN0nnhpk0Nuxi
A9xEe5DfF3kTGm0zCM93nDiwFVWhWqXEU7ESE3LyPro6M7GL1aXU1kGJApQp3ZbD
VqD4zQtJ143Ax4pHAWNThGcH/7+Zj9dP37fXG8PZzaAXN5UEo2Meh+gBPdJNf8Ic
J1lvKFAGOMMdgOYF/L7QG+x9jimv9g==
=S0IP
-----END PGP SIGNATURE-----

--fdxsqeksetlwy3w6--

