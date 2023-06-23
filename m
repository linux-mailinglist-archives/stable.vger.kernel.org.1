Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D60273C4A1
	for <lists+stable@lfdr.de>; Sat, 24 Jun 2023 01:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbjFWXDi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 23 Jun 2023 19:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjFWXDe (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Jun 2023 19:03:34 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C494D271E
        for <stable@vger.kernel.org>; Fri, 23 Jun 2023 16:03:14 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so4069025a12.0
        for <stable@vger.kernel.org>; Fri, 23 Jun 2023 16:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1687561382; x=1690153382;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p+C7fNiOBQEjssCfRMNQGT9j05BvDs3sSia5OG9zr5E=;
        b=QJwOmFqEKZHanUu4/h2PiiHFp9sY0V2RsZ/nikN45ZiF9oJKm26YOt3i6WaQwd/WVU
         JHSaOZeDwDhiY/fPZZt5d5+mG+nEFqCca0ylI3l6S2k6b9m2S+/pXJRoedejH59eFqc3
         cJgi+czUiEzyhFAk1wdDdh7t7xlFOlDGzniJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687561382; x=1690153382;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p+C7fNiOBQEjssCfRMNQGT9j05BvDs3sSia5OG9zr5E=;
        b=ia5SA5gtGkMgzCJSfp0W4AmVRyciEpQ9ct8LGSFYTgEw3Aho/qhsztIaLZw0bSq5FE
         5+AWRzwnZphk4euIwH6c6LW7FsgRvSgmLA73UwUyfMah7Q7puEzj/b2GZrI7H0UHcKg3
         mjKB39SRkQUAp56s9c7YNLRzAsi17W/GZgyJw3c9qu5G9fFqzpQ0oVqzLHZ+hBhfzYKe
         I6klXtO3HSUIgBHx//nV/7T9N08G/1R5EU5KKze5/F+FvB7h8MlLN/KOfWYRJXGO3tNY
         D2i6WtlTSZiqEvIMeR53LlrF2igfHJQKH/AyM9HMbUqZDxgClvRMJ713o6pa4qQT8Co/
         MuAg==
X-Gm-Message-State: AC+VfDwuZ+rzNdQTvj8879DgOtKPHgGGvFJkf92WAnmMLrm2TaA5CICe
        ne1oSORReTaPoYj4HVO1Lokr3fXGY/Tz2LxH9zlRk+HP
X-Google-Smtp-Source: ACHHUZ6af9cTcOuA3qQN3VfTUYrTezTF5x9K9DsslWnCFmFAJBeZscJraFK42BDs6LQebmk5laU5Fg==
X-Received: by 2002:a17:906:794a:b0:98d:4ae:8db9 with SMTP id l10-20020a170906794a00b0098d04ae8db9mr5951803ejo.19.1687561382009;
        Fri, 23 Jun 2023 16:03:02 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id z24-20020a1709060ad800b0098807b33996sm171991ejf.107.2023.06.23.16.03.00
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 16:03:01 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-51bdd6f187fso2154068a12.1
        for <stable@vger.kernel.org>; Fri, 23 Jun 2023 16:03:00 -0700 (PDT)
X-Received: by 2002:a05:6402:27cb:b0:514:94be:323c with SMTP id
 c11-20020a05640227cb00b0051494be323cmr22751054ede.10.1687561380662; Fri, 23
 Jun 2023 16:03:00 -0700 (PDT)
MIME-Version: 1.0
References: <GQUnKz2al3yke5mB2i1kp3SzNHjK8vi6KJEh7rnLrOQ24OrlljeCyeWveLW9pICEmB9Qc8PKdNt3w1t_g3-Uvxq1l8Wj67PpoMeWDoH8PKk=@proton.me>
 <ZHFaFosKY24-L7tQ@debian.me> <NVN-hJsvHwaHe6R-y6XIYJp0FV7sCavgMjobFnseULT1wjgkOFNXbGBGT5iVjCfbtU7dW5xy2hIDoq0ASeNaXhvSY-g2Df4aHWVIMQ2c3TQ=@proton.me>
 <ZIcmpcEsTLXFaO0f@debian.me> <oEbkgJ-ImLxBDZDUTnIAGFWrRVnwBss3FOlalTpwrz83xWgESC9pcvNKiAVp9BzFgqZ0V-NIwzBZ7icKD8ynuIi_ZMtGt7URu3ftcSt16u4=@proton.me>
 <e2ca75ef-d779-4bad-84a5-a9f262dbe213@lunn.ch> <FNzHwp9-AyweVwIMndmih6VuBD0nsyRp3OM72bmOxpeYszF680jFPJjENIknT32FeaqfVBtVSQFw-5mgE3ZXeksVD8VCFbxwojxP3mSZ9DQ=@proton.me>
 <9517bb70-426c-0296-b426-f5b4f075f7c8@leemhuis.info> <CAHmME9p2ZLJUMq96vhkiSgvJkxP5BxE778MhY5Ou2WdxLVEJyg@mail.gmail.com>
 <CAMj1kXHGkJsgArabs_mbzR3Y83s48qmf_aqb50k1LV1Hi5iNgA@mail.gmail.com>
 <CAHk-=wiiFHLSDe3JSSMm5EezpXXMFxYH=RwFLEbgsCKLjg4qqQ@mail.gmail.com>
 <CAHmME9oC6Kq5qeoSmY5CdDrbGnkcp9sy-9ESXdpRtM8x1_6Hwg@mail.gmail.com>
 <CAHk-=wjKtHwJBeUiJL_1HFJKWja120w-6qaLx1FS5p9QE0PfSw@mail.gmail.com> <CAMj1kXF7aO1FPXeBFeLBe1-7j5hUjiTAXu-xV6oKFN8dRY3qDQ@mail.gmail.com>
In-Reply-To: <CAMj1kXF7aO1FPXeBFeLBe1-7j5hUjiTAXu-xV6oKFN8dRY3qDQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 23 Jun 2023 16:02:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=whKF0S33EgXts++dpspdFAtkf_otRbV45x1Yt2+bDz0sQ@mail.gmail.com>
Message-ID: <CAHk-=whKF0S33EgXts++dpspdFAtkf_otRbV45x1Yt2+bDz0sQ@mail.gmail.com>
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

On Fri, 23 Jun 2023 at 15:55, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> With the revert applied, the kernel/EFI stub only consumes the
> variable and deletes it, but never creates it by itself, and so the
> code does nothing if the variable is never created in the first place.

Right.

But my *point* was that if we want to create it, we DAMN WELL DO NOT
WANT TO DO SO AT BOOT TIME.

Boot time is absolutely the worst possible time to do it.

We'd be much better off doing so at shutdown time, when we at least
have (a) maximal entropy and (b) failures are less critical.

Jason's argument against that was pure and utter BS.

Now, there are real arguments against shutdown time: it too is
horrible to debug. So shutdown is not exactly great either. It's
better than bootup, but it really would be better to do it at a point
where we can actually get reasonable results out if something goes
wrong. Which it clearly did.

              Linus
