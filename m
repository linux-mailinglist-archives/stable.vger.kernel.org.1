Return-Path: <stable+bounces-233816-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHVsM4YM1mmfAwgAu9opvQ
	(envelope-from <stable+bounces-233816-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 10:06:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 55ED03B8BBE
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 10:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F38D2300D684
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 08:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7B5397E65;
	Wed,  8 Apr 2026 08:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLrVCyU5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCF838C405
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 08:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775635534; cv=none; b=D0fWGUBQljPStuxfekAUof1L2c38Z/LkiFw9wQlmqfp8pF4f8bbxxD8mjqRPQJl5gswcil1d5sq+xDHtvRz0M1hcPf5rpHKaJOg0XiK7OaglGWVctAhlbgLv0XwoCwQOxHTr5mjxMm3UhbLkdNpY630Ag/BIRQ/Yug5hWZ9hP3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775635534; c=relaxed/simple;
	bh=7lemymP4B8AMWnXXk52HUYfkTJngMPphX6jlJ0em0iY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sHsYPujsmtadUcuuCOOzhJoGqisIw7TVvAbxAqWbMcSP0qy6c/1v0jzcUFzuVsJjKrlyy8/eo0ektJlihPxemgFetBjmzfsw7ewTtMgYVCkPvzPEoPC07a7k5EX1rJ8YPZhvr/Bdw9BpKoJrdjL0wYVDzj3up50ffxhoYXFN5Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLrVCyU5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4495FC2BCB1
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 08:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775635534;
	bh=7lemymP4B8AMWnXXk52HUYfkTJngMPphX6jlJ0em0iY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QLrVCyU5IRentbxeDRci/W8QLxH5RtHk1fZYUUbyWN19bP9kS8NfZCmD/ZXwvdmSe
	 6znEcBFd/14ydX2gtz5yYef6ZGk8Qq5EGvdUZfj8XuVLhCN32MFou3q+++ZDVljhic
	 0QUiz+dy+cKw4bbTZ/JZ86NuY3Z3rfmwKqDRC6vkhA+3ZUzpMSvpayyoryYaaO0s8U
	 sn0T+YNMAh8W3k8uc888fysuvErf+iRnqflhE0yKULVz+DSx5fkl4Pc1fl/5eElanE
	 yrNgtQQ+2mRHoSIdeA514KA9izAZQTI43LX2SkeKzaEJhmlCCK41H24cd6wdOsRIzJ
	 mPzwij7C4bXbQ==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b9825ba7e8dso768899566b.3
        for <stable@vger.kernel.org>; Wed, 08 Apr 2026 01:05:34 -0700 (PDT)
X-Gm-Message-State: AOJu0YxkPpOe6RTHBHRd0/HP3Glxd3QKlKapnZlKqGK/UORKzyKUNgAj
	/uDzJXBEg4t5jL8E234bQRwnWWMMgfOnL+yeHH5loNvX+ja3p7IQHHNRSOHrWb2Bsy5nsGTDMYk
	ZkLgCr4T7aIqWbtdEXmRZqp4EWkFLeCE=
X-Received: by 2002:a17:907:9813:b0:b9d:30b1:66f4 with SMTP id
 a640c23a62f3a-b9d30b169c6mr47871966b.26.1775635532751; Wed, 08 Apr 2026
 01:05:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408005834.743748-1-sashal@kernel.org>
In-Reply-To: <20260408005834.743748-1-sashal@kernel.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 8 Apr 2026 16:05:38 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7mnMLBLcn0Q-zhm0QPdO1AYFcYZ_mdeWNdzJ=KowqA8w@mail.gmail.com>
X-Gm-Features: AQROBzCtzoeYAk-rYcYv8ohdKhwRZNGdJODebRtuELpnKxX5_0fBw9ErhkMXevM
Message-ID: <CAAhV-H7mnMLBLcn0Q-zhm0QPdO1AYFcYZ_mdeWNdzJ=KowqA8w@mail.gmail.com>
Subject: Re: Patch "Revert "LoongArch: Handle percpu handler address for ORC
 unwinder"" has been added to the 6.12-stable tree
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, sashal@kernel.org, 
	WANG Xuerui <kernel@xen0n.name>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233816-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenhuacai@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 55ED03B8BBE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi, Sasha,

On Wed, Apr 8, 2026 at 8:58=E2=80=AFAM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> This is a note to let you know that I've just added the patch titled
>
>     Revert "LoongArch: Handle percpu handler address for ORC unwinder"
>
> to the 6.12-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>
> The filename of the patch is:
>      revert-loongarch-handle-percpu-handler-address-for-o.patch
> and it can be found in the queue-6.12 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
>
We only need to revert "LoongArch/orc: Use RCU in all users of
__module_address()", and this patch can be applied on top of
"LoongArch: Remove unnecessary checks for ORC unwinder".

Huacai
>
>
> commit 6694f3167701abd0534f9174b6a94c6f19dc1698
> Author: Sasha Levin <sashal@kernel.org>
> Date:   Tue Apr 7 20:00:56 2026 -0400
>
>     Revert "LoongArch: Handle percpu handler address for ORC unwinder"
>
>     This reverts commit 8eeb34ae9d4c743b1fd2cf58f9c51def37091cf5.
>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> diff --git a/arch/loongarch/include/asm/setup.h b/arch/loongarch/include/=
asm/setup.h
> index f81375e5e89c0..3c2fb16b11b64 100644
> --- a/arch/loongarch/include/asm/setup.h
> +++ b/arch/loongarch/include/asm/setup.h
> @@ -7,7 +7,6 @@
>  #define _LOONGARCH_SETUP_H
>
>  #include <linux/types.h>
> -#include <linux/threads.h>
>  #include <asm/sections.h>
>  #include <uapi/asm/setup.h>
>
> @@ -15,8 +14,6 @@
>
>  extern unsigned long eentry;
>  extern unsigned long tlbrentry;
> -extern unsigned long pcpu_handlers[NR_CPUS];
> -extern long exception_handlers[VECSIZE * 128 / sizeof(long)];
>  extern char init_command_line[COMMAND_LINE_SIZE];
>  extern void tlb_init(int cpu);
>  extern void cpu_cache_init(void);
> diff --git a/arch/loongarch/kernel/unwind_orc.c b/arch/loongarch/kernel/u=
nwind_orc.c
> index e8b95f1bc5786..4924d1ecc4579 100644
> --- a/arch/loongarch/kernel/unwind_orc.c
> +++ b/arch/loongarch/kernel/unwind_orc.c
> @@ -357,21 +357,7 @@ static bool is_entry_func(unsigned long addr)
>
>  static inline unsigned long bt_address(unsigned long ra)
>  {
> -#if defined(CONFIG_NUMA) && !defined(CONFIG_PREEMPT_RT)
> -       int cpu;
> -       int vec_sz =3D sizeof(exception_handlers);
> -
> -       for_each_possible_cpu(cpu) {
> -               if (!pcpu_handlers[cpu])
> -                       continue;
> -
> -               if (ra >=3D pcpu_handlers[cpu] &&
> -                   ra < pcpu_handlers[cpu] + vec_sz) {
> -                       ra =3D ra + eentry - pcpu_handlers[cpu];
> -                       break;
> -               }
> -       }
> -#endif
> +       extern unsigned long eentry;
>
>         if (ra >=3D eentry && ra < eentry +  EXCCODE_INT_END * VECSIZE) {
>                 unsigned long func;

