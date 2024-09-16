Return-Path: <stable+bounces-76177-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC95F979BBC
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 09:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 684BF1F2123F
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 07:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5997C47F46;
	Mon, 16 Sep 2024 07:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TVkh18vM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DD0282FD;
	Mon, 16 Sep 2024 07:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726470087; cv=none; b=P2NBSsOWN2U/4DcSbbKBcxbW82LxaU8wwZ3cV8z5YliE34sEOvWxkoWsA/KOHSx4L/NhewEMDp5c/PAMK3aFdB/afCN5yDSYRICsfjDy7lepLbzn4UC36Qk8tIoCyzk4aKMZVeM6mkcUcFt65KrxIPUy/YuvwjW9UTAuok1FuR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726470087; c=relaxed/simple;
	bh=1ikaFaSoCsPLoQgV04uNWfBUF7Pu3uTQmPOnd2a66xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eI6F7lN/e8hF+Ot4FKVhYwLwoM7s6dGexQrNJQsu5hLFWHbpNYwRlnOKBa25OyWT9t5WUT2FMwi7JePi6WloTrode/N9pAkWDAOADtRCd8I1iYUp4Eije6P0U7OPkpTXRvV6d5g6+N5c9jmSWMKzEPOkvGQqXWPinU37zRIBQ5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TVkh18vM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B5ABC4CEC4;
	Mon, 16 Sep 2024 07:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726470086;
	bh=1ikaFaSoCsPLoQgV04uNWfBUF7Pu3uTQmPOnd2a66xo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TVkh18vMOGCHbuu20LHp2Tqa/lUF4aQCbcOn9mj0y+qGt/m9y0kOWKUhoCitfXmdH
	 P+Sbq3e02AtgmgWzEAk2yWf3Q3Jz51kq5YEISIHEr9LA60Kh1zNx/z7I4ZfAHtWn1f
	 nzz/M1ib4CEqSwQdWm7lezK0PaZEFdnM9i712+ZU=
Date: Mon, 16 Sep 2024 09:01:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: WangYuli <wangyuli@uniontech.com>
Cc: stable@vger.kernel.org, sashal@kernel.org, william.qiu@starfivetech.com,
	emil.renner.berthing@canonical.com, conor.dooley@microchip.com,
	kernel@esmil.dk, conor@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.6 v3] riscv: dts: starfive: add assigned-clock* to
 limit frquency
Message-ID: <2024091616-shut-roundish-6a17@gregkh>
References: <247345579659D8F7+20240916034603.59120-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <247345579659D8F7+20240916034603.59120-1-wangyuli@uniontech.com>

On Mon, Sep 16, 2024 at 11:46:02AM +0800, WangYuli wrote:
> From: William Qiu <william.qiu@starfivetech.com>
> 
> [ Upstream commit af571133f7ae028ec9b5fdab78f483af13bf28d3 ]
> 
> In JH7110 SoC, we need to go by-pass mode, so we need add the
> assigned-clock* properties to limit clock frquency.
> 
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: WangYuli <wangyuli@uniontech.com>
> ---
>  .../riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> index 062b97c6e7df..4874e3bb42ab 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> @@ -204,6 +204,8 @@ &i2c6 {
>  
>  &mmc0 {
>  	max-frequency = <100000000>;
> +	assigned-clocks = <&syscrg JH7110_SYSCLK_SDIO0_SDCARD>;
> +	assigned-clock-rates = <50000000>;
>  	bus-width = <8>;
>  	cap-mmc-highspeed;
>  	mmc-ddr-1_8v;
> @@ -220,6 +222,8 @@ &mmc0 {
>  
>  &mmc1 {
>  	max-frequency = <100000000>;
> +	assigned-clocks = <&syscrg JH7110_SYSCLK_SDIO1_SDCARD>;
> +	assigned-clock-rates = <50000000>;
>  	bus-width = <4>;
>  	no-sdio;
>  	no-mmc;
> -- 
> 2.43.0
> 
> 

Now queued up, thanks.

greg k-h

