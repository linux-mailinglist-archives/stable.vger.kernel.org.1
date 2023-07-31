Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8AD76A4D4
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 01:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjGaX2g (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 31 Jul 2023 19:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjGaX2f (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 31 Jul 2023 19:28:35 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B921911B
        for <stable@vger.kernel.org>; Mon, 31 Jul 2023 16:28:33 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99bfcf4c814so434512266b.0
        for <stable@vger.kernel.org>; Mon, 31 Jul 2023 16:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690846112; x=1691450912;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2GbKQbR8WQDKm/09hjFJLqAkFDHcK7ngIt0eeXc/7M4=;
        b=ZekSgBZkAavLHGGah0w31PCLHlAqS/S9ypHQf2oGzr6j+sNI2t9uQ/p9xkhUBiSnXM
         WgV/J3qKPl0g/CG0GqD/ITJtAYWXtykxHf6PJhd6gKD4vdcSQC0yFuOrPFUoIv2P1NXP
         wU7sML2VwwbarztWTEem8URdK5+0BOJKp7y0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690846112; x=1691450912;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2GbKQbR8WQDKm/09hjFJLqAkFDHcK7ngIt0eeXc/7M4=;
        b=Iy1seVDk8V6MIm+C6wYBHaYFcO5GdxMUq8sIXmz7bqgzqWeOGhPIZJ3acQeaFx0/89
         ScGgQPukKyVUDDRoCjT87vW+c/nC+S+9nzGbHw69iRk2Mox8neE7TILMwSETII4Rwmuq
         v31+k1ZZ9fh4Rvs+OlU1LYKODqVwmGElAyAdQoGjeXzcmrXNIQKnD9AXy8CxqYfHlI/T
         T8e0Qs29/VLGXMwRnSbl0Mgx7oGUZ/baCf+VzWsj1BRkfrFlZxx3XYlgG+Cb4epHlFg6
         4uhxMSmnHrskNZJfCqmiA7l8HZALOU8jhib+YMcUXImEHSYXktTHu1T2IoA1V2mAvPKY
         QwwA==
X-Gm-Message-State: ABy/qLa/rOb9yWzzTDF7ND3wXZoZ258aOKAFnDkwRfE/beYwO9G2qe6x
        4AIXnL+WmYWDE66fqsV4oTMJXvjfG16Ue/3aBuo7vXBz
X-Google-Smtp-Source: APBJJlHXv+UInaaZG7GOegHp5UDhNGPb8EryqVsJuWQmidFG9x00xDLMfB8Svo2qY0K5PIWpONPi1g==
X-Received: by 2002:a17:906:3046:b0:99b:4668:865f with SMTP id d6-20020a170906304600b0099b4668865fmr942259ejd.10.1690846112182;
        Mon, 31 Jul 2023 16:28:32 -0700 (PDT)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id a26-20020a17090640da00b009829dc0f2a0sm6811670ejk.111.2023.07.31.16.28.30
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 16:28:30 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-3fe2048c910so14471285e9.1
        for <stable@vger.kernel.org>; Mon, 31 Jul 2023 16:28:30 -0700 (PDT)
X-Received: by 2002:adf:f9cf:0:b0:316:ff0e:81b6 with SMTP id
 w15-20020adff9cf000000b00316ff0e81b6mr941858wrr.32.1690846110462; Mon, 31 Jul
 2023 16:28:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230727183805.69c36d6e@g14> <b1dd27df-744b-3977-0a86-f5dde8e24288@amd.com>
 <20230727193949.55c18805@g14> <65a1c307-826d-4ca3-0336-07a185684e5d@amd.com>
 <20230727195019.41abb48d@g14> <67eefe98-e6df-e152-3169-44329e22478d@amd.com>
 <20230727200527.4080c595@g14> <CAHk-=whqT0PxBazwfjWwoHQQFzZt50tV6Jfgq3iYceKMJtyuUg@mail.gmail.com>
 <CUGAV1Y993FB.1O2Q691015Z2C@seitikki> <CAHk-=whphk8Jp=NYmnm7Qv+vZ6ScYCz+rV8a2G1nD-AQY3z+mQ@mail.gmail.com>
 <105b9d13-cedd-7d3c-1f29-2c65199f1de7@amd.com> <CAHk-=why64j-K4e1VxKwx7o6FiGjcXEnu1Pz+1QnNTBCv9AGyA@mail.gmail.com>
 <fd3cc87a-97ec-00ea-e480-f6597664c13a@amd.com>
In-Reply-To: <fd3cc87a-97ec-00ea-e480-f6597664c13a@amd.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 31 Jul 2023 16:28:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=whPvSJH=H9eHZbJQ+sxC-AVDvrgJ+M14fD3K5A+5s=zVA@mail.gmail.com>
Message-ID: <CAHk-=whPvSJH=H9eHZbJQ+sxC-AVDvrgJ+M14fD3K5A+5s=zVA@mail.gmail.com>
Subject: Re: [PATCH 1/1] tpm: disable hwrng for fTPM on some AMD designs
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     linux@dominikbrodowski.net, Jarkko Sakkinen <jarkko@kernel.org>,
        Daniil Stas <daniil.stas@posteo.net>,
        James.Bottomley@hansenpartnership.com, Jason@zx2c4.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@leemhuis.info, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, 31 Jul 2023 at 14:57, Limonciello, Mario
<mario.limonciello@amd.com> wrote:
>
> Are you thinking then to unregister the tpm hwrng "sometime" after boot?

No, I was more thinking that instead of registering it as a randomness
source, you'd just do a one-time

    tpm_get_random(..);
    add_hwgenerator_randomness(..);

and leave it at that.

Even if there is some stutter due to some crazy firmware
implementation for reading the random data, at boot time nobody will
notice it.

           Linus
