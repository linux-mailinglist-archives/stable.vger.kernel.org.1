Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4189A77B6C1
	for <lists+stable@lfdr.de>; Mon, 14 Aug 2023 12:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbjHNKdl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 14 Aug 2023 06:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjHNKdd (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 14 Aug 2023 06:33:33 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0298A10C
        for <stable@vger.kernel.org>; Mon, 14 Aug 2023 03:33:32 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-523b066d7ceso5026283a12.2
        for <stable@vger.kernel.org>; Mon, 14 Aug 2023 03:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20221208.gappssmtp.com; s=20221208; t=1692009210; x=1692614010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uleSPCEhWYps/G0+jIIwOEt4SNkxmTT9PADtVhClwek=;
        b=rTS5GaH3NUE2HLbWYWh8BgcIglEgniZVG5sZ4i4ZlrWV4u3eTvI0cLZfvvVSfau1I+
         lnTS6cNyW+ANkwA+Vnrckw7gLIhib+rVsuu5AbdpmbOP2sJj2S+/L6a3qM3i7gBHYDxA
         9idSnN7Qg1YijsTeei97RINzROPvhctXrmZ0Zk4CtwjdjcS7NSFgOu5laR04tdV8L6px
         dFyQiAKJ69KxzeMmG19NmwnBX7WfxP9ko3qpng96T8yEK+I5O22i2sV0TjwYhfifYZKz
         Dsl5XgaPjf4UcmRdWpKcGWEDOv1VA5CHiMdY7xJJv4z9lVpe/Aoj6RTFI/X1WddREMst
         NIxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692009210; x=1692614010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uleSPCEhWYps/G0+jIIwOEt4SNkxmTT9PADtVhClwek=;
        b=O7FCmwPeq3pZrFWpnXCXBs7bKlZTEz+6A2sBUbg/HXM3YwH+qKP46+Csu5eOTohTRs
         DUcJZo/FVsBU87fCx9A0CVwhRc8+/W+rZxVTWf1AoG4Xu5t6QUz2XnhsTfi/A0NPeMWZ
         ZWlBE4tJuP3UEjdkyN+MYxyq/WtOgT8alU3lMpGp21aj6Ks5Nurgr63iQaEBFX5+M0DG
         tKSBn00di2fbrkI/T022uMtTBmjn49nGinYrIGbysCuFVtxbo53tA9TpJDA/wJow6a1O
         XshhyA1jqvP17E4oy9rt9EJGJCKJizrJ2w85oFzAuRpFrApH05xgJ0stScMb9kQ2c7Ai
         zzhA==
X-Gm-Message-State: AOJu0YzDO20zhWM7kHEuaAOoseLp5C9s4vkE+QKaew12BMyaaEL4asxh
        8DHL33KRolmT42KZj98aWiFAvko5i0I/vDrbM6ueiQ==
X-Google-Smtp-Source: AGHT+IErMvltuuNvb0Ql0I6gloiuj/IOh2manbi6gz3jz50UDeRT996wuxrHMof9qaZT/ImGdm9FiGAhgx3uc212J3w=
X-Received: by 2002:a50:fa8f:0:b0:525:440a:616a with SMTP id
 w15-20020a50fa8f000000b00525440a616amr4644893edr.20.1692009210277; Mon, 14
 Aug 2023 03:33:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230813211718.757428827@linuxfoundation.org>
In-Reply-To: <20230813211718.757428827@linuxfoundation.org>
From:   Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date:   Mon, 14 Aug 2023 19:33:19 +0900
Message-ID: <CAKL4bV4cCVqYHyf01=ZBTgX3-dU5Gh8NZxAGnYD__xWmACR=Wg@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/149] 6.1.46-rc1 review
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

On Mon, Aug 14, 2023 at 6:34=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.46 release.
> There are 149 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 15 Aug 2023 21:16:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.46-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.1.46-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
