Return-Path: <stable+bounces-6496-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD3280F66F
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 20:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B0861C20CAE
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 19:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7478081E34;
	Tue, 12 Dec 2023 19:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8ZKjkAj"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20DDF83;
	Tue, 12 Dec 2023 11:18:55 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6d852e06b07so3169533a34.3;
        Tue, 12 Dec 2023 11:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702408734; x=1703013534; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lRI+Z3So7cR4czFluxvYwlfma5c41gzeBHqb5Y4Vja4=;
        b=L8ZKjkAj4FxUuDel9bmnOGK4HBLG4mWngj2QLiVQ99A3jpDeinLzXLuV0lyFGbO2Hq
         hkL6e330DaXwDzdCW+pqSswR/MeCX7S07m0SMqHKGc4U/z24DCUl9sg1PUKhRN3HqhYD
         FKQo9Nk3J8rAPjdTTZ9zk0PY/Tw7W6MJcnOPjvaMSkekJ9usnTIiAm0bP/jqXFbvZsYQ
         LrKYv8lVk/F9BGiKUU/W13ibOodmT7fNfHI6NX6LOwcKjxs7MN/s9dJsE+ALN9TYrcd4
         q5eJ8jYqRlIa3tBDl6AJ8LMQQrAcjoDaGrGAHe7vL9wkT0lutFFaxKagi4X0mSztUiqh
         n1jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702408734; x=1703013534;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lRI+Z3So7cR4czFluxvYwlfma5c41gzeBHqb5Y4Vja4=;
        b=iwbLn70FD/z0b86V2KIu+7RYAsjZDy81Rr5xJda7/UX7HUCm6mwbfJTGOfItdXUzJ3
         72pEspHEoMPVcc1ltfVfgu1soco3+mGP97mysmZGEtBUGuSHYv6wlyvje2nUBsb0xV/j
         Lx6WSIkt0NehJRA/yhFX6z9I2o/vaQGcIGibspSHWbjy35lDae8NHI37jCWNNXL6MqIX
         oUr4xGiy71SYaRgBcCAOf7zuuqTQx/sAaE6olEzBxTwZuGfRQ0IgJUpHvp0u6NYbOhnr
         IdT0Oyj3O/UX0e8v032jDr/OpBXcpnBELqqBFnaZq7uwrMVIZkSRaw5i7Szpb9fhHVBO
         +6Cw==
X-Gm-Message-State: AOJu0YyfcvR+d8Xi05DUnsNTGocgJiUMwVRv3AdBV0OFModl9ExJQWZM
	jW9B6H9GHIYWiofGE4C6uSq/NAaGBD1wzEnL2vY=
X-Google-Smtp-Source: AGHT+IH7Gl41yzN1LlyzIXzr+mlZbXiwYsHqWWxOt4X/4Qmx+WYf32alvxIxL2Sd1mYkqJPxFCwDNJ75FR52QYnPlC0=
X-Received: by 2002:a05:6830:118c:b0:6da:3071:2f78 with SMTP id
 u12-20020a056830118c00b006da30712f78mr516440otq.23.1702408734423; Tue, 12 Dec
 2023 11:18:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212120210.556388977@linuxfoundation.org>
In-Reply-To: <20231212120210.556388977@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Tue, 12 Dec 2023 11:18:42 -0800
Message-ID: <CAOMdWSKV3KfehCOpkANWxbbi7-kCwbBs93L12Pay6Bk_QRfPXA@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/139] 5.15.143-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 5.15.143 release.
> There are 139 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 14 Dec 2023 12:01:32 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.143-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Compiled and booted on my x86_64 and ARM64 test systems. No errors or
regressions.

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks.

