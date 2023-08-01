Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078A776B0A0
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 12:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233930AbjHAKPW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 06:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbjHAKO5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 06:14:57 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6CA2D44
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 03:14:02 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fbc5d5742eso59758165e9.3
        for <stable@vger.kernel.org>; Tue, 01 Aug 2023 03:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690884841; x=1691489641;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJx2n+dBel9f4Gt1C4Dg/26a/vxyTBuRpD36Rp0YTDE=;
        b=l6FZS4S/77JJeAvhFucdL4CBN/kyMRL7nCIbDnfc3koM2Rcpo0Pw/AnFduNnQhbHuJ
         YSa6PEGT4pln9+2RLD7aQ8COk68YYTjKfp5xz3O54T+hZ11IHfcuW8AQKGxgeOF+7gZA
         TO4JMgF64HIhRpzM/q72zsLh0J3f7ZdF2HZjplgmsCWYjA5o3ewuoguhnRYso5qh4qX+
         ZXQn4gl1NIkp5ZT8YHm+LaRA4dXpguOyqwmo82VQ+nH+vIqnbTIftc9bIJfHY8DIzWIz
         ZKzEdT1R2sOB9Oax9dIM8/QZN05ZK2dN3pjoGnkz1KmPwa7gCBKZciH5qSJ/kH4au/aU
         RFyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690884841; x=1691489641;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AJx2n+dBel9f4Gt1C4Dg/26a/vxyTBuRpD36Rp0YTDE=;
        b=fPCKuaaEJEEuHOmthQn01ANJYqc7E1HW2kW/lN6l6kB0YelQX1qB+RyGjr8VqFvddI
         jbWQn22RfBCE0QgxAr8bgmT4Y7eLMv/yY3C14ishAfVKeaUYrkQL4wby+baqyS9YpNDC
         2SQ1t21bqvm3H2ymJIcx8eYMfEwPr7MFgqMqZEjMUL6a/jMCN4xJP0mt5Bs8IuXXJTRN
         HUy+Bui82rBoZofuZiCjlsF/20tv1b7RC21hPSbpLVmdJmhub47VH/yRAT9TXV++eMko
         m44SRebKjLA50pDgIp+oRCVx2kK/S7kK/CptxwroSrS8CaSwLLtbBSxnhwo2dRWDgqLB
         LNaw==
X-Gm-Message-State: ABy/qLbRQfx2pzJkfFiGMHMxweHURGPuIxKRj5NS5Y6DlaumGQ1RUZdX
        GhwWDGt+aFt0QyYQVlyRSpuAF9vUZAnBPk8Lx3U=
X-Google-Smtp-Source: APBJJlEdWItKTg2ihWWaxFzEe3sXFyYm+0GFkCVelIwhsymYYOBhJJT2DfbKfsOjtGkviV1BHdgKo09pPWeM6rqUmHU=
X-Received: by 2002:adf:f60a:0:b0:314:3e77:f210 with SMTP id
 t10-20020adff60a000000b003143e77f210mr2056757wrp.59.1690884840824; Tue, 01
 Aug 2023 03:14:00 -0700 (PDT)
MIME-Version: 1.0
Sender: morrisonkelvi9@gmail.com
Received: by 2002:a5d:5502:0:b0:314:5486:9008 with HTTP; Tue, 1 Aug 2023
 03:13:59 -0700 (PDT)
From:   Lauran Glover <lauranglover2@gmail.com>
Date:   Tue, 1 Aug 2023 03:13:59 -0700
X-Google-Sender-Auth: zm97MJyWBke6B2yDn2seBgdb_ow
Message-ID: <CAEEf0pPenzDnVJh-ae1+B2NRVh0C465D7Vw5ubDwZMTaA=jZNg@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,MILLION_USD,MONEY_FRAUD_8,
        RCVD_IN_DNSWL_BLOCKED,RISK_FREE,SPF_HELO_NONE,SPF_PASS,T_MONEY_PERCENT,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Assist Request from You

Please let this not be a surprise message to you because I decided to
contact you on this magnitude and lucrative transaction for our
present and future survival in life. Moreover, I have laid all the
solemn trust in you before I decided to disclose this successful and
confidential transaction to you.
I am  Sgt Lauran Glover  a Female  soldier working for the United
Nations in Poland  on war against Russia invasion in Ukraine  . I have
in my possession the sum of $3.5million USD Which I made here; I
deposited this money with a Red Cross agent. I want you to stand as my
beneficiary and receive the fund and keep it safe so that as soon as I
am through with my mission here in a month's time.
You will utilize this money the way I am going to instruct here, I
want you to take 40% Percent of the total money for your personal use
While 20% Percent of the money will go to charity, people in the
street and helping the orphanage the remaining 40% percent of the
total money .you will assist me to invest it in a good profitable
Venture or you keep it for me until I arrive in your country.
Please reply back to me if you are willing to work with me so that I
can send you the information where the money has been deposited, this
is not a stolen fund and there are no risks involved. I count on your
understanding and honesty.
Yours
Sgt Lauran Glover
