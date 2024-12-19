Return-Path: <stable+bounces-105325-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AAD9F80F1
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 18:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E6BA188F64F
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 17:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E7E1990B7;
	Thu, 19 Dec 2024 17:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s9Rv+YiY"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CBC15252D
	for <stable@vger.kernel.org>; Thu, 19 Dec 2024 17:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734627767; cv=none; b=VURDG10WnA1aCenMsyESx5ypnU6FKsPStHROtcPJs3L20Tjurv0jIp+9ZNCBpqw+w2n7q8NFf9iw6sw1mYbD12bO1w146q93t8FsAeNDMuJl17NGTdY+BenKzPUScQiti3K8GTXiibfPi2rkz6Dl2W4Zt9dvXoearZ4UFddBrso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734627767; c=relaxed/simple;
	bh=8tPhpReMI2FEAq6ZgzoYCKneBzUWt4OYXxogzP66pLI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=CIUv2vG7P1FLZYEnUykKbfQFDwb0+Ex0cQj8h+OObbp1k2DmsxtYYTiah/Jl+GTvMBO4uh4/4nvhxFDEMTbCuR+aa1nl6k/8WCZvdPzv0B3iwMP42/PKlHYJoSeFc07jdSAQqsMrwk/vtbPiRtgpNcYWFX0CsYvsgAp9w6rCcSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s9Rv+YiY; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-432d86a3085so7512955e9.2
        for <stable@vger.kernel.org>; Thu, 19 Dec 2024 09:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734627764; x=1735232564; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gL28luK8Y6zJpCCzZzcZt/N+YLNKTMLpY3B1nVCJhqo=;
        b=s9Rv+YiYEb4jnBhaLDo0WuxifuPXtm7zZ32QkaS3krbvMbyvn4wW5OaSh49UOF6JJC
         Hi3wlpzHI7QDna30+RYDThTtzPnEDWS/NCfzfC73+K7rHI4WyMii+AukSZZu2kqS88A8
         nSAeve0g21seFr112ZeRlAbVshf+prX5g1cG5VSAlC93wwPMZwNR+aczLZW/JhqAYlze
         MuBVEVgUPVztKHhzH5HSVwRsQYkrIcssEL4U47BzTOItrNFnfIvt/4Z8iMkS/e4/x5Jk
         zwn5cBbx4xHemzRnee0/i2Xuzs/nwuhqNnuymIjCR/FJvPwqbq0E63pVaVhusdXYy1EE
         /I+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734627764; x=1735232564;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gL28luK8Y6zJpCCzZzcZt/N+YLNKTMLpY3B1nVCJhqo=;
        b=VWLDGK3opJrp+OsDtvXg/EKhbUIHTGIzB0eJL3UpEUaEEexSUAsPgazSr6ZZh+Bk6Q
         vR/Gk2Qs3zUg8T19M6vQ/MD+wCpko5y49rOaJlgGReTo6ow+fGxM/JQ8Q79/nGJ37sST
         faZK1ANS8g8os1QvOXR43iC+XaksLeqUvgXhC0qPldn8YjhCPu4LZPnmx6Hfj/tBS6P9
         yPKl2D5hxqqzjy3xlAKKVc4AKSNU76MU1PeTI/75LNtbsfxT0PAvPCEFJ+0RPEQtsogD
         B5Ip7amQVt/lG5NONU5vtLt8IXHYn2V1ZVid1jnrIfxydcxU4jbw36u5WHAQRD7Sm6Gd
         v6oA==
X-Forwarded-Encrypted: i=1; AJvYcCW8vLKntrVNhCvYK/zPYuQVyDfkkaQFD8wq21m27Nt79NTvd3ptmxbZKNIsdEp5t7e0U1hoLoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw436RjVxVkvdXeFPqqTQtjOI+rugFG6Jk5rs8neUHFdoDSOOLa
	mVHVEW0JUE/pCJODg0dgd74ysmh6DKX7UgTJFpMLDyb+nTVsvekIJZ74xDWVuIo=
