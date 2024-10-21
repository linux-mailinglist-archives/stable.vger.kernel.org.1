Return-Path: <stable+bounces-87550-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 493BF9A68F1
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 14:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B1DC1C22508
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 12:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DAC1F80B8;
	Mon, 21 Oct 2024 12:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIdTjn6Z"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B761F76D0;
	Mon, 21 Oct 2024 12:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729514790; cv=none; b=IVdxYl7yDdIIVvMUUh6rRErq+6CYuLaxh6SlJavzQ83lgLiUyS7sueWX6diC+ufOgZWFKTPuiqKEca1rj8Yyw8kLmVUHis0s+S63MCZuQPhYKTTer/VkpwK8HHGiKIzO9gGF25ywM6jDkkYAzRqimhOeR7zgeKQePwHHlG9TdQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729514790; c=relaxed/simple;
	bh=xTfEykVBfqYI2JgbgfPsBPAISsdZz05BmImPaVUH/vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r1c7UBTEZkHBIxV0+qAfpxFcUZnk5BtXZz87lN/9zj9yiGVIrp2DzAHTwChvbiq222DWF3AJDmm2Uc2TMQyE9IAceJAtCXYzA5R3DYj3fwmLFH7y1VbMjFNu/YXYrjyET6ucq74GrYVbX6910Z5ahAgYDaZeBvCuvlAY3xqFm/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MIdTjn6Z; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d49ffaba6so3101716f8f.0;
        Mon, 21 Oct 2024 05:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729514786; x=1730119586; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2tNgkXKwLXOYj2vcfpM51UGck7gc6AsRRag9xxhq4aM=;
        b=MIdTjn6ZWld3fH+tfoX7L01M0HJt2MFk9BUS3+X8IkSvL55gG537D9U45uWvV9sM6E
         nRyJhyAgnfQeneHyPfuIYGRUlsomzszxpQRfR+rt5zYcFmNh3x3uKPO8V95lkexW8LeN
         G9E7EgccvcdtSvMFXpoeKnM4QN5qD82PWEfm0iO/olBUotqkibmSTKXGQmaj81RhBMk2
         mT6bGWzawHsp5PFVnmmT/kJCEWuoJfOt6+hhlQzpm+4m+VaWJvHp7o10MeYnkNTKccKg
         PqtAn/t+yiMpU3bRJQz3e+xfqebfO5duNRs2YNubeBlhdNTbnVwa6e6V1TD0xMAg8GjZ
         5kjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729514786; x=1730119586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2tNgkXKwLXOYj2vcfpM51UGck7gc6AsRRag9xxhq4aM=;
        b=UkKK3guNW+kMcTGaSsAKLRwaZ99ab29qxmx5qxpcZ7H1m6wFJZyhb3Hf8VtcqSJi37
         uOjxdmqpb9UaUWdO47xvcl3qGmiZ68+Kh5wAgioyfi2CChHykGYOj0ZLgz8F+Mhe2lL6
         ptBfOkGD2h8fGaX/0RZIs/Fb2CNCHd3ciBeBdT9P1WTQ9Xs9lrawDIib9tV4RgC5JzLb
         8TZ65ueOHE3DRV9685AqwtRO1o8akEMrEwptaNrykUvnV8Wms3hK3l0GeB+5eDOEGpID
         Tb4icgoNxSUn+fgn1NeFc8GMbBoryIY8VFfUMRWgB2ITZIeaWyT40bimu4aeANbFyiPI
         HI4w==
X-Forwarded-Encrypted: i=1; AJvYcCUhufmy6h5ZGOHA8DwaV1T8sQZxDdCMZSB9WrgkH9BP/chwKLgTDSUCFiDEs6b2sLI94MOwZCqCiFAgDyA=@vger.kernel.org, AJvYcCWj32LUXxEBwq3HyYHjCnMtsMQYP4Aqgl870rZWXSrJ9yUKCyt+mBTNy6szl8D4YCO9DHoK/xdR@vger.kernel.org, AJvYcCX0sykXKPG2MXeXEkrWbcoX/pABCZ/VsnkaEFB+f5O+0erP1DQoCIIQknr3JdZNAIgLYuKvkjRGKv5L@vger.kernel.org, AJvYcCXVFmjtGByXBtR1nBo3xS05am0wwZBF9EOnxAXPsH81xAnuVOcapG3WDcBhd/MKZ30CQ31eZ8ztukfZ4rk=@vger.kernel.org
X-Gm-Message-State: AOJu0YydYxvU4cXO9Z7MOC9hvwL/xgPOvcl3489s9za6q3k07THuo6FS
	5F+VqcscBV7Q7JMMetncZOlOFj3K8kQIKAaNy5YXNiyivdxB0hC1WrO7/Ber
X-Google-Smtp-Source: AGHT+IF8yYylXofo4xb4ihzBJmGnKtLzqF98xqMY3Cs7Cdm1hv3lJGPTKXEJqP56KuRk3nu/ZFyplw==
X-Received: by 2002:a05:6000:109:b0:37c:cca1:b1e3 with SMTP id ffacd0b85a97d-37eb48701a8mr6745329f8f.41.1729514786320;
        Mon, 21 Oct 2024 05:46:26 -0700 (PDT)
