Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D2F6FC3AA
	for <lists+stable@lfdr.de>; Tue,  9 May 2023 12:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234976AbjEIKRR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 9 May 2023 06:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234953AbjEIKRQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 9 May 2023 06:17:16 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA0AD076
        for <stable@vger.kernel.org>; Tue,  9 May 2023 03:17:13 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9661a1ff1e9so486747266b.1
        for <stable@vger.kernel.org>; Tue, 09 May 2023 03:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20221208.gappssmtp.com; s=20221208; t=1683627432; x=1686219432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ohlbAzo5ypwXbaF7pM6OkdMeUeZBKkZUohq6OEP0kZU=;
        b=ziO7DvPc9SBB23k/jehuNJYdveEYLM7h0sazR78aoaxgiajd9ybCUcuDAf3VzW35L1
         iRc4Ae/FHc1FW73mx7JrbMQoc0ReumUMiG1MHR3J9JF+5Km1utCuV5aSAHlEHNTXty4X
         ryZko4DYK2p0Sc90zohTHW4dyo8hrxyiD2zfnp/lGPrn6U2JNu45UvUsj0SkJtNdHNWV
         gK7bptIul5zh9ro5ihYQtP1pQOlLM2h2gbgoiIC+F9DzrZ4ZoHrJd5gmvbMIwLLxum0j
         BByOL1WVXyQKzJPZMk9HDEHpqAl4OvV6+NMo5J8xrw7aCX2/b23SCLAPQy1HqW1FGBcJ
         mhAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683627432; x=1686219432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ohlbAzo5ypwXbaF7pM6OkdMeUeZBKkZUohq6OEP0kZU=;
        b=BTLPYfBFDyA1uC+0ZBF+rYWPCImtgzQK6kSAI8A53NEldB5x32qzN7DP6elMb6P+ZD
         e87qvwxrdzxGBWS/6LBEuKxbARvTj+eqiNFvQ5vsfv1TYSqzRWE4sXdWgS16bGe1BOXR
         7Uw0gYRylUw4dKXdiCt4KJpFQRB+ceyittNngZ6KGEPcpkcYJh3RnvP7mgN0LxhZUHQY
         9C2VThPydujuu8RChapjYeRPMKu78Qitr4uVXH8gJBLE66zrFH+NDMgSTbp1S/oH0YIY
         s15apsITFcsFu0ofLBXX6IDrFSX5bnILquTjwKfpSwPCDctGCmJMwo7dvEyqRcYn4SsC
         wBUQ==
X-Gm-Message-State: AC+VfDw8mMdR7pu0UlBR70Vl8JN/GMivto2srQ1IyZDHBQImk7X//rIP
        O4Fau3Pzsf/v/YyRVxuz+JDtRUIsyCG8WGArTFvIrw==
X-Google-Smtp-Source: ACHHUZ4fpHBQjFItIPZmI0/7UCEWgb0vqm/e9/KBpogQJkDgd3uL/4mLaxg2DFynAPUZl/b50gJqaip9svkToh9hxNo=
X-Received: by 2002:a17:907:868f:b0:969:f9e8:a77c with SMTP id
 qa15-20020a170907868f00b00969f9e8a77cmr1058743ejc.64.1683627432167; Tue, 09
 May 2023 03:17:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230509030653.039732630@linuxfoundation.org>
In-Reply-To: <20230509030653.039732630@linuxfoundation.org>
From:   ogasawara takeshi <takeshi.ogasawara@futuring-girl.com>
Date:   Tue, 9 May 2023 19:17:01 +0900
Message-ID: <CAKL4bV7QsdCtqJfm1O1MvkHN1WcmzGZuTaiBqmBVd7Rw59TsVQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/610] 6.1.28-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Greg

On Tue, May 9, 2023 at 12:27=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.28 release.
> There are 610 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 11 May 2023 03:05:05 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.28-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.1.28-rc2 tested.

x86_64

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P, arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
