Return-Path: <stable+bounces-47992-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A125E8FCAC9
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 13:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B9B0B239C9
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 11:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2591922CC;
	Wed,  5 Jun 2024 11:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MkfrmZBy"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EEC14D451
	for <stable@vger.kernel.org>; Wed,  5 Jun 2024 11:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717587896; cv=none; b=OICuuyxgX1ZeFfhDhvbEBBCLcTpz6IBnKjT3G5xZ1/+Tql8OOpi5nGgwUtl7gnZLsHVzG4ii8F5q3aQnji4Rb2n5PcUMN9cd5H3SMYej3GIhvXW5cdaYM9SZvTR7gJ5DocqDoa196aXbVsFTku6d5DNKli9nAz05hd6D0pO5HkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717587896; c=relaxed/simple;
	bh=10uX0pnm175pZfInro+zFADnM8oOID6XHqWA+aC+5pI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ix/sMtVFXFVw70CwbFUGdlepEPISVoSB74z14Dvv3dwoQXHKnHkMnnFBPoMxK/bpt73mfHPXhiMUI3mA9P38F9nJaTanJjmp9GhItajKJU3OBz8NiIMPbTmFSxq3tbl0XysvkyYUkAmQo6Urdn+C0ogVncyWcz/VxB74+lx7NfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MkfrmZBy; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso206852366b.0
        for <stable@vger.kernel.org>; Wed, 05 Jun 2024 04:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717587893; x=1718192693; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zNZcbSzlByI67PsmGACJiLmqC3BU0QVfeHAMyiGnADo=;
        b=MkfrmZBy4nTaZ8k/EThi3M3HjAVgdCwITrP/cIeOgMYTB6qM+4SA5QpGmMaYy4GWuc
         R4q4mo8lZZkqCQWtkfqm/trjGcga0mCppP/lfphGoJun1PkjmPhkVqPr6Oa/A8C6N5kY
         O/hwG/9I4I1H4apNXjbQAWPKPQeEXQonSOsQe+Pydwh0O1bUypj6pxB+95Da48NoYr3h
         HlGEV5r0476pT04fOVgntOrrxAbds+8wGV83esmvR4ycOnn/rhovqCvylwQ9EiTkmf2q
         AA5MAr7RV0DRZ4eqWViW2/ci2mkHLCo1/E9jTPQ/+4UQMeE/PLx3SSm4WbyHd8euCB06
         2SEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717587893; x=1718192693;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zNZcbSzlByI67PsmGACJiLmqC3BU0QVfeHAMyiGnADo=;
        b=l4aOeZZsw2kfSXhaS/bYH9UNgp7U+nPTrAILB4Pbx357MiiEpo92+LM3duJRLxRSEw
         fUKIet+r0sHnM0eRnPD86wayPAsnichpwVZY7St9b0NgC7mKnBGsi9jUhvXOfqBH1IuD
         b4xrq9/FPcaPFhJfSbd2xNt4tY6rbIaEKQB/sU14TmYJTzSgbvCPN/aAEqihzOwJe8w+
         0n+1/oy6UOGWGtMnhI61D99LFoeEsMONIiKRQd4Emuu2mh7Q5KDpyOGNl+NxpQIBhNcS
         bTyalArj7cPVbG2YvT7oobYMWkqUmvw2nvcwJMpMOP3SQzvwjiMfH6MC1EUlqxwtDyDL
         RSog==
X-Forwarded-Encrypted: i=1; AJvYcCVyESppDnnO9Nc86Ez6uz/czw0xrpRd0f7cZWNJQaP2Yx5WEqx6nazcY8y+KDlGjx8p+hkCZcqVStyZL2IM5H0j/w0nIOb0
X-Gm-Message-State: AOJu0YzQVoaa7MNMLcjHgqlgRKDcdebyx10zZvcagDl5WMq3RBJxrd0P
	A6toJTgXKOPpMsBd3vu3g7KDiSkhL1C+nvffpqTxSQx/8kWvt5OAY9fTx4Rg8Io=
X-Google-Smtp-Source: AGHT+IEoVi/zKnP2Ndp/Gg6ZKxgNC+4Zkk4fp46/324EESrPUgXyT6F7yoCUf6yEtyXrPvbrwW2rlQ==
X-Received: by 2002:a17:906:698:b0:a6c:7221:60e6 with SMTP id a640c23a62f3a-a6c72216263mr4448166b.57.1717587893061;
        Wed, 05 Jun 2024 04:44:53 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::8090? ([2a02:8109:aa0d:be00::8090])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a67e73fa49esm759342166b.87.2024.06.05.04.44.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 04:44:52 -0700 (PDT)
Message-ID: <791c4a62-aa7f-4b62-ac71-b7ec66b0c996@linaro.org>
Date: Wed, 5 Jun 2024 13:44:50 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: qrb4210-rb2: switch I2C2 to
 i2c-gpio
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Alexey Klimov <alexey.klimov@linaro.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240605-rb12-i2c2g-pio-v2-0-946f5d6b6948@linaro.org>
 <20240605-rb12-i2c2g-pio-v2-2-946f5d6b6948@linaro.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240605-rb12-i2c2g-pio-v2-2-946f5d6b6948@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 05/06/2024 10:55, Dmitry Baryshkov wrote:
> On the Qualcomm RB2 platform the I2C bus connected to the LT9611UXC
> bridge under some circumstances can go into a state when all transfers
> timeout. This causes both issues with fetching of EDID and with
> updating of the bridge's firmware. While we are debugging the issue,
> switch corresponding I2C bus to use i2c-gpio driver. While using
> i2c-gpio no communication issues are observed.
> 
> This patch is asusmed to be a temporary fix, so it is implemented in a
> non-intrusive manner to simply reverting it later.
> 
> Fixes: f7b01e07e89c ("arm64: dts: qcom: qrb4210-rb2: Enable display out")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
> index 2c39bb1b97db..cb8a62714a30 100644
> --- a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
> +++ b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
> @@ -60,6 +60,17 @@ hdmi_con: endpoint {
>   		};
>   	};
>   
> +	i2c2_gpio: i2c {
> +		compatible = "i2c-gpio";
> +
> +		sda-gpios = <&tlmm 6 GPIO_ACTIVE_HIGH>;
> +		scl-gpios = <&tlmm 7 GPIO_ACTIVE_HIGH>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		status = "disabled";
> +	};
> +
>   	leds {
>   		compatible = "gpio-leds";
>   
> @@ -190,7 +201,7 @@ zap-shader {
>   	};
>   };
>   
> -&i2c2 {
> +&i2c2_gpio {
>   	clock-frequency = <400000>;
>   	status = "okay";
>   
> 

-- 
// Caleb (they/them)

