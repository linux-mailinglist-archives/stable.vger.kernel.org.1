Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551CC738DE2
	for <lists+stable@lfdr.de>; Wed, 21 Jun 2023 19:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbjFUR51 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 21 Jun 2023 13:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbjFUR5P (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Jun 2023 13:57:15 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C39B26A2
        for <stable@vger.kernel.org>; Wed, 21 Jun 2023 10:56:31 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b46bfa66d2so66064591fa.2
        for <stable@vger.kernel.org>; Wed, 21 Jun 2023 10:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1687370185; x=1689962185;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HJx3UsV77JuxwQCPSbmxcEQXpPRNKRvV07UCaJ+HfVc=;
        b=Wu1t92qowZqWEvU6vL86VubsGqP7ZiAe/0yKh2Uo9hUyr1+KNt9u6pUnLcAKyY9sR3
         ZWqTIWSpQrQGDvrvDmroUqarj53N10HlPjmpnyNFTM4KOXVZjfx0KI1A5gH8ViE7rkJX
         aqd6C4KxMse+GkQ8ySISEvR5g1UzEvcnK79zE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687370185; x=1689962185;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HJx3UsV77JuxwQCPSbmxcEQXpPRNKRvV07UCaJ+HfVc=;
        b=O0anl7VAL+1GzG1cqg0WGmr+jXNXDr8FBz7dbYGpjb8I9K7EFAvRHswpK8yR6xF/AF
         UESXk/WIbh60wYT6kIZVvuEzwjc6/3yWWEn08AU16KMwrkdv7dvcG8U/IT7mojaoAfh6
         afkEgS45ik8ybnL+LuCToiJi2hzm9ciHBHGwEGEBmZBV2UY0rENIOi02QHCymImwGiMM
         2uEU8nZIMGy4/fl/+whtPMu7wX+5Woa/TgPJqLfoVKAf9VBhIOvFjoA7Um1B7J0XKljr
         q71F0KaAbsEsNKd7COsXt2CBBL+QGvCReAJDgMdNmHyehd5CgtEJvs4Q3JeL12RrLyF0
         cLjA==
X-Gm-Message-State: AC+VfDwFGlqeTXcMowOSkn3yf9CSJZGfXMllsNmTJaQj+6IkGoo40FEw
        nx04jiC5+8ZYIkwbW0JD7tw4FteLQwhSZq4iGylbwo9U
X-Google-Smtp-Source: ACHHUZ4HAT1XYYCEuLcFIHuzU3Z3FWGhLzPkcitnApiWg7YgIo0QcwogwiBeYrkYC1w81N7GJqozMA==
X-Received: by 2002:a2e:86d0:0:b0:2b5:8080:af5a with SMTP id n16-20020a2e86d0000000b002b58080af5amr3298873ljj.48.1687370184863;
        Wed, 21 Jun 2023 10:56:24 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id u15-20020a2e2e0f000000b002b1e6a78d3esm964432lju.82.2023.06.21.10.56.24
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 10:56:24 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-4f8792d2e86so3831159e87.1
        for <stable@vger.kernel.org>; Wed, 21 Jun 2023 10:56:24 -0700 (PDT)
X-Received: by 2002:a19:f201:0:b0:4f7:42de:3a8f with SMTP id
 q1-20020a19f201000000b004f742de3a8fmr9024880lfh.56.1687370183631; Wed, 21 Jun
 2023 10:56:23 -0700 (PDT)
MIME-Version: 1.0
References: <GQUnKz2al3yke5mB2i1kp3SzNHjK8vi6KJEh7rnLrOQ24OrlljeCyeWveLW9pICEmB9Qc8PKdNt3w1t_g3-Uvxq1l8Wj67PpoMeWDoH8PKk=@proton.me>
 <ZHFaFosKY24-L7tQ@debian.me> <NVN-hJsvHwaHe6R-y6XIYJp0FV7sCavgMjobFnseULT1wjgkOFNXbGBGT5iVjCfbtU7dW5xy2hIDoq0ASeNaXhvSY-g2Df4aHWVIMQ2c3TQ=@proton.me>
 <ZIcmpcEsTLXFaO0f@debian.me> <oEbkgJ-ImLxBDZDUTnIAGFWrRVnwBss3FOlalTpwrz83xWgESC9pcvNKiAVp9BzFgqZ0V-NIwzBZ7icKD8ynuIi_ZMtGt7URu3ftcSt16u4=@proton.me>
 <e2ca75ef-d779-4bad-84a5-a9f262dbe213@lunn.ch> <FNzHwp9-AyweVwIMndmih6VuBD0nsyRp3OM72bmOxpeYszF680jFPJjENIknT32FeaqfVBtVSQFw-5mgE3ZXeksVD8VCFbxwojxP3mSZ9DQ=@proton.me>
 <9517bb70-426c-0296-b426-f5b4f075f7c8@leemhuis.info>
In-Reply-To: <9517bb70-426c-0296-b426-f5b4f075f7c8@leemhuis.info>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 21 Jun 2023 10:56:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiK5oDqgt6=OHLiiAu4VmLy4qn8WQdhvFo+sm26r4UjHw@mail.gmail.com>
Message-ID: <CAHk-=wiK5oDqgt6=OHLiiAu4VmLy4qn8WQdhvFo+sm26r4UjHw@mail.gmail.com>
Subject: Re: [REGRESSION][BISECTED] Boot stall from merge tag 'net-next-6.2'
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Linux Stable <stable@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Sami Korkalainen <sami.korkalainen@proton.me>
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

On Wed, 21 Jun 2023 at 01:46, Linux regression tracking (Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> Jason, in that case it seems this is something for you. For the initial
> report, see here:

I'll just revert it for now. Writing EFI variables has always been
fraught with danger - more so than just reading them - and this one
just looks horrible anyway.

Calling execute_with_initialized_rng() can end up having the callback
done under a spinlock with interrupts disabled, which is probably why
it then has that odd double indirection through a one-time work. And
in no situation should we start writing to EFI variables during early
subsystem initialization, I feel.

It also probably shouldn't use the "set_variable" function at all, but
the non-blocking one, and who knows if it should try to do some
serialization with efi/vars.c.

I think it would be better off done in user space, but if we can't
trust user space to do the right thing, at least do it much much
later.

               Linus
