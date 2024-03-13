Return-Path: <stable+bounces-28071-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD04987B05F
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 19:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED16A1C23485
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 18:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E0D81ADB;
	Wed, 13 Mar 2024 17:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vzLKCXR9"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD06413A877
	for <stable@vger.kernel.org>; Wed, 13 Mar 2024 17:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710352126; cv=none; b=GAfdjL2Q3lzyWsl5qE8YqW7jCpLsPV60tT2htB97NjcOhDv44Qtci88lZYi+xiwlwciIr3Dcy9XOp31KpT6zUJlYiW8gHuCOANQKMO30E8CBIYE8zw/QMZ8kU5UknlEA3/ILB1ibbhFTfE94Wf0AtZ/Zr3ZAOa1/ej4UZaoF/t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710352126; c=relaxed/simple;
	bh=9GtmUPcx1cxxZ/dcwLKu3JzLV3bpa7tnF+eo93QPb5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S2SwpI6/bxP/xrUR5SMEPzj27wB9UrTep2Ls7YFYQPtQld9oUi8F6h5yGgVgE0AnhlM27DvBm3ULeuBkpK3nAbZtAMP6IynyIHAWZKmSv55sj3sOiYfRdhcs5EjMv5Ys+/z3/M6/HQ6nWCLgHBFzYB3PplQHQOgM3tI81UXn7Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vzLKCXR9; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dd97fd66cdso719555ad.1
        for <stable@vger.kernel.org>; Wed, 13 Mar 2024 10:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710352124; x=1710956924; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R8LTBs7j3NPB0OsjLuDAwxjZmk3c2A5WFBTqJZAD8yE=;
        b=vzLKCXR9v860PfC4jQBIy4mNlgHWiWXF6BqoZafDNG/tRwFe10Zvy2IZ7uJB0I6/bL
         rG2cqWyZhvAEUYLhOLZRQqB3SbNyzLMAy+J/haNOvA7v/ZROij1ITg1zxykUg23EFdxD
         /4HG3DV5tO3dKGIpNy3tp5Fcrpd364LzwsjE4qWGoUXNOOwmJ4xb7ccv+Ri4rdslqJik
         jKmbRwB+bkqblYj1ILqIFZ0rpCkQvDEs6MoYWS0viPASS4Jg6j9xHZFvEpzKk0/I+bdl
         yUkSBxw/p8sLCJxrL1Zpf4dnFPC0nA4s941v9IrCOJqvfA6N8dYyYxeOLJBJQN/WUtWH
         9kGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710352124; x=1710956924;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R8LTBs7j3NPB0OsjLuDAwxjZmk3c2A5WFBTqJZAD8yE=;
        b=g/H7TuI/E2ScKOXOD1CyGqBMIPhrQdkByL0kUpFK+DE1mvJHsoqlnTHOAYiBve1MTd
         eWWUkAwPHbvNLaYBkgjx4C0U02lltez/G6qzqeucP0HtZKRo8fBbgssXO/glLvgFpx98
         l7Gumpymei5W5XCawgnXIdVsj5vtVVl5nKLUOSmUwQWwzei/qoaUs99jgP5uoH7Kwrqy
         L8f76RpCyPhrZQjjP4HKYa7FlrK/jOAhDcqPgLXWsL/ZMe13SV+lvRMklzN/umyDPMN3
         s+80bdcdpNKQb3lvx3ZVNgGE4FYwc+GBNCUHNZFjM0RALRrJvFR4nNXhbGi/nWJjHQHp
         TBNg==
X-Forwarded-Encrypted: i=1; AJvYcCUeHG2ytvLo0MzLx9RpQK4ri4f5Vi74Kwoyqqj2SKz8nY/SolIfUG2NbcHiAnnPqB3GRPAv1YMLWLMXn4DlbVLf4fdNUsyC
X-Gm-Message-State: AOJu0Yz2wdxoUVSNGNk/9FBKWnEhnvzeR0d+am2Rgpva37Iyv5W4ypUj
	qCnnCQZnRj735ugKbpVqpVZlArkmqOsWsiZaf4BmKusibv40R36yZWJcWw508lo=
X-Google-Smtp-Source: AGHT+IHeEq7az6+TrjkJquo9xYbWPGtoacza46mVBEKLDXRW7Ew3Amiazbn+mHOAIJGh5SRkzAzTiA==
X-Received: by 2002:a17:903:442:b0:1dd:1c6f:aec6 with SMTP id iw2-20020a170903044200b001dd1c6faec6mr10133655plb.46.1710352124196;
        Wed, 13 Mar 2024 10:48:44 -0700 (PDT)
Received: from [0.0.0.0] ([103.88.46.247])
        by smtp.gmail.com with ESMTPSA id t8-20020a170902e84800b001c407fac227sm8910885plg.41.2024.03.13.10.48.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 10:48:43 -0700 (PDT)
