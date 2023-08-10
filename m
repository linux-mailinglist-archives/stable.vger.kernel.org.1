Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A7F777C1E
	for <lists+stable@lfdr.de>; Thu, 10 Aug 2023 17:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236098AbjHJP0d (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 10 Aug 2023 11:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236032AbjHJP0d (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 10 Aug 2023 11:26:33 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14C826B6
        for <stable@vger.kernel.org>; Thu, 10 Aug 2023 08:26:32 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-2685bcd046eso600163a91.3
        for <stable@vger.kernel.org>; Thu, 10 Aug 2023 08:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691681191; x=1692285991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4iFOjbhlpDEoOd7aM1ql5J2UbSjoE4+yRevM56Z8Aw=;
        b=Y7+O9GhshaM8GKnAHJZhLOX+SqpQ/zcdEgpbbUG1ZOvDUdQhHwZtR3mAygCEzt9ELl
         BjxATYkJSTHsiErGyEulLfy8SXxvhZxcVMBHoYzJF+Z0nnq3vOYkIToqUt6dcPh/WDsp
         5qXEycgP39i32xPQ4D+wG6np6YJu2cbVVhH9rpE6nqQVwg7aeb7yNfiHeTbc00srlM31
         LMvRTkGx4k0nl98G/p102jMrPMpK4oj77D7VweRAbIrwfVh8kAEXqtkBySgHMIMF7Tht
         z0c8M7By3+E01CfffPCOVGR/UrE+/GWGSqXP6JPcZCvbQ0enCX7RpX/aqI05ggVcz0bq
         jn5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691681191; x=1692285991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p4iFOjbhlpDEoOd7aM1ql5J2UbSjoE4+yRevM56Z8Aw=;
        b=YKWZZtlPA896RjFUtLiFRfIHWco3BDTsdjKoDWQbzFUd0NQf0C3DOPRqhdEOyQPAWQ
         LVZ8xAJkjXV4PJL9AX6mi9sK0Q/coxCEfrn8JrrE6p7nH3iWhru38re+Zw1+MMSX6eIz
         ccrQKHNMp7lsrln7O1AoGmQ3WPkpin+gT7HAZ1cie1/w3Z62CjitY4NpLYc4snN3QbI/
         4dkwz5bDcf1w+EacYf+YQFsBrpV3f9UMkBjhwJHP0EzYgthd5EaWNHko4liakU1alM3n
         1yolIs6stl2hj+m7jg1G0iWCOP5ZCI7h+KWGrshd4qsTB3cC3FfuE9VdwLUB0JVIDM56
         yHrg==
X-Gm-Message-State: AOJu0YzR15FP0XmgfT5Qh1iGKSmHFEF9ehOUI1PWGs4C6q6GySdK7qi0
        8Wqmpd/t03Pu87EcUYMW+OoO0Yjew+FY/RliR4Lr5X2JGy4WQw==
X-Google-Smtp-Source: AGHT+IEFbD7yDYExmhc0uHNK/MoCkav6WZGCH0HtPokKRgrVPQUqh6zM4l0iqfHIAhqZPxSZfdvFU/K6ELC80A5Ykbo=
X-Received: by 2002:a17:90a:9512:b0:268:5d00:3751 with SMTP id
 t18-20020a17090a951200b002685d003751mr2174275pjo.10.1691681191456; Thu, 10
 Aug 2023 08:26:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAPXMrf9Q7JGCwEnCKM8i0wi3oY9VH2V0fDYX_+6U9jfjzPeZ8Q@mail.gmail.com>
 <ZNTx5TXekM/szrmR@quatroqueijos.cascardo.eti.br>
In-Reply-To: <ZNTx5TXekM/szrmR@quatroqueijos.cascardo.eti.br>
From:   RAJESH DASARI <raajeshdasari@gmail.com>
Date:   Thu, 10 Aug 2023 18:26:20 +0300
Message-ID: <CAPXMrf-Ztbj5X=EQan6Jsq__pbnWgdn7SzFN48zYc424scgXbg@mail.gmail.com>
Subject: Re: WARNING: CPU: 0 PID: 0 at arch/x86/kernel/fpu/xstate.c in 5.4.252 kernel
To:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Cc:     stable@vger.kernel.org, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Thanks,
Rajesh Dasari.


On Thu, Aug 10, 2023 at 5:19=E2=80=AFPM Thadeu Lima de Souza Cascardo
<cascardo@canonical.com> wrote:
>
> On Thu, Aug 10, 2023 at 12:58:53PM +0300, RAJESH DASARI wrote:
> > Hi ,
> >
> > We are noticing the below warning in the latest 5.4.252 kernel bootup l=
ogs.
> >
> > WARNING: CPU: 0 PID: 0 at arch/x86/kernel/fpu/xstate.c:878
> > get_xsave_addr+0x83/0x90
> >
> > and relevant call trace in the logs , after updating to kernel 5.4.252.
> >
> > I see that issue is due to this commit
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit=
/?h=3Dv5.4.252&id=3D6e60443668978131a442df485db3deccb31d5651
> >
> > This is seen in the qemu instance  which  is emulating the host cpu
> > and was deployed on Intel(R) Xeon(R) Gold 5218 processor.
> >
> > I revert the commit and there is no WARNING and call trace in the logs
> > , Is this issue already reported and a fix is available? Could you
> > please provide your inputs.
> >
> > Regards,
> > Rajesh.
>
> Does applying b3607269ff57 ("x86/pkeys: Revert a5eff7259790 ("x86/pkeys:
> Add PKRU value to init_fpstate")") fixes it for you?
>
Thanks for the quick response. Yes this patch works, WARNING is not
seen now.  any plans to backport this patch to 5.4.x kernel releases?

> Cascardo.
