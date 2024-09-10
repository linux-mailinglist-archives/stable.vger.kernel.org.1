Return-Path: <stable+bounces-75671-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 081E6973DC5
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 18:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B7541C2531B
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 16:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56901A0B1D;
	Tue, 10 Sep 2024 16:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d1hJ1xie"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126C4197A7D
	for <stable@vger.kernel.org>; Tue, 10 Sep 2024 16:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725987176; cv=none; b=A8zcQcD9HxxCw1mKfIHBENNEFysD/jahHytkC0V1RWPUZWZZ+ccjNNU3VwptFZALjoIcQDEIEzNDLA7JdBS6pB/RSZGrvXOW/VGiLHvkYIQHfsiJHgUDhhOIR2ORxie+ktWDCBj/8GqrHR8ZzZaNpSYtgM3fpYB/ElU/EtoM8A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725987176; c=relaxed/simple;
	bh=pmkiV0ROweHRR1xx9Sy4aOWEKgFXZ9v/XWZ9gvfmcLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q0uFuF13N2UjE7Iw5ly4OfdPsqtU/sHVAyVNuvSWROuU4ncCC8I6xWG4B+CY+hhlmixvi6HOio8cqiAi6KnATpqqSmb3IAWHRXVdyl8Lwm23tr6NeMEbg5vYIwT7IU30XA+Cbl0ur4na5lToSguTwC0nJUkl/qAiFJiSjQHleIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d1hJ1xie; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-6bce380eb96so3594145a12.0
        for <stable@vger.kernel.org>; Tue, 10 Sep 2024 09:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725987174; x=1726591974; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g25Ru7xbbTB3wDSvtSavAzlRmQz6Xvdop91thyf32UM=;
        b=d1hJ1xie6fxtkA2YLfgL/ICM3wz8RjPudW8E1QFN8k0B+RlUpZUUsyWw/u8127gKXI
         pNxntAnDI+tCd1b22V5Sz72a9fCmbA7tB53dfACQ4uGU0uYLEMlXRHls5b6Y2mjPYzVR
         hwGu7NP3yGqxvSUT3GYfrPj1aW7NHKfQORERA5ZT4YylW0hed8tv/xh3wNCiA1yKZj9y
         xJs5J02zUxKH0DH9P74yIsM7EaUl6SSFkNSGW+FdpjZYmVdEZrwREMblxwYqTruSc3Ti
         3YB/WNSIlZAA1IDR5+8UJTPHCtSOocn9y6eMETASQ9UcmExxNYcYZ/fQidYcxM5uq/91
         SLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725987174; x=1726591974;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g25Ru7xbbTB3wDSvtSavAzlRmQz6Xvdop91thyf32UM=;
        b=YlEbd+JWXHwgzJFquazfq5Xha4XeacWXkKFQuHEXN0kF1KBq2q2hcaKDzG/a9i2FUO
         F/FtaBMX8QzMNOkoNCrCqtxjIkJInewRub4DEHrshfgeka5LhWf4GiQI4w/C8TTUaJof
         XLbXzev/sqewmgg37e/R2kesz8kT+zXRf8NGR3N2Ujbac6qWKGtu9i46GVo5Ew9DMzs2
         x3xuLqG0AeHgFnJPOg06K+1BV+8sadG7uezUf6j3SwBx59rIZKUz/Q+eoEI1oZzX+YzZ
         hwLQvSyAVYLqhoOyuDcX7Lk06XwfXTfhBc6WffsYhaXd8e+Moaver5vwHI1OE1cfYwdc
         d1hw==
X-Forwarded-Encrypted: i=1; AJvYcCXtBjgEfcmEZDXp4yqhal8QqY/KUQ2ufn35Ry/Z4GLhnQV1negPfgfgwGoEKPQf+Sxg5BJrwxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHjXLlktGzajZlwaTbiqeCJ5SAaOXOVmgNUlTeK3kUR1DoCons
	lKP4Ps8UUKbynPwaJQZXvBpS205zqMgSa3AH176jGksV6OilBxL3VA4Cju2m3A==
X-Google-Smtp-Source: AGHT+IGT8gCwyZvdGRQRZlzo82GU5AwgsS0cQ+zQt7rE2+MgonPozA5gcDhFM9k5t3u/0UbEHmZSnQ==
X-Received: by 2002:a05:6a21:1707:b0:1cf:2aaa:9199 with SMTP id adf61e73a8af0-1cf5e075815mr1579531637.15.1725987173970;
        Tue, 10 Sep 2024 09:52:53 -0700 (PDT)
Received: from thinkpad ([120.60.128.228])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadc03f5aesm8775980a91.28.2024.09.10.09.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 09:52:53 -0700 (PDT)
Date: Tue, 10 Sep 2024 22:22:42 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Anastasia Belova <abelova@astralinux.ru>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
	"open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
	"moderated list:ARM/ACTIONS SEMI ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	"moderated list:ARM/ACTIONS SEMI ARCHITECTURE" <linux-actions@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	lvc-project@linuxtesting.org, stable@vger.kernel.org
Subject: Re: [PATCH] clk: actions: prevent overflow in owl_pll_recalc_rate
Message-ID: <20240910165242.v6jcirmtbahxqggx@thinkpad>
References: <20240910130640.20631-1-abelova@astralinux.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240910130640.20631-1-abelova@astralinux.ru>

On Tue, Sep 10, 2024 at 04:06:40PM +0300, Anastasia Belova wrote:
> In case of OWL S900 SoC clock driver there are cases
> where bfreq = 24000000, shift = 0. If value read from
> CMU_COREPLL or CMU_DDRPLL to val is big enough, an
> overflow may occur.
> 
> Add explicit casting to prevent it.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 2792c37e94c8 ("clk: actions: Add pll clock support")
> Cc: <stable@vger.kernel.org> 
> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>

Currently, val is limited to 8 bits max on the supported SoCs. So there won't be
any overflow. But for the sake of correctness, I'm OK with this patch.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/clk/actions/owl-pll.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/actions/owl-pll.c b/drivers/clk/actions/owl-pll.c
> index 155f313986b4..fa17567665ec 100644
> --- a/drivers/clk/actions/owl-pll.c
> +++ b/drivers/clk/actions/owl-pll.c
> @@ -104,7 +104,7 @@ static unsigned long owl_pll_recalc_rate(struct clk_hw *hw,
>  	val = val >> pll_hw->shift;
>  	val &= mul_mask(pll_hw);
>  
> -	return pll_hw->bfreq * val;
> +	return (unsigned long)pll_hw->bfreq * val;
>  }
>  
>  static int owl_pll_is_enabled(struct clk_hw *hw)
> -- 
> 2.30.2
> 

-- 
மணிவண்ணன் சதாசிவம்

