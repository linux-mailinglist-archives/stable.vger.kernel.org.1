Return-Path: <stable+bounces-139719-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B79FAA9837
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 18:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5091A3BE273
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 16:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4C5264FA6;
	Mon,  5 May 2025 16:02:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A62817B425;
	Mon,  5 May 2025 16:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746460961; cv=none; b=NlRywuInH77YfcQGoBis2uahGutJeSwSUmU+jrbiLwRPq44aFKH4rMeNHWJ3R21RlKt7yXhA1XPVeVf21YkWTrSWbGQdOfJHYIl3R1H4dU5d8qmtSjp2mXXxgVDKKEVT5v5VFZ90uMtHbnlPv0/gsY9E/6qfbj9NRFpNuz6xWMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746460961; c=relaxed/simple;
	bh=859W0ONICk/lnxUxe5B+N7CDRdPaRvyaAVNgbcTT6to=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W8T5OFcCT08hoMWGGd0G467lw39PI526ljxFlNhXn7cCegM/+frFCbbcbNhL/NdZsj2ZgSw4iahsJoq0YMLSqCCLVsg2LAAhdSJ34/+pELoYT7XtNQuaJk8+4FdwMf/rL7C3OQ+dLtlvyFbT6oNYf1TfIxhkgwmnQWwhMUv/SKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9B8F443A39;
	Mon,  5 May 2025 16:02:26 +0000 (UTC)
Message-ID: <c59f2632-d96f-43c6-869d-5e5f743f2dbd@ghiti.fr>
Date: Mon, 5 May 2025 18:02:26 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Fix kernel crash due to PR_SET_TAGGED_ADDR_CTRL
Content-Language: en-US
To: Nam Cao <namcao@linutronix.de>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Samuel Holland <samuel.holland@sifive.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20250504101920.3393053-1-namcao@linutronix.de>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250504101920.3393053-1-namcao@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeduheefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpedthfelfeejgeehveegleejleelgfevhfekieffkeeujeetfedvvefhledvgeegieenucfkphepvddttddumeekiedumeeffeekvdemvghfledtmeegvggrvdemvgehvdeimeeiheduudemheefgegtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddttddumeekiedumeeffeekvdemvghfledtmeegvggrvdemvgehvdeimeeiheduudemheefgegtpdhhvghloheplgfkrfggieemvddttddumeekiedumeeffeekvdemvghfledtmeegvggrvdemvgehvdeimeeiheduudemheefgegtngdpmhgrihhlfhhrohhmpegrlhgvgiesghhhihhtihdrfhhrpdhnsggprhgtphhtthhopeekpdhrtghpthhtohepnhgrmhgtrghosehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepphgruhhlrdifrghlmhhslhgvhiesshhifhhivhgvrdgtohhmpdhrtghpthhtohepphgrlhhmvghrsegurggssggvlhhtrdgtohhmp
 dhrtghpthhtoheprghouhesvggvtghsrdgsvghrkhgvlhgvhidrvgguuhdprhgtphhtthhopehsrghmuhgvlhdrhhholhhlrghnugesshhifhhivhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqrhhishgtvheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: alex@ghiti.fr

Hi Nam,

On 04/05/2025 12:19, Nam Cao wrote:
> When userspace does PR_SET_TAGGED_ADDR_CTRL, but Supm extension is not
> available, the kernel crashes:
>
> Oops - illegal instruction [#1]
>      [snip]
> epc : set_tagged_addr_ctrl+0x112/0x15a
>   ra : set_tagged_addr_ctrl+0x74/0x15a
> epc : ffffffff80011ace ra : ffffffff80011a30 sp : ffffffc60039be10
>      [snip]
> status: 0000000200000120 badaddr: 0000000010a79073 cause: 0000000000000002
>      set_tagged_addr_ctrl+0x112/0x15a
>      __riscv_sys_prctl+0x352/0x73c
>      do_trap_ecall_u+0x17c/0x20c
>      andle_exception+0x150/0x15c


It seems like the csr write is triggering this illegal instruction, can 
you confirm it is? If so, I can't find in the specification that an 
implementation should do that when writing envcfg and I can't reproduce 
it on qemu. Where did you see this oops?

Thanks,

Alex


>
> Fix it by checking if Supm is available.
>
> Fixes: 09d6775f503b ("riscv: Add support for userspace pointer masking")
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> Cc: stable@vger.kernel.org
> ---
>   arch/riscv/kernel/process.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> index 7c244de77180..3db2c0c07acd 100644
> --- a/arch/riscv/kernel/process.c
> +++ b/arch/riscv/kernel/process.c
> @@ -275,6 +275,9 @@ long set_tagged_addr_ctrl(struct task_struct *task, unsigned long arg)
>   	unsigned long pmm;
>   	u8 pmlen;
>   
> +	if (!riscv_has_extension_unlikely(RISCV_ISA_EXT_SUPM))
> +		return -EINVAL;
> +
>   	if (is_compat_thread(ti))
>   		return -EINVAL;
>   

