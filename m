Return-Path: <stable+bounces-96313-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2B49E1E52
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 14:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AEAF2880C1
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 13:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50501F1315;
	Tue,  3 Dec 2024 13:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dqnCpyNj"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C0D1EE00D
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 13:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733234118; cv=none; b=godomlV08jQUExdn12bhSqd9Ov2eR2L44uo6cltzI7/v2BEfKX7+fXopTdgmF2zBKMYmn0iU4XUEfuuf/Ma30l9Q/7EGr/RtcO7lyeioGoaEEmh6NVa9k0Y1kc5VbSax8cGis9lMR/eE+Wy7xvNjAM5i3n9K9G1bx8d0ijO2QkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733234118; c=relaxed/simple;
	bh=mle9UUb7dDskLtd9jCH9QqWnYl8wSrz63i6CvmV7vXA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=lfUfmCmNkNWH/xlX3ypvLGRyy1ItPVf2EYYzbvZ4NyvSokqGOGR+cc3XqMM6QXuWvbbpLAGfID8By6LXqSj7t0fcg3EK/Z/ZpTxzd5Ko7ytbRMP5xSwuQrq7HKY5mssj2swYH47hEqdsWVHwK/81Gmp0znYBohauT7AW/AnPY7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dqnCpyNj; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-434aa222d96so68864705e9.0
        for <stable@vger.kernel.org>; Tue, 03 Dec 2024 05:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733234114; x=1733838914; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gz+l3KqObW/HJFvDTOv2iIjYIEIUxrukQz2sYdYBT8s=;
        b=dqnCpyNjGijGuEX4/HQfs0ORJbyiO2qrZUfkpvhuJBMOAAs3fj+kRSrNPS9+qA6p0X
         aqFOMLenlOaGS6gsxD8DgXpo4VM103k0d9wfvBE4a7g41PZLb6IJeuCf+9zkXOv9JS/9
         wkmXuCnzzVkyQdW/km5AyhUSzOjz/dBfCj+pgU7hZ7tq0FkCZZO2dPQ4ojBWYJM/bGsd
         mMvzkxOmrioMP7zd85+FODqysa4P/2awx96fJyhA13nLawuywC7j3CeyW/+pqc0lGLyq
         +7UrbkalMXACAwftQhn+mcL+pW7VqwNQQVnoCcdRAXCz9hj3fRFw7hmR2eaPbpa5yA5F
         aW8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733234114; x=1733838914;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gz+l3KqObW/HJFvDTOv2iIjYIEIUxrukQz2sYdYBT8s=;
        b=IZpZhR04uQkCiTGfRloJkQ3nIgqnGEcsalHTh1UhU0k/Dk9+jBFAY6er7LDkmBk/UU
         sI2VkQBRq34eSlCtEX0CE4DeM+JJ6OfqN8+RsayMSgDMnqEU/rPNewn5pozxkbtpBFrQ
         U/LGRNRU5loCf26q/oC895Z5kzyMFpsBV4UCa8g2JcnDPCxsDgv56o9cnly2g8CJd8Sm
         BpqGfrKjvZFyO1KaLqowDcxtQYeF1O696QWHOURHludrKpz75MhurdNWSmKCbFUYCQKV
         w/aqB+Ie0ujaKAhxSn89mYXXkGehkVPawwO8HmmPnpDAISpiapMEqS10R/6aZPX8uA72
         CiNg==
X-Forwarded-Encrypted: i=1; AJvYcCXGf8QL3AObzX7/nNjJ9JaTi1Ilr7bqS8We9dFM5eU/Fx+OVgvtWmSQNlh7brhlc1QphngQ4as=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz26zGfHK2ZinprnN7nAnO59iklTfEoNWuge7ymItABAKQ30Fkn
	k5bmidYByTHMYsFF1FMhb6UWr/FqOa4gmP3t2E44nXWs2mmhSIiaxWtQHGzO/aewcWwhDjyaeHl
	eV0Q=
