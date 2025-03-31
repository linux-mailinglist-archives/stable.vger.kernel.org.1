Return-Path: <stable+bounces-127045-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E41EA766C2
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 15:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6885E3ABC66
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 13:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E191211A05;
	Mon, 31 Mar 2025 13:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hvALBDxq"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7524D157A5A
	for <stable@vger.kernel.org>; Mon, 31 Mar 2025 13:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743427327; cv=none; b=MjMhpysjxJtHmgZV4Vf3rSlblPefxgSHHJqYX5vGUNeXhSsj5PTuYnksIAt5HBcrdE72ilnSyzgK3F/QaoxySaSy2lhoi3KQdAxmO3cJNKUSOQqjnMOXW06gdaLF5OHoMcYjgzwnax1kYTXBVQh/npPuxDF0oCCkNEfFoLf1ZkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743427327; c=relaxed/simple;
	bh=H0+BMW7QcTDjy39aSiOdTsRn5xBpuJir+R08vpDsJPw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=TArAsM9lUhhZXvtPZ7L7WUvS0ZEN2f+ktXmn5yE5vAlOpNA2eVlRHWW+kSmvU7JWJzkGQqBxzVy1clGOMUbmHIJ+9IIxhab/ib7baPw2XorZqtSB7OTCzzje3UpRZeuTFYM1x7xhxdTOf2xHaoZDEkA3j4RPn7nxKXaX/3aL1kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hvALBDxq; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39c1efbefc6so268443f8f.1
        for <stable@vger.kernel.org>; Mon, 31 Mar 2025 06:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743427323; x=1744032123; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/rYByIuq0b2PjmjfZxltk1e0AePkOWa/aML/nirCPWw=;
        b=hvALBDxqQg9oiZZIGFnButnEGwVuV9QuaZEchqH+Z1Ig5kk+JiGVEhB+QDSbvlrp/l
         CbmkA4fA7l5ZvgffF8o4U8gTR4hY1L52+cNpmsvU0yOdJt5Ci6jAyiiypA9undLevQEv
         9a4/ABsE/wZxFgbjS6gBiznjR7iWzc65ec1VX2oEKW94X7UHvtUtmn5I+c/foQ786Zmg
         nUq1Su8o8wpZFi5U8OishATRQxIc+UIqG4URdxox1+97qqCjQcEIZBAe7lSdv74VaRzx
         8p2kBfFTwa1NjGXO5GP67loO/mkJw6B9W/ZXaUbgB5tkrGsjU7WFxmej2S73nQCLZsWW
         k7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743427323; x=1744032123;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/rYByIuq0b2PjmjfZxltk1e0AePkOWa/aML/nirCPWw=;
        b=EqDzdAgDRKDfXVqNIXL+4hW3RBttQsOG6dAfmm08QFxh9FS4xAGfIgTCbcIKgMHMjU
         pU7A9jBLkWG75swJdZ9j7e/k6jaMJ0QZzoWlsnaZQr+jrtyF00GL9HyN2GHQvGF5622C
         cADWGY+JGaDRzInHjD0Nkr+dAIDRhWg1aHFoM5O1WYalBjdkeKoqGZ7jCHd7TQymfURR
         36HnKvLhQEgWs0q6Yaf058eizoaTVhJJfyDEO6QqCnOKuzrBji6/6QJWcAva6+yb6LJn
         eix9i/i2LJ+1OOaaCV9zObx0kXeUvgdA+9asLsSv6tBqgHrt73PeosdAhnEgFX2/4AJ4
         +eJw==
X-Gm-Message-State: AOJu0Yxi1vMO2TlmtW/WeaYVMuosmTNmpPvwgmkRTjunJIK/DvtRb5c8
	esqqpNa+vdJZFCn8riw8/cmsyLHwek2bOK6prmxgAUJP64n8t/hQW23xQJNP1Jg=
