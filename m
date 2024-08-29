Return-Path: <stable+bounces-71505-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFFF9648C2
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 16:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71859B246CD
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 14:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C91F1B011C;
	Thu, 29 Aug 2024 14:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ju8wOwSZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E9C1AB500;
	Thu, 29 Aug 2024 14:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724942424; cv=none; b=YIYUjscrc2YezqjcZOw4gKWSE7gswHK1UIZHk+YB5V1UJ+T5vOyq6mQ42ddunX87GeBaqsqTWA0iuHa1h/kOZJ/nWxlPPECWEPdhjaksRWX7gQwZSf5zPwLAXK1uocYiQcrnaAEmRF8s/jG48yzPIZAYKuqYsFyzb5d6VHJ4mw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724942424; c=relaxed/simple;
	bh=o1CIuhKClc2KBznPJSl6sSwTNIKelV+2ijsQCntQw/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jlDNR2XQDwu1zyBglV2VmJhRZIvnN6uujZ809UCVBE8uhuN7XVlbq8Xzo4HnQv+SJIy16xojjyRAzWxcZxc2pUfjs/8vqTFrs/NY4bEau4BoFLppLU8BByzRc9+XRdw8zZ/YIKPF2biTu7kGHPDycMVQXWMaAdPS9J896hkYhXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ju8wOwSZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A9CC4CEC1;
	Thu, 29 Aug 2024 14:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724942424;
	bh=o1CIuhKClc2KBznPJSl6sSwTNIKelV+2ijsQCntQw/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ju8wOwSZXODs/ap6jCqawfwBcJS6zTFx1yIt9BX42iAAFl6d5mLrnLSTdJ8glZA/n
	 P69AwHcdJ5gbTXLQ9dba54ryaPpVF86gEwqLVOfu1ItgvxpJTJfQz85wKjHOdsSPhh
	 m3SNpHT9LRN/im5F4omqheEDg+PpbpoVZeUODw/u9kf4J3AeMc5B21X317hdn7cBPh
	 6tmHL7eRIAUNsoQy2vl0FD8e0kNnkLHBPDX8HJG4vsWt7fH+3yhAl/o4bDDDZrsRPx
	 FcZkiNZuHKM1Q1Lo8VOVofR4172nYw7i95FmBvT18/QKv/alKFvlqbql4wj3i62XFS
	 n6SHCu1VpljIQ==
Date: Thu, 29 Aug 2024 15:40:19 +0100
From: Mark Brown <broonie@kernel.org>
To: Markuss Broks <markuss.broks@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ASoC: amd: yc: Add a quirk for MSI Bravo 17 (D7VEK)
Message-ID: <6e46ec3b-3d34-4716-83bc-364bb023f1be@sirena.org.uk>
References: <20240829130313.338508-1-markuss.broks@gmail.com>
 <2024082917-jockstrap-armored-6a14@gregkh>
 <adff0886-1fb8-44ac-a86d-855e4e6dc8de@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Sqep04bPF+Uo7XG5"
Content-Disposition: inline
In-Reply-To: <adff0886-1fb8-44ac-a86d-855e4e6dc8de@gmail.com>
X-Cookie: Go 'way!  You're bothering me!


--Sqep04bPF+Uo7XG5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 29, 2024 at 05:36:06PM +0300, Markuss Broks wrote:

> Sorry, misread it, so I need to include it in the mail body? Do I resend
> this patch with that change?

No.

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

--Sqep04bPF+Uo7XG5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbQiFMACgkQJNaLcl1U
h9B4twf9HxORpv+NOnO0stgVLPsT2vUvq10B4wmsrrXCzjKaUuB7KmLJxAgDXOYm
VNtbGLx/hOfPqYIJT8TVhqYksAmXQwPVUoosLNSXoITLr+nYC6YKEo5DbRDwaxjg
YTaL35Org8QHCIsB03uK3Dr8SJ6lA8rKIHkSQtcuZBlXvKSzg43jGHN3KE8JyFy9
BbEVuHz7c6adsm7i1LlkDJkryeVMoGPpOK2/vPkHfIjl23PEH8T3+35qTZ0R7sTs
cOb48SgbonE6NcTuS+c6GNhEsCUjdXCONWBlJ3ADtoWjWqCV3nbaqdVnGfh5i/Kw
ksSNOInP8qX29AHEDrpCBK9X+SBt6Q==
=7X6a
-----END PGP SIGNATURE-----

--Sqep04bPF+Uo7XG5--

