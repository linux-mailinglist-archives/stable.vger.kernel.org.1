Return-Path: <stable+bounces-143133-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8320AB31C7
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 10:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBAB73BCA68
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 08:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89252259CBE;
	Mon, 12 May 2025 08:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fFaFn33M"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B350256C85
	for <stable@vger.kernel.org>; Mon, 12 May 2025 08:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747038801; cv=none; b=dhZ5tCMln4tEoVfDVxYGoEdggweyrEKfep0hAvdnt997CRQ+mKEsBKlmH/LtyEbnjWk/WdPlgyJDkETqdgG8UG/CAjp+ApkpMXoeCjo7cchdmIAuHht40QCcxKzt4SoCRUnFHcE7VeWPgn8WJyyiDAzgkKID2rgBEeO4C1GekjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747038801; c=relaxed/simple;
	bh=Hik7OtedaFZAkiGMlum5kZXS39nxblKMLG+OT8C0c1U=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=b6SJhOx3o9idi+DHVPJA3m/BqnItCBpETo06t9GvZlkyKu+LTMBi0zkKfTbmKZENu9cYPOAxtH6DFpTLAFPmbIfFqp50l0Nnhq/ZKGHyW3maYxC1jt3tF8d4no0gTLSZOciYDrW+Kk1cBzilTs2F5f8ViK7SvWQkeym5Fo6+gJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fFaFn33M; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cfebc343dso27301295e9.2
        for <stable@vger.kernel.org>; Mon, 12 May 2025 01:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747038795; x=1747643595; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wTzHIKjFiKmyPbI4xGH6KvZ5G+KJhLs/y1YftexbnRA=;
        b=fFaFn33MwB3gI1IuKOXjYBCJzWaTVklB5nqN3D8AfEHBg5ofDxXrv73imhBfNGuKiX
         gTjZN/jgV/zSFyEJdKm08atmU3S5vgLU77HxP/aDqahGOrRH0Pq43Q3eDxL99egwpJoe
         XCodrigCgwSLtshb5QnhXqGYqAWU0dAZ+aB0GuLbPlS9mmBISqKFLlAMrJID2UTJ87pA
         7bgkzT3/NhgMiW2rmg1w0mmj6yeK1ZL1bsya3co/+f0SFY8BPZOFWnzfPqgb34AJv0Ni
         ZfBfEC8EOZwZ6pCiblarXF5dV3+K92prz8t+6ipc2UFAGonjBbaVKu+3lqx/xU/Fi0bO
         yWsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747038795; x=1747643595;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wTzHIKjFiKmyPbI4xGH6KvZ5G+KJhLs/y1YftexbnRA=;
        b=e4Psh+CKDstGwZiVzoeoiPTuMh3szrGJ9rFocFQyNN6ucc5kbAMigcRA22G2N3/RcH
         bgM+mHEDiVZKbq1e2xcb+MIsWnuHT+2gBTQPR8Q5x03jpv3lurBN8I4u8uDHAxPlYfW4
         j3pWMQeYUMj8WvdPi2MxouYvi3jnY4BNeX/OxIFV25CmTqAP2UB5Y0MjFCN0rrAOUkPA
         Bv34tjXVaqYUANsh5dxIAZRwHI8xgZi/JNm0bAXIzI6ewRkuHdFybKXXYidzaqpBsY/G
         ZIRyZXEOMBksMsZkROHbIPaF5zG2Y7XzUb6lrzYq3H63V7BTxnJJAZ/RcJJcO00hCpD8
         9JjQ==
X-Gm-Message-State: AOJu0YxP7uBecvBPJRHNOx9TqqCFh36XRPAUe2F3HabKKfJkibuN/zw6
	3u2xhsh2H0geC1TWWIboDiwcbebeyXWpUQTtXWMEcigyU5keuYBXJ9lQG7PILHE=
