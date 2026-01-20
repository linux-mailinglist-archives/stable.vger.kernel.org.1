Return-Path: <stable+bounces-210426-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DACD3BE1E
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 05:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 38DF33506D8
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 04:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2807A33971F;
	Tue, 20 Jan 2026 04:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="RpwlWdwR"
X-Original-To: stable@vger.kernel.org
Received: from mail-m1973172.qiye.163.com (mail-m1973172.qiye.163.com [220.197.31.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A557E33375D;
	Tue, 20 Jan 2026 04:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768881734; cv=none; b=pHvFOWV3TZWPpi7PbN9TX0AKs2nj0mfZubZyKvKgVvIQfKDwTWcxaY4DYXHthYuUcj+poSGAoYAdZZiyR1Wt/QHeamJNgc5PpL7RtmacDFqcPR4Z86biK7fFxXUOm9onYZ/DIiZIcqlqR/fwCzpkkyoO8MvVVRzzhjaKsgGLrTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768881734; c=relaxed/simple;
	bh=ZLf0T+z9/Q95LTTYGu5XIAtLfLv12VAB4DowO3lzBR0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iV+vXMk0+5APV1ljLqjCq97OK697mPNQ1TZQOCC7xFpwJUYkYBJV0FDyK6XE0+E17WrRbO6oDGfWZ/TWgdPxtWIMXq0Badja5VqsX4dJGkZ3DjCOUvg4hjavWbXEdCoapEIdmpRccgUO1Ts1vY4O5L3Op6OJvlRUgI5JG6/hBXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=RpwlWdwR; arc=none smtp.client-ip=220.197.31.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3139770be;
	Tue, 20 Jan 2026 09:39:29 +0800 (GMT+08:00)
Message-ID: <6479d7b8-7712-4181-9c82-0021da94d1a8@rock-chips.com>
Date: Tue, 20 Jan 2026 09:39:28 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Quentin Schulz <quentin.schulz@cherry.de>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Explicitly request UFS reset pin on
 RK3576
To: Alexey Charkov <alchark@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Manivannan Sadhasivam <mani@kernel.org>
References: <20260119-ufs-rst-v1-1-c8e96493948c@gmail.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20260119-ufs-rst-v1-1-c8e96493948c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9bd90e901f09cckunmca3c291e9e5067
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR8fH1ZCHUpMH0hCQk5ISkJWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=RpwlWdwR4M5y3riZVJjUTSCD/0J510nEIm61VuQOicb7e5VAD7YF+SIKGxUl4BQyEfxSiKNPdjl/C8ma2YRe1ugqLoMFm7WYE/8uLhnPgVaqqq0wnFEqml2qFNTbUTP+/QRcNMRvOZvKiNYk7wfeUHHQAV/yrGWUx5Gtdie/1lU=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=aWYGu5J9V5z11TMqc+8jFIAluBajua9+OLQjTlFfPqI=;
	h=date:mime-version:subject:message-id:from;

在 2026/01/19 星期一 17:22, Alexey Charkov 写道:
> Rockchip RK3576 UFS controller uses a dedicated pin to reset the connected
> UFS device, which can operate either in a hardware controlled mode or as a
> GPIO pin.
> 

It's the only one 1.2V IO could be used on RK3576 to reset ufs devices,
except ufs refclk. So it's a dedicated pin for sure if using ufs, that's
why we put it into rk3576.dtsi.

> Power-on default is GPIO mode, but the boot ROM reconfigures it to a
> hardware controlled mode if it uses UFS to load the next boot stage.
> 

ROM code could be specific, but the linux/loader driver is compatible，
so for the coming SoCs, with more 1.2V IO could be used, it's more
flexible to use gpio-based instead of hardware controlled(of course,
move reset pinctrl settings into board dts).

> Given that existing bindings (and rk3576.dtsi) expect a GPIO-controlled
> device reset, request the required pin config explicitly.
> 
> This doesn't appear to affect Linux, but it does affect U-boot:
> 

IIUC, it's more or less a fix for loader, more precisely U-boot here?
I'm not entirely certain about the handling here, is it standard
convention to add a fixes tag in this context?


> Before:
> => md.l 0x2604b398
> 2604b398: 00000011 00000000 00000000 00000000  ................
> < ... snip ... >
> => ufs init
> ufshcd-rockchip ufshc@2a2d0000: [RX, TX]: gear=[3, 3], lane[2, 2], pwr[FASTAUTO_MODE, FASTAUTO_MODE], rate = 2
> => md.l 0x2604b398
> 2604b398: 00000011 00000000 00000000 00000000  ................
> 
> After:
> => md.l 0x2604b398
> 2604b398: 00000011 00000000 00000000 00000000  ................
> < ... snip ...>
> => ufs init
> ufshcd-rockchip ufshc@2a2d0000: [RX, TX]: gear=[3, 3], lane[2, 2], pwr[FASTAUTO_MODE, FASTAUTO_MODE], rate = 2
> => md.l 0x2604b398
> 2604b398: 00000010 00000000 00000000 00000000  ................
> 
> (0x2604b398 is the respective pin mux register, with its BIT0 driving the
> mode of UFS_RST: unset = GPIO, set = hardware controlled UFS_RST)
> 
> This helps ensure that GPIO-driven device reset actually fires when the
> system requests it, not when whatever black box magic inside the UFSHC
> decides to reset the flash chip.
> 
> Cc: stable@vger.kernel.org
> Fixes: c75e5e010fef ("scsi: arm64: dts: rockchip: Add UFS support for RK3576 SoC")
> Reported-by: Quentin Schulz <quentin.schulz@cherry.de>
> Signed-off-by: Alexey Charkov <alchark@gmail.com>
> ---
> This has originally surfaced during the review of UFS patches for U-boot
> at [1], where it was found that the UFS reset line is not requested to be
> configured as GPIO but used as such. This leads in some cases to the UFS
> driver appearing to control device resets, while in fact it is the
> internal controller logic that drives the reset line (perhaps in
> unexpected ways).
> 
> Thanks Quentin Schulz for spotting this issue.
> 
> [1] https://lore.kernel.org/u-boot/259fc358-f72b-4a24-9a71-ad90f2081335@cherry.de/
> ---
>   arch/arm64/boot/dts/rockchip/rk3576-pinctrl.dtsi | 7 +++++++
>   arch/arm64/boot/dts/rockchip/rk3576.dtsi         | 2 +-
>   2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3576-pinctrl.dtsi b/arch/arm64/boot/dts/rockchip/rk3576-pinctrl.dtsi
> index 0b0851a7e4ea..20cfd3393a75 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3576-pinctrl.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3576-pinctrl.dtsi
> @@ -5228,6 +5228,13 @@ ufs_rst: ufs-rst {
>   				/* ufs_rstn */
>   				<4 RK_PD0 1 &pcfg_pull_none>;
>   		};
> +
> +		/omit-if-no-ref/
> +		ufs_rst_gpio: ufs-rst-gpio {
> +			rockchip,pins =
> +				/* ufs_rstn */
> +				<4 RK_PD0 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
>   	};
>   
>   	ufs_testdata0 {
> diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
> index 3a29c627bf6d..db610f57c845 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
> @@ -1865,7 +1865,7 @@ ufshc: ufshc@2a2d0000 {
>   			assigned-clock-parents = <&cru CLK_REF_MPHY_26M>;
>   			interrupts = <GIC_SPI 361 IRQ_TYPE_LEVEL_HIGH>;
>   			power-domains = <&power RK3576_PD_USB>;
> -			pinctrl-0 = <&ufs_refclk>;
> +			pinctrl-0 = <&ufs_refclk &ufs_rst_gpio>;
>   			pinctrl-names = "default";
>   			resets = <&cru SRST_A_UFS_BIU>, <&cru SRST_A_UFS_SYS>,
>   				 <&cru SRST_A_UFS>, <&cru SRST_P_UFS_GRF>;
> 
> ---
> base-commit: 46fe65a2c28ecf5df1a7475aba1f08ccf4c0ac1b
> change-id: 20260119-ufs-rst-ffbc0ec88e07
> 
> Best regards,


