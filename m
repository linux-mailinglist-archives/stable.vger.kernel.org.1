Return-Path: <stable+bounces-169716-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABEDB280C5
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 15:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1AFC1C27CFA
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 13:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903DB30276D;
	Fri, 15 Aug 2025 13:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cOLn2gat"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F18433AD
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 13:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755265348; cv=none; b=mDZlEs19Mzvc6hutB4+1i323VXUYoDiLTghD4x2/j31DuYYqdKyPoUB916jf/2m3BBSBO7pvqpKrjVXts49Nw/aF+UiTQf6UheusNMzaOO93Cu/5GlJXmm4lFR35FUB8BMioVPQysCQ4wrO5pVu22Z0Ev618kypVizZsRkw5AIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755265348; c=relaxed/simple;
	bh=PQ8+dfSydKrkvzfm2HENartemvX6MLXX0jZP5Wi/v+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+Yo5VrI0PGB57f6Gp535nvJ3eTF/BJ2QwFVNSfoDv8Cr3N1WSBqcmeJN5s1c0mIfI1I6MVURipuLWD80wANak4VpV8A7369dIoAfaj/DSdSCUdu3WMzdYAh0QpIppMvmqgxePPG8MqBU5q8pO3wqwVmAtl647A9qXdZWGb+wJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cOLn2gat; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45a1b0bd237so14958835e9.2
        for <stable@vger.kernel.org>; Fri, 15 Aug 2025 06:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755265345; x=1755870145; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tay3gLmD8Frwd0JSmKUUlrGu9kRRhF6pKhplgXjle5s=;
        b=cOLn2gatFPWBYGNe3cTRFGUqHek6Ba4rGEbgsc0dkLuynegdo6EBaVj5ltan662UsZ
         kovgTVgmBzzyJ9bQE/ssjPuZId+Za7HlOxZn/cXeKgrZR4q4g+MyE5KBvBWWcFwDyP/o
         AM33KgRkBju8lFD9AEaNYDTP16B7F7tQEChPARoI7nms4rslScEvXi7/iRBc20dcXYvv
         fxhICqvAHo4TLMLF38iPWIjUL6FAPb5jOro5s9Os+U7JQbopkG219xJLU0h0t1sh5S86
         8deCy/0UEB02vpMm4XU1Uf7V8VVmnzqLS/8CnREb0EYodmr9M/L2h6lAVd5RbRvann6m
         3TVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755265345; x=1755870145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tay3gLmD8Frwd0JSmKUUlrGu9kRRhF6pKhplgXjle5s=;
        b=SMPMhY0J6Z/l8OnvqGs7DBe9Et03UFhIX1pv6ibV0zjE4+MBKZW4d8U8irftv5v1fH
         uxoiJvSo4qTpKeFgJQDKscae+2nt5hsXGdssft9/QJo9EH54lK7aRFy2RN7rYHFcB97K
         7f21uIxW/LQ/JjPK3oA6GvSHsN1iJpCyo2dFvBWN2kAYBe3x7OOdLa7FTLRSbgdJtSSd
         NA3rBzU402FZb6MT04G4qvLkaJuWlHK4PeGKkfGJPoW1aaGogPW8b5CxloJzNcYSoumm
         VHif9KAKIrC934K4Ca/FeQSTfdMuGp01nPWB0gjByxf/iiIc38X18VKPj+omVJInVbsR
         wwgg==
X-Forwarded-Encrypted: i=1; AJvYcCUBgx/Pi/+jqGdPX6g7K1zWmbhKuyfojimIH/lOz8JRT+7TqGuAbJuaXNkMdPeV5QRfFWW3Udg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsMheJSwdHnMHx35qt4N41+1DUyDScY89rGr1ixrDRZaGIMJpW
	MpPQUyy6LlUymgL+iDqhh68YBOOehBBBAPM4R214ZtvpeVU14nKe+zgP9XiU+1PkzAY=