X-Gm-Gg: ASbGncsLzCtUTqKoC0GGdzDv2esZKtF75x8xhbrXZ23yCtR4T0KBol3gO+zoUzXyvm8
	scLQBSVOJ/seyFcwmIPdThmvmxY7ODqtyiZiNpOBVk0bd7lgC86o2PusTFBcgAwz9bPRdJDTHU4
	gFUP9JsuEyR5FhDRGrxm7FLbhgxFVAnPK3PkIv8v2WXmm1ztuiNjmrdMUozi+xo6IBuAHc0j6H3
	W4t1LUa4hY0cFw8U5ljaFR95YmUd35BcZfxyRs56xzpLDP6C5BmXhPy8KW6h6eQH4anUdih7y8M
	+7n8TRSbdYvtwYFSRWDdTog8LkMprmSdrRoieFdZ29wFTX+p4HIbCvbzKhqg6i1zERTPD3ps57M
	kEGQ/4L2zPin6tKjuCVv5wQAD67qh
X-Google-Smtp-Source: AGHT+IFuQDvMvD9YeofWnuHOmfxKE1aBgD/3Qr8iHneAgHf//6SuN6jkgPv2gPV91PBlbLB7la43DA==
X-Received: by 2002:a05:600c:8012:b0:43b:cc42:c54f with SMTP id 5b1f17b1804b1-442d6d3e6e8mr115012785e9.14.1747038795575;
        Mon, 12 May 2025 01:33:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:a88a:91be:2fd8:4f9f? ([2a01:e0a:3d9:2080:a88a:91be:2fd8:4f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd3b7b83sm156129235e9.33.2025.05.12.01.33.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 01:33:15 -0700 (PDT)
Message-ID: <9d72fe73-3b71-4f40-a34e-fc7bdb907cc6@linaro.org>
Date: Mon, 12 May 2025 10:33:14 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2] clk: meson-g12a: fix missing spicc clks to clk_sel
To: Da Xue <da@libre.computer>, Jerome Brunet <jbrunet@baylibre.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: stable@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250511173926.1468374-1-da@libre.computer>
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
In-Reply-To: <20250511173926.1468374-1-da@libre.computer>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 11/05/2025 19:39, Da Xue wrote:
> HHI_SPICC_CLK_CNTL bits 25:23 controls spicc clk_sel.

This sentence can be removed, this patch doesn't change anything in this= regard.

> 
> It is missing fclk_div 2 and gp0_pll which causes the spicc module to
> output the incorrect clocks for spicc sclk at 2.5x the expected rate.

The sentence is not correct, the spicc sclk will be at the freq computed but CCF,
it simply can't achieve the requested rate without the missing parents.

But I'm against adding the GP0 PLL since this PLL is required to drive DSI panels.

And GP0 isn't needed since on G12, the SPICC has the "enhance_clk_div" which should be
able to to reach much more rates with the fclk_divX clocks.

Neil

> 
> Add the missing clocks resolves this.
> 
> Fixes: a18c8e0b7697 ("clk: meson: g12a: add support for the SPICC SCLK Source clocks")
> Cc: <stable@vger.kernel.org> # 6.1
> Signed-off-by: Da Xue <da@libre.computer>
> ---
> Changelog:
> 
> v1 -> v2: add Fixes as an older version of the patch was incorrectly sent as v1
> ---
>   drivers/clk/meson/g12a.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
> index 4f92b83965d5a..892862bf39996 100644
> --- a/drivers/clk/meson/g12a.c
> +++ b/drivers/clk/meson/g12a.c
> @@ -4099,8 +4099,10 @@ static const struct clk_parent_data spicc_sclk_parent_data[] = {
>   	{ .hw = &g12a_clk81.hw },
>   	{ .hw = &g12a_fclk_div4.hw },
>   	{ .hw = &g12a_fclk_div3.hw },
> +	{ .hw = &g12a_fclk_div2.hw },
>   	{ .hw = &g12a_fclk_div5.hw },
>   	{ .hw = &g12a_fclk_div7.hw },
> +	{ .hw = &g12a_gp0_pll.hw, },
>   };
>   
>   static struct clk_regmap g12a_spicc0_sclk_sel = {


