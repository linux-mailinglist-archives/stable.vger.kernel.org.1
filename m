Return-Path: <stable+bounces-191738-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47871C208D8
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 15:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD1EC400947
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 14:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34E6258EDF;
	Thu, 30 Oct 2025 14:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QXbR+HMK"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9271E2566F7
	for <stable@vger.kernel.org>; Thu, 30 Oct 2025 14:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761833970; cv=none; b=V/IMH1lChJDbBBQczhhYfSILDkNYAIIyXcT2eMlaO35mCSPFanGHed3zfLMpTMu6w/UPy9NlYx7KCmgAt1WjkE3+eZH9aVgybHTVddCe3xmw9ymKxIE0mkmoZc1PdCCtuuEGv3tQtwy2aaTmXAQvqaZMXJCzl5B4JE8yXbPy4hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761833970; c=relaxed/simple;
	bh=nWjEWW14xA6wvhmaKlUmBYkwCi9XznMqECjmZVOuvc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GlOwcsw0/vyOisUfmDTG1Rj5jKrZ6YShaBGnI4sxDCCI7xMzFcECCRTR+o4eIj5y6VuRmXXgE2N78eOxJLRHk6+ed1g5pa1QDrSvy3iLQMitoSF+s6KgiZcvuUNvrmaOliMG9qGEA9prGFR8BuWY8K8tTNXAqVuSHZAtwwoePYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QXbR+HMK; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-475de184058so3849475e9.2
        for <stable@vger.kernel.org>; Thu, 30 Oct 2025 07:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761833967; x=1762438767; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a20YeKsMFc9Z6sbLd4e+xL3fMV6LgnJCfC9IDTqyQpU=;
        b=QXbR+HMKmSNQXcqAKd9nVhvOLgYoA3rcN2ykBLdnIklYia71Fdn0We1FCH+vIkrfvR
         NMCAtdu8sqGqhOWohL02QXSgIS8Qnlp67l80/kXdT3zjs2XsTxVAx3IQD1GXfsAQZfsu
         TKf2nhsmtzDbYQluAnN7anuKSvc54c+jikZV0fIlMwQX4efSAYet5Orjja59SRY8mFPi
         o4Raut4qKnh35i/hwOIfYmVpwFE1/+UnYGBgrhY4f2zNxaSZUnJU6B4ssqF5U8OB7Hl3
         Le6+cxgkq5HuejZp7RaSkFPuh8tFbI7SNLoDpiTnupnGmidaKHxGIzVFRR7WSJJEmJzA
         dhug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761833967; x=1762438767;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a20YeKsMFc9Z6sbLd4e+xL3fMV6LgnJCfC9IDTqyQpU=;
        b=fq01PMINYo2fYvkAk9rrNWzT2X2amI6X2PJvzekcqekOh24m/q4WX9M0SmlCQXYgai
         6uos74Oqg/vjSvm06060abyZx1xo9RGa6rxhMRMQrJIeib3WJlqMdqtKOxVOkAHPvTT6
         HObb29NVKrwicMS7q64AjkrQwlcYu9PaTHI1+HgOqN8Lw1S2vyVHBcJDONtElUUGiL8v
         EnhWdoRcm0bHKf275vOiVHszqas+vANPwuGEfHDW5Ny9bf6aa6xtluciFYRDu7UFeyMn
         XnmhrNrzwoXjjhnIxKC4J0xbENgXyu1iqUyqZrJVX7ZPVKc5LclQMEMEsd1Dq4rDShnA
         qzMA==
X-Forwarded-Encrypted: i=1; AJvYcCVR5Tyu7O63a98yseOPOs64/jTjCsyYdb7b6IdK0h31g4ygpI8NnnLqdZbQqfRQ3UOJqaOubOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQjupso/cYq+z4CDLUgBgcZE5yh8v7WTe8GwbPk7DP9YXTTZmm
	lRo5r3N1cWq/XVd6ITRugv49KoQnIQiswQtuLFTvdLFE5+PZ5D+LPZKZ8ygdvfNptEQ=
X-Gm-Gg: ASbGncvU1tgeYJEJgrZRxyyM1eWVawDS5SDD1OMcjvq3BZDrBWl4F58Fbc7xKCJwuaU
	bMJ3R7o3x2do3OigQESpME8OF2q5FfSS+pdnFaYBxA756CP1EnB77lWOX5NxA+BS1T79d2GwNxM
	KSV4eO4gJ4pFoQLh7ipn1Un+RcomySFy7ZloRi0FGDzaZI17ZMiyjWlQ2H8Q6/FfH6yYB2K63LJ
	qSUd3shN/ZOPr6CQTseh4aS4sJpn5FzewAMvIz9cM2l53OejsKexxkZaPTzIjqPoA2oNNNZ7Ud/
	PjdwX/ICpAsHKnd87bVFd9aie+5kyELERDN/h0a8nSizAjtur4jFeeKE/2IoTcmCb9ugf4NtX9E
	DK8kMIByQabboVVxexMbYOZrtpjq58bYOrXz5MXZ9aopP/xOP90lz2yFWlSFuNhCre74Jiz6KgW
	jex69UIv8=
