Return-Path: <stable+bounces-150643-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCAAACBF1C
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 06:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAFA8170071
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 04:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19A9190462;
	Tue,  3 Jun 2025 04:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2nR/z7D5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E45385626
	for <stable@vger.kernel.org>; Tue,  3 Jun 2025 04:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748924140; cv=none; b=aabW/78zRkkOOuCkenj8VjfQzoEyDkR8Qzej5MRL3tCw/U8xB50UnyQLCRKqAVe+0uzzNmQNZ8vdfA3Plhx1b9rM81s1Fzq2eQIZC2Lbv3pyKYqpTgyANrUwVc4c+fJMIqyyMAvsg4O3l1Jnrr8v/0gabL0NLz6ss0F7flIcuIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748924140; c=relaxed/simple;
	bh=TtiBvt/lyBeXO3qMUGQtyN6ZDAsJollXV9F2LqGXkUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gOMnCDktjZqetAmhLb16rmHvOXSnlBK4RiGutd1hVQWYjrz5nnNgT0PfW7nAXk9V5OEFZ6ysnQ7H1NWrC1YjltbGB5mdVrarQV9vfXehO2Xo7Jq/dsTjkG9OIX8yJ91be7sHLa01IGCX6wTBf3ojETTXpyyZhmw/LeHwn1H44jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2nR/z7D5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78768C4CEED;
	Tue,  3 Jun 2025 04:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748924139;
	bh=TtiBvt/lyBeXO3qMUGQtyN6ZDAsJollXV9F2LqGXkUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2nR/z7D5CymlTQbGxdyg6lJvWjm4HT14y2o0Yv/kvTH3JDP5LCK0jx14nq5N+is1J
	 +Gqz6deV2uqE9r6/lYvRvICZdwO8eekOoBMXVgGaw2xkuuI5+Y+6kmSKIQ+fgMEF9F
	 6Bd6BEDm1G++QmzcFuN8AFjVWjafYPt9UysC3lVI=
Date: Tue, 3 Jun 2025 06:15:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Judith Mendez <jm@ti.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 6.6.y] arm64: dts: ti: k3-am65-main: Add missing taps to
 sdhci0
Message-ID: <2025060333-bullring-striving-8912@gregkh>
References: <2025060218-subdivide-smashing-0ef7@gregkh>
 <20250602222827.86162-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250602222827.86162-1-jm@ti.com>

On Mon, Jun 02, 2025 at 05:28:27PM -0500, Judith Mendez wrote:
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
> index 57befcce93b9..2e5f4f1af52f 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> @@ -447,6 +447,9 @@ sdhci0: mmc@4f80000 {
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

