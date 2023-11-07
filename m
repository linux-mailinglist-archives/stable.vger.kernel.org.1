Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7CE17E3AB1
	for <lists+stable@lfdr.de>; Tue,  7 Nov 2023 12:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbjKGLDI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 7 Nov 2023 06:03:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbjKGLDH (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 7 Nov 2023 06:03:07 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6634BED
        for <stable@vger.kernel.org>; Tue,  7 Nov 2023 03:03:03 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6c431ca7826so563749b3a.0
        for <stable@vger.kernel.org>; Tue, 07 Nov 2023 03:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1699354983; x=1699959783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PC3d6wWHpqdfS4D388YBQ7NgpKv2etiMwEuLXnGK4bI=;
        b=1ZC0uft+ctRU6rM3EHXA8X3K6UnHES1uG6TrkJLr5kBltU9yIpq7fwPAGSnra5CjHm
         va3aSQ7prfnxDA8tnQ+Qf/1xRCzOEQTaiSBLRH4QdlyXH9d30s4WiVtuCwwvPR72bqib
         exbh70n3fT8TB5Ov5V2v5UFXFjY+aJmJJETTapSBGvBOaM1vaYCgi/31gr6NdaKz/5v+
         XB1MKWIVdolRXMmdbtQ8G/qAMwJm+gXgpReGT6WiHLAJJg9sKOF020OxvpfnmyUj1WCR
         eE8FQYfvv348Es8JEDE+k7FTCeRWYOdPLq2s72Cg3gH4C6bIV1hSVeqkpqNepchaQInS
         GiSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699354983; x=1699959783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PC3d6wWHpqdfS4D388YBQ7NgpKv2etiMwEuLXnGK4bI=;
        b=f8OrMVqOGUQgOMLLN/4hpz1z04h59nbHsiUyTWxXYSZXLjJq77gBpoIE21lYIblKgL
         vyI9VFI3tpCqC1VtMs7r287YXobRVFb4zOUYZ9NdqBdvxAqFyafPe5YaEL8AnPTeLRjv
         AjE5HNvm9SeQjqhKkkMpGsgenupeHzf7qtvR/SF8607qQ1TrqmG0DHJZyGpcJRIcipuZ
         kSrqw2E5ePwj4h+pzDVkXZnaOm0dJM8i0oRLloPXlMezPYftf3dTHUg/RoHQLrmGSJuM
         lOapd4I2WgmYteZkLwU5iCNUO97nXVZFd+3u4nAvS8mhX+qmKHDDIfr4tSthgjuP3A5U
         f75w==
X-Gm-Message-State: AOJu0YxENkuuIadXeztqIdCJSOTvW83Ir04w53QI60FFmjAXzt0/0uGL
        5fpARc/6o2j8NnlOeJ6CR4f3HZ0KKCBVgLdsrECwXg==
X-Google-Smtp-Source: AGHT+IE7iI43DIi/hwt3+oaAr9mreCpy5srt9xD5cwQpQTRLmMVPxEuYq0iKgOPV3XgIuhu7aw/nsI9WwKAbjdKwRrg=
X-Received: by 2002:a05:6a21:7742:b0:181:3dde:deeb with SMTP id
 bc2-20020a056a21774200b001813ddedeebmr18127765pzc.33.1699354982747; Tue, 07
 Nov 2023 03:03:02 -0800 (PST)
MIME-Version: 1.0
References: <20231106130257.903265688@linuxfoundation.org>
In-Reply-To: <20231106130257.903265688@linuxfoundation.org>
From:   Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date:   Tue, 7 Nov 2023 20:02:51 +0900
Message-ID: <CAKL4bV7DhfiRGXDTtMLvHjEKYApXyOmH+6Uvs5y1SWkJN583DA@mail.gmail.com>
Subject: Re: [PATCH 6.6 00/30] 6.6.1-rc1 review
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

On Mon, Nov 6, 2023 at 10:07=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.1 release.
> There are 30 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 08 Nov 2023 13:02:46 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.1-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


6.6.1-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
