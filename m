Return-Path: <stable+bounces-204453-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F9BCEE1A5
	for <lists+stable@lfdr.de>; Fri, 02 Jan 2026 10:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ADCC63003BDA
	for <lists+stable@lfdr.de>; Fri,  2 Jan 2026 09:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68572D4B68;
	Fri,  2 Jan 2026 09:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z6YsgHnW"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A43A4C97
	for <stable@vger.kernel.org>; Fri,  2 Jan 2026 09:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767347373; cv=none; b=mNPRT5MtUb54NrVaiWit50PP+TVVJ6O5bJcXJPMLqrf/n0v4ei3BPiLBa1y3HW54zg06stkcJP+7lkJkhnONwBdZOL7bwtKIiqdYq1jdJ6l161x81XD/TtlGO0T9L/lwxnUkC3+ygt4UphTWC6neCVBIDrMCrbgO3eZ49spLmhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767347373; c=relaxed/simple;
	bh=slFegTz3P/JluIXvMbOc1Pvvjimz+yXm422YyUVjw0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p1eg35zqAh9ULRks0pUF0ZyMivE5AqVEGfDpoAtFmo4Eig5YFt+Hj9XwqSSqVC8zePxIBhMRJDIezh/ZrXomTyVPJ1NSKzELXyXcMtu5ve3LU9kDrZrKx3bkXrBMiMA0BraCrgZ1qIG+UKpTVkEJGDAhnaNZkg2ioNDLk8FhRDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z6YsgHnW; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-64d80a47491so17914007a12.1
        for <stable@vger.kernel.org>; Fri, 02 Jan 2026 01:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767347370; x=1767952170; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BsVkQf9vQJk/04twE5FzoYDgeZD8nWuhZIHPbDLZt1o=;
        b=Z6YsgHnWKkFUE+jv0NUGas+KtUxvsImT+RQMwvkCiPlNL+Rb3J53VQsSiI5sKuM/fP
         lLrJRX1woAScvzKgUM3sJEIB6CxamQjxtyIR/pHIXO8elG0rnRVP7V4dVBJxFHRmZuSZ
         CGCCOQztRS9BGhS2hOaYuFB/hUSTpMZ2qZ+AL0h62O1EnRD6lmGAx8mX+j0d3HdYn4Xp
         4bFwZMpbOqUMMZJJGr6/YNisgIq0gbo8uNZDjC8GUNKR5F1dkDoiVKizRcza61Bn7o+n
         NsjFq04/e0RTmMo99Xx8X9u7xtG4rQofFKutWNZ9FFEyffyrt/5k0f2SkiTcSDjP41hQ
         mC+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767347370; x=1767952170;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BsVkQf9vQJk/04twE5FzoYDgeZD8nWuhZIHPbDLZt1o=;
        b=oo/MqXOfDidytyHNXgZkkXVyoSShVnMB0/ds7mNjn3rhxCVHK1s9FeA5dS9nLKKeoU
         3kTg6qqoXI0AxxYxwz9WlZQDbea43Ylqk7kyuKHyuxbuDb/P3X+a5tUQ3GS7+rrumDiU
         NKqWjSZE+/OEhjTZX+KZYd9pJiLeuqg9bbPoNIgsSzliHOtNuOwk3dF0RB6WzY50Udxd
         Ml2kt3Lqdv5+kavyhbyVFKWvihl+rbjhnf36SCg3qn6zWMTdmwtGtp7C09osIi4vut86
         aal4Z9kOl/NwYgHPlByNINqlw9u4COp5IJ7jsajLSQkz0LSpcvgY+65MJGdEJxIH4Ggl
         UL6g==
X-Forwarded-Encrypted: i=1; AJvYcCW0jCGWB+3hxghaTYDwEo0ko/g6sgaynlKe7UMCLf7hJk5ukkNCqX1EcEFgiZznU4KwNXgl77M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6anV0ncGoIe7+8ucp2kaF8OoBI8Y++47b+dk6NZSKy8P/zBd8
	gG/zsAiOv7hxzUFo1CU3ILzPjc9CSbO8u5I4w8JYqkdIAsX6L4FVgspY8kigvo9j4j0=
