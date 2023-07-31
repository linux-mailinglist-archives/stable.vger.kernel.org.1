Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2EAD76A0D2
	for <lists+stable@lfdr.de>; Mon, 31 Jul 2023 21:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjGaTGa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 31 Jul 2023 15:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbjGaTG1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 31 Jul 2023 15:06:27 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09F41FD5
        for <stable@vger.kernel.org>; Mon, 31 Jul 2023 12:06:02 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b9cdba1228so55943531fa.2
        for <stable@vger.kernel.org>; Mon, 31 Jul 2023 12:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690830360; x=1691435160;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l2WxsWAHvSSljtKQmToghU/ZBm1ZT8P5v2Qhy5RjWOk=;
        b=FivhBWf5dm+70AtLuhtGSDQWg5T17ddlB5XsAt1myLyxWnKFK+8Xk7iV1BUtuFBhSU
         ZrSydZjVrkpQbWaZJhZJq+tEpQExDh5AB2N8rT9kJJrbMgXZl8P95YSKDKTB8S2vEBeA
         v1YOpMOWdBt995jFr1PtnzTDjoeJMPF/hE9QM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690830360; x=1691435160;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l2WxsWAHvSSljtKQmToghU/ZBm1ZT8P5v2Qhy5RjWOk=;
        b=fz41aW6FdLp0F+aWWDA5q5+rvdgsW5etyk4JlVrmtw2btGFXGiqbF5TIqulbdD+ll/
         sV+jsT2Fftl1qYQ5pXoCn/Cu31RT4UYyEbwEZKUK6LMyA230yZOrgR51HN40T+3eh9ie
         4/qPv3+FS5JZiZOBKIoU7q30i7k5oD39cAJcId4SuCD9q6F2ciOtVAtt+qHRmZm8smIF
         fzxupiY57vIWxcvFCdXrS/fQrvBfim01NfKrypUewe11wAQV9hQaayanuCiMpYoz+BVb
         LEIBdKxbLkpoePwtHtAy1xE9sQRTazIPlFL0PBq55D0i8zauI0+npQDqwZ314HMrZB/z
         XMZQ==
X-Gm-Message-State: ABy/qLZqCPloAQdwvLnKuXoTdbC9Orj0G5IHK4GX+/tW8mzUCE4lQKVx
        GUniWJOr6JbR5sRoU9MTrB6hyYZW46LucGWjoBeXa7H9
X-Google-Smtp-Source: APBJJlGqbeSexYueKYu3nhtEgyElvC0KAx3qo1SVXVdVG8shxwXLboB/iRs2rA5aDtVBzyGtFSUROw==
X-Received: by 2002:a2e:3011:0:b0:2b9:f0b4:eaa1 with SMTP id w17-20020a2e3011000000b002b9f0b4eaa1mr610594ljw.16.1690830360303;
        Mon, 31 Jul 2023 12:06:00 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id dk8-20020a170906f0c800b00992f2befcbcsm6513235ejb.180.2023.07.31.12.05.59
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 12:05:59 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5222bc91838so7234073a12.0
        for <stable@vger.kernel.org>; Mon, 31 Jul 2023 12:05:59 -0700 (PDT)
X-Received: by 2002:aa7:dcc3:0:b0:522:31d5:ee8e with SMTP id
 w3-20020aa7dcc3000000b0052231d5ee8emr691287edu.8.1690830358999; Mon, 31 Jul
 2023 12:05:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230727183805.69c36d6e@g14> <b1dd27df-744b-3977-0a86-f5dde8e24288@amd.com>
 <20230727193949.55c18805@g14> <65a1c307-826d-4ca3-0336-07a185684e5d@amd.com>
 <20230727195019.41abb48d@g14> <67eefe98-e6df-e152-3169-44329e22478d@amd.com>
 <20230727200527.4080c595@g14> <CAHk-=whqT0PxBazwfjWwoHQQFzZt50tV6Jfgq3iYceKMJtyuUg@mail.gmail.com>
 <CUGAV1Y993FB.1O2Q691015Z2C@seitikki>
In-Reply-To: <CUGAV1Y993FB.1O2Q691015Z2C@seitikki>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 31 Jul 2023 12:05:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=whphk8Jp=NYmnm7Qv+vZ6ScYCz+rV8a2G1nD-AQY3z+mQ@mail.gmail.com>
Message-ID: <CAHk-=whphk8Jp=NYmnm7Qv+vZ6ScYCz+rV8a2G1nD-AQY3z+mQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] tpm: disable hwrng for fTPM on some AMD designs
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Daniil Stas <daniil.stas@posteo.net>,
        Mario Limonciello <mario.limonciello@amd.com>,
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

On Mon, 31 Jul 2023 at 03:53, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> I quickly carved up a patch (attached), which is only compile tested
> because I do not have any AMD hardware at hand.

Is there some way to just see "this is a fTPM"?

Because honestly, even if AMD is the one that has had stuttering
issues, the bigger argument is that there is simply no _point_ in
supporting randomness from a firmware source.

There is no way anybody should believe that a firmware TPM generates
better randomness than we do natively.

And there are many reasons to _not_ believe it. The AMD problem is
just the most user-visible one.

Now, I'm not saying that a fTPM needs to be disabled in general - but
I really feel like we should just do

 static int tpm_add_hwrng(struct tpm_chip *chip)
 {
        if (!IS_ENABLED(CONFIG_HW_RANDOM_TPM))
                return 0;
        // If it's not hardware, don't treat it as such
        if (tpm_is_fTPM(chip))
                return 0;
        [...]

and be done with it.

But hey, if we have no way to see that whole "this is firmware
emulation", then just blocking AMD might be the only way.

               Linus
