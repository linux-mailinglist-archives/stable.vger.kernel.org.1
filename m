Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D597743544
	for <lists+stable@lfdr.de>; Fri, 30 Jun 2023 08:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbjF3Gr2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 30 Jun 2023 02:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbjF3Gr1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 30 Jun 2023 02:47:27 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4182D69
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 23:47:24 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-98e0c1d5289so174475466b.2
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 23:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688107643; x=1690699643;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zlchbRYXZ2GmgikakdfRkYq9RUe43aExK7E5sqwL0Bw=;
        b=OVM0ZV3RlyGGrzqXh/mYvoDZ5ojO6xDLhkM+h9nlpBjAJdWSXNvxPWWSHpG4c/kb4x
         Lm1vrIizQ0GK71+cqFpC4vDwoa0Q/Nbv1tAv2wZzBwsBzkljWsffXJsWoNmrQLselfDp
         jGVWIsBfkJ7mQKMorzGKto7GvzyKZlgUROgrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688107643; x=1690699643;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zlchbRYXZ2GmgikakdfRkYq9RUe43aExK7E5sqwL0Bw=;
        b=HyCkcoWE9o9nmpchbpSB2jmqGRknzWcTuMfINxWXAl1E7en8Gt2jnfrK+B9EgkSaxM
         g5MNd/ekK/rmc3hLoJkUIS5FsHKHYfPebIFx20a54E69Ue70oWjP3DmnNBjvZh8ZAz5G
         EEw75hirZUvDi8bOy+FSSvknAFqAH7F2ca+CJm+Woc/y/lvVK0RmP5E+++b+pR7SDWSH
         zHRzvXEM4nx6iWXaYqDVMTf79B4KcaLMp5joCh2egqQwrTylMi8nelNPfgoPCBFjZxm0
         KKln4kAfrjj87RNKzldTcG88wTDpBW3EmA9HBupLZMnv5D1LFyyHN/y27oPcOv9rM2xy
         mI7A==
X-Gm-Message-State: ABy/qLYdP9HhoE87OZPHLa9bBNKaWqV4VgBuVGa4PtoG6qAt0oCHcz+2
        bDnWUkAcHjf1+G11WdNSwTza1djbPIh6cJ//dVgDMu+o
X-Google-Smtp-Source: APBJJlHjj5CLCxJlJFkDQ7iLFD9aGsfa/xhwGL5TNg7BdJe+3YrDGHznD2ZgyM7y5lSPf0Xc2amSoQ==
X-Received: by 2002:a17:907:174a:b0:992:be80:ab01 with SMTP id lf10-20020a170907174a00b00992be80ab01mr1165626ejc.58.1688107642975;
        Thu, 29 Jun 2023 23:47:22 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id v4-20020a170906180400b009920e9a3a73sm4037873eje.115.2023.06.29.23.47.21
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 23:47:22 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-51d9123a8abso1625884a12.2
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 23:47:21 -0700 (PDT)
X-Received: by 2002:a05:6402:217:b0:51d:7ed9:c65 with SMTP id
 t23-20020a056402021700b0051d7ed90c65mr915784edv.21.1688107641560; Thu, 29 Jun
 2023 23:47:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230629184151.888604958@linuxfoundation.org> <CA+G9fYsM2s3q1k=+wHszvNbkKbHGe1pskkffWvaGXjYrp6qR=g@mail.gmail.com>
 <CAHk-=whaO3RZmKj8NDjs4f6JEwuwQWWesOfFu-URzOqTkyPoxw@mail.gmail.com>
 <fbe57907-b03f-ac8c-f3f4-4d6959bbc59c@roeck-us.net> <CAHk-=wgE9iTd_g20RU+FYa0NPhGSdiUDPW+moEqdHR4du1jmVA@mail.gmail.com>
In-Reply-To: <CAHk-=wgE9iTd_g20RU+FYa0NPhGSdiUDPW+moEqdHR4du1jmVA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Jun 2023 23:47:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiN5H-2dh2zCo_jXE7_ekrxSHvQcMw4xfUKjuQs2=BN4w@mail.gmail.com>
Message-ID: <CAHk-=wiN5H-2dh2zCo_jXE7_ekrxSHvQcMw4xfUKjuQs2=BN4w@mail.gmail.com>
Subject: Re: [PATCH 6.4 00/28] 6.4.1-rc1 review
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
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

On Thu, 29 Jun 2023 at 23:33, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Oh well.  We'll get them all. Eventually. Let me go fix up that csky case.

It's commit e55e5df193d2 ("csky: fix up lock_mm_and_find_vma() conversion").

Let's hope all the problems are these kinds of silly - but obvious -
naming differences between different architectures.

Because as long as they cause build errors, they may be embarrassing,
but easy to find and notice.

I may not have cared enough about some of these architectures, and it
shows. sparc32. parisc. csky...

             Linus
