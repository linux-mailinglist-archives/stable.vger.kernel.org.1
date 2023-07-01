Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9287744A34
	for <lists+stable@lfdr.de>; Sat,  1 Jul 2023 17:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjGAPBf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 1 Jul 2023 11:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjGAPBd (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 1 Jul 2023 11:01:33 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A693A89
        for <stable@vger.kernel.org>; Sat,  1 Jul 2023 08:01:32 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-98e39784a85so514868166b.1
        for <stable@vger.kernel.org>; Sat, 01 Jul 2023 08:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688223690; x=1690815690;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0wvLshWsSLBZ/5yypeB0xY2a5lfsRQLT8GONX/h7vZc=;
        b=Vzh8noQVqqW864cbnbZfuwXl8zqhfSTBu2+WsqTsynBDuuI7zabbsV7BA0Zw8phT9+
         SxSj/0aocyVKBgaBVVL5TjjrvGE5pK6NJilunjsycq99mi4sM+lSALLMt/U8apFunZZk
         CcKf5ISen06w3p+s6yqmayVbMEaiY5uvtU5Kg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688223690; x=1690815690;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0wvLshWsSLBZ/5yypeB0xY2a5lfsRQLT8GONX/h7vZc=;
        b=EIhDd2EMbLXSqfaVD9Yf+XQUrOj0dVl6h3iJBnrKwQjh8iUz5HUbugf8nDXETJOZ4Y
         3sSs5SnvCCn1yWAOKOeOXOJEQOxyW/BDyPOK3/LOsOqSCqXSrbxIx1CgbT9MmhcjF+YM
         RpHrcZcMRzzPj5BRmki+WfcD+3SFvR9crNzQoxRg6C8NEKmDVeIi17tWxPVZpK+OKL1U
         EbFXL5+jx4GnYXZQX1wED7gW5KvhrhBkJZjMYcNq43ASIb+Y1jbS/frX/fZohY+2f76l
         +8OvHrYlpkseqvJ9jJMgFN7O0P1RzEtJVy7GOw7CVkpklZqPEwVajshwfGmHjgDyR9eT
         L9eA==
X-Gm-Message-State: AC+VfDxnPebUGvnJoVVAPQ9zM1uIADKcZteOMmJbEJ48ZEnaien17yD4
        KGeufrw93eFEaUUkbAnl79NfzoRbUv53TtwI+0jmkxgc
X-Google-Smtp-Source: ACHHUZ5pHw/8NwIlXy7Uu5VoI6kKL7Iq4pR+rzfIkDc5CrTE5WIw4b2mT9ZzeCz2eKgTCeskLMJqlg==
X-Received: by 2002:a17:907:7d8a:b0:978:8979:c66c with SMTP id oz10-20020a1709077d8a00b009788979c66cmr10467026ejc.18.1688223690513;
        Sat, 01 Jul 2023 08:01:30 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id o7-20020aa7dd47000000b0051bf57aa0c6sm8022210edw.87.2023.07.01.08.01.28
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Jul 2023 08:01:30 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-51dd0205b2cso5057069a12.1
        for <stable@vger.kernel.org>; Sat, 01 Jul 2023 08:01:28 -0700 (PDT)
X-Received: by 2002:aa7:d047:0:b0:51b:f862:7b6a with SMTP id
 n7-20020aa7d047000000b0051bf8627b6amr9564270edo.14.1688223687666; Sat, 01 Jul
 2023 08:01:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230629184151.888604958@linuxfoundation.org> <CA+G9fYsM2s3q1k=+wHszvNbkKbHGe1pskkffWvaGXjYrp6qR=g@mail.gmail.com>
 <CAHk-=whaO3RZmKj8NDjs4f6JEwuwQWWesOfFu-URzOqTkyPoxw@mail.gmail.com>
 <fbe57907-b03f-ac8c-f3f4-4d6959bbc59c@roeck-us.net> <CAHk-=wgE9iTd_g20RU+FYa0NPhGSdiUDPW+moEqdHR4du1jmVA@mail.gmail.com>
 <CAHk-=wiN5H-2dh2zCo_jXE7_ekrxSHvQcMw4xfUKjuQs2=BN4w@mail.gmail.com>
 <fb63ea7b-c44b-fb1b-2014-3d23794fa896@roeck-us.net> <CAHk-=whh_aUHYF6LCV36K9NYHR4ofEZ0gwcg0RY5hj=B7AT4YQ@mail.gmail.com>
 <e4dd115b-1a41-4859-bbeb-b3a6a75bf664@roeck-us.net> <CAHk-=wgBAhFqD6aoD2rL0qws8S1erdbrvmQXuYi=ZFEUVNuVfg@mail.gmail.com>
 <CAMo8BfJ+FcR8ZfNk8GNL5pRsJO13O=on8ewRHSJkuQ85_WPk0A@mail.gmail.com>
In-Reply-To: <CAMo8BfJ+FcR8ZfNk8GNL5pRsJO13O=on8ewRHSJkuQ85_WPk0A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 1 Jul 2023 08:01:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgy=8CEGoGJnHkuz4p0pR+Q-5RvsM4VNyYeWabshYr5yQ@mail.gmail.com>
Message-ID: <CAHk-=wgy=8CEGoGJnHkuz4p0pR+Q-5RvsM4VNyYeWabshYr5yQ@mail.gmail.com>
Subject: Re: [PATCH 6.4 00/28] 6.4.1-rc1 review
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Chris Zankel <chris@zankel.net>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        linux-parisc <linux-parisc@vger.kernel.org>,
        sparclinux@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Helge Deller <deller@gmx.de>,
        Jason Wang <wangborong@cdjrlc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, 1 Jul 2023 at 03:32, Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> Thanks for the build fix. Unfortunately despite being obviously correct
> it doesn't release the mm lock in case VMA is not found, so it results
> in a runtime hang. I've posted a fix for that.

Heh. I woke up this morning to that feeling of "Duh!" about this, and
find you already had fixed it. Patch applied.

            Linus
