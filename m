Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D522774C906
	for <lists+stable@lfdr.de>; Mon, 10 Jul 2023 00:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjGIW4J (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 18:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjGIW4J (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 18:56:09 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BEB123
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 15:56:07 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-262d9e75438so2807487a91.2
        for <stable@vger.kernel.org>; Sun, 09 Jul 2023 15:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688943366; x=1691535366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QPdWGUJfSkwMpEftrHb4D0cEYRriyUH34Z10bwypwcY=;
        b=CLsejkqejApXka8e4+zbRWOj4b3p+RUdEXNs8qqyD/iTB1djayTt60FQuWqGiaNKCI
         /BqsFe9v42atzSr89uUZwE7J7VcBC5Namdf7xLM+cCDZd8NOlxVhE/laMU7A/cCHDzRe
         DFHght8gY1kanTVEZhcAygHGumfgVHxIDmhqd4Ib6R6ExQeyM+2HiZxzOFyU7FFMVT1C
         eeaAAE71uf2DpbVyEq5AyUMWD7lmTNTMchYxhXPTGOsYbB/Dsl2iYEW+v3R2TiWTdGAM
         YE9jr4dKWMolMisYUdXcifg3Tbkl10aWXyAek0zjaJb2qtpehDfr7PZECrp78xfCXNKo
         WujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688943366; x=1691535366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QPdWGUJfSkwMpEftrHb4D0cEYRriyUH34Z10bwypwcY=;
        b=iusHkFgjuPWaraeLeaUfPzmYDA/y1QaT6n25WcLRGRzxT6fjQ/xpvYvaH3c8ZdX8nv
         d+pA//vne6+aO8T4jZZ7aNyZX5otEgSnG0L1x22HdpFLyKX64S5UON5G/cml+iEjKV3K
         GWZU/CVYsge5gIlvRl4No87EvMShEeL+tQYMjvWXvhMcjMFqaUfjmECCwAWosTo9Vite
         MTN5EEwxK9Mj2fC3BdUhjP/InBHt8BTRwyI4cl/cw1cIHFAV4sS9q4ViQA1V0d+IRSQG
         S/3uX+eGJhy35mI3PTw7HsrvfrGunzVOFUn/Qf6WaJt1T1iCk9Vr+qMVguMimdynEJy5
         abnw==
X-Gm-Message-State: ABy/qLZziDzycDRsUWfgzb0ejwNEcNCD5xOph1clQyiEqyiRczWvS/ZU
        lceKKnBoV89jL4cI2JsJ7pyDx2RjHcCvLvIGweBljQ==
X-Google-Smtp-Source: APBJJlHR1RTkC5VFgPWsyq6+xGci00cEkBZUr3KXhTYYNqOa6OOJZOmGZA53j4DADL++r3rjSqPqo4w8ydU3ANiKpSU=
X-Received: by 2002:a17:90a:b283:b0:262:d661:75e4 with SMTP id
 c3-20020a17090ab28300b00262d66175e4mr11412368pjr.0.1688943366456; Sun, 09 Jul
 2023 15:56:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230709202353.266998088@linuxfoundation.org>
In-Reply-To: <20230709202353.266998088@linuxfoundation.org>
From:   =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date:   Sun, 9 Jul 2023 16:55:55 -0600
Message-ID: <CAEUSe7_KV_+jLJzE4u4_DHUPbi8Z=ASh-=aKB_JQr4+pz_8GVw@mail.gmail.com>
Subject: Re: [PATCH 6.3 000/425] 6.3.13-rc2 review
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hello!

On Sun, 9 Jul 2023 at 14:24, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 6.3.13 release.
> There are 425 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 11 Jul 2023 20:22:29 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.3.13-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.3.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

This introduces a warning:
-----8<-----
  In file included from /builds/linux/block/genhd.c:28:
  /builds/linux/block/genhd.c: In function 'disk_release':
  /builds/linux/include/linux/blktrace_api.h:88:33: warning: statement
with no effect [-Wunused-value]
   # define blk_trace_remove(q)    (-ENOTTY)
                                   ^
  /builds/linux/block/genhd.c:1187:2: note: in expansion of macro
'blk_trace_remove'
    blk_trace_remove(disk->queue);
    ^~~~~~~~~~~~~~~~
----->8-----

This is again with Arm 32-bits on omap1_defconfig.

Bisection points to "block: fix blktrace debugfs entries leakage"
(d8c9d0067dbd here, dd7de3704af9 upstream). Reverting this commit
makes the warning go away.

Greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org
