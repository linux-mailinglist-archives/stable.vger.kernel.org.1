Return-Path: <stable+bounces-12279-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1498832C7F
	for <lists+stable@lfdr.de>; Fri, 19 Jan 2024 16:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E1F91F249FC
	for <lists+stable@lfdr.de>; Fri, 19 Jan 2024 15:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3194854BE3;
	Fri, 19 Jan 2024 15:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gZ1okhzT"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B733C465
	for <stable@vger.kernel.org>; Fri, 19 Jan 2024 15:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705679326; cv=none; b=dsW1dTBiqU/2GX8tWbwCNf5AknUl2MPmrWTqxDrwfwU+reKm2Lza++4DUm+U5V/ojJtQ2z5Mj0QkCx2YU0ZB43WbWUD8mOzBzzV3HFHnTAx1bQhLny+J6+yAwrCNrC+XNXHHQLs+ngKK7VTqW86q3rzwsf5GXDre/4hH9sgxv9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705679326; c=relaxed/simple;
	bh=3KeVb8iHSTXJAHlpC+TiGoBdbDy0ujW0bVUfMh7M/IM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oc7XrGlo68snEXSyFfS1dUO7Be4+4916JqRzNn6MJwffoYw9/cL2NdJ4ow9gzsNz7BEBeXn+oka6CBV2IjT5TEuBrguKPJ0TXNphjhzXoXZhyM8uR1E4vxFFkTbwnB2LEhS4qeiAZyElie67hEQYJkE6oryKUb6yDcJy3kewQ/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gZ1okhzT; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-7d2e16b552dso158670241.1
        for <stable@vger.kernel.org>; Fri, 19 Jan 2024 07:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705679322; x=1706284122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kSbsPC/GT8f3pGBraL0I1C1S6tXlzFxSCmChfpZ5F90=;
        b=gZ1okhzTwTKskuEKoi1ZU9FQWWqERcVvQeSzLlZG1butmD72rJJLGG4HP4+oLmWt/Z
         M0YfIzFszhskJcHcAckeS0eegfhO/cu5Vjtj2pwKvqYgbyafeIj2ebC/8KqtT6S9ihT7
         Z/P178hPskHehh5CNi3iNbKPJHhxQbyGFoATW4NbVaBHAO0gTUoH+RDnSNMq0E2CX2Wf
         E7AeWn8DV5N08IU6JQxCoLw/2V3/4epwY67tWaB4BK2UWefdc0AyUjoJwxw1rtzZamLq
         /lykS6cfYgNvlx1LZmygtSZ99MCGL0ZM/NIUP965FNl81NA0S3QdsXmkMzk46zwgSXRo
         ACSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705679322; x=1706284122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kSbsPC/GT8f3pGBraL0I1C1S6tXlzFxSCmChfpZ5F90=;
        b=p2GB3urmLQGNfJSLobLepkN94MkhKuAvXWBvVKme5ZVO+iV/bHFdCooQIY5vOn/wTS
         p4UxD+qiJqyNAOz4g9Q+zQdrKlPqt1kHNYBVbsrZr5oJv54HkRQUgaSV9NZnHRNNFfBo
         C5yu7zbDw6ZWEZANSu6NNaNhgEtYj76F+CKyF4zXQ0DaUyECjyHCoR4H/WvP5Sui90Qm
         wOrrEgKKN61Vdq8xOtL6w2liB1VTZ2r9cnLRTGXjN3SP0zbcbRImWwrURJYxIL1BZfK2
         VphOODWcBjzpyFePYJ2pgpH+j3scYy8pHiDizfhUdmssn8x/l91dLw/LCoDGc7uYnLDx
         85pQ==
X-Gm-Message-State: AOJu0YwC8mwcHNe43WT87Cu6IzoHhaBCmML5b4PysJP2vTvdNQexQqBK
	S+MQec5GyOyIpaZVfHfjo2SpKDISKz5qjsfAoSOth5uYUo0Mp5WBWYdIiQ5rKgbSGJN03tWg1ON
	Ve/HsiCeHlVy/O03RQYWuNVTU7sMxaWb7WtqJbEhycdHFcDMFocY=
X-Google-Smtp-Source: AGHT+IGLafI0xBDL15bbjTBVc+RXc9+ZzQCvlFVzHvfgKr0SoyjWZ+Sb6T/8NraCFHnMzn/9lWlD/bMD7rzeMqgfQvQ=
X-Received: by 2002:a05:6102:3229:b0:469:9fe3:96b3 with SMTP id
 x9-20020a056102322900b004699fe396b3mr510547vsf.9.1705679320997; Fri, 19 Jan
 2024 07:48:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118104301.249503558@linuxfoundation.org>
In-Reply-To: <20240118104301.249503558@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 19 Jan 2024 21:18:29 +0530
Message-ID: <CA+G9fYv4PdOsuFmd2BGoq57omiXWuvnSpJJ1HuLYT0rJ_h9xEw@mail.gmail.com>
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

On Thu, 18 Jan 2024 at 16:20, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.7.1 release.
> There are 28 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 20 Jan 2024 10:42:49 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.7.1-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.7.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
The arm allmodconfig clang-17 build failed on 6.7.y, Linux next and mainlin=
e.
but passed on 6.6.y.

Links:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240117=
/testrun/22090095/suite/build/test/clang-17-allmodconfig/details/

## Build
* kernel: 6.7.1-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.7.y
* git commit: ef44e963b02edb00d4de5fa3528a21f3e7b33a85
* git describe: v6.7-29-gef44e963b02e
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.7.y/build/v6.7-2=
9-gef44e963b02e/


--
Linaro LKFT
https://lkft.linaro.org

