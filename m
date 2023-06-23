Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB3873C35A
	for <lists+stable@lfdr.de>; Fri, 23 Jun 2023 23:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjFWVxT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 23 Jun 2023 17:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbjFWVxD (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Jun 2023 17:53:03 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B97826AD
        for <stable@vger.kernel.org>; Fri, 23 Jun 2023 14:52:46 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-98bcc5338d8so119769366b.1
        for <stable@vger.kernel.org>; Fri, 23 Jun 2023 14:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1687557165; x=1690149165;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=crikR62VHTobwaAaRBUscQ/y18KPE823gSw9fzpdAYI=;
        b=XP17ygZeyMQjg1fXuASSv1tridfPM/sVxS3yBqNGR5WcR/T4D/AkLe5eXlaBjpx+tx
         m3OBa+depDAVfkJLy1TBXNJQsTv9QxsVIbDqwqZSYEMnmgHs+Xxy2u0R9KV60fxW9Lyk
         oJ365+xpNO+arPDqKCR8ZVqhODKss41Dr96a4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687557165; x=1690149165;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=crikR62VHTobwaAaRBUscQ/y18KPE823gSw9fzpdAYI=;
        b=BOwV+DUumufVvUo+tdjOMp/sFGRY79wVZozxkWbTWGkt2Qxb9Bf61yLAdS47yRZHyn
         OC8qj7Fd/INPfek4729cvaOmJsEXCUDC2Z3HyDDB91BDmHy13eKQyIU64ppSpsxogMSt
         HeglLF93RnfRmkRrW+BkFt/tcRR7eSwUEwrQhKlLO6Vf28oDylXGYTWaMl4AhicYffez
         J/coH3F7wvE+eW3NI7e+bXCS99eAVqvIlJjzsA4OYcXi0wfKhbkodWrn6B/xndtcNEYH
         69puhUYpW6EHQNWKkDiIYvOD6KHS/7XQgTik5VYVQ5sUpxl6oBkODftS2GHOLDQHuWkr
         taPQ==
X-Gm-Message-State: AC+VfDxU1r9bCs1GWTWTkqCqawtqrGNG16TDyTNGCkcMzpe9P/XqVfbo
        1KZFybBEfBWmYK1HNkjvAEcFKJ8dvKdddM5zJqTCaQ==
X-Google-Smtp-Source: ACHHUZ5/tIGkvekqSuyspL3a5Vst0CT+oadvfGhkBldJ+f00SKhzORcRFZ6dGEMBlzCmQJ3E4r41yw==
X-Received: by 2002:a17:907:2687:b0:97c:64bd:50a5 with SMTP id bn7-20020a170907268700b0097c64bd50a5mr20291159ejc.53.1687557164930;
        Fri, 23 Jun 2023 14:52:44 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id br26-20020a170906d15a00b0096f7cf96525sm108350ejb.146.2023.06.23.14.52.43
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 14:52:43 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-519c0ad1223so1216122a12.0
        for <stable@vger.kernel.org>; Fri, 23 Jun 2023 14:52:43 -0700 (PDT)
X-Received: by 2002:aa7:c859:0:b0:50b:c085:1991 with SMTP id
 g25-20020aa7c859000000b0050bc0851991mr13780235edt.19.1687557162976; Fri, 23
 Jun 2023 14:52:42 -0700 (PDT)
MIME-Version: 1.0
References: <GQUnKz2al3yke5mB2i1kp3SzNHjK8vi6KJEh7rnLrOQ24OrlljeCyeWveLW9pICEmB9Qc8PKdNt3w1t_g3-Uvxq1l8Wj67PpoMeWDoH8PKk=@proton.me>
 <ZHFaFosKY24-L7tQ@debian.me> <NVN-hJsvHwaHe6R-y6XIYJp0FV7sCavgMjobFnseULT1wjgkOFNXbGBGT5iVjCfbtU7dW5xy2hIDoq0ASeNaXhvSY-g2Df4aHWVIMQ2c3TQ=@proton.me>
 <ZIcmpcEsTLXFaO0f@debian.me> <oEbkgJ-ImLxBDZDUTnIAGFWrRVnwBss3FOlalTpwrz83xWgESC9pcvNKiAVp9BzFgqZ0V-NIwzBZ7icKD8ynuIi_ZMtGt7URu3ftcSt16u4=@proton.me>
 <e2ca75ef-d779-4bad-84a5-a9f262dbe213@lunn.ch> <FNzHwp9-AyweVwIMndmih6VuBD0nsyRp3OM72bmOxpeYszF680jFPJjENIknT32FeaqfVBtVSQFw-5mgE3ZXeksVD8VCFbxwojxP3mSZ9DQ=@proton.me>
 <9517bb70-426c-0296-b426-f5b4f075f7c8@leemhuis.info> <CAHmME9p2ZLJUMq96vhkiSgvJkxP5BxE778MhY5Ou2WdxLVEJyg@mail.gmail.com>
 <CAMj1kXHGkJsgArabs_mbzR3Y83s48qmf_aqb50k1LV1Hi5iNgA@mail.gmail.com>
 <CAHk-=wiiFHLSDe3JSSMm5EezpXXMFxYH=RwFLEbgsCKLjg4qqQ@mail.gmail.com> <CAHmME9oC6Kq5qeoSmY5CdDrbGnkcp9sy-9ESXdpRtM8x1_6Hwg@mail.gmail.com>
In-Reply-To: <CAHmME9oC6Kq5qeoSmY5CdDrbGnkcp9sy-9ESXdpRtM8x1_6Hwg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 23 Jun 2023 14:52:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjKtHwJBeUiJL_1HFJKWja120w-6qaLx1FS5p9QE0PfSw@mail.gmail.com>
Message-ID: <CAHk-=wjKtHwJBeUiJL_1HFJKWja120w-6qaLx1FS5p9QE0PfSw@mail.gmail.com>
Subject: Re: [REGRESSION][BISECTED] Boot stall from merge tag 'net-next-6.2'
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, regressions@leemhuis.info,
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

On Fri, 23 Jun 2023 at 13:31, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> We always have to write when using so that we don't credit the same
> seed twice, so it's gotta be used at a stage when SetVariable is
> somewhat working.

This code isn't even the code that "uses" the alleged entropy from
that EFI variable in the first place. That's the code in
efi_random_get_seed() in the EFI boot sequence, and appends it to the
bootup randomness buffers.

And that code already seems to clear the EFI variable (or seems to
append to it).

So this argument seems to be complete garbage - we absolutely do not
have to write it, and your patch already just wrote it in the wrong
place anyway.

Don't make excuses. That code caused boot failures, it was all done in
the wrong place, and at entirely the wrong time.

                  Linus
