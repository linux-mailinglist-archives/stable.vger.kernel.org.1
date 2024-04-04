Return-Path: <stable+bounces-35976-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A72898FF2
	for <lists+stable@lfdr.de>; Thu,  4 Apr 2024 23:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C26712829F7
	for <lists+stable@lfdr.de>; Thu,  4 Apr 2024 21:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686C613BACF;
	Thu,  4 Apr 2024 21:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VkOxH4PZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6642F134CF8
	for <stable@vger.kernel.org>; Thu,  4 Apr 2024 21:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712265223; cv=none; b=jCpckyxjERdH7dTCepJKGppAp7PRaIxSRtnfXJdbUZ3hUoV2v+AQmoL9+uzktOLidbuohk1ZWeu6fpbCqRWwu+oO6flWFBiAdLpXfADmi3REIkOfq1X/RKWUzJyc3pstRNEd25cT6df6Nb++G+CH8qF7Z/MhmZ4JJo0AVyvMDQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712265223; c=relaxed/simple;
	bh=s9wwL23thTprrqQZ5wXrDwmYHVyBkc8YlW0ql+daai0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dn1TxAEHJXRnMD9STSNxLUGfo8JL5GvZh9B2RIrs+PneCxLthlNNoS2aY6p1Rb5NZDJatlW9UMGuB4q37TZf+j/8dPqF/TjuKNsw+l32bg6VRiEViu8HLuLGar76ouaY1OntX5acSzRXjb8KOropoyj9TpOp81dQ5bnJ/pd9i9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VkOxH4PZ; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6151e2d037dso17343897b3.3
        for <stable@vger.kernel.org>; Thu, 04 Apr 2024 14:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712265219; x=1712870019; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s9wwL23thTprrqQZ5wXrDwmYHVyBkc8YlW0ql+daai0=;
        b=VkOxH4PZ7ve7D7LfwdEUJPzVPbSfTaFeTpr+gNHWXiAfodLp3YWewCKjOMMULmPTLx
         zvYo1QgjKhbkzj54exC17ZXzSZEQZcTLtvxrgjHkTTH1HTSPRS9YZAzNAKiAOzLt2SrS
         9308pt2J9xVqcYmxw65EOr013jDXm+pjg28YcpobcMDZVRSpRe5wgHK3AilmDn4oPZre
         BIVfS75gS+4Ue2/8us1eg7Wf+F4yze0lS5DdD/Q2S+Qs1xxRwTl8g9gRjbzETvf3tRs8
         ZCbmzbzGWEYitfDQlVkRNkihB2bxVN4dY08AQAiUciM4SIjDqBu6n7SzsxqgHz6y6qES
         YttQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712265219; x=1712870019;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s9wwL23thTprrqQZ5wXrDwmYHVyBkc8YlW0ql+daai0=;
        b=V5B3+an9Uw+De0VAPP8Pwnz/SMMRM6QDulaR7SdKEzNW9UBBZgEdyqJonTzl+BdG9O
         kYnervj44qAnvAC74F5WI0bRCzj2z3kq/S9ijt9oGok7+q/YO+bszMosuUw17hwtdSF7
         odXJALhVisScGEQV4t4ePJjxg6v9ybFMYCOK5AhRyRfKgSmAfDkCxsQxNv0poAI+i6XY
         hwt5HSoMNNbg481adze8ij4PowcE8TX36/PYgi0o3NrLwhucGrSDCnClLS9bDttZOxkU
         NT+eH2PoHWTZm4idlT8E1WoLyaogyVhsSduoF2iH4MnqwvvNxAY4xPrDMSbV2oP4ODZh
         22HA==
X-Forwarded-Encrypted: i=1; AJvYcCUVGqNaGiVrPcXXvPziXh8V18IOSrojLUfuZ6T3U1Ch0AjUpjBvSbvL8p49cpGIKVDXP4UWDdSur4lMtev2wP6K3kuUL5aI
X-Gm-Message-State: AOJu0YylKQcAjc9jWJuGAmHqIRWDLqkNCyJ0QCKNvfGxXcUD284pdVEl
	nsPUX3Z7UTf3dRSl/npx72k6nIEnS4qB6Z84FbY8UfdBW00IiYzubwA2b3wNKzvB6PfY9Z2nyuy
	dWDeC2tnEd3uEYFfF0y8xMtgi55mxnroZXrsemQ==
