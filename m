Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883E372DE19
	for <lists+stable@lfdr.de>; Tue, 13 Jun 2023 11:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241362AbjFMJqE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 13 Jun 2023 05:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241079AbjFMJpv (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Jun 2023 05:45:51 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBAE510E3
        for <stable@vger.kernel.org>; Tue, 13 Jun 2023 02:45:46 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f61b45ee0dso6462271e87.0
        for <stable@vger.kernel.org>; Tue, 13 Jun 2023 02:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20221208.gappssmtp.com; s=20221208; t=1686649545; x=1689241545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8SpYglX3xZWy5x6JjxtuTN/FRZavJqUKXS8aVqhebYk=;
        b=XZdZk9shQ71u/141zS/u087WEwIiXiVqoN5KykFsUDzUgnGRIL2wqNn2WoNL4E4t9q
         lEr0qAN1yOObjT0sr4ONuHCjhDcE03RnnLuVTjtiHeXQ4yrRSOp5eUV5WV+DULDJ4DOd
         zFiS7+1DQV6FeRResvIBtMnU7swr8DniimFgP01bMtuezbDe6C+QWZeJM6AsRMXd5dr3
         JexylTYCI9Khd25mb3PJxRLkGzJS6J6LsXtGUTy81YZ4WBL1ekCFtC8JzjFFED8+Z+f2
         UVFlX+SXon3VAqzVtIRaoWVYpfMWQP9FVKhDYR+dQusQqDuLqDJgH6bIIHAKHujjTlp3
         j2aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686649545; x=1689241545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8SpYglX3xZWy5x6JjxtuTN/FRZavJqUKXS8aVqhebYk=;
        b=fDBGngkcCY+SIsHk6yNt77Snozx082E3o1wbbQozNbvmOUOLT22DDvcrETZ1ysAtYQ
         l1Eu9Y7s0GI1f9u1vbpLA1J40ivsZUjQ7W0W3jjWxmZ/i28Fhn8sMC6pobPx2nU6K4iq
         Esy+/VP/mz0TZTF1TLunSKZlAsGIK4kawdfp7V2LZjpSIMUYXSvsj0ue8tFpwr7plvf8
         LycpmoWvYxVDPxNpzArKWeJgsHP+O0E9OT2DBBtDriMmPTqG4SdMrYEXatUvPLcMRg1Y
         /f91dQ0CKKj18FozgdF6J9+O+qIX7JpDWpVKVnt0FdP0/aGACuibXP13/1J6mvI3E+En
         PFpQ==
X-Gm-Message-State: AC+VfDzWIzSRKnAs7ptN8IQxXbgHJJbDFcVinfYegeZ/Jw276p3iA1pL
        8YsQGxxq3df80RhMSlEXq39AH5fZSH50HKQJo1Aauw==
X-Google-Smtp-Source: ACHHUZ5cFzMVREFQr4SC+vRlo8q4itfT6Lyp/yPulI7nR8OW7RQeLvlldVxv4pJyEPB8r/jXc7ZKZr9+unN9EIxlpfY=
X-Received: by 2002:a19:4f0d:0:b0:4f4:dd5d:f3e4 with SMTP id
 d13-20020a194f0d000000b004f4dd5df3e4mr5367991lfb.26.1686649544710; Tue, 13
 Jun 2023 02:45:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230612101710.279705932@linuxfoundation.org>
In-Reply-To: <20230612101710.279705932@linuxfoundation.org>
From:   ogasawara takeshi <takeshi.ogasawara@futuring-girl.com>
Date:   Tue, 13 Jun 2023 18:45:33 +0900
Message-ID: <CAKL4bV5Kvn7bAwChdpmiA7ONJ8bnDYCNFJTxqfs_dYfbTzt38Q@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/132] 6.1.34-rc1 review
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

On Mon, Jun 12, 2023 at 7:56=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.34 release.
> There are 132 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 14 Jun 2023 10:16:41 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.34-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.1.34-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64), arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
