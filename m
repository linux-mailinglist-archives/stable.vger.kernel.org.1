Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD94714F6D
	for <lists+stable@lfdr.de>; Mon, 29 May 2023 20:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjE2SlA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 29 May 2023 14:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjE2Sk7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 29 May 2023 14:40:59 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E24C4
        for <stable@vger.kernel.org>; Mon, 29 May 2023 11:40:58 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-30aa76048fbso2223819f8f.2
        for <stable@vger.kernel.org>; Mon, 29 May 2023 11:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685385657; x=1687977657;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xlTWDl3bXyu48UOGK7lqiXY0SDnRZzLpSn02oJ8OGfQ=;
        b=bgMGcmhdZd7DQkgKBiPy/ADq7A2wsVngaSBSVSWcYXAX06nMc+KOSe5LJ422s8lTbq
         lUzBB4+AvTbcTfmEdEShEAXU7+Ok0XU+iVmcs2ddTC9ObZZDYOpSsxeMeZ1Qc9Im9xTJ
         HO5ebs1EatdTy0f0ZoIVwcTNaoCBPlUY10NxE1987+A1NyqKlfZhZxXWk85cYP4UB3PO
         ENd7lyApzmyDhbOszlgMCMeS9VozpEqLlrBDh8Xnt2tgRwzlvJjcMuTsc4mcVYoT230t
         euqa5utnjQm39T4WVOZZYbS0GUKWTbGVaCGeuZUqRAdIZS7JscDnPsYqC3WHrRWDQf6U
         Wexw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685385657; x=1687977657;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xlTWDl3bXyu48UOGK7lqiXY0SDnRZzLpSn02oJ8OGfQ=;
        b=RSGS1h8PUWvFcwrlVZqB3TngfbP2zcC/G9JsLjpJ082+DNAY75i3AXjTg9Ppv3rd2n
         S2qPACabFo6bLf10mqpgSN4/THAGfTZG6ixb+dARwQyb1I4/GbejL4OYy7EmsSzJvIYC
         cMtOcyO5wGYpRX+pbp4PE6Z0oWkB8vZBPIexFTa1+UZ3xB7qFYtuuCFgQHtQ2zCmq/sE
         +FOSYNnhXfwM3er93VhVQvteuUVLnLHta64GoDStoH4ArjCOsxdEm0nmV9jzrZxkZDa2
         QSpCQz4MkaBsK1hWD9Ps3j5MuQUvWk6edApdG7FHtqVt2QTRvwgJrXpvmOWYweuq2svw
         /Htw==
X-Gm-Message-State: AC+VfDwQlsb9OZ1TPxZSduivy3yMINZXJ4MY9zEcitZrjsF7qOkhI01Z
        EqpPMcLOyoYgLu1O51zG4t+w5xr92wKk5YeRqOqllF1d
X-Google-Smtp-Source: ACHHUZ7UR+LBEoh7iY8zxtDNSFe6wNs6YOCUzJkowL7bgnJuUhWDPc9akOznxMUy3rXPwSpIqrQEzi40k4qdTKjrwBk=
X-Received: by 2002:adf:e2ce:0:b0:307:c0c4:109a with SMTP id
 d14-20020adfe2ce000000b00307c0c4109amr10051714wrj.6.1685385656982; Mon, 29
 May 2023 11:40:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAG7aomXv2KV9es2RiGwguesRnUTda-XzmeE42m0=GdpJ2qMOcg@mail.gmail.com>
 <ZHKW5NeabmfhgLbY@debian.me> <261a70b7-a425-faed-8cd5-7fbf807bdef7@amd.com> <20230529113813.GZ45886@black.fi.intel.com>
In-Reply-To: <20230529113813.GZ45886@black.fi.intel.com>
From:   beld zhang <beldzhang@gmail.com>
Date:   Mon, 29 May 2023 14:40:26 -0400
Message-ID: <CAG7aomVpsyOktPFNAURYF9o32CnZST=49BPBRDRH2w7raLbQ7g@mail.gmail.com>
Subject: Re: 6.1.30: thunderbolt: Clear registers properly when auto clear
 isn't in use cause call trace after resume
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
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

both
# rmmod thunderbolt
# modprobe thunderbolt
makes many crash logs on my hardware.

try to patch this to 6.1.30 and 6.4-rc4 but are all failed.

how about continue this on the kernel bugzilla, and post a patch here
after it is resolved as Greg said ?


On Mon, May 29, 2023 at 7:38=E2=80=AFAM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Sun, May 28, 2023 at 07:55:39AM -0500, Mario Limonciello wrote:
> > On 5/27/23 18:48, Bagas Sanjaya wrote:
> > > On Sat, May 27, 2023 at 04:15:51PM -0400, beld zhang wrote:
> > > > Upgrade to 6.1.30, got crash message after resume, but looks still
> > > > running normally
> >
> > This is specific resuming from s2idle, doesn't happen at boot?
> >
> > Does it happen with hot-plugging or hot-unplugging a TBT3 or USB4 dock =
too?
>
> Happens also when device is connected and do
>
>   # rmmod thunderbolt
>   # modprobe thunderbolt
>
> I think it is because nhi_mask_interrupt() does not mask interrupt on
> Intel now.
>
> Can you try the patch below? I'm unable to try myself because my test
> system has some booting issues at the moment.
>
> diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
> index 4c9f2811d20d..a11650da40f9 100644
> --- a/drivers/thunderbolt/nhi.c
> +++ b/drivers/thunderbolt/nhi.c
> @@ -60,9 +60,12 @@ static int ring_interrupt_index(const struct tb_ring *=
ring)
>
>  static void nhi_mask_interrupt(struct tb_nhi *nhi, int mask, int ring)
>  {
> -       if (nhi->quirks & QUIRK_AUTO_CLEAR_INT)
> -               return;
> -       iowrite32(mask, nhi->iobase + REG_RING_INTERRUPT_MASK_CLEAR_BASE =
+ ring);
> +       if (nhi->quirks & QUIRK_AUTO_CLEAR_INT) {
> +               u32 val =3D ioread32(nhi->iobase + REG_RING_INTERRUPT_BAS=
E + ring);
> +               iowrite32(val & ~mask, nhi->iobase + REG_RING_INTERRUPT_B=
ASE + ring);
> +       } else {
> +               iowrite32(mask, nhi->iobase + REG_RING_INTERRUPT_MASK_CLE=
AR_BASE + ring);
> +       }
>  }
>
>  static void nhi_clear_interrupt(struct tb_nhi *nhi, int ring)
