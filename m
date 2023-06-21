Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4514738E38
	for <lists+stable@lfdr.de>; Wed, 21 Jun 2023 20:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjFUSJA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 21 Jun 2023 14:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjFUSI6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Jun 2023 14:08:58 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1381716
        for <stable@vger.kernel.org>; Wed, 21 Jun 2023 11:08:55 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-98746d7f35dso793333166b.2
        for <stable@vger.kernel.org>; Wed, 21 Jun 2023 11:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1687370933; x=1689962933;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h4Ucd0qvaN4RbTaMub1cXvd79JxnZbAQ50t+Lut4dXs=;
        b=F+9rPl8kM1cTRgwBD7y5l2+OIyTmPj+r4+80xkIxPVbZ85r+grot89w/imibqZVvHy
         m1ktqIJeFLejg2Ju3ftAoNwKBy47y08A2Ty8WKYIot+/yqzniwYfw4UFUhvckBszvTfO
         Ju3g8EjIJRbPtW+hfJY+lToEpueZdhJTc9zbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687370933; x=1689962933;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h4Ucd0qvaN4RbTaMub1cXvd79JxnZbAQ50t+Lut4dXs=;
        b=F0VfarSWgwcsvsX5DJE83nay3XTN5Z5JGctgkUQPyAsAigWIIVb1+FAakg0ZsjFCLG
         iJD1HQWo/JDokYVk+vq5a1MNrcdTw016KSbH1bCcw2EDV4OB+ajM9AZy5u0lAv6lQZmr
         J1XpWZMBKlD9b0qi2PPxoZGEkxQFIDCzdoykY/DyI+QGDxeIAn9vfyRCnFTTz41ZdMYI
         +MI8UUAolLU32yQHFH5ztoEB2QbtAebsaifCxzGEEMU+P919NpacHv68rTn6qZG2341i
         1mmaZg18gL7uDSo4z12ytDTeW7reTqzZkqRCEzBsyv/WX1jQOy2/P9kwht87o6oW8xUI
         RpLw==
X-Gm-Message-State: AC+VfDz8TgL4nuaUOIhRI+7U4ukJb2NBgBEev216rf21VP/CI/oEh+q0
        UYhwWKKkfd5qoNjgVec2IpUPo1HQoq1greUkfJ3O5QKy
X-Google-Smtp-Source: ACHHUZ7we52DPQV7lUgg9HEELI6uzmzzXHUENkEh4sj6/xuzigKHPD4xs9SsGCliIATo0khd7lMwQQ==
X-Received: by 2002:a17:907:944e:b0:987:1c6b:6e6d with SMTP id dl14-20020a170907944e00b009871c6b6e6dmr12071785ejc.28.1687370933453;
        Wed, 21 Jun 2023 11:08:53 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id g15-20020a17090613cf00b009885462a644sm3469162ejc.215.2023.06.21.11.08.52
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 11:08:53 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-51a426e4f4bso7440700a12.1
        for <stable@vger.kernel.org>; Wed, 21 Jun 2023 11:08:52 -0700 (PDT)
X-Received: by 2002:aa7:c90f:0:b0:51a:50f2:4e7a with SMTP id
 b15-20020aa7c90f000000b0051a50f24e7amr7543192edt.13.1687370932607; Wed, 21
 Jun 2023 11:08:52 -0700 (PDT)
MIME-Version: 1.0
References: <GQUnKz2al3yke5mB2i1kp3SzNHjK8vi6KJEh7rnLrOQ24OrlljeCyeWveLW9pICEmB9Qc8PKdNt3w1t_g3-Uvxq1l8Wj67PpoMeWDoH8PKk=@proton.me>
 <ZHFaFosKY24-L7tQ@debian.me> <NVN-hJsvHwaHe6R-y6XIYJp0FV7sCavgMjobFnseULT1wjgkOFNXbGBGT5iVjCfbtU7dW5xy2hIDoq0ASeNaXhvSY-g2Df4aHWVIMQ2c3TQ=@proton.me>
 <ZIcmpcEsTLXFaO0f@debian.me> <oEbkgJ-ImLxBDZDUTnIAGFWrRVnwBss3FOlalTpwrz83xWgESC9pcvNKiAVp9BzFgqZ0V-NIwzBZ7icKD8ynuIi_ZMtGt7URu3ftcSt16u4=@proton.me>
 <e2ca75ef-d779-4bad-84a5-a9f262dbe213@lunn.ch> <FNzHwp9-AyweVwIMndmih6VuBD0nsyRp3OM72bmOxpeYszF680jFPJjENIknT32FeaqfVBtVSQFw-5mgE3ZXeksVD8VCFbxwojxP3mSZ9DQ=@proton.me>
 <9517bb70-426c-0296-b426-f5b4f075f7c8@leemhuis.info> <CAHk-=wiK5oDqgt6=OHLiiAu4VmLy4qn8WQdhvFo+sm26r4UjHw@mail.gmail.com>
In-Reply-To: <CAHk-=wiK5oDqgt6=OHLiiAu4VmLy4qn8WQdhvFo+sm26r4UjHw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 21 Jun 2023 11:08:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjGubMs+yoCS44bM1x4=CxDWvJeauquCcE5qLzNmToozw@mail.gmail.com>
Message-ID: <CAHk-=wjGubMs+yoCS44bM1x4=CxDWvJeauquCcE5qLzNmToozw@mail.gmail.com>
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

On Wed, 21 Jun 2023 at 10:56, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I'll just revert it for now.

Btw, Thorsten, is there a good way to refer to the regzbot entry in a
commit message some way? I know about the email interface, but I'd
love to just be able to link to the regression entry. Now I just
linked to the report in this thread.

Maybe you don't keep a long-term stable link around anywhere, and you
just pick up on reverts directly, but I suspect it would be nice to be
able to just link to any regression entry directly.

            Linus
