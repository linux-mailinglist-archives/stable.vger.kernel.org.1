Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861C86FE7F5
	for <lists+stable@lfdr.de>; Thu, 11 May 2023 01:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236313AbjEJXJ6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 10 May 2023 19:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236907AbjEJXJ4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 10 May 2023 19:09:56 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535DDB1
        for <stable@vger.kernel.org>; Wed, 10 May 2023 16:09:55 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-966287b0f72so984505466b.0
        for <stable@vger.kernel.org>; Wed, 10 May 2023 16:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683760194; x=1686352194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jqoKxzx8nbzMGeKcw393T5tuP9l9MYfmO2sKW8WQB+Q=;
        b=ANW3gXPTsMJujOwxNhJ2I1zuSGraG9s1eUHJz3V5xLx6it/JmxcxrXRHSnNDWfaYrC
         djPbZQ+T8xqfoi6mX2CsLZfps6PcrUpxt47BLLFV/39yAILF2gOLskuhBq2QyTEgG8sU
         8cTihGAGBH0yLD+YuwdK6NQooC3MEPlunun6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683760194; x=1686352194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jqoKxzx8nbzMGeKcw393T5tuP9l9MYfmO2sKW8WQB+Q=;
        b=Vr8kUKMVskLQ6OrzGbt1PxTkLHjloWA4WR+V1ghj9/jtJo3647PgjXHKq4kycxY+6R
         Km+260B6XuC8HAGyFFQgLEUeoyh9YFlmAwzBTH7ptR1Wl1JSgdYhpt8GVpFQyFV21Hch
         GJZrpLEFUn6gsuOzTdGkqK8edocQ6gehs+m4c+O51nWB5RxurxXW6Z0jpAYaZleVeDXd
         TNDwnH0IzNRVwnsYL1yzLf3qJzJRIrTsc6IeW1idGgddq9U96IwmilMdCgqvwlK+g3/k
         nDAmqOas/rEEUJzrCcebECv5Y8j68Zyy79/On6NKIBPvSbFgKj3Mufl6GRjWjClL1Idm
         DdPA==
X-Gm-Message-State: AC+VfDy717IW5cute0unCg5aREmU2sO6PetG1ncPtMhlGEf7nKxhIXVT
        atwhHHpTaPKHr3HaFEK34eFG3vUZKTkNnqXP3UeWBA==
X-Google-Smtp-Source: ACHHUZ46bm+ZIriH+GSb6IRI4OJqRQ/VzEJI9lDJL5kyYtpz+esfX9ov0ZT3caAGXYe9mXR0tAzQaQ==
X-Received: by 2002:a17:907:a41e:b0:965:e556:8f6d with SMTP id sg30-20020a170907a41e00b00965e5568f6dmr18291973ejc.63.1683760193732;
        Wed, 10 May 2023 16:09:53 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id ca21-20020a170906a3d500b00965a52d2bf6sm3165589ejb.88.2023.05.10.16.09.53
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 16:09:53 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-965e4be7541so1268995166b.1
        for <stable@vger.kernel.org>; Wed, 10 May 2023 16:09:53 -0700 (PDT)
X-Received: by 2002:a17:907:6e10:b0:968:1e8:a754 with SMTP id
 sd16-20020a1709076e1000b0096801e8a754mr10370572ejc.72.1683760192951; Wed, 10
 May 2023 16:09:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230509030611.521807993@linuxfoundation.org> <863a112f-f4a4-d580-9687-f6214d555939@linaro.org>
 <2023051035-monitor-sandy-2a5b@gregkh> <CAEUSe79AViqsHimbYbFjkKAxcvROGhFKA2yKVuC3aP1Gm=jc1w@mail.gmail.com>
 <CAEUSe7_ZBW_hPUZYeKkZ6zuckeqYb+O46GdgGx0wE6T0=c5wZg@mail.gmail.com>
 <4d3c5462-1788-426a-a44a-e839b1c4970d@roeck-us.net> <2023051154-activator-aside-bc8e@gregkh>
In-Reply-To: <2023051154-activator-aside-bc8e@gregkh>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 10 May 2023 18:09:35 -0500
X-Gmail-Original-Message-ID: <CAHk-=wh2nmNs98AUpv6+BZ3x_bNh6ps+nuufQO2Sn6LdXCbC9A@mail.gmail.com>
Message-ID: <CAHk-=wh2nmNs98AUpv6+BZ3x_bNh6ps+nuufQO2Sn6LdXCbC9A@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/370] 5.15.111-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, laoar.shao@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, May 10, 2023 at 5:58=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> Thanks!  Turns out someone put the wrong "Fixes:" tag in that commit
> which is why I missed it.

Hmm. Presumably the real commit ceeadb83aea2 at some point got
rebased, and had had that other mentioned SHA1 before that.

It might be a good idea in general - not just for stable - if we had
some automation that said "this refers to a commit ID that doesn't
exist".

Of course, sometimes those commits might exist elsewhere (ie the
stable tree obviously refers to upstream commits that are *not*
directly reachable from the commit that refers to it, and thus relies
on another tree not rebasing itself).

But on the whole, I would expect that the normal situation, outside of
that "upstream commit" issue in the stable tree, is that you only
refer to commits that are actually reachable from the referrer commit.

Or do people refer to other branches' (or even other projects') commit IDs?

It might be interesting to have some automation, particularly if it
then might highlight the situation where the same one-line description
does exist under a different commit name...

                Linus
