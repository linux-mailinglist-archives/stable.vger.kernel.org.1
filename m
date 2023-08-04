Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4D577000A
	for <lists+stable@lfdr.de>; Fri,  4 Aug 2023 14:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjHDMQa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 4 Aug 2023 08:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjHDMQ3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 4 Aug 2023 08:16:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5977546A6
        for <stable@vger.kernel.org>; Fri,  4 Aug 2023 05:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691151344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iifFgJWlEJ/tR+OujI8Y2TfWF+bx6PDIwYvuFmvjx8E=;
        b=hOa4T3BslQ2xQqaMcvn4fEntE3LEXhVmVgRVBDOdyERLZNdhlGCeKKihaC9WSHFzx//Iwn
        2eJETJCLtHARDBmJhcI6AtGSgQToeRiUJaIRm8nGw2bnfYpW9xZ0pKtg1jZ5vNYKU0GUaf
        jGL53Rw5i2iBvn5iWCmOUB5OfQBlbkI=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-lnPhjjStP_iCv6TP5QxhzQ-1; Fri, 04 Aug 2023 08:15:42 -0400
X-MC-Unique: lnPhjjStP_iCv6TP5QxhzQ-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2a7a6393ba6so4562521fa.1
        for <stable@vger.kernel.org>; Fri, 04 Aug 2023 05:15:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691151341; x=1691756141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iifFgJWlEJ/tR+OujI8Y2TfWF+bx6PDIwYvuFmvjx8E=;
        b=HYvi+xbn4JOw85pdBXHR9884/xLzwc+bNNYLTmN4gwO9/whrGcAZU6llYgUP2O7HvJ
         MUH9NUBgyubqC6V+1SztYd1SdcGV8FVhtXCJQphdy4/mWwrDsLmKEqvJ6HRFZXMOQ5Ng
         9a6gtNt5vj/cQCD44znH8jD8OmmESLbP3c7bbRad/qq2Oh2XOZTm7bVJoWAcKFuEHWuC
         OZRiusMvths/0THxvE/xNRRawPsOAnAbZS45TnyVdXEZ4uCva0T9v9VWU2iI69mCOR34
         GM3XnEA+LN380FzfNcZpCoujR25TLLMvHFO2/cs/qfW0WPapl9wiYAuT3rj0wwp1+ofc
         rvBw==
X-Gm-Message-State: ABy/qLbEXX11V0YJ3Lic/Nrl4VQx7KIh5a6dq18CYuCbQtoC/ZDJP3Fn
        WCNJgb0l7kjyGuVNJRcvgnNUinhzNsEXL9LIVpmOAks4jCNDT2kPTXObiSde2JqY3iLLhMC5VW0
        diZKy0mnRb+6pjVqAIM39Oc6Qe6cuPwK439wyIN2Cs8k=
X-Received: by 2002:a2e:bc13:0:b0:2b6:af68:6803 with SMTP id b19-20020a2ebc13000000b002b6af686803mr15501667ljf.4.1691151340759;
        Fri, 04 Aug 2023 05:15:40 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF5SVdiNkOzR43HfHpXWgsB7QQe4iqK1CZLGLKsmHdTGSgH5EDmZaORZ3VyZOGxA65bhGchzMQWssgOluwgvnI=
X-Received: by 2002:a2e:bc13:0:b0:2b6:af68:6803 with SMTP id
 b19-20020a2ebc13000000b002b6af686803mr15501646ljf.4.1691151340361; Fri, 04
 Aug 2023 05:15:40 -0700 (PDT)
MIME-Version: 1.0
References: <20be6650-5db3-b72a-a7a8-5e817113cff5@kravcenko.com> <c27fb4dd-b2dc-22de-4425-6c7db5f543ba@leemhuis.info>
In-Reply-To: <c27fb4dd-b2dc-22de-4425-6c7db5f543ba@leemhuis.info>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Fri, 4 Aug 2023 14:15:29 +0200
Message-ID: <CACO55ttcUEUjdVgx4y7pv26VAGeHS5q1wVKWrMw5=o9QLaJLZw@mail.gmail.com>
Subject: Re: nouveau bug in linux/6.1.38-2
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Olaf Skibbe <news@kravcenko.com>, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, 1042753@bugs.debian.org,
        Ben Skeggs <bskeggs@redhat.com>, Lyude Paul <lyude@redhat.com>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Aug 4, 2023 at 2:02=E2=80=AFPM Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> Hi!
