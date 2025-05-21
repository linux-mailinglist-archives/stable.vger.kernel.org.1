Return-Path: <stable+bounces-145837-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85325ABF638
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 15:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D437B1BC49B2
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 13:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BA327B4E4;
	Wed, 21 May 2025 13:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b="pfviqgCN"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2756265CBD
	for <stable@vger.kernel.org>; Wed, 21 May 2025 13:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747834541; cv=none; b=EkFVt5ZMEBhHD/Q9ehyO67Y5KbgySHFAcsKvtr0v9BUOMMCxVvfQshz+k66pi61edvrndVzxnnbnBJ0aUS4UbkFlTLWAbNGabkfknC6skV2UakjghwslC/NKgfGmGuETafvkkvEiQy7s++u6vT1JB4ANbgwRezS10hZaTHhoLSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747834541; c=relaxed/simple;
	bh=Hz0zcak+SEFe3diMwY9NS2ySs/drqRPLTc1WEtV5nik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nqkdpyqVVvP+ipwkGJCX/jRautEV09GTFwMFVUbOGpHNP/uMAWp4TvXr93xrX99gTA89rCHFPYFRvFHovXtAEHbX/v6OAdICbY8Wxv6PDOTw2BmNejXcpwIiYDg/G/6ThmYRQ0Q8znx0ltKf130v9aZYest/7ZMNYK4/gEH901M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com; spf=pass smtp.mailfrom=ciq.com; dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b=pfviqgCN; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciq.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4769bbc21b0so66051521cf.2
        for <stable@vger.kernel.org>; Wed, 21 May 2025 06:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1747834539; x=1748439339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zHr0Cs4KaT2UvU/qZTlZsSCRg1iopIeIF/2NlDc8tRs=;
        b=pfviqgCNHCSkJUE6/Z1fEmboC7SIrnVauDCGYaobEHW1kVyQ1J6i62/nXIhnJF2qLk
         io8q5yMUpckR6vRVYkqttsvXytrFqcwxQwH1rROoxtMAaeu9aBnyAFGml8c1oxOz+hP/
         D9og3fMnFASSRrZtiZN7UAhV+EaLve4TOfAAKld1ugRGMHD4+bBuClmNbgrTZKCDZP0A
         fDq9meOt9jbqdLHqjSWtSJq618N2Cvc+MbT1/tYM/zPeRWwrfpwoCXwqVv9LbHDFq27b
         lYVEg5h97nuIfUii2dqoZbs/+KD5rEKKlS86OqWLdsPCZen9twSzUQiSxm+Dw5Pj07ny
         QlcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747834539; x=1748439339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zHr0Cs4KaT2UvU/qZTlZsSCRg1iopIeIF/2NlDc8tRs=;
        b=rXAp0XHr0O+unbyAhTODdrL2yo42AfjAfrGaBoJAXIXZg5YD35FTvMMUoFTXE1j5Rn
         hJ411Abc1KNKnra2c7wZ8R749tF0W3zSy4KW/1NTUL+QcuSF687eE9kigBFAIsIG9vVl
         bk1xZT95GIiLLUCgBJCWqPuZdCNDkyn/UUF9iZxEDagSjiypB4B9Yj2KfjMislDr8vla
         ReXzZCluQvDVU5bug2o1+ji0LSLap55AxpVo5ciR7Q3KsEfFv301CtjlddM/j9yqKZic
         jEm/lACJtAEtBW4sVtqDrNB7PsH3AkKLbyV0lUr1oc9scYjlqSTRcCwjugs3JTzlhWN1
         6ntw==
X-Gm-Message-State: AOJu0Yy/u8OD970JZ+f5NIgvXhb6VQCwV75UX7HBbmDizVgnxqfVakG0
	eFqVKPVKxUShliRljcqz+mkeWGDhhjKOfzDkFQ3PEVyZMgt3qLftbYp4U3utWlElRAf6lzrLTLq
	aDd3l5MiwfM/YkMqtVFvA44OB052qYyHObc7NFFzV+I484Peqzx2BjkSAdg==
X-Gm-Gg: ASbGnctEKvdOFDgt7vCRWanhB+/qs6DzxSbeM90CLCHOgPO+ojvQPD+kP/I7j/d92GF
	WR2RL9SJ98bIgKJJLS1eoHoLdVjFlm4VHpA8DkyuyMQyOIqT2h82Z6ZGzi1PcashITgcNJ7qSXz
	DsJVt/Ud75+c3AD9XvX++S2Ht5Z9gChmGrAaT/C4f9cN8=
X-Google-Smtp-Source: AGHT+IHw0FtBYXqi2ZhMV8XwB3k6d+PXA2qv/4nhtVXTIGl5XoLNBzVEMfmLL//34e3b8tZ7idnmD0eIhKNjVFF8fw0=
X-Received: by 2002:ac8:5fca:0:b0:494:b1f9:d677 with SMTP id
 d75a77b69052e-494b1f9dbe3mr261499451cf.48.1747834538524; Wed, 21 May 2025
 06:35:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520125810.036375422@linuxfoundation.org>
In-Reply-To: <20250520125810.036375422@linuxfoundation.org>
From: Brett Mastbergen <bmastbergen@ciq.com>
Date: Wed, 21 May 2025 09:35:27 -0400
X-Gm-Features: AX0GCFsnnZ61HrxlDsOy0x1qRDaTZbQ_XLe0x5ZFQ7bykkdgBHhdO40e1Ax1qDY
Message-ID: <CAOBMUvjDCJzGO4kZzRMi0JmzeL-Boj8b92to20AFjtDQWzSN=Q@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/143] 6.12.30-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 10:07=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.30 release.
> There are 143 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 22 May 2025 12:57:37 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.30-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Builds successfully.  Boots and works on qemu and Dell XPS 15 9520 w/
Intel Core i7-12600H

Tested-by: Brett Mastbergen <bmastbergen@ciq.com>

Thanks,
Brett

