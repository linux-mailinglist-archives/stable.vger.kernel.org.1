Return-Path: <stable+bounces-95711-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1B89DB836
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 14:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1EA6B2110F
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 13:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F48E19E830;
	Thu, 28 Nov 2024 13:02:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A3919D086;
	Thu, 28 Nov 2024 13:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732798974; cv=none; b=B/SbrtGIctWW5xdiQzBG2VJsQTbzFz7QVLvcXKsn3+Ed/ME7RruQkzr/76JqxFSeoxQl9W4pHzV4QuDLXnCADgEFKstbsz/MnsPmr50EbdNfOR15BJTCSz3jXj+UOCbpGLPPHFv3AL1Vla+aGpnrAvEfSxbxsaxfOSZiYbqJuac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732798974; c=relaxed/simple;
	bh=Il/N/uUF5Y+0yFcQQgIzjI4ycL9a4G812QxjL71vS3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ct8d/0UFWQTbQFhhPDT8XcpTlSTJD3T0MmEBNQGWG3l1tyd0Nn3tB7hH5j0FpMvO0MwvTo3CkoBUyFdZ3bb53hdtU96k8PSziB9XFbBW4NMhfF/Toc6vS72R5aAjYxGP6DVNgKmZwpF+ul47EetR9kNe9RpBR1ngomEeBkeyZqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id E022660005;
	Thu, 28 Nov 2024 13:02:40 +0000 (UTC)
Message-ID: <7662be43-16e6-4695-9bc4-077e1dd3ba12@ghiti.fr>
Date: Thu, 28 Nov 2024 14:02:40 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: kprobes: Fix incorrect address calculation
Content-Language: en-US
To: Nam Cao <namcao@linutronix.de>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Samuel Holland <samuel.holland@sifive.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: John Ogness <john.ogness@linutronix.de>, stable@vger.kernel.org
References: <20241119111056.2554419-1-namcao@linutronix.de>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20241119111056.2554419-1-namcao@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Nam,

On 19/11/2024 12:10, Nam Cao wrote:
> p->ainsn.api.insn is a pointer to u32, therefore arithmetic operations are
> multiplied by four. This is clearly undesirable for this case.
>
> Cast it to (void *) first before any calculation.
>
> Below is a sample before/after. The dumped memory is two kprobe slots, the
> first slot has
>
>    - c.addiw a0, 0x1c (0x7125)
>    - ebreak           (0x00100073)
>
> and the second slot has:
>
>    - c.addiw a0, -4   (0x7135)
>    - ebreak           (0x00100073)
>
> Before this patch:
>
> (gdb) x/16xh 0xff20000000135000
> 0xff20000000135000:	0x7125	0x0000	0x0000	0x0000	0x7135	0x0010	0x0000	0x0000
> 0xff20000000135010:	0x0073	0x0010	0x0000	0x0000	0x0000	0x0000	0x0000	0x0000
>
> After this patch:
>
> (gdb) x/16xh 0xff20000000125000
> 0xff20000000125000:	0x7125	0x0073	0x0010	0x0000	0x7135	0x0073	0x0010	0x0000
> 0xff20000000125010:	0x0000	0x0000	0x0000	0x0000	0x0000	0x0000	0x0000	0x0000
>
> Fixes: b1756750a397 ("riscv: kprobes: Use patch_text_nosync() for insn slots")
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> Cc: stable@vger.kernel.org
> ---
>   arch/riscv/kernel/probes/kprobes.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
> index 474a65213657..d2dacea1aedd 100644
> --- a/arch/riscv/kernel/probes/kprobes.c
> +++ b/arch/riscv/kernel/probes/kprobes.c
> @@ -30,7 +30,7 @@ static void __kprobes arch_prepare_ss_slot(struct kprobe *p)
>   	p->ainsn.api.restore = (unsigned long)p->addr + len;
>   
>   	patch_text_nosync(p->ainsn.api.insn, &p->opcode, len);
> -	patch_text_nosync(p->ainsn.api.insn + len, &insn, GET_INSN_LENGTH(insn));
> +	patch_text_nosync((void *)p->ainsn.api.insn + len, &insn, GET_INSN_LENGTH(insn));
>   }
>   
>   static void __kprobes arch_prepare_simulate(struct kprobe *p)

This looks good to me, how did you find this issue?

You can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


