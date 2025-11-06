Return-Path: <stable+bounces-192589-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0ACC3A056
	for <lists+stable@lfdr.de>; Thu, 06 Nov 2025 11:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 479754FD356
	for <lists+stable@lfdr.de>; Thu,  6 Nov 2025 10:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E13530CDBF;
	Thu,  6 Nov 2025 10:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YRXqBhMk"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F4130C639
	for <stable@vger.kernel.org>; Thu,  6 Nov 2025 10:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762423237; cv=none; b=SDpo7e21WKY9jSVl4aCvx+BCewSTx35VHKkGjOlm/ElTmDQEDvGz3zbecP4BL5EUl1LJkf3kdPmp2atZFQRmh6V9zB2O1AbdeD8Cdv4OSOiAr7opXLa8PzSpfXb3ELXW72uyI2bOb2sY6FaNA/oSlZ7Dmzy7hupELdWYgb8kQVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762423237; c=relaxed/simple;
	bh=I4H5qHab6Aj0C5LwJMaHRiYnjpVzkseYs1jdsdGDz1Y=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qs+eJAEPQ2WQEILwrbLXGgQswvDfwYF9hLcGIDjCRQnUUvCTYqSmRr3u4FUWfP0py6ux15OzpbE0NSXQdJ/N/T3np/zCUn/VH3Q21uyzQOkeY4pM+ETR4fVQw6Ob4BjOna2wcqXt69CaVmHk1tizT2EKZq3AFST5hNMjUNRACf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YRXqBhMk; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-477549b3082so6667945e9.0
        for <stable@vger.kernel.org>; Thu, 06 Nov 2025 02:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762423233; x=1763028033; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hotEei7lwkfLoPtTcXzDgl2xx83T+2l/lt8Evo2copA=;
        b=YRXqBhMkOQZ8MSYcTZP/RasE+JNe2wuuwWQGUSbFZpl2TdFcnFda8HdJ0Htrr+zxnI
         YGYjbD/bQWd5we/rwedzxS50IZ364NDCvqjMzpeLpe3sBgBei7sNfJZIIob0XUTHYbls
         RnKRHwAF+VM/YdIGqHFJkc5QErHxYAZbpgeUfiKxP5WcOQD4JDN246sF0Sjjcdpx3HC3
         9oQmkfsVwzfnemIGaiI36yTB48PLo2MrMGl1DuMIZnPZ3GQ+2VGCnmGJQLAEuC9Yx8lY
         PzZSSl9ONQMGIrKN6hLo3ErbDQ38gYiu0hd1X9i40uNxEH0DdYmZGVKRr/bRIa++JbBS
         1qUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762423233; x=1763028033;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hotEei7lwkfLoPtTcXzDgl2xx83T+2l/lt8Evo2copA=;
        b=ZVKlf8aNZSwzX92rIYPlbnQ6zeO74DGJQ0It169OdDUYvyedR7nKPLRlPL4C2ytrYq
         11vTGPrdnIu/J782rDxg+7LWySMX78CMzY4JhlV8THORObsmjufq9D9AMPp0n4COdWdI
         /EVZEZy0irHaNUktEpOVWqt5JDDw05/PM3ntuKlY5hUmS6AQfIPjgLJKgnD7KD8cvKmo
         MNl5jRRTiFs+GBH165x9lZ7LApsRMKJ0ZVVOCWes8VGav9tNbw9tD5pUCmGiBHq3vIpz
         2lidNYNR0W0MBkqRIRlce7th12CYnVjM41THKi4vAX10lbO09ORjoi8YWmHyDU2lbAOl
         o4cg==
X-Forwarded-Encrypted: i=1; AJvYcCXNWcMl2UR2PR9opyw00SnqdMBrp8gcY8KdAFTyvYXkge6AlRzA9T1e9z+nupb5YYKGoHi+zyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKMZTTMSZqvTr+Unx2A9rZHVNa0IO+nY626T0u8JPPJl2hRJO/
	PC7+O037F9QmZP18Hvn+4YcieWA/yO/Pd2HFd/h8iwEdMj2dTK4fbl4uwPGCfP1NzyE=
X-Gm-Gg: ASbGncuXIzDNw9ZuIvjpD30bzB7aokIXgwmlBoGYmgLq1f/J91eZrb6iGfc/qMyUyEA
	bfmXI+5oeDeNT18Ai9c7QwLzPVSRj/mrFFQsjR13JW0KsvHMVo5qNAX2XlfKnBB5sCz6sC473Xr
	LlSdZQ0HSW09yuiugDbo69NKJrjbowzRXos32cN0MjySPYBsQdZ1qXm98OFv4g3DCB33cDiU7Lf
	pqPop8ENosQGH7wuaN9QHBWC2HL0jjPFPrapE4ZMwi8g+L9+NAjTNx4/PAPIr/YyuqQMc+hYAuU
	e7CalulU0C7TzTA5VzObWppxyWJomkZ9EplvWv8oLyhHAWTXY3NFYI8yu6+/apQ9iX1yuC3NvMs
	o23ZOz5mlWjxO+f1CoyX4zq6TvukA4Kh0P3wIISM0xP8tuNIy1FrqKwrxgNsCbd66drAu7EMnBu
	avgdaQtoTocOCrd1kmfAesN+z5keVWNb1Bxg==