X-Google-Smtp-Source: AGHT+IGsrooHF667jpjcxcb99/DcW0fwSfThU7HKVDtxh2RCICQMVyfcyBMKfj/nqQt9pNEkvEvrius1N2V1oudQtq8=
X-Received: by 2002:a25:c744:0:b0:dc2:398b:fa08 with SMTP id
 w65-20020a25c744000000b00dc2398bfa08mr3804202ybe.31.1712265219410; Thu, 04
 Apr 2024 14:13:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321-sdhci-mmc-suspend-v1-1-fbc555a64400@8devices.com>
 <2e712cf6-7521-4c0b-b6fd-76bacc309496@intel.com> <CAPDyKFoBgwWDXhcXsbCfBD_nJ=3w1e5eReqHgDQ1BiPf0zJRxw@mail.gmail.com>
 <5bce008a-8354-4ccd-af1f-b7f2b2caf3bc@intel.com> <77d76e3b-549e-4d26-834c-a59b91fbb2a0@intel.com>
In-Reply-To: <77d76e3b-549e-4d26-834c-a59b91fbb2a0@intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 4 Apr 2024 23:13:02 +0200
Message-ID: <CAPDyKFrx3OdQqzfUvfi_tsoA0Am2rf6HKSrzL1qg77p50BZ3Lw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-msm: pervent access to suspended controller
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Mantas Pucka <mantas@8devices.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Georgi Djakov <djakov@kernel.org>, 
	Pramod Gurav <pramod.gurav@linaro.org>, Ritesh Harjani <ritesh.list@gmail.com>, 
	linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Thierry Reding <thierry.reding@gmail.com>, Liming Sun <limings@nvidia.com>, 
	Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Apr 2024 at 20:42, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 28/03/24 16:20, Adrian Hunter wrote:
> > On 27/03/24 17:17, Ulf Hansson wrote:
> >> On Tue, 26 Mar 2024 at 11:25, Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>>
> >>> On 21/03/24 16:30, Mantas Pucka wrote:
> >>>> Generic sdhci code registers LED device and uses host->runtime_suspended
> >>>> flag to protect access to it. The sdhci-msm driver doesn't set this flag,
> >>>> which causes a crash when LED is accessed while controller is runtime
> >>>> suspended. Fix this by setting the flag correctly.
> >>>>
> >>>> Cc: stable@vger.kernel.org
> >>>> Fixes: 67e6db113c90 ("mmc: sdhci-msm: Add pm_runtime and system PM support")
> >>>> Signed-off-by: Mantas Pucka <mantas@8devices.com>
> >>>
> >>> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> >>
> >> Looks like this problem may exist for other sdhci drivers too. In
> >> particular for those that enables runtime PM, don't set
> >> SDHCI_QUIRK_NO_LED and don't use sdhci_runtime|suspend_resume_host().
> >>
> >> Don't know if there is a better way to address this, if not on a case
> >> by case basis. Do you have any thoughts about this?
> >
> > Yes probably case by case, but I will look at it.
>
> There seem to be 3 that use runtime pm but not
> sdhci_runtime_suspend_host():
>
> 1. dwcmshc_runtime_suspend() : only turns off the card clock
> via SDHCI_CLOCK_CONTROL register, so registers are presumably
> still accessible
>
> 2. gl9763e_runtime_suspend() : ditto
>
> 3. sdhci_tegra_runtime_suspend() : disables the functional
> clock via clk_disable_unprepare(), so registers are presumably
> still accessible
>
> sdhci_msm_runtime_suspend() is different because it also turns
> off the interface clock.
>
> But it looks like there are no similar cases.

Not sure we should care, but it still looks a bit fragile to me. We
may also have a power-domain hooked up to the device, that could get
power gated too, in which case it's likely affecting the access to
registers.

Kind regards
Uffe

