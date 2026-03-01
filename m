Return-Path: <stable+bounces-222409-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLhHAw7do2l5QQUAu9opvQ
	(envelope-from <stable+bounces-222409-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 07:30:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FD61CEA04
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 07:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D6EEB300BB9F
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 06:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC2321D3E4;
	Sun,  1 Mar 2026 06:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJC6kbbP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8A063CB
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 06:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772346633; cv=none; b=ErPkhkRpH0ODwfVRS1doQcl1nZsXIPa0tj2ObHkPZl6X1yCqzSnB0FQkFLEK8Vn8QN4bkTXeQxWIeGpI9bi3wsWXLhyoywndAUBUEn5VddaSoDoNVb7120AynFZCsNfeO1W7xNqldO2TdXfDh4gbC96rRKl/Jl49L9STGfgQz2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772346633; c=relaxed/simple;
	bh=5Ci4iQ8LIkRjw9ITSzRmMXH38FKEB3kwlZ/GBUHDVSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HQKM9eYzMoWNA1+84htU6bkm3KoXPdayVMXn6AND50miHbU8LRJQnBm0RVbTYCYY2EzssA/5TV63akyOxAwJQtNH9bOWjWB7eXd3ey0wi4QFf0mVEnSn1BjYVS1D0qXAvfZsf0Av3HQ8T81HMDWcOGqaGeU+NFZM5VO0bgEWF98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJC6kbbP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8EE1C4AF09
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 06:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772346632;
	bh=5Ci4iQ8LIkRjw9ITSzRmMXH38FKEB3kwlZ/GBUHDVSc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XJC6kbbPZynVyJ0VmR4N5DkJ7wXg3e/L7E1CTiSd2D1C6xKrxKkJAwPN3RJzavj7Y
	 lwljdEg8otI+Zu/sGO1EJijummqbPSlvGq2C2gVrWv6BCvnZpvbHPIUUorarlavuT6
	 XQL8FWZYr8u1SjX7vEu/3SmI6/alZtw1+jt2gfwi6ntxSawbTlc3CC2nsNtgqPc1Bw
	 qFdHvMCjyXMRopMPd4KuyJ5eXC81cTRzwmLpE+bnUdh/lNf6Nw1KHOdHaqCgAEAyOX
	 kghI+jSJaMjXPI6FgZabwLIQjCF0PmNhXljNmAkmdprS2sTSXnjqLTpyqVcIQP/+Mv
	 TQ53SAMoFPpDQ==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-65a26c220b6so4588792a12.0
        for <stable@vger.kernel.org>; Sat, 28 Feb 2026 22:30:32 -0800 (PST)
X-Gm-Message-State: AOJu0Yw843u4Rzq3+iWIA2VS/55KoBUO/WpkI6IP3zr/ouBzBYNIITqD
	BhekIphNLQiTBvqv03n4z4Cp6fPERCUf7yVqbW0X3kZsuzghF8ct+jz/GEMSN9QgXfsdKpCB6U8
	llG3Z9ymP+Ln5xQ/mfIHvtfsaY15hpVc=
X-Received: by 2002:a05:6402:2706:b0:65f:a619:22f4 with SMTP id
 4fb4d7f45d1cf-65fddef77dfmr4795751a12.27.1772346631335; Sat, 28 Feb 2026
 22:30:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260301012733.1685068-1-sashal@kernel.org>
In-Reply-To: <20260301012733.1685068-1-sashal@kernel.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 1 Mar 2026 14:30:19 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5LbUecy1gV5njsd1Hk_q4=_LgBs5yN9OecukCxLE1GEw@mail.gmail.com>
X-Gm-Features: AaiRm531C7nHiTRnKkTxeO1JL9v97YjLgJN6HwOcR6CM4VWFglyII4FCDtsLaAg
Message-ID: <CAAhV-H5LbUecy1gV5njsd1Hk_q4=_LgBs5yN9OecukCxLE1GEw@mail.gmail.com>
Subject: Re: FAILED: Patch "LoongArch: Prefer top-down allocation after
 arch_mem_init()" failed to apply to 6.12-stable tree
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>, 
	loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-222409-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenhuacai@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[loongson.cn:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: A1FD61CEA04
X-Rspamd-Action: no action

Hi, Sasha,

On Sun, Mar 1, 2026 at 9:27=E2=80=AFAM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> The patch below does not apply to the 6.12-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
I'm very confused because it can be applied and already here:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tre=
e/queue-6.12

Huacai

>
> Thanks,
> Sasha
>
> ------------------ original commit in Linus's tree ------------------
>
> From 2172d6ebac9372eb01fe4505a53e18cb061e103b Mon Sep 17 00:00:00 2001
> From: Huacai Chen <chenhuacai@loongson.cn>
> Date: Tue, 10 Feb 2026 19:31:13 +0800
> Subject: [PATCH] LoongArch: Prefer top-down allocation after arch_mem_ini=
t()
>
> Currently we use bottom-up allocation after sparse_init(), the reason is
> sparse_init() need a lot of memory, and bottom-up allocation may exhaust
> precious low memory (below 4GB). On the other hand, SWIOTLB and CMA need
> low memories for DMA32, so swiotlb_init() and dma_contiguous_reserve()
> need bottom-up allocation.
>
> Since swiotlb_init() and dma_contiguous_reserve() are both called in
> arch_mem_init(), we no longer need bottom-up allocation after that. So
> we set the allocation policy to top-down at the end of arch_mem_init(),
> in order to avoid later memory allocations (such as KASAN) exhaust low
> memory.
>
> This solve at least two problems:
> 1. Some buggy BIOSes use 0xfd000000~0xfe000000 for secondary CPUs, but
>    didn't reserve this range, which causes smpboot failures.
> 2. Some DMA32 devices, such as Loongson-DRM and OHCI, cannot work with
>    KASAN enabled.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  arch/loongarch/kernel/setup.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.=
c
> index 20cb6f3064568..2b260d15b2e25 100644
> --- a/arch/loongarch/kernel/setup.c
> +++ b/arch/loongarch/kernel/setup.c
> @@ -421,6 +421,7 @@ static void __init arch_mem_init(char **cmdline_p)
>                                    PFN_UP(__pa_symbol(&__nosave_end)));
>
>         memblock_dump_all();
> +       memblock_set_bottom_up(false);
>
>         early_memtest(PFN_PHYS(ARCH_PFN_OFFSET), PFN_PHYS(max_low_pfn));
>  }
> --
> 2.51.0
>
>
>
>

