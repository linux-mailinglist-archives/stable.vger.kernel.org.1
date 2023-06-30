Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776507434DC
	for <lists+stable@lfdr.de>; Fri, 30 Jun 2023 08:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbjF3GQo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 30 Jun 2023 02:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbjF3GQn (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 30 Jun 2023 02:16:43 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F27C2683
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 23:16:42 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b69dcf45faso24537971fa.0
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 23:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688105800; x=1690697800;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Uhmn3RW3fCZZK1xj84ra9lbrAgT4ezYFSHn/zPTSsl0=;
        b=X5ZywbJZoGy8KJYcyA5gRYsmEEWHVlTYNYdy/QQHPb9oZ4GIHIXB0Ex5coZiJnJyVB
         gH/P26N1m8YaaVpLpbzPY986HZ3R2SDzICxhRvqFo3p0sfBxKtbzrt8XD8DOZ8zC4da8
         GOHpeTf4JM9qhLojqURbeY9D0I22cTD6s924Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688105800; x=1690697800;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uhmn3RW3fCZZK1xj84ra9lbrAgT4ezYFSHn/zPTSsl0=;
        b=g74GcRrhwTAUxgjDb0r+QwQilGIsBI5BtFw7Vjt2oJPO/TJsr1XYEPuL1YZunGtpRy
         jrwzU3m0VnU2GKfH9NO/V7I5eGYDXX/uZlm64v28udrrVih8YJH4GvLka7J83BC3Gjx6
         Gr6Z2n/8l1Awk++Oql5YrE58Trymp3BrikZvf0BE5B+cnGwpGx656M7dKNfJ1Orpmrjy
         6pyYoHkFy6m7aE648hMdwVabjRzyBpJrIn2NHAh8lih52D/VWzg1tsLt5RbA81OsD+MM
         b4pouDdmcOiuowYNVFM8OKavGT9h+wgCQl/EhdrN4Q2xyxfOKO/7wyEZv1lQa3jLdGw3
         vKVA==
X-Gm-Message-State: ABy/qLaBaieB1gdo/ymCK2v6Jzy3pQSc5en3uMITSqL/DVqr9VsykiZd
        FSvtux2LoYuh37JAj1ue/tF2qD67wIA3ltQXO4WChkrg
X-Google-Smtp-Source: APBJJlHdfBsb+0ds4EF8i3qpz81lyq1R9mACIbxRddTOfOk8BmqmI/ziPA1E90cafG87meBYYIytvg==
X-Received: by 2002:a2e:9d86:0:b0:2b6:cf0f:1fbf with SMTP id c6-20020a2e9d86000000b002b6cf0f1fbfmr1141034ljj.42.1688105800603;
        Thu, 29 Jun 2023 23:16:40 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id n22-20020a2e8796000000b002b6c8958c17sm575050lji.44.2023.06.29.23.16.39
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 23:16:39 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2b6a0d91e80so24279641fa.3
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 23:16:39 -0700 (PDT)
X-Received: by 2002:a2e:870f:0:b0:2b6:99a3:c254 with SMTP id
 m15-20020a2e870f000000b002b699a3c254mr1390190lji.26.1688105798765; Thu, 29
 Jun 2023 23:16:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230629184151.888604958@linuxfoundation.org> <CA+G9fYsM2s3q1k=+wHszvNbkKbHGe1pskkffWvaGXjYrp6qR=g@mail.gmail.com>
In-Reply-To: <CA+G9fYsM2s3q1k=+wHszvNbkKbHGe1pskkffWvaGXjYrp6qR=g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Jun 2023 23:16:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=whaO3RZmKj8NDjs4f6JEwuwQWWesOfFu-URzOqTkyPoxw@mail.gmail.com>
Message-ID: <CAHk-=whaO3RZmKj8NDjs4f6JEwuwQWWesOfFu-URzOqTkyPoxw@mail.gmail.com>
Subject: Re: [PATCH 6.4 00/28] 6.4.1-rc1 review
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
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

On Thu, 29 Jun 2023 at 22:31, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> arch/parisc/mm/fault.c: In function 'do_page_fault':
> arch/parisc/mm/fault.c:292:22: error: 'prev' undeclared (first use in this function)
>   292 |                 if (!prev || !(prev->vm_flags & VM_GROWSUP))

Bah. "prev" should be "prev_vma" here.

I've pushed out the fix. Greg, apologies. It's

   ea3f8272876f parisc: fix expand_stack() conversion

and Naresh already pointed to the similarly silly sparc32 fix.

             Linus
