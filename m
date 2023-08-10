Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3821B7781AB
	for <lists+stable@lfdr.de>; Thu, 10 Aug 2023 21:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236573AbjHJThL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 10 Aug 2023 15:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233486AbjHJThB (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 10 Aug 2023 15:37:01 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F15213B
        for <stable@vger.kernel.org>; Thu, 10 Aug 2023 12:37:00 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99c1f6f3884so180936266b.0
        for <stable@vger.kernel.org>; Thu, 10 Aug 2023 12:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691696219; x=1692301019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bxXYghb+eoRa0mcUhOiyjnEloU2cZwSMtKrX/TWEnDU=;
        b=he8HYHSJPSdntzb4i8YGrAwjyffGuiKA+woE/714lov/drFNz+XV9rfgGmQoP63wvn
         i3r2sKG8MCblRLEmyec50FnSvn5r7WMkU7Obv2t5smvlh1zTuVe+65A7hwv/VRCORTOm
         7LYPAzk87JhYV0o+MGL4GYOvaRAJbRm3vBfmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691696219; x=1692301019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bxXYghb+eoRa0mcUhOiyjnEloU2cZwSMtKrX/TWEnDU=;
        b=bHESR2Hvb3l2qDAnb9NSTYIqETnAlkzi7zEHPcZPj1BZmNFlnOqE7VYC6oxzUsM0Bx
         zgfl7U8j7w3H8gSCsKpGpaBSkylSH78l0wTN25boPitXrmoyVtYd+wFiCcoqSJa11yYy
         K1kKgFKtMzi66YQDVN7tV0MfVk/wJDrmp//yBaI+lFC2d1JJWpjOjEnOLH0jNk5+ABfx
         IkS5d1TtHbdNeOaXIyxULYhRL+qXVBhWyQSj+8NJO/1oAxQHDDCUJk8J+nkoq5Sklplj
         FtbNuYnsB/Im5NsiSRkgaWNUjFMD8VoYXWtHiegM15zbRSUbum4MpPGvpyzatLE9gt9V
         1OHg==
X-Gm-Message-State: AOJu0YwU9yTF1yyQVz/Yoteawl6SnNM2LULiib3Rd1yQS7QTuJ8fU7cy
        ZKN4RqyYQ6O9LP/KYULCm6LOotSDHHYUNXnmUsMjn2V7
X-Google-Smtp-Source: AGHT+IGBCmSWCAn7hSCASJW5yueq1TYg/NQyBl7t2FxrPTnl1qdlpDhyMNWwXfozSaBBjsYc8EG9Cw==
X-Received: by 2002:a17:906:5a67:b0:99c:8906:4b25 with SMTP id my39-20020a1709065a6700b0099c89064b25mr2813439ejc.74.1691696219126;
        Thu, 10 Aug 2023 12:36:59 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id kq16-20020a170906abd000b00992b50fbbe9sm1333006ejb.90.2023.08.10.12.36.58
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 12:36:58 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-523225dd110so1660316a12.0
        for <stable@vger.kernel.org>; Thu, 10 Aug 2023 12:36:58 -0700 (PDT)
X-Received: by 2002:aa7:d0cb:0:b0:523:5012:63d5 with SMTP id
 u11-20020aa7d0cb000000b00523501263d5mr3095069edo.16.1691696217947; Thu, 10
 Aug 2023 12:36:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230809103658.104386911@linuxfoundation.org> <CAEUSe787p3uDD9Q0wq=Y=PY0-wLxbYY8oY6T24dhm+qgK1MjNw@mail.gmail.com>
In-Reply-To: <CAEUSe787p3uDD9Q0wq=Y=PY0-wLxbYY8oY6T24dhm+qgK1MjNw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Aug 2023 12:36:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiTzjgRRPmfkwOr89uMuk5wdoG_6edMAnEdubX9bq8OSw@mail.gmail.com>
Message-ID: <CAHk-=wiTzjgRRPmfkwOr89uMuk5wdoG_6edMAnEdubX9bq8OSw@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/323] 4.19.291-rc1 review
To:     =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        lyude@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, 10 Aug 2023 at 12:28, Daniel D=C3=ADaz <daniel.diaz@linaro.org> wro=
te:
>
> Two new warnings are introduced on x86_64 with GCC-8 (defconfig):
>
> -----8<-----
> drivers/gpu/drm/drm_edid.o: warning: objtool:
> drm_mode_std.isra.34()+0xbc: return with modified stack frame
> drivers/gpu/drm/drm_edid.o: warning: objtool:
> drm_mode_std.isra.34()+0x0: stack state mismatch: cfa1=3D7+112 cfa2=3D7+8
> ----->8-----
>
> Bisection points to the quoted commit ("drm/edid: Fix uninitialized
> variable in drm_cvt_modes()"), 991fcb77f490 upstream. Reverting makes
> the warnings disappear.

Bah. Stable should pick up commit d652d5f1eeeb ("drm/edid: fix objtool
warning in drm_cvt_modes()") from mainline too.

Sadly it didn't have a 'Fixes:' tag, so it didn't get picked up
automatically. My bad.

Although it's not like the commits it fixes were actually ever marked
for stable either. I guess commit 3f649ab728cd ("treewide: Remove
uninitialized_var() usage") got picked up as some kind of "make it
easier to apply other patches" thing.

               Linus
