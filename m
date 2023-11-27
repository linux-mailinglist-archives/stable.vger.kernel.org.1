Return-Path: <stable+bounces-2807-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B457FAAAD
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 20:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81DE3B20F0D
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 19:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48ED45956;
	Mon, 27 Nov 2023 19:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bctYYrUL"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732121B4
	for <stable@vger.kernel.org>; Mon, 27 Nov 2023 11:55:41 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-462f2fec472so577499137.2
        for <stable@vger.kernel.org>; Mon, 27 Nov 2023 11:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701114940; x=1701719740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/TMOaAh1xttulN4HpcJfcDREcNIucjhookb0crER2fo=;
        b=bctYYrULkwIGuGGOhefgCRTJieRsmaWF5hPkUm3+B7MT0lkGIjZaJyQ7JZXHcSy+HU
         810s9QFvec057/58mxiqa3ml7TQNktfdQ/AAitSRb58V5X4UamrWJW1s2R6Kwax/zfBs
         ysaSaP8EagmcZl4m0T9drpHNksHBzc+jls3/CwUicZxYflf6XoN5SORjH3Q/XPzUvClp
         o/FRpyBpgpJ4dgYiO6Y5QtAU5bOrBbeQJ15vF8z2oGMKW9UsG8LdT8rs+q23OThHEX8t
         jsEVw5nDOT9O4aYfq/OWT38hfymrDYnETNr+dMed4D4n/NkfxK7dQD096BobzNB9ds5P
         5wYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701114940; x=1701719740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/TMOaAh1xttulN4HpcJfcDREcNIucjhookb0crER2fo=;
        b=kB0tXK1+Vd4r6+Dr9wwYXi5TiU502N5l/Ej43pelxZTtHPIOQwmjQYUXAlsN8bcSTU
         i8c76DzC79SxrwO999Yz2rHHLwZOda/ltyFAHTso23Ws2gJ97cLmEij4EmqKCJUqhOl7
         V6Ue1zzOy8nZQATzfwaWXHoXfpF2O5eiL38/QIcr/oot3x1jU5E/VNCM+l8d7OzMe+C8
         B1H4WD0dp7/xiu8E6s2wNBfd1pN/7pA3x4g6gW5zs5giUrTlhnxL+Ow9ek+BMzej8VFK
         68p0xqO5UUK2rxtWNj7oPkLuOwKLuVMDJGYpXVUBFLCnVVneTGU0mIWkYr+AJBr2ZQR3
         Hnvw==
X-Gm-Message-State: AOJu0Ywg0Q7heoOWburiZ3WmZvS6euiFqolpXwreG2J5z+SVOzrlf23r
	s+/g6CYCCWDNHQdBgoJdnDMAI48rNenPlHWyjti+6A==
X-Google-Smtp-Source: AGHT+IF1mAFvOGAvsDg4pZ0R8M8hiRKSHtJN0pBMxbewTkFnpMlzKn4GXJ7+GoqmrN8fTu0r7ShP9hBxdVV81qBlWn8=
X-Received: by 2002:a67:fb03:0:b0:462:d592:b078 with SMTP id
 d3-20020a67fb03000000b00462d592b078mr12137866vsr.32.1701114940428; Mon, 27
 Nov 2023 11:55:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231126154329.848261327@linuxfoundation.org>
In-Reply-To: <20231126154329.848261327@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 28 Nov 2023 01:25:29 +0530
Message-ID: <CA+G9fYudTmZ+t84YLfe2wTXxORpTFBp8p9S=NYVOMretu-VSyg@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/152] 5.4.262-rc4 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 26 Nov 2023 at 21:16, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.262 release.
> There are 152 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 28 Nov 2023 15:43:06 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.262-rc4.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

[my two cents]
[May not be a great idea to test latest clang on older kernels]

Following kernel warning noticed on stable-rc linux-5.4.y with
clang-17 for arm64 defconfig.

> Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>     PCI: keystone: Don't discard .probe() callback
>
> Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>     PCI: keystone: Don't discard .remove() callback

WARNING: vmlinux.o(.text+0x4e2a80): Section mismatch in reference from the
 function ks_pcie_probe() to the function .init.text:ks_pcie_add_pcie_port(=
)
The function ks_pcie_probe() references
the function __init ks_pcie_add_pcie_port().
This is often because ks_pcie_probe lacks a __init
annotation or the annotation of ks_pcie_add_pcie_port is wrong.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Link:
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2YlCuygCpZ8wNd4DS=
0txeyTovV4/

--
Linaro LKFT
https://lkft.linaro.org

