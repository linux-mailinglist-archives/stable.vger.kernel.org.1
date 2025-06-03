Return-Path: <stable+bounces-150644-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49939ACBF1D
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 06:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1914116F941
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 04:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD6D190462;
	Tue,  3 Jun 2025 04:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jqTV9vHL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869F585626
	for <stable@vger.kernel.org>; Tue,  3 Jun 2025 04:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748924146; cv=none; b=HmuRhq2nwykoQDSaGs/26lk5tq3/XhoywP1OW3jKz57RNt8Eu9W/Ii0fDwA1voj1W2KHaX1yyNjkLXOvzfqF9/NOfhpVneyEW7WEUedeEGUlIe+PZEkkt7hKDWc6//i06k/R0a3EFYMxKQfn/OG/vMhQsqr/u9I0eICmii/5WpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748924146; c=relaxed/simple;
	bh=4q0+iB3XnBAtNw5Ck3xz92GuwTNhM25Es4pbTN41U6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p6gSz2Ud3qyEWIzEfLfz9NHK1uYgC3oSVOImlvf8D9eaHB9fSM4x9HIHlCLufveqUVkAlthMNWdWntVRCVPWH1VTplueNTsUjKYZxzSq6K07bUbHbOK/P6Y0VDc0a61Z99P2bHcfX7UPEUB/zWxT15ioSXogdPqJO7FLNPUcPMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jqTV9vHL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C25BC4CEED;
	Tue,  3 Jun 2025 04:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748924146;
	bh=4q0+iB3XnBAtNw5Ck3xz92GuwTNhM25Es4pbTN41U6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jqTV9vHLgxw3RhWwNLOW5DAeMn+n/Ppyo3uI4XaEOR14lD6L6qawFZozLrjJzN0YN
	 QGBE1tJps6IVR28OedVK/doFTVTw58x+UbEmJSarNWI9PDMf92k8HodVfmcGjzo82K
	 MOCJvgspUIGcsDNFbsE+tjduUWvVT4LcjtQ0AHcE=
Date: Tue, 3 Jun 2025 06:15:43 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Judith Mendez <jm@ti.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 6.1.y] arm64: dts: ti: k3-am62-main: Set eMMC clock
 parent to default
Message-ID: <2025060339-fraying-arrange-e97a@gregkh>
References: <2025060230-sacrifice-vexingly-4e21@gregkh>
 <20250602222012.82867-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250602222012.82867-1-jm@ti.com>

On Mon, Jun 02, 2025 at 05:20:12PM -0500, Judith Mendez wrote:
> Set eMMC clock parents to the defaults which is MAIN_PLL0_HSDIV5_CLKOUT
> for eMMC. This change is necessary since DM is not implementing the
> correct procedure to switch PLL clock source for eMMC and MMC CLK mux is
> not glich-free. As a preventative action, lets switch back to the defaults.
> 
> Fixes: c37c58fdeb8a ("arm64: dts: ti: k3-am62: Add more peripheral nodes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Judith Mendez <jm@ti.com>
> Acked-by: Udit Kumar <u-kumar1@ti.com>
> Acked-by: Bryan Brattlof <bb@ti.com>
> Link: https://lore.kernel.org/r/20250429163337.15634-2-jm@ti.com
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> index 04222028e53e..03f7bd5dd53f 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> @@ -384,8 +384,6 @@ sdhci0: mmc@fa10000 {
>  		power-domains = <&k3_pds 57 TI_SCI_PD_EXCLUSIVE>;
>  		clocks = <&k3_clks 57 5>, <&k3_clks 57 6>;
>  		clock-names = "clk_ahb", "clk_xin";
> -		assigned-clocks = <&k3_clks 57 6>;
> -		assigned-clock-parents = <&k3_clks 57 8>;
>  		mmc-ddr-1_8v;
>  		mmc-hs200-1_8v;
>  		ti,trm-icp = <0x2>;
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