X-Gm-Gg: ASbGncscD7Ulbq5YPO5GJvu+H2P5PRb7WdRc2veOE0WirZ2VV9vPJJDyMoSHHas/t4Y
	jPZMNZ2yJSeE4lj6ksQW/GlblRyy94qr145Oba8tMnn/oke9/zJ3b3h5K/R+TUCqL03IuNJ2Xgq
	aXF1grJsOaXa5C1Zq8htpMT8FdjUsI3JBoyosHg8th5KdiiX+46LK74rUcku1vNkhmHDJjioa/T
	VHwzaogUgyBGXQoDxF0ITEOeeQSG/00/QP/V2sbDrcCmIWxRvUS7jjyDYIpm3D92t7kKJn+z8+G
	Hyd/IaYPggy/3EpeqgZEC+pz
X-Google-Smtp-Source: AGHT+IHO5v4mBO5cO68x6c9dihydjdMPOihkNn60wLtRB6InkOSEoDsCz6rUvo0qtKSH5DZhekNFlg==
X-Received: by 2002:a05:600c:3502:b0:431:24c3:dbaa with SMTP id 5b1f17b1804b1-434d09b2e2cmr24599645e9.2.1733234114210;
        Tue, 03 Dec 2024 05:55:14 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:b668:b88:4ecf:c065? ([2a01:e0a:982:cbb0:b668:b88:4ecf:c065])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0f32594sm193399585e9.32.2024.12.03.05.55.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 05:55:13 -0800 (PST)
Message-ID: <b3e5184d-19bc-45ed-92e3-a751842839b3@linaro.org>
Date: Tue, 3 Dec 2024 14:55:12 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/9] crypto: qce - unregister previously registered algos
 in error path
To: Bartosz Golaszewski <brgl@bgdev.pl>,
 Thara Gopinath <thara.gopinath@gmail.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 Stanimir Varbanov <svarbanov@mm-sol.com>
Cc: linux-crypto@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, stable@vger.kernel.org
References: <20241203-crypto-qce-refactor-v1-0-c5901d2dd45c@linaro.org>
 <20241203-crypto-qce-refactor-v1-2-c5901d2dd45c@linaro.org>
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
In-Reply-To: <20241203-crypto-qce-refactor-v1-2-c5901d2dd45c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/12/2024 10:19, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> If we encounter an error when registering alorithms with the crypto
> framework, we just bail out and don't unregister the ones we
> successfully registered in prior iterations of the loop.
> 
> Add code that goes back over the algos and unregisters them before
> returning an error from qce_register_algs().
> 
> Cc: stable@vger.kernel.org
> Fixes: ec8f5d8f6f76 ("crypto: qce - Qualcomm crypto engine driver")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>   drivers/crypto/qce/core.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
> index 58ea93220f015..848e5e802b92b 100644
> --- a/drivers/crypto/qce/core.c
> +++ b/drivers/crypto/qce/core.c
> @@ -51,16 +51,19 @@ static void qce_unregister_algs(struct qce_device *qce)
>   static int qce_register_algs(struct qce_device *qce)
>   {
>   	const struct qce_algo_ops *ops;
> -	int i, ret = -ENODEV;
> +	int i, j, ret = -ENODEV;
>   
>   	for (i = 0; i < ARRAY_SIZE(qce_ops); i++) {
>   		ops = qce_ops[i];
>   		ret = ops->register_algs(qce);
> -		if (ret)
> -			break;
> +		if (ret) {
> +			for (j = i - 1; j >= 0; j--)
> +				ops->unregister_algs(qce);
> +			return ret;
> +		}
>   	}
>   
> -	return ret;
> +	return 0;
>   }
>   
>   static int qce_handle_request(struct crypto_async_request *async_req)
> 

Perhaps you can also use the devm trick here aswell ?

Neil

