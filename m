Return-Path: <stable+bounces-156612-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A36AE504D
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E976A4A0A64
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE8E1FE46D;
	Mon, 23 Jun 2025 21:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WZVdoB0f"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566581ACEDA
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 21:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750713840; cv=none; b=E8pC/Xq2ByHuT9t+OYpdGcwUQ/yIGq5fxL71jS3TrGG0cTlVitz9uqiubgE6hSd7UheQnrzs7gEQ+DKaAFyNXD9nFya7ADlqbyHvayjmzSLPZbvOKhPXiY7LNh1jbloK704NGktJVdLSwrS2rzpLD7czMLVoAw3VkB/M41qnS5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750713840; c=relaxed/simple;
	bh=/Kg0WRXw5VKnsXhRWYSpnatlSaD/D8BnYoR5CRjJ7wQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DpMhPQSEMTYOvrHg7JW8X57LwrQCy9pY+Ts/ZrJ0dOk8Fv3P/F54IsXOY3RYgj9Oe/DAJmzyy1SL9zBO9ILTSQn39Qm+R9JUehLoJRnGtIY1XSY49W9rX17TGgkFE/BgQGbnxcrZasMa93sAapISsfT7zNvGb4LUl8CtGCViZtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WZVdoB0f; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b31e076f714so3906354a12.0
        for <stable@vger.kernel.org>; Mon, 23 Jun 2025 14:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750713836; x=1751318636; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=By+WfrXAyPyITn9F5TDk+hwemNBoK/rCwALmacNE1Jk=;
        b=WZVdoB0fyoVXw3EsGHLLgIfQjvRPTHI+wEvh6ZXvoeexf9Z6i3zGBtNITHs0uELqox
         qn8leBCKZjKL8wbfsKnw1TE+LB2OzlkljS3wnKw0HPZUiLPAEKRvB2k9JdoQY/9gK+og
         VthX+QPbrWUDc985TplNTybxx2lYRlgr8WTMMCMPDWama4CL+kjQE0AE5i0e9f4AoGdt
         w98mSnz7TwwX/TQMdNrdZU+lq/hS1DZ3cghabQSce93MzpzWx47niasFniCbFlyqK3Te
         BKEoxyDstUm0YqAKZlc+mHqepB9U6uzqHILmE3AP8tgAKtyNIvF/E25J3els9RuwHZPD
         C2FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750713836; x=1751318636;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=By+WfrXAyPyITn9F5TDk+hwemNBoK/rCwALmacNE1Jk=;
        b=aRkDLdEFATZTr7j0jEWcwZatcgKnqnEnzaVREXk182ooBaaoSYRRjKcO4WWu1h5Ck4
         kgK6U+XwM3bRuT3FIlqJ8oPNSfpSfw6y6zEhhaX6uopxk5tQfFJNjTZzidcQmnFGZumF
         HAnWlDqEURe90TcTka2VSzg4Wo84mvfZQMrzK2AMIlwyiUplDO4xpFU0V6iNbyGgE9TR
         lNvxXbmUWeirLiXzKLPhbjckRq7s22AVraoWsymNxQ+OWd4EMuvCe8rXhiMvY3LIGT1n
         IOphzxWI68totaQS1OQjsszn7kmVH+zTwp2RPtYWxNWpDNvDkLYg4y4q8ofSj81LIUDV
         4PJg==
X-Gm-Message-State: AOJu0YzT5jl3cdfVOZgEyVDre/81/vDEajtAt+8bEs3ImZ6FsJ1Jiz38
	Nz8o0lwUNXolpXMPo0Cwvk5NteTj1uwqReKpmcIN4FnyFiB2QM8frf6Kt2DIKH+J/5uXenvuFuj
	3v4Y6xxKflT2/04fFNlWzhpQp5U2N7Xl5FIu5p1uwQA==
