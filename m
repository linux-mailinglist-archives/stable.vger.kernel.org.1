Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3321879000D
	for <lists+stable@lfdr.de>; Fri,  1 Sep 2023 17:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234033AbjIAPm1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 1 Sep 2023 11:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbjIAPm1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 1 Sep 2023 11:42:27 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1037010E4
        for <stable@vger.kernel.org>; Fri,  1 Sep 2023 08:42:24 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9a603159f33so247700466b.0
        for <stable@vger.kernel.org>; Fri, 01 Sep 2023 08:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1693582942; x=1694187742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3IOQaLWTlXCahS+2Exjx/ttKfGVk+cooC5ON3tQFxnA=;
        b=Tu2dFDQBInZN61sq6BusJe80OS/QBlysH50Lh3n99Q8u5lNTN9HrHfOStT9ZJdbpTS
         zc29GLpsj9h60FLfhgfHpec3T5o+vIDpMb0qNTJZjnDvQJiy42fyv72TBEKKnba9285G
         2bgND2qEzYxyLlkQT2oZzLJ8Wr0V0355oPJdN+Z19G8DGdxKtC+YYNMbBn1jl+4SjULq
         MtcjAuMM23BUZcRYNDp47GAsvElgZgSYTO74nYxt6Cq9GuxtsUxZ75UOUzG8D5TXFqaF
         9t2ACbUZhFRlzZVYbcbEdEnNZwniD4sZ2HYM2gwlbZahtPd7Fx4t49glYebKPI4JommA
         qyRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693582942; x=1694187742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3IOQaLWTlXCahS+2Exjx/ttKfGVk+cooC5ON3tQFxnA=;
        b=aU05tNtBfAyhCwVEcdEmGV5FXQpKK9B8WPrZAyucvQjcfMC31AnUPZBfkahTTs36zg
         ftwp22wwxJrmKK8TamgJeO+2PU35X9gQecHihJj2F670C0+/fzkPzK3semz1W5xT8KFx
         +HYNu3FCHMNimwJMrnrNkdOjTzgH0xQtF4JO1iG72v/y2MeHLuvOTNaCxGZaMzG+2vHY
         afeXiguNPGtiB+UAZVzaJRGxYwN/u5AJw18SzuVly2o9f5+ek8g+sEGPlTKPWIC8+S4I
         LKxEK+awCwPm/fo6XBWYtRPA8d3A/5JhTN117t4NmTZYglD0H+vRn0kqrm1FAJy4wr6T
         3Ttw==
X-Gm-Message-State: AOJu0YynTyO9w2Wsjl8Azng4NNgUDn+qyQY/N2tLPHu9CUtdh+gL3Vt+
        JyZkS0h1USxen2gEVt9xawAvGdXPVGn2RiohNJ8gCA==
X-Google-Smtp-Source: AGHT+IHCqAphpIIxpllHgJAshq74M2a8hIBLJFdOm7z9SehjsCRmY3laVtJkFhZphrQP5jfH0urpKFbxzEZ6yeMG1M4=
X-Received: by 2002:a17:907:7625:b0:993:f90b:e549 with SMTP id
 jy5-20020a170907762500b00993f90be549mr1986984ejc.37.1693582942376; Fri, 01
 Sep 2023 08:42:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230831110831.079963475@linuxfoundation.org>
In-Reply-To: <20230831110831.079963475@linuxfoundation.org>
From:   Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date:   Sat, 2 Sep 2023 00:42:11 +0900
Message-ID: <CAKL4bV678zDbX7dwoqdRpkoda=c49EskC+fgX=BLoH-dvvb5MA@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/10] 6.1.51-rc1 review
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

On Thu, Aug 31, 2023 at 8:12=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.51 release.
> There are 10 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 02 Sep 2023 11:08:22 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.51-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.1.51-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
