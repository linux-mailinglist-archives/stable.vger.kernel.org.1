Return-Path: <stable+bounces-177833-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4596B45BF2
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 17:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C13E67A7E44
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 15:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1B131B80B;
	Fri,  5 Sep 2025 15:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nigauri-org.20230601.gappssmtp.com header.i=@nigauri-org.20230601.gappssmtp.com header.b="ZDEj1IOK"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FB531B80D
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 15:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757085195; cv=none; b=ufNxv353vBeeNm2gD0m66e6L10pxNvi98ULWJsBRLN7z/N8IWNst6NEHhGknOs+Hlab9bQZltTv1kAGQjEXPSzGEtukEYebWd3puBoRYUE18fR7VkRZTBCmuy1waTxTaMaTO957kH9/rhyxx2csonEgzN2fJw4bLl8tmitDfwDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757085195; c=relaxed/simple;
	bh=vcbzZr+E02WokGut7C2c77Afxd5rpoCYAkJoIkII9d8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QDiPE6Mlumd+A3kWqg9OKdHcM61l/CaS+C7yl073UhspJCSFcU9NKQBAUV7iPmSMM8eu9jPTHIODLk90WZyE7sIjvnbQ7zuRRFvMvOakpAONR4eQXXxhTRpS9z6S3jGjYXoAkZjfFECXggMOkLEkXhu2GX70TajiW06BJc7CIuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nigauri.org; spf=none smtp.mailfrom=nigauri.org; dkim=pass (2048-bit key) header.d=nigauri-org.20230601.gappssmtp.com header.i=@nigauri-org.20230601.gappssmtp.com header.b=ZDEj1IOK; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nigauri.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nigauri.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6188b5ad4f0so3727335a12.0
        for <stable@vger.kernel.org>; Fri, 05 Sep 2025 08:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20230601.gappssmtp.com; s=20230601; t=1757085192; x=1757689992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHMIdxjHKuTqVD8SOr4IvDDg7ji1cX6ZfEw+vHDGWBo=;
        b=ZDEj1IOKepbUvHpZzM3m2lRtZAMUowMVafek24OUbq6KU2Yuk9ii+QaQXkAnYIQfxy
         dy9FuNETwTcYZFNdIWkYC+dGAS8toGAG6DIsn5cIHxHryC/+F7gMkkWtAapjeFtLx1VP
         I3wNPlt8z2s2OOaPvABV02Cs3iciXbstXd4dOVshdfCedPrgQmxytng1IeGb2LkZML1e
         kDiuTD+OlqBPqKOQY3qA4xVp1PzAb7YUVlT6Od9S3E9HjfP/GpRqljMBhTTtj+UX2yw9
         yFsMpTfLhX/gZ/IWde0k1nOXrsXESVYcG/g4vrVfQP0vZK/0pFrcK/raIhB9JFtF00d5
         efMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757085192; x=1757689992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DHMIdxjHKuTqVD8SOr4IvDDg7ji1cX6ZfEw+vHDGWBo=;
        b=tRKKjaqwmHt/kMW0s41ZB1Zkp1RAhwwmWKRTNMaOQ8llv7VeH+ZKcyCeybZBUC6jV6
         9q74jsEiTN/chMYXp4j49QCckGgKLeHcWzctZAkFSMGTNBOHw5e1ip0SBc5MB6R9WJ6H
         KZ8iXR6H5bie3BiBRHIOxwgfXrE91uPvU9bLOeAAlLoqyfUmabh58X4qqFdLc8DMsV4z
         Er3J8RUSpmEiHjSIU3ua49tBNG/MIZQgIEhjCgW1TMORntYwjMa5WN6xWx9njAJcN8u9
         x/DyOgV66jzBahIBz7J820PCvzf/z4OL6ZfHksXgZ6qOZRXsAsMHCXDKo/Ak5uSA4dDJ
         BT5A==
X-Forwarded-Encrypted: i=1; AJvYcCWvOaWRbh6BrqIHPZzT69gRjqt8hXxw18+1qzM/PtDkZYnF33Oag7+eu6OZNyRTGtArl92EjeM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2IK6vZAlMtcbIF83rS24TTxANdzBI7FC6PbZ0jwetQJBPSTTv
	SNkp6H4nzzekSWJTXOlLK1mtnvbTC7GNsUU+0pfAtkbVtPCktUlixfCZW38DrSsmmzR24TcFlL3
	d311JFo9l9+VvsKAyukVgtWGKKQHOKDBH6ZMHNFk=
