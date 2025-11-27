Return-Path: <stable+bounces-197503-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5D9C8F37A
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 16:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B84983A3008
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 15:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1AD02BE7AD;
	Thu, 27 Nov 2025 15:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="FW8crPtd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9FC2475E3
	for <stable@vger.kernel.org>; Thu, 27 Nov 2025 15:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764256262; cv=none; b=EPGJ4D4Q1kJKs6jP5uKi6tit8vFwOAntLs4hWz8eFWsMPZL6OGMrjW/+vOh/pF6lYJ9QEhQ2MedCfzHDBjKwej5Xd1LToL6g5w++lvmP3a+M+dJ/Gp0cLCRnGCa7yqjkQLyrwUkJO36Lwhz/8a9qsGZYPes5J2KAEbf/0EPig60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764256262; c=relaxed/simple;
	bh=2qqKLxzsznQmxl3EGbTOvkQ53kf5KLCsBW+pMPJTFnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SYfLqY8uWm4/Z4Au1urmS7NJn+n9Mu+NC2WAKV8Hx2AM1ZIggi0zphvkAFfpOrA1pqXp4cvJMyqiCqUlBki7ztZ1CQTWWc8+HozOyPmGycob3UPYSdgqd8InUfZNlXDR2BJ22gAQ+wH55otY+8YqgS1OYuTU1xrFkAHqDsUjgbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=FW8crPtd; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1764256253;
 bh=EaTOVJoMb3GVdUlxOvtR/lv+2wvrGaK2bk6xiFUlwXc=;
 b=FW8crPtdP04Zr1xLgu3id7U+WGk2+UWjet+Lt6DBADNZH8Bt1A2RtUBu+oO8nECUOiT7bKm9c
 DfFsX0v5rGsCLf7rM7b8PVL5vJt2p4Iw4ad4bkGdTkS4EvenjyHn/cghizxpfuY3ulbtF9nWh78
 Cu1JzTfFhIGNTMgu6GUhROTNcM5ey8mInvwd2GYq+lW4DG6tZcu0tVpabUuDDShM9YB/mZMln5k
 w064YMJoQOiVDQnHLwhDwOFJ1I3HIUBAFdjvdi+J3i3AHhRVzzCHT42kZ/2vZMmWXAiFPOPtMl2
 wiVN66MoNOopqvRdmO9DY4cRCJHdtatoTdIEN7dnXJvA==
X-Forward-Email-ID: 692869f2361c660d902bad35
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.6.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <ab1d240f-4130-4088-9ead-9fb562ee9ad2@kwiboo.se>
Date: Thu, 27 Nov 2025 16:10:38 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "arm64: dts: rockchip: fix audio-supply for Rock
 Pi 4"
To: Quentin Schulz <foss+kernel@0leil.net>, FUKAUMI Naoki <naoki@radxa.com>,
 Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Alex Bee <knaerzche@gmail.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Quentin Schulz <quentin.schulz@cherry.de>, stable@vger.kernel.org,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20251127-rock-pi-4-io-domain-apio5-v1-1-9cb92793f734@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20251127-rock-pi-4-io-domain-apio5-v1-1-9cb92793f734@cherry.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Quentin,

On 11/27/2025 3:36 PM, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> This reverts commit 8240e87f16d17a9592c9d67857a3dcdbcb98f10d.
> 
> The original commit claimed that APIO5 IO domain (supplied with
> audio-supply) is supplied by RK808-D Buck 4 as stated in the schematics.
> 
> The linked PDF has two non-schematics pages where APIO5 indeed is said
> to be 1.8V. Reading the actual schematics[1][2][3][4][5][6][7][8], this
> is actually wrong as APIO5 is supplied VCC_3V0 which is LDO8 from
> RK808-D and is 3.0V instead of 1.8V from vcca1v8_codec.
> 
> This fixes the console disappearing in U-Boot, where the Device Tree is
> imported from the Linux kernel repo, when the IO domain driver is built,
> as reported by Heinrich[9]. As to why this breaks the console while the
> serial is not exposed on any of the pins on the bank in the APIO5
> domain, that is a well-kept secret by the SoC for now.
> 
> The issue "fixed" by the original commit will need to be fixed another
> way.
> 
> [1] https://dl.radxa.com/rockpi4/docs/hw/rockpi4/4ap/radxa_rock_4ap_v1600_schematic.pdf
> [2] https://dl.radxa.com/rockpi4/docs/hw/rockpi4/4ap/radxa_rock_4ap_v1730_schematic.pdf
> [3] https://dl.radxa.com/rockpi4/docs/hw/rockpi4/4bp/radxa_rock_4bp_v1600_schematic.pdf
> [4] https://dl.radxa.com/rockpi4/docs/hw/rockpi4/4bp/radxa_rock_4bp_v1730_schematic.pdf
> [5] https://dl.radxa.com/rockpi4/docs/hw/rockpi4/ROCK-4-SE-V1.53-SCH.pdf
> [6] https://dl.radxa.com/rockpi4/docs/hw/rockpi4/4b/ROCK_4B_v1.52_SCH.pdf
> [7] https://dl.radxa.com/rockpi4/docs/hw/rockpi4/4a/ROCK_4A_V1.52_SCH.pdf
> [8] https://dl.radxa.com/rockpi4/docs/hw/rockpi4/rockpi4_v13_sch_20181112.pdf
> [9] https://lore.kernel.org/u-boot/e7b7b905-4a6c-4342-b1a5-0ad32a5837cf@gmx.de/
> 
> Cc: stable@vger.kernel.org
> Reported-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
> Note: I do not own any of the Rock Pi 4 variants so I cannot work on
> fixing the original issue report by Alex.
> ---
>  arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
> index 046dbe3290178..fda7ea87e4efc 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
> @@ -516,7 +516,7 @@ &i2s2 {
>  };
>  
>  &io_domains {
> -	audio-supply = <&vcca1v8_codec>;
> +	audio-supply = <&vcc_3v0>;

This revert/patch seem to be identical to the following patch from a
month ago:

https://lore.kernel.org/all/20251027005220.22298-1-naoki@radxa.com/

Regards,
Jonas

>  	bt656-supply = <&vcc_3v0>;
>  	gpio1830-supply = <&vcc_3v0>;
>  	sdmmc-supply = <&vcc_sdio>;
> 
> ---
> base-commit: 765e56e41a5af2d456ddda6cbd617b9d3295ab4e
> change-id: 20251127-rock-pi-4-io-domain-apio5-26bc2afa8224
> 
> Best regards,


