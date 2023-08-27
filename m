Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F9A789AD4
	for <lists+stable@lfdr.de>; Sun, 27 Aug 2023 03:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjH0BeL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 26 Aug 2023 21:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjH0Bdh (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 26 Aug 2023 21:33:37 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1535E1BC
        for <stable@vger.kernel.org>; Sat, 26 Aug 2023 18:33:35 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9a58dbd5daeso127707366b.2
        for <stable@vger.kernel.org>; Sat, 26 Aug 2023 18:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20221208.gappssmtp.com; s=20221208; t=1693100013; x=1693704813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RT9M14f+fzjM8J0OEHrQ2CYoCkLyH8rDZSUrhqLTE98=;
        b=470K4TIKA+UDx0xKr28T1LnbGBAo1YF/MzNcqB4YwDRaPOst6oIQ8KybSDan8xbUEz
         novt/Z+sR2JenoGTUKoYy9VIwEX5cFdb2qUYg3jyKxGmmV9wKH3OkYcWmzsyZO7hDS3i
         V3Q+bxpU9zbOp/p+u1NEa5FV5JaOjF4baZ/iauwu/PTBRgbtv5naW+/ceY3HJxlR1RNH
         vZPi9aqYbl21ijBLx4FmzQwBVU4na3WBuiDdt+MVrRP9FD6tcmHUstH/EZNli8Pl4hYG
         arP1gzdXiyG2vmVvBqObIQMjeIYAmi1vwFPCazMI1c6cKj2gt0uECg1nz4S4C+PVcHvV
         q+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693100013; x=1693704813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RT9M14f+fzjM8J0OEHrQ2CYoCkLyH8rDZSUrhqLTE98=;
        b=cWsa3QjzHiTjiG58yM11zeQSmWvGY/O97hwD4ggqgYHIJE4xHEFBMrLv+ApIZxmpVe
         Jfu9S217JbnHM51uPV+KAJxEGssz5NU+fASruAJg2oMyP3BeBFJJoGibKh+HfBaygvVG
         sT++G3ZHs8+/33RDx3qKU9B9OcGJTIeRZD7NaQvR7SduYWtvYJ4If+UCXxd/2lspXkiT
         oDQlfkOObzgGjjCscQ5sTCGVURh8AH2yNyUcms71iukPPiVKrgYF4wNhDhkdeXGaGkrm
         ZINwqnBs6k6ckQKdducQN1v+bZlATY0WbBliuKATbLJn+n0OZw7plNC5Tuby9G6/iqiK
         78zw==
X-Gm-Message-State: AOJu0YzZ5jcB0lSJIUJMBqhWPxfjgtnzSuDHZkDYc3V2yoKNgxl8AO80
        ntM3MnPFoKPaI3CVa/MKHbOIOGpjtEBgIqYz2a3zrw==
X-Google-Smtp-Source: AGHT+IESODDnD/Bq39TxKw3pzqhTqWzhiSv0AMsfq+/Gt7aC1O3n9dbtLNKKv4hMcfA8FUflUhDP+nFfgroLq+u18Fo=
X-Received: by 2002:a17:906:cd2:b0:99e:1041:f849 with SMTP id
 l18-20020a1709060cd200b0099e1041f849mr17616654ejh.20.1693100013381; Sat, 26
 Aug 2023 18:33:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230826154625.450325166@linuxfoundation.org>
In-Reply-To: <20230826154625.450325166@linuxfoundation.org>
From:   Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date:   Sun, 27 Aug 2023 10:33:22 +0900
Message-ID: <CAKL4bV5npEHw3kfK_b4wbPZ0sEpW3muLzq6ENV2Y-7cqsE25Qw@mail.gmail.com>
Subject: Re: [PATCH 6.1 0/4] 6.1.49-rc1 review
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
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Greg

On Sun, Aug 27, 2023 at 12:49=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.49 release.
> There are 4 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 28 Aug 2023 15:46:14 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.49-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.1.49-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
