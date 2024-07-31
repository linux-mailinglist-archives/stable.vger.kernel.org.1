Return-Path: <stable+bounces-64767-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD343942FDE
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 15:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 782691F2B5E8
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 13:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A56D1B150A;
	Wed, 31 Jul 2024 13:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZpTN+ZBg"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739171B1437
	for <stable@vger.kernel.org>; Wed, 31 Jul 2024 13:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722431649; cv=none; b=CavqZOs39fpKaxPETObBdGfPhjkqo7tEvFwdYfQGS5NzYeNwoVMLEj+AUnhnDgbtm/nLJ+gbL5nDrFZhbaQUZA3IJV/O3CKdTHN//HNBHfZrDvfXpp0/hh6/MlpZLORp707aYIQKBKd5b0g/817cPS6dw8qUBbEaRRbAcA3+QHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722431649; c=relaxed/simple;
	bh=bvuz7ZQTlpKVEtd+hGYF+4HHVu3BwtgkiFOCzgMSB8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPghcZyirsOhoEvkCzpzRH0Aws64rDNYyIecWWU2w4kQWST3N4B784XeYnSsIE2PSFY5Xo60zxX/VOUj1mQuqJ3ol4OUIJC6Q9+7UKygmfuCpJ5qeg/vyfyglcDvZWU9IZ58ks+ddcdP1yFERh72m2QHYobdaBE23S48HcZVLjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZpTN+ZBg; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52f04150796so9771266e87.3
        for <stable@vger.kernel.org>; Wed, 31 Jul 2024 06:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722431645; x=1723036445; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IdNpuC66tCZmNn3Bi2XBjqkoJKgvebentJwyoGJLLCE=;
        b=ZpTN+ZBgWSxbTVjW0bgsjGLzuER/g6dwgERlHLLULckTR5K72+G/UPv7+iXYC/kygC
         kAtYoP+6fed9+TeW+1Nlim7OkvQSTjInTqNgugq93Mn1yVsuFLfeK5lpjRRex6J5TE1y
         iUy90kF1aB+w8mdY5jb/FIyYdn4Um+cHKPvpDNykHRmGHXOzWaA1YivNu/JktwWFLf6O
         xsuECjYqOKdZ03OxTJbs14ixWAhXJOgBW570tQzEFKJS8tL6atvorH1CnJBNPcgp7GBJ
         NJyh6H3abhI0KOBJ9Vsz4VoKSDxl7hTgzSHyuXMNOuvgVYZFq+n+Bf7nvMZItlWCwgxC
         xW7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722431645; x=1723036445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IdNpuC66tCZmNn3Bi2XBjqkoJKgvebentJwyoGJLLCE=;
        b=d9dDaR7cKqbCOD5e6OkzOMHRYfiA4PPRy8eIcGxX2P9hlmN0a3cylfdH+bd6Idcrag
         zYG2IQc09SqZ8a2+JHpxbp8sARY4l9cyknj2wRJBu2relN9HeqPZ5YzQDekgQWcOETpI
         GDEFU+QsHrcspJsR15VkiZIK8i1TTUeKemtSJ3Am5VigH6bhmpDrhOJXlkEYFe5n1C9m
         eVljyuMu3yN+kHYr6jvp1aKNv2UHf8CQKeGhSTDX9BTz4odpMMS+guE5jhupcqM65Udd
         I8scygCnNsrgW72zob2QXEv2Z7KfTI4FDqa+SE7F54OvagQZNI/ufYm3Zi/AThiiLJvv
         /DKg==
X-Forwarded-Encrypted: i=1; AJvYcCW/oZRpUmlHSlbCLn5fNWmtUP3MwC12hhx+TJ+Wj487QkricT8UgGJxvDLcw8DTfRAf3whM67lFaaA/pI5tkvm9boh20IO0
X-Gm-Message-State: AOJu0YzeHAugkkYiGjqLHs/HA42HnZHqpUWvXl4WvscIUOmTGOyerLcz
	gW6moRJSk0Qm03QJr8gPRkfheaN8WXi1R5V7cnL+4bGxdPfW80gUi77gJGsKBnw=
X-Google-Smtp-Source: AGHT+IEgIs1LGQXs+G34QWMVNh4qqIgBZfqUv7xu9vzUgzbuSIjdZCm2DOw0aztw/lmqqYCW+Vl77w==
X-Received: by 2002:a05:6512:2c0d:b0:530:ab68:2602 with SMTP id 2adb3069b0e04-530ab682a4bmr3648687e87.29.1722431645294;
        Wed, 31 Jul 2024 06:14:05 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c2bfaasm2245943e87.256.2024.07.31.06.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 06:14:04 -0700 (PDT)
Date: Wed, 31 Jul 2024 16:14:03 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Abhishek Sahu <absahu@codeaurora.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Ajit Pandey <quic_ajipan@quicinc.com>, 
	Imran Shaik <quic_imrashai@quicinc.com>, Taniya Das <quic_tdas@quicinc.com>, 
	Jagadeesh Kona <quic_jkona@quicinc.com>, stable@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH V3 3/8] clk: qcom: clk-alpha-pll: Fix zonda set_rate
 failure when PLL is disabled
Message-ID: <atzeh566yjeyrpr4dk4ogqmz366llenbp4i7z6tolarxfhifzr@p3mrhn4sr7ek>
References: <20240731062916.2680823-1-quic_skakitap@quicinc.com>
 <20240731062916.2680823-4-quic_skakitap@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731062916.2680823-4-quic_skakitap@quicinc.com>

On Wed, Jul 31, 2024 at 11:59:11AM GMT, Satya Priya Kakitapalli wrote:
> Currently, clk_zonda_pll_set_rate polls for the PLL to lock even if the
> PLL is disabled. However, if the PLL is disabled then LOCK_DET will
> never assert and we'll return an error. There is no reason to poll
> LOCK_DET if the PLL is already disabled, so skip polling in this case.
> 
> Fixes: f21b6bfecc27 ("clk: qcom: clk-alpha-pll: add support for zonda pll")
> Cc: stable@vger.kernel.org
> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
> ---
>  drivers/clk/qcom/clk-alpha-pll.c | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

