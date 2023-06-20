Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C67736C27
	for <lists+stable@lfdr.de>; Tue, 20 Jun 2023 14:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbjFTMpB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 20 Jun 2023 08:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbjFTMox (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 20 Jun 2023 08:44:53 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83ADD10FF
        for <stable@vger.kernel.org>; Tue, 20 Jun 2023 05:44:51 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5149aafef44so5517413a12.0
        for <stable@vger.kernel.org>; Tue, 20 Jun 2023 05:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20221208.gappssmtp.com; s=20221208; t=1687265090; x=1689857090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Woy9uXIbm09rqBjX1mw8Ry8Yy7O1r7e9UR5ScGw9hbM=;
        b=bUq6B/fjuqhJGJhb5F4omVZxP5j6n2opJA03bG7H4M8PKjLi+kiu7BFjM5zAtTgx5v
         akG2by3SZjL0jaePtm/ixtTEeXpaxulBN1B0PtzRj5OytQtu6CGquxk9LYtodMY/zn98
         yQW4O0UVPAixNUg5QC7ADwdj5ZXawlmiuoucNKFezIhyfofpC3AKNQnvyifz2e1kiTM3
         s8l9gnD0ERusHwVd9bsfhyigW5MTch2mUkCcWUAjjlXWutQBPdc4FxjJWxxfpZvtYO7x
         anf+UraBULroMpoqLiZpH6y7jbV439DB7y72/cOqEFT1mdITl5uVPmiQYC2xWAA15Plu
         1Cww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687265090; x=1689857090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Woy9uXIbm09rqBjX1mw8Ry8Yy7O1r7e9UR5ScGw9hbM=;
        b=K5mk34s+l8TQCYDvpEPrp4f23yB9iu/S4J0FlkyKiwabBG4WmKdP10UJejLEP+xl7M
         /hzqCLYxcmmoww5+urn5wbz3CvjLUQ/jbJ4LYr8/JryyOE4nMYljAm5umM+kb/lK4U6t
         8msgkHBdt+dmLRVYJIHurEUWPsJ2xtIKmVRgvIPN15xWMgMCiT4wYU/ouafYdjcs7KEI
         F1PBkFa7NRZuNAqiTpR6grvvnDIO3Bw4Toe3ThdBO/C/+eQx7AbQXUUSZ0neGAjRcAH8
         CaVioCGd/VJpiNRqmQrg9ZwlCe/YIEkQkU2UuYxmTT8BaOcnG8gcNbEuDQZI3xGjB+o5
         4lwA==
X-Gm-Message-State: AC+VfDxg7TnbDcKij0doSU47yh900Xra72TDzsL9gtFmnXqry+OspRh+
        02PDJxuWWNu/nY6UwinTZrTYYBJqjxPO/JZUYZQkf7edUhBYoEfv9aH6eQ==
X-Google-Smtp-Source: ACHHUZ6+prkdM6kZZEktw29hRWVkIfpIaf/jCzXL1Y0+PKO/f1QZdU2GYr6hdrLVYRpcWNFABBLfvyTb+4mDWXeI71Y=
X-Received: by 2002:aa7:d605:0:b0:518:92a2:1697 with SMTP id
 c5-20020aa7d605000000b0051892a21697mr7702125edr.15.1687265089834; Tue, 20 Jun
 2023 05:44:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230619102154.568541872@linuxfoundation.org>
In-Reply-To: <20230619102154.568541872@linuxfoundation.org>
From:   ogasawara takeshi <takeshi.ogasawara@futuring-girl.com>
Date:   Tue, 20 Jun 2023 21:44:38 +0900
Message-ID: <CAKL4bV6nbRsiufHPdGEQQgCKRBDE84ApYCoAB2pJEhhfP6wdcQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/166] 6.1.35-rc1 review
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

On Mon, Jun 19, 2023 at 7:44=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.35 release.
> There are 166 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 21 Jun 2023 10:21:12 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.35-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.1.35-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64), arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
