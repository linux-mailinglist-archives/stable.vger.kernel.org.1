Return-Path: <stable+bounces-32166-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A15488A416
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 15:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBC641C3158F
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 14:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DA6188A73;
	Mon, 25 Mar 2024 10:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b9V+hUhS"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1F1182EE3
	for <stable@vger.kernel.org>; Mon, 25 Mar 2024 10:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711361696; cv=none; b=L3SItb5wona9RmnHWcTNFvYT0KFkC9Aku3bOnAKy8esKPPfHV/uEBhrVaoWLBfMS//Fj4SWU1XlOeKeSq13qsnXwWi2+/rHb2OqxUYd+CPy4ljXcEfBufaFoV7is8rBk/FqYXRzdVrzMCLtDN6PdDPgj2M16KFyBe2q+GStGo7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711361696; c=relaxed/simple;
	bh=0m4OvaG4TjQncz6CeAce4N9xOv37QnwgrtsxOEC72DY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I3rUfN7AoFBaSKd/5yjSZFK5S6z4snNdjhenLiJURtTlLr68Osb8aLFclLTW1aUL6VMvuls0pvIJrNUPkAaVWWvh5eWcWmUJsSDh4NILea+qisEDEh3ZBluY36UgpzjwQkKY/s1rNJvs+Rq+h3wph9WmmT1FfuaufrtbGNlqJCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b9V+hUhS; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-476588b3c3eso1454665137.2
        for <stable@vger.kernel.org>; Mon, 25 Mar 2024 03:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711361692; x=1711966492; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dviW0LXOA189cguARshIw5Rs0U+dfA78oWLA/wEMZ9w=;
        b=b9V+hUhSTri52MOQV4O9SAS49O7q8vzGOamgrGcMX5UFWxU0oryv40YiGIm2IH8hfc
         VcYNxn+kxSl0wWQl3LmK1SYEWiqp/WJDIs/sGGpnswwHP0g7g4LyleQ5e/ySdlLcVw0n
         HDiCjviIyP+rxq6IKpUQ0jBjiOgoqCRO1ck+884Z9yqqlCFBOAkZuvHF6qTsTlzui40w
         goLbwrqbPUyfol0kfoXfQs7j0IKuIHi+5g0AyOffmV4uVPt8L+p/g0qFvKnd4gGdcxxJ
         XfPR2EvzWJijbN+bdmM/ZoCexD01tAZn5V0BFe2Qm7isGWa1dqOhPWQSHdBf/OGf/nIP
         5aPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711361692; x=1711966492;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dviW0LXOA189cguARshIw5Rs0U+dfA78oWLA/wEMZ9w=;
        b=bgk0oT5Y/6N8x2cl8Qv+AMTsfFVoJhtksq84Bho3WXi67Ok3vF8RNx+s5ns/p0vZum
         dH8MxYvRMvqPoSPs1t2hv/sz1TYq/Fihf39N2VS05BQZ/syvglrOaCfQS8oIXHD3KdpH
         Pz+TnirTycjqC5UFMz3xO/ft9on3Bb8o7+uWEg+qRmTC4yShtV/P0ahnM4u9bnh0crYz
         ZvapdlD/bFunftwZ0zJkM5BuT6lf+F9I08MSIb6x/bVpcC0bHlQMeXtfE9J9hGLY5YsI
         XCjLCETHrxiPVnoGqqDoiUqccPUg1HXuKrBkfwHZ/SSbG6EHpstPThloDaWqtbnKXpnW
         FQfw==
X-Forwarded-Encrypted: i=1; AJvYcCUvq/S6m0JFog8xJ86ifJovAd93G0YjFE8+S8WiYE68nBhg7Uo/pbHHK1akjtmoEbhpDrPMa3oZKWWcxiHogmozoN2U5ZfS
X-Gm-Message-State: AOJu0YyE/oygqw8a5MUcb+edNHyWTUIGdGXi481KherW2enzwduYrkp/
	vjJtyTncMqZJ1LO94YSsUrQecr4PZYUU5u1ENFaOilXjMAuc6J6c2DoroUVgeWS/z/vWPv2YED2
	mus4Uz6myhy633AYAkl65DrLsRB68UcemliovAQ==
