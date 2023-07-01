Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38FF9744683
	for <lists+stable@lfdr.de>; Sat,  1 Jul 2023 06:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjGAEXZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 1 Jul 2023 00:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjGAEXT (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 1 Jul 2023 00:23:19 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4113E1B2
        for <stable@vger.kernel.org>; Fri, 30 Jun 2023 21:23:06 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fb7589b187so4239694e87.1
        for <stable@vger.kernel.org>; Fri, 30 Jun 2023 21:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688185384; x=1690777384;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ViFCqfiw9NC8hbaUDlyrBH6eii1s13MnpTkthHHGEXE=;
        b=ACV7XAyCVqAaBPNd+vSu/FV7OVAcONKkLsIThuTWcFsU+vFFJE8UGIfDFQ9syAqfBF
         UHhVf2ek1ZJtMlI1dLek6aI8vF62vW5SiqORp+TfAwaKEs8e3//gpSn8LzMzxLe8PJ+e
         fkz6qDz5S4RTJATaYWGRbVauPShNUyPDdt41U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688185384; x=1690777384;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ViFCqfiw9NC8hbaUDlyrBH6eii1s13MnpTkthHHGEXE=;
        b=VAwhwHf93xdsKLViPY5fzpHf6Cpf/cZxNGRMo9os6pYCNIZMZgNyoTDIkZSxM6rrEr
         V2KGemt5CiPZrVqGasw2O/lax8GirCGYVzahH2tdRj/btpR7SBY0U3nXaHm3Y6ywD6Kg
         J12cKzLT2UGFlIgw6GLpWoecORF+O7VsHjD6bdEP5Dbs66+MhvQTl7U0nUoHkrwWRX1k
         DPPLT5zldNOWBBQ1/XFeh50zDeqJFQZrw4FOlZbT39PbuTL5buiC6qNNaQi2ukhe6Hxk
         9VUE8xw09RP/rEX3hOGhoP5C0IQWpKIFyuOrYz7XhdkyLm/1b8opiaIi7d+hRPw4OTSW
         bCVA==
X-Gm-Message-State: ABy/qLaLLSB7gz/FAAIFQPY+CRbjYSfxxrPBjtl9AFt+oWP6oi7Rj2Qh
        2pafE2+Gvy1skmGh1k4L04kcaQWgyPiuZbHV7jfwBc0O
X-Google-Smtp-Source: APBJJlEXsv5fF+fANIbS4FKVfsyQ0lig55MxM0I25sYZe6yXJtT7ZD6Y64L/gY+83LKtPkNkRDn1Nw==
X-Received: by 2002:a05:6512:280d:b0:4fb:18f4:4cd4 with SMTP id cf13-20020a056512280d00b004fb18f44cd4mr4009619lfb.55.1688185384354;
        Fri, 30 Jun 2023 21:23:04 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id b23-20020ac25637000000b004f87893ce21sm3158740lff.3.2023.06.30.21.23.03
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jun 2023 21:23:03 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2b69ff54321so42209821fa.2
        for <stable@vger.kernel.org>; Fri, 30 Jun 2023 21:23:03 -0700 (PDT)
X-Received: by 2002:a2e:888e:0:b0:2b5:9f54:e290 with SMTP id
 k14-20020a2e888e000000b002b59f54e290mr3104948lji.0.1688185382985; Fri, 30 Jun
 2023 21:23:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230629184151.888604958@linuxfoundation.org> <CA+G9fYsM2s3q1k=+wHszvNbkKbHGe1pskkffWvaGXjYrp6qR=g@mail.gmail.com>
 <CAHk-=whaO3RZmKj8NDjs4f6JEwuwQWWesOfFu-URzOqTkyPoxw@mail.gmail.com>
 <fbe57907-b03f-ac8c-f3f4-4d6959bbc59c@roeck-us.net> <CAHk-=wgE9iTd_g20RU+FYa0NPhGSdiUDPW+moEqdHR4du1jmVA@mail.gmail.com>
 <CAHk-=wiN5H-2dh2zCo_jXE7_ekrxSHvQcMw4xfUKjuQs2=BN4w@mail.gmail.com>
 <fb63ea7b-c44b-fb1b-2014-3d23794fa896@roeck-us.net> <CAHk-=whh_aUHYF6LCV36K9NYHR4ofEZ0gwcg0RY5hj=B7AT4YQ@mail.gmail.com>
 <e4dd115b-1a41-4859-bbeb-b3a6a75bf664@roeck-us.net>
In-Reply-To: <e4dd115b-1a41-4859-bbeb-b3a6a75bf664@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 30 Jun 2023 21:22:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgBAhFqD6aoD2rL0qws8S1erdbrvmQXuYi=ZFEUVNuVfg@mail.gmail.com>
Message-ID: <CAHk-=wgBAhFqD6aoD2rL0qws8S1erdbrvmQXuYi=ZFEUVNuVfg@mail.gmail.com>
Subject: Re: [PATCH 6.4 00/28] 6.4.1-rc1 review
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
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

On Fri, 30 Jun 2023 at 19:50, Guenter Roeck <linux@roeck-us.net> wrote:
>
> Yes, the patch below fixes the problem.
>
> Building xtensa:de212:kc705-nommu:nommu_kc705_defconfig ... running ......... passed

Thanks. Committed as

  d85a143b69ab ("xtensa: fix NOMMU build with lock_mm_and_find_vma()
conversion")

and pushed out.

                    Linus
