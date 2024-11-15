Return-Path: <stable+bounces-93551-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C719CE121
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 15:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45DA11F21D59
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 14:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DF11CEE9A;
	Fri, 15 Nov 2024 14:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XhaFh2Yi"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2851C07F6
	for <stable@vger.kernel.org>; Fri, 15 Nov 2024 14:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731680426; cv=none; b=ci/d2WAQnl6ZbQ+adrgHmTFDbIxxmc1cLq0XLCXwEou3QTaH9XI3qRlvIK0ZsWGUHxNOD1XVuj6EOq678za2Qf2paoCZPjXQyj27BX31SEqp4fDmgyyUmfLKnsrFzMDMPzaKD9QLo4H6O8hEq/QdaSrPMxnQMhAVp+1VhX1iPdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731680426; c=relaxed/simple;
	bh=E+N7hANlUNnWzMAxdQP13OfBphSSO9L7QTGOneJcRxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LBuRg9yG/naCt08JB0fzAE9VH4kmasbS3zqA2KiS0KVPzm1jV0kzp2rxii6111tEpeOcrS2gGYJQ3oHHoD9Gm2I8T9OKvtSXSKofUOCXfRIfHwoMctC14IV02auQJkC8Oj7Yi4SJnUUmXViKHbI3uAcCSmC5V0z5I/bSAHt9lM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XhaFh2Yi; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539d9fffea1so1840551e87.2
        for <stable@vger.kernel.org>; Fri, 15 Nov 2024 06:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731680422; x=1732285222; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9kxLZh7oIW/Qu6MO9UxZ5HRBg1gE82+4pLIY8QLKtus=;
        b=XhaFh2Yi3+XTMP/pWXhSckGwjpIJPYO8RF1/ae5fapU+l2o5ZDXYcsaKtx7c8+9stJ
         2gZ81gmL+dehmuqKWcbXkrKNnNlgo6j/KY7WtFMzX/FWaEYelZXM02W4sTT2lSHGHi3m
         x94V1hwUu3mscnpcfhCrsIsI28D2b/iWa4W4ZRJ8G/LRPslX5/J8IRio0pYGja14QErR
         PrjqJHlLrUd6bylrra7KtdPdCTdwx2Gxh0zrjKjdySs3viQJpBlt3TgiS9QLiCS/JXmN
         CUZU0l1pr1kbXHxCEj+mgpCfgLh4miriMV+K66OWmUe8jY0RfQWWXUSQuIPP7/LojFyh
         C8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731680422; x=1732285222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kxLZh7oIW/Qu6MO9UxZ5HRBg1gE82+4pLIY8QLKtus=;
        b=jhKCtJyGMEwQrJDJTOzcWJ1iSvRKeHRuV1KhNHV4RTNbR62FcIPGZlvN+PsaZG+Cs5
         oGmCk5glnJ68OJiT3AFhNDOBO7O5FRYS3o9H7LfA8v1rAUflajmfRd/z1BmyeuBaLOhq
         MqmUtFPvhL1bTDZO7WxB0ZHdVZCNG6ACEUO8VR51x6sgGdDYifl/ghIwhGGDurlqAWpi
         Zk6xMhvNy0UJElXCDJUxXRPjsCztOsFEyIQUBnkDkYtlBDbREhzWJ3Tp3S6eKNysXqAN
         9u8/Er2cE7iOsKB2vp3xbTHYF7PNnWyyW6IdgkUPRMzwP9+4qXmRVs7Q/30zPKcCERgp
         h/1w==
X-Forwarded-Encrypted: i=1; AJvYcCWPOA4ve8I6ng3CmWEMJg0vLE3a9u6PPIDr+mmfLvQ+A/Fw55hmwn37lreBIPWSnmgUKYMI1vs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmEYgXnwHk7V2RSQgVtNanXalBUTl3tMSamCXTz6rEAlrDg4DN
	TPM0XkdXOE5YTDDYmusfcKx7hYQbN+HiSLijC7Xq8SAafWhmWT7/Ctrjgg0B8M8=
X-Google-Smtp-Source: AGHT+IEBU8A15vScg0ia4WplSofYKJIuXC0KSALSXA7EzvPsyMeCtNrpJisnibjIPA6EZmUQQ6oJwQ==
X-Received: by 2002:a05:6512:3a88:b0:539:96a1:e4cf with SMTP id 2adb3069b0e04-53dab2ab63fmr1545621e87.32.1731680422383;
        Fri, 15 Nov 2024 06:20:22 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53da6549034sm584101e87.272.2024.11.15.06.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 06:20:21 -0800 (PST)
Date: Fri, 15 Nov 2024 16:20:18 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Abel Vesa <abel.vesa@linaro.org>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Johan Hovold <johan@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dpu: fix x1e80100 intf_6 underrun/vsync interrupt
Message-ID: <7qx65y6o4fvnnnspof2exzk7xru4bgpda43655deeu7hw6wowt@zcnpzyw2xutm>
References: <20241115-x1e80100-dp2-fix-v1-1-727b9fe6f390@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115-x1e80100-dp2-fix-v1-1-727b9fe6f390@linaro.org>

On Fri, Nov 15, 2024 at 01:55:13PM +0100, Stephan Gerhold wrote:
> The IRQ indexes for the intf_6 underrun/vsync interrupts are swapped.
> DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 16) is the actual underrun interrupt and
> DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 17) is the vsync interrupt.
> 
> This causes timeout errors when using the DP2 controller, e.g.
>   [dpu error]enc37 frame done timeout
>   *ERROR* irq timeout id=37, intf_mode=INTF_MODE_VIDEO intf=6 wb=-1, pp=2, intr=0
>   *ERROR* wait disable failed: id:37 intf:6 ret:-110
> 
> Correct them to fix these errors and make DP2 work properly.
> 
> Cc: stable@vger.kernel.org
> Fixes: e3b1f369db5a ("drm/msm/dpu: Add X1E80100 support")
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

This matches other DPU hardware, so

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

