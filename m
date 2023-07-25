Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A6376186C
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 14:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbjGYMdW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 08:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233712AbjGYMdO (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 08:33:14 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C4811A
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 05:33:13 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fdea55743eso5089152e87.2
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 05:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20221208.gappssmtp.com; s=20221208; t=1690288391; x=1690893191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WKpkzF96g9NgPXhoWUx4qyrJxQAYJZi3pZkdXCYeBMY=;
        b=4svnrkRxCvqD6vorNSJ9EaNW3eXE3a6UZ2gc6wDPppaH8KH26QSUVB5VR0+xPfNfkB
         3uwaDda0GVEq5B74jOGO3Sgj30u3I/rpJan0+jcgEj1o0QElQte7N2suv86J3/SLewNX
         9JDYA9sxvSUT0QGxctNzMwl1/+KGZ14n5jAm3Vywncfc+FZ9al9JCOFhnB+LJgbvEJ4p
         76g/SCsq+F4PvA/D7gx78PCLrNyjDniUtWMBr5BAvKwHI8+AUoUgzNHyWru9hdl/q3ff
         EQIng1U+whNHxVRd3bNHL9CtvRtJAAR1w/Gw4y/3SapsDAgOMcINyW+xnht4HjrTw8+y
         VFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690288391; x=1690893191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WKpkzF96g9NgPXhoWUx4qyrJxQAYJZi3pZkdXCYeBMY=;
        b=W4vmbKz12p15q/RS4ooV4HqDBEVnj/zjN0h6GHGrPjdmFJwPSQ0vPnPW1Wl/7TePcj
         Y/fXc9bfAHed+8Y4cBkeuwZFJJKpJeb1dvZf0xG8rG66XRym+ul3CwInYhJJJ/pSBELH
         WaFOoQbOvnJ0QZqgfEy+qdamNZ+toiVXMduc4KMoLe4/UrYOTwaYGPEUzFjcNeKiHUrA
         Xx+FzFTL67Ypbr67xN0dDwenLbzTrv6CdXkJXSKBcksJaRkTL8typCB0kehumMj3IaAB
         GP9zwhyJf6RfdsKUen9gqrYQhMsUvWDx1fNN68D9K6015mhXl2YIm1cxLPfdi5IN+m8k
         Z3xA==
X-Gm-Message-State: ABy/qLbh+4dVh3MKMUiEC2jUuqdfukABiyuknKe0jF0IU2acht+mSmcc
        0mtKJTvROYDuUMC39aROxxs+jMUKwA+WOc5iPDOUrA==
X-Google-Smtp-Source: APBJJlHmfFkFQER3q6Dst2bu92mvAGDw0hUkJ4O0za2LwpY5NSiE/siaSsfkrIU/FsRkfek7BbGEr5EpbXqs7WSnVUg=
X-Received: by 2002:ac2:4f05:0:b0:4f8:5696:6bbc with SMTP id
 k5-20020ac24f05000000b004f856966bbcmr8779702lfr.29.1690288391202; Tue, 25 Jul
 2023 05:33:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230725104507.756981058@linuxfoundation.org>
In-Reply-To: <20230725104507.756981058@linuxfoundation.org>
From:   Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date:   Tue, 25 Jul 2023 21:33:00 +0900
Message-ID: <CAKL4bV70qiD5jFcx9ALXJdCS+OBeQnZpAwJZZsJhs6=vCmewsg@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/183] 6.1.42-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Greg

On Tue, Jul 25, 2023 at 8:03=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.42 release.
> There are 183 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 27 Jul 2023 10:44:26 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.42-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.1.42-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
