Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95DA3783BEC
	for <lists+stable@lfdr.de>; Tue, 22 Aug 2023 10:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbjHVIj5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+stable@lfdr.de>); Tue, 22 Aug 2023 04:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbjHVIj4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 22 Aug 2023 04:39:56 -0400
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B7019C;
        Tue, 22 Aug 2023 01:39:55 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-44d48168e2cso749129137.2;
        Tue, 22 Aug 2023 01:39:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692693594; x=1693298394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ffUMKIz9ZLdaXCPPtKWL3jgimu+Ma0fYS9zNnJUWmm8=;
        b=fdy3R3os0kgX36XlZsm3lhVlkOQZL30L+CGQYsljUhH7q6BWH/vfzznIIFrN+pMHeU
         jcAR9tJz1mXLA+nMCdCZSIi9HYIEb+SOW5edz6SoHY2JVfmcj4i4nY0kw6YCkz0Ipt6E
         Rx+3MmJ8LF7Mfvz23KQRPPTa5eftUdbDh6WKAsASZ0xZKNfLSA2g4zh8BVcnBV6XrB1s
         kkadG/55s/0qbS51/VL9FrePBTqy1dCUdSQzdbCstG+8KdWSTf1GringNVH1d+HyHlxK
         IRhvNgrzZYdpFf1hpp+gbWdOzRcGVyzbO2GYaA77xyVi6FSESD2vxDYjc8/FOkdLmAKq
         RV+A==
X-Gm-Message-State: AOJu0Yx8ShGCOrfuK41dWVTVTIa3hFyOunpHW+InpDDaTXq+CJeGqM3j
        6nOZvBttYsYIBaKeNUW7icRW5ouBjboGww==
X-Google-Smtp-Source: AGHT+IGgpfgoMkmg5I9ySgax7fR+rmDlspAMEf7ropcByzcKvErM4SgMrxr3gU2ccAA1ZrX4D3gO2A==
X-Received: by 2002:a67:d08a:0:b0:447:ad77:f034 with SMTP id s10-20020a67d08a000000b00447ad77f034mr7567719vsi.7.1692693593995;
        Tue, 22 Aug 2023 01:39:53 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id u184-20020a8147c1000000b005832ca42ba6sm2677321ywa.3.2023.08.22.01.39.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 01:39:53 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-d6fcffce486so4104362276.3;
        Tue, 22 Aug 2023 01:39:53 -0700 (PDT)
X-Received: by 2002:a5b:64a:0:b0:c47:56c9:a9bd with SMTP id
 o10-20020a5b064a000000b00c4756c9a9bdmr7427832ybq.6.1692693592514; Tue, 22 Aug
 2023 01:39:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230818234903.9226-1-schmitzmic@gmail.com> <20230818234903.9226-2-schmitzmic@gmail.com>
 <CAMuHMdUdqRZcwHnWCb0SJ34JM3BqEyejsgWajwsbe_F+6xZMjg@mail.gmail.com> <fd0b71fa-783e-41c0-ab2b-02656286d2ab@gmail.com>
In-Reply-To: <fd0b71fa-783e-41c0-ab2b-02656286d2ab@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 22 Aug 2023 10:39:40 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUokks=1Z9vDkzYdqTXEWyhT5WZk8w5FgmppZBeGP2nrg@mail.gmail.com>
Message-ID: <CAMuHMdUokks=1Z9vDkzYdqTXEWyhT5WZk8w5FgmppZBeGP2nrg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] ata: pata_falcon: fix IO base selection for Q40
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     dlemoal@kernel.org, linux-ide@vger.kernel.org,
        linux-m68k@vger.kernel.org, will@sowerbutts.com, rz@linux-m68k.org,
        stable@vger.kernel.org, Finn Thain <fthain@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Michael,

On Tue, Aug 22, 2023 at 10:27 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
> Am 21.08.2023 um 19:50 schrieb Geert Uytterhoeven:
> >> +       ap->ioaddr.data_addr = (void __iomem *)base_mem_res->start;
> >> +
> >> +       if (base_res) {         /* only Q40 has IO resources */
> >> +               io_offset = 0x10000;
> >> +               reg_scale = 1;
> >> +               base = (void __iomem *)base_res->start;
> >> +               ctl_base = (void __iomem *)ctl_res->start;
> >> +
> >> +               ata_port_desc(ap, "cmd %pa ctl %pa",
> >> +                             &base_res->start,
> >> +                             &ctl_res->start);
> >
> > This can be  moved outside the else, using %px to format base and
> > ctl_base.
>
> I get a checkpatch warning for %px, but not for %pa (used for .
> &ap->ioaddr.data_addr). What gives?
>
> WARNING: Using vsprintf specifier '%px' potentially exposes the kernel
> memory layout, if you don't really need the address please consider
> using '%p'.
> #148: FILE: drivers/ata/pata_falcon.c:194:
> +       ata_port_desc(ap, "cmd %px ctl %px data %pa",
> +                     base, ctl_base, &ap->ioaddr.data_addr);

You can ignore this.
%p prints obfuscated pointer values, so they are useless here.
%px prints an unobfuscated pointer value, which is fine here, as it's
not a pointer to kernel memory that an attacker can use, but just the
virtual address of an I/O device mapped one-to-one.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
