Return-Path: <stable+bounces-152531-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB96AD6783
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 07:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75F7D189B953
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 05:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EA31D5ACE;
	Thu, 12 Jun 2025 05:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TJiONlJ9"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014902AE6D;
	Thu, 12 Jun 2025 05:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749707482; cv=none; b=M2du0HGwvX/r3e/9TOFtKmX1IvENfxuAc7Qb4scnmSVDkerxbekXAzrnAb/pBaaWerW+/CfqBd27142z9s+bjR80UwLc3uMOwTa6au6qoeAfrh6gCVZyzogL5rLkTU+6KPbueltbW8RKEtPhkfH4gSLTZ0BFvtxCFDOYMf+WOdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749707482; c=relaxed/simple;
	bh=slvcAQUT+HFsllFYLGyw5Fofz5HxNlsL+2o5mQBM/0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b/73GVBBkoTms+NRRMKWMludeYjJ8oHrR1jepgrNLf0q/EeVQaH6omQPxgho1evyMt4enKkrF4Vv3E+aSZH9pEIGucneBDhHEfi1t+dcCnNjdKjnenPt4PyjIwwIktUsYaNHimE3NDHq7t8i+PaHYuaX2ZunIvAWdfutJnTnXwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TJiONlJ9; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1749707477;
	bh=slvcAQUT+HFsllFYLGyw5Fofz5HxNlsL+2o5mQBM/0s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TJiONlJ9E7Ze3sRhwKZBV9R9Z6MEzthUCgwvyz+PCAR+b70XacpHK1Ok/w3otAUFo
	 xcTXGKlAwRPHZ1F6LQYAfijJx8cPS2ocEIIYr5CIe0ASepzhEjtn3vMGn46lxkk2eW
	 8psRt03UkK1YeCc6FFFhyESjq4YJXMdOEo/0/I0ziEoIMbfNowwJy5KPqv/k5cZNgZ
	 MxuwYQMKU4LDB3uCpiJrUHZmeU79iOy4kKyhervclnE+dBW10wK/xsvQM6s/UVMUUa
	 UcN/1JEs4AAex34cYtPmWbGHMbMtJnA49vF7KX6dJwpN6QDEC+iw572cMrnmH9AY6/
	 TKCFRDlv01aYQ==
Received: from [192.168.1.90] (unknown [212.93.144.165])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 19B3E17E0863;
	Thu, 12 Jun 2025 07:51:17 +0200 (CEST)
Message-ID: <33376472-679b-406f-aadb-41dd540c47cf@collabora.com>
Date: Thu, 12 Jun 2025 08:51:05 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: Add HDMI PHY PLL clock source
 to VOP2 on rk3576
To: Detlev Casanova <detlev.casanova@collabora.com>,
 Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: kernel@collabora.com, Andy Yan <andyshrk@163.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250612-rk3576-hdmitx-fix-v1-0-4b11007d8675@collabora.com>
 <20250612-rk3576-hdmitx-fix-v1-3-4b11007d8675@collabora.com>
 <6011857.DvuYhMxLoT@trenzalore>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <6011857.DvuYhMxLoT@trenzalore>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Detlev,

On 6/12/25 3:00 AM, Detlev Casanova wrote:
> Hi Cristian,
> 
> On Wednesday, 11 June 2025 17:47:49 EDT Cristian Ciocaltea wrote:
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
>>  arch/arm64/boot/dts/rockchip/rk3576.dtsi | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
>> b/arch/arm64/boot/dts/rockchip/rk3576.dtsi index
>> 6a13fe0c3513fb2ff7cd535aa70e3386c37696e4..b1ac23035dd789f0478bf10c78c74ef16
>> 7d94904 100644 --- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
>> @@ -1155,12 +1155,14 @@ vop: vop@27d00000 {
>>  				 <&cru HCLK_VOP>,
>>  				 <&cru DCLK_VP0>,
>>  				 <&cru DCLK_VP1>,
>> -				 <&cru DCLK_VP2>;
>> +				 <&cru DCLK_VP2>,
>> +				 <&hdptxphy>;
>>  			clock-names = "aclk",
>>  				      "hclk",
>>  				      "dclk_vp0",
>>  				      "dclk_vp1",
>> -				      "dclk_vp2";
>> +				      "dclk_vp2",
>> +				      "pll_hdmiphy0";
>>  			iommus = <&vop_mmu>;
>>  			power-domains = <&power RK3576_PD_VOP>;
>>  			rockchip,grf = <&sys_grf>;
> 
> I tested this on the ROCK 4D and can confirm that:
>  - New modes like 2K are now working
>  - Mode changes is now correctly supported
> 
> So,
> Tested-By: Detlev Casanova <detlev.casanova@collabora.com>

Thanks for taking the time to perform all these tests!

Cristian