X-Gm-Gg: AY/fxX6apT0S9I4ueQvlMpucq1RmLWpLBY9SG26R3Ejppzfc7q5heDki6miuEhI4eZG
	46VWcgFLHmV4U0fwsFX3lRyHZSIzxkItkZlBpcpPW6wKbDWu8iUSI+hqn5vZRk9S8EqqGQwVjV2
	ngE68Idcs31dsu2+q1sQZaC6iryisV81yrTIB6VDD5y19CmDxkQPreyczIW6CWENFd7bzR+VAvQ
	pVOlMSp/ITvi0D6LDRFy0zWbsv3kWiSiT66Qi6SaJq4ALz5DSvsUMwpIT+kiWVXlMkcF33LCkEl
	Ewc9A1pJ8lznD3r1lpM7wX8K6M59Ac6H8Uy25vTfLKaTEwwPFtYjdoZuefU7Bv+D+lW66QPlKvk
	PYavWmXF3P2Xo43G4+JLy3RjIsqs4O6XAMseJA08ckf4NzOazk2I1yuM4lw6lard5zz1nNHZYmq
	gj7zJaddwNkNyCO5eAf8i4C92vXBSUMZ1SEJDN9Yot25W2+bdDYR0gl2nWZPVoNXckOOGOllKDs
	QlxXGGMBie3DOSZsD7RDL0x3o01VysJC6oLg8MyhIB5ARnLG0KFTj5O7EPbU/DhG4Yt17T5weq/
	PHRIev5bn8k9
X-Google-Smtp-Source: AGHT+IETWYWx735xjxVe/6RROWIkDsSn4NVtXPCKugmKHVhMX7CMbKQDhu4KgO1/800miWdtKnSrDA==
X-Received: by 2002:a05:6402:50d1:b0:64b:4617:7717 with SMTP id 4fb4d7f45d1cf-64b8d24ebb3mr43849047a12.9.1767347369962;
        Fri, 02 Jan 2026 01:49:29 -0800 (PST)
Received: from ?IPV6:2001:1c06:2302:5600:7555:cca3:bbc4:648b? (2001-1c06-2302-5600-7555-cca3-bbc4-648b.cable.dynamic.v6.ziggo.nl. [2001:1c06:2302:5600:7555:cca3:bbc4:648b])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b91494cd7sm42644033a12.16.2026.01.02.01.49.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jan 2026 01:49:29 -0800 (PST)
Message-ID: <08e380fe-91e5-49a4-8fc0-8ec64a7c89a8@linaro.org>
Date: Fri, 2 Jan 2026 09:49:26 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] clk: qcom: gcc-x1e80100: Do not turn off PCIe GDSCs
 during gdsc_disable()
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
 Konrad Dybcio <konradybcio@kernel.org>, Bartosz Golaszewski
 <brgl@kernel.org>, Shazad Hussain <quic_shazhuss@quicinc.com>,
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
 Melody Olvera <quic_molvera@quicinc.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Taniya Das <taniya.das@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Imran Shaik <quic_imrashai@quicinc.com>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, Rajendra Nayak <quic_rjendra@quicinc.com>,
 manivannan.sadhasivam@oss.qualcomm.com, stable@vger.kernel.org
References: <20260102-pci_gdsc_fix-v1-0-b17ed3d175bc@oss.qualcomm.com>
 <20260102-pci_gdsc_fix-v1-6-b17ed3d175bc@oss.qualcomm.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20260102-pci_gdsc_fix-v1-6-b17ed3d175bc@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/01/2026 09:43, Krishna Chaitanya Chundru wrote:
