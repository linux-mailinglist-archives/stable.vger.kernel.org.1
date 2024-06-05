Return-Path: <stable+bounces-47993-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 542358FCACE
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 13:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 710411C22F88
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 11:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4E11411EB;
	Wed,  5 Jun 2024 11:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XHrx8TH2"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AD914D297
	for <stable@vger.kernel.org>; Wed,  5 Jun 2024 11:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717587924; cv=none; b=j6ATboyyJKsbWQ6UXxhKhKWyI428pc4mltNtr/+R+TCIb1gazjw9rkGHZmJ6erXQ8VGSPUZoJb6FU9mfagtEb77NtYuYLrNN0/PYjKVgWmCCXQxs/0IFQHPrniw/NZVmG+CnEnWRT93b+mpV19G4nFVnKoTra0S80Icq4PXDXcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717587924; c=relaxed/simple;
	bh=F8KvKlp9bavX/llL9E6gFKVG+DJ59VczQJj9wnu+J8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KQxzlbaRQVcfap0hEVc+/+/IXjkCN5J2SIhIsA1MZAz+0UIC6tD8Gp+IJ2scATeyw3Vw+Zp1d93N6m3uD1Txxsj3iaPzdWxNGS90kp0s3H6XT0b47hJfMPABDZBbEYeLmvIN+MUjrmtJKnuNTcUQvkB7+UVDlOvv171HiXGXeSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XHrx8TH2; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57a6fcb823fso3178824a12.3
        for <stable@vger.kernel.org>; Wed, 05 Jun 2024 04:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717587920; x=1718192720; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FIB7ujhSm4r4oHfWl29labezUCHSPo2rSBZvn+iBsPc=;
        b=XHrx8TH2k6q83iY625U8yXpQYcTBiAVEFQjCZHCtSYnU7Gwq/4Y0eoP8Lnjcg3NgTa
         5ccKQnqnZwn7jmCpzvztowLVib0f2vSHZBZjLTPGQ/DY5ot+y9cWEhXgDnr109yC6wzM
         x0C9R0s/UL0TOaSyJNDgCU4y7J5CNiHJIWSOiQ0ibCh2G/hojC4cShdM9D7E9iBdKq32
         1DqI5b4HRACmlp7dbwJ3V7jBRcr2NCo8AscFX73+eRFcSDllMP/EYIMO5VTd4RQcB/ej
         VZRvdaf3eMS+PUVmiofRfGhUQ2FNZZYWJCaw9ik5EDc1gp+9fpG6F1qDWE4mx82OkEHu
         02iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717587920; x=1718192720;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FIB7ujhSm4r4oHfWl29labezUCHSPo2rSBZvn+iBsPc=;
        b=V1XTLjWi9wcwkcNiKHTIbmvmgGZeBzsXo2d0YwBg5aA10U3dBZJneL99fI4k1aZRhV
         BeaTclHNa8vIA+KQt/6syPwDdP7kfTTNEcMZgTgSOpd0YSqbxxkRRWViA/COY5vi/gIa
         Ivs5TGZTd5a+KAu4t4QDTX6mNYr4IqKmJcc8F64AY4ClKOZ57H752FromtIgF867LphH
         b18kuz55SS2XB4ebJYN4Aubfk7qyiJDf4yh3CPXiKTclhbTVy9ff3QDWkhBhG3BCMtb7
         LbKhPIYGin3uWRZn06Ft0Hq+pYUHnfBVBRnZY4PW4q8kuP89d4KC+f4WgT8+m7trxPLy
         sv9w==
X-Forwarded-Encrypted: i=1; AJvYcCVU3kq8PzzaOaS1YxdeR+1xEDOD/5D2wr6WnFZ04eBH2ffam0I9/ocLrkOjJyF9Yy9yPNnEOH5P+LLM5zjJcEmPDBjl1eNe
X-Gm-Message-State: AOJu0Yw3uzdPj9J3NVfGC+Qdkhb/Ieb159kiKiGtmQj/zgN2iJIQyJaW
	0W/EbW2Hx5qPqf9e3X/8aI2r+fS8ZL/ERX7xQBz753Y8Gle5xtrHLQbqoE/Ybk8=
X-Google-Smtp-Source: AGHT+IEQq6YNWa7x/qG2lhYwxS9LQL2TDlJNLLtmnR+0fXmuY9dNZ7lFwLOhObs5pdsHmSIE7eyCDA==
X-Received: by 2002:a17:906:fcc5:b0:a68:bae4:94d3 with SMTP id a640c23a62f3a-a699f680343mr167106966b.8.1717587920537;
        Wed, 05 Jun 2024 04:45:20 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::8090? ([2a02:8109:aa0d:be00::8090])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68fa49e66fsm491263966b.129.2024.06.05.04.45.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 04:45:20 -0700 (PDT)
Message-ID: <395ffca5-20b3-43fe-b443-7055eba574fc@linaro.org>
Date: Wed, 5 Jun 2024 13:45:18 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm64: dts: qcom: qrb2210-rb1: switch I2C2 to
 i2c-gpio
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Alexey Klimov <alexey.klimov@linaro.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240605-rb12-i2c2g-pio-v2-0-946f5d6b6948@linaro.org>
 <20240605-rb12-i2c2g-pio-v2-1-946f5d6b6948@linaro.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240605-rb12-i2c2g-pio-v2-1-946f5d6b6948@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 05/06/2024 10:55, Dmitry Baryshkov wrote:
> On the Qualcomm RB1 platform the I2C bus connected to the LT9611UXC
> bridge under some circumstances can go into a state when all transfers
> timeout. This causes both issues with fetching of EDID and with
> updating of the bridge's firmware. While we are debugging the issue,
> switch corresponding I2C bus to use i2c-gpio driver. While using
> i2c-gpio no communication issues are observed.
> 
> This patch is asusmed to be a temporary fix, so it is implemented in a
> non-intrusive manner to simply reverting it later.
> 
> Fixes: 616eda24edd4 ("arm64: dts: qcom: qrb2210-rb1: Set up HDMI")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/qrb2210-rb1.dts | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
> index bb5191422660..8c27d52139a1 100644
> --- a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
> +++ b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
> @@ -59,6 +59,17 @@ hdmi_con: endpoint {
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
> @@ -199,7 +210,7 @@ &gpi_dma0 {
>   	status = "okay";
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