X-Gm-Gg: ASbGncscYTHg8prcG/96Hljs6+2uzFAGZEFFdWxk810xYXT5+E56yZ2ok4YkBcjCo/N
	ujQmaxGfJauvK0CtanbRLOCH1N6RIsCsFuJ3G5IrZ93xhi5AlfnJUuc+5hgJSFjGQg7SsvzeE0x
	WYWtP0RpUlvobzObOtZ7FU70L3HnQyit1iUAkJCr49aPKi/dcjupOwHSX6GIEci2dYJsHLfDqrb
	MGq
X-Google-Smtp-Source: AGHT+IHJlRRLWWoQ6yh3AeFZC83NODh6v6Ss+DAN43JkjEBbpOfz48bjecKNoDN25759ZXlyzX8KWTWbCxW22IU+1EE=
X-Received: by 2002:a17:90b:38c9:b0:313:f995:91cc with SMTP id
 98e67ed59e1d1-315ccc32116mr1516367a91.2.1750713835691; Mon, 23 Jun 2025
 14:23:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623130626.910356556@linuxfoundation.org>
In-Reply-To: <20250623130626.910356556@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 24 Jun 2025 02:53:43 +0530
X-Gm-Features: Ac12FXzeAzIXRWJ7lKN4j0ifqWtMYFRuT9M7G2PFqIjYGj7Dh1wwE6lAMfMxRVY
Message-ID: <CA+G9fYtROQg1rpX_6uG-AYktDOHqaEzEPVvL9Fxi9mQfLy6zBQ@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/290] 6.6.95-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Jun 2025 at 18:39, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.95 release.
> There are 290 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 25 Jun 2025 13:05:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.95-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Regressions on parisc, s390 allmodconfig builds with gcc-13 and gcc-11 failed on
the Linux stable-rc 6.6.95-rc1.

Regressions found on s390
* parisc, build
  - gcc-11-allmodconfig

* s390, build
  - gcc-13-allmodconfig

Regression Analysis:
 - New regression? Yes
 - Reproducibility? Yes

Build regression: stable-rc 6.6.95-rc1 s390 parisc allmodconfig
sdhci-esdhc-imx.c 'sdhc_esdhc_tuning_restore' defined but not used

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build errors
drivers/mmc/host/sdhci-esdhc-imx.c:1571:13: error:
'sdhc_esdhc_tuning_restore' defined but not used
[-Werror=unused-function]
 1571 | static void sdhc_esdhc_tuning_restore(struct sdhci_host *host)
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~
drivers/mmc/host/sdhci-esdhc-imx.c:1549:13: error:
'sdhc_esdhc_tuning_save' defined but not used
[-Werror=unused-function]
 1549 | static void sdhc_esdhc_tuning_save(struct sdhci_host *host)
      |             ^~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

## Source
* Kernel version: 6.6.95-rc1
* Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* Git sha: 44f41e69469d0de714a6e7e56848c3e423ac2bb9
* Git describe: v6.6.94-291-g44f41e69469d
* Project details:
https://regressions.linaro.org/lkft/linux-stable-rc-linux-6.6.y/v6.6.94-291-g44f41e69469d/
* Architectures: parisc, s390
* Toolchains: gcc-11, gcc-13
* Kconfigs: allmodconfig

## Build s390
* Build log: https://qa-reports.linaro.org/api/testruns/28839625/log_file/
* Build details:
https://regressions.linaro.org/lkft/linux-stable-rc-linux-6.6.y/v6.6.94-291-g44f41e69469d/build/gcc-13-allmodconfig/
* Build link:  https://storage.tuxsuite.com/public/linaro/lkft/builds/2yuYHPJ5UcFEMxXVXUOIqaCBQWP/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2yuYHPJ5UcFEMxXVXUOIqaCBQWP/config

## Steps to reproduce
  - tuxmake --runtime podman --target-arch s390 --toolchain gcc-13
--kconfig allmodconfig

--
Linaro LKFT
https://lkft.linaro.org

