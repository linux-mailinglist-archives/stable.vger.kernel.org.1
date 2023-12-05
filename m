Return-Path: <stable+bounces-4704-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15211805929
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 16:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4627D1C210D6
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 15:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C3668EBB;
	Tue,  5 Dec 2023 15:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZjZ2Ra2m"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B945318D
	for <stable@vger.kernel.org>; Tue,  5 Dec 2023 07:54:11 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-db510605572so4148804276.0
        for <stable@vger.kernel.org>; Tue, 05 Dec 2023 07:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701791651; x=1702396451; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OpCZZN7ifzLhrwAYxkGqYDBB1FuZ2YnYQt+7H4zDU+Q=;
        b=ZjZ2Ra2m9jCfp3zsDGaiueJ0GfvHiEPOHTWwRqGZ8tpVqnnWAuhjaJ2MxBVazJYwo+
         AvqN3VKfF/m7dzicuf1H1AYbzhYSWM1LLAr2/AEYMoTlhtrVy0rtsv59pRNu+WirrgfW
         t5Z6tUNjbsR6HEKGvk50G70sW/U+XJUT8hPTEPmdECqUXHa0F6CLEW0/P36hxi8zyWaI
         aLVJfaSSm0lGJvzbDnn7ujPsWQQIL6E8N3pmut+fQyuccoJLvyzht/wlD6Di7PvEyBgo
         qZiJRkgkul5MtSSx4Cdv0OrvQGdUKA89Px7RGKQcmcR7Z/ALRcTd/wnyUNV03y69/tS8
         4+sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701791651; x=1702396451;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OpCZZN7ifzLhrwAYxkGqYDBB1FuZ2YnYQt+7H4zDU+Q=;
        b=JQZNAZir8r4iDt66xmD+QUz1E1NTQGfrjZYWoMNWNHuZHTihJP3VptJE+nAkV9RZJG
         h7/cdpj9C08235k6BkgboADDfJb0NJOI40qYfIT7aIY/vOLBXNTH7YK4mtMS50YbDO2A
         AV6oeybwdYkv7jxbc/pbOCJD0AyQKZ4kmfQPVv2BvTyO7UD1oLTaHb8thg55ldY+s3cc
         ihqlfafx29IdplXju2e0R5KeD0B2JtLT1EFOCoEmGaljWKwpp83ux6LcPMgNPOvkW41v
         SBuPOvlNkkB/hF3+2kzosH+yveEKI3lXWFbN2wrvVHvPA2rRrjC+WLmujZqJ9Qk0Mqnj
         fM/A==
X-Gm-Message-State: AOJu0YzYeIPPNEh6zEPPKeMHr8u6Kl5y7asBQ0YL81vaW7crlJkCQynW
	+iF+QD+89xMNKXzoUAxVLTZnGzZuYCWmbKfN9YEExA==
X-Google-Smtp-Source: AGHT+IGCJb6NJTexBLiNBzgMwl8doc7Qk7WTAXljr3GKe9KFhu9oJQpIiiYrofNfQQq+O9e/tLSF6yqkhku8Pwwo5cc=
X-Received: by 2002:a25:b293:0:b0:db7:dacf:59fc with SMTP id
 k19-20020a25b293000000b00db7dacf59fcmr4225994ybj.112.1701791650893; Tue, 05
 Dec 2023 07:54:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205031535.163661217@linuxfoundation.org>
In-Reply-To: <20231205031535.163661217@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 5 Dec 2023 21:23:59 +0530
Message-ID: <CA+G9fYuL_-Q67t+Y7ST5taYv1XkkoJegH2zBvw_ZUOhF9QRiOg@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/134] 6.6.5-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Johannes Berg <johannes.berg@intel.com>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	Netdev <netdev@vger.kernel.org>, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Dec 2023 at 08:51, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.5 release.
> There are 134 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 07 Dec 2023 03:14:57 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.5-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


The x86 allmodconfig with gcc-8 failed but passed with gcc-13.

x86_64: gcc-8-allmodconfig: FAILED
x86_64: gcc-13-allmodconfig: PASS

Build error:
------------
In function 'nl80211_set_cqm_rssi.isra.44',
    inlined from 'nl80211_set_cqm' at net/wireless/nl80211.c:12994:10:
include/linux/fortify-string.h:57:29: error: '__builtin_memcpy'
pointer overflow between offset 36 and size [-1, 9223372036854775807]
[-Werror=array-bounds]
 #define __underlying_memcpy __builtin_memcpy
                             ^
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Suspecting commit:
-------------
wifi: cfg80211: fix CQM for non-range use
commit 7e7efdda6adb385fbdfd6f819d76bc68c923c394 upstream.


Links:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.4-135-gb0b05ccdd77d/testrun/21509070/suite/build/test/gcc-8-allmodconfig/log
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.4-135-gb0b05ccdd77d/testrun/21509070/suite/build/test/gcc-8-allmodconfig/history/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.4-135-gb0b05ccdd77d/testrun/21509070/suite/build/test/gcc-8-allmodconfig/details/


--
Linaro LKFT
https://lkft.linaro.org