Message-ID: <77f1c6a6-7756-4168-a69d-583a35abd8ab@linaro.org>
Date: Thu, 14 Mar 2024 01:48:36 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 015/267] arm64: dts: qcom: sdm845: fix USB wakeup
 interrupt types
Content-Language: en-US
To: Johan Hovold <johan+linaro@kernel.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, Bjorn Andersson <andersson@kernel.org>,
 amit.pundir@linaro.org, sumit.semwal@linaro.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240221125940.058369148@linuxfoundation.org>
 <20240221125940.531673812@linuxfoundation.org>
From: Yongqin Liu <yongqin.liu@linaro.org>
Autocrypt: addr=yongqin.liu@linaro.org; keydata=
 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
 ldR5r/oaSetp
In-Reply-To: <20240221125940.531673812@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi, Johan

On 2024/2/21 21:05, Greg Kroah-Hartman wrote:
> 5.4-stable review patch.  If anyone has any objections, please let me know.
>
> ------------------
>
> From: Johan Hovold <johan+linaro@kernel.org>
>
> commit 84ad9ac8d9ca29033d589e79a991866b38e23b85 upstream.
>
> The DP/DM wakeup interrupts are edge triggered and which edge to trigger
> on depends on use-case and whether a Low speed or Full/High speed device
> is connected.
>
> Fixes: ca4db2b538a1 ("arm64: dts: qcom: sdm845: Add USB-related nodes")
> Cc: stable@vger.kernel.org      # 4.20
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> Link: https://lore.kernel.org/r/20231120164331.8116-9-johan+linaro@kernel.org
> Signed-off-by: Bjorn Andersson <andersson@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>   arch/arm64/boot/dts/qcom/sdm845.dtsi |    8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -2503,8 +2503,8 @@
>   
>   			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
>   				     <GIC_SPI 486 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 488 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 489 IRQ_TYPE_LEVEL_HIGH>;
> +				     <GIC_SPI 488 IRQ_TYPE_EDGE_BOTH>,
> +				     <GIC_SPI 489 IRQ_TYPE_EDGE_BOTH>;
>   			interrupt-names = "hs_phy_irq", "ss_phy_irq",
>   					  "dm_hs_phy_irq", "dp_hs_phy_irq";
>   
> @@ -2547,8 +2547,8 @@
>   
>   			interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
>   				     <GIC_SPI 487 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 490 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 491 IRQ_TYPE_LEVEL_HIGH>;
> +				     <GIC_SPI 490 IRQ_TYPE_EDGE_BOTH>,
> +				     <GIC_SPI 491 IRQ_TYPE_EDGE_BOTH>;
>   			interrupt-names = "hs_phy_irq", "ss_phy_irq",
>   					  "dm_hs_phy_irq", "dp_hs_phy_irq";
>   
>
This patch only causes the db845c Android builds to fail to have the adb 
connection setup after boot.
In the serial console, the following lines are printed:
   [    0.779242][   T79] genirq: Setting trigger mode 3 for irq 33 
failed (__typeid__ZTSFiP8irq_datajE_global_addr+0x14/0x58)
   [    0.779411][   T79] dwc3-qcom a6f8800.usb: dp_hs_phy_irq failed: -22
   [    0.779418][   T79] dwc3-qcom a6f8800.usb: failed to setup IRQs, 
err=-22
   [    0.779652][  T154] irq/30-qcom_dwc (154) used greatest stack 
depth: 14464 bytes left
   [    0.779661][   T79] dwc3-qcom: probe of a6f8800.usb failed with 
error -22
   [    0.779997][    T1] init: Loaded kernel module /lib/modules/smem.ko
   [    0.780144][    T1] init: Loading module 
/lib/modules/qcom_glink_native.ko with args ''
   [    0.782619][   T79] genirq: Setting trigger mode 3 for irq 37 
failed (__typeid__ZTSFiP8irq_datajE_global_addr+0x14/0x58)
   [    0.782672][   T79] dwc3-qcom a8f8800.usb: dp_hs_phy_irq failed: -22
   [    0.782679][   T79] dwc3-qcom a8f8800.usb: failed to setup IRQs, 
err=-22
   [    0.782864][   T79] dwc3-qcom: probe of a8f8800.usb failed with 
error -22

After some investigation, it's found it will work again if the following 
two patches are applied:
   72b67ebf9d24 ("arm64: dts: qcom: add PDC interrupt controller for 
SDM845")
   204f9ed4bad6 ("arm64: dts: qcom: sdm845: fix USB DP/DM HS PHY 
interrupts")

Could you please help to have a check and give some suggestions on what 
patches

should be back ported to the 5.4 kernel, or are the above two patches 
only good enough?


Thanks,

Yongqin Liu

---------------------------------------------------------------
#mailing list
linaro-android@lists.linaro.org <mailto:linaro-android@lists.linaro.org>
http://lists.linaro.org/mailman/listinfo/linaro-android 
<http://lists.linaro.org/mailman/listinfo/linaro-android>


