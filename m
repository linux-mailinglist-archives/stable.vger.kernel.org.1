Return-Path: <stable+bounces-152548-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E00AD6D88
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 12:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1964173281
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 10:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189D3231825;
	Thu, 12 Jun 2025 10:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="driuHXsn"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155BE230269;
	Thu, 12 Jun 2025 10:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749723756; cv=none; b=PnrWvqUaLz5Cgj2N2fKwUCRlYecaaJpSc7IuzyQwCNsHOcuk89FclbejzbX4xCWpYq6svAhMeiJ+XezaPg9Nhy1kydAzWvoP0eIAWErAYf9EUXv2btnO+hlbcjfTr5tsOjO+IsaNM9la4dOEyuN2i1+A8/cMc8lUTupsazl4t10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749723756; c=relaxed/simple;
	bh=++jzvtIbTVbmGBVd5TasUy8Q3dAZIh9hHsXzYyG13Tc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=VsiSexsVAyNxu8lGWqu9FPdQeuSgZd/XqOycHjLb9vgSw979c1ZWxyzdf5sASNze+Bu4/hSZIGAMFSM7eAbtmr3Ky6WAn5zmxuTpct2j5pQeBVHMric98KP4+qLVx1RNDXE4BZoUBbxHNniZYZi54ir2qcWt9iEZKWpu+Qno+6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=driuHXsn; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-607b59b447bso1416151a12.1;
        Thu, 12 Jun 2025 03:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749723753; x=1750328553; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ELcPuvNKLZu6Ryw5rajS8NLZ+N5vs8CjzH8DFZ2k5qY=;
        b=driuHXsnY7oTHq8yHSX92nBSQCDNEYyjvabmki0VV3YiZ+JVJpsr0C9uGvrGV5es6C
         j5LshjzpAhkEbx8HKiYjBwxMgVWgL4W3V/4wSF6UpYN0Fmudt8kBz2WX6KYkyCodwySq
         UER93NxiUiM7RWKjsOo4w8al3/ON55XKGJ6gdQvOC7n9xEqfGq7q1YgzaDRcpszPLfDo
         hJEG4uT+F0BvJzajqtOr10sU7uhV4M8Y1CF/xfQcEXv5oIJHVyyxBrgW+/osjtn/Xbtx
         TbiwAEJtiBOavkThhvPcVEyQvb67xseiW3h7/yTYoXDOYUwceYvJL/se//mJgk5dIMv+
         4zrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749723753; x=1750328553;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ELcPuvNKLZu6Ryw5rajS8NLZ+N5vs8CjzH8DFZ2k5qY=;
        b=VO7KpP/epV853lT6hHL3D3Ct49yYP93CGgilVBeLyZp9Rq7Adv0tJS+mNkgn4fIF7k
         w0d6JRy3yLOeVTs9x5TYKqjJi4cYjPj97vJK1mIBFlTiPKk9lLHUp02C4gvRDHSbgk+g
         8IoZh/VU8LZ8IJ+six7KTLeoPity0IDHMIeUtPtOtxm18pClkoRfVl42S8e6AxLdiIwn
         tAvBOpLkeGji7svowZhJQUyFl9wy/hdYjIVZSKK+ZPq9VS9Y9y5SqL24+DRGAUwksm9h
         cpEWhltf8GdfNZKQDDq+cR5zLTmLmYnccLDfZH6SGCxKh19KPvaC/N406vKhPz/zf91d
         tkPw==
X-Forwarded-Encrypted: i=1; AJvYcCUN9qyDCwceBvT0x9kiBWgXPEKDz/QCC7Gsqd/DT7rywMfG/zlwY1XY+N4e8Oj0YUTFCzfhlCDhcdSxON5e@vger.kernel.org, AJvYcCW+ep5UAjr7zgk1HaXl77UnPIS25aH9Y0tImMfxyO1HisBqP7soPG4hzz5CpsyLlRbJ7bDQJNAAHHBu@vger.kernel.org, AJvYcCXrjWUA0tPPAIMtF63OCDsKvjGk5w89HVIZCpyC2rXUq2Zy/2MTeF5x+52AmRYN4D3rWlX+JIc4@vger.kernel.org
X-Gm-Message-State: AOJu0YxSuPu9WR9BJXUeY4VMBedUEE7imzqCZ3jM26b8pWeBMX917lau
	7jOOqSJsj2lhW5zyU3+U/BEpRydBiCSt8MVyF7QpESBtj8I6veQwvIIE
