Return-Path: <stable+bounces-12295-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFF0832E39
	for <lists+stable@lfdr.de>; Fri, 19 Jan 2024 18:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21553B2160E
	for <lists+stable@lfdr.de>; Fri, 19 Jan 2024 17:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0CF55E58;
	Fri, 19 Jan 2024 17:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cPREiBN0"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6821954F9D
	for <stable@vger.kernel.org>; Fri, 19 Jan 2024 17:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705685726; cv=none; b=mUApM0TOZc/6NC2YoyIM23X311phCH/gPrlk1DGkSZ6yOuf9t51zh7u5tBxB5nSbHYsjc5AJz3nJczJ1g2bp4nDEJtCJKO479ZRiehduQdnmhVWzcZxWNypfOtF8KdCEGK1Rwz/Q1M23U04s1wuO7i7opI5Pr4aK0cZIF2uZ/rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705685726; c=relaxed/simple;
	bh=YYJtFFrWyFN07iC2Pnj71je0b557cDdHcxt6rp4uPyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XKBcE5dmo/5MkWV+UWjujs9iIdCqT8VsMAnm278dlg8RVNR3VOhC3fe3yPJZzbGURyXBcPemvDxTWZgZfPfPs0nWVJqpLBsSDOO8B68bwhRiFWzIKvxXeHnN/abMdeN4Pv2puWgqOVbKs0Xvu3zSaA/u7CRyQo4v/kj5es1mg/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cPREiBN0; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4692b24f147so334285137.3
        for <stable@vger.kernel.org>; Fri, 19 Jan 2024 09:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705685724; x=1706290524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nij5MJXPr1Ekua+uc/RF5x/wvNKaJmQ8aEq49qT0/oo=;
        b=cPREiBN0JPv8AiIkJgpFbip7b3RzArt3OqzqcStudK1l/OY/LaIz2rh0+A5FVoQw+6
         DMU8AHmYIOQmVqDHU5xwXvWscUkujzQvX3P1TI8FTnxG/3KyEZKcorRJ7RWLF5cLyks+
         IGcFS6GRUYVJHScgIXy0X7qbg9Umtp7C8EMSNn14lvIYPH475W6jowS/4IiN4EO839Yo
         81RTE2YHqY3eOJbMwBKh9dKia8TotIKR85ttdSQkaWxQOw80lhPB/MXYRcqJOVwJOqIq
         y/8ahu5sRn3PVgAlkqq7S/7Mrdn1RDrUT13RnLXetYhv5aW90HTN2aDH8AIYmImsnfNA
         dWHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705685724; x=1706290524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nij5MJXPr1Ekua+uc/RF5x/wvNKaJmQ8aEq49qT0/oo=;
        b=Y3eeNcrNIFV86eLsuw31VOYeuxjhlQJk1ZSCsI0R/YUboBBRWSseXGbhRz//jcFF2h
         cYwbB5R5L8J/EalwZV0Ml4wB3upxQiad6GslVvuanHht4OOFZqwBkJM2gKMA7ryqAQV7
         gGoO3Vpm0FJf35sg4+mgJBW5UPJrbdLZWA7idc6RIYmu0Q4H69MYuaAkI1CyMCpa+UuH
         piH3ILRuWa+dplpum02dVIn21N1dndjlEAPaMtb4oQ3a2dHmkdRG5q2Q0Jz3TtRLCKHI
         nrxxFHjerKSBCGpPJPWMiPgANWU6zZOE7q6fGd7uRs1ZAwW3ZfVDmZQqlESQUyraeq/W
         dqng==
X-Gm-Message-State: AOJu0YzTYqvo0zGTh4NmOo+qGMCxvPmr50mlTpj1vypPql1ieVOnA7By
	Pm75bBbnKR4wIaIQ701wROuL7IKTpzugo0pE40oUpHnn59FHvRgxtEQ7BH2PsMfhDqPTz9k+GJg
	iemilpDD8dE/QpAKym/Gc7kF2/yd71AGRAXAhOQ==
X-Google-Smtp-Source: AGHT+IG5Dkka/sL/bUHyUu1DFKr5XJwN5zLeHhnPzHMX+6g1NXFOSn93OMgjK9uC5DUpUSsoEJIHIlvpsa9TcitWnnA=
X-Received: by 2002:a05:6122:9aa:b0:4b7:3986:de56 with SMTP id
 g42-20020a05612209aa00b004b73986de56mr87335vkd.11.1705685724319; Fri, 19 Jan
 2024 09:35:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118104301.249503558@linuxfoundation.org> <CA+G9fYv4PdOsuFmd2BGoq57omiXWuvnSpJJ1HuLYT0rJ_h9xEw@mail.gmail.com>
 <2024011935-pushchair-affected-e2f0@gregkh>
In-Reply-To: <2024011935-pushchair-affected-e2f0@gregkh>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 19 Jan 2024 23:05:12 +0530
Message-ID: <CA+G9fYuPpL13P-5Zm8agOrGKEzAc2kB5yQ_MvWs0AYRKMkNKwQ@mail.gmail.com>
Subject: Re: [PATCH 6.7 00/28] 6.7.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 19 Jan 2024 at 21:31, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Jan 19, 2024 at 09:18:29PM +0530, Naresh Kamboju wrote:
> > On Thu, 18 Jan 2024 at 16:20, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > This is the start of the stable review cycle for the 6.7.1 release.
> > > There are 28 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, plea=
se
> > > let me know.
> > >
> > > Responses should be made by Sat, 20 Jan 2024 10:42:49 +0000.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/pa=
tch-6.7.1-rc1.gz
> > > or in the git tree and branch at:
> > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git linux-6.7.y
> > > and the diffstat can be found below.
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > Results from Linaro=E2=80=99s test farm.
> > The arm allmodconfig clang-17 build failed on 6.7.y, Linux next and mai=
nline.
>
> So 6.7.0 is also broken?

Yes.

- Naresh

