Return-Path: <stable+bounces-41336-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D668B043F
	for <lists+stable@lfdr.de>; Wed, 24 Apr 2024 10:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C27911F23E61
	for <lists+stable@lfdr.de>; Wed, 24 Apr 2024 08:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E28158A04;
	Wed, 24 Apr 2024 08:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D99h+jPI"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71121581EB
	for <stable@vger.kernel.org>; Wed, 24 Apr 2024 08:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713947030; cv=none; b=GRjEZ0d2Gh0XYxZjcQbAwvTbNo4Z+RCKOEhBC/otutIlkzPx9kP/JbTg/ihVkIQwqMb5zFN7YTBFu4avuSJkFFjnISz052j9sC8AQdz8S2qZ7/iwLjzTmOXRqNkg08VAw0TMxTbOtI1vsNKt5lOW6DTFKHBnUu/EExe2MPlvzmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713947030; c=relaxed/simple;
	bh=Zp3ox78TP6hxWDah/Xpqv+ArZs5jq62G8JwODJB4R/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V+X02cEQWfJ/0xSk1hNjBygdzySnX0O6dudQW/LvFzckmRSUlxvip+5hnZ9zFB60VO+Gr2KlOF3Q4h2kaBSCtbRWghwBZFV3ZHISu4+par/HTfO86PTiLhfYjcqZ/zEpR7BCtOJqDjR6dwygpBmTUr7oxi2MPXgzuMhP/XtCrgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D99h+jPI; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4daa513e430so1669788e0c.2
        for <stable@vger.kernel.org>; Wed, 24 Apr 2024 01:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713947027; x=1714551827; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hPFo+IxgUQ2kIlqLDAB9FNtWLgx3YKcW7YRqfGcT4is=;
        b=D99h+jPI02n6GqC0nTUgIBoOB/rxNVXaq+kV/nJeyIEeK9HKDBCFa35QkEhKnSrYSb
         fSChGitjJDJuJORQ6mqbBpP5jjUy14U8DUJF25Xl1e+lkn80UzRJX93D1BU01eBY5GgG
         T3bQ2c5PgSJ03ZWXGKDxrzkUd2DUPAoyANAOyL6kT20v6r01BnS9/6RyvwYfnxsMQqTt
         bS0NNUoXToSapKYv02Cnsc0GkNtKrDhjL6X7WDSkRNbVBT3P0Og7sFHVomxUx55UuToQ
         D2gtLw7CrXAo+63p52KAeMMDLKWgv8BM2WqJn5FMge0NkffY9VhFLDjpBPRAS+Gw1Rcv
         wawA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713947027; x=1714551827;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hPFo+IxgUQ2kIlqLDAB9FNtWLgx3YKcW7YRqfGcT4is=;
        b=T5R0vBF6k1V5RxyIiwIYzeJY73zLcg4r4AQOKCbykCyAAvaYYPPwxKR+nP3PAcUX8f
         8+nz86jzlr+XsZ3YbnGsdRD/OYsFkNYo/lCk2uH4tNvKbRMRRJHNf6f0mr7K49T5688z
         I/BkZ+qWoEVLCuPhBBaM5d6bsZDFqkYF4Kpy1osGbKCQNLwWD/v36Buw6GWKwZE0Xgu3
         KlstV+GG0H77AH2ae/WofV9dVH6m5f6zNVBVM8evfd3amQc7klPo6qQOlHsR1HWXeX2J
         zDg+4OshbtUZzlna8Mq5e6p4lfLWisT4x4JTLS2rYAyY/QzJQCS5K00TOmIiiylQLaSF
         CSnA==
X-Gm-Message-State: AOJu0Yw5ESY02dUXu4g9iupbBk34+IATcOQSZBpOnowo1B+7S6G2aKKo
	T4JeFa2vToS9kZi+5/tj+C0ie+VcjqtYItV+dMla6DmSVBBaakcH+5Opklc9NhOYRYaAEJV98ta
	h8scXlqpHm4rEGoBMsGrN/zm2lOXiJgcaPe9dKw==
X-Google-Smtp-Source: AGHT+IHZ7X76KDkGnfGA3Bl/vGPMhc2BLowSx3pIZsvhaqPdCqZCneOazFLgOUQklJc7AYOw6nVgw9sTtiQodVWHsnE=
X-Received: by 2002:a05:6122:3284:b0:4dc:fbc5:d47 with SMTP id
 cj4-20020a056122328400b004dcfbc50d47mr1633005vkb.16.1713947026616; Wed, 24
 Apr 2024 01:23:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423213853.356988651@linuxfoundation.org>
In-Reply-To: <20240423213853.356988651@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 24 Apr 2024 13:53:35 +0530
Message-ID: <CA+G9fYuv0nH3K9BJTmJyxLXxvKQjh91KdUi4yjJ0ewncW5cSjw@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/141] 6.1.88-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, Anders Roxell <anders.roxell@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Apr 2024 at 03:14, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.88 release.
> There are 141 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 25 Apr 2024 21:38:28 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.88-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

