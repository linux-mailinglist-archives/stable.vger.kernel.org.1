Return-Path: <stable+bounces-183679-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC41EBC86EC
	for <lists+stable@lfdr.de>; Thu, 09 Oct 2025 12:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA5C13BB9C1
	for <lists+stable@lfdr.de>; Thu,  9 Oct 2025 10:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88AD2D73B6;
	Thu,  9 Oct 2025 10:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8HpBE00"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBAB25EF81
	for <stable@vger.kernel.org>; Thu,  9 Oct 2025 10:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760004964; cv=none; b=fSXOW36OPM7ZwFtJAgQvR6CRQHSpSQEOWxRxLbyxuDgu18SSy+l346C9qEg/UvDCdn3kKw0gJnfyhDt4ombB65Awmf1z4Ahr4kDIpNm4Wx74ZzS30TD19wg3xggGtlM1ITTvu6y06nzu+mmH9YNgXoeT9l5UXmtx1qib7CbpAAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760004964; c=relaxed/simple;
	bh=9qRHHYEqmADy2Hg7PePBEBsrGtyY7ax7aZmn7NMwQzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PK7W92UIM2OXEkmNSQ1ILnbugI5liQprX8XDfUD8E+oqqPo1D1Yk45qB1XPBrE8tBSuwcdMVggFqW8hG3kQiJiUOLFoZQMXvId4d9eGxUZnMV3FuGoiGvyKoJZ9KDlusI45WERpse615/8Vde80CcwgDBulITZNF749KHV9G43I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B8HpBE00; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3fa528f127fso616702f8f.1
        for <stable@vger.kernel.org>; Thu, 09 Oct 2025 03:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760004961; x=1760609761; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OM8w5j3cNslas5sLb0Tl+m0IuMNBdYJF77WJyrPk0Zo=;
        b=B8HpBE005iYFBGqBQo4ECpHydKfdlV0+oCOmRFs8rGYYi4/UtePoLbU7AWSrNB9lgS
         CNcgEy4IKRjWmXggTLB6pD89KpiurR2k91KCBmJO+Akg0R+YjD1NSlz1yNFaI20knGgC
         tGT31dP357e2O38SOSET51Y95PkDk2fSFhPv9pGjtNE9a0RwejZaRcrdULUsfjzcICIg
         bIVvq2dOHe27BoJtmZKxvEU0nbDkpjs70XA6RE662tA6ct1s7N5bJgZjBKCsHg9nMrn/
         SEeBpH1BUlxctEJygkyztFWXSqZ5D+FW65atQxUpFm4EhCT/EgRuPU7f4/HyxDJJLgsb
         70yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760004961; x=1760609761;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OM8w5j3cNslas5sLb0Tl+m0IuMNBdYJF77WJyrPk0Zo=;
        b=xGIfDR+dZNuQamRDlmufYvcohArJQMWm7LA5WbbpxTVNjc++SC8pZVaCuevfORV0v1
         x/SOmnF9gp0CjhV/vmuEUhboTTA3OxnyvsweiTfPuyiqO6xUTsdeqvlmhkzUxQA8th9S
         j01xv04mfMucGfu5TSkx3XPnC1o6zUnZj2VsGqhfNzKtpsKeRIW5lDM6BGkNnPajj32+
         Tq817+lMH2hnQ74r3yJH0cuyzvoLW87CmNm6Xy0xA2Ti60IsGGF6qLv2VGlpGdCPcETz
         3L01VZhLdG5YM/pB9KeKl2x2yiAC+RLKC9z8k4stfmo1OFBPiM3uv650ETlVTogXDPLv
         INxw==
X-Forwarded-Encrypted: i=1; AJvYcCWceY6jrrEIFUBowJk3lgY3kINrv3ndIeQrSBHhYmTuhmi5/f0Sx8odajC6M3Bc71KNrGELLRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVewr9qvxoIGipco1ySvg6F+91k3IYuOuxE/u3V8QDHK//eTO5
	9eVUIUHuuqjfk8sxSozZOzUMpfWNRiINx8hCMpL3WLv4Iz5Hx7miLemm
X-Gm-Gg: ASbGncvks4DhlE3/Srm4csw4Vfy42ohWRnbthIJSCrvG+9hZZ/qWSfP43S4rE6bv579
	AM2SHtwkQBjQUqY+quueoT50ydZiPw+kJSuMQJ7hEwpIBxLZdKjPAgZympuhUxTtr+56asLGp1L
	gbZxJl38RdRy69IMYEBBQRAOCpfA2+te+XOempODsolUh5vngW81cVI9EJWScnNxfv0u3WS5ojY
	yq2Vh97dQquong469SUurZLMhrJIRpVSx067Gu4IFq2EQDG/3X7UunULrcQZNLQ/vL+N+yqbL0e
	ueFooWSQHCtzfqbKPimsiLh71HzW8fm7VEW0Gs2KpVUvsPCKUdAsbjgsqbyUNYDshmOZMWKDuM+
	8zq2Ziv90R8N1Hf/AeE9LmM0CAQPV606GDaMgq/pxNlct7PryWMyJOC2KHhGCs1CdY2tekyykrH
	GnZ6Ef0hMiymb3Rva4/SjTuDQbjcA7bCz85C06+e5dobSm
