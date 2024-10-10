Return-Path: <stable+bounces-83384-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F16998E5D
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 19:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 084071F259B7
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 17:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F4919CCF4;
	Thu, 10 Oct 2024 17:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0KeYF6j"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E5D18950A;
	Thu, 10 Oct 2024 17:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728581546; cv=none; b=D4dRXaJBK/mA18mHFD2ZTajOOFFrFAwFRvxhz0Dxp+shSGz1xZ0E4YUnE1QuqKC5TyAQ9tBdCmKffX96bwj2Z5ZsldnJ4XLGYblpULTxSD7R5VuoPOMhJyiKSWJDNWz7Q/ZvSILWgUsw8nTywITwzf5b+VQhLoBORbOhSQvG+QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728581546; c=relaxed/simple;
	bh=SmRFvrAoUmt6qHVrIVPp4aWb6oj16rrPfPziLvDQL9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OIs85qiIU77fQYQoY+rQCqtd881YoiWKuiiKfmTjErrbJCHO+vvku4rrNYPQkLVMvblykc2RCLiTB7Q5UQkeMcfoIRArPb0uQVryh8C5FxGpjK7DdjRr2TYEP0mXzHwxMOhrtm1JHSus3+ZExrA19/Ft76esopolsucRxYEO1jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z0KeYF6j; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6cbe700dcc3so7639246d6.3;
        Thu, 10 Oct 2024 10:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728581544; x=1729186344; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0nMlLvviJmPYv2MjcZTCv3Irnh3bCL8aaXvUPWjA1g=;
        b=Z0KeYF6jx7nK52MIwJpxME3PDqWldXNWT83fcisJxB9ci+tHf46WBGKk616cocpaLw
         8eC+0f9x2QT11TFuR167bS1bSZ0Ftd0F675y1nFeFZ4EmARNp2+YBpxk5EiJYp36EO3K
         E8Ycm1wZViH7aCoRhr5xmUT1yscJc+fQrMrU4Fgll79y2Y/u+ozFcAUMHvg7zcJQcrct
         prmDf3xZUTlQAPaVTeb58rfrN1e0+zXsCpTUKdhgEXdfxd2wN6z4u6N95nUfczl6/wKT
         sswSRC92K8g01czZf0JfDAq9QjQZQ52TgLvVQxoWrPX44qTcVcmHvgjEPALedK5/8Sbs
         3tfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728581544; x=1729186344;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l0nMlLvviJmPYv2MjcZTCv3Irnh3bCL8aaXvUPWjA1g=;
        b=XvCR4XpX3flF/02kzyNdyu+B26izT0tRiPu6Oiy50VgPfg9VKzqCIYVCAQh/N4AnQ7
         QFNmht38VXq4SW0K7SmDBE201yVSJhXfNgbOKv3xcR0QGc497Vj4jbCoouJKxsmI2Cq6
         CB4QRUIFOjgs4Vh+XgGV/EssuFRgRISf/lUn2jyss1FK69aCYHWycc/KaqAQQdeK1KqR
         SFdD80WO3kxiCQSJQoclY/yNS93ko9sM8FuRabnKsWb3jZCO/5yM7UKkAr/2O4PPl0dR
         6ErHxGS5gsyL78U4kppV8ne+F3V8Feyz03ad3t8sTw1+eOPNR18rSCC1votR0UQfidZP
         HD2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUZMY48g+KxRbrbUz5KD4sQGeoBCoFCrS1hMM8INfunx5oE+yEWQJMrGXBqyDDVjmX3sJi1k+8jkCqg@vger.kernel.org, AJvYcCUboDE2nIJvaYHYNKMuc6bMSCiYxnt5xZMds+1QcmGLh6zSWK7N1DZcOX53AR9ujSzZWB32Ix+q@vger.kernel.org, AJvYcCVFFRfh6D5Be73oCwO1T99qshG1tdzKIV0ABbzxb60kxZK/zbWlV3XjWbsGThHDxJpTPwUrfRQcHlV6nrjL@vger.kernel.org
X-Gm-Message-State: AOJu0YwAEBTHfBcB4nV3y4QtzeGVbvvgPtO9gFon3IIHttfQSIQfsQf2
	tuSFGywmvPFZsdnWjdbrYhEOOQpsvNuR+EruPwoQWazIyHG1OuFv
X-Google-Smtp-Source: AGHT+IFRlhEVbo3tzXbvvXuvHuYvVHINoj93prdPjLq37t+ElASZTNRAmEMoAEOgjndfOlphLPpM6A==
X-Received: by 2002:a05:6214:3a07:b0:6cb:e632:a059 with SMTP id 6a1803df08f44-6cbe632c1f4mr44223376d6.49.1728581544094;
        Thu, 10 Oct 2024 10:32:24 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbe862fe87sm7116246d6.106.2024.10.10.10.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 10:32:23 -0700 (PDT)
Date: Thu, 10 Oct 2024 13:32:21 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: linux-rockchip@lists.infradead.org, heiko@sntech.de,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Prevent thermal runaways in RK3308
 SoC dtsi
Message-ID: <20241010173154.GA32479@localhost>
References: <d3e9dc4201d38894b09f3198368428153a3af1a4.1728555461.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d3e9dc4201d38894b09f3198368428153a3af1a4.1728555461.git.dsimic@manjaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu 2024-10-10 @ 12:19:41 PM, Dragan Simic wrote:
> Until the TSADC, thermal zones, thermal trips and cooling maps are defined
> in the RK3308 SoC dtsi, none of the CPU OPPs except the slowest one may be
> enabled under any circumstances.  Allowing the DVFS to scale the CPU cores
> up without even just the critical CPU thermal trip in place can rather easily
> result in thermal runaways and damaged SoCs, which is bad.
> 
> Thus, leave only the lowest available CPU OPP enabled for now.
> 

It builds, it runs, it's been running on one of my rock-pi-s boards for ~3h
now. I can read my spi, i2c, and w1 sensors, so no issues for me.

# cat /sys/bus/cpu/devices/cpu*/cpufreq/stats/time_in_state
408000 1168942
408000 1168942
408000 1168942
408000 1168942

Tested-by: Trevor Woerner <twoerner@gmail.com>

> Fixes: 6913c45239fd ("arm64: dts: rockchip: Add core dts for RK3308 SOC")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
>  arch/arm64/boot/dts/rockchip/rk3308.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3308.dtsi b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
> index 31c25de2d689..a7698e1f6b9e 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3308.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
> @@ -120,16 +120,19 @@ opp-600000000 {
>  			opp-hz = /bits/ 64 <600000000>;
>  			opp-microvolt = <950000 950000 1340000>;
>  			clock-latency-ns = <40000>;
> +			status = "disabled";
>  		};
>  		opp-816000000 {
>  			opp-hz = /bits/ 64 <816000000>;
>  			opp-microvolt = <1025000 1025000 1340000>;
>  			clock-latency-ns = <40000>;
> +			status = "disabled";
>  		};
>  		opp-1008000000 {
>  			opp-hz = /bits/ 64 <1008000000>;
>  			opp-microvolt = <1125000 1125000 1340000>;
>  			clock-latency-ns = <40000>;
> +			status = "disabled";
>  		};
>  	};
>  
> 

