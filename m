Return-Path: <stable+bounces-91810-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3039C05C6
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 13:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0F7F284450
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 12:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E089D20F5A1;
	Thu,  7 Nov 2024 12:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qd7q8zc6"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD6620371D
	for <stable@vger.kernel.org>; Thu,  7 Nov 2024 12:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730982455; cv=none; b=kBI3rQpm88ViBdBK7eHjwYUl3d2oUuHYkAX94cuRz8zvLa3oXKNjP+mxUOqkgVorbFfDKEoYiR/Ukpky+8aEcflfEI0THgjG7YBUu5kGso9c2b0OmaxWsmBWnSRtHJZNDXnLoqup4irPk/9iPIToqVQrnWZ3pZKFD5POqeLNRPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730982455; c=relaxed/simple;
	bh=7fW7Or4bv3LMfGfA2w7Yy7Fn1KUAaH8JSTS4G9X+14g=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=uGmgsD2r4ulwtVOR0p+wX15IevAh3458hBPnUDz92z9oBLZHIZRTndoqTEg2V/DFy6cg+vqNqEh3P0odRkM11VPV+Zj4kNbn8U4i0IzUon4mwwuzKUGIKrRSka5pmW9c6aoXGNdIYCBELe2wMj0eF+Qr/fYoOri5uwmXSplmCuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qd7q8zc6; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4316e9f4a40so7426035e9.2
        for <stable@vger.kernel.org>; Thu, 07 Nov 2024 04:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730982452; x=1731587252; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yn4k/AKEEWXzHMELIUTj4UPwDIVmAaYKV7woWIMbon4=;
        b=Qd7q8zc6dcKrmbRpiJ884Zyp0HqueDdhBZoA1CtjVSY1fvW5gaSirxyCguGq+ObETV
         tqQzLSu2tZ3aruV7vz+5uHQW7xpkmtYs5V0VElDYtYq/XLLePBtVnDM4TkhZjly5EIq6
         7ZIT/2/A2l7+BsBX/V3e7vx1yo2Cmt0wOsi/iVympCTzYvtgdC4+NokVDcilZAfUN2OP
         p2m1r8tS2kFPKd5tdg2N+laj6fKeVkdPkeXdS4g/XFAoQbb3CP0lEAITQrhfDUeYEkRR
         s9VlOAPfQpINvr4tbLwz6ZIbVrtlEVPy5B+riQh3YNluNO1I8Gmpgj18ocXWcb7O4RTL
         ynEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730982452; x=1731587252;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Yn4k/AKEEWXzHMELIUTj4UPwDIVmAaYKV7woWIMbon4=;
        b=Ej3eEh8tCWV+A4IixXLibUjPXIB7ixpZ3zfSuc7Ajy/PfwrfgLPvay9wLhMnn6Cxud
         eIkGJkd7Si1qHHnhA2cHXL7kLsfRfGjLT0RKvqFW2uazdvVaKmhkkS9MGeUEVwgU2cAU
         Unwt9zRhOX5Asdq/rwqXc47P59XHPJmKPND4McyqSAeQ2V1gsl51qKi67Nh+3MKZdq8f
         3VFry+Ke/xnro7KfL7xwee9LprAAskiMKztqIZoHVjevQ8hncxsdxmlv9qBj1yAIqQcQ
         PiqLljKsmi1dbnFWzdwD6eHiNeH7t7PSCKk8T5a7fWTuhUEwS+zPwCbPj28fEQ9CytUB
         KoAw==
X-Forwarded-Encrypted: i=1; AJvYcCUgLhmeNAeem3qK8SS+R9v+W3lTfZK2fGc00Ouw7TVDpMyr42IQYp/kodCyYQHXkAO2ZC3lCsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYJRBSCNe63aYBIh76wLL4LwMZpuvpOVrkmuNtb7WCernMYfSY
	74SDXh/0uxWaIOSuNgAb3w15BUPde9Olp2HYMhzKz9Qe7ESbFP44VFFVL49ckTE=
