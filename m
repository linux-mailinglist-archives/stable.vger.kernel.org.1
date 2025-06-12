Return-Path: <stable+bounces-152490-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C51AD641D
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 02:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3B94189E247
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 00:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CD48821;
	Thu, 12 Jun 2025 00:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b="B89YEpc1"
X-Original-To: stable@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2DDA48;
	Thu, 12 Jun 2025 00:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749686506; cv=pass; b=NSIhTaLUKUaieSjegL/s1h2ZEFmtyi0o7V+1G6bbdVw4eusm4S36MdyHN6W2WeN7WJ1F/Q49nfkVsTdFEDUl3UOJeZ3IcMNLQx48JFsV3KGXBiObu3XC2nAl1LUos90JvDHH/kdPLvhPZ8LyDdh46JyGNgJ7xC4mxF2bl5MEcJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749686506; c=relaxed/simple;
	bh=f2HADJN1HqnVLqXEX2gn0EBHpS9KEi/mJMzRBKyEVi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E5MnDvnF4ELFvA71I6XVGRcwV4Ty4/fT6DHSlkrOy4SSCGWFHqsdBT82yKAv5mSD4bXrgsHbX1+y0hOL/R1xfCVIWp3zuMQ3zPiDESrE6WhhafYctm1V935aFNe5V9a0b4JU40GzvbQkNbUpLsNro6jJu1N5DfOpPUJev8W7htk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b=B89YEpc1; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1749686457; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RfUJLgL3uiMWBMZumyBvXpsPE2UMpPd3FQWhCEKj5YlW8CpCzh8drQyfbMrEH8EI96d+2L11XOX5VD8utD7ZQvI72LE3wD2WqVRCfseYEcpBtT89TeHnQkNROZlE4l4T30nS1s5igLVgQ6v8kOUqwsQ1WQi9yn43D3hkqHIXd4M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1749686457; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=vGmPNxgIyEoEQtADc8X3nicC6jEVHqGcMDg8y3I/t3o=; 
	b=B+8YjO+uqewQPSBMsMZO6HJPPCQm9iq5yZbYGgyvPx9snSvvqPnZ8jtAq+qoggS+EzUENfcIHw3z5Y1WcmVQeji7a1RpZvILe0SwcMk83npw/qm0ZAUqQ0XP0wIKnQV1QNN6DPKM+YkqsHtxkwVDzB9EXxBmX0V3TC9R0hZvKIw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=detlev.casanova@collabora.com;
	dmarc=pass header.from=<detlev.casanova@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1749686457;
	s=zohomail; d=collabora.com; i=detlev.casanova@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=vGmPNxgIyEoEQtADc8X3nicC6jEVHqGcMDg8y3I/t3o=;
	b=B89YEpc18TsrakKZypLJ7xGiQ6kWyg6E59pyj89kKZmDWb8r5NGmKQEPYBR0D3Fx
	NOmEBD89GluYxB12j6rZV/ZLix7X6ZnTqRW+Xn5Cg0Q5qqzsIW6u1ft1kCPfBt/+hqq
	pup6vSnHDcfX3ZuwlZ+C2RdyjA7nJpHzR9/gtB8U=
Received: by mx.zohomail.com with SMTPS id 1749686454865928.7893063021048;
	Wed, 11 Jun 2025 17:00:54 -0700 (PDT)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: Sandy Huang <hjc@rock-chips.com>,
 Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: kernel@collabora.com, Andy Yan <andyshrk@163.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject:
 Re: [PATCH 3/3] arm64: dts: rockchip: Add HDMI PHY PLL clock source to VOP2
 on rk3576
Date: Wed, 11 Jun 2025 20:00:52 -0400
Message-ID: <6011857.DvuYhMxLoT@trenzalore>
In-Reply-To: <20250612-rk3576-hdmitx-fix-v1-3-4b11007d8675@collabora.com>
References:
 <20250612-rk3576-hdmitx-fix-v1-0-4b11007d8675@collabora.com>
 <20250612-rk3576-hdmitx-fix-v1-3-4b11007d8675@collabora.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-ZohoMailClient: External

Hi Cristian,

On Wednesday, 11 June 2025 17:47:49 EDT Cristian Ciocaltea wrote:
> Since commit c871a311edf0 ("phy: rockchip: samsung-hdptx: Setup TMDS
> char rate via phy_configure_opts_hdmi"), the workaround of passing the
> rate from DW HDMI QP bridge driver via phy_set_bus_width() became
> partially broken, as it cannot reliably handle mode switches anymore.
> 
> Attempting to fix this up at PHY level would not only introduce
> additional hacks, but it would also fail to adequately resolve the
> display issues that are a consequence of the system CRU limitations.
> 
> Instead, proceed with the solution already implemented for RK3588: make
> use of the HDMI PHY PLL as a better suited DCLK source for VOP2. This
> will not only address the aforementioned problem, but it should also
> facilitate the proper operation of display modes up to 4K@60Hz.
> 
> It's worth noting that anything above 4K@30Hz still requires high TMDS
> clock ratio and scrambling support, which hasn't been mainlined yet.
> 
> Fixes: d74b842cab08 ("arm64: dts: rockchip: Add vop for rk3576")
> Cc: stable@vger.kernel.org
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3576.dtsi | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
> b/arch/arm64/boot/dts/rockchip/rk3576.dtsi index
> 6a13fe0c3513fb2ff7cd535aa70e3386c37696e4..b1ac23035dd789f0478bf10c78c74ef16
> 7d94904 100644 --- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
> @@ -1155,12 +1155,14 @@ vop: vop@27d00000 {
>  				 <&cru HCLK_VOP>,
>  				 <&cru DCLK_VP0>,
>  				 <&cru DCLK_VP1>,
> -				 <&cru DCLK_VP2>;
> +				 <&cru DCLK_VP2>,
> +				 <&hdptxphy>;
>  			clock-names = "aclk",
>  				      "hclk",
>  				      "dclk_vp0",
>  				      "dclk_vp1",
> -				      "dclk_vp2";
> +				      "dclk_vp2",
> +				      "pll_hdmiphy0";
>  			iommus = <&vop_mmu>;
>  			power-domains = <&power RK3576_PD_VOP>;
>  			rockchip,grf = <&sys_grf>;

I tested this on the ROCK 4D and can confirm that:
 - New modes like 2K are now working
 - Mode changes is now correctly supported

So,
Tested-By: Detlev Casanova <detlev.casanova@collabora.com>

Regards,

Detlev.