X-Gm-Gg: ASbGnctKDKkzua9ZiHt2mX85GrGBD1IPXyS8tRmgKBgEyW44RsG8m0OuGLnpjgNiY+6
	Cwec7gK1MNQYHjqMDP7z3kQzUSpEpMpzeOzK7o5BPrzYLXe/oQgpFBFNvmu01nvaAH7i1bi0Fhz
	+AmP8G0elP7lEpw93xmN+1nhHlWE0wwuhyEkbCz6tN5ZqazeHTvNdpNm4JsJNNrCWscZ/3Xff27
	ytnSedPDM6HI3WnXTGfJpDd68Dpt4EgF6CJfrx5TW0j64o06k6U+7l/zyZqml+P4KoLqv9vZaJc
	hEw1b26FGU0mjq5Aks1jTbuy4yyrmErmg0gIXuOpQ5Lpdp27KALjAAm08scwxP6vCmVdkzp/cj/
	2JPW2Ngye8b7jQnh9
X-Google-Smtp-Source: AGHT+IHUVZ074JKaAb9ncND8Uu7WRhh2YlGnAcHVleffCEEVTpj1+nUfZQDJb2JS+yVkEbfZ4DlSNw==
X-Received: by 2002:a05:6000:240a:b0:39c:142c:e889 with SMTP id ffacd0b85a97d-39c142ce891mr6232553f8f.27.1743427322771;
        Mon, 31 Mar 2025 06:22:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:143:2e3d:45f1:fd2? ([2a01:e0a:3d9:2080:143:2e3d:45f1:fd2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b7a4346sm11469954f8f.95.2025.03.31.06.22.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 06:22:02 -0700 (PDT)
Message-ID: <7c986d1f-315d-4cb0-b160-ee1f564c26c4@linaro.org>
Date: Mon, 31 Mar 2025 15:22:01 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2] net: mdio: mux-meson-gxl: set 28th bit in eth_reg2
To: Christian Hewitt <christianshewitt@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Da Xue <da@libre.computer>
References: <20250331074420.3443748-1-christianshewitt@gmail.com>
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
In-Reply-To: <20250331074420.3443748-1-christianshewitt@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/03/2025 09:44, Christian Hewitt wrote:
> From: Da Xue <da@libre.computer>
> 
> This bit is necessary to enable packets on the interface. Without this
> bit set, ethernet behaves as if it is working, but no activity occurs.
> 
> The vendor SDK sets this bit along with the PHY_ID bits. U-boot also
> sets this bit, but if u-boot is not compiled with networking support
> the interface will not work.
> 
> Fixes: 9a24e1ff4326 ("net: mdio: add amlogic gxl mdio mux support");
> Signed-off-by: Da Xue <da@libre.computer>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
> Resending on behalf of Da Xue who has email sending issues.
> Changes since v1 [0]:
> - Remove blank line between Fixes and SoB tags
> - Submit without mail server mangling the patch
> - Minor tweaks to subject line and commit message
> - CC to stable@vger.kernel.org
> 
> [0] https://patchwork.kernel.org/project/linux-amlogic/patch/CACqvRUbx-KsrMwCHYQS6eGXBohynD8Q1CQx=8=9VhqZi13BCQQ@mail.gmail.com/
> 
>   drivers/net/mdio/mdio-mux-meson-gxl.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/mdio/mdio-mux-meson-gxl.c b/drivers/net/mdio/mdio-mux-meson-gxl.c
> index 00c66240136b..fc5883387718 100644
> --- a/drivers/net/mdio/mdio-mux-meson-gxl.c
> +++ b/drivers/net/mdio/mdio-mux-meson-gxl.c
> @@ -17,6 +17,7 @@
>   #define  REG2_LEDACT		GENMASK(23, 22)
>   #define  REG2_LEDLINK		GENMASK(25, 24)
>   #define  REG2_DIV4SEL		BIT(27)
> +#define  REG2_RESERVED_28	BIT(28)
>   #define  REG2_ADCBYPASS		BIT(30)
>   #define  REG2_CLKINSEL		BIT(31)
>   #define ETH_REG3		0x4
> @@ -65,7 +66,7 @@ static void gxl_enable_internal_mdio(struct gxl_mdio_mux *priv)
>   	 * The only constraint is that it must match the one in
>   	 * drivers/net/phy/meson-gxl.c to properly match the PHY.
>   	 */
> -	writel(FIELD_PREP(REG2_PHYID, EPHY_GXL_ID),
> +	writel(REG2_RESERVED_28 | FIELD_PREP(REG2_PHYID, EPHY_GXL_ID),
>   	       priv->regs + ETH_REG2);
>   
>   	/* Enable the internal phy */

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