X-Gm-Gg: ASbGncuo0ZOHWZkgMuHnSr/MJc5eYtW3DGnwo0f7gczfPSY+O0f+r3ZDOiTtas3+vBe
	7J8ZCmkv/yY6gXIkpU9hswd94gWZjCkCpjLHw74bskSr858yVZOTqqU0aEXCCeAgOTtYKvB2+Co
	0J0wUzmFpckcFgpe19m8Wa0IjU4Huh4YwNhlB+cupXQsPv/HrCuStLYuQRYyjYayRvP0ismV6g
X-Google-Smtp-Source: AGHT+IE5RR3xHpHhW22PdOxC27cxpSABsoBUyfebHCL+SzRaex/Yg5PA4kv6ZoooBZkF06NN2M4yziw9mmi8ooK96Xw=
X-Received: by 2002:a05:6402:35d6:b0:61e:d34c:d1d3 with SMTP id
 4fb4d7f45d1cf-61ed34cd400mr10877470a12.19.1757085191500; Fri, 05 Sep 2025
 08:13:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121071325.2148854-1-iwamatsu@nigauri.org> <CABMQnVJVTmnsx3RNYK01ikZ-jnn_y4pbrNAeZaKPzz0N_YFz5g@mail.gmail.com>
In-Reply-To: <CABMQnVJVTmnsx3RNYK01ikZ-jnn_y4pbrNAeZaKPzz0N_YFz5g@mail.gmail.com>
From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Sat, 6 Sep 2025 00:12:44 +0900
X-Gm-Features: Ac12FXzTX4H5emedmc2ovwKAlGVEjYg6lVwTcyicNPf8FtCjYiYPI4wGLhju7oc
Message-ID: <CABMQnVJsK3wNRQfGjomggKcwL5zaqBchoAKajbVb+ZXmrwn2iQ@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: socfpga: sodia: Fix mdio bus probe and PHY address
To: dinguyen@kernel.org, robh+dt@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

ping?

2025=E5=B9=B41=E6=9C=8814=E6=97=A5(=E7=81=AB) 22:50 Nobuhiro Iwamatsu <iwam=
atsu@nigauri.org>:
>
> Hi Dinh,
>
> Could you check and apply this patch?
>
> Thanks,
>   Nobuhiro
>
> 2024=E5=B9=B411=E6=9C=8821=E6=97=A5(=E6=9C=A8) 16:13 Nobuhiro Iwamatsu <i=
wamatsu@nigauri.org>:
> >
> > On SoCFPGA/Sodia board, mdio bus cannot be probed, so the PHY cannot be
> > found and the network device does not work.
> >
> > ```
> > stmmaceth ff702000.ethernet eth0: __stmmac_open: Cannot attach to PHY (=
error: -19)
> > ```
> >
> > To probe the mdio bus, add "snps,dwmac-mdio" as compatible string of th=
e
> > mdio bus. Also the PHY address connected to this board is 4. Therefore,
> > change to 4.
> >
> > Cc: stable@vger.kernel.org # 6.3+
> > Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> > ---
> >  v2: Update commit message from 'ID' to 'address'.
> >      Drop Fixes tag, because that commit is not the cause.
> >
> >  arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_sodia.dts | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_sodia.dts=
 b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_sodia.dts
> > index ce0d6514eeb571..e4794ccb8e413f 100644
> > --- a/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_sodia.dts
> > +++ b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_sodia.dts
> > @@ -66,8 +66,10 @@ &gmac1 {
> >         mdio0 {
> >                 #address-cells =3D <1>;
> >                 #size-cells =3D <0>;
> > -               phy0: ethernet-phy@0 {
> > -                       reg =3D <0>;
> > +               compatible =3D "snps,dwmac-mdio";
> > +
> > +               phy0: ethernet-phy@4 {
> > +                       reg =3D <4>;
> >                         rxd0-skew-ps =3D <0>;
> >                         rxd1-skew-ps =3D <0>;
> >                         rxd2-skew-ps =3D <0>;
> > --
> > 2.45.2
> >
>
>
> --
> Nobuhiro Iwamatsu
>    iwamatsu at {nigauri.org / debian.org / kernel.org}
>    GPG ID: 32247FBB40AD1FA6



--=20
Nobuhiro Iwamatsu
   iwamatsu at {nigauri.org / debian.org / kernel.org}
   GPG ID: 32247FBB40AD1FA6

