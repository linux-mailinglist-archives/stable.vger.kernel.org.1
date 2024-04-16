Return-Path: <stable+bounces-40035-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 539058A73E0
	for <lists+stable@lfdr.de>; Tue, 16 Apr 2024 20:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 847871C218C4
	for <lists+stable@lfdr.de>; Tue, 16 Apr 2024 18:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F310137C40;
	Tue, 16 Apr 2024 18:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hE6e2M02"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFA513777C
	for <stable@vger.kernel.org>; Tue, 16 Apr 2024 18:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713293540; cv=none; b=V3k469eFHogQDX7zI30aUcNMK+8j9cqLu1JwVga16USch+ZWn/f3KPx+47hAVdSIUFk7q1C7L4JtSqi8h5RNn8pmVria6hCptNvn0mplIahiHxTET7QLQNJKpB2Lu5J/zIxa3TtBe61e7SRMXsZzUHgexsw0Gcfhdq8f7tpKNWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713293540; c=relaxed/simple;
	bh=y0uVH3oZE1a3APxihRtxusmQeZlfaUfpI73EDsl34Ic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JIlw/Zy66KCeFLwYVxRHZ4ltrCxSz8134NfQGV1/MogGgAN9FCSQwudJWYqbxVzuHjxxQJ2KfP5J6Y30zi7Rl+WR4kjgIp6VDH3/CvbPH7OTnDxq91tOtTxPj5/PZt/EsA6mia8pmN0xmIvhAk1zXYduRLhAt/vgtdwZs/FXWlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hE6e2M02; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so4731076276.1
        for <stable@vger.kernel.org>; Tue, 16 Apr 2024 11:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713293537; x=1713898337; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W5vQzyryFWgKw/gamp30zKVmQkGglywjftI1PpywStM=;
        b=hE6e2M028SGdn1J6NmvTGc0lCnYRBo1IY3+/VzIBb3MWrQuKMXFHc5jKbZK2qWzNNt
         7PdZ79yy7q11oLk6TiikHUAUGrFMokjcDDrzwcxbZ/GegpglgHJJK7qBAJn7X45jWl1n
         S/14eYV+R3WcmcbxVIqX5vV6R/86JQykzksgHOj955lugAHoMt7897vfTVH9E6IOeuPn
         XxbdKEQP3P+ls8G60k8KdRY51dpvxr8zD4E1ydjl++DTY0/FJLB7YaFQVxSO1FZv7C9J
         +WigZwi3uCdz7KOm9N/b2svuqCmDMJE+RcEPVj/pTLwJLZjU6SVuRg/mrXwk7fsSb39K
         Lq1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713293537; x=1713898337;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W5vQzyryFWgKw/gamp30zKVmQkGglywjftI1PpywStM=;
        b=GmzxxEMKEXe/x/snMaFP5ETmvq+2GpkLfIktgRXQmSfP3z1zMx4BE6HoGe3FDTcWAb
         ovO+++4aQe2QzbzDm+Ci97KJzkf2Bw48+0gl65522Fyqct2BX0dhoFwO1qnyn1pP4OWO
         wPDShyvZewMYjWFQiGGeOROSoSoYzcE2L02RkBwZX0+QS8qi/YV16puNvkQCDpk3d4ec
         t/wa97B9vrwLoac8XdDREAGHW+vt6PlI09cjKUpaqvAoXl+/e4oNNg+XFnf4iixSj3sY
         /mmigSIs6d48KhtF/ZrgQFmRZw9xavtIdPGStL0bl8sFw4522pAv4js2L64RPaz9BCDz
         tV0w==