X-Google-Smtp-Source: AGHT+IFlFWC9kU+Mnozr0FajDi8lLvELWyKIXfkOw61WlClbcF8AFrsB7MLFt16hX93JOqSFya6Ipw==
X-Received: by 2002:a05:6000:4283:b0:3ee:1368:a921 with SMTP id ffacd0b85a97d-4266e7cfb85mr5665226f8f.28.1760004961089;
        Thu, 09 Oct 2025 03:16:01 -0700 (PDT)
Received: from orome (p200300e41f28f500f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f28:f500:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8a6bb2sm33100275f8f.10.2025.10.09.03.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 03:15:59 -0700 (PDT)
Date: Thu, 9 Oct 2025 12:15:57 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Johan Hovold <johan@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
	Rob Clark <robin.clark@oss.qualcomm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Yong Wu <yong.wu@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Chen-Yu Tsai <wens@csie.org>, Krishna Reddy <vdumpa@nvidia.com>, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Thierry Reding <treding@nvidia.com>, Miaoqian Lin <linmq006@gmail.com>
Subject: Re: [PATCH v2 14/14] iommu/tegra: fix device leak on probe_device()
Message-ID: <4uszly3pf2iddttdwbrfnt5pypzsyj4loz4i3a6ecnekkiedgr@r2bbpn6ymtax>
References: <20251007094327.11734-1-johan@kernel.org>
 <20251007094327.11734-15-johan@kernel.org>
 <rp2yiradenf3twznebagx7tgsruwh66exiikal37c4fwo75t4t@4breto65stqt>
 <aOdyC1toHHIeE4i5@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c3sygtlebt6s3awu"
Content-Disposition: inline
In-Reply-To: <aOdyC1toHHIeE4i5@hovoldconsulting.com>


--c3sygtlebt6s3awu
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 14/14] iommu/tegra: fix device leak on probe_device()
MIME-Version: 1.0

On Thu, Oct 09, 2025 at 10:27:55AM +0200, Johan Hovold wrote:
> On Thu, Oct 09, 2025 at 09:56:18AM +0200, Thierry Reding wrote:
> > On Tue, Oct 07, 2025 at 11:43:27AM +0200, Johan Hovold wrote:
>=20
> > > @@ -830,10 +830,9 @@ static struct tegra_smmu *tegra_smmu_find(struct=
 device_node *np)
> > >  		return NULL;
> > > =20
> > >  	mc =3D platform_get_drvdata(pdev);
> > > -	if (!mc) {
> > > -		put_device(&pdev->dev);
> > > +	put_device(&pdev->dev);
> > > +	if (!mc)
> > >  		return NULL;
> > > -	}
> > > =20
> > >  	return mc->smmu;
> >=20
> > pdev->dev is what's backing mc, so if we use put_device() here, then the
> > MC could go away at any time, right?
>=20
> Holding a reference to a device does not prevent its driver data from
> going away so there is no point in keeping the reference.
>=20
> But from what I can tell, you don't need to worry about that anyway
> since it's the memory controller driver that registers the iommu (and
> the driver can't be unbound).

That's true. It'd be nice to at least conceptually do the right thing
here, but not sure it's worth it. As you said, driver data going away
would need special handling and it's not even clear what that would
mean in terms of the clients...

Acked-by: Thierry Reding <treding@nvidia.com>

--c3sygtlebt6s3awu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmjni1kACgkQ3SOs138+
s6Hxrg//eMtMJXdv/o41OWNrAKnyhekEvAPwh5MW/YZi09gOgbHUcjPGo7vThuPz
JSWzANjX6kXaUPvM0lVPbg19I+qQGCldNOP33d3RjMKpeRbWtoFOCsVj0ejUx/eq
Y06TzaFYDlNmR8aF+QqlBltg6fj+CNUbxYqndjyft88d+84QvhxXeI+ZsGcB/Fbi
FazMs3Qcqe4U1+ZPpRz08hrH4fTL2I77X3zZKiAqb1FFSewEtIeC6wlohOTgCELe
mgS9n7eW8PatznfexWMAsf14LLegxFs/KstlJGu6Oe+9oXOzKMcn165y8GGGy6wc
h4TsdPMnbkEzRwxqjkQ0ONFOZ35ozFKfa8LuKbhEf7oGbqZEKRN2ZapqcCfGHckh
ssUgFXmQ2dA4DCysprjvQ9EV9gLdyzMy0/Q57Ogwo1zrJz+fmke6HTPPY+fWoiLP
QWx6TWuG7ZQhh4lb+uo1ZQAnMGNttLTvLygk5jvaHEIPW8xM88jnDwVn7Bpf8qdV
9TrKejE1xVgQsbuPQZUOERdGX677mNudKdm+t9+JTD+VtPBNfBLUN/R4f2dOi/3L
xNNyM54fXljVBx49pvIAw2xbsP/tjPLUfFOOtGoU9tdhxbjMHWMYe5LdktpyeoCv
QFWHWcgx+C+w4y4YzM6f+zI7TJ6ZB4eLXR5rAtt+J4FjdB5vMt0=
=XUBA
-----END PGP SIGNATURE-----

--c3sygtlebt6s3awu--

