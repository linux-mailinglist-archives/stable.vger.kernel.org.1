Return-Path: <stable+bounces-76212-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B392497A062
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 13:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F214281812
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 11:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF73155336;
	Mon, 16 Sep 2024 11:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zfJvf2mg"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F7B154423
	for <stable@vger.kernel.org>; Mon, 16 Sep 2024 11:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726486589; cv=none; b=HB8i4LiFWOmzA2KySNMvIsdtL5ViElHx1UGSIolUvMyAk8x73/yvC5VlqpvdMTOgGtAEYRTzHXY2NssXUl7gigiSpap1GEKGFCiC1Ry0ekKGmkhbW379/ZqNcW7CiLj3eQiuEmZ8pmRtJ9lAahiifXwv8dGgG+vwFd0Tl36i5AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726486589; c=relaxed/simple;
	bh=XRSeRuCMJTvS754GsDtnh9XudwOOqWtoAC0SK8U7n6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cvCoBzT1XIHT/4Lp2qpKgQ7bg1jP/b5QDLMs0mettvq0NatfPh8xGqJoX3qRDmNNkAO8jRpoP8waJsdbWjDO2CcL2rm46Vss7Lp+KW7MZWv6DDhaBH+5gymgQ4kiQQ/5dZx8rYqXkL8FglbbK1GCUBdGhnHGYCuTHHDum2qtbno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zfJvf2mg; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a8d2daa2262so406831666b.1
        for <stable@vger.kernel.org>; Mon, 16 Sep 2024 04:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726486586; x=1727091386; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g2kD63xCEnK7LpZGmhTprbOnZCv6t5U7PfEhkSoqT9E=;
        b=zfJvf2mghuvqyjDZ1Bo5Te69dEsyNZMdikHMqBD/hiZiWixODhi/PeaM3ZE1wQ2Mgr
         x4czCd8m/Fn6lK01OwYhjaCAGmE9IXzPYBesLBQROdJg610MgilNEdnM8Pr7i5wIauH5
         xlaI7miDKtixm4K0b1keOMvzIxmz+Ij0NmWza4wSRRXb9X7d5K6UFajGWlUFej9ihgxJ
         47UuugnUpxsz3u11ix4g+qJzlhIf5EgoOLJMg6dtmJmSaw5CSoPSFAYsqcwHycshdLZL
         JlN4Bc3IRfq2DjmEcBgMxEJI5vMSi1laWQlMtONNxFMaIPjfkp9//QFBO0pENw4JqI9L
         aSKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726486586; x=1727091386;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2kD63xCEnK7LpZGmhTprbOnZCv6t5U7PfEhkSoqT9E=;
        b=dFT1tPx45M5vR4g3uMbfb0w5+dEWjXI8hTPQxVtl9jeEf/8oQ66kA3GOsH2+hdlXUn
         mqiYpfBx0wNN/C+3a1i5fkmT3v4Frw14ffdrGNPbELQGys+H5T+N4DVXUQjGlZnd5H5l
         udAGfiYwthU4Yk3i6687mnkcj1l3Mwli5Fg6qXNYRvsHWIBmWFO4NkuHvqvGu5z1+AAM
         Gvp/SnzQQ388yTf8HeOdW639DiOVc8RsunoidWVsLyomMBndhJR1wfdIJV2elog51/Vn
         psHANjYJUQW2BqSphwqy1gvSN5fSTqP0mGHfp8WLL7mk8uYcNDClhCpJ28NYmmxs9HVe
         RGbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVX1teOes3+SPZJF9knVnejA5OSCid87ixEB0gkxr3DZqSAcUhcK7NzFxgm62q+6wdLAlUnYXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkVha5gHxf7X7GvuuF/0ZyY0lrqcYvjeri0PKe9jVSGsHTD2TJ
	kjtdZRTSALUlQDnxiUMsPvafS+PZ+N+uqZt8T7iU2mg5L1O65sPevb1BRHM6zrU=
