Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F040713BAD
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 20:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjE1Sfd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 14:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjE1Sfc (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 14:35:32 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60074AC
        for <stable@vger.kernel.org>; Sun, 28 May 2023 11:35:31 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-30ae967ef74so253019f8f.0
        for <stable@vger.kernel.org>; Sun, 28 May 2023 11:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685298929; x=1687890929;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GPap/tO9TOFWDZk3iHYhcAFPOGhziCRGFd79SRReniU=;
        b=PE/KhZg/HuUM4DThAfZqrg0MmqNQgN41OXYHIc5c31sgfqOnpJu5q7cR7aIa0Se95A
         s0zQrt/9YQd9/JDfLDWcTwh6nO7OLZKUtAdq9j76yyfwZSWMzb4C4mvdSRBeoB0QeWYF
         mGyAvU6GtY83sXXe+gM+c8SVec2Xish3Ao2ftbwzIFreKGBwvKOoMpFH4vyINJa4Q1gF
         D6S1/VKCvD5ku8VeBPVE9NQB3YzxqmnmdInnbxzi9BaYLZB4/nN1bho9q6BUwEm4vs3I
         cvR5YoouDc1vuQr0aRJN/JCP0dtHL/oDOheQ+0H3E5RXJotha+ZuI+H1Mul+YL12D373
         nBwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685298929; x=1687890929;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GPap/tO9TOFWDZk3iHYhcAFPOGhziCRGFd79SRReniU=;
        b=SuAV6sAmwQSh+HNwikrCMfTSUG5ZUi2XOfzYT/EE6fnqJs3Zvd9mouzWLK+LM6jXDz
         MscN4BaRMXfohrIqbFDT4SoQcNBoqW6ca6g8EXqKeEabPCe2UYl7LwCFC4V76L6Zm8/5
         wDZLYRA6aIO2e6bRQoaSVF5EF6NktaVeI1rzCg9sxggwXw2N+pXVrqCDdv/e3JAxtA9M
         q8aFx4mxa24Xvqi+idiZ7PWpyCPY+39yKes1Nqn+qhBh7ZB2eCWMe2mQpNZ+JE3Gg8oq
         AEOKMJSHE7M9vqa1QLm+WYGTVEvhgRd0k+R+D0a1Eah7f/ZpGfag4OakYjHuaKSo5l1K
         WFEg==
X-Gm-Message-State: AC+VfDzuM6BKiX5n21S0WFs9D/WImIXOVov8Or8MvE9Skxie8HaPNel5
        CafCuirlTMwj1yCCdiMsKu9o6UqQ9G2Kmj0iKotu+Lvx
X-Google-Smtp-Source: ACHHUZ4PwjVmfPJsmTZmUCCVTd/Rclr57y3fGJJiM3tqqighyosQCfRqC4Al3BhftvZurwgMx5UYpAc0hImZdtqbJag=
X-Received: by 2002:adf:f702:0:b0:2ee:f77f:3d02 with SMTP id
 r2-20020adff702000000b002eef77f3d02mr7552905wrp.0.1685298929393; Sun, 28 May
 2023 11:35:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAG7aomXv2KV9es2RiGwguesRnUTda-XzmeE42m0=GdpJ2qMOcg@mail.gmail.com>
 <ZHKW5NeabmfhgLbY@debian.me> <261a70b7-a425-faed-8cd5-7fbf807bdef7@amd.com> <CAG7aomVVJyDpKjpZ=k=+9qKY5+13eFjcGPEWZ0T0+NTNfZWDfA@mail.gmail.com>
In-Reply-To: <CAG7aomVVJyDpKjpZ=k=+9qKY5+13eFjcGPEWZ0T0+NTNfZWDfA@mail.gmail.com>
From:   beld zhang <beldzhang@gmail.com>
Date:   Sun, 28 May 2023 14:35:18 -0400
Message-ID: <CAG7aomXP0JHmHytsv5cMsyHzee61BQnG3fc-Y+NLzum7H3DyHA@mail.gmail.com>
Subject: Fwd: 6.1.30: thunderbolt: Clear registers properly when auto clear
 isn't in use cause call trace after resume
To:     stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

---------- Forwarded message ---------
From: beld zhang
Date: Sun, May 28, 2023 at 2:07=E2=80=AFPM
Subject: Re: 6.1.30: thunderbolt: Clear registers properly when auto
clear isn't in use cause call trace after resume
To: Mario Limonciello

On Sun, May 28, 2023 at 8:55=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> This is specific resuming from s2idle, doesn't happen at boot?
>
> Does it happen with hot-plugging or hot-unplugging a TBT3 or USB4 dock to=
o?
>
> In addition to checking mainline, can you please attach a full dmesg to
> somewhere ephemeral like a kernel bugzilla with thunderbolt.dyndbg=3D'+p'
> on the kernel command line set?
>

6.4-rc4:
    *) test 1~4 was done with usb hub with ethernet plugged-in
        model: UE330, usb 3.0 3-port hub & GIgabit Ether adapter
        a rapoo wireless mouse in one of the ports
    1) no crash at boot
        until [169.099024]
    2) no crash after plug an extra usb dock
        from [297.004691]
    3) no crash after remove it
        from [373.273511]
    4) crash after suspend/resume: 2 call-stacks
        from [438.356253]
    5) removed that hub(only ac-power left): NO crash after resume
        from [551.820333]
    6) plug in the hub(no mouse): NO crash after resume
        from [1250.256607]
    7) put on mouse: CRASH after resume
        from [1311.400963]
        mouse model: Rapoo Wireless Optical Mouse 1620

sorry I have no idea how to fill a proper bug report at kernel
bugzilla, hope these shared links work.
btw I have no TB devices to test.

dmesg:
https://drive.google.com/file/d/1bUWnV7q2ziM4tdTzmuGiVuvEzaLcdfKm/view?usp=
=3Dsharing

config:
https://drive.google.com/file/d/1It75_AV5tOzfkXXBAX5zAiZMoeJAe0Au/view?usp=
=3Dsharing