X-Forwarded-Encrypted: i=1; AJvYcCX8rbp9CJJkkTppAEkjyxm4onXrL4wLgFZCrrcDRtkSDmeK3W7ZpbK1L4jHzUXjXllJnGgPDqYviBY5nfbtecietSdzLQ5F
X-Gm-Message-State: AOJu0YxtoDXUJPG14qYE0wwq1FwSW54UZJ48xJWU5HQpLhs7r/LCuYaw
	0m6VlgH27rx8VHyt8KFx5p+TzFS+WVUFFNB5mDm9prtfd6SBSHcnrgByz/vK7zvqs7xxbzJIxxK
	Eq2VqerTF5RIBSgBxNZPhJe+fyosk4tIa5CxRTg==
X-Google-Smtp-Source: AGHT+IEJjJJdzKD55UTLRTScRGrfAh2UPKsgtVqF6P2ql9N19AKf5+ktuo3JFOBl4aK0CuRCXG6qMrNHQ+pcEav3Cwg=
X-Received: by 2002:a25:1e56:0:b0:de1:1b21:4f8 with SMTP id
 e83-20020a251e56000000b00de11b2104f8mr10605271ybe.62.1713293536905; Tue, 16
 Apr 2024 11:52:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416182005.75422-1-quic_ajipan@quicinc.com> <20240416182005.75422-2-quic_ajipan@quicinc.com>
In-Reply-To: <20240416182005.75422-2-quic_ajipan@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 16 Apr 2024 21:52:05 +0300
Message-ID: <CAA8EJpox_C7hdHYxM4-w6YKHN2BMQqJ6xaGZqvzFdOYyrYtZFA@mail.gmail.com>
Subject: Re: [PATCH V2 1/8] clk: qcom: clk-alpha-pll: Fix CAL_L_VAL override
 for LUCID EVO PLL
To: Ajit Pandey <quic_ajipan@quicinc.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Taniya Das <quic_tdas@quicinc.com>, 
	Jagadeesh Kona <quic_jkona@quicinc.com>, Imran Shaik <quic_imrashai@quicinc.com>, 
	Satya Priya Kakitapalli <quic_skakitap@quicinc.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Apr 2024 at 21:21, Ajit Pandey <quic_ajipan@quicinc.com> wrote:
>
> In LUCID EVO PLL CAL_L_VAL and L_VAL bitfields are part of single
> PLL_L_VAL register. Update for L_VAL bitfield values in PLL_L_VAL
> register using regmap_write() API in __alpha_pll_trion_set_rate
> callback will override LUCID EVO PLL initial configuration related
> to PLL_CAL_L_VAL bit fields in PLL_L_VAL register.
>
> Observed random PLL lock failures during PLL enable due to such
> override in PLL calibration value. Use regmap_update_bits() with
> L_VAL bitfield mask instead of regmap_write() API to update only
> PLL_L_VAL bitfields in __alpha_pll_trion_set_rate callback.
>
> Fixes: 260e36606a03 ("clk: qcom: clk-alpha-pll: add Lucid EVO PLL configuration interfaces")
> Signed-off-by: Ajit Pandey <quic_ajipan@quicinc.com>
> Cc: stable@vger.kernel.org

S-o-B tag should be the last one. With that fixed:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  drivers/clk/qcom/clk-alpha-pll.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
> index 8a412ef47e16..81cabd28eabe 100644
> --- a/drivers/clk/qcom/clk-alpha-pll.c
> +++ b/drivers/clk/qcom/clk-alpha-pll.c
> @@ -1656,7 +1656,7 @@ static int __alpha_pll_trion_set_rate(struct clk_hw *hw, unsigned long rate,
>         if (ret < 0)
>                 return ret;
>
> -       regmap_write(pll->clkr.regmap, PLL_L_VAL(pll), l);
> +       regmap_update_bits(pll->clkr.regmap, PLL_L_VAL(pll), LUCID_EVO_PLL_L_VAL_MASK,  l);
>         regmap_write(pll->clkr.regmap, PLL_ALPHA_VAL(pll), a);
>
>         /* Latch the PLL input */
> --
> 2.25.1
>
>


-- 
With best wishes
Dmitry

