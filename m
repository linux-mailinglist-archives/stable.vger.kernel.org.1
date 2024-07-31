Return-Path: <stable+bounces-64771-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 110C49430E6
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 15:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0935B226B6
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 13:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849921B1503;
	Wed, 31 Jul 2024 13:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wZEP2s1J"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943071AE843
	for <stable@vger.kernel.org>; Wed, 31 Jul 2024 13:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722432716; cv=none; b=KO6oQESAeCPHfTanyjC523NdWiWXMSNuTW03+05TW5R6cQgkg6NhaAdutAJ9vgBKgrOEMx1XuBkA5shEBI080OpaTCxl7yT7bormgD1tTNFnqVfE1zCNRhncqXHX7ZBbvHJWXZnNqkmkaAnHw5GsWWXF3+QLgk9aMvoXFgRY9Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722432716; c=relaxed/simple;
	bh=P2Zc2kRlUTzQWuiLdA1pFWHC6xvaH6zfnCz8JHSEIs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IBYzhM4th9lq90soo8DQ+8ExXbvKUudFXzXAPqxI/QhR/ggTyaWlutbRCWuVUs+uOy5LDCPzBlaKh0SZJrlSTwPZS8uDpQP0ylle47N4x1FNkIDYoIBx/Vqc3ZhxQzbWLn5y/lruxkd6yrSVytYlY7FgN6/VVEla2nByDxdF7wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wZEP2s1J; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52ed741fe46so6499580e87.0
        for <stable@vger.kernel.org>; Wed, 31 Jul 2024 06:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722432713; x=1723037513; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mu/jrHV9aX6kTVP3aSVpeXFR1odPgGfcDv5EihSzkVY=;
        b=wZEP2s1JDOHjfRaoa3j1T/vvA/AMIAw9Byv8YAx8c9708Qk8BjIjIdnL+1nYleLwDo
         hXNGL4VoorUaCgD/5kQNDjf7S9GMUuvrPQMeQvI8USqBlmgR8y5ywkPmGfouP8tBOYRS
         T0T8o9yGlLP3YuFjWXDvpzYzETN6wOHBUO1F3Y1DU22JdVGNm7Uh070c0Ksa2Huhj9zA
         eXvALTbveik9vBeQPxJbXEtkHRWzlN/whkwGWp09rxRHLFVpx7f7F5Alou2+Gra2/r+A
         ihZZOgzffHWxXRboxaFcqPsp8Ajn2Pk+iClxkAV2V7hhfal5SoraVk+4gpXX4JlnkP+s
         D6wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722432713; x=1723037513;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mu/jrHV9aX6kTVP3aSVpeXFR1odPgGfcDv5EihSzkVY=;
        b=fW3Rbu2cmr0qvT+sfcfszEEYkeqYslqsuduLZe6B4kbuKOF0y3qAOHvlEIySo6Immq
         C3TUuWy9YvBK/t92VNjO3VBs3vVObYuMOSyxIDCcu0V7xfXRzzaPm1VgY4UHKVlPx3fm
         IJJiNHLFj33Kg9pe3D1LaAQt+I1GALjjC4RYTBtyI7f2GI7TnIi+EdZd6SlFmujfjXfo
         1QoUBPPObyfQNspppsvyBXmfbJcYjN5BF0wzOiY1woharWNv34NpwC5RM6JlppqufJDc
         mefZQ1agSt2vzaJ27y6CELgHPgVVm3pdM4KkL1alq9MRlVqil6R2cL63zlIezYBnSeNj
         eEBA==
X-Forwarded-Encrypted: i=1; AJvYcCUYZl9etSAeL1emWVEqA+gEzmVRaPs2GG4b9A8ZI6UkzcOGpuAxrX9niy32cDwhu3QaH3tTjTtop0EqxAhKcEinzjFjyEGS
X-Gm-Message-State: AOJu0YxE52lLBCUCbRrgjNPwTBFLPNz5g29bJYlpJdmzsWsvhqd4FGVr
	u33HRFJEgTUHO3Vq1b4HivsqinFBtG+LnqJ72bZQ89l40d2rRTDGxK9SnJ3Kq4s=
X-Google-Smtp-Source: AGHT+IF9yysuesy1AWwQPiU83pnAbyqHjqnagriUsXCkmX5PJrirOfJMTi1oEuRwoiTJE5k2d+aUKA==
X-Received: by 2002:a19:5e16:0:b0:52e:7f6b:5786 with SMTP id 2adb3069b0e04-5309b2d9ee6mr7399994e87.61.1722432712551;
        Wed, 31 Jul 2024 06:31:52 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c2ce6esm2242763e87.267.2024.07.31.06.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 06:31:52 -0700 (PDT)
Date: Wed, 31 Jul 2024 16:31:50 +0300
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
Subject: Re: [PATCH V3 8/8] arm64: dts: qcom: Add camera clock controller for
 sm8150
Message-ID: <dlrkizo76pr57f5ijdxb65u3mz2arfs376cpalpv6j6aphmk24@4f6mrbxujyke>
References: <20240731062916.2680823-1-quic_skakitap@quicinc.com>
 <20240731062916.2680823-9-quic_skakitap@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731062916.2680823-9-quic_skakitap@quicinc.com>

On Wed, Jul 31, 2024 at 11:59:16AM GMT, Satya Priya Kakitapalli wrote:
> Add device node for camera clock controller on Qualcomm
> SM8150 platform.
> 
> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sa8155p.dtsi |  4 ++++
>  arch/arm64/boot/dts/qcom/sm8150.dtsi  | 13 +++++++++++++
>  2 files changed, 17 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Minor nit below.

> @@ -3759,6 +3760,18 @@ camnoc_virt: interconnect@ac00000 {
>  			qcom,bcm-voters = <&apps_bcm_voter>;
>  		};
>  
> +		camcc: clock-controller@ad00000 {
> +			compatible = "qcom,sm8150-camcc";
> +			reg = <0 0x0ad00000 0 0x10000>;
> +			clocks = <&rpmhcc RPMH_CXO_CLK>,
> +				 <&gcc GCC_CAMERA_AHB_CLK>;
> +			power-domains = <&rpmhpd SM8150_MMCX>;
> +			required-opps = <&rpmhpd_opp_low_svs>;

Is the required-opps necessary?

> +			#clock-cells = <1>;
> +			#reset-cells = <1>;
> +			#power-domain-cells = <1>;
> +		};
> +
>  		mdss: display-subsystem@ae00000 {
>  			compatible = "qcom,sm8150-mdss";
>  			reg = <0 0x0ae00000 0 0x1000>;
> -- 
> 2.25.1
> 

-- 
With best wishes
Dmitry