>
> On 02.08.23 23:28, Olaf Skibbe wrote:
> > Dear Maintainers,
> >
> > Hereby I would like to report an apparent bug in the nouveau driver in
> > linux/6.1.38-2.
>
> Thx for your report. Maybe your problem is caused by a incomplete
> backport. I Cced the maintainers for the drivers (and the regressions
> and the stable list), maybe one of them has an idea, as they know the
> driver.
>
> If they don't reply in the next few days, please check if the problem is
> also present in mainline. If not, check if the latest 6.1.y. release
> already fixes this. If not, try to check which of the four patches you
> reverted to make things going is actually causing this (e.g. first only
> revert the one that was applied last; then the two last ones; ...).
>
> > Running a current debian stable on a Dell Latitude E6510 with a
> > "NVIDIA Corporation GT218M" graphic card, the monitor turns black
> > after the grub screen. Also switching to a console (Strg-Alt-F2) shows
> > just a black screen. Access via ssh is possible.
> >
> > ~# uname -r
> > 6.1.0-10-amd64
> >
> > demesg shows the following error message:
> >
> > [    3.560153] WARNING: CPU: 0 PID: 176 at
> > drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.c:460
> > nvkm_dp_acquire+0x26a/0x490 [nouveau]
> > [    3.560287] Modules linked in: sd_mod t10_pi sr_mod crc64_rocksoft
> > cdrom crc64 crc_t10dif crct10dif_generic nouveau(+) ahci libahci mxm_wm=
i
> > i2c_algo_bit drm_display_helper libata cec rc_core drm_ttm_helper ttm
> > scsi_mod e1000e drm_kms_helper ptp firewire_ohci sdhci_pci cqhci
> > ehci_pci sdhci ehci_hcd firewire_core i2c_i801 crct10dif_pclmul
> > crct10dif_common drm crc32_pclmul crc32c_intel psmouse usbcore mmc_core
> > crc_itu_t pps_core scsi_common i2c_smbus lpc_ich usb_common battery
> > video wmi button
> > [    3.560322] CPU: 0 PID: 176 Comm: kworker/u16:5 Not tainted
> > 6.1.0-10-amd64 #1  Debian 6.1.38-2
> > [    3.560325] Hardware name: Dell Inc. Latitude E6510/0N5KHN, BIOS A17
> > 05/12/2017
> > [    3.560327] Workqueue: nvkm-disp nv50_disp_super [nouveau]
> > [    3.560433] RIP: 0010:nvkm_dp_acquire+0x26a/0x490 [nouveau]
> > [    3.560538] Code: 48 8b 44 24 58 65 48 2b 04 25 28 00 00 00 0f 85 37
> > 02 00 00 48 83 c4 60 44 89 e0 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc
> > cc <0f> 0b c1 e8 03 41 88 6d 62 44 89 fe 48 89 df 48 69 c0 cf 0d d6 26
> > [    3.560541] RSP: 0018:ffff9899c048bd60 EFLAGS: 00010246
> > [    3.560542] RAX: 0000000000041eb0 RBX: ffff88e0209d2600 RCX:
> > 0000000000041eb0
> > [    3.560544] RDX: ffffffffc079f760 RSI: 0000000000000000 RDI:
> > ffff9899c048bcf0
> > [    3.560545] RBP: 0000000000000001 R08: ffff9899c048bc64 R09:
> > 0000000000005b76
> > [    3.560546] R10: 000000000000000d R11: ffff9899c048bde0 R12:
> > 00000000ffffffea
> > [    3.560548] R13: ffff88e00b39e480 R14: 0000000000044d45 R15:
> > 0000000000000000
> > [    3.560549] FS:  0000000000000000(0000) GS:ffff88e123c00000(0000)
> > knlGS:0000000000000000
> > [    3.560551] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [    3.560552] CR2: 00007f57f4e90451 CR3: 0000000181410000 CR4:
> > 00000000000006f0
> > [    3.560554] Call Trace:
> > [    3.560558]  <TASK>
> > [    3.560560]  ? __warn+0x7d/0xc0
> > [    3.560566]  ? nvkm_dp_acquire+0x26a/0x490 [nouveau]
> > [    3.560671]  ? report_bug+0xe6/0x170
> > [    3.560675]  ? handle_bug+0x41/0x70
> > [    3.560679]  ? exc_invalid_op+0x13/0x60
> > [    3.560681]  ? asm_exc_invalid_op+0x16/0x20
> > [    3.560685]  ? init_reset_begun+0x20/0x20 [nouveau]
> > [    3.560769]  ? nvkm_dp_acquire+0x26a/0x490 [nouveau]
> > [    3.560888]  nv50_disp_super_2_2+0x70/0x430 [nouveau]
> > [    3.560997]  nv50_disp_super+0x113/0x210 [nouveau]
> > [    3.561103]  process_one_work+0x1c7/0x380
> > [    3.561109]  worker_thread+0x4d/0x380
> > [    3.561113]  ? rescuer_thread+0x3a0/0x3a0
> > [    3.561116]  kthread+0xe9/0x110
> > [    3.561120]  ? kthread_complete_and_exit+0x20/0x20
> > [    3.561122]  ret_from_fork+0x22/0x30
> > [    3.561130]  </TASK>
> >
> > Further information:
> >
> > $ lspci -v -s $(lspci | grep -i vga | awk '{ print $1 }')
> > 01:00.0 VGA compatible controller: NVIDIA Corporation GT218M [NVS 3100M=
]
> > (rev a2) (prog-if 00 [VGA controller])
> >     Subsystem: Dell Latitude E6510
> >     Flags: bus master, fast devsel, latency 0, IRQ 27
> >     Memory at e2000000 (32-bit, non-prefetchable) [size=3D16M]
> >     Memory at d0000000 (64-bit, prefetchable) [size=3D256M]
> >     Memory at e0000000 (64-bit, prefetchable) [size=3D32M]
> >     I/O ports at 7000 [size=3D128]
> >     Expansion ROM at 000c0000 [disabled] [size=3D128K]
> >     Capabilities: <access denied>
> >     Kernel driver in use: nouveau
> >     Kernel modules: nouveau
> >
> > I reported this bug to debian already, see
> > https://bugs.debian.org/1042753 for context.
> >
> > With support (thanks Diederik!) I managed to figure out that the cause
> > was a regression between upstream kernel version 6.1.27 and 6.1.38.
> >
> > I build a new 6.1.38 kernel with these commits reverted:
> >
> > 62aecf23f3d1 drm/nouveau: add nv_encoder pointer check for NULL
> > fb725beca62d drm/nouveau/dp: check for NULL nv_connector->native_mode
> > 90748be0f4f3 drm/nouveau: don't detect DSM for non-NVIDIA device
> > 5a144bad3e75 nouveau: fix client work fence deletion race
> >

mind retrying with only fb725beca62d and 62aecf23f3d1 reverted? Would
be weird if the other two commits are causing it. If that's the case,
it's a bit worrying that reverting either of the those causes issues,
but maybe there is a good reason for it. Anyway, mind figuring out
which of the two you need reverted to fix your issue? Thanks!

> > With that kernel the graphic works again.
> >
> > Please inform me if further tests are required.
>
> FWIW, to be sure the issue doesn't fall through the cracks unnoticed,
> I'm adding it to regzbot, the Linux kernel regression tracking bot:
>
> #regzbot ^introduced v6.1.27..v6.1.38
> #regzbot title drm/nouveau: display stays black
> #regzbot ignore-activity
>
> This isn't a regression? This issue or a fix for it are already
> discussed somewhere else? It was fixed already? You want to clarify when
> the regression started to happen? Or point out I got the title or
> something else totally wrong? Then just reply and tell me -- ideally
> while also telling regzbot about it, as explained by the page listed in
> the footer of this mail.
>
> Developers: When fixing the issue, remember to add 'Link:' tags pointing
> to the report (the parent of this mail). See page linked in footer for
> details.
>
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> That page also explains what to do if mails like this annoy you.
>

