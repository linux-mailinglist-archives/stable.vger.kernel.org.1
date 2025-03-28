Return-Path: <stable+bounces-126943-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5480A74D0E
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 15:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF4CF17B389
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 14:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D691B5EA4;
	Fri, 28 Mar 2025 14:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h6MWsw6O"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E7B1B424E
	for <stable@vger.kernel.org>; Fri, 28 Mar 2025 14:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743172980; cv=none; b=FlBv7HxPJK/0wfq4zkSv+HSHUjipLupDMffRIG0mAkCSrzyayOe+DmxApqznWyV+YrAObFOTbWWulx3+m78ypAHFAhHpdta2Zi7IxMCo/53hi6KdoPs6oWld7PSNV3tVBoU2i7kDeEEQtfuwWZYN9KSVTpjy/bPjD7crqBFYRKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743172980; c=relaxed/simple;
	bh=tjAIKgTzm6/MGyLQfjiuIHOp0fmSUV2cxbEbpn84D6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gs3SMI1HvBmg+bUIyEW0D3k7hajWBlzlYSo6CHS+r49WthSQPHdOQMEe+408+PnTet6nl16+4fVoRXKUeAF2kUXEfAGOZ47IY0vjcGHzELwpRcWuO9HGQsKS5w3/1K3h4RB+Kv5FN2bkQmZAtopv+q0c5Ea154hRpaAixGMFToU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h6MWsw6O; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-86cce5dac90so1020263241.0
        for <stable@vger.kernel.org>; Fri, 28 Mar 2025 07:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743172976; x=1743777776; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d6ToKzHT6TF8RQ5+cmvhkhRs8kpZAnpcNS44iZJDBN4=;
        b=h6MWsw6OLcKvHPfdhSUa1cUuFG5eJ+53to9WSwVfn3nQgXOMNN9cRTHMetnBDpWlJW
         l0qNl9hoEPmiOv1y6P+2zxgiTa2JznZwldtZqQoeboGSl0tTS8q9fx5Byew7j5oC4njw
         z1KQheah+DiaEFOooWq5kOCyZy162NNMekhmn6o+/j7o8wmAALfF0sLTZhvFT03oLHco
         uplE6QiR9f8MMsLzUikHuoD8jib4qz9G5YNC0AvnKtn/YBAf3YHcy+XjpKkhpZES4XRm
         lJ5+KSZdMWY/FcrUeyjoQPqz+TsnRle6i9LE1CtZxfT5cBZbfnFue7zGcLggt0gyszbv
         bshA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743172976; x=1743777776;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d6ToKzHT6TF8RQ5+cmvhkhRs8kpZAnpcNS44iZJDBN4=;
        b=u5uqqyhxRGfduF7FdFMAtJNTREzg7kEq9tKB6JdEsRqc9SLQ6MxoEKQ6te6koycy7Q
         5Vh4ydiT1SUxGI2t/O8rR3lzycezhKQBRNrOMQDAb4cpNhf/YOGZqrKY8zxdHe4JwgsE
         24rRqvpiU/j2Cyb3RR/jmsEMxPitFP0UrQNwHUjxjCOh+odpTyWEUnK3qJp2EMmyEN2I
         utkL4jVsWsUTQo8lRtAVAzC0Vl572NvfMBvdqUw4lgn1Lc1kn65dX7ZlYzcxNS8SSReL
         2Afq5DfnX0C4ytoRHMraBB7xuanS0NOd6g5XYy7miswIHTYuby95sz8uz+TWOjE0tw/u
         M3ZQ==
X-Gm-Message-State: AOJu0YxWSBPvgc6T/XBBDbLyNSJ1xQkcHnDLYPNwY+1lZ7ftjU7z7YHD
	2GB37nT5Bulagh6afo0sIEevzlRTfAwBQHDsPK7XWpJrRDvsUL0cxPuc8XZNXPqm/rVAKuKbWd7
	JrAVTv28I6BUJELFvLX1jWeoz6knaD+3D0J4YCA==
X-Gm-Gg: ASbGncvCwJXXyS9ZDe+hZW1iD688VoTkmOaSKy8XT8vAymzDNSy7uEkdUHOdaVNycpQ
	4Q7qsYWLNeyWbkmfGoi5q3I/KICVUN6Jl1gUQTyPmIb3jVLnHGqugSwNIPGk2MOIMRyWJRNqlJe
	fldBfjbdpfUlPe1u1gZSn+nDAobzfYafiFIJho2V8DnEkqygM8HRR6l9fHQw==
X-Google-Smtp-Source: AGHT+IF4Hqd0y6tvOBG1L9437crSiShcfp+ae/DQ2Kz7JAQEC4Ms9UYLukhP4MfVCN7OnazqSSf3NmzN1q87oneOTuk=
X-Received: by 2002:a05:6102:149b:b0:4b9:bc52:e050 with SMTP id
 ada2fe7eead31-4c586f1e376mr9399814137.2.1743172976411; Fri, 28 Mar 2025
 07:42:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326154346.820929475@linuxfoundation.org> <CA+G9fYuY7iX+3=Yn77JjgiDiZAZNcpe0cW-y_M3sazhFN7dGLw@mail.gmail.com>
In-Reply-To: <CA+G9fYuY7iX+3=Yn77JjgiDiZAZNcpe0cW-y_M3sazhFN7dGLw@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 28 Mar 2025 20:12:45 +0530
X-Gm-Features: AQ5f1Jrr3okkYsKcySxu_-gULq0rRUbR8tw6Cwpyo_vJOfJMTAWnBOuVF6pmc6E
Message-ID: <CA+G9fYtdg6OopeUQWkVmW9CYoprtqzWVTQfaoaY1vUtXKEXD2Q@mail.gmail.com>
Subject: Re: [PATCH 6.6 00/76] 6.6.85-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Cgroups <cgroups@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 28 Mar 2025 at 17:14, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> On Wed, 26 Mar 2025 at 21:16, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 6.6.85 release.
> > There are 76 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Fri, 28 Mar 2025 15:43:33 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.85-rc2.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
>
> Regressions on arm64 devices cpu hotplug tests failed with gcc-13 and
> clang-20 the stable-rc 6.6.85-rc2
>
> These regressions are the same as stable-rc 6.1 cpu hotplug regressions.
>
> First seen on the 6.6.85-rc2
> Good: v6.6.83
> Bad: 6.6.85-rc2

I have reverted this patch and confirms that reported regressions fixed,
  memcg: drain obj stock on cpu hotplug teardown
  commit 9f01b4954490d4ccdbcc2b9be34a9921ceee9cbb upstream.

-  Naresh

