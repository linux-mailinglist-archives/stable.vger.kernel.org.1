Return-Path: <stable+bounces-93670-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0339D028B
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 09:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 214572822B4
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 08:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A99013A26F;
	Sun, 17 Nov 2024 08:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nigauri-org.20230601.gappssmtp.com header.i=@nigauri-org.20230601.gappssmtp.com header.b="h6XkncAE"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D9038F9C
	for <stable@vger.kernel.org>; Sun, 17 Nov 2024 08:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731833662; cv=none; b=rSBd6kP7CAo8KdXMw+ck/WOyqObiTvQYugEiuj2AJ2bWPt988IXrhWkIkzBJHutFSrYyD9ng2IxOar3KrcSR/zFuD+5De42EdXjDg+NjAeBgTGdKmT1v++TZakNR5EQgLNehRs1lCK7WjJ0kJ6XZKKoxSgYo41mBl3kFO0e28HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731833662; c=relaxed/simple;
	bh=1CgclRnp10ly/JD5SiLrTDFla8mus//SPDBxcGQV0jY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aWfL4nESDw1Vt4hG4E3AjOhZZdD18tPNZxDH+aiY7BW5wv4n77JKwMVSy015Y+pi6Q7Sfnf2y5DdZkwZRAXhLthZRqCt0IObZbhj8uL/zkinFP778PDZYV+91ZGhQkHaRkpz2y43wqZFpNXe4qArkyPW8GAHoS/ZbmRXjftzjng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nigauri.org; spf=none smtp.mailfrom=nigauri.org; dkim=pass (2048-bit key) header.d=nigauri-org.20230601.gappssmtp.com header.i=@nigauri-org.20230601.gappssmtp.com header.b=h6XkncAE; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nigauri.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nigauri.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9ed0ec0e92so153284866b.0
        for <stable@vger.kernel.org>; Sun, 17 Nov 2024 00:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20230601.gappssmtp.com; s=20230601; t=1731833657; x=1732438457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aAFozerT8AmWvaMiQhtVKgrLvIOoUAQYsmUVcu4V1u0=;
        b=h6XkncAEP5lZU7dLWT3iVaWZKNTd2D+jLdHb1E9WzRlZo64hwVFLdlpw+PNj9jiEfE
         0ZSMBx7zlbgpHYESCAPSp+JJychIe+cq8er/XXvfdfzc2vj6Iq5LZag7iIpZ4n39VDo5
         PLIoq9HzcRmAaft/8e3R0mMPQ1YcRCJHLXWgdvJs2UZBnWeL8omeRGty+LKgYDIGv+fc
         Kt18gEPB4r8A+iJvyrnUZejvuru3ukTC6/+c842PC29ByxB+WnbDccY9VfR2dMZMT0IC
         MF8M/7NFqx+g/52D3aoEM55HIYdG9e74B1P2YYFIi4RotqO90QBGT72Aa3d0/PqxOiuY
         d2Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731833657; x=1732438457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aAFozerT8AmWvaMiQhtVKgrLvIOoUAQYsmUVcu4V1u0=;
        b=EPVaNvi9jgGlBi2SKfUOFpoi9pV1n7sgzlYOd/k+4BMFNgVo+BRdVmB2VWFovnqK1U
         b1PATSeRwTUG9KZxziMnXaq5wBI/K8jjt2RZTmYzK9p9PNZe4AZlud24bjgix/o91Piv
         MJhabjUC0U69dUchDE+IpdsOzdmgoGJeuDPQntlzUeYv1PuCEQKUjR/9bT/0UoueWEHE
         4c44RTEqVpXn2lPEUg6N+F7DSZd0Kwe4KNFmzA7oyB7zRhwZwcv7D3BWfsStqkdMsEiM
         AKWeg3SprRg4JIhCkUvf2jM2O/GolyewhuOV/1+cKwjJSK+/btmux3rNgkly5tfymMs7
         ZJLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFY/J85hy0056zvUqkDvJKwaT36xokE74vVMnOCx/jwz+OeU3I4BYqxssubV5fsYPiI6M8htQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQvpT+CRiT0R30lqnfQCIelntqa5s0AWA9nzh5GwhGilziHgKF
	3mlNy8KY/OOecpwTP1D7w7HQfDuIzVSHP9ZPq8B3a5HtQ9bcuJQE1soaPZQMZyUrVI2ckpc7FRC
	oO6TpxftCWPP1Ck1fmhC4munobbNFh35Dku8=
X-Google-Smtp-Source: AGHT+IH9A6EZKAlNlaThpg9AAuD/cbmV9VJvtt/bhTQvVCtVUAtunC0O/fpyJLc/etjVvqahiNW3SCx3U6/D6U7BbUI=
X-Received: by 2002:a17:907:3f98:b0:a9e:d539:86c4 with SMTP id
 a640c23a62f3a-aa4833f41cdmr702610266b.9.1731833657034; Sun, 17 Nov 2024
 00:54:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004061541.1666280-1-nobuhiro1.iwamatsu@toshiba.co.jp>
In-Reply-To: <20241004061541.1666280-1-nobuhiro1.iwamatsu@toshiba.co.jp>
From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Sun, 17 Nov 2024 17:53:51 +0900
Message-ID: <CABMQnVK_RUC84QQ5zb+ZpuMOZcFMNV6HzEYAfmX4bOrRm+rvTw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: socfpga: sodia: Fix mdio bus probe and PHY ID
To: dinguyen@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, robh+dt@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dinh,

Please check and apply this patch?

Thanks,
  Nobuhiro

2024=E5=B9=B410=E6=9C=884=E6=97=A5(=E9=87=91) 15:16 Nobuhiro Iwamatsu <iwam=
atsu@nigauri.org>:
>
> From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
>
> On SoCFPGA/Sodia board, mdio bus cannot be probed, so the PHY cannot be
> found and the network device does not work.
>
> ```
> stmmaceth ff702000.ethernet eth0: __stmmac_open: Cannot attach to PHY (er=
ror: -19)
> ```
>
> To probe the mdio bus, add "snps,dwmac-mdio" as compatible string of the
> mdio bus. Also the PHY ID connected to this board is 4. Therefore, change
> to 4.
>
> Fixes: 8fbc10b995a5 ("net: stmmac: check fwnode for phy device before sca=
nning for phy")
> Cc: stable@vger.kernel.org # 6.3+
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> ---
>  arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_sodia.dts | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_sodia.dts b=
/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_sodia.dts
> index ce0d6514eeb571..e4794ccb8e413f 100644
> --- a/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_sodia.dts
> +++ b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_sodia.dts
> @@ -66,8 +66,10 @@ &gmac1 {
>         mdio0 {
>                 #address-cells =3D <1>;
>                 #size-cells =3D <0>;
> -               phy0: ethernet-phy@0 {
> -                       reg =3D <0>;
> +               compatible =3D "snps,dwmac-mdio";
> +
> +               phy0: ethernet-phy@4 {
> +                       reg =3D <4>;
>                         rxd0-skew-ps =3D <0>;
>                         rxd1-skew-ps =3D <0>;
>                         rxd2-skew-ps =3D <0>;
> --
> 2.45.2
>


--=20
Nobuhiro Iwamatsu
   iwamatsu at {nigauri.org / debian.org / kernel.org}
   GPG ID: 32247FBB40AD1FA6

