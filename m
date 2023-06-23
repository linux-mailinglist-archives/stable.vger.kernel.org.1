Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B2073BEA9
	for <lists+stable@lfdr.de>; Fri, 23 Jun 2023 21:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbjFWTBm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 23 Jun 2023 15:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbjFWTBl (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Jun 2023 15:01:41 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890101FCE
        for <stable@vger.kernel.org>; Fri, 23 Jun 2023 12:01:40 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-988a5383fd4so186866266b.0
        for <stable@vger.kernel.org>; Fri, 23 Jun 2023 12:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1687546899; x=1690138899;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m6G2sMv4B2au2OlpHw9YOutXro+13UpPpl7VGbAiI6o=;
        b=H1pwdE1MDp9wneWqtC/6GOU+4gyEqtvTodhu5Uanw4hSCppklI4iDtmFDu5IkzCFn4
         HwUlKWOpKWeJc6VCyko6aBa7bWBHE3DtahiGbPwdnF3ixu1kb35J6bxuDO/K0pcOQz13
         CEeilCJIiYOyWI8NNjn2iANhybatXa3fumxf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687546899; x=1690138899;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m6G2sMv4B2au2OlpHw9YOutXro+13UpPpl7VGbAiI6o=;
        b=kPASb1HFBk8dhMu6zrTcr/yig8jae5CPM3dqj7GVlP3Xdo0znGb7K45X4SNQcRHdsw
         9cScpNo+rtb1cYc/ZfHfdsFhCtx4MxAINTwex7LxZEHMMbWmSk+dZgIeLNCEe8L6xbYM
         j4wdFVfiljiD4K6OZoUWGmCEocpd/CpvHqTvtf8dR5MtFE+Xthi33/V2tXNTjyjuLs2K
         VWz1sBs6ztGaurDHx4+EPwg151jDxLM8cZa33CMrFjVlocw2Z05As4uwdBQnYYmrHkoq
         fezM9cQ/vDd/eUXB0hyIGhoP3/mlr72IyLQAAKj7dmGSSq8v2v6vX29jV8hmWDEZG+Vu
         InZQ==
X-Gm-Message-State: AC+VfDxY0Ptodd3G49znrcuagtuWT/TTPRfynk4GyOy4XOU1/IFACXZX
        pqy1L2kx7OKnR/9X7IQ5jozF/tEoL4jGUoXjUS6rCaUI
X-Google-Smtp-Source: ACHHUZ6fltlavAKmi0JNHU934bNoLUcZfeaNyM9OZHqufc1EjFxnqGRabe+KesUCF5JDUVudP8xPXg==
X-Received: by 2002:a17:906:6a0f:b0:988:686a:233 with SMTP id qw15-20020a1709066a0f00b00988686a0233mr17432251ejc.13.1687546898872;
        Fri, 23 Jun 2023 12:01:38 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id ch12-20020a170906c2cc00b00982b204678fsm6202267ejb.207.2023.06.23.12.01.37
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 12:01:38 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-514ab6cb529so3724112a12.1
        for <stable@vger.kernel.org>; Fri, 23 Jun 2023 12:01:37 -0700 (PDT)
X-Received: by 2002:aa7:d706:0:b0:51b:daa6:a215 with SMTP id
 t6-20020aa7d706000000b0051bdaa6a215mr8076731edq.13.1687546897711; Fri, 23 Jun
 2023 12:01:37 -0700 (PDT)
MIME-Version: 1.0
References: <GQUnKz2al3yke5mB2i1kp3SzNHjK8vi6KJEh7rnLrOQ24OrlljeCyeWveLW9pICEmB9Qc8PKdNt3w1t_g3-Uvxq1l8Wj67PpoMeWDoH8PKk=@proton.me>
 <ZHFaFosKY24-L7tQ@debian.me> <NVN-hJsvHwaHe6R-y6XIYJp0FV7sCavgMjobFnseULT1wjgkOFNXbGBGT5iVjCfbtU7dW5xy2hIDoq0ASeNaXhvSY-g2Df4aHWVIMQ2c3TQ=@proton.me>
 <ZIcmpcEsTLXFaO0f@debian.me> <oEbkgJ-ImLxBDZDUTnIAGFWrRVnwBss3FOlalTpwrz83xWgESC9pcvNKiAVp9BzFgqZ0V-NIwzBZ7icKD8ynuIi_ZMtGt7URu3ftcSt16u4=@proton.me>
 <e2ca75ef-d779-4bad-84a5-a9f262dbe213@lunn.ch> <FNzHwp9-AyweVwIMndmih6VuBD0nsyRp3OM72bmOxpeYszF680jFPJjENIknT32FeaqfVBtVSQFw-5mgE3ZXeksVD8VCFbxwojxP3mSZ9DQ=@proton.me>
 <9517bb70-426c-0296-b426-f5b4f075f7c8@leemhuis.info> <CAHmME9p2ZLJUMq96vhkiSgvJkxP5BxE778MhY5Ou2WdxLVEJyg@mail.gmail.com>
 <CAMj1kXHGkJsgArabs_mbzR3Y83s48qmf_aqb50k1LV1Hi5iNgA@mail.gmail.com>
 <CzNbNfn7R2cqLMD6_jp11Dku0OoXYJhx2AMfk8JXeQVP2EGdt7tqeYD4HH0COhp2o_yj5kN6Ao7oObSelRi8yiz-5ltbQ2xtjBvplvgcZjo=@proton.me>
 <CAMj1kXGb+RfMQeOui8uzXBFRchfWhpnEsxOo84Y-LLBqk=z5Uw@mail.gmail.com>
In-Reply-To: <CAMj1kXGb+RfMQeOui8uzXBFRchfWhpnEsxOo84Y-LLBqk=z5Uw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 23 Jun 2023 12:01:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgdH_UtN=PPrb6XV3GogHPMPVYnSgLLAL2d2pM2rru4RQ@mail.gmail.com>
Message-ID: <CAHk-=wgdH_UtN=PPrb6XV3GogHPMPVYnSgLLAL2d2pM2rru4RQ@mail.gmail.com>
Subject: Re: [REGRESSION][BISECTED] Boot stall from merge tag 'net-next-6.2'
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Sami Korkalainen <sami.korkalainen@proton.me>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, regressions@leemhuis.info,
        Andrew Lunn <andrew@lunn.ch>,
        Linux Stable <stable@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Bagas Sanjaya <bagasdotme@gmail.com>
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

On Fri, 23 Jun 2023 at 11:39, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Fri, 23 Jun 2023 at 20:20, Sami Korkalainen
> <sami.korkalainen@proton.me> wrote:
> >
>
> Please don't send me encrypted emails.

Heh. That must be protonmail doing some crazy stuff based on
recipient. Here's Sami's email on the lists:

   https://lore.kernel.org/all/CzNbNfn7R2cqLMD6_jp11Dku0OoXYJhx2AMfk8JXeQVP2EGdt7tqeYD4HH0COhp2o_yj5kN6Ao7oObSelRi8yiz-5ltbQ2xtjBvplvgcZjo=@proton.me/

(and it's what I got too). No encryption anywhere, just the message ID
from hell.

So for some reason protonmail decided that *you* are special, and
singled you out for their super sekrit encryption. Presumably because
Sami has your pgp key.

                  Linus
