Return-Path: <stable+bounces-171896-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CD5B2DB4F
	for <lists+stable@lfdr.de>; Wed, 20 Aug 2025 13:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5C8F3A1FC9
	for <lists+stable@lfdr.de>; Wed, 20 Aug 2025 11:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21762DCC03;
	Wed, 20 Aug 2025 11:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dGZ0heH2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA692367AE
	for <stable@vger.kernel.org>; Wed, 20 Aug 2025 11:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755690052; cv=none; b=nSNBlNIJLA/3fJynxT0raYladV+ZDDlx3jXj+paYwybw2RvAMbpGqub7zhouRxMm7xRr+A9/9GnGX2krBtnhpLMnHlGp7BUSzAL8K/BS0+4VQDTMvZM4jPFTMCc2Q0XhLOhFPe3maa8GNcBM8SsVzeJk+8aVDZ0O8zSJ12RKwfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755690052; c=relaxed/simple;
	bh=JjhHjJfwbaeN+Rcd9I9ii1W+H6PAnjqDFDKeLrmQKQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bCrAdTVE0tl/fTld/cGJR/4VVmUxu7fl6FpN5O2FCoTYEqTTj1yGtTVOpwUTZT0PM7f7cALCpJRVfuRZsEE3Fri76wMK+3YeAgmU3Z5MSdqrXRUYyISNKFyVluk8Mx2YlYTHRTR1cBqsMFgCSPNmk1/mLnOX5B+pCi9tG1t9I0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dGZ0heH2; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b477029ea5eso8232a12.3
        for <stable@vger.kernel.org>; Wed, 20 Aug 2025 04:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755690050; x=1756294850; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=26dVySXraRVWkX1dA4A+YxZnuQpE5T+9coDuoubCcC0=;
        b=dGZ0heH2LQQi8eQAbV8lNOr7sVRFT12WGnSiAlf+QwAeWgu0iFY5yV7YawGTXnVXnv
         y7JfoX6Ndri7vxhx/cc+sA8/FkzmR+3BRttuLUhC91m4h2I+HFl0sIukGtGeT5nZeIWj
         YZmq3CmCcnXAFWoKb9kcGWFMNVSQCdqghm/crh1HqUONJ/TKlktIOXW1PSKKuAHXqOUL
         K9sGj6CK3dP77XC0Fhv17t5+rszpdJt1s+rwm5271pmHgl6Jsn64voBIgLRHfdxVljRv
         tJyqQ7e1CbR1nK7SDvvt4zcAq91YWXiym4RxIymV3zvm+cxZEnJj/+L+Joa3oLYb2idl
         LJtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755690050; x=1756294850;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=26dVySXraRVWkX1dA4A+YxZnuQpE5T+9coDuoubCcC0=;
        b=GH/Lh+0qRDONVy+jv8B+KfjYbSyHE4q7djHLnIX8J8jgXDxZ6/dUsbO5z1tIGgMrKQ
         buDP+PoQ9/NLWEAYc5+IG5aa1YPAImRM+ni9/gl9TPoIDjRKQPfACwhJ2iPo4+Nx8r9s
         Nr024qrbTNCMYRfoE1FjGMzYVuzQmBXu0R/Ry62nGHNZiI/62RpdftYxn3Kai+xwIm/5
         RM8amPFkuHzXmmamuTABxg5dZZIPLPWNKyz44OatIsDzPjcE5NZMr5nPkFtoxZwPtZV8
         nt4bUmnWJf8kDLwL9giCpVSda3+grR1maJl+Wdolgq7iqJVRo/Ush+2S4cNICgsm/WZL
         jOdA==
X-Forwarded-Encrypted: i=1; AJvYcCVre7zZQVOKxlq2gTp+WBWhVIep6j7iu8j4rrQP0Eeezcopfqr7Rf7A0hsN7YqJcy/UVGRSqPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjpewHF5UmmP9QRD7HsBps4sz0h8Am20rU4HLVu7xcdqTNbMr6
	++EsvNmLEsGePa2HBfFeS9bhkvTDnT0oS7UX4dGdMWW33sqnHIXwRNb5y6EgbGI7j79USO7tEEg
	Sr/MoE4l4zS9Gi/e4bxOzHXJxYHrl1XyhVZm+Wth56g==
X-Gm-Gg: ASbGncstkRFUsRCMHY9Dfgvj7xovmxBEV6qLlwhZzALrDwl4s7Gd9osDBTHei1bC9HG
	Jg0x0HBu1fR5na2t13O0OZODIlOjvDBuiFuJEWc90ok3OI16xygxlHMgLn2FtDpeucaNZjk5eeP
	WKRzzyqU8ndIe4bFM2+5iFek8Qbfs/jSW5EsUTBEyqjlekV2gtD++ojtwSyOiLo6Q6aRu2rlpXT
	b4/DlhqRI6C6wnW+8RDvy6h4WAodVDUUhjiQ3hC
X-Google-Smtp-Source: AGHT+IF8AmOWHIAq7OQoSlww7khUMix7+VlH6RDk4aiFzmID1OwQtiwCZOi9WHpVW5C0l6kM2GONs0FeQiAhF1yLTi8=
X-Received: by 2002:a17:903:110c:b0:23f:c760:fdf0 with SMTP id
 d9443c01a7336-245ef25bb45mr33670985ad.45.1755690050527; Wed, 20 Aug 2025
 04:40:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819122834.836683687@linuxfoundation.org> <bb8ebf36-fb7c-470c-89e7-e6607460c973@sirena.org.uk>
 <2025082058-imprint-capital-e12c@gregkh> <c6232128-6bc5-4f84-af15-43e2fce6d619@sirena.org.uk>
In-Reply-To: <c6232128-6bc5-4f84-af15-43e2fce6d619@sirena.org.uk>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 20 Aug 2025 17:10:39 +0530
X-Gm-Features: Ac12FXwfvMit070C0xIS0xD7Ba2mGdVD4TnOncv3FB6dUHXIhTLgwE-oFgQbp-E
Message-ID: <CA+G9fYua4gFQeXs_SwnRFv=KtAu2o8es7kjA8KRq=KySap1A9Q@mail.gmail.com>
Subject: Re: [PATCH 6.15 000/509] 6.15.11-rc2 review
To: Mark Brown <broonie@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, 
	conor@kernel.org, hargar@microsoft.com, achill@achill.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Aug 2025 at 16:49, Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Aug 20, 2025 at 01:14:14PM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Aug 20, 2025 at 11:57:57AM +0100, Mark Brown wrote:
>
> > > # first bad commit: [3b03bb96f7485981aa3c59b26b4d3a1c700ba9f3] eventpoll: Fix semi-unbounded recursion
>
> > I thought the LTP test was going to be fixed, what happened to that?
>
> I have no recollection of being looped into that discussion so this is
> still exactly the same LTP image as I was running before.  Do you have
> any references, is this something that's in a released LTP?

The following patch merged into LTP master and it will be available from
the next LTP release.

syscalls/epoll_ctl04: add ELOOP to expected errnos

Kernel commit f2e467a48287 ("eventpoll: Fix semi-unbounded recursion")
added an extra checks for determining the maximum depth of an upwards
walk, which starting with 6.17-rc kernels now hits ELOOP before EINVAL.

Add ELOOP to list of expected errnos.

Link:  - https://lore.kernel.org/ltp/39ee7abdee12e22074b40d46775d69d37725b932.1754386027.git.jstancek@redhat.com/
- https://github.com/linux-test-project/ltp/commit/e84f0689cf7a8a77478a0e70aa62560f66c3bceb

