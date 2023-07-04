Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2BD37477EA
	for <lists+stable@lfdr.de>; Tue,  4 Jul 2023 19:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjGDRfP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 4 Jul 2023 13:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjGDRfO (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 4 Jul 2023 13:35:14 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663DC170D
        for <stable@vger.kernel.org>; Tue,  4 Jul 2023 10:34:56 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fbc0609cd6so58439995e9.1
        for <stable@vger.kernel.org>; Tue, 04 Jul 2023 10:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688492094; x=1691084094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3qJ64lF89VpbBy1ulIr9SZuXHSuhm2fS1ISkB9mGrhk=;
        b=UaNfZIHtqk8sEbad/eQ98L/1Xhl2t0Rk2Cg/sDrY56rhiua4m2qDFulF1/qLVjRl+S
         cKvYQ7uLAy5lu4t51ZX4buDN3G7HRRoHRzYeYqY3SMkVnx6TD1+UVZnRhrmxhQ61Q493
         +Or8Aijqk1dkK7CSdnUQ1vOR7Wh3zf4K7rSv9EmlxbtiBCk4J2FIJxt4rBWo9Zo96Exn
         yM5TdQuJNG3DazERTfy13G3Tk7f6vcCKSD7SqSonGaPU7vrvAWP7act/UC/JQXTLdKwA
         os9+ZDwZWt6eHP78vqaKcB7cqPXG0zTGfRuw1v6yl6U81iH3tcsxFcy8dg0dKeW4zs9a
         FYeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688492094; x=1691084094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3qJ64lF89VpbBy1ulIr9SZuXHSuhm2fS1ISkB9mGrhk=;
        b=Ln3R363xSibP/BJJXAv2GFfy4UFB9L8JZakCcBKLl1dvBM34PgsLAcoUUG8sLGRrte
         YmDXnqhCA3L/cBRT5KLZ2BT93nAid0kCv1Q38dI8JsrPRCGSa+tXESmjuEZr3wvweguB
         qsF+tsCND13Vd2YyLRTO1eUVUry/Yie5MRonV+W2BqXbz485UxJuvyaJdFhqdspgG0c1
         Z40HYzLsM0KOLwCJ2KKm6x6lkWy7qMm/l/6VfPCFH0cWeuJTwRoHWwn5QCbVnv3Z3Hwa
         jvb0aqyKfNZZBdOsUBOfw66dY0b5+G0KIqOs8A3lHiB1Zf+I3BpetnPajpFoRCiZGOX9
         bD+w==
X-Gm-Message-State: AC+VfDyJFpqZHPW+lzRSmfYjcE26LWFaOH0cckcZPae5QKZcG2d/rjnw
        w6KJGGshLn1tXPJQmCKNjuGJPA==
X-Google-Smtp-Source: ACHHUZ5jn9n9ZjzIR1LoKOiyjbakRHjBusBJI/fMlOmuJoqSwT0055ZXuMXIRChWey7suI30Cuw7cA==
X-Received: by 2002:a1c:4c10:0:b0:3fa:991c:2af9 with SMTP id z16-20020a1c4c10000000b003fa991c2af9mr10773167wmf.16.1688492094251;
        Tue, 04 Jul 2023 10:34:54 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id u16-20020a7bcb10000000b003fbb5142c4bsm17163518wmj.18.2023.07.04.10.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 10:34:53 -0700 (PDT)
Date:   Tue, 4 Jul 2023 18:34:51 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     guoren@kernel.org, arnd@arndb.de, palmer@rivosinc.com,
        tglx@linutronix.de, luto@kernel.org, conor.dooley@microchip.com,
        heiko@sntech.de, jszhang@kernel.org, lazyparser@gmail.com,
        falcon@tinylab.org, chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, mark.rutland@arm.com, bjorn@kernel.org,
        palmer@dabbelt.com, bjorn@rivosinc.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        stable@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH] riscv: entry: Fixup do_trap_break from kernel side
Message-ID: <20230704173451.GD385243@aspen.lan>
References: <20230702025708.784106-1-guoren@kernel.org>
 <20230704164003.GB83892@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704164003.GB83892@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Jul 04, 2023 at 06:40:03PM +0200, Peter Zijlstra wrote:
> On Sat, Jul 01, 2023 at 10:57:07PM -0400, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > The irqentry_nmi_enter/exit would force the current context into in_interrupt.
> > That would trigger the kernel to dead panic, but the kdb still needs "ebreak" to
> > debug the kernel.
> >
> > Move irqentry_nmi_enter/exit to exception_enter/exit could correct handle_break
> > of the kernel side.
>
> This doesn't explain much if anything :/
>
> I'm confused (probably because I don't know RISC-V very well), what's
> EBREAK and how does it happen?

Among other things ebreak is part of the BUG() macro (although it is
also used to programmatically enter kgdb).


> Specifically, if EBREAK can happen inside an local_irq_disable() region,
> then the below change is actively wrong. Any exception/interrupt that
> can happen while local_irq_disable() must be treated like an NMI.
>
> If that makes kdb unhappy, fix kdb.

The only relationship this problem has to kgdb/kdb is that is was found
using the kgdb test suite. However the panic is absolutely nothing to
do with kgdb.

I would never normally be so sure regarding the absence of bugs in kgdb
but in this case it can be reproduced when kgdb is not enabled in the
KConfig which I think puts it in the clear!

Reproduction is simply:

  /bin/echo BUG > /sys/kernel/debug/provoke-crash/DIRECT

Above will panic the kernel but, absent options specifically requesting
a panic, this should kill the echo process rather than killing the kernel.


Daniel.
