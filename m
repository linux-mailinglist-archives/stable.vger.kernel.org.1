Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B337CC203
	for <lists+stable@lfdr.de>; Tue, 17 Oct 2023 13:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbjJQLu4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 17 Oct 2023 07:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233882AbjJQLuz (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Oct 2023 07:50:55 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B2FEA
        for <stable@vger.kernel.org>; Tue, 17 Oct 2023 04:50:53 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9c5b313b3ffso143602166b.0
        for <stable@vger.kernel.org>; Tue, 17 Oct 2023 04:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1697543452; x=1698148252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gWNFjq7J1b1bH2lphfT1Fu13xafbJk+ueucEMZRdQUY=;
        b=mmNv0G+LbrxkSsqLPSB85jrwi4vzk2ia34tK1wbC+UxWMipX+BhZAkqKTytY66/Tjs
         kvG0HW2vrDTFvqgDTjVYetwTq7rKmitPHG+ylD41doVfqRBQ7pgIORyUM69l2EYWlKS/
         jjE/jCoimDE1InQ9IRC+6SBE1G1gmVse4/3gCVJjW85abpIGULPTR4xCdlT1QYHeRJyo
         OIsFX9ENUDCKoMHtuEHhHUYJTJFy3P3bbShNkU+hS+dXyA6e96WsTvHsVF/odIKw7Vr/
         /rmXiyT4p3Eh4Bi6RK/Ymmp7VaT5TvSdW2TI1RQHZKs4CgdcvHhgMdJPtylB5JBIaGKJ
         QxWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697543452; x=1698148252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gWNFjq7J1b1bH2lphfT1Fu13xafbJk+ueucEMZRdQUY=;
        b=HTsuVjmjN543CS9dTZ/h/pSC/qTjdWfqWEqa2bmR5zJ46jDaeTMaFRaR9V/zZ6vILR
         zLQ9zyeRaAhyTMzGT1Ki0xQBANlu9Woi+Zucq/hYLpGyJIVVYz0Y+l+mItokNiHeMBkd
         ymdI9bB3YiadagwjqOw9CO8n/ydhPWkIyuUxI4xb+Mw39M17lc4N5ZMTLRtYYEw4w1+g
         Y+6wUq82hFpWa9fX4PmNM7F7vNJ31c0/r9uQj+KDWuvLYWe3WoOrj0HqYM7UVo6JQxJG
         aRbGbD/8F7GYeHRyRe0YMRQZjncoRFFxx8/HFQk5V+M/PWSsAJTw8MN7B1DioT8enXIL
         b3Bg==
X-Gm-Message-State: AOJu0YzP4+coVwRJ7Px/H1vBglXspI+moMFnkblRh/6M/3U3T+faxyei
        Yj4CjpqErv7e8noBqM0Yt3wARW+k8bPWZusNHBbRvA==
X-Google-Smtp-Source: AGHT+IFg+ZLZEHu0kdf0bELio3Q7hx39EsGlyjfnPCLtBOZvQ7d8GQpkLSwxOk+q4t4K6UNt+The68B2G7eTkvc71yI=
X-Received: by 2002:a17:906:da87:b0:9be:6bf0:2f95 with SMTP id
 xh7-20020a170906da8700b009be6bf02f95mr1582393ejb.20.1697543451569; Tue, 17
 Oct 2023 04:50:51 -0700 (PDT)
MIME-Version: 1.0
References: <20231016084000.050926073@linuxfoundation.org>
In-Reply-To: <20231016084000.050926073@linuxfoundation.org>
From:   Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date:   Tue, 17 Oct 2023 20:50:40 +0900
Message-ID: <CAKL4bV4Dy2qTKQ3NZo3Gh604c8Cn7t5n5xUkajkjkRys8xByzw@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/131] 6.1.59-rc1 review
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
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Greg

On Mon, Oct 16, 2023 at 5:52=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.59 release.
> There are 131 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 18 Oct 2023 08:39:40 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.59-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.1.59-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
