Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74CD071424A
	for <lists+stable@lfdr.de>; Mon, 29 May 2023 05:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjE2DXf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 23:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjE2DXe (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 23:23:34 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15D6AF
        for <stable@vger.kernel.org>; Sun, 28 May 2023 20:23:32 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-30aebe2602fso205418f8f.3
        for <stable@vger.kernel.org>; Sun, 28 May 2023 20:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685330611; x=1687922611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/bU4xzqZERuymMOzd57IF6EQ9Cms4/FYFMpBNExEM/o=;
        b=Xfbt9lzRh31learkqq20zsa2rQD8nozlputsqlibifocYIlet17oNP9xkRDyT2cklc
         OcSMc9104WWyPk3ERB9rg8SiE8HDC2AnZAWku5IdWNdt5Ton1puCZ3BMaHN0FEM2VPu2
         tLvIKvoYv5msDvUyTx0P04qLAYSSDgBeeXrESYRy0/PWpJ/yk1lIiy6PUfLSzDiKCW69
         zuvuNcki0chIJvIREPOUAboOKbyl8o5A5jhiprA3iJRdn5gNWC1gBS6MOlPzGVLksmbi
         KKe15Ri8XLRXdG2a9psJBktQGW7h/1mTQa/kPW/mF4g7oOLEj6s8MwqwQtC5jFTaTVds
         C51g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685330611; x=1687922611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/bU4xzqZERuymMOzd57IF6EQ9Cms4/FYFMpBNExEM/o=;
        b=gA3iF/6jFK343u3/qH1kdBWNZxV1C+nesYuSxmAjI9j3WSz+EmnttWq91DUFzb8u7b
         JtagDzkRAynSSsO5N/fetTIOOLjZPyaBYOR3VpnVHshW8bAogqGHhL/WLY+K01qju0Qh
         jH3k+Ge0hwtoIstlXMmzeQNUT8iiDOGdMAHaS+VEDjj25WPccxtMTbE5Qjyscu+sft8k
         TB1fEgbqCa3PB8C2Mqhv02KnmMyn7g5bJan2RmA9/bVBV7gIvkJnffAyX+hl8f2eGCuP
         FocBjHUCcwdFcC9ZpYXba3WVwLDtxGwxh4vtRNZpc76miGO3ITRV11LFJxMk1XIm5Yca
         H6uA==
X-Gm-Message-State: AC+VfDw36In/IZGTpvV01nczLuKykSgTMMNVjXeQPyUOMRCPnEHReH+P
        MWe4zpif72QNWY6S5O542Z3bE7JSXoTl/x1YW7QMT5CpuYQ=
X-Google-Smtp-Source: ACHHUZ6EhEzj+DBQzIesjpIyktjKpsRf4xGHPELpCPkqEU6xqxN6ice3XVm3og1TU9lNxUXDMFTyjI+GpDtlsgNmAqA=
X-Received: by 2002:adf:dfcc:0:b0:30a:dd15:bb69 with SMTP id
 q12-20020adfdfcc000000b0030add15bb69mr6783725wrn.18.1685330610856; Sun, 28
 May 2023 20:23:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAG7aomXv2KV9es2RiGwguesRnUTda-XzmeE42m0=GdpJ2qMOcg@mail.gmail.com>
 <ZHKW5NeabmfhgLbY@debian.me> <261a70b7-a425-faed-8cd5-7fbf807bdef7@amd.com>
 <CAG7aomVVJyDpKjpZ=k=+9qKY5+13eFjcGPEWZ0T0+NTNfZWDfA@mail.gmail.com>
 <CAG7aomXP0JHmHytsv5cMsyHzee61BQnG3fc-Y+NLzum7H3DyHA@mail.gmail.com> <ZHQMGN-LAJk6vHjH@debian.me>
In-Reply-To: <ZHQMGN-LAJk6vHjH@debian.me>
From:   beld zhang <beldzhang@gmail.com>
Date:   Sun, 28 May 2023 23:23:20 -0400
Message-ID: <CAG7aomWDnB6VCMCFoYh-Z9W1QPA52VAh3_mF4eg8up+TMQ8Low@mail.gmail.com>
Subject: Re: Fwd: 6.1.30: thunderbolt: Clear registers properly when auto
 clear isn't in use cause call trace after resume
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     stable@vger.kernel.org
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

rebuild with CONFIG_DYNAMIC_DEBUG=3Dy

testing result:
  1) power on without any device
   2) plug in usb-hub, NO crash
     [ 53.###]
   3) plug in mouse, NO crash, works ok
     [114.###]
   4) suspend/resume, CRASH, mouse still working, nic on hub working
     [176.###]

bug report created at:
  https://bugzilla.kernel.org/show_bug.cgi?id=3D217500

On Sun, May 28, 2023 at 10:21=E2=80=AFPM Bagas Sanjaya <bagasdotme@gmail.co=
m> wrote:
>
> On Sun, May 28, 2023 at 02:35:18PM -0400, beld zhang wrote:
> > ---------- Forwarded message ---------
> > From: beld zhang
> > Date: Sun, May 28, 2023 at 2:07=E2=80=AFPM
> > Subject: Re: 6.1.30: thunderbolt: Clear registers properly when auto
> > clear isn't in use cause call trace after resume
> > To: Mario Limonciello
> >
> > On Sun, May 28, 2023 at 8:55=E2=80=AFAM Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> > >
> > > This is specific resuming from s2idle, doesn't happen at boot?
> > >
> > > Does it happen with hot-plugging or hot-unplugging a TBT3 or USB4 doc=
k too?
> > >
> > > In addition to checking mainline, can you please attach a full dmesg =
to
> > > somewhere ephemeral like a kernel bugzilla with thunderbolt.dyndbg=3D=
'+p'
> > > on the kernel command line set?
> > >
> >
> > 6.4-rc4:
> >     *) test 1~4 was done with usb hub with ethernet plugged-in
> >         model: UE330, usb 3.0 3-port hub & GIgabit Ether adapter
> >         a rapoo wireless mouse in one of the ports
> >     1) no crash at boot
> >         until [169.099024]
> >     2) no crash after plug an extra usb dock
> >         from [297.004691]
> >     3) no crash after remove it
> >         from [373.273511]
> >     4) crash after suspend/resume: 2 call-stacks
> >         from [438.356253]
> >     5) removed that hub(only ac-power left): NO crash after resume
> >         from [551.820333]
> >     6) plug in the hub(no mouse): NO crash after resume
> >         from [1250.256607]
> >     7) put on mouse: CRASH after resume
> >         from [1311.400963]
> >         mouse model: Rapoo Wireless Optical Mouse 1620
>
> Before suspend, is attaching your mouse not crashing your system?
>
> >
> > sorry I have no idea how to fill a proper bug report at kernel
> > bugzilla, hope these shared links work.
> > btw I have no TB devices to test.
> >
> > dmesg:
> > https://drive.google.com/file/d/1bUWnV7q2ziM4tdTzmuGiVuvEzaLcdfKm/view?=
usp=3Dsharing
> >
> > config:
> > https://drive.google.com/file/d/1It75_AV5tOzfkXXBAX5zAiZMoeJAe0Au/view?=
usp=3Dsharing
>
> There is a functionality on Bugzilla to attach above files. Use it.
>
> Thanks.
>
> --
> An old man doll... just what I always wanted! - Clara
