Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C623A738DEC
	for <lists+stable@lfdr.de>; Wed, 21 Jun 2023 19:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjFUR6X (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 21 Jun 2023 13:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbjFUR6P (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Jun 2023 13:58:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870F7198E
        for <stable@vger.kernel.org>; Wed, 21 Jun 2023 10:57:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C6DB61658
        for <stable@vger.kernel.org>; Wed, 21 Jun 2023 17:57:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37075C433CA
        for <stable@vger.kernel.org>; Wed, 21 Jun 2023 17:57:48 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="a8pKHg/W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1687370264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rl4SatZlYW3zfPB8EhfcgRbTfzI6pKWS4+j1IBQgrSM=;
        b=a8pKHg/W9ZwYVTfZTeHjMpZ3K5aKoSMPoH/XMSUfa511H3j5VyaOLTL6JWqjhXGgrXoRQs
        OHl8wXJrG14M9pf8KY8QHbhf0wrNRXUDD/ad0QsKOscjXnH1JDdwsbm+7l1DWz6GFJxPuf
        j5iDqlWZFKcPgdACKJV9OPuZvLeD6o8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7d0e998e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <stable@vger.kernel.org>;
        Wed, 21 Jun 2023 17:57:43 +0000 (UTC)
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-78a065548e3so2495337241.0
        for <stable@vger.kernel.org>; Wed, 21 Jun 2023 10:57:43 -0700 (PDT)
X-Gm-Message-State: AC+VfDzXrw2j3m9upenHh8J/M6JNXT4BHfGQvsKvwaiBvbUyNjwvUtve
        PtPo8byYtLDjR8pTfSJqhcQonybUPlR2SBt6GkY=
X-Google-Smtp-Source: ACHHUZ53lppsuJRUY2telQU1fgcbJ1amd7Gy3dfz3XBiZB9kGBmv82dqJ5lIE/ByYVNdHEJQPKWfMcJPdfqxchHEuyE=
X-Received: by 2002:a05:6102:398:b0:440:a920:dcc4 with SMTP id
 m24-20020a056102039800b00440a920dcc4mr5969366vsq.22.1687370261715; Wed, 21
 Jun 2023 10:57:41 -0700 (PDT)
MIME-Version: 1.0
References: <GQUnKz2al3yke5mB2i1kp3SzNHjK8vi6KJEh7rnLrOQ24OrlljeCyeWveLW9pICEmB9Qc8PKdNt3w1t_g3-Uvxq1l8Wj67PpoMeWDoH8PKk=@proton.me>
 <ZHFaFosKY24-L7tQ@debian.me> <NVN-hJsvHwaHe6R-y6XIYJp0FV7sCavgMjobFnseULT1wjgkOFNXbGBGT5iVjCfbtU7dW5xy2hIDoq0ASeNaXhvSY-g2Df4aHWVIMQ2c3TQ=@proton.me>
 <ZIcmpcEsTLXFaO0f@debian.me> <oEbkgJ-ImLxBDZDUTnIAGFWrRVnwBss3FOlalTpwrz83xWgESC9pcvNKiAVp9BzFgqZ0V-NIwzBZ7icKD8ynuIi_ZMtGt7URu3ftcSt16u4=@proton.me>
 <e2ca75ef-d779-4bad-84a5-a9f262dbe213@lunn.ch> <FNzHwp9-AyweVwIMndmih6VuBD0nsyRp3OM72bmOxpeYszF680jFPJjENIknT32FeaqfVBtVSQFw-5mgE3ZXeksVD8VCFbxwojxP3mSZ9DQ=@proton.me>
 <9517bb70-426c-0296-b426-f5b4f075f7c8@leemhuis.info>
In-Reply-To: <9517bb70-426c-0296-b426-f5b4f075f7c8@leemhuis.info>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 21 Jun 2023 19:57:30 +0200
X-Gmail-Original-Message-ID: <CAHmME9p2ZLJUMq96vhkiSgvJkxP5BxE778MhY5Ou2WdxLVEJyg@mail.gmail.com>
Message-ID: <CAHmME9p2ZLJUMq96vhkiSgvJkxP5BxE778MhY5Ou2WdxLVEJyg@mail.gmail.com>
Subject: Re: [REGRESSION][BISECTED] Boot stall from merge tag 'net-next-6.2'
To:     regressions@leemhuis.info, Ard Biesheuvel <ardb@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Stable <stable@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Sami Korkalainen <sami.korkalainen@proton.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

+Ard - any ideas here?

On Wed, Jun 21, 2023 at 10:46=E2=80=AFAM Linux regression tracking (Thorste=
n
Leemhuis) <regressions@leemhuis.info> wrote:
>
> [added Jason (who authored the culprit) to the list of recipients; moved
> net people and list to BCC, guess they are not much interested in this
> anymore then]
>
> On 21.06.23 08:07, Sami Korkalainen wrote:
> > I bisected again. It seems I made some mistake last time, as I got a
> > different result this time. Maybe, because these problematic kernels ma=
y
> > boot fine sometimes, like I said before.
> >
> > Anyway, first bad commit (makes much more sense this time):
> > e7b813b32a42a3a6281a4fd9ae7700a0257c1d50 efi: random: refresh
> > non-volatile random seed when RNG is initialized
> >
> > I confirmed that this is the code causing the issue by commenting it
> > out (see the patch file). Without this code, the latest mainline boots =
fine.
>
> Jason, in that case it seems this is something for you. For the initial
> report, see here:
>
> https://lore.kernel.org/all/GQUnKz2al3yke5mB2i1kp3SzNHjK8vi6KJEh7rnLrOQ24=
OrlljeCyeWveLW9pICEmB9Qc8PKdNt3w1t_g3-Uvxq1l8Wj67PpoMeWDoH8PKk=3D@proton.me=
/
>
> Quoting a part of it:
>
> ```
> Linux 6.2 and newer are (mostly) unbootable on my old HP 6730b laptop,
> the 6.1.30 works still fine.
> The weirdest thing is that newer kernels (like 6.3.4 and 6.4-rc3) may
> boot ok on the first try, but when rebooting, the very same version
> doesn't boot.
>
> Some times, when trying to boot, I get this message repeated forever:
> ACPI Error: No handler or method for GPE [XX], disabling event
> (20221020/evgpe-839)
> On newer kernels, the date is 20230331 instead of 20221020. There is
> also some other error, but I can't read it as it gets overwritten by the
> other ACPI error, see image linked at the end.
>
> And some times, the screen will just stay completely blank.
>
> I tried booting with acpi=3Doff, but it does not help.
> ```
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
>
> #regzbot introduced e7b813b32a42a3a6281a4fd9ae7700a0257c1d50
