Return-Path: <stable+bounces-150642-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C18ACBF1B
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 06:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C3C11890028
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 04:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9281E7C24;
	Tue,  3 Jun 2025 04:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qwLzEq8d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0EA17C220
	for <stable@vger.kernel.org>; Tue,  3 Jun 2025 04:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748924134; cv=none; b=JvU8yj3HLEBsJaHk5sKDUaNHSy4Wx7JPv5zAkHXG7mTTyuFjJPWOZg9TTrjisnXNSsp1F1uOpy0fHiGYQXp/1GbRmb7c6Dl+lUe9cpyb/Tg/7TyFImsc1lcvv6joOWFaxx0UD0SP41FVC1wDrcyv5aXVkzQHmLODeVboi/58m0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748924134; c=relaxed/simple;
	bh=KPjM3W07MC1akqHlwvhFADbVh0412ooIfTaARDqg8Rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pg3UUtQ2JyplyjOhRoqi7wSjqYaOFR4lqVcTvZF0ybM83bHF78Q7jAAojAoWdfB7iNSVHZbwUPbzv2rWOE7wetaTXWPC50l0e6oWBmDJoRsq4iwlGibrCeEmtszVzYSe5d2rxAAqXb20pOnPBxPdMi9l4muzcFU60JQf9ShSpDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qwLzEq8d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C87CC4CEED;
	Tue,  3 Jun 2025 04:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748924133;
	bh=KPjM3W07MC1akqHlwvhFADbVh0412ooIfTaARDqg8Rs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qwLzEq8d/DSRSr3uIEJpHJLePwE6bXgO4lN7Suz0DJkVqXDkpnUESwgyRQmTPACdZ
	 dp2JPmtiXYNNeB/fJgyLxzYxiO7pUKaRCBVNJ2yUDqQSO7riEP3ipG+Oe6hSgZwUje
	 6ZyeICahjd1SfDM4brgWN1CyvquL2eM+WlmV7el4=
Date: Tue, 3 Jun 2025 06:15:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Judith Mendez <jm@ti.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 6.1.y] arm64: dts: ti: k3-am65-main: Add missing taps to
 sdhci0
Message-ID: <2025060327-guidance-scrawny-3dba@gregkh>
References: <2025060218-borrowing-cartload-20af@gregkh>
 <20250602223132.87435-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250602223132.87435-1-jm@ti.com>

On Mon, Jun 02, 2025 at 05:31:32PM -0500, Judith Mendez wrote:
> For am65x, add missing ITAPDLYSEL values for Default Speed and High
> Speed SDR modes to sdhci0 node according to the device datasheet [0].
> 
> [0] https://www.ti.com/lit/gpn/am6548
> 
> Fixes: eac99d38f861 ("arm64: dts: ti: k3-am654-main: Update otap-del-sel values")
> Cc: stable@vger.kernel.org
> Signed-off-by: Judith Mendez <jm@ti.com>
> Reviewed-by: Moteen Shah <m-shah@ti.com>
> Link: https://lore.kernel.org/r/20250429173009.33994-1-jm@ti.com
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> index 83dd8993027a..637cd88078ac 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> @@ -273,6 +273,9 @@ sdhci0: mmc@4f80000 {
>  		ti,otap-del-sel-ddr52 = <0x5>;
>  		ti,otap-del-sel-hs200 = <0x5>;
>  		ti,otap-del-sel-hs400 = <0x0>;
> +		ti,itap-del-sel-legacy = <0xa>;
> +		ti,itap-del-sel-mmc-hs = <0x1>;
> +		ti,itap-del-sel-ddr52 = <0x0>;
>  		ti,trm-icp = <0x8>;
>  		dma-coherent;
>  	};
> -- 
> 2.49.0
> 
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

