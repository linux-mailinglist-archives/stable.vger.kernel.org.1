Return-Path: <stable+bounces-10037-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E4E827216
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 16:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DAC4284488
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 15:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C3546B81;
	Mon,  8 Jan 2024 15:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eZvdNJQW"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FCB5100D
	for <stable@vger.kernel.org>; Mon,  8 Jan 2024 15:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2045bedb806so1951136fac.3
        for <stable@vger.kernel.org>; Mon, 08 Jan 2024 07:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704726217; x=1705331017; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yUiP3KKGR0mBVVVBBTQ0Scya9qBaQyaIesgAU/UrY5k=;
        b=eZvdNJQW3yYjj6nniJviqlngKEPYy5b3ffrrru6OUR3BeBXxjaq5gn6CrUK7SCX6Jt
         UVpJGvGPwfEiavAW6rpM8DawmpwWqaCHw7wikkQdxTKPJ0QlSKx9QJtyqCkXzrT3Ht6Y
         Cg/6PvuECGrnVZV5f+R8c+KS9Ppy2PCBK+ffIb/z6jkIS6XQYIPull4Ka+1hCNSm2YaB
         1TqJOPGT+zZk6AEfAtvx5qMjZ+xtWoUWZ4rN2LKKQSdjLj0UnRMibZvmfO614h8q14Jg
         J5j1V3rXtA16qBSvn5kEF5uwJPkPEAqiXFxRBxTR9LSQz1igFB039XcnQeDALRKEdkbj
         8ukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704726217; x=1705331017;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yUiP3KKGR0mBVVVBBTQ0Scya9qBaQyaIesgAU/UrY5k=;
        b=fXgmOe23sNCxVP34NiEY8ab/7RSuRO0igEc23T0efedJxUedYB+Ae7EhTmm56UcNqS
         gVhBhN3kqzmsiOUdgHMFQbyTKl/c1aRWOPY9VjHMipsqZj6j5RXSCugtwNRarl9CEUD1
         kWf7UM5Oht19gDFeVTpPZSTYjn1UroKMbpetMLeiWQDWlpK3O7W+W4Snn4/IUu6lQyRr
         /xKCnXmz8nAmv7e6adYpQCx//K1pByT8eP7Od7xyPbvnjWFZnOspcYGn93QwWW1EN4tb
         GN13MP1DD4JMcaTHD9xb00p7EY6s52zu3H0NrCYDb8W0FL1NSjw32FUklJWTpSFd3tGb
         SdEQ==
X-Gm-Message-State: AOJu0Yw4MXJn8Kec7Ts43tHaOBsksAAHavxoT1tksESkP0vbJ/cPtmi5
	UmZb01wV4VwaCmsOKimY/mupvcWRzVyTj16mF/IvAOVPuJ5x6g==
X-Google-Smtp-Source: AGHT+IE80XL1LnyT+wMEKISvh/W678Gi3bEA0D0jl7KoK0yscUgs0E7tx6xp4rRwOy/41XDUnzSDq/POGegGOCJceEI=
X-Received: by 2002:a05:6870:a3c7:b0:203:64c3:7b86 with SMTP id
 h7-20020a056870a3c700b0020364c37b86mr5462616oak.44.1704726216940; Mon, 08 Jan
 2024 07:03:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240107155702.3395873-1-amit.pundir@linaro.org> <2024010850-latch-occupancy-e727@gregkh>
In-Reply-To: <2024010850-latch-occupancy-e727@gregkh>
From: Amit Pundir <amit.pundir@linaro.org>
Date: Mon, 8 Jan 2024 20:33:00 +0530
Message-ID: <CAMi1Hd37L6NYKNpGOUnT7EO8kfc-HVQUqnoTTARA5gTpTc2wXQ@mail.gmail.com>
Subject: Re: [PATCH for-6.1.y] Revert "interconnect: qcom: sm8250: Enable sync_state"
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, Georgi Djakov <djakov@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Stable <stable@vger.kernel.org>, 
	Yongqin Liu <yongqin.liu@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Jan 2024 at 19:42, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sun, Jan 07, 2024 at 09:27:02PM +0530, Amit Pundir wrote:
> > This reverts commit 3637f6bdfe2ccd53c493836b6e43c9a73e4513b3 which is
> > commit bfc7db1cb94ad664546d70212699f8cc6c539e8c upstream.
> >
> > This resulted in boot regression on RB5 (sm8250), causing the device
> > to hard crash into USB crash dump mode everytime.
> >
> > Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
>
> Any link to that report?  Is this also an issue in 6.7 and/or 6.6.y?

Here is a fresh RB5 crash report running AOSP with upstream v6.1.71
https://lkft.validation.linaro.org/scheduler/job/7151629#L4239

I do not see this crash on v6.7.

I have not tested v6.6.y yet. I'll test and submit a revert if I see
this crash there as well.

Regards,
Amit Pundir

>
> thanks,
>
> greg k-h
>

