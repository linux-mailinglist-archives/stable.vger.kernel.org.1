Return-Path: <stable+bounces-20617-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9185885A970
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 17:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E2B628646E
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 16:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19E241C89;
	Mon, 19 Feb 2024 16:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDHQ5Cs7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629E240BFD
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 16:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708361841; cv=none; b=n8JMsc3s4zuGwE6e1vQECHwrPhh/TD/CQiknNHqG7pFJ5H2M2OjERmsw45WAgdbLij7nHll0B3IvLd9gL4OB6wU04ZzTNhzbsYgOW26DlXmss9WsBDuqyWCmYHSed3u3oU+fipVQrLWSEF4ElhM5FlxARjfIGeHgqH6nX/4hkWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708361841; c=relaxed/simple;
	bh=HYZvq+u+R3YNuFfdlGg34LXOTzMLxiY67sI7VhMbtf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XIMD2vIQ7RitiUjy+kvTL2UiLMAITs+jcjwx/JvcfsWk+lj5eqSiGeHKk+iRmgrcqO6Hb9DeF6HXw+Vjv55LL2vVds3vNLC2RT0N2U7VkZBNrUkv8qvYJxs6Co5aBhb1qSk7sFlzxJXf2ipzyg6gVNrd9gK6ymxjlx7GMiIpO0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDHQ5Cs7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7645C43390
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 16:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708361840;
	bh=HYZvq+u+R3YNuFfdlGg34LXOTzMLxiY67sI7VhMbtf0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SDHQ5Cs7qq0+1LQrrYLy6Cok0JuVCjl+D/cIG86uOK0Ija/zMfpOYn3rIxplUk8Wv
	 PuKgfS5/FmvN0B63UwLIz/OSuYIni5skSDhDpMcQCbbPrCNiCSGLwEwO8pyu5yMcxl
	 fO7S7K1KnpkLywGAnLLX8/3DD4YPXbrMzlITqx4knJ0IYeacMn3xCcPdcH1fcvWpwI
	 RvJl0bYEHc5mO6L9+BKaSZqv+B0Tu4wMfU1sUFY9e+sku2DeN8fnqfB0fRBwr43f4I
	 gPZfToQffRssjfOmQEaClFhiqVo9SFiwnDhsYmYz/mtLcgUfbScoNlKwjiYiErg8iy
	 cXArEb/vFJUGw==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-512bce554a5so884791e87.3
        for <stable@vger.kernel.org>; Mon, 19 Feb 2024 08:57:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUqCU8MWM6Viv9Vk3xF/uR4AkP8EDvgS6SKSCaJ9e1XIbW7actjTiipqe4C6OZJPhePNmwto5MAltbNeJx7M2DDXMfNjaw1
X-Gm-Message-State: AOJu0Yyb7TMcZMT2GfOmXa+M4TLZOQSePsne+onsc4DozksEGAWBvlql
	O6VmPNKOlD0kg59Jb9Ed+dbb/VPVV55MYOIw0rxEjn5rHpIjHijHO6voPPGiyleR8P8vGo6bEky
	dwg9Zlevu0SYHBMcwSmXlAfZjuvc=
X-Google-Smtp-Source: AGHT+IFuvdkMMi/h68Krvces1E2fqS7wEV0hQ9trW6gNX6ThEtog3GVrQDGcL5F9PKlWj4WCtwNB3y6eVjwnWT+ORq0=
X-Received: by 2002:a05:6512:20c9:b0:512:be5b:30aa with SMTP id
 u9-20020a05651220c900b00512be5b30aamr806071lfr.49.1708361839115; Mon, 19 Feb
 2024 08:57:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219132153.378265-1-xiangyang3@huawei.com>
In-Reply-To: <20240219132153.378265-1-xiangyang3@huawei.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 19 Feb 2024 17:57:07 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFwTLJ77MYy3Pm+S9WGgkMw0hAGdTKOF05xdqqBg8giMw@mail.gmail.com>
Message-ID: <CAMj1kXFwTLJ77MYy3Pm+S9WGgkMw0hAGdTKOF05xdqqBg8giMw@mail.gmail.com>
Subject: Re: [PATCH 5.10.y v2] Revert "arm64: Stash shadow stack pointer in
 the task struct on interrupt"
To: Xiang Yang <xiangyang3@huawei.com>
Cc: mark.rutland@arm.com, catalin.marinas@arm.com, will@kernel.org, 
	keescook@chromium.org, linux-arm-kernel@lists.infradead.org, 
	stable@vger.kernel.org, gregkh@linuxfoundation.org, xiujianfeng@huawei.com, 
	liaochang1@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Feb 2024 at 14:24, Xiang Yang <xiangyang3@huawei.com> wrote:
>
> This reverts commit 3f225f29c69c13ce1cbdb1d607a42efeef080056.
>
> The shadow call stack for irq now is stored in current task's thread info
> in irq_stack_entry. There is a possibility that we have some soft irqs
> pending at the end of hard irq, and when we process softirq with the irq
> enabled, irq_stack_entry will enter again and overwrite the shadow call
> stack whitch stored in current task's thread info, leading to the
> incorrect shadow call stack restoration for the first entry of the hard
> IRQ, then the system end up with a panic.
>
> task A                               |  task A
> -------------------------------------+------------------------------------
> el1_irq        //irq1 enter          |
>   irq_handler  //save scs_sp1        |
>     gic_handle_irq                   |
>     irq_exit                         |
>       __do_softirq                   |
>                                      | el1_irq         //irq2 enter
>                                      |   irq_handler   //save scs_sp2
>                                      |                 //overwrite scs_sp1
>                                      |   ...
>                                      |   irq_stack_exit //restore scs_sp2
>   irq_stack_exit //restore wrong     |
>                  //scs_sp2           |
>
> So revert this commit to fix it.
>
> Fixes: 3f225f29c69c ("arm64: Stash shadow stack pointer in the task struct on interrupt")
>
> Signed-off-by: Xiang Yang <xiangyang3@huawei.com>

Acked-by: Ard Biesheuvel <ardb@kernel.org>



> ---
>  arch/arm64/kernel/entry.S | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index a94acea770c7..020a455824be 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -431,7 +431,9 @@ SYM_CODE_END(__swpan_exit_el0)
>
>         .macro  irq_stack_entry
>         mov     x19, sp                 // preserve the original sp
> -       scs_save tsk                    // preserve the original shadow stack
> +#ifdef CONFIG_SHADOW_CALL_STACK
> +       mov     x24, scs_sp             // preserve the original shadow stack
> +#endif
>
>         /*
>          * Compare sp with the base of the task stack.
> @@ -465,7 +467,9 @@ SYM_CODE_END(__swpan_exit_el0)
>          */
>         .macro  irq_stack_exit
>         mov     sp, x19
> -       scs_load_current
> +#ifdef CONFIG_SHADOW_CALL_STACK
> +       mov     scs_sp, x24
> +#endif
>         .endm
>
>  /* GPRs used by entry code */
> --
> 2.34.1
>