X-Gm-Gg: ASbGncsh6MKHx8/3oJ1WFZtctVG2uznp+1dLsMZ6NZ/qY2+SO/gkT2Ix/aoJ8fk/YlT
	2Gfmh5fjDd/800bkVcmVkl7EPusj+NSgeBHcrmZLjT9KDqn+A8itfnZrOKuNHxAvDk6nu8aIMI6
	JC35fQURovgP/Q9jmar0YAV3Q9PSni+xfN3yaUK+15f5kPoxq+CshYeEHKEOCGmzfFTbwU1wC32
	vJTchjngimJroQPIrLJW6eUMj7kwOiavMa3GFgpTMiWeuosFd5Q3JTt2lBmRHwuhl5rxQYrn3GD
	1NbnQZY12O7K+xjKfYjmWmzp/8SHsA1I/0pGMb1QK9xM6wzfIPKvy9n3XjXs/ycuiYmH7L2wzKy
	oPmby3FPcvjZmmVXdIYUELUBLS1r6GKkGeMalEQsmmH4=
X-Google-Smtp-Source: AGHT+IFlajPT5BztdSNYp4ivjV5fdtLyMwPsBJGF7bEW9Ww4T7y2G/wB+Plg/hRmOIzKKeMUkjMMbQ==
X-Received: by 2002:a05:600c:4590:b0:459:10de:551e with SMTP id 5b1f17b1804b1-45a218575d8mr17339135e9.27.1755265344897;
        Fri, 15 Aug 2025 06:42:24 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45a1c78b33csm62016055e9.25.2025.08.15.06.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 06:42:24 -0700 (PDT)
Date: Fri, 15 Aug 2025 16:42:21 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: icc-bwmon: Fix handling
 dev_pm_opp_find_bw_*() errors
Message-ID: <aJ85PQbujQe-IZUH@stanley.mountain>
References: <20250814063256.10281-2-krzysztof.kozlowski@linaro.org>
 <e35ca54c-252f-45c4-bfdf-fd943f833bc4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e35ca54c-252f-45c4-bfdf-fd943f833bc4@oss.qualcomm.com>

On Thu, Aug 14, 2025 at 11:15:08AM +0200, Konrad Dybcio wrote:
> On 8/14/25 8:32 AM, Krzysztof Kozlowski wrote:
> > The ISR calls dev_pm_opp_find_bw_ceil(), which can return EINVAL, ERANGE
> > or ENODEV, and if that one fails with ERANGE, then it tries again with
> > floor dev_pm_opp_find_bw_floor().
> > 
> > Code misses error checks for two cases:
> > 1. First dev_pm_opp_find_bw_ceil() failed with error different than
> >    ERANGE,
> > 2. Any error from second dev_pm_opp_find_bw_floor().
> > 
> > In an unlikely case these error happened, the code would further
> > dereference the ERR pointer.  Close that possibility and make the code
> > more obvious that all errors are correctly handled.
> > 
> > Reported by Smatch:
> >   icc-bwmon.c:693 bwmon_intr_thread() error: 'target_opp' dereferencing possible ERR_PTR()
> > 
> > Fixes: b9c2ae6cac40 ("soc: qcom: icc-bwmon: Add bandwidth monitoring driver")
> > Cc: <stable@vger.kernel.org>
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Closes: https://lore.kernel.org/r/aJTNEQsRFjrFknG9@stanley.mountain/
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > 
> > ---
> > 
> > Some unreleased smatch, though, because I cannot reproduce the warning,
> > but I imagine Dan keeps the tastiests reports for later. :)
> > ---
> >  drivers/soc/qcom/icc-bwmon.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/soc/qcom/icc-bwmon.c b/drivers/soc/qcom/icc-bwmon.c
> > index 3dfa448bf8cf..597f9025e422 100644
> > --- a/drivers/soc/qcom/icc-bwmon.c
> > +++ b/drivers/soc/qcom/icc-bwmon.c
> > @@ -656,6 +656,9 @@ static irqreturn_t bwmon_intr_thread(int irq, void *dev_id)
> >  	if (IS_ERR(target_opp) && PTR_ERR(target_opp) == -ERANGE)
> >  		target_opp = dev_pm_opp_find_bw_floor(bwmon->dev, &bw_kbps, 0);
> >  
> > +	if (IS_ERR(target_opp))
> > +		return IRQ_HANDLED;
> 
> So the thunk above checks for a ceil freq relative to bw_kbps and then
> if it doesn't exist, for a floor one
> 
> Meaning essentially if we fall into this branch, there's no OPPs in the
> table, which would have been caught in probe

It would be really hard to silence a false positive like this...

regards,
dan carpenter


