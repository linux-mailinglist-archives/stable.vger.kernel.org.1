Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F6E739068
	for <lists+stable@lfdr.de>; Wed, 21 Jun 2023 21:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjFUTvu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 21 Jun 2023 15:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjFUTvu (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Jun 2023 15:51:50 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA34184
        for <stable@vger.kernel.org>; Wed, 21 Jun 2023 12:51:49 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-988c495f35fso454881966b.1
        for <stable@vger.kernel.org>; Wed, 21 Jun 2023 12:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1687377107; x=1689969107;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MfThIXnm1cC9qXQRV1CY6U1OcxuFqEAFC2ABjaKFNAI=;
        b=MbbG7drYmNXCj3A9IhR6yNxurZaP/pIafigCURw1KmcLwWww21MB04/4OGrS8fApZz
         W+4joZQzrYlG8KNcwvY4XDVPMikD6LgrlmKgli6qA5fba/EzxKOZmXaKsYpFGoAXAWGG
         lzZmroiCEhXJUDD7w/yEx4/CvnAN/tdljMims=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687377107; x=1689969107;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MfThIXnm1cC9qXQRV1CY6U1OcxuFqEAFC2ABjaKFNAI=;
        b=KcXfxavnE0CtltBqF0qXjbuWvFEbk34YeXsjyvc9NKfdpuJPROeoU6MdpJBwPtLVUk
         /8oHQC9nNuuF2ega1lKj+qgrrWHm80bcgIrqb38eIJWzD5GRZuhN1Y89YZyhP4BIRSTs
         stZvRmtDDH4wd20kTBcpSI3okRkxzv2jTWcoP+wXtZzclVw8/LufANE7tav62ZJigZdf
         zfFb6P5xBbV1JVuLdagE/jkm4kaHzlVVb9RVPeNk3qBM4bTs6LqsE/OP2/4UnKsM7RYW
         LbKCPjl/YsTcO3rzLSUvKlO5pSTWhRQdQsZ6SwryO5MWE110KtienbhCJy0tZbUa1chT
         +yQw==
X-Gm-Message-State: AC+VfDyxqsp8uTigD54dd7IsTxzVWw/CZGhT2yeHSZfPthdTFrEelP8B
        616+lt9bsfNMgJQqcgeCW8XvKfsrpsoDkynbs2LIq8u1
X-Google-Smtp-Source: ACHHUZ5Ji+/NIc8epZ+QEZVqexPoq2WRCLtnx26Fpk3Ro2dvLT+DuubznqmZJzaKvb2jJNlk8cY86g==
X-Received: by 2002:a17:906:58d2:b0:988:8a11:ab88 with SMTP id e18-20020a17090658d200b009888a11ab88mr10075913ejs.33.1687377107290;
        Wed, 21 Jun 2023 12:51:47 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id g15-20020a17090613cf00b009885462a644sm3572067ejc.215.2023.06.21.12.51.46
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 12:51:46 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-51a2160a271so7819716a12.1
        for <stable@vger.kernel.org>; Wed, 21 Jun 2023 12:51:46 -0700 (PDT)
X-Received: by 2002:a05:6402:111a:b0:514:a110:6bed with SMTP id
 u26-20020a056402111a00b00514a1106bedmr10689946edv.27.1687377105968; Wed, 21
 Jun 2023 12:51:45 -0700 (PDT)
MIME-Version: 1.0
References: <GQUnKz2al3yke5mB2i1kp3SzNHjK8vi6KJEh7rnLrOQ24OrlljeCyeWveLW9pICEmB9Qc8PKdNt3w1t_g3-Uvxq1l8Wj67PpoMeWDoH8PKk=@proton.me>
 <ZHFaFosKY24-L7tQ@debian.me> <NVN-hJsvHwaHe6R-y6XIYJp0FV7sCavgMjobFnseULT1wjgkOFNXbGBGT5iVjCfbtU7dW5xy2hIDoq0ASeNaXhvSY-g2Df4aHWVIMQ2c3TQ=@proton.me>
 <ZIcmpcEsTLXFaO0f@debian.me> <oEbkgJ-ImLxBDZDUTnIAGFWrRVnwBss3FOlalTpwrz83xWgESC9pcvNKiAVp9BzFgqZ0V-NIwzBZ7icKD8ynuIi_ZMtGt7URu3ftcSt16u4=@proton.me>
 <e2ca75ef-d779-4bad-84a5-a9f262dbe213@lunn.ch> <FNzHwp9-AyweVwIMndmih6VuBD0nsyRp3OM72bmOxpeYszF680jFPJjENIknT32FeaqfVBtVSQFw-5mgE3ZXeksVD8VCFbxwojxP3mSZ9DQ=@proton.me>
 <9517bb70-426c-0296-b426-f5b4f075f7c8@leemhuis.info> <CAHmME9oh7kEUe-6NFk9=_8UxeD-SNbfMksYh3GaYdutXS01zOw@mail.gmail.com>
In-Reply-To: <CAHmME9oh7kEUe-6NFk9=_8UxeD-SNbfMksYh3GaYdutXS01zOw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 21 Jun 2023 12:51:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=who5-p3QKFnio2nA9b4yf0qrV-KZ8bJa7m80ouJbvOfoA@mail.gmail.com>
Message-ID: <CAHk-=who5-p3QKFnio2nA9b4yf0qrV-KZ8bJa7m80ouJbvOfoA@mail.gmail.com>
Subject: Re: [REGRESSION][BISECTED] Boot stall from merge tag 'net-next-6.2'
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Sami Korkalainen <sami.korkalainen@proton.me>,
        Andrew Lunn <andrew@lunn.ch>,
        Linux Stable <stable@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Brad Spengler <spender@grsecurity.net>,
        regressions@leemhuis.info
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

On Wed, 21 Jun 2023 at 11:49, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Would you try applying
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=13bb06f8dd42071cb9a49f6e21099eea05d4b856
> instead of the revert?

That commit just got merged into my tree, and it fixes a real bug, but
it _shouldn't_ be what Sami sees.

The bug it fixes was only introduced in this merge window.

So any boot failures seen in older kernels would only be because it
was then backported to stable trees, but Sami mentions kernel versions
that don't have those stable backports (eg the original questionable
bisection that ended up on a bad commit 7e68dd7d07a2).

Now, with non-repeatable boot failures, anything is possible, and Sami
does mention 6.1.30 as good (implying that 6.1.31 might not be - and
that is when the backport happened).

So it's certainly worth checking out, but on the face of it, that
bisection result doesn't really support the bug being due to
e9523a0d81899 (which came *after* e7b813b32a42).

                Linus