X-Google-Smtp-Source: AGHT+IE4iVNH/Yi3C6l6RnP78Zl1rdiKCTKo5dcFalxIAXD2Y4EUCMepAYttsrZ1Iej8+4iKxR3rHQ==
X-Received: by 2002:a17:907:2d87:b0:a8d:7046:a1bd with SMTP id a640c23a62f3a-a9047d03d80mr979448166b.28.1726486585422;
        Mon, 16 Sep 2024 04:36:25 -0700 (PDT)
Received: from linaro.org ([62.231.96.65])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610f386dsm302049466b.49.2024.09.16.04.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 04:36:24 -0700 (PDT)
Date: Mon, 16 Sep 2024 14:36:23 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	Sibi Sankar <quic_sibis@quicinc.com>, linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: dts: qcom: x1e80100: fix PCIe4 and PCIe6a PHY
 clocks
Message-ID: <ZugYN0L/dj0iJxaH@linaro.org>
References: <20240916082307.29393-1-johan+linaro@kernel.org>
 <20240916082307.29393-3-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916082307.29393-3-johan+linaro@kernel.org>

On 24-09-16 10:23:06, Johan Hovold wrote:
> Add the missing clkref enable and pipediv2 clocks to the PCIe4 and
> PCIe6a PHYs.
> 
> Fixes: 5eb83fc10289 ("arm64: dts: qcom: x1e80100: Add PCIe nodes")
> Cc: stable@vger.kernel.org	# 6.9
> Cc: Abel Vesa <abel.vesa@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> ---
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> index 0cf4f3c12428..53e7d1e603cb 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> @@ -2980,14 +2980,16 @@ pcie6a_phy: phy@1bfc000 {
>  
>  			clocks = <&gcc GCC_PCIE_6A_PHY_AUX_CLK>,
>  				 <&gcc GCC_PCIE_6A_CFG_AHB_CLK>,
> -				 <&rpmhcc RPMH_CXO_CLK>,
> +				 <&tcsr TCSR_PCIE_4L_CLKREF_EN>,
>  				 <&gcc GCC_PCIE_6A_PHY_RCHNG_CLK>,
> -				 <&gcc GCC_PCIE_6A_PIPE_CLK>;
> +				 <&gcc GCC_PCIE_6A_PIPE_CLK>,
> +				 <&gcc GCC_PCIE_6A_PIPEDIV2_CLK>;
>  			clock-names = "aux",
>  				      "cfg_ahb",
>  				      "ref",
>  				      "rchng",
> -				      "pipe";
> +				      "pipe",
> +				      "pipediv2";
>  
>  			resets = <&gcc GCC_PCIE_6A_PHY_BCR>,
>  				 <&gcc GCC_PCIE_6A_NOCSR_COM_PHY_BCR>;
> @@ -3232,14 +3234,16 @@ pcie4_phy: phy@1c0e000 {
>  
>  			clocks = <&gcc GCC_PCIE_4_AUX_CLK>,
>  				 <&gcc GCC_PCIE_4_CFG_AHB_CLK>,
> -				 <&rpmhcc RPMH_CXO_CLK>,
> +				 <&tcsr TCSR_PCIE_2L_4_CLKREF_EN>,
>  				 <&gcc GCC_PCIE_4_PHY_RCHNG_CLK>,
> -				 <&gcc GCC_PCIE_4_PIPE_CLK>;
> +				 <&gcc GCC_PCIE_4_PIPE_CLK>,
> +				 <&gcc GCC_PCIE_4_PIPEDIV2_CLK>;
>  			clock-names = "aux",
>  				      "cfg_ahb",
>  				      "ref",
>  				      "rchng",
> -				      "pipe";
> +				      "pipe",
> +				      "pipediv2";
>  
>  			resets = <&gcc GCC_PCIE_4_PHY_BCR>;
>  			reset-names = "phy";
> -- 
> 2.44.2
> 

