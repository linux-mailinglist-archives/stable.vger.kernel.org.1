Return-Path: <stable+bounces-156436-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A486AE4FB3
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E14747AD256
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F7A223DE8;
	Mon, 23 Jun 2025 21:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Em1yFZH5"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0421FE46D
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 21:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750713409; cv=none; b=Psm3S+jhgQB1DjV57VCgTyKSVIrhMc2qYv5kWiq6vqGDXMnpe2R9fcrw1L5xCTCXzETwxMPc0ZM0Xrh548RIY6KhhjtasmHd0BSYeh3TjI4CH9GpXxQnAY+vpgMHopWgVtPxogeWJ+xQgG/hIHxLlRH2ruTtjtDkrvm5ipi2MfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750713409; c=relaxed/simple;
	bh=LtDdaRCFnOzRaKVTAE3F/dlf7+IT0xFa6bseJet1gxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uuwHQ2gv+YJXeCT1bl/KU+lDaSMw0JxXF5obPfvdlSA3JT1DgRY2poNduokFewYPIlDhNRnDJEOahwtK9tLF0t0SzVBPjgSzSzzU1qocSJJaJAQn4ZpQUP57XwHcWoFLXXSLAqZvwYH1XJI90g4Pd5OXpLJSgGW1cP6f1OO2ouI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Em1yFZH5; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b2fd091f826so3563334a12.1
        for <stable@vger.kernel.org>; Mon, 23 Jun 2025 14:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750713406; x=1751318206; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zAxIbG7Zl9ZnLRYF7XmoS7J2q0R3DwVsCI7SvRvrNiY=;
        b=Em1yFZH59f1mlQOzsdnTpgTQNByQwYO2Onm712PmJojwnHar4KolbbpTRrlQ47qn5/
         YoY5WziYWX2DuWoWMRydVxm/4IuLbAwNKgM/yt7Bkv2rpMeIZZLjuPXmIM2aea3BOI0n
         qTrMzrHibXjP6xD62J/To6qHpcp0ixJNhBdl5nycESZ6yQKRlrni1b7G3OQojqNP9unn
         V8JBlaTurnEJhgFpArRw1uWU+2i/+PoVW+ahGc6Lee98L6+V84nBtstOZxXkcBRrYXvD
         dfjvB4ewfFkPcD9cWqFZgfygTMlgHmuFndnAwEymI/zgSc6UlGc30eNISeG/7cWJ2lVE
         gByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750713406; x=1751318206;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zAxIbG7Zl9ZnLRYF7XmoS7J2q0R3DwVsCI7SvRvrNiY=;
        b=iot4FdADb1+RfQo2/YXLWOI73R5GmhGtrF/MIDqw/5GfmeFpnCCABXNUQpocKt0KOR
         MGh7RoebiTQliAG/62hWDBljhqyX1i9RTbUR8s7VC5WagI4cbPNL6E+Lm6oEhNp3kvUt
         IP8hg1/zu5JkgK1gjQP/RWICfa+U+eMXrEyAn02JQhZFij1tC4+lc2FKdJ9UgDbVqEe5
         TjTnzY0m5cRYWpk3HHEpDzKPzpeTm6oWoBvjHnGEix8gahRTqNn6CfY/J/pe+99Gwhab
         gyPfHvy2q/mbOxztUU5qSb7HbKNbutt/VChbJA6r5Vzrt4FDECMWG2Y79RJlLXuPn7TU
         0qmw==
X-Gm-Message-State: AOJu0YxwsH//7rrnpP8sLaLMNIBlFkYvOai1rl3y/DBSmxSPNMnmJ3vE
	c+VFjkHF/MWmPTtSjrk6pl+xqUgu2XTrkrg08SkxsLcpMxXcZDEzA02gZvEHnx9i3QrkDNzqxbA
	VSAi1kkOf21cLVzOFjtjqoACXkwQWRJbNnwH2NCPl2w==
