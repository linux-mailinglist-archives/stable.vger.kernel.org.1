Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2119173BDCF
	for <lists+stable@lfdr.de>; Fri, 23 Jun 2023 19:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbjFWRa1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 23 Jun 2023 13:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbjFWRaY (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Jun 2023 13:30:24 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4982942
        for <stable@vger.kernel.org>; Fri, 23 Jun 2023 10:30:18 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b4745834f3so14977951fa.2
        for <stable@vger.kernel.org>; Fri, 23 Jun 2023 10:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1687541416; x=1690133416;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z6gsFnCOPQqveW3Pgec1BIN9/v1H+43jT4xHFsyYNnc=;
        b=BERNpO8qQGNhnCYAugF+kNw4MPYc9lKANuR4MRrypSPIOt8fvTrWA6XgyeUhw470Dl
         REbojEDBAG30qa46nRWCUwdLM1RF7FVveUyzA7c+z56wN2HnEaQgvEzg1Uii5qLbPt3P
         hw9PL5d6qBCkfRkzxcLRRz+fq/YQdnoSIi95Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687541416; x=1690133416;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z6gsFnCOPQqveW3Pgec1BIN9/v1H+43jT4xHFsyYNnc=;
        b=Q3GDNP9+sFLH+0j27gjOfbwYWstA8bSuhYIvpgI4TkZEL7N0Ha63u7WFSrZ+ojGWwN
         L4lg3EDY7Cn6txxIK9EO9iq4jIPjqEene7X1vYdOzbs+2jjJGP3sZSFs+MTTYsPxHIJh
         8i5QrkNwca3m9e/CRA9VMLBrj+thT02Jy4+wxGw5KMNx5PPrmu+uGTIGw3bBX+7FOHG5
         ts1ZQ9bHGeqFftjU50er54btEx33ZNHYuJmmINod26RK8O3hnM1YRI43IQepu2uBl4tX
         MuRtazSx5Rvm9e+w7oB33zNIRLc5+qOHYPBFJG8dn/gWB/0SNLDSrhKCfI8UW7KmqbJp
         9opw==
X-Gm-Message-State: AC+VfDyY0umRSFs4X2kdWza11DGMiCiVpBwFH/McIjpxshP6clQIqn9r
        cbyKNk6MNfV2SVVFWpdJ8a6jv/UC3afe+BewZj3P/kkP
X-Google-Smtp-Source: ACHHUZ7jkb1Qjt2T3yurRCIacTiBxx3h+kr2F4VBlj5yK3c8r9K30ugw4KDHbvOI2fcsXjQrwAda7A==
X-Received: by 2002:a19:6409:0:b0:4f8:7781:9875 with SMTP id y9-20020a196409000000b004f877819875mr9983827lfb.60.1687541416665;
        Fri, 23 Jun 2023 10:30:16 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id l10-20020ac2430a000000b004f84305bde3sm1489107lfh.242.2023.06.23.10.30.15
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 10:30:15 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2b466073e19so15112631fa.1
        for <stable@vger.kernel.org>; Fri, 23 Jun 2023 10:30:15 -0700 (PDT)
X-Received: by 2002:a2e:99da:0:b0:2b5:98dc:ffc2 with SMTP id
 l26-20020a2e99da000000b002b598dcffc2mr2530023ljj.52.1687541414839; Fri, 23
 Jun 2023 10:30:14 -0700 (PDT)
MIME-Version: 1.0
References: <GQUnKz2al3yke5mB2i1kp3SzNHjK8vi6KJEh7rnLrOQ24OrlljeCyeWveLW9pICEmB9Qc8PKdNt3w1t_g3-Uvxq1l8Wj67PpoMeWDoH8PKk=@proton.me>
 <ZHFaFosKY24-L7tQ@debian.me> <NVN-hJsvHwaHe6R-y6XIYJp0FV7sCavgMjobFnseULT1wjgkOFNXbGBGT5iVjCfbtU7dW5xy2hIDoq0ASeNaXhvSY-g2Df4aHWVIMQ2c3TQ=@proton.me>
 <ZIcmpcEsTLXFaO0f@debian.me> <oEbkgJ-ImLxBDZDUTnIAGFWrRVnwBss3FOlalTpwrz83xWgESC9pcvNKiAVp9BzFgqZ0V-NIwzBZ7icKD8ynuIi_ZMtGt7URu3ftcSt16u4=@proton.me>
 <e2ca75ef-d779-4bad-84a5-a9f262dbe213@lunn.ch> <FNzHwp9-AyweVwIMndmih6VuBD0nsyRp3OM72bmOxpeYszF680jFPJjENIknT32FeaqfVBtVSQFw-5mgE3ZXeksVD8VCFbxwojxP3mSZ9DQ=@proton.me>
 <9517bb70-426c-0296-b426-f5b4f075f7c8@leemhuis.info> <CAHmME9p2ZLJUMq96vhkiSgvJkxP5BxE778MhY5Ou2WdxLVEJyg@mail.gmail.com>
 <CAMj1kXHGkJsgArabs_mbzR3Y83s48qmf_aqb50k1LV1Hi5iNgA@mail.gmail.com>
In-Reply-To: <CAMj1kXHGkJsgArabs_mbzR3Y83s48qmf_aqb50k1LV1Hi5iNgA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 23 Jun 2023 10:29:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiiFHLSDe3JSSMm5EezpXXMFxYH=RwFLEbgsCKLjg4qqQ@mail.gmail.com>
Message-ID: <CAHk-=wiiFHLSDe3JSSMm5EezpXXMFxYH=RwFLEbgsCKLjg4qqQ@mail.gmail.com>
Subject: Re: [REGRESSION][BISECTED] Boot stall from merge tag 'net-next-6.2'
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>, regressions@leemhuis.info,
        Andrew Lunn <andrew@lunn.ch>,
        Linux Stable <stable@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
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

On Fri, 23 Jun 2023 at 06:55, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> Setting the variable from user space is ultimately a better choice, I
> think.

Doing it from the kernel might still be an option, but I think it was
a huge mistake to do it *early*.

Early boot is fragile to begin with when not everything is set up, and
*much* harder to debug.

So not only are problems more likely to happen in the first place,
when they do happen they are a lot harder to figure out.

Maybe it would make more sense to write a new seed at kernel shutdown.
Not only do y ou presumably have a ton more entropy at that point, but
if things go sideways it's also less of a problem to have dead
machine.

Of course, shutdown is another really hard to debug situation, so not
optimal either.

               Linus
