Return-Path: <stable+bounces-54715-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C2B910596
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 15:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BFAF1F25687
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 13:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7061ACE65;
	Thu, 20 Jun 2024 13:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pRBgRsdE"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807F81AC794
	for <stable@vger.kernel.org>; Thu, 20 Jun 2024 13:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718889266; cv=none; b=VSyU+rJXPrxiElwWL2vbTj2czy3gg1zSW3cEFkweIc5TTQGXvRW+iAmZqaS37tNGSsshzqdI9Dm6zcMjQtPU5vaZazzR1YzsHeGSuBCZdUyL6ojiexHG0HjwOJJSuqFg5+4gZ5W7V4dWaxp1t/lK/S6V0D5/axy18NwPlUhVoWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718889266; c=relaxed/simple;
	bh=Y+MEEyx41IcOVMqXoXDJWkJ9+FrOPr++BZN75feuo1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qWg/j+6bEAR1uAg6SW7CE43Put+obLZqpEMpMP2Kw2Ay8M84vHCbqw8Exv4JbJRUpqUleNZF3t9GZEwtHZ0j9loXAoCfUFlRqxUWecPJaPXdlE7IcwV49jN3mlwipdXXstMKBJfyhun12UDwwbE9Au0lTidGOiG7H+ZokcscndI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pRBgRsdE; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-44051a92f37so6393331cf.1
        for <stable@vger.kernel.org>; Thu, 20 Jun 2024 06:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718889263; x=1719494063; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k8loiKfZnA+YA+BNdznuyc93e427hOVjzdhKBo4Mcdg=;
        b=pRBgRsdEoVVhHSevcztTbX0ZQbs6ODQpR+ZDGlx4bS6LsN51+wh+5jJxEHZF17AIwC
         EwntDMgI4oMOZwvavysBQ7dfYv0cLsEJ9vn7N/rTVCkNChPK/p9eVDXJzl59HxwlScSw
         3Pl4pZssaPdHXObOHR8ieYxQdfgh8/2J1W+Gt15p43V9HSVS4bdg1x8q5c8kYQGUdOs0
         VaRQxPvn0CqE7+PZb3Fc/5ucnT15ftHjDZu06LEl3wV2dm1C0Ap5kEXtL7vbnXEU1Gp3
         DytIeT6pMw1uiXwEmJuXLXFvN8LaRy5NsJwPjr7mlvB6EHiioWO4iv0kGnlL0YpZhGKw
         gDsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718889263; x=1719494063;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k8loiKfZnA+YA+BNdznuyc93e427hOVjzdhKBo4Mcdg=;
        b=awKdWitMvBSJLyfwVG/cB/0muFpUs1yc4/lIHwfVINIaMM2m5rwL8MStZda0rMazr4
         ol4r2HUXEkNB+fgX8xpq+7mSOhtbFY8xniiRfB9vMa5IwZpiVMCO2pzcKNz48/7ExfUy
         oBYAah9ENJNQqKqMtTEKpKFTBNCOUW6GEPTCzfFWtDwrcHz1b4oFR+dhz+zsc53B6Cy2
         OLnLiugUBBQSHBs64Am+OTPcy5SwzxDZE58oh1flYRRXwoOEamPat//lmKG7hp4N2B0s
         SOPWSRXlW/+JCKZcIdaQUq6yDrwzzXqlT5srTqmMlJtpgv2V4pVEbRvTh33oNzvtGG/u
         iP/g==
X-Gm-Message-State: AOJu0YzRrp03zBgEvVv0NhKz/Hel8ejYR4iYgDs0KnfZc1mI1uQT01EQ
	PTZ5c6bhudQhrziIszQiTYlYgtEn9qvsO9NOu+NTrJfTZSeV5He2AlH0bSvTeypnYMCRGtZRU9f
	6i68iPMESgOvSic0laNXwC48brJTzG1xnNwTI0A==
X-Google-Smtp-Source: AGHT+IGiHKV+q2qJu/mkMnrbWS6TykUfrsN8Y6wuNtachV8KZU4pBm3Bkt8z8L8YuUKSny6A751rJg0UHn+YKbmJrf0=
X-Received: by 2002:a05:622a:1813:b0:43f:f5e0:8e86 with SMTP id
 d75a77b69052e-4449b90ec32mr145142351cf.10.1718889263444; Thu, 20 Jun 2024
 06:14:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619125609.836313103@linuxfoundation.org> <CA+G9fYtPV3kskAyc4NQws68-CpBrV+ohxkt1EEaAN54Dh6J6Uw@mail.gmail.com>
 <2024062028-caloric-cost-2ab9@gregkh>
In-Reply-To: <2024062028-caloric-cost-2ab9@gregkh>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 20 Jun 2024 18:44:11 +0530
Message-ID: <CA+G9fYsr0=_Yzew1uyUtrZ7ayZFYqmaNzAwFZJPjFnDXZEwYcQ@mail.gmail.com>
Subject: Re: [PATCH 6.9 000/281] 6.9.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, Miaohe Lin <linmiaohe@huawei.com>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, David Hildenbrand <david@redhat.com>, 
	Cgroups <cgroups@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, jbeulich@suse.com, 
	LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Jun 2024 at 17:59, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jun 20, 2024 at 05:21:09PM +0530, Naresh Kamboju wrote:
> > On Wed, 19 Jun 2024 at 18:41, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > This is the start of the stable review cycle for the 6.9.6 release.
> > > There are 281 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > >
> > > Responses should be made by Fri, 21 Jun 2024 12:55:11 +0000.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.6-rc1.gz
> > > or in the git tree and branch at:
> > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.9.y
> > > and the diffstat can be found below.
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > There are two major issues on arm64 Juno-r2 on Linux stable-rc 6.9.6-rc1
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > 1)
> > The LTP controllers cgroup_fj_stress test cases causing kernel crash
> > on arm64 Juno-r2 with
> > compat mode testing with stable-rc 6.9 kernel.
> >
> > In the recent past I have reported this issues on Linux mainline.
> >
> > LTP: fork13: kernel panic on rk3399-rock-pi-4 running mainline 6.10.rc3
> >   - https://lore.kernel.org/all/CA+G9fYvKmr84WzTArmfaypKM9+=Aw0uXCtuUKHQKFCNMGJyOgQ@mail.gmail.com/
> >
> > it goes like this,
> >   Unable to handle kernel NULL pointer dereference at virtual address
> >   ...
> >   Insufficient stack space to handle exception!
> >   end Kernel panic - not syncing: kernel stack overflow
> >
> > 2)
> > The LTP controllers cgroup_fj_stress test suite causing kernel oops on
> > arm64 Juno-r2 (with the clang-night build toolchain).
> >   Unable to handle kernel NULL pointer dereference at virtual address
> > 0000000000000009
> >   Internal error: Oops: 0000000096000044 [#1] PREEMPT SMP
> >   pc : xprt_alloc_slot+0x54/0x1c8
> >   lr : xprt_alloc_slot+0x30/0x1c8
>
> And these are regressions?  Any chance to run 'git bisect'?

it's difficult to reproduce the first one so we haven't been able to bisect it.
It seemd like David and Baolin might have an idea what's causing it.

- Naresh