X-Gm-Gg: ASbGncsKCh4YQmLUWJxZMbqfYzKY2Gd9vEys8k9xf9pEnOTycayMGMKpeImB6lLYszd
	ys6QyOATUip7HH13ED3KQn6h1KgPIFgxxlrWPDxn5b0n1PcXOPrCNi3zl3auPXICBTRG5IIemUz
	3/CgPMD1IeFNZYEWdg1nSLaTjXga5woBMIxjLJYEwroqmVBaPOYEuwARYtqJgwawJah6TmYOt8B
	bxXnTr2LDC2bJvBNxOGRUaOK+vZEoh/GieZqqG5YZeZ2Tebsxu6mKrRxknY3uHUQAwuOfJnvHAX
	g1LXd2yo+z89Rc4RU0PzMMXCkkq/hrIMYElCbQmCu8TXBAkTwP6byjC37Dtx8ROkv1rGlYBLtQS
	aFt1QFXWtrg==
X-Google-Smtp-Source: AGHT+IE0/bTYEFCNhrQjD7YEJLFi+GzwBTgnJRxUstfNcaX5VD81i0FvmEvIypNuTLGINT6BjMUjbg==
X-Received: by 2002:a05:6402:40c5:b0:607:f431:33f4 with SMTP id 4fb4d7f45d1cf-6086b2a46c4mr1919282a12.16.1749723753038;
        Thu, 12 Jun 2025 03:22:33 -0700 (PDT)
Received: from smtpclient.apple ([89.66.237.154])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6086a551a2esm939584a12.1.2025.06.12.03.22.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jun 2025 03:22:32 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: Add HDMI PHY PLL clock source
 to VOP2 on rk3576
From: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
In-Reply-To: <20250612-rk3576-hdmitx-fix-v1-3-4b11007d8675@collabora.com>
Date: Thu, 12 Jun 2025 12:22:19 +0200
Cc: Sandy Huang <hjc@rock-chips.com>,
 =?utf-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 kernel@collabora.com,
 Andy Yan <andyshrk@163.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <01D5D2D8-392B-4926-884E-1A4FB87C03CF@gmail.com>
References: <20250612-rk3576-hdmitx-fix-v1-0-4b11007d8675@collabora.com>
 <20250612-rk3576-hdmitx-fix-v1-3-4b11007d8675@collabora.com>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)



> Wiadomo=C5=9B=C4=87 napisana przez Cristian Ciocaltea =
<cristian.ciocaltea@collabora.com> w dniu 11 cze 2025, o godz. 23:47:
>=20
> Since commit c871a311edf0 ("phy: rockchip: samsung-hdptx: Setup TMDS
> char rate via phy_configure_opts_hdmi"), the workaround of passing the
> rate from DW HDMI QP bridge driver via phy_set_bus_width() became
> partially broken, as it cannot reliably handle mode switches anymore.
>=20
> Attempting to fix this up at PHY level would not only introduce
> additional hacks, but it would also fail to adequately resolve the
> display issues that are a consequence of the system CRU limitations.
>=20
> Instead, proceed with the solution already implemented for RK3588: =
make
> use of the HDMI PHY PLL as a better suited DCLK source for VOP2. This
> will not only address the aforementioned problem, but it should also
> facilitate the proper operation of display modes up to 4K@60Hz.
>=20
> It's worth noting that anything above 4K@30Hz still requires high TMDS
> clock ratio and scrambling support, which hasn't been mainlined yet.
>=20
> Fixes: d74b842cab08 ("arm64: dts: rockchip: Add vop for rk3576")
> Cc: stable@vger.kernel.org
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
> arch/arm64/boot/dts/rockchip/rk3576.dtsi | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi =
b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
> index =
6a13fe0c3513fb2ff7cd535aa70e3386c37696e4..b1ac23035dd789f0478bf10c78c74ef1=
67d94904 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
> @@ -1155,12 +1155,14 @@ vop: vop@27d00000 {
> <&cru HCLK_VOP>,
> <&cru DCLK_VP0>,
> <&cru DCLK_VP1>,
> - <&cru DCLK_VP2>;
> + <&cru DCLK_VP2>,
> + <&hdptxphy>;
> clock-names =3D "aclk",
>      "hclk",
>      "dclk_vp0",
>      "dclk_vp1",
> -      "dclk_vp2";
> +      "dclk_vp2",
> +      "pll_hdmiphy0";
> iommus =3D <&vop_mmu>;
> power-domains =3D <&power RK3576_PD_VOP>;
> rockchip,grf =3D <&sys_grf>;
>=20
> --=20
> 2.49.0
>=20
>=20
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

Cristian,
It fixes fractional hd modes for me on rk3576.
Thx for this fix!
 =20