X-Gm-Gg: ASbGncvCkBBOQoP1yLHXfVXYDjmo66KHVUWNE37UXgkbbJbGeuc1rgll3A+qL/XTVMQ
	Tvykjechjyz+bsmlz1lTzF5cvqx95FIHD3P7xUCv5Cy/YvXhrVTjcQCBGatLQZfPBbUtfLJy+02
	rq7mQuakjAP7iaGdGfacywI+b20cUDS/tpn5/eFIdOgRtjNh3h93RziS9CKVBJaE6yXBHcxyxN+
	o0/
X-Google-Smtp-Source: AGHT+IHdXTjLmFniSVEoVRLtzjN2ucReqYqHFsQsGXxHYWXnRGns80Bi6bWad99swFSENzSSlizfjzmNIUY68yEdsng=
X-Received: by 2002:a17:90a:da83:b0:312:dbcd:b94f with SMTP id
 98e67ed59e1d1-315cccc4472mr1503356a91.11.1750713405985; Mon, 23 Jun 2025
 14:16:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623130642.015559452@linuxfoundation.org>
In-Reply-To: <20250623130642.015559452@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 24 Jun 2025 02:46:34 +0530
X-Gm-Features: Ac12FXww9_WpdOaHdkgJbruDk5iAmI9JDDJZ3Q-jbazbPa6fMcxkmYRxXtADy4A
Message-ID: <CA+G9fYtdHwOUg==LJ-uiH2xy_GXU97yb2Fui0PnXShG_X8PA8Q@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/414] 6.12.35-rc1 review
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
> This is the start of the stable review cycle for the 6.12.35 release.
> There are 414 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 25 Jun 2025 13:05:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.35-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Regressions on parisc, s390 allmodconfig builds with gcc-11 and gcc-13 failed on
the Linux stable-rc 6.12.35-rc1.

Regressions found on s390
* parisc, build
  - gcc-11-allmodconfig

* s390, build
  - gcc-13-allmodconfig

Regression Analysis:
 - New regression? Yes
 - Reproducibility? Yes

Build regression: stable-rc 6.12.35-rc1 s390 allmodconfig
sdhci-esdhc-imx.c 'sdhc_esdhc_tuning_restore' defined but not used

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build errors
drivers/mmc/host/sdhci-esdhc-imx.c:1595:13: error:
'sdhc_esdhc_tuning_restore' defined but not used
[-Werror=unused-function]
 1595 | static void sdhc_esdhc_tuning_restore(struct sdhci_host *host)
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~
drivers/mmc/host/sdhci-esdhc-imx.c:1573:13: error:
'sdhc_esdhc_tuning_save' defined but not used
[-Werror=unused-function]
 1573 | static void sdhc_esdhc_tuning_save(struct sdhci_host *host)
      |             ^~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

## Source
* Kernel version: 6.12.35-rc1
* Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* Git sha: 97420f337f2e873945307514e185ab28a4eab0de
* Git describe: v6.12.34-415-g97420f337f2e
* Project details:
https://regressions.linaro.org/lkft/linux-stable-rc-linux-6.12.y/v6.12.34-415-g97420f337f2e/build/gcc-11-allmodconfig/
* Architectures: parisc
* Toolchains: gcc-11
* Kconfigs: allmodconfig

## Build parisc
* Build log: https://storage.tuxsuite.com/public/linaro/lkft/builds/2yuYNm13k63nvGpMv5Vv07a4U9J/config
* Build details:
https://regressions.linaro.org/lkft/linux-stable-rc-linux-6.12.y/v6.12.34-415-g97420f337f2e/build/gcc-11-allmodconfig/
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2yuYNm13k63nvGpMv5Vv07a4U9J/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2yuYNm13k63nvGpMv5Vv07a4U9J/config

## Steps to reproduce
  - tuxmake --runtime podman --target-arch parisc --toolchain gcc-11
--kconfig allmodconfig

--
Linaro LKFT
https://lkft.linaro.org

