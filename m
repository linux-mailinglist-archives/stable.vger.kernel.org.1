Return-Path: <stable+bounces-81200-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A582A992117
	for <lists+stable@lfdr.de>; Sun,  6 Oct 2024 22:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 481D2281C97
	for <lists+stable@lfdr.de>; Sun,  6 Oct 2024 20:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC3018A6B8;
	Sun,  6 Oct 2024 20:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bsX7bzCN"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD70E170828
	for <stable@vger.kernel.org>; Sun,  6 Oct 2024 20:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728246235; cv=none; b=rerdAjvVOlmQWCXSQttkmfkgzDGogAPdvHWWkvyasSK/xWwHShIL/EVFmYGBUbWJ074Z/k0NZXvtGIKXFV8KLQpjeZJj8+r23fB8V5SoD+9MDTJECL8rIT/CSBRXFCsR9Wz2c42NI6eMlvEAkj16kusCY+T6qu5RLND58Y812Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728246235; c=relaxed/simple;
	bh=9/IyMAHv2eIUwA3++BDoFfJTjz9glj1kN3V5KZf62zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XelUkw6g1AozdwWHkrWvBIEEUCY8A4VuPQQWpoq4fF9nLdiU3ySQcxERVuSrMvWQyWSQw7LT892RbHc6XKToYa9vb0ff7p99JZamWENIbJePCD/ei8IwVEkyIRhKGJ0ghGoW4RaFEcrkhl4CjrfJuc/VupjLBfAWuIP5ot022fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bsX7bzCN; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fabd2c4ac0so39776351fa.1
        for <stable@vger.kernel.org>; Sun, 06 Oct 2024 13:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728246232; x=1728851032; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SjmOkhGoHww5SsWhWZcZeAeLgnv0SYVUTlVXfaGN1Ts=;
        b=bsX7bzCN2dWNd5KfRJ7ThQLPoD2tF5hVQnf4P0dEJujUw2RjfZv2E17gqnQkU8aajo
         N3AgsJGceXWv8Z5SDlr8lBKvtpPvg1ALtMkKVkMyYWiEu7jfVtxSvwD7p2Nbh8HWl+ar
         BK9SJZ9kPoPQwhhHVBziGi+JToeQOveUpeYRc/RVyK4YGpwXq/05aTDPi8rmB8AvILgr
         2y4Nj+vVQqmANkbAcIF0ZyzaaQmXekzmHU8l8dXTgW0P/KbbaS8aQifIf1ACeHyB3IGn
         x5HAaC2pqWFULwD0eN+PbQ9x5M3b3q4E12fWTkBggLaZYJVRyhd9AQBe2WxFHVBlPW80
         p+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728246232; x=1728851032;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SjmOkhGoHww5SsWhWZcZeAeLgnv0SYVUTlVXfaGN1Ts=;
        b=Z9NtJwXorcJyrzmj4U9jnedvxWjMeEw3Ocf9j6QVMYJ43ylsBpb38pYNuzvRnP5Bym
         jvMbRREfldpFwaobk83886n3N2E+Qa23+uxEqZsfdcHoF/kHQi5jH/QNfKo3h6r93SCf
         bpyQNONMvbE73XZqp3G40mNtcLsb0miv2IzB9diLFBkpxLbNGthAqQsL0S1rJob2PQyH
         /Vr2a6UEM5wTAriBRrT48WyOJevZ0SYrlFK383nYcG0iYuOgX4N05qcZgw05ik/FEpaM
         aHgwmOLLbzAP9iT9H41IUbj5FzE6UJPBOCsfuXO8bCJO/b6+F+qFXpvpiPL8sqtVyEnN
         J8Zw==
X-Forwarded-Encrypted: i=1; AJvYcCWpwiUqTgeYJ/oEhWC4+b0UU7i1qCu7uqKlONLbQ4/MTptL/pvDdpCkcwhsnv/yj/uWpe74ygU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVug6vYoJYyDfAMDT2lav3krKOMPsINO13uyiD8/CMPoPl+JT1
	STXyXnKPQdIswAuWKoyLK8VI9DmbL2nHqXRvwAbuHaiL+ZY7dBPOkwrfW4FwqX0=
X-Google-Smtp-Source: AGHT+IE9Ou+NDUiMJlp5CAdop1NdXKTU8QhE3wA1kzmQkrSFmqoSvuA4HniJwQ6rP+n6zCcA1stj9w==
X-Received: by 2002:a05:6512:398b:b0:536:a695:9429 with SMTP id 2adb3069b0e04-539ab8625a4mr4460950e87.10.1728246231828;
        Sun, 06 Oct 2024 13:23:51 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00-89ea-67f6-92cd-b49.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:89ea:67f6:92cd:b49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539aff1d0c8sm602410e87.130.2024.10.06.13.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 13:23:51 -0700 (PDT)
Date: Sun, 6 Oct 2024 23:23:48 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Gax-c <zichenxie0106@gmail.com>
Cc: gregkh@linuxfoundation.org, broonie@kernel.org, lgirdwood@gmail.com, 
	linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, perex@perex.cz, tiwai@suse.com, 
	rohitkr@codeaurora.org, srinivas.kandagatla@linaro.org, stable@vger.kernel.org, 
	alsa-devel@alsa-project.org, chenyuan0y@gmail.com, zzjas98@gmail.com
Subject: Re: [PATCH] ASoC: qcom: Fix NULL Dereference in
 asoc_qcom_lpass_cpu_platform_probe()
Message-ID: <r6bumoyhuu53kz57tqlcscitpyi67tb7422d2kffifzpqyphfz@agniiovymvdw>
References: <2024100358-crewmate-headwear-164e@gregkh>
 <20241003152739.9650-1-zichenxie0106@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003152739.9650-1-zichenxie0106@gmail.com>

On Thu, Oct 03, 2024 at 10:27:39AM GMT, Gax-c wrote:
> From: Zichen Xie <zichenxie0106@gmail.com>
> 
> A devm_kzalloc() in asoc_qcom_lpass_cpu_platform_probe() could
> possibly return NULL pointer. NULL Pointer Dereference may be
> triggerred without addtional check.
> Add a NULL check for the returned pointer.
> 
> Fixes: b5022a36d28f ("ASoC: qcom: lpass: Use regmap_field for i2sctl and dmactl registers")
> Signed-off-by: Zichen Xie <zichenxie0106@gmail.com>
> Cc: stable@vger.kernel.org

I think Fixes / Cc / Signed-off-by is more logical.

> ---
>  sound/soc/qcom/lpass-cpu.c | 2 ++
>  1 file changed, 2 insertions(+)
> 

This is version two of your patch (even though the patch contents didn't
change). Please tag your patches accordingly, provide a changelog and
don't send next iteration as a reply to the existing thread (it might
get lost or mishandled). Please send a proper v3 of your patch.

-- 
With best wishes
Dmitry

