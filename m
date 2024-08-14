Return-Path: <stable+bounces-67674-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D06951EA8
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 17:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6D641C236AB
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 15:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AB11B5832;
	Wed, 14 Aug 2024 15:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="uO5HQsYx"
X-Original-To: stable@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7C21B581B;
	Wed, 14 Aug 2024 15:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723649744; cv=none; b=jIiKbA1otMKnegRRCoMKbJC/+sDCxGkExM24qY1XyOdZz+qohxlrgSohmNW2XO+/jmzLcdDXpCi1BeS3aZXyZM2P9i+zy9ApObSb4n0x+VygbtMENDY++KEyI5f6ZVJbGP9vaGEESN39ZwQsK0uzVI4eyQRvT5+qkgFjYMogcCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723649744; c=relaxed/simple;
	bh=vPBUNVJr13bzofQkt0i9RBxU35Rpem/WoHYbHGlADNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YDbc0FqFS8HJ0JXybV1UKpZkwl4VJGAiYZFf9sHATzIJFP3PIVtgXYwCDHYtswvsNKC1FbQ+rfG4nBeWOV5QwCyW4EtdDMiPzwvFfFJfBWqLvW01GDs/dofk2yDFWG0mE5NF0YkGY1303nCE2UFmA+PHOczml7Wdwv2hkYP1Vzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=uO5HQsYx; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47EFESJW004021;
	Wed, 14 Aug 2024 17:35:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	ApZSwU8z0je7+1pyLOxNF1U7pXARLkL16y03KzUYwFo=; b=uO5HQsYx1UPEPHzD
	opKbg7SzmkK6+vbEpcPZERG0XQZ9c4KNxU1GctnCdDyc8zKtwWJ+VC78O4XJ0ey/
	DIlZLTGosNnn61Ltsm3FBdqRztVJP/yNQjx5xbGSTgmHg5GaGM/XpUnpwmgKmVZD
	gXfpQnZJ+03inMJmNVfqcO2fqqYo/NKdhUaGHi1+hZEZXjr17GoUxT3BtT8QELxg
	2O8XXZXe45wnv2bbYnHNPzKAbYaYpwwZGUpw7H3okIzSnbVs7F71LKDoYfhgehsD
	Oa/wFBqXuDARCVkktcSc9i6rqXQe4K2zsoWEbkRqI+tb05rPnzYxy+XArxJqbwi6
	YzkN0g==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 410y24027w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 17:35:11 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id D462A40057;
	Wed, 14 Aug 2024 17:35:02 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1B17827D10D;
	Wed, 14 Aug 2024 17:34:21 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 14 Aug
 2024 17:34:20 +0200
Message-ID: <501b7fcb-5476-4418-96a6-0b03d69b0a8f@foss.st.com>
Date: Wed, 14 Aug 2024 17:34:19 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] usb: dwc3: st: fix probed platform device ref count
 on probe error path
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thinh Nguyen
	<Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@ti.com>, Peter Griffin <peter.griffin@linaro.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Lee Jones <lee@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <stable@vger.kernel.org>
References: <20240814093957.37940-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20240814093957.37940-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-14_11,2024-08-13_02,2024-05-17_01



On 8/14/24 11:39, Krzysztof Kozlowski wrote:
> The probe function never performs any paltform device allocation, thus

Hi Krzysztof

s/paltform/platform

> error path "undo_platform_dev_alloc" is entirely bogus.  It drops the
> reference count from the platform device being probed.  If error path is
> triggered, this will lead to unbalanced device reference counts and
> premature release of device resources, thus possible use-after-free when
> releasing remaining devm-managed resources.
> 
> Fixes: f83fca0707c6 ("usb: dwc3: add ST dwc3 glue layer to manage dwc3 HC")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/usb/dwc3/dwc3-st.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-st.c b/drivers/usb/dwc3/dwc3-st.c
> index 211360eee95a..a9cb04043f08 100644
> --- a/drivers/usb/dwc3/dwc3-st.c
> +++ b/drivers/usb/dwc3/dwc3-st.c
> @@ -219,10 +219,8 @@ static int st_dwc3_probe(struct platform_device *pdev)
>  	dwc3_data->regmap = regmap;
>  
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "syscfg-reg");
> -	if (!res) {
> -		ret = -ENXIO;
> -		goto undo_platform_dev_alloc;
> -	}
> +	if (!res)
> +		return -ENXIO;
>  
>  	dwc3_data->syscfg_reg_off = res->start;
>  
> @@ -233,8 +231,7 @@ static int st_dwc3_probe(struct platform_device *pdev)
>  		devm_reset_control_get_exclusive(dev, "powerdown");
>  	if (IS_ERR(dwc3_data->rstc_pwrdn)) {
>  		dev_err(&pdev->dev, "could not get power controller\n");
> -		ret = PTR_ERR(dwc3_data->rstc_pwrdn);
> -		goto undo_platform_dev_alloc;
> +		return PTR_ERR(dwc3_data->rstc_pwrdn);
>  	}
>  
>  	/* Manage PowerDown */
> @@ -300,8 +297,6 @@ static int st_dwc3_probe(struct platform_device *pdev)
>  	reset_control_assert(dwc3_data->rstc_rst);
>  undo_powerdown:
>  	reset_control_assert(dwc3_data->rstc_pwrdn);
> -undo_platform_dev_alloc:
> -	platform_device_put(pdev);
>  	return ret;
>  }
>  

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice

