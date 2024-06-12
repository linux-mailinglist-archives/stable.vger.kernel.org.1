Return-Path: <stable+bounces-50307-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E4E9059B3
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 19:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54C6C28325D
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 17:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038D9181BAB;
	Wed, 12 Jun 2024 17:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YvuCsqof"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F6A17FAC5;
	Wed, 12 Jun 2024 17:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718212406; cv=none; b=SlQLSwLmwf3x43CgNopsNvcWtU/PvPI8psWJCkWssVfp2LELQ4NIWSNVeVtV4uXaO6mRfR8bwe/ZexuUR2fpFRh+R56lcW/T3I94LZmUveukS7j3oVKPJEKHPGKsemP2fMiJQV4xm+O/Zz5eM+krgr9zBCr84aX3RAcAPJEEDVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718212406; c=relaxed/simple;
	bh=pVRtT8SspP4plGFGsoiJuLG4f22ItF8UkF281AhSXAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LFK+U5arXn8ZLZ/6huHbGY5SJSk2uTRsJuQk6qVCE8/ONQ88M2ZTxPdPizXKnJDvlodOPOgxybFcySA1/NfIVZH022tyTjAwLX95EHPQXCMAlCR8W55vb5lELlGTim1U4R1ko8KDNNHWtdS6lOUUsq9Kp1zfSdHJJt8Ld5REuoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YvuCsqof; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8AF7C116B1;
	Wed, 12 Jun 2024 17:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718212405;
	bh=pVRtT8SspP4plGFGsoiJuLG4f22ItF8UkF281AhSXAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YvuCsqofG/60U/lperzaXZZak8MxjEoz7fZaX+6v9Bdvw2DsGZ59AWi58+Wh1+MBz
	 kNTNFkz1znOaog3FO/EJkM5AWK1lx3hVs8U1lbgR+1PbIrdxEljW7KZE1+8lZZjveZ
	 F8ddli7UOc9fthmALrrrS6kDhL4opjqdOoIAzpmi9vVnjw85xUlowj+d4ffp401Pp2
	 kvue7KHzIl74pItTm28gbmDe3mPrIDfjUEQYoKaAGzbzJK5WpbHzne5A+9mV4sXDgZ
	 i7Ab17rp82HN5cw6cDyuJ2QcNPm6Q6L97DBlW5tjvkPGldbecdARf3MFcHy/ijFbWZ
	 n7QY47uCBsYJQ==
Date: Wed, 12 Jun 2024 18:13:21 +0100
From: Conor Dooley <conor@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: joswang <joswang1221@gmail.com>, Thinh.Nguyen@synopsys.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Jos Wang <joswang@lenovo.com>
Subject: Re: [PATCH v4, 3/3] usb: dwc3: core: Workaround for CSR read timeout
Message-ID: <20240612-balmy-deviancy-7d68aca2173c@spud>
References: <20240601092646.52139-1-joswang1221@gmail.com>
 <20240612153922.2531-1-joswang1221@gmail.com>
 <2024061203-good-sneeze-f118@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iV5vRXpMzTX8/qdP"
Content-Disposition: inline
In-Reply-To: <2024061203-good-sneeze-f118@gregkh>


--iV5vRXpMzTX8/qdP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 07:04:28PM +0200, Greg KH wrote:
> On Wed, Jun 12, 2024 at 11:39:22PM +0800, joswang wrote:
> > From: Jos Wang <joswang@lenovo.com>
> >=20
> > This is a workaround for STAR 4846132, which only affects
> > DWC_usb31 version2.00a operating in host mode.
> >=20
> > There is a problem in DWC_usb31 version 2.00a operating
> > in host mode that would cause a CSR read timeout When CSR
> > read coincides with RAM Clock Gating Entry. By disable
> > Clock Gating, sacrificing power consumption for normal
> > operation.
> >=20
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jos Wang <joswang@lenovo.com>
> > ---
> > v1 -> v2:
> > - add "dt-bindings: usb: dwc3: Add snps,p2p3tranok quirk" patch,
> >   this patch does not make any changes
> > v2 -> v3:
> > - code refactor
> > - modify comment, add STAR number, workaround applied in host mode
> > - modify commit message, add STAR number, workaround applied in host mo=
de
> > - modify Author Jos Wang
> > v3 -> v4:
> > - modify commit message, add Cc: stable@vger.kernel.org
>=20
> This thread is crazy, look at:
> 	https://lore.kernel.org/all/20240612153922.2531-1-joswang1221@gmail.com/
> for how it looks.  How do I pick out the proper patches to review/apply
> there at all?  What would you do if you were in my position except just
> delete the whole thing?

I usually wouldn't admit to it, cos it means more for Rob or Krzysztof
to look at, but deleting the thread is exactly what I did for the
dt-binding part of it that I got sent.

--iV5vRXpMzTX8/qdP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmnXMQAKCRB4tDGHoIJi
0l31AQCgnzGy8jovB3LsHP5I2sLvaVto6mJsRUkPndueYrwlvAD7Bdo6b+tRh5DM
V4NutjrkmxkWXiKN+F6SyZXpkCGmHgw=
=Sgty
-----END PGP SIGNATURE-----

--iV5vRXpMzTX8/qdP--

