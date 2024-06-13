Return-Path: <stable+bounces-50467-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11266906665
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 10:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A213A285EF5
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 08:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5440613D50C;
	Thu, 13 Jun 2024 08:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="otJk6Np+"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699A913D502
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 08:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718266786; cv=none; b=jJpJhDOJyIhljt4eqG4eltuYNFn9t+5WWn9WESXici1oveuQKSqdk7SvM+VwwbVD7bR3zBF8BairsjD9CyvqudDvbacG5uJ5uq+LbmViomT34Yvh3Ci188wyTiq3bZFIxLImmELeAhi9u3ofwYsKsW3h7M+PomyzDUX20q4MbJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718266786; c=relaxed/simple;
	bh=kqwyxqCAid86cD5vG1gVcUsF9oMz7VowpVEj+CbUwUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pUoGGq3rPoxdHsGZFDgFUgZS1ct/FkXTpFsdpAHJEyfHH+NlCyIZgxGUVQrZfGyH8JJR+8eT5FJR+tZJ8kPSmJSg9UZ6c9kzks7EDOjbpFa6Zc6rkTH8XblOEBcVFnMQF7E25oz5SuKbn8K0BREke9l6apaDdrvbJuEfEzL/sqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=otJk6Np+; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2eaea316481so591131fa.2
        for <stable@vger.kernel.org>; Thu, 13 Jun 2024 01:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718266782; x=1718871582; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+0UP0g4SgJBlO7fJs5utFNOMdYzCMBOE1A8PYkpodHE=;
        b=otJk6Np+lRUpwoKD56lY45QCKqUyWVT0ktrQ2ciJGMMFpb6ibbragctKCvizsGJliJ
         LfsOHaNJnIr1FfrG/HDRUb7B0d01qf7n/q5HIOHDX203TRyUO5q6V7xWpml50xytfvwy
         yp1t4WnOITbkFo8uMmDlP9cvPyq76Ya3zxBhyjj20L4M/BlA0ECA7m5S0ar8Kxbw2G6v
         Q9dhDh1VIcfwH/T2ilYCbtpn2RSnKr1CtptiXa4FayA/8t52qHk34uhPH3rIIsCym/PD
         2u1MILHgXe7dkuRVnINcEIN/SI9t225hhH2n2YaZc5fKospk1APiT0WkEOYqaVz6vY/L
         7s7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718266782; x=1718871582;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+0UP0g4SgJBlO7fJs5utFNOMdYzCMBOE1A8PYkpodHE=;
        b=IwVmehh+eFY7fOnHdOfdgIt5SEQA8S+MMH+XzxzI4RhzZqG25OyJ21nD3RVfnbEQpy
         FHLUGCFJAMlLJlKtvc4SL1Wr0i9TNZ4Zs9+ncZsAXXy+hpEEG14sn8u7/QE5adkb32+A
         rXral7J4c4qh9Nc9mY9bwHLveeV2cVDFV+pLCU3KDb//87rlMLV/ILWjZfhbltUf9MIR
         x5Pg/d0Gm2ZR9Wv0NkuZg4wEBt9l4HXmnZVjKOFERtulVydtWHij3caXIHZgK6rd88Zc
         aOTGduOz5nrfAdYwzNOQd22Bi2yoAYN+Hp5U+wjF+b7qAPYXp0CqfLoUz/qFuCOtqkFQ
         gLTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXED2RJYZNJLOnnUwXLKUQHPOGtplLyWWmp07lGHtxdr9DzX7CGw0V7IiRfVOL7eGV2hccb3jpq89qK3q3/Zwg/ep9oU8a
X-Gm-Message-State: AOJu0Yy2Uij3CnMdPLk6dqLuSaTPzNjdVyb7KHJPAd3ZhCpSMq5e+vb5
	ycvnd9558m7N1gdGshMY7r9repW4qHBllStzPjw7gvzXYOP/XLs9LicNmPmV6fM=
X-Google-Smtp-Source: AGHT+IGVP/0aCb+LgJGqQTXXDStsxDbTPr1bzgPtOQZziu+iQkXKZZEEujrtax/g9gdqsncG888sGA==
X-Received: by 2002:a2e:2a85:0:b0:2eb:e738:53b2 with SMTP id 38308e7fff4ca-2ebfc8b174dmr26404661fa.1.1718266782557;
        Thu, 13 Jun 2024 01:19:42 -0700 (PDT)
Received: from [192.168.1.3] (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec05c16f00sm1240211fa.61.2024.06.13.01.19.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 01:19:42 -0700 (PDT)
Message-ID: <68a18159-11ff-412c-b742-34ceb0f3a028@linaro.org>
Date: Thu, 13 Jun 2024 11:19:34 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 1/8] clk: qcom: clk-alpha-pll: Fix CAL_L_VAL override
 for LUCID EVO PLL
To: Ajit Pandey <quic_ajipan@quicinc.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Taniya Das <quic_tdas@quicinc.com>, Jagadeesh Kona <quic_jkona@quicinc.com>,
 Imran Shaik <quic_imrashai@quicinc.com>,
 Satya Priya Kakitapalli <quic_skakitap@quicinc.com>, stable@vger.kernel.org,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20240611133752.2192401-1-quic_ajipan@quicinc.com>
 <20240611133752.2192401-2-quic_ajipan@quicinc.com>
Content-Language: en-US
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20240611133752.2192401-2-quic_ajipan@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ajit,

On 6/11/24 16:37, Ajit Pandey wrote:
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
> Cc: stable@vger.kernel.org
> Signed-off-by: Ajit Pandey <quic_ajipan@quicinc.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

thank you for the fix!

Acked-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

--
Best wishes,
Vladimir