X-Google-Smtp-Source: AGHT+IE7UuJbdo/Q7mpnTl38KiQR38Lr7QPsY1r8hICE+qSu1pk5jF1m+963Bm6mVEV1ywLMunOIjDDA1DcsD4vlKMw=
X-Received: by 2002:a05:6102:a46:b0:478:619:342f with SMTP id
 i6-20020a0561020a4600b004780619342fmr748178vss.24.1711361692535; Mon, 25 Mar
 2024 03:14:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324223455.1342824-1-sashal@kernel.org>
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 25 Mar 2024 15:44:41 +0530
Message-ID: <CA+G9fYu1G1+LKu0mOhppUbVcAJ2DaC-zSh2GBhfShR_No9T=9g@mail.gmail.com>
Subject: Re: [PATCH 6.8 000/715] 6.8.2-rc1 review
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	florian.fainelli@broadcom.com, pavel@denx.de, 
	Thomas Zimmermann <tzimmermann@suse.de>
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Mar 2024 at 04:05, Sasha Levin <sashal@kernel.org> wrote:
>
>
> This is the start of the stable review cycle for the 6.8.2 release.
> There are 715 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue Mar 26 10:34:31 PM UTC 2024.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.8.y&id2=v6.8.1
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
> and the diffstat can be found below.
>
> Thanks,
> Sasha

The Powerpc ppc6xx_defconfig build regressions stable rc branches

Build details,
 - ppc6xx_defconfig - linux-stable-rc-linux-6.8.y - gcc-13 - Failed
 - ppc6xx_defconfig - linux-stable-rc-linux-6.7.y - gcc-13 - Failed
 - ppc6xx_defconfig - linux-stable-rc-linux-6.6.y - gcc-13 - Failed
 - ppc6xx_defconfig - linux-stable-rc-linux-6.1.y - gcc-13 - Failed

 - ppc6xx_defconfig - linux-stable-rc-linux-5.15.y - gcc-12 - Failed
 - ppc6xx_defconfig - linux-stable-rc-linux-5.10.y - gcc-12 - Failed


Build error:
-----------
drivers/macintosh/via-pmu-backlight.c:21:20: error:

'FB_BACKLIGHT_LEVELS' undeclared here (not in a function)
   21 | static u8 bl_curve[FB_BACKLIGHT_LEVELS];
      |                    ^~~~~~~~~~~~~~~~~~~
In file included from include/linux/init.h:5,
                 from include/linux/printk.h:6,
                 from include/asm-generic/bug.h:22,
                 from arch/powerpc/include/asm/bug.h:116,
                 from include/linux/bug.h:5,
                 from include/linux/thread_info.h:13,
                 from arch/powerpc/include/asm/ptrace.h:342,
                 from drivers/macintosh/via-pmu-backlight.c:11:
drivers/macintosh/via-pmu-backlight.c: In function 'pmu_backlight_curve_lookup':
include/linux/minmax.h:31:9: error: first argument to
'__builtin_choose_expr' not a constant
   31 |
__builtin_choose_expr(__is_constexpr(is_signed_type(typeof(x))),
 \
      |         ^~~~~~~~~~~~~~~~~~~~~


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Steps to reproduce:
------------
# tuxmake --runtime podman --target-arch powerpc --toolchain gcc-13
--kconfig ppc6xx_defconfig


Links:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.8.y/build/v6.8.1-715-gb0f6de60d946/testrun/23136379/suite/build/test/gcc-13-ppc6xx_defconfig/details/
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2e9dGALLBbylr7k4kq5DMdvqISo/


--
Linaro LKFT
https://lkft.linaro.org

