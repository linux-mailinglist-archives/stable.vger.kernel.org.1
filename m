Return-Path: <stable+bounces-116405-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1ABEA35DA9
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 13:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABC8D3AE0AA
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 12:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C28263F3C;
	Fri, 14 Feb 2025 12:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jIznVETw"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDD5263F23
	for <stable@vger.kernel.org>; Fri, 14 Feb 2025 12:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739536196; cv=none; b=eMUCKkLAruT5gLkU711chTo0KPnju5yDPCGT3MwOaOBH0sYmOyVGkov9mMk4CoBsmjecz3J+QmNG2GwKm4f+gk5PjMim7i/Ha7bcoEpEYhQUEpG7B+QstXxhn5fVNoq0FVKmjNmtWeMeEyoKt4A0xiGwgNVHuiVyMjAQLm21+AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739536196; c=relaxed/simple;
	bh=o+9eJVl8CwL4mxIer/X2JlMnYjvZGgitWo5E6XsIP00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tESY6Mumy5ApmMxP8T7rj8hhyvEFuwsz3mSn4nwC0wXX1ebtuAf6jV4X+8Lhcc2CVEYsXMFjb2FY90Ja31Ce9K3xmjkuH+qhA9fzwd40UbPYf9W6p6TUinMfKeSjmHUdcOB8w/IQRN5S4YSMD2V1niyHOJX4ypY7BKetL29BnU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jIznVETw; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4bbe0d2189aso594079137.2
        for <stable@vger.kernel.org>; Fri, 14 Feb 2025 04:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739536192; x=1740140992; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lTFbAU7wJoF4fOBfb8cWjl4tFAB0huVpYXczHim4Y1o=;
        b=jIznVETwq8/92diQRkc6ubURVuUbxWxObGWy0fYTTNYnFS2bA0Is0SP1zksOKVKmEH
         gzC2IIQLArsP7NWH67thl2+I7QOwC27AHoOy0onLqMJ6Iymapkue2Mk3gC7WCvLCrbhj
         uqtCKuesU6S8iwHfAnuoP3eqbPseN1vwhze1u5TmXPDyEAnRM6swd2KTLIGO0SsnSVUZ
         f2PVAkDzYt6WdHaePrc6gydE7YTCzMp2Iq4JsEj6oSeVtEfGukB+zavGyb2xC/eaG1tU
         yZi+fQ6j6ugoz6rhVk8YTpmJIjuqRUJx3EAFExjDnw7ACcwudWxAIrxkGT76Q9q8kmDm
         mzRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739536192; x=1740140992;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lTFbAU7wJoF4fOBfb8cWjl4tFAB0huVpYXczHim4Y1o=;
        b=YXRGZwN3Cd/npUV+GZgJgfV0u0FbHrHA74iKadzalYYwn9J6yyihAAYZ6C+/x/XB6P
         VgZUgJgy87NiI7a8/sUoZYdB2og0E92gZg4OXZSP8rf+lC/1PA0DecibpkaDyCNVi+v0
         BURjOqgqkMacUEbmN3hAK1dHO5yoWGPMRjVHIn8tdRFZrBH6wlXu4uYh4bSQA6ibbjBv
         c2EFjl914/utIDkMGEQso/klz6VQBVch5j1RYS/AZ8udYiEzhGgUyUNNDJWdpQvgh21z
         siCoyf1KI1IzqBKpLPVxoz28qmxgI8yQcMTFtoHE4xgNalX44dKAJWKzF/d9JZa2borF
         eQHQ==
X-Gm-Message-State: AOJu0YyBJ4sYJ8ua+VzTGVF0nyCbhYUaO9Sh6Jne68OVeej9jVaF6Jqf
	THJOGDDC7pCpMk2J2MnA4jdBSOdCC38uOc1Wip4s5mGyXRejjbHmqDY25BJIcBbhc8e4mrqLuWM
	mMd4+LrWy4gU6VhydJQyL/k6zX/IjUHwjeqrzZA==
X-Gm-Gg: ASbGnctLnoNHiLQCZ6fk0vvh2heKQws8ypQr3NGLSdHfGtbMTsH4TqPnzJQp1Fsq3RH
	nZGMP9mvYpGO9rPGA0vQTN0Nd3Why7bWXPcoy6R+YCmSgkK1fVqZjViBMywdBSNPcRR9jViNQoN
	Cc7wsSHLHPKGFTXPniTPbI9plxUx0ysUQ=
X-Google-Smtp-Source: AGHT+IFayjXgqLnPIi5Gj/6+Fnamdf+uE2pl1g6krTGZMHKX9RJajOKZ81JoDlIpuTxR8LgZtuj0I33nc9DhR+zNH3w=
X-Received: by 2002:a05:6102:3a0e:b0:4bb:e14a:944b with SMTP id
 ada2fe7eead31-4bc03781b64mr5853377137.20.1739536192461; Fri, 14 Feb 2025
 04:29:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213142436.408121546@linuxfoundation.org> <CA+G9fYuVj+rhFPLshE_RKfBMyMvKiHaDzPttZ1FeqqeJHOnSbQ@mail.gmail.com>
In-Reply-To: <CA+G9fYuVj+rhFPLshE_RKfBMyMvKiHaDzPttZ1FeqqeJHOnSbQ@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 14 Feb 2025 17:59:40 +0530
X-Gm-Features: AWEUYZk1PwH1MSNr9Lf4hA8ve4s44k0qj-QHXi0NZuppFfQe21jEYySxIYPOqJU
Message-ID: <CA+G9fYsVFoLTXYBqpeUN1VUTwy5kXTB82fztK62fMPR6tYxChA@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/422] 6.12.14-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	linux-xfs@vger.kernel.org, chandan.babu@oracle.com, 
	"Darrick J. Wong" <djwong@kernel.org>, Long Li <leo.lilong@huawei.com>, 
	Wentao Liang <vulab@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Feb 2025 at 14:16, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> On Thu, 13 Feb 2025 at 20:02, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 6.12.14 release.
> > There are 422 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sat, 15 Feb 2025 14:23:11 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.14-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
>
> Regressions on the arm64, powerpc builds failed with gcc-8/13 and clang
> on the Linux stable-rc 6.12.14-rc1.
>
> Build regression: arm, powerpc, fs/xfs/xfs_trans.c too few arguments
>
> Good: v6.12.13
> Bad:  6.12.14-rc1 (v6.12.13-423-gfb9a4bb2450b)

Anders bisected this to,
# first bad commit:
   [91717e464c5939f7d01ca64742f773a75b319981]
   xfs: don't lose solo dquot update transactions

--
Linaro LKFT
https://lkft.linaro.org

