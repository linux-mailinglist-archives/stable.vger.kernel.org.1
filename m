Return-Path: <stable+bounces-4836-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB63806F8F
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 13:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8808D281B76
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 12:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD63D364BE;
	Wed,  6 Dec 2023 12:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PF1ziB2S"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB57D3
	for <stable@vger.kernel.org>; Wed,  6 Dec 2023 04:20:01 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c9f8faf57bso51159111fa.3
        for <stable@vger.kernel.org>; Wed, 06 Dec 2023 04:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701865200; x=1702470000; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+i4Ygk68LEIXvF8ovwCDnUeBvBPCrOF9ltM3kyzBELs=;
        b=PF1ziB2SIg4qc/OE5MV0auQAj/lWiY3/ZBafxRKxFSVH/WUD9JzLLdMy8jDb9/DnMB
         5MADX6vbvWyhfx1It6PvZJe+qhOp4apenPvNou5cm1WnhCHAgz8GptVOxlPD85FK1n+K
         ptDipsmIuNCrM8f1BH0wh7XiMM1VlkdkAsw5jVfcMmP0akwDye0CXlcfZdhbA1bkxHFK
         /bcRZuB+/9UtwphSDtzxTGd/mvkrgilmrBmwe76Rk7u0bKT7TP2Q8USQzz/eh1S6+m2L
         nYlsfnBnfTyBRQA3MWRH1i1pfXJNmILB3LZ3yxq21FZcQdMT6i8VAA/Oa4fdnh1/xa9M
         ezWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701865200; x=1702470000;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+i4Ygk68LEIXvF8ovwCDnUeBvBPCrOF9ltM3kyzBELs=;
        b=TwajJG7Dc+bICbqRApv/3e+A4hTf60TcjAEcW7zlQdFhZCQIiC0qtKmvgPUWShVO/+
         MGUSnKWNrBOaBHg7yePHUJIO4nXvSO7ZS9PKDKMkqjLIiMZScp3Nr2iwRyzXaLGkBGta
         C4LOzJUC+qYXeF1aIu0GAYaNeoR4C8PVrq8j/cIzbnYQbRIwjO+mzVXXqM3PyB5+y9qR
         smYELgESRIpu0b+09enrqVlYCL6UGYPoO6MogtGAhAcEOqLdiSKLZsASuPnk5rLGvvaM
         9nT2yKQRfpfVSXSyve0A2yhu5Dx+UO3w2kaXfbmPIPbJPgq3NmbtyH+JhU4c8F4w7AHe
         pgZA==
X-Gm-Message-State: AOJu0Ywe3ia0OP8Hl6CzJZdV1IRDvrb3MY5lTA6QLG1fa3NVgV5B2tbo
	8TvTyKW5nD6TGy/C+GQ2J5f3bg==
X-Google-Smtp-Source: AGHT+IGDUAakGvSrTeFgi2nx9gIOE1y209ymR5Qb+p1nSlHQs/zqcKybiK8Xz1Q0AbYMBjC+NnL+xQ==
X-Received: by 2002:a2e:3514:0:b0:2ca:18de:5c63 with SMTP id z20-20020a2e3514000000b002ca18de5c63mr553729ljz.72.1701865199839;
        Wed, 06 Dec 2023 04:19:59 -0800 (PST)
Received: from [172.30.205.186] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id z23-20020a05651c023700b002c9f8d8e5f4sm1209955ljn.41.2023.12.06.04.19.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 04:19:59 -0800 (PST)
Message-ID: <81b4f158-41e7-43b6-a762-1a05a0994d6e@linaro.org>
Date: Wed, 6 Dec 2023 13:19:56 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT] interconnect: qcom: icc-rpm: Fix peak rate
 calculation
To: Bjorn Andersson <quic_bjorande@quicinc.com>,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Georgi Djakov <djakov@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20231205-qcom_icc_calc_rate-typo-v1-1-9d4378dcf53e@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231205-qcom_icc_calc_rate-typo-v1-1-9d4378dcf53e@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: *



On 12/5/23 23:14, Bjorn Andersson wrote:
> Per the commit message of commit 'dd014803f260 ("interconnect: qcom:
> icc-rpm: Add AB/IB calculations coefficients")', the peak rate should be
> 100/ib_percent. But, in what looks like a typical typo, the numerator
> value is discarded in the calculation.
> 
> Update the implementation to match the described intention.
> 
> Fixes: dd014803f260 ("interconnect: qcom: icc-rpm: Add AB/IB calculations coefficients")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
> Spotted while reading the code, patch is untested.
> ---
>   drivers/interconnect/qcom/icc-rpm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
> index fb54e78f8fd7..a8ed435f696c 100644
> --- a/drivers/interconnect/qcom/icc-rpm.c
> +++ b/drivers/interconnect/qcom/icc-rpm.c
> @@ -307,7 +307,7 @@ static u64 qcom_icc_calc_rate(struct qcom_icc_provider *qp, struct qcom_icc_node
>   
>   	if (qn->ib_coeff) {
>   		agg_peak_rate = qn->max_peak[ctx] * 100;
> -		agg_peak_rate = div_u64(qn->max_peak[ctx], qn->ib_coeff);
> +		agg_peak_rate = div_u64(agg_peak_rate, qn->ib_coeff);
Oh fun.. I'dve assumed the compiler is smart enough to catch this

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