X-Gm-Gg: ASbGncsf2aUKNAMjUBsbHKpzgUJEeWf12AKQraLvnG+5m/eLeaIzIrJg9HCXjt+vdB3
	EkZti2jXvW6EOj7yBaHWHSv3XfWLiM4n8tMlFl1n9ML+EaDggBNidtkiU17tLuZrj9EqXysTV3+
	iwKmTkuGB3/+bor3jU7pycSexELQ7woMavXsfsVFHuJoEPbSuUhN16GvfPJrVOPffn3qedznOoJ
	Rz6hvyWU6SFV9D8KxhXWteHXPlDEo9sW/WJ+zDdfk5oDH4lCvTQV5RoSIboZ0q86i7UUpnpyJpt
	jK9Nh5nX7x8iltCcgQs7iHXU4K60+pG9zw==
X-Google-Smtp-Source: AGHT+IGa6V8mo5UvfYFVnq8LCR1VrG/yzInfd45NCV/5/aiauE4nEtWeiSYDF1W1Pk6JzEehWx4zmg==
X-Received: by 2002:a05:600c:4508:b0:436:2923:d23a with SMTP id 5b1f17b1804b1-4365cbb5bb6mr33859245e9.33.1734627764440;
        Thu, 19 Dec 2024 09:02:44 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:a0fd:4342:76af:7533? ([2a01:e0a:982:cbb0:a0fd:4342:76af:7533])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b00cf6sm58103265e9.10.2024.12.19.09.02.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 09:02:43 -0800 (PST)
Message-ID: <09df3401-7d06-4136-9098-ce9782e2a00f@linaro.org>
Date: Thu, 19 Dec 2024 18:02:40 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/2] clk: qcom: gcc-sm8550: Do not turn off PCIe GDSCs
 during gdsc_disable()
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20241219170011.70140-1-manivannan.sadhasivam@linaro.org>
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
In-Reply-To: <20241219170011.70140-1-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/12/2024 18:00, Manivannan Sadhasivam wrote:
> With PWRSTS_OFF_ON, PCIe GDSCs are turned off during gdsc_disable(). This
> can happen during scenarios such as system suspend and breaks the resume
> of PCIe controllers from suspend.
> 
> So use PWRSTS_RET_ON to indicate the GDSC driver to not turn off the GDSCs
> during gdsc_disable() and allow the hardware to transition the GDSCs to
> retention when the parent domain enters low power state during system
> suspend.
> 
> Cc: stable@vger.kernel.org # 6.2
> Fixes: 955f2ea3b9e9 ("clk: qcom: Add GCC driver for SM8550")
> Reported-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   drivers/clk/qcom/gcc-sm8550.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/qcom/gcc-sm8550.c b/drivers/clk/qcom/gcc-sm8550.c
> index 5abaeddd6afc..862a9bf73bcb 100644
> --- a/drivers/clk/qcom/gcc-sm8550.c
> +++ b/drivers/clk/qcom/gcc-sm8550.c
> @@ -3003,7 +3003,7 @@ static struct gdsc pcie_0_gdsc = {
>   	.pd = {
>   		.name = "pcie_0_gdsc",
>   	},
> -	.pwrsts = PWRSTS_OFF_ON,
> +	.pwrsts = PWRSTS_RET_ON,
>   	.flags = VOTABLE | POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
>   };
>   
> @@ -3014,7 +3014,7 @@ static struct gdsc pcie_0_phy_gdsc = {
>   	.pd = {
>   		.name = "pcie_0_phy_gdsc",
>   	},
> -	.pwrsts = PWRSTS_OFF_ON,
> +	.pwrsts = PWRSTS_RET_ON,
>   	.flags = VOTABLE | POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
>   };
>   
> @@ -3025,7 +3025,7 @@ static struct gdsc pcie_1_gdsc = {
>   	.pd = {
>   		.name = "pcie_1_gdsc",
>   	},
> -	.pwrsts = PWRSTS_OFF_ON,
> +	.pwrsts = PWRSTS_RET_ON,
>   	.flags = VOTABLE | POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
>   };
>   
> @@ -3036,7 +3036,7 @@ static struct gdsc pcie_1_phy_gdsc = {
>   	.pd = {
>   		.name = "pcie_1_phy_gdsc",
>   	},
> -	.pwrsts = PWRSTS_OFF_ON,
> +	.pwrsts = PWRSTS_RET_ON,
>   	.flags = VOTABLE | POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
>   };
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on QRD8550

