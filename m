Return-Path: <stable+bounces-50412-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F985906573
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 09:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EED85B24689
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 07:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A70F13C9D0;
	Thu, 13 Jun 2024 07:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O6GWlopt"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128F913C8F4
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 07:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718264589; cv=none; b=Rwi0jOAHNxSiA86bo9z7ldXwMz9hPrQCozUR+ObTFgfNVoQkOqSRbcResx65/luaChxgfOvlmWkrdrRwAbcLIXrbHmdNT+tUiKk6Qdsaww/S7FDi2punh9Vvcfe1iG0vev+LrnPsujyPa76+sKlheAqb1oiCMoDy4wotRuGTje4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718264589; c=relaxed/simple;
	bh=Oh2VIm7LM70YX19wn1LBpKXluX+l95XGAHjH23O4UWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UN+mnIhkKiHWitQXnButog0KW4v2nLj+ocEyz43ApgtSnbAnyNNj5APqLd6T9y2qk4HYHrGpTtEb77upDSE6bWGyIa7BnnNsUYHuWlOBedq1FNJJ2ULJPohLE1hBfIHIjXm118YKiEDN1/UfoOCSRaCb4pDHg7EsS9M4wNQuVE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O6GWlopt; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52bbdb15dd5so903267e87.3
        for <stable@vger.kernel.org>; Thu, 13 Jun 2024 00:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718264584; x=1718869384; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wZOybXwAmI6sCFAiKuwFaCnejrVzOy82tLHhHkRl/yc=;
        b=O6GWloptzZVIlynNBd9b1HYPFeqt0Y/O+DMoS9thPxUFjzdPOUOghummvAFI+Vu70C
         w7LVh/Gjnbf2b7alzSCo09ExJwbuRmMHjcq9zHRhc7E5KKeRa/uuycxqSzjLi47b41RS
         N3p0TTeC0UFJ64bbTwuSruSuUz4cyZsXekUY7PJMbxAisLXeenuP/xBfcPdFwyMWtKiT
         1q4+1TEMCdjfqiRspbiDX5ihBOlD5fqJs8EXzTQTUF834OGqLLVB6+o1XxpYi0HMB6Cd
         XrSsBnzA60Yok6B0geWeD2hevMQnVMpzx8MiLYce5VF3i9ng00fVWBINwRVbudezgUsV
         1UoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718264584; x=1718869384;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wZOybXwAmI6sCFAiKuwFaCnejrVzOy82tLHhHkRl/yc=;
        b=SHYTFGIPpg4kSBDApXK/UzoTksGQXw6QOWtOcKezS9kCkQt1NdrQWAd4lgOEXT9t+i
         BLYpZWd+h86p1QPyOsP2Fq1ib2X40YQ34x6VJnuVHbHxhrGpXVkgkM1+2zMlxFBnlk1c
         Vf0zPcFBjewYBSYgTX5BM+oFDi0cKj6qzELj3ZEgUW54u3P6DLfhIDwHIJQFpHQOtjow
         9b2Tob3eGN9C7WvKntal2qai1Y+HWPB2kEZhI6GZJYp5USJRnkeRbmmlGpP3GxG3a5+g
         /thPmRoRFC+DeAXr8kc2JPejg7cSuu5C4E8JEvgKVCrHUTeetazATFmL4UjkXtGlna+R
         Ne7w==
X-Gm-Message-State: AOJu0Yy9/HUGw92yI21BMiXk/F+VSVnVJkUYA6picir8nV06i2w5Iw96
	jJIfuSbhgksO95juFwJqvamv6rwvWqc8iFjtJjtH0/wsiGfeoYB+9gGH1nvzIi8=
X-Google-Smtp-Source: AGHT+IFe/gSwHRfx1q7ZYMPUTWA0VfmkZpZ1Y1lZIoSjnPH4fuB+TI++MzvmI2FSLoRbqfPZzNXVvQ==
X-Received: by 2002:a19:7513:0:b0:52b:c14d:733c with SMTP id 2adb3069b0e04-52c9a406a18mr1685954e87.68.1718264584176;
        Thu, 13 Jun 2024 00:43:04 -0700 (PDT)
Received: from ?IPV6:2a00:f41:900a:a4b1:c71b:4253:8a9f:c478? ([2a00:f41:900a:a4b1:c71b:4253:8a9f:c478])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca28723a4sm113108e87.145.2024.06.13.00.43.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 00:43:03 -0700 (PDT)
Message-ID: <10fd543e-7b3b-48ef-9a09-acf8d17662a1@linaro.org>
Date: Thu, 13 Jun 2024 09:43:01 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: qcom: x1e80100-crd: fix WCD audio codec
 TX port mapping
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20240611142555.994675-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240611142555.994675-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/11/24 16:25, Krzysztof Kozlowski wrote:
> Starting with the LPASS v11 (SM8550 also X1E80100), there is an
> additional output port on SWR2 Soundwire instance, thus WCD9385 audio
> codec TX port mapping should be shifted by one.  This is a necessary fix
> for proper audio recording via analogue microphones connected to WCD9385
> codec (e.g. headset AMIC2).
> 
> Fixes: 229c9ce0fd11 ("arm64: dts: qcom: x1e80100-crd: add WCD9385 Audio Codec")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

