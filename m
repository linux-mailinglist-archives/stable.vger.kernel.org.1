Return-Path: <stable+bounces-6756-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E49813949
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 19:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C1C31C20D48
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 18:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572AB67E88;
	Thu, 14 Dec 2023 18:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XGKsI3FT"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106C112C
	for <stable@vger.kernel.org>; Thu, 14 Dec 2023 10:00:01 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50bf898c43cso8237137e87.1
        for <stable@vger.kernel.org>; Thu, 14 Dec 2023 10:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702576799; x=1703181599; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RNzrB1u5cdRIIUK1CjwOMqB3675QEed56fbMDtEebUE=;
        b=XGKsI3FT7JIi0JWcFzEFUbQPJvzz75eMCPzpKa4UvycGG277rzUtsMeK3PzZjkWbiE
         j1WiH5j5/s2RpnqoHg0jOQREJpZOH4iEL/kD3S4OM3P6CnwJbGqzLTZDJhv0TK5ra19E
         ccIkwNspOxm16VzP8blEk+7ISvIacIeUiTrxE0sy01+kgXxFXntIa1QSgkMeVemHEMgi
         ms3vnywwHktq/9EJnC99pZ1zfpFfJbXQ15qPy7CLVEPC9vHyJm1omMn35nzquNKQRySL
         NJDxhWGOsucxXZyYOxXuwrYloKgr5XDmwtZn42weLqpp3WFYCGgoMg4Qe3YwSSy9uPdS
         vdMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702576799; x=1703181599;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RNzrB1u5cdRIIUK1CjwOMqB3675QEed56fbMDtEebUE=;
        b=qrsL8XnHIJL5XE3dvRLmhMuvCjsy+iDTsPwJYKv9Eqsyj6WvAG1Jt3Q8XKg9p2vWJn
         dbbcNQKb4zrDrtIbyvMPmVuHJi3zt86JzWS4dBsiC/D58yHAjgjp5UXlouuuw86g1QbD
         15TianrwSE0RUIFjVDJVSq+AAD65uWz9znIx7sqk8a3odMbYgwet1amlImiOlh1sRfap
         5C4E7BLWQ/JLCigH7otS4bNdzHBUOLwo0nORK8KK4ABUgYxPkHzBSST56r0NQhs+4LVf
         Uw5Q54wE03ePhpMOvW0SWG++yvbTrz9Upk0tYFHr4Bnsw1aTQW+cqoZrMBaA8tD+jHSa
         7IBA==
X-Gm-Message-State: AOJu0YyQRLgdN1q/5gWb8CJ8MlV06jbgjvmH5KEVuiYSg4ODvQiVV/Dz
	ASbjljg0z0qvS95f46mnCP6uGA==
X-Google-Smtp-Source: AGHT+IHR/BseF81sooOcwETh42XcEmC8wRC2CR5cbiuzH8kZrhbG0bSYS5JqYImuWrYkNYE76VTFMg==
X-Received: by 2002:a05:6512:3d9e:b0:50b:f269:64df with SMTP id k30-20020a0565123d9e00b0050bf26964dfmr4185701lfv.105.1702576799237;
        Thu, 14 Dec 2023 09:59:59 -0800 (PST)
Received: from [172.30.205.72] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id k13-20020ac257cd000000b0050bff2648b9sm1919173lfo.203.2023.12.14.09.59.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 09:59:58 -0800 (PST)
Message-ID: <bba0160e-e495-45a3-8958-fba380e5a98c@linaro.org>
Date: Thu, 14 Dec 2023 18:59:56 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] arm64: dts: qcom: sc8180x: fix USB DP/DM HS PHY
 interrupts
Content-Language: en-US
To: Johan Hovold <johan+linaro@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Vinod Koul <vkoul@kernel.org>
References: <20231213173403.29544-1-johan+linaro@kernel.org>
 <20231213173403.29544-2-johan+linaro@kernel.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231213173403.29544-2-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: *



On 12/13/23 18:33, Johan Hovold wrote:
> The USB DP/DM HS PHY interrupts need to be provided by the PDC interrupt
> controller in order to be able to wake the system up from low-power
> states and to be able to detect disconnect events, which requires
> triggering on falling edges.
> 
> A recent commit updated the trigger type but failed to change the
> interrupt provider as required. This leads to the current Linux driver
> failing to probe instead of printing an error during suspend and USB
> wakeup not working as intended.
> 
> Fixes: 0dc0f6da3d43 ("arm64: dts: qcom: sc8180x: fix USB wakeup interrupt types")
> Fixes: b080f53a8f44 ("arm64: dts: qcom: sc8180x: Add remoteprocs, wifi and usb nodes")
> Cc: stable@vger.kernel.org      # 6.5
> Cc: Vinod Koul <vkoul@kernel.org>
> Reported-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Tested-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

