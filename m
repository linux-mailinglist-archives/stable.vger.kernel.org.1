Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7324071547E
	for <lists+stable@lfdr.de>; Tue, 30 May 2023 06:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjE3E1h (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 30 May 2023 00:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjE3E1h (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 30 May 2023 00:27:37 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86DAE3
        for <stable@vger.kernel.org>; Mon, 29 May 2023 21:27:35 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f623adec61so41417625e9.0
        for <stable@vger.kernel.org>; Mon, 29 May 2023 21:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685420854; x=1688012854;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6HLdM2o7B/gixdFJLAM42DdKrClj8wpMrvon4kgOALM=;
        b=ejR21VrKI43KJyrud3drgIdcSmbKP4Hvybdd8wsuLePAhVmAskAs92qJb9jnIoUeuI
         HsNG6TzwxoMxj/OJmqMZXkYWzbZGiZwci9ToySuXw3k5H+daQ4A315olcEkqohPYAcnd
         hiSULYt2uKFH5cswgTHXtGRpm0/ZXI/m4bLsMI/8/dwSmDipn0pgu1dt/455PD397ixG
         hH4ti1EjRNNVU+6E89+SnwKbpsPfWg2iXVqQ/I//HGZh/PlitnipyvINVVBL/1QEf0Ey
         K2twTNjFQVylB1eo1w8Ucy7IgWfeVnQU4OGvbRYG6BTryUwXIbU9ED5z2VxsXy759nXq
         sEkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685420854; x=1688012854;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6HLdM2o7B/gixdFJLAM42DdKrClj8wpMrvon4kgOALM=;
        b=MRgXgMH11c1OrWUHMnoDLQuBx6l1YGKTczDttvsVl1I73//4QlgJAb9XSeGU8PU8G7
         pnbIMNEsA3NyOTw4RO9xKhQxQPNC/7+IbUay45GXRBOjfJIT5mni7sWupFYz9+jORCJI
         umHexY0dghPPSwEc7zTf+IP4JoVoCVhLZJKmavJf3D/Rodfiff5IrmozohVL9H62pN0W
         7dHdv6AzjsbIIoTAuVBsP92BYJUwmTkLXOBnFgJMR8untUtnlOpJR2JMfJ9fYOiPAHWI
         qMfsy+EU3DPITc4MCD7/aF7rtOeJ/A9NS+FlbZyfI0MPWttGogCDNQoEGsx2XZ598D+V
         l6QA==
X-Gm-Message-State: AC+VfDzABadJ+EF2e+a1xWKUGXJS3LrA5n3AdcRVNXa+U4nDE60W09gT
        HOfKqdIiG98CuQF1XfHFYZzRuwLLhN/Fk3c4ZQR6diYc
X-Google-Smtp-Source: ACHHUZ4+DRCHQ1eqHMu1RQ3AhU0yBZAXra6i+FjoqlCWxQQ0N04XwkEw1GNh5wxsVcOG+avbmES08wpyDd18tPf41ME=
X-Received: by 2002:adf:e749:0:b0:309:4368:a8a0 with SMTP id
 c9-20020adfe749000000b003094368a8a0mr466541wrn.68.1685420853974; Mon, 29 May
 2023 21:27:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAG7aomXv2KV9es2RiGwguesRnUTda-XzmeE42m0=GdpJ2qMOcg@mail.gmail.com>
 <ZHKW5NeabmfhgLbY@debian.me> <261a70b7-a425-faed-8cd5-7fbf807bdef7@amd.com>
 <20230529113813.GZ45886@black.fi.intel.com> <e37b2f7f-d204-4204-ce72-e108975c2fe0@amd.com>
In-Reply-To: <e37b2f7f-d204-4204-ce72-e108975c2fe0@amd.com>
From:   beld zhang <beldzhang@gmail.com>
Date:   Tue, 30 May 2023 00:27:22 -0400
Message-ID: <CAG7aomWsZAfHNCg9jS2P_dWjTh2O6Umx71rG7Xri+ZvpHw8+jQ@mail.gmail.com>
Subject: Re: 6.1.30: thunderbolt: Clear registers properly when auto clear
 isn't in use cause call trace after resume
To:     Mario Limonciello <mario.limonciello@amd.com>,
        stable@vger.kernel.org
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

test passed both 6.1.30 and 6.4-rc4
comments at bugzilla.

On Tue, May 30, 2023 at 12:12=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 5/29/23 06:38, Mika Westerberg wrote:
> > On Sun, May 28, 2023 at 07:55:39AM -0500, Mario Limonciello wrote:
> >> On 5/27/23 18:48, Bagas Sanjaya wrote:
> >>> On Sat, May 27, 2023 at 04:15:51PM -0400, beld zhang wrote:
> >>>> Upgrade to 6.1.30, got crash message after resume, but looks still
> >>>> running normally
> >>
> >> This is specific resuming from s2idle, doesn't happen at boot?
> >>
> >> Does it happen with hot-plugging or hot-unplugging a TBT3 or USB4 dock=
 too?
> >
> > Happens also when device is connected and do
> >
> >    # rmmod thunderbolt
> >    # modprobe thunderbolt
> >
> > I think it is because nhi_mask_interrupt() does not mask interrupt on
> > Intel now.
> >
> > Can you try the patch below? I'm unable to try myself because my test
> > system has some booting issues at the moment.
> >
> > diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
> > index 4c9f2811d20d..a11650da40f9 100644
> > --- a/drivers/thunderbolt/nhi.c
> > +++ b/drivers/thunderbolt/nhi.c
> > @@ -60,9 +60,12 @@ static int ring_interrupt_index(const struct tb_ring=
 *ring)
> >
> >   static void nhi_mask_interrupt(struct tb_nhi *nhi, int mask, int ring=
)
> >   {
> > -     if (nhi->quirks & QUIRK_AUTO_CLEAR_INT)
> > -             return;
> > -     iowrite32(mask, nhi->iobase + REG_RING_INTERRUPT_MASK_CLEAR_BASE =
+ ring);
> > +     if (nhi->quirks & QUIRK_AUTO_CLEAR_INT) {
> > +             u32 val =3D ioread32(nhi->iobase + REG_RING_INTERRUPT_BAS=
E + ring);
> > +             iowrite32(val & ~mask, nhi->iobase + REG_RING_INTERRUPT_B=
ASE + ring);
> > +     } else {
> > +             iowrite32(mask, nhi->iobase + REG_RING_INTERRUPT_MASK_CLE=
AR_BASE + ring);
> > +     }
> >   }
> >
> >   static void nhi_clear_interrupt(struct tb_nhi *nhi, int ring)
>
> Mika, that looks good for the issue, thanks!
>
> You can add:
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
>
> When you submit it.
