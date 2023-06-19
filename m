Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAEF17350B5
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 11:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjFSJpg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 05:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbjFSJpe (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 05:45:34 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621211AB
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 02:45:27 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-47169fc1a40so431411e0c.0
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 02:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687167926; x=1689759926;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HLTYGaHYZDSJp2SbG0y4lmDo+tpAcdjtNbibRr7xhD4=;
        b=EZBvqq4DSpDvkYaOKs/pQgQTG7W4+p/mRHpfKFOMpwQBbC5EsJ81uzQZ9OCdPp7YWq
         9kvIBAomFx+eagbF0/T1qDmDQknzho+DPE8kZrgaCj0iEvMjuG+Eu9w8p4763/SOoCqi
         xthkfTeOelSMWKg2YWF0JDvs0vvar0JT8VM/9m6i58CgsI8yCHyBGNliiV0wkFAtXcZV
         nkQr++jO8aX2rTIkW3DGlskP1uTCXrnOV4WE4jX3uNmmzObvRgS2MD3rkRfA7s/KONjM
         pYgsFQhc5v3q3TPRslZ5N3Xup2HGRkJ0bU9k/zmc49u9EuiN88+chI5UrrQrtodXoOrb
         kMgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687167926; x=1689759926;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HLTYGaHYZDSJp2SbG0y4lmDo+tpAcdjtNbibRr7xhD4=;
        b=hLgzn292zoGfvNz49mSEWInTVw1VGn+XuBQYoMNSoxAzifkx18Te03Hx9NG3ezxcDJ
         c2Kfe2BSrAG02GuIgTpXVMBBAUHhTSCDd3DB9Fmaoho/xETJTc6NlV4txVKJ9iV7dN5F
         jba/K65fTwiDljLKtQJnWuGL/+9PGD0evKXF6m3by+UBBAxm16j3qid5nrloRZlvQoWL
         fAQjNZtwKfb1BnOTxeKUNKaLWTTyrT1wPp2ZIxvif39SrVkbr8M1X+IakC7mdVtSebhb
         np0odEzrx0P1f7KO4lB1d1d+aITnFSO+3C9SKNWwfgWZ3spoJx8geXhZOptpF1dj5QxS
         6Egg==
X-Gm-Message-State: AC+VfDwivpT0/sC5TQ2yr8yqeK4Z2NV7NO4J3uocIocSYPWUnLRUHJll
        4y/gEBIhOzBUlLcv9d6uHrZPxAgnPyzP3dwviutscQ==
X-Google-Smtp-Source: ACHHUZ4fqOuQGq8jNYLHjft9sTuUQTdni994zs91E8Fl4VsHVSfRLcXxuhE8EpPUKdF3R6XMrfkCNaNe256wnbAHgho=
X-Received: by 2002:a1f:3f89:0:b0:471:5144:e7af with SMTP id
 m131-20020a1f3f89000000b004715144e7afmr1309472vka.1.1687167926154; Mon, 19
 Jun 2023 02:45:26 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYueU5joKgRRgLgfBaRTx93B71UXMyueNR_NeA_HZTsvFQ@mail.gmail.com>
 <877711f8-3cdd-c9d8-bc0c-fb3cc827f9f8@0.smtp.remotehost.it>
In-Reply-To: <877711f8-3cdd-c9d8-bc0c-fb3cc827f9f8@0.smtp.remotehost.it>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 19 Jun 2023 15:15:15 +0530
Message-ID: <CA+G9fYu4O-2rdmwuri2GO5VRATw7xCN2x+MX1_Sq4TD18w_0gw@mail.gmail.com>
Subject: Re: stable-rc-5.4.y: arch/mips/kernel/cpu-probe.c:2125:9: error:
 duplicate case value 2125 case PRID_COMP_NETLOGIC
To:     Manuel Lauss <manuel.lauss@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     lkft-triage@lists.linaro.org, Sasha Levin <sashal@kernel.org>,
        Pascal Ernster <git@hardfalcon.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, 18 Jun 2023 at 12:42, Pascal Ernster <git@hardfalcon.net> wrote:
>
> [2023-06-18 07:28] Naresh Kamboju:
> > Following regressions found on stable rc 5.4 while building MIPS configs,
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > MIPS: Restore Au1300 support
> > [ Upstream commit f2041708dee30a3425f680265c337acd28293782 ]
> >
> >
> > Build log:
> > ======
> > arch/mips/kernel/cpu-probe.c: In function 'cpu_probe':
> > arch/mips/kernel/cpu-probe.c:2125:9: error: duplicate case value
> >   2125 |         case PRID_COMP_NETLOGIC:
> >        |         ^~~~
> > arch/mips/kernel/cpu-probe.c:2099:9: note: previously used here
> >   2099 |         case PRID_COMP_NETLOGIC:
> >        |         ^~~~
> > make[3]: *** [scripts/Makefile.build:262: arch/mips/kernel/cpu-probe.o] Error 1
>
> The same issue also affects both the 5.10 and the 5.15 branch.

MIPS builds are breaking on stable-rc 5.4, 5.10 and 5.15 branches.
Due to following patch,
----

Subject: MIPS: Restore Au1300 support

[ Upstream commit f2041708dee30a3425f680265c337acd28293782 ]

The Au1300, at least the one I have to test, uses the NetLogic vendor
ID, but commit 95b8a5e0111a ("MIPS: Remove NETLOGIC support") also
dropped Au1300 detection.  Restore Au1300 detection.

Tested on DB1300 with Au1380 chip.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/kernel/cpu-probe.c | 5 +++++
 1 file changed, 5 insertions(+)


--
Linaro LKFT
https://lkft.linaro.org