X-Google-Smtp-Source: AGHT+IG+IVP2okOyZfO9efTEqK5kYK+g6r3W0Uym8vBYAKG016/w0MJyIa7e2e068PJnJ764TdjQ4Q==
X-Received: by 2002:a05:600c:621a:b0:471:14f5:126f with SMTP id 5b1f17b1804b1-4775ce206f3mr49954515e9.33.1762423233373;
        Thu, 06 Nov 2025 02:00:33 -0800 (PST)
Received: from [192.168.27.65] (home.rastines.starnux.net. [82.64.67.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477625e88fasm45340025e9.15.2025.11.06.02.00.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 02:00:32 -0800 (PST)
Message-ID: <1c31a5ef-39f6-460b-8046-3c7b2627e3ba@linaro.org>
Date: Thu, 6 Nov 2025 11:00:29 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH RESEND 3/3] PCI: meson: Fix parsing the DBI register
 region
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Hanjie Lin <hanjie.lin@amlogic.com>,
 Yue Wang <yue.wang@amlogic.com>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Andrew Murray <amurray@thegoodpenguin.co.uk>,
 Jingoo Han <jingoohan1@gmail.com>,
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, stable@vger.kernel.org,
 Linnaea Lavia <linnaea-von-lavia@live.com>
References: <20251101-pci-meson-fix-v1-0-c50dcc56ed6a@oss.qualcomm.com>
 <20251101-pci-meson-fix-v1-3-c50dcc56ed6a@oss.qualcomm.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20251101-pci-meson-fix-v1-3-c50dcc56ed6a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 11/1/25 05:29, Manivannan Sadhasivam wrote:
> First of all, the driver was parsing the 'dbi' register region as 'elbi'.
> This was due to DT mistakenly passing 'dbi' as 'elbi'. Since the DT is
> now fixed to supply 'dbi' region, this driver can rely on the DWC core
> driver to parse and map it.
> 
> However, to support the old DTs, if the 'elbi' region is found in DT, parse
> and map the region as both 'dw_pcie::elbi_base' as 'dw_pcie::dbi_base'.
> This will allow the driver to work with both broken and fixed DTs.
> 
> Also, skip parsing the 'elbi' region in DWC core if 'pci->elbi_base' was
> already populated.
> 
> Cc: <stable@vger.kernel.org> # 6.2
> Reported-by: Linnaea Lavia <linnaea-von-lavia@live.com>
> Closes: https://lore.kernel.org/linux-pci/DM4PR05MB102707B8CDF84D776C39F22F2C7F0A@DM4PR05MB10270.namprd05.prod.outlook.com/
> Fixes: 9c0ef6d34fdb ("PCI: amlogic: Add the Amlogic Meson PCIe controller driver")
> Fixes: c96992a24bec ("PCI: dwc: Add support for ELBI resource mapping")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>   drivers/pci/controller/dwc/pci-meson.c       | 18 +++++++++++++++---
>   drivers/pci/controller/dwc/pcie-designware.c | 12 +++++++-----
>   2 files changed, 22 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
> index 787469d1b396d4c7b3e28edfe276b7b997fb8aee..54b6a4196f1767a3c14c6c901bfee3505588134c 100644
> --- a/drivers/pci/controller/dwc/pci-meson.c
> +++ b/drivers/pci/controller/dwc/pci-meson.c
> @@ -108,10 +108,22 @@ static int meson_pcie_get_mems(struct platform_device *pdev,
>   			       struct meson_pcie *mp)
>   {
>   	struct dw_pcie *pci = &mp->pci;
> +	struct resource *res;
>   
> -	pci->dbi_base = devm_platform_ioremap_resource_byname(pdev, "elbi");
> -	if (IS_ERR(pci->dbi_base))
> -		return PTR_ERR(pci->dbi_base);
> +	/*
> +	 * For the broken DTs that supply 'dbi' as 'elbi', parse the 'elbi'
> +	 * region and assign it to both 'pci->elbi_base' and 'pci->dbi_space' so
> +	 * that the DWC core can skip parsing both regions.
> +	 */
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "elbi");
> +	if (res) {
> +		pci->elbi_base = devm_pci_remap_cfg_resource(pci->dev, res);
> +		if (IS_ERR(pci->elbi_base))
> +			return PTR_ERR(pci->elbi_base);
> +
> +		pci->dbi_base = pci->elbi_base;
> +		pci->dbi_phys_addr = res->start;
> +	}
>   
>   	mp->cfg_base = devm_platform_ioremap_resource_byname(pdev, "cfg");
>   	if (IS_ERR(mp->cfg_base))
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index c644216995f69cbf065e61a0392bf1e5e32cf56e..06eca858eb1b3c7a8a833df6616febcdbe854850 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -168,11 +168,13 @@ int dw_pcie_get_resources(struct dw_pcie *pci)
>   	}
>   
>   	/* ELBI is an optional resource */
> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "elbi");
> -	if (res) {
> -		pci->elbi_base = devm_ioremap_resource(pci->dev, res);
> -		if (IS_ERR(pci->elbi_base))
> -			return PTR_ERR(pci->elbi_base);
> +	if (!pci->elbi_base) {
> +		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "elbi");
> +		if (res) {
> +			pci->elbi_base = devm_ioremap_resource(pci->dev, res);
> +			if (IS_ERR(pci->elbi_base))
> +				return PTR_ERR(pci->elbi_base);
> +		}
>   	}
>   
>   	/* LLDD is supposed to manually switch the clocks and resets state */
> 

Tested with "old" and "new" DT worked fine with both:

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on Bananapi-M2S

Thanks,
Neil

