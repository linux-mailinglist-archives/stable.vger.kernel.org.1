Return-Path: <stable+bounces-15492-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB98838ADC
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 10:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C882928A7B4
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 09:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298325D8F2;
	Tue, 23 Jan 2024 09:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SgqeWKKk"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A2A5D75F
	for <stable@vger.kernel.org>; Tue, 23 Jan 2024 09:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706003138; cv=none; b=aFfVu32cfgXjlleefqBFIG3FghJxVeiE+Z9sg2GhSc/S3mHAhWGI4X4QmQaijxnML4p6whSxBgTG2ReWLf5xum/9KgOTh+f0v3qQ3Kks+dKL1yK56Dy31blft8FkEXmWrhgzy057RK2UsJ92kRKEXeeI6deK/TNZrNRKgqh8A6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706003138; c=relaxed/simple;
	bh=aLi4ni515fDPLmheTfXWKONnXtTpxfLwvtIiaSEI/pI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXPLO/utQHji1I2CL8SCgUEs0Adpm0e0sW9ZLo2R0HqN5ZbtDRr+uruF/wpeSzpEiAlg3sH/1cEl+KoG3Y9nibvR+2CsTAEu/xj9dUtqytTFuCx3byeBTaSXNsbvuedKIe3ooB+yPUQk6WDF25Yn2pw9kfOa2TFUNQ1pWBQTIJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SgqeWKKk; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-42a49d42f06so5410791cf.2
        for <stable@vger.kernel.org>; Tue, 23 Jan 2024 01:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706003136; x=1706607936; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GPuIu+Od8YPZ7JAGfosVr9r0tWmFr9cTu0oqbB+e0Zo=;
        b=SgqeWKKkVfxFi6U7w1Pb3K8TdafaRdah6HPMhYpQCSjsPbxITaoq/4gOfakq4uHny1
         iyaLBJIoOITozXmV3Nf8bZ+uVxL2n2qzAPyhagNapf5fXxmWWg74khT9OZ3jKdzVKj5M
         Vw20FKcGeQi3Soibai1EkTr//02S+07D7D0xp9zq/809AI/yyg+Z3Ty/AP/sV+a2Ibam
         RoiqsJMcCApxz6LVBRkyeMGYfLJ8or+rRMa9fDWXCvv6v40HOHQ2aWpRL0ICazeaV6i1
         vUsLTYN3FdfpbhpJxyhF5Mkpe04uKOcGnLVKUz0fvZJY+MWoKXAEeHrpt7NWTU4hPflv
         jrZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706003136; x=1706607936;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GPuIu+Od8YPZ7JAGfosVr9r0tWmFr9cTu0oqbB+e0Zo=;
        b=XWMveGs+KlIP1nlCff9VqsaVld3eSZYEj4RGf+p5SuHLPBQ5y7Dp7KjKjIR5pX0xOp
         H/IT8U6ADclT1Zle9qrHb/FVxcSXbM0MBYDGkcigi2vZdh6NeHwQQLYZy4TzYMEOFjOl
         BQOVm8pW8bjKdkhYGOCZQAHPBclea//rj5q/Z2hLAyWcBVls1YpQS8NgiPGxqN3hdvpH
         4QUA/0/3uyJgC3/TLaxu4C6/aKyEWYbNl69iJbzBe9fQ0YnbPhLtENFUGGvB4wfRtC4t
         L/uH0PwwlCbRqqtlEpc9l/aIZKYS0nDLmyGF2ZudSQ74oD3MaDVMA3S7r1FUSc5GbIAd
         4xgQ==
X-Gm-Message-State: AOJu0Yytjl0lIoZW9YnaQw+pLalQyglx2XSZuyxKp+FgSnjsWH8bbXUX
	+zBPmdPlj5PD2CimujcJ7loi3BGQeeskef3In5V3YvubmlsDt/eO7sOQBHB/eA==
X-Google-Smtp-Source: AGHT+IGwmRddd4hbzIPzChpuRO0Dfx5I4nzCNEfptJ98zrnanML4MnrVA1G0oVNdUJTPC+nD4BLe2g==
X-Received: by 2002:ac8:4e93:0:b0:42a:3a03:7ea0 with SMTP id 19-20020ac84e93000000b0042a3a037ea0mr450084qtp.111.1706003136386;
        Tue, 23 Jan 2024 01:45:36 -0800 (PST)
Received: from thinkpad ([120.56.197.174])
        by smtp.gmail.com with ESMTPSA id fg6-20020a05622a580600b00429be14d3bbsm3323313qtb.13.2024.01.23.01.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 01:45:36 -0800 (PST)
Date: Tue, 23 Jan 2024 15:15:28 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Amit Pundir <amit.pundir@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: gcc-sdm845: Add soft dependency on rpmhpd
Message-ID: <20240123094528.GA19029@thinkpad>
References: <20240123062814.2555649-1-amit.pundir@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240123062814.2555649-1-amit.pundir@linaro.org>

On Tue, Jan 23, 2024 at 11:58:14AM +0530, Amit Pundir wrote:
> With the addition of RPMh power domain to the GCC node in
> device tree, we noticed a significant delay in getting the
> UFS driver probed on AOSP which futher led to mount failures
> because Android do not support rootwait. So adding a soft
> dependency on RPMh power domain which informs modprobe to
> load rpmhpd module before gcc-sdm845.
> 
> Cc: <stable@vger.kernel.org> # v5.4+
> Fixes: 4b6ea15c0a11 ("arm64: dts: qcom: sdm845: Add missing RPMh power domain to GCC")
> Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Amit Pundir <amit.pundir@linaro.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/clk/qcom/gcc-sdm845.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
> index 725cd52d2398..ea4c3bf4fb9b 100644
> --- a/drivers/clk/qcom/gcc-sdm845.c
> +++ b/drivers/clk/qcom/gcc-sdm845.c
> @@ -4037,3 +4037,4 @@ module_exit(gcc_sdm845_exit);
>  MODULE_DESCRIPTION("QTI GCC SDM845 Driver");
>  MODULE_LICENSE("GPL v2");
>  MODULE_ALIAS("platform:gcc-sdm845");
> +MODULE_SOFTDEP("pre: rpmhpd");
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்