Received: from orome (p200300e41f26ec00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f26:ec00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f570f7esm56668325e9.10.2024.10.21.05.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 05:46:25 -0700 (PDT)
Date: Mon, 21 Oct 2024 14:46:24 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Henry Lin <henryl@nvidia.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Petlozu Pravareshwar <petlozup@nvidia.com>, Jim Lin <jilin@nvidia.com>, linux-usb@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4] xhci: tegra: fix checked USB2 port number
Message-ID: <lfjrdb5hx7ytm5kfolsidfa6pfbatocznejedyo4nsxjziouse@6bjo5huzciwa>
References: <20241014042134.27664-1-henryl@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fplnjns5szlhev77"
Content-Disposition: inline
In-Reply-To: <20241014042134.27664-1-henryl@nvidia.com>


--fplnjns5szlhev77
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4] xhci: tegra: fix checked USB2 port number
MIME-Version: 1.0

On Mon, Oct 14, 2024 at 12:21:34PM +0800, Henry Lin wrote:
> If USB virtualizatoin is enabled, USB2 ports are shared between all
> Virtual Functions. The USB2 port number owned by an USB2 root hub in
> a Virtual Function may be less than total USB2 phy number supported
> by the Tegra XUSB controller.
>=20
> Using total USB2 phy number as port number to check all PORTSC values
> would cause invalid memory access.
>=20
> [  116.923438] Unable to handle kernel paging request at virtual address =
006c622f7665642f
> ...
> [  117.213640] Call trace:
> [  117.216783]  tegra_xusb_enter_elpg+0x23c/0x658
> [  117.222021]  tegra_xusb_runtime_suspend+0x40/0x68
> [  117.227260]  pm_generic_runtime_suspend+0x30/0x50
> [  117.232847]  __rpm_callback+0x84/0x3c0
> [  117.237038]  rpm_suspend+0x2dc/0x740
> [  117.241229] pm_runtime_work+0xa0/0xb8
> [  117.245769]  process_scheduled_works+0x24c/0x478
> [  117.251007]  worker_thread+0x23c/0x328
> [  117.255547]  kthread+0x104/0x1b0
> [  117.259389]  ret_from_fork+0x10/0x20
> [  117.263582] Code: 54000222 f9461ae8 f8747908 b4ffff48 (f9400100)
>=20
> Cc: <stable@vger.kernel.org> # v6.3+
> Fixes: a30951d31b25 ("xhci: tegra: USB2 pad power controls")
> Signed-off-by: Henry Lin <henryl@nvidia.com>
> ---
> V1 -> V2: Add Fixes tag and the cc stable line
> V2 -> V3: Update commit message to clarify issue
> V3 -> V4: Resend for patch changelogs that are missing in V3
>=20
>  drivers/usb/host/xhci-tegra.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
> index 6246d5ad1468..76f228e7443c 100644
> --- a/drivers/usb/host/xhci-tegra.c
> +++ b/drivers/usb/host/xhci-tegra.c
> @@ -2183,7 +2183,7 @@ static int tegra_xusb_enter_elpg(struct tegra_xusb =
*tegra, bool runtime)
>  		goto out;
>  	}
> =20
> -	for (i =3D 0; i < tegra->num_usb_phys; i++) {
> +	for (i =3D 0; i < xhci->usb2_rhub.num_ports; i++) {
>  		if (!xhci->usb2_rhub.ports[i])
>  			continue;
>  		portsc =3D readl(xhci->usb2_rhub.ports[i]->addr);

Given that the size of usb2_rhub.ports is given by usb2_rhub.num_ports,
this seems the right thing to do regardless of virtualization.

Acked-by: Thierry Reding <treding@nvidia.com>

--fplnjns5szlhev77
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmcWTR8ACgkQ3SOs138+
s6HZUg/9HIVjVuZFYW96ytxOAoCNpEL/mi1p3WBpkcl8jBg4F9w4LWOWBpvfwoAd
zIvSaFJXKqbi8/LcMvNCpSknAWDot14Lp2ZBnR9Uq4NcLpoZ3mU9eu3Kc/ZmMDRJ
08itUmZX+FjhTmRevrYz88nc2QgMOWMcFAvWcMsdqrTX6AqFOqna3LhxzY6qX+V0
KQLjy9DpxjdPxQY1O9B4TTd5K5BUawdPzJMQCSwayrWF3izL2qFqJ9cOQI6UnF1h
EL1eq+2WDuCKq3AyurTAeRVFE/Gs30l1Qhzn15GzLhdF88s5fCjf3ZDZE8qG2VFq
7pOcbMfWENhioQYncFUHnnsVju5+A3XXMs/DCUcyjHV57QnaDJA7wCiIdnP4hWBo
IQI4UpweJRHtjArSAt6GS4T9n/TiGzstoIj1x6lvwJJuWDbV41fvr95eXAKDZ601
0+hhTor75YN5IAoJZGNleU4OA9q3dcNTwr4lMCBNKIA6qUmJVrUUKl+RivXL0MfN
OLP9XkP1Dn+dKFHL2zggK1MzdSQ1l+8PS+vTkmvAiYtPXDY8JZbbnxAVycweWrzi
ocb5E93LIbrRaR2SfSXsmmdaYRMbtSUXcUlrG+fevHrzv/mUB0FWiZFH4sVwzQbO
MMGCOcmcaXGXJqQr0sF4HQmcFWR9eze6+iyPofzVj7ryDMaTLc4=
=IcrR
-----END PGP SIGNATURE-----

--fplnjns5szlhev77--

