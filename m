Return-Path: <stable+bounces-150641-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E63ACBF1A
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 06:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6817716FC52
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 04:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EE71EFF8D;
	Tue,  3 Jun 2025 04:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qi4hRRDy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA4B17C220
	for <stable@vger.kernel.org>; Tue,  3 Jun 2025 04:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748924127; cv=none; b=OqGjBYKemvA57ZyU6tTA2jjPuBMck2IgwLBx4GP9wPd2Z48wXnqg7QYgFXmfvHEi9xC9jZrKixkUJhEjkYAy3i22r4LLY4YcSyczozMc1Hd4mPmxPL99k0v6h7cKPebwuv4Kn8QkqhhsZRUfZK5qFuy4BpT/fxzOJZGJ75+p46M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748924127; c=relaxed/simple;
	bh=PfGp+Q2RNTIb1IIA8E4I06HpnQkmlDhq8rCwP0uFtMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=blDndLEbWiZG/K4upgLMlyuVWtiYi3c9j44xtpEM5dBqhkVjNd7rFsfTKSpQKjacYdWPJuCX9h+NPZCkPGy4JfXz38kNjJqpH6kVYVQ4WduPjOwD99z6tkC8O2OFuUQGOJxjFqpMXrvSS/bhG3TRbqG1ldKo5toXQSrjgVGOXfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qi4hRRDy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9930DC4CEED;
	Tue,  3 Jun 2025 04:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748924126;
	bh=PfGp+Q2RNTIb1IIA8E4I06HpnQkmlDhq8rCwP0uFtMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qi4hRRDy+IIz2tus1bWnrDWKz3r7+rzLmjRhlhV7soDHc5GxLrmwSh3VHKqQ21BIo
	 EptVLngTuEizhgjqOzLDl8noQQx/ykIbSYPAAI7o6lLV6WNRKtO0IMoZ9pajO0T5Ly
	 xDre1CQ2Nosml5Lz1zgNrIVIY5c301K5Y1QFKHOM=
Date: Tue, 3 Jun 2025 06:15:24 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Judith Mendez <jm@ti.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 5.10.y] arm64: dts: ti: k3-am65-main: Add missing taps to
 sdhci0
Message-ID: <2025060315-speak-lumping-05dc@gregkh>
References: <2025060219-slicing-gargle-f481@gregkh>
 <20250602224224.92221-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250602224224.92221-1-jm@ti.com>

On Mon, Jun 02, 2025 at 05:42:24PM -0500, Judith Mendez wrote:
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
> index a3538279d710..ae2284bd5f32 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> @@ -279,6 +279,9 @@ sdhci0: sdhci@4f80000 {
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

