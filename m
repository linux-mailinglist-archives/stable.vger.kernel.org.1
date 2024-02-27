Return-Path: <stable+bounces-23791-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AA3868695
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 03:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C481D28BBBD
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 02:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E03107A0;
	Tue, 27 Feb 2024 02:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p3iOFnrb"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF03D304
	for <stable@vger.kernel.org>; Tue, 27 Feb 2024 02:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708999685; cv=none; b=KmWsvltu1qBX4HKVfbrWn3tf9Q1DTUx3Uqurf6kdbtne/elnGcPaU5RNj3rIaL+Ywk8PzZft4F+KaelkKe7JGyWnvhk5ufPFNzj3WT4c+6r8MVDPuk1wG/sUUxcjf6nGnMMOfNkq6odhJ8q1gC5HxP4UoexBZEuH2Z7ByfO5wqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708999685; c=relaxed/simple;
	bh=e20cSwHxUYKaM7UrngPan3hSH8QhKOwaTuiejGgEcE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PJ+FfCNVQuh/Z591rv0U55KzDvmnf6jQFU4xtiCHe6wU6II9WRZHlons9Hkb5MNzpgktmFbsr/BZS88qfqw/00FTvWtqyanQf2UuPfWPvrTuc96Pj431D5qMznOISNfnCcVUDfqN7ePYi/9l8z5UyB3N9/wu18Us7PgA0vP2J3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p3iOFnrb; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-512f89250d6so2095850e87.2
        for <stable@vger.kernel.org>; Mon, 26 Feb 2024 18:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708999681; x=1709604481; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pKgrsbDtRhtTwJSZwi3Iuzq+IR/GTbO5ckHV4gkPPIQ=;
        b=p3iOFnrbTQr/7RKe5s/anuR/LwIioxh3JG8ddLkcRNGnuphUUYQjc3X1UEVEnL8AsJ
         0zUMkNNHTq4iiIWeBkgBRFshqt5D4p5R5i1BqQ8FRQsIVK3ZURlaNljgkmQJ/+ddxH73
         ImUMW6sz18ltZJqX6DsNS4pKreDclyOXsxacBfjNo6LPXkURgT6S4jS2vXjBDgWNYSs+
         WTb87u/n1R6gRoubcjE2DP7tWm35saG4sZ+s7iC4cbGL20zh0RvI38IE0CuxrV5WHTR0
         6s6+XcgEcRjG8raaZ8B3YmO1yAR/5ChFwb0aiQO/X+sAyWUvweSl7CEuT0+drOycake0
         eboA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708999681; x=1709604481;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pKgrsbDtRhtTwJSZwi3Iuzq+IR/GTbO5ckHV4gkPPIQ=;
        b=vr1BzRbZ6Z3bYPJYehq8tDwo/0LLPoOX7J2/KdVa40/7TTunSoyJ6gKCqmz4PQcMdc
         snd2KSPzAusYSdW/hzBmExKINpY4Zqm2osi011ZO7NDAPens52akoLkG2+1yjW7ZxVdF
         erkDxJYciAEPhhmSbr8t/b7T3i56KDsSpLJr+gVRRyND4N1Xol8QP5eQvFkLY4hSKo8k
         vgHGx3lVhhMisuhU2tC7ZtqwZLZlTuMqaHb9s/FHTmc6Bht/VPvSvJ3vQmc4Soi1rf/q
         gK4X3IZwXm87GQ3pebtR0Mfc+7PWe6810fHggLEmnyMDVdM10ChuHbQn0JDD0q9jDUyV
         xPhw==
X-Forwarded-Encrypted: i=1; AJvYcCWcDtBXoc/SPSBf+YEWht0lNc1bkuqtMxrx1I8Oq04vGSk7ykWhlre0fe3EOWu4dZkaZqx1tTru9eKJJbLc/N/mkHMH2gfN
X-Gm-Message-State: AOJu0YwDQDPmSCgmoFSSsqFN720dnoAdAG23Ccjn79uPzybM320Hy7FB
	UmDaT8OC3vRCseVkGs/DfjKga6tFSA7DMPny1USSNqIDeCD1vEGdGPFg2i3E5WU=
X-Google-Smtp-Source: AGHT+IGXqMoQl1y3QKQ7aoLgd/YCYjjNvpDVJY5uZK5Inh7UBk//uGb/IfQsf0Y8r17C33Kt0AmV4Q==
X-Received: by 2002:a05:6512:324f:b0:512:b84e:e7a1 with SMTP id c15-20020a056512324f00b00512b84ee7a1mr4873359lfr.5.1708999680724;
        Mon, 26 Feb 2024 18:08:00 -0800 (PST)
Received: from [172.30.204.180] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id r28-20020ac25a5c000000b00512e40ef364sm1035102lfn.108.2024.02.26.18.07.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 18:08:00 -0800 (PST)
Message-ID: <615042d9-4a8c-45c2-be17-756e9635a8af@linaro.org>
Date: Tue, 27 Feb 2024 03:07:59 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pmdomain: qcom: rpmhpd: Fix enabled_corner aggregation
Content-Language: en-US
To: quic_bjorande@quicinc.com, Bjorn Andersson <andersson@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Stephen Boyd <swboyd@chromium.org>,
 Johan Hovold <johan+linaro@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
 stable@vger.kernel.org
References: <20240226-rpmhpd-enable-corner-fix-v1-1-68c004cec48c@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240226-rpmhpd-enable-corner-fix-v1-1-68c004cec48c@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/27/24 02:49, Bjorn Andersson via B4 Relay wrote:
> From: Bjorn Andersson <quic_bjorande@quicinc.com>
> 
> Commit 'e3e56c050ab6 ("soc: qcom: rpmhpd: Make power_on actually enable
> the domain")' aimed to make sure that a power-domain that is being
> enabled without any particular performance-state requested will at least
> turn the rail on, to avoid filling DeviceTree with otherwise unnecessary
> required-opps properties.
> 
> But in the event that aggregation happens on a disabled power-domain, with
> an enabled peer without performance-state, both the local and peer
> corner are 0. The peer's enabled_corner is not considered, with the
> result that the underlying (shared) resource is disabled.
> 
> One case where this can be observed is when the display stack keeps mmcx
> enabled (but without a particular performance-state vote) in order to
> access registers and sync_state happens in the rpmhpd driver. As mmcx_ao
> is flushed the state of the peer (mmcx) is not considered and mmcx_ao
> ends up turning off "mmcx.lvl" underneath mmcx. This has been observed
> several times, but has been painted over in DeviceTree by adding an
> explicit vote for the lowest non-disabled performance-state.
> 
> Fixes: e3e56c050ab6 ("soc: qcom: rpmhpd: Make power_on actually enable the domain")
> Reported-by: Johan Hovold <johan@kernel.org>
> Closes: https://lore.kernel.org/linux-arm-msm/ZdMwZa98L23mu3u6@hovoldconsulting.com/
> Cc:  <stable@vger.kernel.org>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
> This issue is the root cause of a display regression on SC8280XP boards,
> resulting in the system often resetting during boot. It was exposed by
> the refactoring of the DisplayPort driver in v6.8-rc1.
> ---

Very good find, thanks!

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

