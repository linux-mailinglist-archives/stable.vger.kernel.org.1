Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92777677C9
	for <lists+stable@lfdr.de>; Fri, 28 Jul 2023 23:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234457AbjG1Viq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Jul 2023 17:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbjG1Vip (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Jul 2023 17:38:45 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E67421D
        for <stable@vger.kernel.org>; Fri, 28 Jul 2023 14:38:41 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso278031266b.1
        for <stable@vger.kernel.org>; Fri, 28 Jul 2023 14:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690580320; x=1691185120;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eFPGXH3D8khdfq+8tdL19Fd9zkktz+opxN/g+ekYzaY=;
        b=fP0ohH8W2/J5LSbRtLf6hsxGZtO4D9Uzaygadq1TaxpkEWjJqpRkNCIJIqPtGiRnT2
         XjzGzqlkNLDwqk/fUhZwqXr/4tmvogop1oSFEKwytSFD9E7So8/GvfF/7frMqIeL3ww4
         Laz7MHhQT4qLEYxQ0pIKZ9FAQfK1q4b/AhMkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690580320; x=1691185120;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eFPGXH3D8khdfq+8tdL19Fd9zkktz+opxN/g+ekYzaY=;
        b=UccjIrgTlMVFjQso5z6IYQMnVQDwBclomkpLWhOL8D57psJS1cAu0iu8nAdasj5dMN
         2A0s0aZQ8d2LqVmYzENTtaXdw0h9cfUyXJPOvDBJMhv7RKtk4fmLjZwz5iel+RUHRX9d
         dSRjDp/c2/36aZVaZhr7J4J2qidGLxOUDhssWWtAVeA5nKL9WAaU5FXyddQhVjzC1Sa+
         BbU2L9N1UBge+j5szsXTl0YjrD80uTCAZVvb4b+deR5Yb4phakb0sqx4/4qhoYZOoIoY
         7un1s7HeQdg3hLceTy3mN2TX/C9fWVsgITw0vw+tbgF2TE4hnolV8otoJJ3dKVOng7i4
         HPIQ==
X-Gm-Message-State: ABy/qLa9ID9f39gqgEwL5GTDxpgviL84kCxxdy4hPJ0SIFndJ4ImsCzF
        KgC48Uwr4KDtGJvpKGHfAA4BUB1VWAdFRguaL4mHBguc
X-Google-Smtp-Source: APBJJlGzOiWwCfF4nI4l5RjIGrPwX1IeJIU+LufnGmbI6pMM0/To8Af1ukzUMmmucekSKVTshIaJ3g==
X-Received: by 2002:a17:907:7798:b0:99b:f554:1f1c with SMTP id ky24-20020a170907779800b0099bf5541f1cmr527748ejc.14.1690580319472;
        Fri, 28 Jul 2023 14:38:39 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id k17-20020a1709061c1100b009930c80b87csm2506354ejg.142.2023.07.28.14.38.38
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 14:38:39 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-31783d02093so2055215f8f.0
        for <stable@vger.kernel.org>; Fri, 28 Jul 2023 14:38:38 -0700 (PDT)
X-Received: by 2002:a05:6000:120a:b0:317:54e2:26ca with SMTP id
 e10-20020a056000120a00b0031754e226camr3139809wrx.50.1690580318550; Fri, 28
 Jul 2023 14:38:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230727183805.69c36d6e@g14> <b1dd27df-744b-3977-0a86-f5dde8e24288@amd.com>
 <20230727193949.55c18805@g14> <65a1c307-826d-4ca3-0336-07a185684e5d@amd.com>
 <20230727195019.41abb48d@g14> <67eefe98-e6df-e152-3169-44329e22478d@amd.com>
 <20230727200527.4080c595@g14> <CAHk-=whqT0PxBazwfjWwoHQQFzZt50tV6Jfgq3iYceKMJtyuUg@mail.gmail.com>
 <5235ab4c-a49b-0679-1bef-c3f02346168c@amd.com>
In-Reply-To: <5235ab4c-a49b-0679-1bef-c3f02346168c@amd.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 28 Jul 2023 14:38:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=why=_Y60iHnsh8-SZjs8Ndm41cjAHw7KX3FOD-85=CKEQ@mail.gmail.com>
Message-ID: <CAHk-=why=_Y60iHnsh8-SZjs8Ndm41cjAHw7KX3FOD-85=CKEQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] tpm: disable hwrng for fTPM on some AMD designs
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     Daniil Stas <daniil.stas@posteo.net>,
        James.Bottomley@hansenpartnership.com, Jason@zx2c4.com,
        jarkko@kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, regressions@leemhuis.info,
        stable@vger.kernel.org
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

On Fri, 28 Jul 2023 at 14:01, Limonciello, Mario
<mario.limonciello@amd.com> wrote:
>
> That's exactly why I was asking in the kernel bugzilla if something
> similar gets tripped up by RDRAND.

So that would sound very unlikely, but who knows... Microcode can
obviously do pretty much anything at all, but at least the original
fTPM issues _seemed_ to be about BIOS doing truly crazy things like
SPI flash accesses.

I can easily imagine a BIOS fTPM code using some absolutely horrid
global "EFI synchronization" lock or whatever, which could then cause
random problems just based on some entirely unrelated activity.

I would not be surprised, for example, if wasn't the fTPM hwrnd code
itself that decided to read some random number from SPI, but that it
simply got serialized with something else that the BIOS was involved
with. It's not like BIOS people are famous for their scalable code
that is entirely parallel...

And I'd be _very_ surprised if CPU microcode does anything even
remotely like that. Not impossible - HP famously screwed with the time
stamp counter with SMIs, and I could imagine them - or others - doing
the same with rdrand.

But it does sound pretty damn unlikely, compared to "EFI BIOS uses a
one big lock approach".

So rdrand (and rdseed in particular) can be rather slow, but I think
we're talking hundreds of CPU cycles (maybe low thousands). Nothing
like the stuttering reports we've seen from fTPM.

                            Linus
