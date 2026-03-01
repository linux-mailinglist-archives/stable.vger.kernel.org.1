Return-Path: <stable+bounces-222418-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHMuJBDgo2lPQwUAu9opvQ
	(envelope-from <stable+bounces-222418-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 07:43:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AF11CEAA4
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 07:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E651301D325
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 06:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E33D13D53C;
	Sun,  1 Mar 2026 06:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ut7lDY8N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A7D30B539
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 06:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772347405; cv=none; b=jNzA108bBtcqJGuC45biUXreCm0GVuKT9QvaUNp90lNl4yJOMeKl6b9Zz2D29BsT8HMDAVDGjxfH42Hzn7iQL7TQVq0eBZOyUHzY4WDGMizu7bQjnlQ9RnWTIm3PRkKQzJtUSSmI52Adk6KqKzdaZljB3kbKyiteERFZBc0kz3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772347405; c=relaxed/simple;
	bh=a3gDiQkm39SDNs3FJn9tByo+Y+gifVe+5SxGVPceq8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gkq1HVwRINXa9QgLj6N1vzbNKh4mE13/9TjUMhBTS8gHbG7hyNY4XuDRnh9eyqov/OXiYrsHAZ+s8HmXwW0PXj66zEtULgXlSsD2hLXGZvg4BS1vHoCsEBxcfAkd+DVJFEzh7h8RRbweb3gRSuRkXT+0XZ7E9A7QYbBJq+Eu/Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ut7lDY8N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13444C116C6
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 06:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772347405;
	bh=a3gDiQkm39SDNs3FJn9tByo+Y+gifVe+5SxGVPceq8c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ut7lDY8ND5K7RwzJNWEml2yqcQaEqSGozE7YDwdArbEnnlGIRxn2j5uXIxxcgYG6l
	 pnSAZGq3HLZ9/U2pBzIc64d4lAfO/AhllGy0r2cxq52+nN1HbfIjTxIyNd2xAH4ZHE
	 3IN0zO9ZKZHSDK9YYfPoDCtn27vnJldRK1g3A9LcspEMmuLCYDPABwjWHA0Ezr0EFE
	 zagN6OINYNG2mLMt/pObX2uVkSry8FsYPI2jxcu0XB3o5AGaJ8iVwJxrZKnhnSA/QL
	 g+iDa7VrmBrsSr9SKjcPlJM+MDvEMfhz93YQq84NBy2Fdrejo6AjyxP1MjrCTe8vOr
	 Eed8uR8aNUaiw==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-65fb991d7e7so4865532a12.1
        for <stable@vger.kernel.org>; Sat, 28 Feb 2026 22:43:25 -0800 (PST)
X-Gm-Message-State: AOJu0YyBdV2n+Cj8Z02uGEJK+e/QlArzBHsEMw/yA+wi+R8gDMZv9In/
	hED+KRGLL6QIPpzrqm/T7AVJc6gwj1M4gF1ssXIhqRoeFOe7JxkXvxD0bpTvxEazOfuHwu9aeif
	VBpy0YENsEGjo/KmQs+ryw96ael8AVcw=
X-Received: by 2002:a05:6402:1456:b0:658:b837:7953 with SMTP id
 4fb4d7f45d1cf-65fdd6ef9f8mr5194126a12.12.1772347403652; Sat, 28 Feb 2026
 22:43:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260301013808.1698484-1-sashal@kernel.org>
In-Reply-To: <20260301013808.1698484-1-sashal@kernel.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 1 Mar 2026 14:43:12 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5N+Qwz=ViTjm9pxZWOE=_HdcHXYjqBysPhFovjMPc_LQ@mail.gmail.com>
X-Gm-Features: AaiRm50d9JSTLnIVN7uyK-OVq5ZFcscc1wP3GZgAgZqmyZmVsUgy9YzHgZTkv-w
Message-ID: <CAAhV-H5N+Qwz=ViTjm9pxZWOE=_HdcHXYjqBysPhFovjMPc_LQ@mail.gmail.com>
Subject: Re: FAILED: Patch "LoongArch: Disable instrumentation for
 setup_ptwalker()" failed to apply to 6.6-stable tree
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, yangtiezhu@loongson.cn, 
	Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222418-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenhuacai@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[loongson.cn:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F1AF11CEAA4
X-Rspamd-Action: no action

Hi, Sasha,

On Sun, Mar 1, 2026 at 9:38=E2=80=AFAM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> The patch below does not apply to the 6.6-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
I'm very confused because it can be applied and already here:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tre=
e/queue-6.6

Huacai

>
> Thanks,
> Sasha
>
> ------------------ original commit in Linus's tree ------------------
>
> From 7cb37af61f09c9cfd90c43c9275307c16320cbf2 Mon Sep 17 00:00:00 2001
> From: Tiezhu Yang <yangtiezhu@loongson.cn>
> Date: Tue, 10 Feb 2026 19:31:17 +0800
> Subject: [PATCH] LoongArch: Disable instrumentation for setup_ptwalker()
>
> According to Documentation/dev-tools/kasan.rst, software KASAN modes use
> compiler instrumentation to insert validity checks. Such instrumentation
> might be incompatible with some parts of the kernel, and therefore needs
> to be disabled, just use the attribute __no_sanitize_address to disable
> instrumentation for the low level function setup_ptwalker().
>
> Otherwise bringing up the secondary CPUs failed when CONFIG_KASAN is set
> (especially when PTW is enabled), here are the call chains:
>
>     smpboot_entry()
>       start_secondary()
>         cpu_probe()
>           per_cpu_trap_init()
>             tlb_init()
>               setup_tlb_handler()
>                 setup_ptwalker()
>
> The reason is the PGD registers are configured in setup_ptwalker(), but
> KASAN instrumentation may cause TLB exceptions before that.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  arch/loongarch/mm/tlb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/mm/tlb.c b/arch/loongarch/mm/tlb.c
> index 4014c44695878..aaf7d685cc2aa 100644
> --- a/arch/loongarch/mm/tlb.c
> +++ b/arch/loongarch/mm/tlb.c
> @@ -202,7 +202,7 @@ void __update_tlb(struct vm_area_struct *vma, unsigne=
d long address, pte_t *ptep
>         local_irq_restore(flags);
>  }
>
> -static void setup_ptwalker(void)
> +static void __no_sanitize_address setup_ptwalker(void)
>  {
>         unsigned long pwctl0, pwctl1;
>         unsigned long pgd_i =3D 0, pgd_w =3D 0;
> --
> 2.51.0
>
>
>
>
>

