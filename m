Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD9C75094C
	for <lists+stable@lfdr.de>; Wed, 12 Jul 2023 15:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbjGLNMC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 12 Jul 2023 09:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjGLNMB (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 12 Jul 2023 09:12:01 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A21198A
        for <stable@vger.kernel.org>; Wed, 12 Jul 2023 06:11:59 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id 71dfb90a1353d-47e06acce3bso2504572e0c.2
        for <stable@vger.kernel.org>; Wed, 12 Jul 2023 06:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689167518; x=1691759518;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mMTX55rsuAtxs8eoTMF0zmRGfyj0Pb2SnfXciWnbDRk=;
        b=oODGvdD932AIbLChg31AWvPktzZ4m7FTZ6aQ1gLyUuWlnI3wXkOvvrIbbIi8uCqd6K
         2DqwWEDw/fQbtPRvLRedVPOOzTHHsf/4HRHxNFxP2Pk6AD3zGU495vP9iEFnx3zwtWlR
         2U9wGjnFkQAVowaGRwGExOWZmczAT6UqND7v5XIqWbDiLIB4+pd1kEjNyEUPRXB2t+cd
         KSbQccVpwUXW9MgFExadDhAfNc6PtxFhlmkd9Qf3Xr8zxwO/yEbyTLdJSY2y1F+sI6hw
         OZ0Z6hSly9/ApfbBL7ai06kUQFpp3+K3Qd325h0IqPNZ3Q4h3cKxEYPBZU3Hr9g2pzfX
         0XEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689167518; x=1691759518;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mMTX55rsuAtxs8eoTMF0zmRGfyj0Pb2SnfXciWnbDRk=;
        b=gGzV64lu2dXzgGXucWZt8dXtjK6OM5AqalNOcUsgByDiAXq5dvaEPr98vpzB4AKmoh
         mkbFogBLeX4KeVfpVGm/8PvZ89fvQeLOo5t5oh1i0nsIZDIPjy72Bz1kajaB1sT/MS3K
         aiRMemW5liCCnhDf3lS8qvlkvyModrLiY1Dr4FLNNzw2vBX4eGdISly7lsbGGaBFcDky
         XKaDECDOH4q2f4lcjovJyo+nSsUJyx+Kb0tdhXfjbRmbHgOyOkqQBCncSel/zOUskIue
         yZT4HRHOofX5cwMOTQ3TklvSozjbB23odg9315nRPOjXwgnARkuKojpIU8kOP8JhZiOz
         e84g==
X-Gm-Message-State: ABy/qLZHRNpMOtvovaNib58Smil3wqA/WMGgb39RRnujt7mr/tFw2DHD
        MxYQDHdbkUCAOhRUlxlOidhiLF/FilNg+8VlnicgxA==
X-Google-Smtp-Source: APBJJlHszP/BzjPgRktgE9ZmebvyBVKr6pfvWwTZjRe8dSb5sh4qROzT6nYqpk/0QxLKUnz2CT1ElQ7dwOmGZ7kEQMc=
X-Received: by 2002:a1f:3fd0:0:b0:481:2ff5:c9a9 with SMTP id
 m199-20020a1f3fd0000000b004812ff5c9a9mr938260vka.13.1689167518233; Wed, 12
 Jul 2023 06:11:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230709203826.141774942@linuxfoundation.org> <CA+G9fYtEr-=GbcXNDYo3XOkwR+uYgehVoDjsP0pFLUpZ_AZcyg@mail.gmail.com>
 <20230711201506.25cc464d@kernel.org> <ZK5k7YnVA39sSXOv@duo.ucw.cz>
In-Reply-To: <ZK5k7YnVA39sSXOv@duo.ucw.cz>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 12 Jul 2023 18:41:46 +0530
Message-ID: <CA+G9fYvEJgcNhvJk6pvdQOkaS_+x105ZgSM1BVvYy0RRW+1TvA@mail.gmail.com>
Subject: Re: [PATCH 6.4 0/6] 6.4.3-rc2 review
To:     Jakub Kicinski <kuba@kernel.org>, Netdev <netdev@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, Qingfang DENG <qingfang.deng@siflower.com.cn>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>,
        Masahide NAKAMURA <nakam@linux-ipv6.org>,
        Ville Nuorvala <vnuorval@tcs.hut.fi>,
        Arnd Bergmann <arnd@arndb.de>, Pavel Machek <pavel@denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, 12 Jul 2023 at 14:01, Pavel Machek <pavel@denx.de> wrote:
>
> Hi!
>
> > >   git_repo: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
> > >   git_sha: 3e37df3ffd9a648c9f88f6bbca158e43d5077bef
> >
> > I can't find this sha :( Please report back if you can still repro this
> > and how we get get the relevant code
>
> That sha seems to be:
>
> commit 3e37df3ffd9a648c9f88f6bbca158e43d5077bef
> Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Date:   Sun Jul 9 22:38:22 2023 +0200
>
>     Linux 6.4.3-rc2

That is the commit id from stable-rc tree.

I have re-tested the reported issues multiple times and
it seems that it is intermittently reproducible.
Following list of links shows kernel crashes while testing
selftest net pmtu.sh

1)
Unable to handle kernel paging request at virtual address
https://lkft.validation.linaro.org/scheduler/job/6579624#L4648


2)
include/net/neighbour.h:302 suspicious rcu_dereference_check() usage!

https://lkft.validation.linaro.org/scheduler/job/6579625#L7500
https://lkft.validation.linaro.org/scheduler/job/6579626#L7509
https://lkft.validation.linaro.org/scheduler/job/6579622#L7537
https://lkft.validation.linaro.org/scheduler/job/6579623#L7469

- Naresh
