Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F15E74354D
	for <lists+stable@lfdr.de>; Fri, 30 Jun 2023 08:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjF3GtL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 30 Jun 2023 02:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbjF3GtK (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 30 Jun 2023 02:49:10 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A9930F6
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 23:49:09 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fb863edcb6so2515150e87.0
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 23:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688107748; x=1690699748;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DSXNPQ9cSE+8ldFCpxe5231qRGX3JF8PWsLfdfAuz3g=;
        b=gN9yewynNzWqCiLGduiYED62Y+JkiZXdvSBsfk+UJyJRAQfN10Z3+qWgVCuQU7emEO
         cKDfXXNm6Ic30Tqhpd1JTbj6Ul+eZbZzkVpq9OoLfchmazOSLEK8cvnRozQg8QvS2jHp
         dTZNMq0VFfNGYXiUNbE5KIX28Nc/Ajhu3uGPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688107748; x=1690699748;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DSXNPQ9cSE+8ldFCpxe5231qRGX3JF8PWsLfdfAuz3g=;
        b=e3ltCwoRNu1BNfyCjW0AAUpKzxw5OdJjWqaFEYPU0Bkm4Bp1Q61hZZN+WEVjjfqK+G
         LlzwDdq2CBR0zFbdQXtxBq0LgnuFYGTxu+Uo2OZafCtCaGReG1cmCBUNyngEK0DWW/G9
         Iv1rwE1xcQgN6jRs+W5g7kGvLo4hy5/UMhjt4aPprybloB2OkPkQywPrt47v7nGYnMxT
         MBotuK33NS8qP5IfocHfZMviD3/xNVNSvC4ug3e/8FP9pqZh7ahDWAZpp0usksGY1eLl
         6zhPJKx8d/cNgoFneAPrDaCe5KzHRtBciktbmDggFM0zNsRj68KYPXY8P7QPaoL/o+IW
         iYdw==
X-Gm-Message-State: ABy/qLZ35dTMfcUCbjDJpIfBxGijE92+IK5jr2oN7mbFboxR1gQBpVNq
        Q58ggppPkDdenPeC7w8hIZYBTHW1hLtlzotjNJeuZ1Yq
X-Google-Smtp-Source: APBJJlFd9m42z85yzOKLl9QoFefD6Lzl+9DU8vZ+OZWaCjhQYc6U950fuKFuI1N+TDcjnC6UiaiRYg==
X-Received: by 2002:a05:6512:3190:b0:4f8:418e:1e49 with SMTP id i16-20020a056512319000b004f8418e1e49mr2038930lfe.16.1688107747771;
        Thu, 29 Jun 2023 23:49:07 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id b16-20020aa7c6d0000000b0051d7f4f32d6sm6367117eds.96.2023.06.29.23.49.06
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 23:49:06 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-51d9850ef09so1641079a12.0
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 23:49:06 -0700 (PDT)
X-Received: by 2002:a05:6402:12ca:b0:514:96f9:4f20 with SMTP id
 k10-20020a05640212ca00b0051496f94f20mr795315edx.41.1688107745787; Thu, 29 Jun
 2023 23:49:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230630055626.202608973@linuxfoundation.org> <CAHk-=when9OgPprG57O+DtVFM7X9_wb6x2h4Veq4Gu6TUvxyiQ@mail.gmail.com>
 <2023063030-overgrown-unfunded-7523@gregkh>
In-Reply-To: <2023063030-overgrown-unfunded-7523@gregkh>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Jun 2023 23:48:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjm79krU=PJ372s5PzrbZ=kUDA16WMm==J4Moery3Uu0A@mail.gmail.com>
Message-ID: <CAHk-=wjm79krU=PJ372s5PzrbZ=kUDA16WMm==J4Moery3Uu0A@mail.gmail.com>
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

On Thu, 29 Jun 2023 at 23:32, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> I think the "crazy users" reports might be triggered sooner with stable
> updates than from your tree as well, so this might be a early-warning
> type system.

Yeah, I agree, it might help find any potential odd cases more quickly.

So just as long as you are aware of the false positives by syzbot and friends..

               Linus
