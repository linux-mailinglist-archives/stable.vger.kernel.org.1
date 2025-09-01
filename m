Return-Path: <stable+bounces-176841-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F473B3E283
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 14:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 211FC201C7D
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 12:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21CB326D45;
	Mon,  1 Sep 2025 12:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AEWxgWgJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76363229B2A
	for <stable@vger.kernel.org>; Mon,  1 Sep 2025 12:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729239; cv=none; b=le7KfULkzASnL/XojAudDGUc5m8TmGu6Zx04OH1zIAkSKsQ4XW/SJiBEaueBRY3MIQUjy7lBJa/CLcwigMpDIdqGSkWcvlDYbk6vu6kPC/BCuaXBRFCPTSR0UQYn23Y2X3eNR5FeQb54DckJ65YA3N4Dh7ymiFf+fu569+R9v4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729239; c=relaxed/simple;
	bh=bGXiQWuP2joVtz5mi9GkdStz5k7fcbMaeihQjtKUsLA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=PY97z7BVFeMCNYGV6NUMaMoNT4+Z+LpBl/B3ZEFU+y/cnSiZHb+Sol7s8YWyLI8M9uA76sYZZ9TFKUhtg1K0yC3nzAx9htOYqgNjsbagT86UBBFLftyD+vxTCXXSuPi4JKYPP4SMZI7ISt7ZQfqUm951WxPxAPvd0zb0VX1ttSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AEWxgWgJ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45b7e69570bso20085405e9.0
        for <stable@vger.kernel.org>; Mon, 01 Sep 2025 05:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756729235; x=1757334035; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WjeTTnIl0jOEJud+l5JHju8hS4DYKMB3s9qvufpCuog=;
        b=AEWxgWgJitRvGS2LydjpbzyeL1jgpTB8uOYuCyeHzNjRI0G+9fQBK9/ngRSa90Ybuy
         gGy6Mq8ubHw9X8QqEPq99MvUoySHGmpUjK2gMtN2RLuGFlznkS7iPx5ytB8MMNkqHaLb
         0dTPD/d21idn1UmsXx2LzEXUgNV1ELtfIyHu2awDrEmQdNmq7qkqq5jnYAOsN2vLjVya
         J5/0R4jkV1vTTttGzx0ZbAVqhwqBpF4IWbLxw1+G7GMZxu4zxnjLT5md+pQeiTBuli7k
         UvTkVQov7/I+rfSddL1Vdi4QngoqZvRUN2u0ns+BUhNFuWJcaiCbTP3RsuvbrJ1UTxjC
         7uYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756729235; x=1757334035;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WjeTTnIl0jOEJud+l5JHju8hS4DYKMB3s9qvufpCuog=;
        b=Jb2dHBM3U3eT8Nn5jMjU/xZDeKQDArxJFfypX4ZOQpGAtVn/pyOui/UDcDEapNG9Dx
         SnRJligSQr4GgrHyqZipNKhn5gtXp0zipu3+NSXJ4PuNq7HH3vY3jdmOXTZkXIQicIXT
         YqHZPRkasUL98KYFkAVfIhKyXSR0fUoQ5ETBnG0V8jwLcvfDeT7txN1+JYiVvwaBQE8u
         W3t2dNtYr/XTlqtfsD2oGMDYBvuui1H1Uiq5zOfqCw3VUSdaWTQHC9O0/IrOt1+oDmto
         2SEWZReFduLIUc2EPp98knrqt833rTTg6CldrttdMAlpmLCjvCmzjdDbgbv+kKw20suv
         DvYw==
X-Forwarded-Encrypted: i=1; AJvYcCUm3mWneSMQhcvms0DQrOwN8p85vP1HyiNRgZUkPi8hS7+GptMYo/Yhn9xehBsOjT6mPl9OgCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT7i7WvsG4ttP8ijKU9rfEcQxNKm+EG0xy2iq5ET+uDh6yXSZN
	In4EG4WETfT/9tyRMmlPTZR2KD5NE087gIqyAeHpBft4YlA1Co2THRl+fFUnogshyTo=
X-Gm-Gg: ASbGnct10Y+29kjeUf8eJZbT2l/B+tnJYUQ9JXAsknkKIGtw+Pw1rmWP8Gbs+5jUSCH
	1HQln9y31S/XxQDPXVrcGnnfZaHmTlFYI/JOJO370AGSV0jG+aiJeuP8rcRO+SotB1Sy4Gurgig
	U6eka83kYLdxveWZR7AIGFJCZiNHv5OuRu2wAZp+UG6Anea5Ru8AGr88EuTwJn678o7wRae69iB
	uGmBnGs7DFbN4FYON4FBpsOSOPMLev8Sh8xT8vlLhUKCyjiFvi5YihQ6qlVYH7ioqKEQJPMFpYR
	8STw5d2hVL5n06dBJWDIADJkOD7QOAfwhtLFxPVZHLZ087ktcPTYq2C5o5FQ6ynZSkJgGVMj9id
	SjojgQDyNdi4zbslIlwuHeT5dBynu5GE7N2kTqzvv+72mcRq7Tf9G8fBQWWSW8dSbzbMkQmECvE
	onhSTxQHQ=
X-Google-Smtp-Source: AGHT+IFRNIETqpB+2jIgi5Tu/QDZHVgu9dKwYHLpUPiWYKQcXey9hx08WJgHdQv+NvmQy5/dFQ/3Qg==
X-Received: by 2002:a05:600c:524d:b0:45b:8a10:e5a7 with SMTP id 5b1f17b1804b1-45b8a10e8c5mr45748725e9.37.1756729234802;
        Mon, 01 Sep 2025 05:20:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:881c:7d0e:ad0a:d9a? ([2a01:e0a:3d9:2080:881c:7d0e:ad0a:d9a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d45daf3293sm7429476f8f.48.2025.09.01.05.20.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 05:20:34 -0700 (PDT)
Message-ID: <0d471827-16f2-4eb4-9212-82ca20a1c0ba@linaro.org>
Date: Mon, 1 Sep 2025 14:20:33 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] firmware: meson_sm: fix device leak at probe
To: Johan Hovold <johan@kernel.org>
Cc: Kevin Hilman <khilman@baylibre.com>, Jerome Brunet
 <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Carlo Caione <ccaione@baylibre.com>, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250725074019.8765-1-johan@kernel.org>
 <aK7U7-ebrPcxwEIj@hovoldconsulting.com>
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
In-Reply-To: <aK7U7-ebrPcxwEIj@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/08/2025 11:50, Johan Hovold wrote:
> On Fri, Jul 25, 2025 at 09:40:19AM +0200, Johan Hovold wrote:
>> Make sure to drop the reference to the secure monitor device taken by
>> of_find_device_by_node() when looking up its driver data on behalf of
>> other drivers (e.g. during probe).
>>
>> Note that holding a reference to the platform device does not prevent
>> its driver data from going away so there is no point in keeping the
>> reference after the helper returns.
>>
>> Fixes: 8cde3c2153e8 ("firmware: meson_sm: Rework driver as a proper platform driver")
>> Cc: stable@vger.kernel.org	# 5.5
>> Cc: Carlo Caione <ccaione@baylibre.com>
>> Signed-off-by: Johan Hovold <johan@kernel.org>
> 
> Can someone pick this one up (along with the compile-test patch)?

I'll pick it.

Neil

> 
> Johan


