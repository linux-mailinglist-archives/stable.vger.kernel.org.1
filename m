Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041C7776F62
	for <lists+stable@lfdr.de>; Thu, 10 Aug 2023 07:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjHJFNL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 10 Aug 2023 01:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjHJFNK (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 10 Aug 2023 01:13:10 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5738106
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 22:13:05 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99c93638322so103351366b.1
        for <stable@vger.kernel.org>; Wed, 09 Aug 2023 22:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20221208.gappssmtp.com; s=20221208; t=1691644384; x=1692249184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pih6LQrUi43YvqWBWRmRVXsCD2JQwVMeHQVeBk6LIdA=;
        b=wpSX9t1ypn6ykzidyAWLy5+1M19wIoXXTuVSE6eibqFDmLcZDrTRX35J2ixvVm1pAC
         zIozAX50Q49/ZZ29y/7yBcuCoRkMpWphIODBYbZuQZSW9w1T82gzxcPIH+PW8j3jIskU
         uKfBj725spyQhr+dQYxYTKGYqLvTY9Lwpb5quE7NODIsGkk6eIo3MGKhZnSBJ0WkNjk2
         GSpBkhOUXaFiBWwRg8oL1O5elp7YKNfO2byTEvcnOvQfcMab9Moy9HnkRTlFL6G0F/fQ
         vfXtYG3lg+sHdI76Gj66HxrEx9DW/Fd9qobKNnd6Qzsj45nSsdFq2v7M4jDyRLoaSB3Q
         /ZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691644384; x=1692249184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pih6LQrUi43YvqWBWRmRVXsCD2JQwVMeHQVeBk6LIdA=;
        b=elTYA99wFHBuolh7ujwbmH0/RcxXMKB++aL71pAsnw+l2fA3glBtoB+EWMEEvkmDbY
         QMb5dOLbONmTzoyrrg+sLDg668nxPvdprRp0uXAHvjaBu8uqFIWrKBqFOpXLhi/GTthF
         /V7zqraike/HhUBlYNr2gfVeT+m/X6eeqbQykh5ZWhxtiBPnNmVE/U7pOCwa/fPJ3yFm
         rUp3j3c6dWqHOFr+M9GOGdi60tiEaCgOHKQ3Hyxb7eksVzB8aOYLsRli9Y50RVXlQ5xx
         DrK/YNEd10sWCUHTwNHhpRiAOImIHb4FJy12b55mL0Vcp579oj50SoxPqU6YFxHgFJBw
         1MVw==
X-Gm-Message-State: AOJu0Yw2i1k9FwxIfrSZQWq8bkGgGcbOH0ibZrzZKDUL23cN3Securqo
        gMOw2gKXFdzdC7O7xBxvnKPRoGJJRquPb/bpCztAig==
X-Google-Smtp-Source: AGHT+IEzT476nMFdd7oMze+KTEauDI/95cGFT61M2OA3uN2MKjbAjB/QpZvwm8I5fZRM7P4JQbz5EbFgyNlDmJzLP3g=
X-Received: by 2002:a17:906:3196:b0:988:b61e:4219 with SMTP id
 22-20020a170906319600b00988b61e4219mr1253319ejy.29.1691644384092; Wed, 09 Aug
 2023 22:13:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230809103636.615294317@linuxfoundation.org>
In-Reply-To: <20230809103636.615294317@linuxfoundation.org>
From:   Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date:   Thu, 10 Aug 2023 14:12:53 +0900
Message-ID: <CAKL4bV7AtvfB=CT1ie4x3TjE-3jJ0JBi8xPwtkXKgtM84Y1K1w@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/127] 6.1.45-rc1 review
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

On Wed, Aug 9, 2023 at 7:54=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.45 release.
> There are 127 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 11 Aug 2023 10:36:10 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.45-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.1.45-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
