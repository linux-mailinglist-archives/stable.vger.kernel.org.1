Return-Path: <stable+bounces-72685-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D77E2968220
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 10:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 947D62837B8
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 08:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4E4186E3D;
	Mon,  2 Sep 2024 08:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ypZLShvm"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DB6757EA
	for <stable@vger.kernel.org>; Mon,  2 Sep 2024 08:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725266216; cv=none; b=tST4l/3Qahayp+c+1CFH6fxSLWK5a3vUTdN4+T42KV38xsU8HQ4Ui3wYkZEOTLxcnbrhDszRVaqSkU3GmhgC1o8iE8dQ6F8u/qez6B/UwPd38tvvvCCKyFE8TmnOZ1a9JDCjrGKbxG9+DL4/w0eb54lTRHTSqTIY8AdoXvj3k7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725266216; c=relaxed/simple;
	bh=xy3Z9lAOzZ45z4zrLrPCPDOJApY6xNM5ad9KMplBiCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BcoY6AJd8JvfXu7JTHsnytnkZsiKIKZA3Ft3EmnkT3M8QT+hy/fBOJJz78JLVBggfENvsa7DcqCw10q5wIskbA1znEHMtgl5AWLYJsa8x0+BwYxjFafSc6CLVEMWwfsgnOuCwbkkwq5x/o/43ec4Zz3scjRlaZjviPf0o2L/wfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ypZLShvm; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-498d7c37921so1674945137.2
        for <stable@vger.kernel.org>; Mon, 02 Sep 2024 01:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725266213; x=1725871013; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=izgwLH91JZbFLA7uRSiQZxwM6vVQO4Q8Uz2oK9o3XyU=;
        b=ypZLShvmkJM0+4sPsN77MD+MrSuOGoFMgSlgIPu0FxTt3FxM2VdZxLz5Iut2lvJNpZ
         2DnEwDT+OKbBIXepXb/2r9j+FV3K5n7QLfCoW1JTlxNcHqGryeqyLdFiWzOzePz9Lpwz
         YhOI5+VG6EacPynNhT7qBeVXA5RGGfTF2MiSddOApEW8PIQdaq0ZWt1YlbTkOoUexrZT
         ClN6Q+mrdThuNiAaSjUUwtYxZk7WiAVAPdFsoX1TU1xPnlQeF52vYcjZfErX3i1c9Uk7
         ZyJXs7L9flAGqIAMXd8QFJw5yoPrKS6ZA+D2Q5e+uQmBJaf/q/fbfGzIdcD+cDIhc4Yk
         oJcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725266213; x=1725871013;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=izgwLH91JZbFLA7uRSiQZxwM6vVQO4Q8Uz2oK9o3XyU=;
        b=i9z/hPWQWNDlO3CmP58IiPuVxyxdb7SEsv9zR6ql1+jBF77ZzXckoRw4mYcZzIvPlS
         qI+JFtiZCiHDX7QY/Gte/1maU/Xa4QhQ/NgBMnZGvEAShhJ+SCAjPUoPOANF5FjxWQ+8
         fJgrrZst4WFv+HUjKFzu42VUp3RXMD6KeaP4dJodyv5+HRutH1seWlv62gEc8Zr/K8OW
         l3duke6ibcF6XDIlQdKRKlhwNEe5iaVx464hRC0Omj3eDtpkYMK8dqw0j7AmtC3+p3fU
         1ynjuuA5unEFKTtE1Sfl+TUSdlOgoeCVRCwzQxrDCybvMTDSDDoxNUsFF+qCC8woumgP
         4TKg==
X-Gm-Message-State: AOJu0YxNI+BfyQVc3pxVrm44PiMwcJJPFHbMCBB8InDZaCpZK9VxCM48
	e/q0dgN0Wb6XDw2drZ5RvDI1wW3k86nHXisMU26M45PM4xa1YCtt9BI+f6D4N6PI3myrKEy8iXz
	ZsbnYdmxLDgC9E8s7QG7NRxiCl/GWU+B5yS4nzA==
X-Google-Smtp-Source: AGHT+IHr9d4uGJaINXYhlYol6A9FJjb6MMNb9yI6s2d5LmfEr5luCvl4+OTH0rW6lSrtvbYTbS2AdcEhIMsVx/v6eXU=
X-Received: by 2002:a05:6102:3050:b0:498:c875:ffaf with SMTP id
 ada2fe7eead31-49a5ae5b461mr17121501137.12.1725266213517; Mon, 02 Sep 2024
 01:36:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240901160809.752718937@linuxfoundation.org>
In-Reply-To: <20240901160809.752718937@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 2 Sep 2024 14:06:42 +0530
Message-ID: <CA+G9fYszuNTqPzsX7cw-2_7D0tFUMeroVKeza4gASmUEbcxcqw@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/134] 5.4.283-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, Anders Roxell <anders.roxell@linaro.org>, abdulrasaqolawani@gmail.com, 
	Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"

On Sun, 1 Sept 2024 at 22:09, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.283 release.
> There are 134 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 03 Sep 2024 16:07:34 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.283-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The Powerpc defconfig builds failed on Linux stable-rc due to following
build warnings / errors with clang-18 and gcc-12.

This is a same problem on current stable-rc review on
   - 5.4.283-rc1 review
   - 5.10.225-rc1 review
   - 5.15.166-rc1 review

In the case of stable-rc linux-5.4.y

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Anders bisected this to first bad commit id as,
  fbdev: offb: replace of_node_put with __free(device_node)
  [ Upstream commit ce4a7ae84a58b9f33aae8d6c769b3c94f3d5ce76 ]

--
Linaro LKFT
https://lkft.linaro.org