X-Google-Smtp-Source: AGHT+IEBlja5JbNdrJw1QkNw2N7bwbcqpMzF5dSAbI4fK9ZOC8Mvm/unLC/mvyeKuAms9L9CjudSAg==
X-Received: by 2002:a05:600c:b85:b0:476:57b4:72b6 with SMTP id 5b1f17b1804b1-4771e16e83emr67296335e9.8.1761833966643;
        Thu, 30 Oct 2025 07:19:26 -0700 (PDT)
Received: from linaro.org ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772fc524ddsm909265e9.7.2025.10.30.07.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 07:19:25 -0700 (PDT)
Date: Thu, 30 Oct 2025 16:19:23 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Baryshkov <lumag@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Sibi Sankar <sibi.sankar@oss.qualcomm.com>, Rajendra Nayak <quic_rjendra@quicinc.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzk@kernel.org>, stable@vger.kernel.org, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v4 2/3] phy: qcom: edp: Make the number of clocks flexible
Message-ID: <sxk3zeqaul32upo2gnmvgembvx2d7eq6qyylmwuxsdahgw4ngu@4zcjcqlooyqa>
References: <20251029-phy-qcom-edp-add-missing-refclk-v4-0-adb7f5c54fe4@linaro.org>
 <20251029-phy-qcom-edp-add-missing-refclk-v4-2-adb7f5c54fe4@linaro.org>
 <wjvec7fiqjzlyo6y5kpzsd5u7rz47anaytu25w2j4yqgtdntx6@zuapdsayoio2>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wjvec7fiqjzlyo6y5kpzsd5u7rz47anaytu25w2j4yqgtdntx6@zuapdsayoio2>

On 25-10-29 11:42:26, Bjorn Andersson wrote:
> On Wed, Oct 29, 2025 at 03:31:31PM +0200, Abel Vesa wrote:
> > On X Elite, the DP PHY needs another clock called ref, while all other
> > platforms do not.
> > 
> > The current X Elite devices supported upstream work fine without this
> > clock, because the boot firmware leaves this clock enabled. But we should
> > not rely on that. Also, even though this change breaks the ABI, it is
> > needed in order to make the driver disables this clock along with the
> > other ones, for a proper bring-down of the entire PHY.
> > 
> > So in order to handle these clocks on different platforms, make the driver
> > get all the clocks regardless of how many there are provided.
> > 
> > Cc: stable@vger.kernel.org # v6.10
> > Fixes: db83c107dc29 ("phy: qcom: edp: Add v6 specific ops and X1E80100 platform support")
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> >  drivers/phy/qualcomm/phy-qcom-edp.c | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
> > index f1b51018683d51df064f60440864c6031638670c..ca9bb9d70e29e1a132bd499fb9f74b5837acf45b 100644
> > --- a/drivers/phy/qualcomm/phy-qcom-edp.c
> > +++ b/drivers/phy/qualcomm/phy-qcom-edp.c
> > @@ -103,7 +103,9 @@ struct qcom_edp {
> >  
> >  	struct phy_configure_opts_dp dp_opts;
> >  
> > -	struct clk_bulk_data clks[2];
> > +	struct clk_bulk_data *clks;
> > +	int num_clks;
> > +
> >  	struct regulator_bulk_data supplies[2];
> >  
> >  	bool is_edp;
> > @@ -218,7 +220,7 @@ static int qcom_edp_phy_init(struct phy *phy)
> >  	if (ret)
> >  		return ret;
> >  
> > -	ret = clk_bulk_prepare_enable(ARRAY_SIZE(edp->clks), edp->clks);
> > +	ret = clk_bulk_prepare_enable(edp->num_clks, edp->clks);
> >  	if (ret)
> >  		goto out_disable_supplies;
> >  
> > @@ -885,7 +887,7 @@ static int qcom_edp_phy_exit(struct phy *phy)
> >  {
> >  	struct qcom_edp *edp = phy_get_drvdata(phy);
> >  
> > -	clk_bulk_disable_unprepare(ARRAY_SIZE(edp->clks), edp->clks);
> > +	clk_bulk_disable_unprepare(edp->num_clks, edp->clks);
> >  	regulator_bulk_disable(ARRAY_SIZE(edp->supplies), edp->supplies);
> >  
> >  	return 0;
> > @@ -1092,11 +1094,9 @@ static int qcom_edp_phy_probe(struct platform_device *pdev)
> >  	if (IS_ERR(edp->pll))
> >  		return PTR_ERR(edp->pll);
> >  
> > -	edp->clks[0].id = "aux";
> > -	edp->clks[1].id = "cfg_ahb";
> > -	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(edp->clks), edp->clks);
> > -	if (ret)
> > -		return ret;
> > +	edp->num_clks = devm_clk_bulk_get_all(dev, &edp->clks);
> > +	if (edp->num_clks < 0)
> > +		return dev_err_probe(dev, edp->num_clks, "failed to parse clocks\n");
> 
> Nit...We're not really failing to "parse" clocks...
> 

Will respin with s/parse/get/

> Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Thanks.

