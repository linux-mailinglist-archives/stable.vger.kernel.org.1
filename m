Return-Path: <stable+bounces-6634-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F83811D3C
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 19:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ED9D2821EF
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 18:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDD361FBF;
	Wed, 13 Dec 2023 18:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vebi432v"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14C8EA
	for <stable@vger.kernel.org>; Wed, 13 Dec 2023 10:47:03 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50bf3efe2cbso8433633e87.2
        for <stable@vger.kernel.org>; Wed, 13 Dec 2023 10:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702493222; x=1703098022; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D9pRN652Qjyr+bUpPGngJiTKRnZ3pLNOirbLUeYcKaE=;
        b=Vebi432vX0Le/x7Us8oanXhjU9Ua4FaNL0hDw0WBJ/PHuVqOr05mCJRNjQAstuN9k3
         4JuHcHTYkK55eDFYxo4DP2XGohm7BgoS2OJW2Sf5ad/Y+F5f6vFghid7dAzcw3DJDC01
         ww3VI8XIPuR/VEFkeRqh6Pa16dOmmDM/2dMM1+nglvk/13yq/5SLBcftCJlEbjWOnxBe
         3BgWK8XM/EZY9cWCeajfRdFlJruaC1qX+dIpdkTiu9quIdQe22dJ2DEq6qTaXEj3zvBE
         6M1m0eWhh1Pfdyhwqaf0lVQ1LAIFJvnEHLlgZ2j0tJ65kcyAoyHl1jn2Ht06nhixBAWJ
         XTNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702493222; x=1703098022;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D9pRN652Qjyr+bUpPGngJiTKRnZ3pLNOirbLUeYcKaE=;
        b=kFTR8ZVKvTAD1BKfX9reqHK4930OoFB6IYNlREPewgGDKG7tAYeKFiEBCocIkMMAMP
         gBdOSCINidiUB7OnW6SoYbEgdF6YcEdsBagf90IU8W1JYnxzjU51CiiH0SI3qbDKAbVL
         ZTg+Bi6z6mosxwDiurGtBH7Xru3thLxTVpNJIBwdOwlWAAgt7bDcQlKJ7VZ+m+lLekf2
         +Kq0qhRFltPzz7/2risVApg5nt6dHsM71AgJgB1sp0l6atwuh+TDN+wMTRxYUMI3Fmq+
         t8hmuIcI1Q00B1ua/TpfUOM8b9XReZ2F2E1xth0e38CvUIVeHIRmzjqpBtLNX7vD9Hf8
         yLWQ==
X-Gm-Message-State: AOJu0YzWKzp6MTN6n8YQCrynXgjp1E9QUiZ0c0pXkGAF3Sv54Nm74nfa
	c6c3rjS+w60vJkw3+szTQLY5SA==
X-Google-Smtp-Source: AGHT+IGdLUVASkIbLTRMFB5Hpp0dA3qXNw+0b/Naa+lZJ8p5ZeeCweWZkm2OE49WwXdI3JyMdWp0rQ==
X-Received: by 2002:ac2:4a6e:0:b0:50b:f06b:7aff with SMTP id q14-20020ac24a6e000000b0050bf06b7affmr1685913lfp.233.1702493222048;
        Wed, 13 Dec 2023 10:47:02 -0800 (PST)
Received: from [172.30.204.126] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id f12-20020a19ae0c000000b0050bdf00f688sm1653687lfc.299.2023.12.13.10.47.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 10:47:01 -0800 (PST)
Message-ID: <b319bae5-1253-471f-a022-4d1d2425e213@linaro.org>
Date: Wed, 13 Dec 2023 19:47:00 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] ARM: dts: qcom: sdx55: fix USB SS wakeup
Content-Language: en-US
To: Johan Hovold <johan+linaro@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Manivannan Sadhasivam <mani@kernel.org>
References: <20231213173131.29436-1-johan+linaro@kernel.org>
 <20231213173131.29436-4-johan+linaro@kernel.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231213173131.29436-4-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/13/23 18:31, Johan Hovold wrote:
> The USB SS PHY interrupt needs to be provided by the PDC interrupt
> controller in order to be able to wake the system up from low-power
> states.
> 
> Fixes: fea4b41022f3 ("ARM: dts: qcom: sdx55: Add USB3 and PHY support")
> Cc: stable@vger.kernel.org	# 5.12
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
Matches the downstream kernel too (as it should!)

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

