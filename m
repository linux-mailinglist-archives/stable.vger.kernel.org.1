Return-Path: <stable+bounces-45271-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE72A8C758C
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 14:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B46D1F22FCC
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 12:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEB5145A1F;
	Thu, 16 May 2024 12:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tl8InijG"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72139145A06
	for <stable@vger.kernel.org>; Thu, 16 May 2024 12:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715860978; cv=none; b=AqarNproy/l3EH93w9jnmcaj7rOyHba47JgsTP6/I7q7B79AS4mnU5nlCmhdpVi2rumznb+LjUX1vrRxquGTxYr2bUw+0CJGNXQOkhn3XvU6+g6jvjdKw2COG2BLu2gOePIV+8manSMPIcsvL1+Ob/vqv43vNL6uKZ4jk9CFF7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715860978; c=relaxed/simple;
	bh=oBotsPJil6PVHxrA1q35uvvz/IlhYD9SDt5YNtfq1+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S7Ej7OwKkOAy0IUqglIBs4qlhEqFFThZR5JZ1DUStXm8gcLKu88xmXCgNJ13vElHICwW4b6Nsn49rebz/BM9DTU6+Ax9CIQw0e6F49jH4PHPSdUBa+iFjauy2bkx3MVzInJJN2wTTQ1oXlC5/yUxZDEVdBdimKZcgNCoLxQqrlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Tl8InijG; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-574bf7ab218so3570055a12.1
        for <stable@vger.kernel.org>; Thu, 16 May 2024 05:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715860975; x=1716465775; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/hFujEQkRTTIC4sPXxzKx3nVfvJZhdLcxUjBaYrvXwk=;
        b=Tl8InijGoBugKOLw7hymQdqw9VymztQ05Kb5rOfYVE7FYiwzUV1fwhVSLClnEoXSt8
         MB3HmMW2aSFhaqAzD0nxPukdb68ecZ+JqAOxAOMxq/iVeX+/S6fRGo4GB+JlBP+ixTGd
         SUHDUkDQLJnJQXUcWiRh2mlBMFm/1T1xk7X8Rqrf5WpZFxQUYvScSfxLfemOLTUs0nFn
         oKrq9LfiavUBAL41kg92GCNVKtkS+sq8ADTvCsEJfE4yVFLPF21R4m3/OoyoC0/H515N
         /A5V3thwFHQrddc86l4PGkhSb7FGTsuWr/hmt5A+zW9Ox2KZwMCvi5v9HzZy+OLk0Jji
         p1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715860975; x=1716465775;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/hFujEQkRTTIC4sPXxzKx3nVfvJZhdLcxUjBaYrvXwk=;
        b=NMLVowTh++Z3XCosm2vsbdPWxHIdd5K1ZhuwH+aPnlILnwIsXCzjx4kMM6+lFxXx95
         5s8khbxDPWWtGRguhKgzndPXdeaoEd6YRVHLoJ8fRO2tTDxALub0f9r+wdZLaF3BXga9
         fDYP5qydpBDhdhxcfvecLab6IPLsoHK6SBUOfyRKM0lcIqF1kmE6/ynaPGSHgG90ixcS
         llcrfEivkx7R63HgcUROZpyvNYUWuWWMdy4QORanqEEppfWUt7Yr53HnCaJpyirtpCVY
         PRA2sAf6Yu1b1HIML2D37p7IreMsxocTPzhpuNME1xmmMPulJlZL/PJGQfu0sonwE2mb
         5VIw==
X-Gm-Message-State: AOJu0Ywd78MviknHq99Auno5tNERDOJNPNwwN10skJSX4NV17POifpeG
	qRKOw6XMI3JV+QZhPZyviLNa9jL5b/l2MgVXeUBQwy1cwuNK7fkWZ4wW/5jmHtSgJh6PHNgfFky
	SMTTFA6j1BVYjJuKx+LZENL+jlneAUxVTGBpuNQ==
X-Google-Smtp-Source: AGHT+IF24n7Bb7yiv2hPX9QR7OjJaCrjTnhCo68mBDN/2UoOuuobCTIpqqrpv2tOfjJAXfPmF2dX3HP6bJEPacOIT0U=
X-Received: by 2002:a50:a6dc:0:b0:574:ebfb:6d90 with SMTP id
 4fb4d7f45d1cf-574ebfb6e1amr4125608a12.4.1715860974768; Thu, 16 May 2024
 05:02:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515082517.910544858@linuxfoundation.org> <CA+G9fYsZ7iTr8UGyaN-FB1R8=zLWnciB_10mzk8QCRhUMLSfFQ@mail.gmail.com>
In-Reply-To: <CA+G9fYsZ7iTr8UGyaN-FB1R8=zLWnciB_10mzk8QCRhUMLSfFQ@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 16 May 2024 14:02:42 +0200
Message-ID: <CA+G9fYuexPg8yh61Bx58QN_y836rb-cfP4DS3ceesTmgohV-5Q@mail.gmail.com>
Subject: Re: [PATCH 6.8 000/340] 6.8.10-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 May 2024 at 12:56, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> On Wed, 15 May 2024 at 10:27, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 6.8.10 release.
> > There are 340 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Fri, 17 May 2024 08:23:27 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.10-rc2.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
>
> As Mark Brown reported and bisected.
> LKFT also noticed this test regression on 6.8 and 6.6 branches.
>
> kselftest-ftrace test case,
> ftrace_ftracetest-ktap_Test_file_and_directory_owership_changes_for_eventfs
> failed on all the boards.
>
> Looks we need to add this patch,
>   d57cf30c4c07837799edec949102b0adf58bae79
>   eventfs: Have "events" directory get permissions from its parent
>
> Let me try this patch and get back to you.

The cherry-pick failed.

- Naresh

