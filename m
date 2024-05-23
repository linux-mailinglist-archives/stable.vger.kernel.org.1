Return-Path: <stable+bounces-45673-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF448CD1D1
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 14:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D02AE28457D
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 12:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B95E13D896;
	Thu, 23 May 2024 12:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nnb1r+TH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246E013D274;
	Thu, 23 May 2024 12:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716466206; cv=none; b=KLjBDVEC1vXBiiDdj8WPp3o2swzLagfNTH31LowSf5n+tIf9oGcEwbUiuq7w3DAu7Ufq+7N5InaqpCGBDtNGVbWKCvJUdYOQ0G/2ffmx6UpFeXWpj6EMeIxF4RZ2g9zgnV6NrXebWRZQBgxHgYm8SDtrOPaOjD8foRGOZMOBVmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716466206; c=relaxed/simple;
	bh=dV3gYhQ/CCKnsQ1isxyygcfcGCTLC98tQVo44ro3qlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GbU0If1/B8VpOaaxAa9Tk3DJh7lyMXD9m1wr1FWfUJM7bvOQ1KN/P/dm9KNY13ACaOTJONTOBsjIM5Vy0P3VdpG9VPabWDbxzGJcfYUOWdUtoAPP2nesJEto6dFrswragFeG8kNcuNcrR8kq/Li1YbtRCLJRy0r6BMDNf91PJVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nnb1r+TH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A14BC32782;
	Thu, 23 May 2024 12:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716466206;
	bh=dV3gYhQ/CCKnsQ1isxyygcfcGCTLC98tQVo44ro3qlY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nnb1r+THjTZct8yaqV6VR7y0U0NbSh9ncvJe1MSO/hbQGyZgJx0JSK9xgeYulzbrU
	 KfcMH8TNKdZUADcCTwZJE1fikT7vuqCi3ZEgksn8xi7yI/r2tN902568Wue9VIB9bN
	 pM026ERB0RjIHpSzCMEUs2YkgTZyNFQQ5hJuHNnjK/HZMKIrFAJardonZ4Ah+ad/gD
	 HWGlP8gR9K83PjTHP+X6FHCaievhqgWlxbPl+DfC28oHjuH2bKgHQMqA3GyGU9e/Xu
	 rfJqEoLRpXCrl6e3SbpxX6MeCXD7HGKPl8fL6Z+qjhTFizk77PjYbT2P0xCh4No5gI
	 uw0VWgt3BJdCQ==
Date: Thu, 23 May 2024 13:10:01 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg KH <greg@kroah.com>
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, lgirdwood@gmail.com,
	linux-sound@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
	kai.vehmanen@linux.intel.com, ranjani.sridharan@linux.intel.com,
	stable@vger.kernel.org, yung-chuan.liao@linux.intel.com
Subject: Re: [PATCH stable-6.9.y] ASoC: Intel: sof_sdw: use generic rtd_init
 function for Realtek SDW DMICs
Message-ID: <a46744fc-541c-42f7-99c9-cc2f1236f960@sirena.org.uk>
References: <20240521072451.5488-1-peter.ujfalusi@linux.intel.com>
 <2024052345-manhood-overrate-6b7d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MgIJRqG73D2t8Nbi"
Content-Disposition: inline
In-Reply-To: <2024052345-manhood-overrate-6b7d@gregkh>
X-Cookie: You auto buy now.


--MgIJRqG73D2t8Nbi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 23, 2024 at 02:02:53PM +0200, Greg KH wrote:
> On Tue, May 21, 2024 at 10:24:51AM +0300, Peter Ujfalusi wrote:

> > The only thing that the rt_xxx_rtd_init() functions do is to set
> > card->components. And we can set card->components with name_prefix
> > as rt712_sdca_dmic_rtd_init() does.
> > And sof_sdw_rtd_init() will always select the first dai with the
> > given dai->name from codec_info_list[]. Unfortunately, we have
> > different codecs with the same dai name. For example, dai name of
> > rt715 and rt715-sdca are both "rt715-aif2". Using a generic rtd_init
> > allow sof_sdw_rtd_init() run the rtd_init() callback from a similar
> > codec dai.

> > The fix for the issue somehow dodged the 6.9 cycle and only landed mainline
> > for 6.10, before -rc1 tag.

FWIW it's quite buried in the changelog that this is a fix (I tend to
just zone out the presence of a Fixes tag because people just put them
in for no reason) - the subject line makes it look like a cleanup, and
it's not clear from even the second paragraph that we're actually seeing
issues in practice as opposed to this being a theoretical thing.

--MgIJRqG73D2t8Nbi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZPMhgACgkQJNaLcl1U
h9AgwAf/QpHcGL7yBUm0uVwUOHr91W1tCeE6vcLlRWp6TuWF1zwyvMX2J8oechw5
WfKuq7pYOKixLENeyW8Xo0pzHQzd/9SkJu2SiPCTp+7sbkiDTguhczQW7N6So8tF
20sTTf2sxayiFx8SUp7PeO30oX9go2FVSOoebGhbG2VJ6XHmtjwLbu8y9qlMeD6f
tTsoghBGqbKvO5pi7AQxahU5ipJQUxNQ5XWb8W1Kibg8JiEWfvwNYP+rH3r3+R0F
oHRYTijkKNauvenTNHyCTM1p3eUSLAvBZWkCn9+c2ipHkpsI1spTzfwl5YGVcQCF
ADKT0cnWiFO75DK8kL7GtquRGCJ5Jw==
=5WNu
-----END PGP SIGNATURE-----

--MgIJRqG73D2t8Nbi--