X-Google-Smtp-Source: AGHT+IEKl+yBhKl9P9rAWF3Zv0iPAWAueK1s6Y0V7M3SqQDjTXl7EEXZlWLjrPZCLIWLZ6AL8CGk/w==
X-Received: by 2002:a5d:49c2:0:b0:37d:39c1:4d3 with SMTP id ffacd0b85a97d-380610f2ea6mr32205866f8f.6.1730982452121;
        Thu, 07 Nov 2024 04:27:32 -0800 (PST)
Received: from [172.16.23.252] ([89.101.134.25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa6b3611sm58072005e9.13.2024.11.07.04.27.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 04:27:31 -0800 (PST)
Message-ID: <3c0b7fb7-5e51-4b7b-bc48-3034470dcb0f@linaro.org>
Date: Thu, 7 Nov 2024 13:27:30 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/2] clk: qcom: gcc-sm8650: Keep UFS PHY GDSCs ALWAYS_ON
To: manivannan.sadhasivam@linaro.org, Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, Amit Pundir <amit.pundir@linaro.org>,
 Nitin Rawat <quic_nitirawa@quicinc.com>, stable@vger.kernel.org
References: <20241107-ufs-clk-fix-v1-0-6032ff22a052@linaro.org>
 <20241107-ufs-clk-fix-v1-2-6032ff22a052@linaro.org>
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
In-Reply-To: <20241107-ufs-clk-fix-v1-2-6032ff22a052@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/11/2024 12:58, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> In SM8650, UFS PHY GDSCs doesn't support hardware retention. So using
> RETAIN_FF_ENABLE is wrong. Moreover, without ALWAYS_ON flag, GDSCs will get
> powered down during suspend, causing the UFS PHY to loose its state. And
> this will lead to UFS error similar to below during resume:
> 
> ufshcd-qcom 1d84000.ufs: ufshcd_uic_hibern8_exit: hibern8 exit failed. ret = 5
> ufshcd-qcom 1d84000.ufs: __ufshcd_wl_resume: hibern8 exit failed 5
> ufs_device_wlun 0:0:0:49488: ufshcd_wl_resume failed: 5
> ufs_device_wlun 0:0:0:49488: PM: dpm_run_callback(): scsi_bus_resume+0x0/0x84 returns 5
> ufs_device_wlun 0:0:0:49488: PM: failed to resume async: error 5
> 
> Cc: stable@vger.kernel.org # 6.8
> Fixes: c58225b7e3d7 ("clk: qcom: add the SM8650 Global Clock Controller driver, part 1")
> Suggested-by: Nitin Rawat <quic_nitirawa@quicinc.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   drivers/clk/qcom/gcc-sm8650.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/qcom/gcc-sm8650.c b/drivers/clk/qcom/gcc-sm8650.c
> index fd9d6544bdd5..ddc38caf7160 100644
> --- a/drivers/clk/qcom/gcc-sm8650.c
> +++ b/drivers/clk/qcom/gcc-sm8650.c
> @@ -3480,7 +3480,7 @@ static struct gdsc ufs_phy_gdsc = {
>   		.name = "ufs_phy_gdsc",
>   	},
>   	.pwrsts = PWRSTS_OFF_ON,
> -	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
> +	.flags = POLL_CFG_GDSCR | ALWAYS_ON,
>   };
>   
>   static struct gdsc ufs_mem_phy_gdsc = {
> @@ -3489,7 +3489,7 @@ static struct gdsc ufs_mem_phy_gdsc = {
>   		.name = "ufs_mem_phy_gdsc",
>   	},
>   	.pwrsts = PWRSTS_OFF_ON,
> -	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
> +	.flags = POLL_CFG_GDSCR | ALWAYS_ON,
>   };
>   
>   static struct gdsc usb30_prim_gdsc = {
> 

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-QRD
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-HDK

Thanks!
Neil

