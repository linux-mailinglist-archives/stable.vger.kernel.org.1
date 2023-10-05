Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399DF7BA364
	for <lists+stable@lfdr.de>; Thu,  5 Oct 2023 17:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236321AbjJEP5N (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 5 Oct 2023 11:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236698AbjJEP4d (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 5 Oct 2023 11:56:33 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1B438A3E
        for <stable@vger.kernel.org>; Thu,  5 Oct 2023 06:57:41 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9ad8a822508so199551866b.0
        for <stable@vger.kernel.org>; Thu, 05 Oct 2023 06:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1696514260; x=1697119060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3jhe3s5Ktjadi5rzr/ScNUu5PHR0qhenACs1FczGETQ=;
        b=jwpAFJl1JejsXJHgW12QeNMyFK3d8sKfPVbeBTtJw/JgHNFxuIdR2HTTcSf/CcAZWt
         ZVOB/AG5rp6pCZu8qtEuq3TXdqCU8b9hlP4AM84v/syWNIbr7q0fA+7THQgIVfqzTaT1
         T0B+UM7Ck7j4O8j3qNBQb7EOAn46X5kGCbH5fcfhNhyV/3lt4UPbYQe8kS7o2e7UoaF+
         N53Dp6vO9MRV6QO5LMxD2Tc4ke6SswD5fY7zF4pf7poW8pGBwEcmP8I+CXPywRzdNVF8
         nX6C+acE7HUeXNkMCVooydwUvwfOsiINSjlbujE1XWXuoiWRGc02GAI6vLurMze+TynK
         aKpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696514260; x=1697119060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3jhe3s5Ktjadi5rzr/ScNUu5PHR0qhenACs1FczGETQ=;
        b=vE8NqdRnSFkmoxkOyfirM43Tug58wdzlrAFh40JOcA2+ORkt5MJSAlNHjiB2nDzt7C
         pNraHlkgjgjGMt9u1nr9rwjKDqjE0Kf9JTdWb6NKvBKx+V+yHz5OgWfFayKA5hAwPCjO
         RGW6ttTDhD2M/f3BTPQvHEjtWyBr22LCPxavj/6TqpS8QrdVrctWpzdqfRrCdkguXMH8
         g0cYhasQD83w067ShURFhnntZu3tvx2LmzYY+NwDyrDPtOmILaSDxl1InHPBthXutY/d
         Ex2OdSnaLtVwv4cbZnx93vurvxsqZ0jOLPgkleZB5zsWFpZxOzLIsAHuLntoK1PbxExI
         SQZQ==
X-Gm-Message-State: AOJu0YwQGETXq+tsaGGYxlyMVZYGhrzplmmogW6pjmsfk2SM60cG23+N
        RwtA4B9Kg5P2Av/4COw5+CIoHeaQz8g8jR7z9xh3o1IkIfuUzGpthFY=
X-Google-Smtp-Source: AGHT+IE9EjlSzKkLLQqvCvGzIENu290Y/0rTmuLlaYvhP9xylHLtEWKPqU9Nsjm1c/1q+IItp+Hh54AChE7gTHxMG7Y=
X-Received: by 2002:a17:906:9c9:b0:9a1:bd33:4389 with SMTP id
 r9-20020a17090609c900b009a1bd334389mr4428143eje.74.1696514259837; Thu, 05 Oct
 2023 06:57:39 -0700 (PDT)
MIME-Version: 1.0
References: <20231004175217.404851126@linuxfoundation.org>
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
From:   Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date:   Thu, 5 Oct 2023 22:57:28 +0900
Message-ID: <CAKL4bV5n6_T5S6SrgqjKLbSZVg1FrB39a-vVRaa3m2uzXExJ6Q@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/259] 6.1.56-rc1 review
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
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Greg

On Thu, Oct 5, 2023 at 3:12=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.56 release.
> There are 259 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 06 Oct 2023 17:51:12 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.56-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.1.56-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
