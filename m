Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1493775D0F4
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 19:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjGURyt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 13:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjGURys (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 13:54:48 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F563580
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 10:54:47 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-521dc8ae899so2585446a12.3
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 10:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20221208.gappssmtp.com; s=20221208; t=1689962085; x=1690566885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjkRTaECuNngklkqmuey8QDFNRY+Ib5isKPE9flrp4o=;
        b=DYlabRZyrBAtigJv1oK1ilQ1nyN4CpyVfMjId24nLyeQwNgBmY/XEjNeVodRL567/0
         NGAD7R8fk5si13uFZifLYe6C21iKvssMliXk04MZyhhhZNg8sIFoxSG+mWEQ3Oqb0h6n
         3XvIDwvm33o5CRA+1pYC1nC8LP7Xxth00zKmN6/m6MVsClIEyyHkciTLIagQbOrPnWwh
         78LP6VDlTZzsoK5zgHhDVT5Qy9zeLL2K7AWOCfN40N3YFH2grtwTa2A/P/fz8SC4ktor
         xFvSgsWRuun2vdvxtzY4WBsskvgDYcH8L/a3aQHrZs2bqco20mwpVKt2GP/crc7s3BE/
         8nrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689962085; x=1690566885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rjkRTaECuNngklkqmuey8QDFNRY+Ib5isKPE9flrp4o=;
        b=kyxlA7BSGkbzb3/mKi8Fuyczg6K4AP7gyjssAkdtTOnzYHMXcbqJ1U1A8xg6UiU3Ou
         EJQY3CLLcYlBLvLvrpgHMBkY8fWS9FE/IB86iT6V1ENuMFeQuQRaxn9T1LMJv+ym6k8x
         VgIkhOufGHddmPGjAYa+k5IFruJCXTvPHighvbC6Zxh24fm0a3RKic5H1kk5vYn/3OvG
         9thPzrjkCO+lW8O4p1LKdpjjbPMngPRjfBF57oXV+r01EI5lKLJi/lCq4ca6eXEERPo4
         RP7ZqcmWGf0laHGVow+G6cpejvxJrnLeUBRU0Tehf4+ZAWJLJoNEHJY/VCgLJPgzBHBI
         Id0A==
X-Gm-Message-State: ABy/qLbVD8S9kymbsRUp+Oxgzsz72SBGzKbZ4NtLD3WhlHcRTEsp6TNF
        iOcCzgv5OoZjg+mtPKDmXSP7DxoXuOj0ISMD/7YAgQ==
X-Google-Smtp-Source: APBJJlF4l3FSenIHeRPlauSq1HxXG7xMFKq+3I+4+GnzMmk3eVgiT4h/Qip7SqbYCPlEeqqDEiXVZvzaaIgsxpT2pxg=
X-Received: by 2002:aa7:cd09:0:b0:51e:54d2:b52a with SMTP id
 b9-20020aa7cd09000000b0051e54d2b52amr1993264edw.26.1689962085413; Fri, 21 Jul
 2023 10:54:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230721160528.800311148@linuxfoundation.org>
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
From:   Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date:   Sat, 22 Jul 2023 02:54:34 +0900
Message-ID: <CAKL4bV4J5wK=piP7n8txU9RWR=yiH=fArTEDQHUYTHgvZLDLnQ@mail.gmail.com>
Subject: Re: [PATCH 6.4 000/292] 6.4.5-rc1 review
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

On Sat, Jul 22, 2023 at 1:09=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.4.5 release.
> There are 292 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 23 Jul 2023 16:04:29 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.4.5-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.4.5-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64), arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
