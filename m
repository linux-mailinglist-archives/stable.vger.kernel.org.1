Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34CB87434E4
	for <lists+stable@lfdr.de>; Fri, 30 Jun 2023 08:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjF3GVL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 30 Jun 2023 02:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjF3GVJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 30 Jun 2023 02:21:09 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AE42694
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 23:21:04 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fb863edcb6so2481155e87.0
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 23:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688106062; x=1690698062;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rRbIAUxLipf503mIOlM3ZYKM925BvMPEOuWIEIxYBNQ=;
        b=HP9CGGX4jcZPoYQb0KQPv5BBlSBiyoTla0dND8xY1faIV4H8QhW+P8saDPovfpcVQ8
         hC3DvLnnNHLG1S4WdAVVuFVWycpKY9R11acIeNNr4h9KjZvbx26+3/nbrWmZmu+WCNOu
         EIpc8PidofXexHz/QoXKJidC9acH/VWf/2Pms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688106062; x=1690698062;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rRbIAUxLipf503mIOlM3ZYKM925BvMPEOuWIEIxYBNQ=;
        b=FLXhgUPYBhyF+xH5oATBSpFYV6/zjxjPB6LcdKDEDIhhTcR/jCJFFyGuCv9pLPnnhN
         5tTww0rFUe35kd9y0puOWI17ajB4pmYOnsCwnJgN2/eSbvFHvharEEA1Oj7U1ijnsSY6
         dL8XMwAg4PSTbDKklVRDzFjkAy/Qgi9AHvo5wn94aPoeJ3c+xwqcwfF9gGeHuJY585HF
         m5QiJHhgyHXZyl+k4GeViJefdMXPDtZm3Q6mff+ds220CVs4ygSYLND4O6fQVoQSLz7H
         QkWeollorwaPh5AkrFeV3Y2C44RnGAlS25ISPm09xZ9boUGxmI8wA3i6orE/04bSrtyx
         jXIg==
X-Gm-Message-State: ABy/qLY0nM2eKybDD0gvTPPed/TUrhv8yzxYpmpU8T5hQHW25GXy3Lf4
        R3CuGxRfY/LG4p2dcizr0dIGugikosstAy9SuPb7h2yA
X-Google-Smtp-Source: APBJJlHrK1OHO/tNPe4CZBzKAY29L4Oge6eTPhc/M5CCxdkL+bKAxbK2r+xAvwvwcjYHBCnYx2lcRw==
X-Received: by 2002:a05:6512:159c:b0:4f3:b61a:a94b with SMTP id bp28-20020a056512159c00b004f3b61aa94bmr1805742lfb.53.1688106062678;
        Thu, 29 Jun 2023 23:21:02 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id q9-20020ac25109000000b004f84372e40csm2611825lfb.179.2023.06.29.23.21.02
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 23:21:02 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2b6994a8ce3so22931981fa.1
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 23:21:02 -0700 (PDT)
X-Received: by 2002:a05:651c:206:b0:2b6:9f64:c375 with SMTP id
 y6-20020a05651c020600b002b69f64c375mr1282639ljn.47.1688106061998; Thu, 29 Jun
 2023 23:21:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230630055626.202608973@linuxfoundation.org>
In-Reply-To: <20230630055626.202608973@linuxfoundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Jun 2023 23:20:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=when9OgPprG57O+DtVFM7X9_wb6x2h4Veq4Gu6TUvxyiQ@mail.gmail.com>
Message-ID: <CAHk-=when9OgPprG57O+DtVFM7X9_wb6x2h4Veq4Gu6TUvxyiQ@mail.gmail.com>
Subject: Re: [PATCH 6.4 00/29] 6.4.1-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
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

On Thu, 29 Jun 2023 at 22:59, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> Linus Torvalds <torvalds@linux-foundation.org>
>     gup: add warning if some caller would seem to want stack expansion

Did you decide to take that one after all?

It's not exactly wrong, and it might help find any odd cases, but I do
suspect you can get syzbot etc to trigger the warning. It's designed
to find crazy users, and syzbot is - pretty much by definition and by
design - one of the craziest out there.

            Linus
