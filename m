Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D2A7A9DDA
	for <lists+stable@lfdr.de>; Thu, 21 Sep 2023 21:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjIUTuG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 21 Sep 2023 15:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjIUTts (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 21 Sep 2023 15:49:48 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E99D19D2
        for <stable@vger.kernel.org>; Thu, 21 Sep 2023 12:07:10 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-5031426b626so2179137e87.3
        for <stable@vger.kernel.org>; Thu, 21 Sep 2023 12:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1695323228; x=1695928028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bnhBiFBKyPiQHRaYS9dfvLmsrYNmtEwUZ70lBW9wVas=;
        b=dW+rjdI0D0uFOASNj6tkrt/QnHVoe4F/ms18AfHcGtcb1yIzxizK6JuhfqZuXjLB0P
         gloyAZYChH88OmslLvaYKRt8gEHt1/ZtG0QnGmBSUGdUB5VyuA4aR/slF/qkM+aChvIb
         dpaC/OsVUzhzJfmpQPPA4GFDQcF6Lqej4vhQCDPtVoF50L3f6MWgoxEIKXGGZGKKm5px
         8rz2VYPrjAe3OU4SPIhbkvz+x3xoPF0keKGM6Niv8QuVs9PIjyCtnKoQ4uXD26MMGAYY
         g8xm9lI1P7brXobGJI/UhQ2LYNvormnTaMAqE/lznnXHTvobzPDPLZwbnPKg4kttsllX
         ORFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695323228; x=1695928028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bnhBiFBKyPiQHRaYS9dfvLmsrYNmtEwUZ70lBW9wVas=;
        b=g2vAPZ2PsFQzzoUWM+yO8o/4pYjZ7uPszxEFKluapubqU2lhEo5Rbl24n+EyCpWBQ4
         Bs9RXzHKtxExRZcAnXTP18sAG+myRmnan+6rE3QY1BVabCH6Zeg9gGc2pqt/j21V/Guf
         70UbufMaAe+M4gSwevByxcLxrmLPsPj2+JcPSanPQ+dl/yiPPwcR+CTImQej13USCP80
         gtnVySuvmfRbZThRWYcV0whWf4kz6D1t1ZpjWmTrvcvQprt8zaL5iphaTTrLSZoepjvR
         WGCFZq3JOAqk+mgslKd+WDiBil64d3BSCZS1ihwxXnxY936C5CpkgROm2N4XJa9xoepy
         65Dg==
X-Gm-Message-State: AOJu0Yy/PJs9dDt96lt8VpCK+iKI9xehKEF7i/UsJ2xN2pjGH2e55Ghf
        zOlkgSJNjXIqQcR9rwYnHgyqV+HgD7z5vjovIH60uV5GeJC9QFfNhAI=
X-Google-Smtp-Source: AGHT+IFZArCnDCg0IaUGDU5EJzWdv+w4dn7a4FoKjDrxayQwXMP+yWbdPJpvIebBcd22esKd9Y9YYWiI1e6z6nvhVig=
X-Received: by 2002:aa7:c992:0:b0:52f:b00a:99be with SMTP id
 c18-20020aa7c992000000b0052fb00a99bemr4603308edt.33.1695299051958; Thu, 21
 Sep 2023 05:24:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230920112835.549467415@linuxfoundation.org>
In-Reply-To: <20230920112835.549467415@linuxfoundation.org>
From:   Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date:   Thu, 21 Sep 2023 21:24:00 +0900
Message-ID: <CAKL4bV6gnu5Ufjru10sWG-3dew25WKtmtdPXQNfdrgLc0nfX_g@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/139] 6.1.55-rc1 review
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
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Greg

On Wed, Sep 20, 2023 at 8:55=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.55 release.
> There are 139 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 22 Sep 2023 11:28:09 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.55-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.1.55-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
