Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2A0789C1D
	for <lists+stable@lfdr.de>; Sun, 27 Aug 2023 10:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjH0IYA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 27 Aug 2023 04:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjH0IXu (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 27 Aug 2023 04:23:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F12114
        for <stable@vger.kernel.org>; Sun, 27 Aug 2023 01:23:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2D1761E4C
        for <stable@vger.kernel.org>; Sun, 27 Aug 2023 08:23:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2518CC433C9
        for <stable@vger.kernel.org>; Sun, 27 Aug 2023 08:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693124627;
        bh=6+LiG74otFot+o7poNVJpXp4RQsrsiD5IQel7qvcHY4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EODiJj63dKfO5meIEVvJR2Nz8eyAf3Wd7hcNX/T34vjPomgDaJmk2Dprd1h5Ytw0g
         6whXp5SbORWinlcj+4Dx9nxAty7fvj/zd15DkjJg5qUkvA6yFIbxLNvs431pnoHgND
         3PICI7OLn8Ng3k6/Kb2iR20krKXuqRF1I35I3vNldZofkHetCr8/fW0R9tOlfDjTq7
         evv6Sbh38VVFhowkMKO0jIVxvKVzoRwkQR9GjG0SkDJhe+Upuf7VPRS7yJCxV7PLij
         onP/nJCQ2A0ZivzKXq8OiRgDBnxiqfGujkhvWP1acU3rCMqqny/DMZS9KvCk/X0kmo
         ewxa8b+az+i7g==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-52a5c0d949eso1045695a12.0
        for <stable@vger.kernel.org>; Sun, 27 Aug 2023 01:23:47 -0700 (PDT)
X-Gm-Message-State: AOJu0YxLr9XpwKukFBpYzSJIUZbCH4zw9qNe+X0Xj8Gk4rnR/bptCoYi
        BxGEuusftOk+67bIFRQpbRrmsD3rS0VlRgIWOik=
X-Google-Smtp-Source: AGHT+IHt1g5P6kUEfYEigKvahpDxqX5hmiIHvLQTs6t/cgDlmUR2l35SF1t+Azb+E0ZaScBkHat6Ju8zxR8Yk+SqhzM=
X-Received: by 2002:aa7:d481:0:b0:525:7da6:be26 with SMTP id
 b1-20020aa7d481000000b005257da6be26mr18606368edr.28.1693124625366; Sun, 27
 Aug 2023 01:23:45 -0700 (PDT)
MIME-Version: 1.0
References: <2023082705-predator-enjoyable-15fb@gregkh>
In-Reply-To: <2023082705-predator-enjoyable-15fb@gregkh>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sun, 27 Aug 2023 16:23:35 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5WYTGSvkz6tgZZud7gUOYyQGUXgSY_7ipe_0BGkz=YeQ@mail.gmail.com>
Message-ID: <CAAhV-H5WYTGSvkz6tgZZud7gUOYyQGUXgSY_7ipe_0BGkz=YeQ@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] LoongArch: Ensure FP/SIMD registers in the
 core dump file is" failed to apply to 6.4-stable tree
To:     gregkh@linuxfoundation.org
Cc:     chenhuacai@loongson.cn, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, Aug 27, 2023 at 2:45=E2=80=AFPM <gregkh@linuxfoundation.org> wrote:
>
>
> The patch below does not apply to the 6.4-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>
> To reproduce the conflict and resubmit, you may use the following command=
s:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.gi=
t/ linux-6.4.y
> git checkout FETCH_HEAD
> git cherry-pick -x 656f9aec07dba7c61d469727494a5d1b18d0bef4
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023082705-=
predator-enjoyable-15fb@gregkh' --subject-prefix 'PATCH 6.4.y' HEAD^..
>
> Possible dependencies:
I'm sorry, this is my mistake. 6.4 also need to cut the simd_get()
part, because simd is only supported since 6.5

Huacai

>
>
>
> thanks,
>
> greg k-h
>
> ------------------ original commit in Linus's tree ------------------
>
> From 656f9aec07dba7c61d469727494a5d1b18d0bef4 Mon Sep 17 00:00:00 2001
> From: Huacai Chen <chenhuacai@kernel.org>
> Date: Sat, 26 Aug 2023 22:21:57 +0800
> Subject: [PATCH] LoongArch: Ensure FP/SIMD registers in the core dump fil=
e is
>  up to date
>
> This is a port of commit 379eb01c21795edb4c ("riscv: Ensure the value
> of FP registers in the core dump file is up to date").
>
> The values of FP/SIMD registers in the core dump file come from the
> thread.fpu. However, kernel saves the FP/SIMD registers only before
> scheduling out the process. If no process switch happens during the
> exception handling, kernel will not have a chance to save the latest
> values of FP/SIMD registers. So it may cause their values in the core
> dump file incorrect. To solve this problem, force fpr_get()/simd_get()
> to save the FP/SIMD registers into the thread.fpu if the target task
> equals the current task.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>
> diff --git a/arch/loongarch/include/asm/fpu.h b/arch/loongarch/include/as=
m/fpu.h
> index b541f6248837..c2d8962fda00 100644
> --- a/arch/loongarch/include/asm/fpu.h
> +++ b/arch/loongarch/include/asm/fpu.h
> @@ -173,16 +173,30 @@ static inline void restore_fp(struct task_struct *t=
sk)
>                 _restore_fp(&tsk->thread.fpu);
>  }
>
> -static inline union fpureg *get_fpu_regs(struct task_struct *tsk)
> +static inline void save_fpu_regs(struct task_struct *tsk)
>  {
> +       unsigned int euen;
> +
>         if (tsk =3D=3D current) {
>                 preempt_disable();
> -               if (is_fpu_owner())
> +
> +               euen =3D csr_read32(LOONGARCH_CSR_EUEN);
> +
> +#ifdef CONFIG_CPU_HAS_LASX
> +               if (euen & CSR_EUEN_LASXEN)
> +                       _save_lasx(&current->thread.fpu);
> +               else
> +#endif
> +#ifdef CONFIG_CPU_HAS_LSX
> +               if (euen & CSR_EUEN_LSXEN)
> +                       _save_lsx(&current->thread.fpu);
> +               else
> +#endif
> +               if (euen & CSR_EUEN_FPEN)
>                         _save_fp(&current->thread.fpu);
> +
>                 preempt_enable();
>         }
> -
> -       return tsk->thread.fpu.fpr;
>  }
>
>  static inline int is_simd_owner(void)
> diff --git a/arch/loongarch/kernel/ptrace.c b/arch/loongarch/kernel/ptrac=
e.c
> index a0767c3a0f0a..f72adbf530c6 100644
> --- a/arch/loongarch/kernel/ptrace.c
> +++ b/arch/loongarch/kernel/ptrace.c
> @@ -147,6 +147,8 @@ static int fpr_get(struct task_struct *target,
>  {
>         int r;
>
> +       save_fpu_regs(target);
> +
>         if (sizeof(target->thread.fpu.fpr[0]) =3D=3D sizeof(elf_fpreg_t))
>                 r =3D gfpr_get(target, &to);
>         else
> @@ -278,6 +280,8 @@ static int simd_get(struct task_struct *target,
>  {
>         const unsigned int wr_size =3D NUM_FPU_REGS * regset->size;
>
> +       save_fpu_regs(target);
> +
>         if (!tsk_used_math(target)) {
>                 /* The task hasn't used FP or LSX, fill with 0xff */
>                 copy_pad_fprs(target, regset, &to, 0);
>
