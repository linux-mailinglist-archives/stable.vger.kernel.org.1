Return-Path: <stable+bounces-93070-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FBE9CD527
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 02:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21EECB236BA
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 01:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D5D13A244;
	Fri, 15 Nov 2024 01:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ynZoiBwW"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65B33307B
	for <stable@vger.kernel.org>; Fri, 15 Nov 2024 01:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731635235; cv=none; b=rAE4M5qWrQAJlOscL0DBuiHcvaiJnHpRpOuBVZ/bPrnEo8ogSD8FAk7/9eewRwxNuque9MBRmqyiT931tJLjxq5F4cnxx9GnVXnN0zsRltWQAyT6AfO22LEoG69nDoD2Q24RKSpr0Kvv4diViSboB7jAp862KyKdCPgbqXzo3YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731635235; c=relaxed/simple;
	bh=Vt5BKSGnVSO1wERPKQPDulTkD92E+F5ePSF0pjjU0rQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ijPNfNambLZ+f2V2yq1BVQ3ZzQf/+c5WpAkMQd0oo6BoAsFMdKjtGCUR/LCR7A1AfpwzIw6vqyaGPcOojs3s0bfXv9poIFr7JEyL3LKizGc/dZxq2U+RpjmmGZso5g6+KwcqIS6+1SwYMA9O5kOhojUk2vJw/FW2Czs4vERtFlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ynZoiBwW; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539e83daa12so149206e87.1
        for <stable@vger.kernel.org>; Thu, 14 Nov 2024 17:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731635231; x=1732240031; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WlZtJEFuE3UKpvbYIEqSVLfZBwjcDIGJk/mPflIrqmI=;
        b=ynZoiBwWQgRaGjpRMP2rwT4iu9RuPw2jNDFkDUPTXMXv15PNhvy6RfjcOVhdTHvW6G
         4+CKwo8Pf/uTqJ4h8HT37DC0FuHFZl4lcgKPApBgbWvE+QZ3LxXHbrbYTjgoJG1cVKGV
         NcG1WgY8S4+Gqx1QRFIgbYhCSbOFBhiNG837RLbUr9OEAjxavXo+NGPbK948/Qbcf52h
         Ry/QSHO1TfjhUeEqhlWb3Yv90qufORUHTY2YWE1S1Y12L+7JaZcOb6XxSURh+VbP2MAn
         Ph8Sk5Nu8cHzBjzV6B8I0jXitQ4ii+1/G4+O9V7vewm+tHN5SxhuiDwsjjGD4/qsx+3N
         5lSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731635231; x=1732240031;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WlZtJEFuE3UKpvbYIEqSVLfZBwjcDIGJk/mPflIrqmI=;
        b=qQpx4RpepEGlbS3F1oopSv1edXkUm4TqY+V06mhRweuDmVNVvT0g2BnZV2n+/5s1Q0
         WeSv3lViOgy3ZXOczYopKt9DDkssgBH4ZZhdw8x0MahjiTaqmeJeUCSBLo0yxOkEYGLV
         Xyj9zYjWPcCYl80fJ4Wm2H9R0wptzOsqUzmHLizEjyqPnjwQn7hhXoYOdLgYZ1C1sKX0
         oTmsn75UIyEKwpPxkUihcPdeMrXLQBmHmqN8mi8XEKb49FtJbsl6Mszyx/s7WSSxnPxv
         QR9U1hGzAmlWqNvyvDu66tCaxePf56orn7JolvbNNXxhBVjfU8ZnVrzdfGnhXGPL00Qd
         871A==
X-Forwarded-Encrypted: i=1; AJvYcCX9TSy1HnWe1UHW2ezGvpuO2KWoh3Q4jft/5/k0xpU82NJ5nMWoV4K+RF5Yf1wT5Vd8d9GLVIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsWk+SVyq9kf9R19PFLokz+y0IhKxnXYHhQBBz5Vgt0AW+rTJI
	WWdMUZz1pql335a9QM5F0qi9ESyPbwVMmNEfNCBZNH9FlGIZhddt/g00REB5LHw=
X-Gm-Gg: ASbGncsR/0GrmPoL2fwYnwUe0s9/EGpph4X/+MT2ZpKFxr19Rn7fkDYVNTaA/XuGDkW
	C+CbKiAG3mBRBPcG+KnpxX4G9WLTjyxhsjB0npYHLEdaT+bwz74lXZDIn8bU7mGTNX1AN/KG3P9
	lgXqEQIb3Bv+fYpbhY30WfuDJoPHArFfGCsieMHTLHwUSLcdOf6UoEr4haN10P9Ym8q22iuEQcO
	j4TVUOk0kQW+WuIulxo7IIUuuco7XJplZQi2+gbGrECsCgkK/2EN1KfmhAhrs7GSUBuNhSNDvTp
	UIukzcjb9SguFBF/E/m97udXIwk4