As Pavel reported,

LKFT also found these regressions on 6.1.

The arm build failed with gcc-13 and clang-17 on the Linux stable-rc
linux.6.1.y branch.

arm:
 * omap2plus_defconfig - failed
 * defconfig  - failed

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Suspecting commit :
-------
  ASoC: ti: Convert Pandora ASoC to GPIO descriptors
    [ Upstream commit 319e6ac143b9e9048e527ab9dd2aabb8fdf3d60f ]

Build log:
---
arch/arm/mach-omap2/pdata-quirks.c:259:15: error: variable
'pandora_soc_audio_gpios' has initializer but incomplete type
  259 | static struct gpiod_lookup_table pandora_soc_audio_gpios = {
      |               ^~~~~~~~~~~~~~~~~~
arch/arm/mach-omap2/pdata-quirks.c:260:10: error: 'struct
gpiod_lookup_table' has no member named 'dev_id'
  260 |         .dev_id = "soc-audio",
      |          ^~~~~~
arch/arm/mach-omap2/pdata-quirks.c:260:19: warning: excess elements in
struct initializer
  260 |         .dev_id = "soc-audio",
      |                   ^~~~~~~~~~~
arch/arm/mach-omap2/pdata-quirks.c:260:19: note: (near initialization
for 'pandora_soc_audio_gpios')
arch/arm/mach-omap2/pdata-quirks.c:261:10: error: 'struct
gpiod_lookup_table' has no member named 'table'
  261 |         .table = {
      |          ^~~~~
arch/arm/mach-omap2/pdata-quirks.c:261:18: error: extra brace group at
end of initializer
  261 |         .table = {
      |                  ^
arch/arm/mach-omap2/pdata-quirks.c:261:18: note: (near initialization
for 'pandora_soc_audio_gpios')
arch/arm/mach-omap2/pdata-quirks.c:262:17: error: implicit declaration
of function 'GPIO_LOOKUP'; did you mean 'IOP_LOOKUP'?
[-Werror=implicit-function-declaration]
  262 |                 GPIO_LOOKUP("gpio-112-127", 6, "dac", GPIO_ACTIVE_HIGH),
      |                 ^~~~~~~~~~~
      |                 IOP_LOOKUP
arch/arm/mach-omap2/pdata-quirks.c:262:55: error: 'GPIO_ACTIVE_HIGH'
undeclared here (not in a function); did you mean 'ACPI_ACTIVE_HIGH'?
  262 |                 GPIO_LOOKUP("gpio-112-127", 6, "dac", GPIO_ACTIVE_HIGH),
      |                                                       ^~~~~~~~~~~~~~~~
      |                                                       ACPI_ACTIVE_HIGH
arch/arm/mach-omap2/pdata-quirks.c:264:17: error: extra brace group at
end of initializer
  264 |                 { }
      |                 ^
arch/arm/mach-omap2/pdata-quirks.c:264:17: note: (near initialization
for 'pandora_soc_audio_gpios')
arch/arm/mach-omap2/pdata-quirks.c:261:18: warning: excess elements in
struct initializer
  261 |         .table = {
      |                  ^
arch/arm/mach-omap2/pdata-quirks.c:261:18: note: (near initialization
for 'pandora_soc_audio_gpios')
arch/arm/mach-omap2/pdata-quirks.c: In function 'omap3_pandora_legacy_init':
arch/arm/mach-omap2/pdata-quirks.c:271:9: error: implicit declaration
of function 'gpiod_add_lookup_table'
[-Werror=implicit-function-declaration]
  271 |         gpiod_add_lookup_table(&pandora_soc_audio_gpios);
      |         ^~~~~~~~~~~~~~~~~~~~~~
arch/arm/mach-omap2/pdata-quirks.c: At top level:
arch/arm/mach-omap2/pdata-quirks.c:259:34: error: storage size of
'pandora_soc_audio_gpios' isn't known
  259 | static struct gpiod_lookup_table pandora_soc_audio_gpios = {
      |                                  ^~~~~~~~~~~~~~~~~~~~~~~
cc1: some warnings being treated as errors
make[3]: *** [scripts/Makefile.build:250:
arch/arm/mach-omap2/pdata-quirks.o] Error 1


steps to reproduce:
---
# tuxmake --runtime podman --target-arch arm --toolchain gcc-13
--kconfig omap2plus_defconfig


Links
---
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2fWG4dRZzA7WgJqyLQ8Rm05WTUo/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.87-142-gcde450ef0f2f/testrun/23640116/suite/build/test/gcc-13-omap2plus_defconfig/details/

--
Linaro LKFT
https://lkft.linaro.org

