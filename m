Return-Path: <stable+bounces-152549-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55984AD6E89
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 13:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDBCD3AD37F
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 11:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4528E239E99;
	Thu, 12 Jun 2025 11:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="crVdHEJH"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DD517A2EA;
	Thu, 12 Jun 2025 11:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749726280; cv=none; b=BoJ1xhMKZugwWmn9oJdssF+Q34Cwp0vC0bduPh4Cc6zk4qXRqSWdZC7RJo20yIbqV3Phs7AcRL7lspHQywDwe3XAKsxfpVd7x3LisRNPEFm17qS5oRmC492w+xGl5uYTmX0Gjr9APX902/zEI3cMcZoO7CDjhEUVr9iE9kB6LiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749726280; c=relaxed/simple;
	bh=+Ccw5JM2ysrP6p18gVlHfA/xuzZsyf6EShm65BKIUU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TVijJfjkxyB4d7ZBfG6amZk+1H2LqJZA1bDkn/tYO7/r+CgFlZtmMZtNItD5Q2oXRikA37990A5AJHcPzoSmf9dZuQCCibRPkSYOIVMZGeScLqfW/kbbsP4DIo3JJXvmXT1zfBX/8znYB0gTaoN7eI1CyI9sj5ogDrdpA1nmHOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=crVdHEJH; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1749726275;
	bh=+Ccw5JM2ysrP6p18gVlHfA/xuzZsyf6EShm65BKIUU4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=crVdHEJHZ49tKIM6cQp/sxc/UxQS0Md/A9mrs7WZOkhjq8cTDVp3bXd251kYyZ9ES
	 tIru8QtPCoM+ymTaCYPFVysC2oVFi+IWaKpPZfvhinNeiK5m/MPEGeljYEtCZktkcy
	 KU/RZjdrlRcTyhYOfuZNW+BAyPF1ZiTWe6B4ypKVOqwE9ROhDjFRYIpllSyfFapLc5
	 PMpW7jgXnYZwdrN5Ju3TXOQLHo4Saa6z6zyWdwl9RBrZd9JPyLu0lF5pMa1py3aSEU
	 dHQqmCoTgonMIG6DgcPYqqpehYKSSSwQBV09hbO0Vc6wdyXdncNZKGfflK2gF50f3d
	 QtXM5Fq6DOJJg==
Received: from [192.168.1.90] (unknown [212.93.144.165])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2B0D417E088C;
	Thu, 12 Jun 2025 13:04:35 +0200 (CEST)
Message-ID: <535a4e1c-33d3-4941-8315-df20d4dec799@collabora.com>
Date: Thu, 12 Jun 2025 14:04:09 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: Add HDMI PHY PLL clock source
 to VOP2 on rk3576
To: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
Cc: Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, kernel@collabora.com,
 Andy Yan <andyshrk@163.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250612-rk3576-hdmitx-fix-v1-0-4b11007d8675@collabora.com>
 <20250612-rk3576-hdmitx-fix-v1-3-4b11007d8675@collabora.com>
 <01D5D2D8-392B-4926-884E-1A4FB87C03CF@gmail.com>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <01D5D2D8-392B-4926-884E-1A4FB87C03CF@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/12/25 1:22 PM, Piotr Oniszczuk wrote:
> 
> 
>> Wiadomość napisana przez Cristian Ciocaltea <cristian.ciocaltea@collabora.com> w dniu 11 cze 2025, o godz. 23:47:
>>
>> Since commit c871a311edf0 ("phy: rockchip: samsung-hdptx: Setup TMDS
>> char rate via phy_configure_opts_hdmi"), the workaround of passing the
>> rate from DW HDMI QP bridge driver via phy_set_bus_width() became
>> partially broken, as it cannot reliably handle mode switches anymore.
>>
>> Attempting to fix this up at PHY level would not only introduce
>> additional hacks, but it would also fail to adequately resolve the
>> display issues that are a consequence of the system CRU limitations.
>>
>> Instead, proceed with the solution already implemented for RK3588: make
>> use of the HDMI PHY PLL as a better suited DCLK source for VOP2. This
>> will not only address the aforementioned problem, but it should also
>> facilitate the proper operation of display modes up to 4K@60Hz.
>>
>> It's worth noting that anything above 4K@30Hz still requires high TMDS
>> clock ratio and scrambling support, which hasn't been mainlined yet.
>>
>> Fixes: d74b842cab08 ("arm64: dts: rockchip: Add vop for rk3576")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>> arch/arm64/boot/dts/rockchip/rk3576.dtsi | 6 ++++--
>> 1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
>> index 6a13fe0c3513fb2ff7cd535aa70e3386c37696e4..b1ac23035dd789f0478bf10c78c74ef167d94904 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
>> @@ -1155,12 +1155,14 @@ vop: vop@27d00000 {
>> <&cru HCLK_VOP>,
>> <&cru DCLK_VP0>,
>> <&cru DCLK_VP1>,
>> - <&cru DCLK_VP2>;
>> + <&cru DCLK_VP2>,
>> + <&hdptxphy>;
>> clock-names = "aclk",
>>      "hclk",
>>      "dclk_vp0",
>>      "dclk_vp1",
>> -      "dclk_vp2";
>> +      "dclk_vp2",
>> +      "pll_hdmiphy0";
>> iommus = <&vop_mmu>;
>> power-domains = <&power RK3576_PD_VOP>;
>> rockchip,grf = <&sys_grf>;
>>
>> -- 
>> 2.49.0
>>
>>
>> _______________________________________________
>> Linux-rockchip mailing list
>> Linux-rockchip@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 
> Cristian,
> It fixes fractional hd modes for me on rk3576.
> Thx for this fix!

Thanks for testing! :)