> With PWRSTS_OFF_ON, PCIe GDSCs are turned off during gdsc_disable(). This
> can happen during scenarios such as system suspend and breaks the resume
> of PCIe controllers from suspend.
> 
> So use PWRSTS_RET_ON to indicate the GDSC driver to not turn off the GDSCs
> during gdsc_disable() and allow the hardware to transition the GDSCs to
> retention when the parent domain enters low power state during system
> suspend.
> 
> Fixes: 161b7c401f4b ("clk: qcom: Add Global Clock controller (GCC) driver for X1E80100")
> Cc: stable@vger.kernel.org
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>   drivers/clk/qcom/gcc-x1e80100.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/clk/qcom/gcc-x1e80100.c b/drivers/clk/qcom/gcc-x1e80100.c
> index e46e65e631513e315de2f663f3dab73e1eb70604..d659d988660ea5e548fcae6f9f2a9a25081e6dda 100644
> --- a/drivers/clk/qcom/gcc-x1e80100.c
> +++ b/drivers/clk/qcom/gcc-x1e80100.c
> @@ -6490,7 +6490,7 @@ static struct gdsc gcc_pcie_0_tunnel_gdsc = {
>   	.pd = {
>   		.name = "gcc_pcie_0_tunnel_gdsc",
>   	},
> -	.pwrsts = PWRSTS_OFF_ON,
> +	.pwrsts = PWRSTS_RET_ON,
>   	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | VOTABLE,
>   };
>   
> @@ -6502,7 +6502,7 @@ static struct gdsc gcc_pcie_1_tunnel_gdsc = {
>   	.pd = {
>   		.name = "gcc_pcie_1_tunnel_gdsc",
>   	},
> -	.pwrsts = PWRSTS_OFF_ON,
> +	.pwrsts = PWRSTS_RET_ON,
>   	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | VOTABLE,
>   };
>   
> @@ -6514,7 +6514,7 @@ static struct gdsc gcc_pcie_2_tunnel_gdsc = {
>   	.pd = {
>   		.name = "gcc_pcie_2_tunnel_gdsc",
>   	},
> -	.pwrsts = PWRSTS_OFF_ON,
> +	.pwrsts = PWRSTS_RET_ON,
>   	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | VOTABLE,
>   };
>   
> @@ -6526,7 +6526,7 @@ static struct gdsc gcc_pcie_3_gdsc = {
>   	.pd = {
>   		.name = "gcc_pcie_3_gdsc",
>   	},
> -	.pwrsts = PWRSTS_OFF_ON,
> +	.pwrsts = PWRSTS_RET_ON,
>   	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | VOTABLE,
>   };
>   
> @@ -6550,7 +6550,7 @@ static struct gdsc gcc_pcie_4_gdsc = {
>   	.pd = {
>   		.name = "gcc_pcie_4_gdsc",
>   	},
> -	.pwrsts = PWRSTS_OFF_ON,
> +	.pwrsts = PWRSTS_RET_ON,
>   	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | VOTABLE,
>   };
>   
> @@ -6574,7 +6574,7 @@ static struct gdsc gcc_pcie_5_gdsc = {
>   	.pd = {
>   		.name = "gcc_pcie_5_gdsc",
>   	},
> -	.pwrsts = PWRSTS_OFF_ON,
> +	.pwrsts = PWRSTS_RET_ON,
>   	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | VOTABLE,
>   };
>   
> @@ -6610,7 +6610,7 @@ static struct gdsc gcc_pcie_6a_gdsc = {
>   	.pd = {
>   		.name = "gcc_pcie_6a_gdsc",
>   	},
> -	.pwrsts = PWRSTS_OFF_ON,
> +	.pwrsts = PWRSTS_RET_ON,
>   	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | VOTABLE,
>   };
>   
> @@ -6622,7 +6622,7 @@ static struct gdsc gcc_pcie_6b_gdsc = {
>   	.pd = {
>   		.name = "gcc_pcie_6b_gdsc",
>   	},
> -	.pwrsts = PWRSTS_OFF_ON,
> +	.pwrsts = PWRSTS_RET_ON,
>   	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | VOTABLE,
>   };
>   
> 

Retitle patch "Switch PCIe GDSCs to retention mode" you're really 
telling firmware to switch these GDSCs to retention mode in suspend - 
"power collapse" might be a better word.

Anyway I think you should switch from a "don't switch off" to a positive 
and more accurate description of what you're doing which is switching 
the GDSCs to retention mode.

With that

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

For the series.

---
bod