X-Google-Smtp-Source: AGHT+IEQjqO83cHFzO/xhdQPIAupPGyCJ6+MgojLBINDYK0Ken0N/7ofXhoTPAECXylvuwdADYNyGg==
X-Received: by 2002:a05:6512:3c87:b0:53d:a5f3:a561 with SMTP id 2adb3069b0e04-53dab25bbc3mr106471e87.0.1731635230804;
        Thu, 14 Nov 2024 17:47:10 -0800 (PST)
Received: from [192.168.1.4] (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53da6530b41sm376971e87.136.2024.11.14.17.47.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 17:47:10 -0800 (PST)
Message-ID: <b3e38b04-0ca9-4022-af73-9feab6f151f1@linaro.org>
Date: Fri, 15 Nov 2024 03:47:08 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: qcom: camcc-x1e80100: Set titan_top_gdsc as the
 parent GDSC of subordinate GDSCs
Content-Language: en-US
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Abel Vesa <abel.vesa@linaro.org>,
 Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20241114-b4-linux-next-master-24-11-14-titan-gdsc-v1-1-ef2533d487dc@linaro.org>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20241114-b4-linux-next-master-24-11-14-titan-gdsc-v1-1-ef2533d487dc@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/15/24 01:32, Bryan O'Donoghue wrote:
> The Titan TOP GDSC is the parent GDSC for all other GDSCs in the CAMCC
> block. None of the subordinate blocks will switch on without the parent
> GDSC switched on.
> 
> Fixes: 76126a5129b5 ("clk: qcom: Add camcc clock driver for x1e80100")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>   drivers/clk/qcom/camcc-x1e80100.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/clk/qcom/camcc-x1e80100.c b/drivers/clk/qcom/camcc-x1e80100.c
> index 85e76c7712ad84c88decb62ccaed68533d8848de..b73524ae64b1b2b1ee94ceca88b5f3b46143f20b 100644
> --- a/drivers/clk/qcom/camcc-x1e80100.c
> +++ b/drivers/clk/qcom/camcc-x1e80100.c
> @@ -2212,6 +2212,8 @@ static struct clk_branch cam_cc_sfe_0_fast_ahb_clk = {
>   	},
>   };
>   
> +static struct gdsc cam_cc_titan_top_gdsc;
> +
>   static struct gdsc cam_cc_bps_gdsc = {
>   	.gdscr = 0x10004,
>   	.en_rest_wait_val = 0x2,
> @@ -2221,6 +2223,7 @@ static struct gdsc cam_cc_bps_gdsc = {
>   		.name = "cam_cc_bps_gdsc",
>   	},
>   	.pwrsts = PWRSTS_OFF_ON,
> +	.parent = &cam_cc_titan_top_gdsc.pd,
>   	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
>   };
>   
> @@ -2233,6 +2236,7 @@ static struct gdsc cam_cc_ife_0_gdsc = {
>   		.name = "cam_cc_ife_0_gdsc",
>   	},
>   	.pwrsts = PWRSTS_OFF_ON,
> +	.parent = &cam_cc_titan_top_gdsc.pd,
>   	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
>   };
>   
> @@ -2245,6 +2249,7 @@ static struct gdsc cam_cc_ife_1_gdsc = {
>   		.name = "cam_cc_ife_1_gdsc",
>   	},
>   	.pwrsts = PWRSTS_OFF_ON,
> +	.parent = &cam_cc_titan_top_gdsc.pd,
>   	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
>   };
>   
> @@ -2257,6 +2262,7 @@ static struct gdsc cam_cc_ipe_0_gdsc = {
>   		.name = "cam_cc_ipe_0_gdsc",
>   	},
>   	.pwrsts = PWRSTS_OFF_ON,
> +	.parent = &cam_cc_titan_top_gdsc.pd,
>   	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
>   };
>   
> @@ -2269,6 +2275,7 @@ static struct gdsc cam_cc_sfe_0_gdsc = {
>   		.name = "cam_cc_sfe_0_gdsc",
>   	},
>   	.pwrsts = PWRSTS_OFF_ON,
> +	.parent = &cam_cc_titan_top_gdsc.pd,
>   	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
>   };
>   
> 


Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

--
Best wishes,
Vladimir

