Return-Path: <stable+bounces-139738-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A51AA9CA0
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 21:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A7533A5790
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 19:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D8026FDB4;
	Mon,  5 May 2025 19:27:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AFF2557C;
	Mon,  5 May 2025 19:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746473278; cv=none; b=elt2fkdXkiZhLxKuYwuIyN+MJjfMlG9Gk62AzZT170JhLwQCk8T+EENEjw+mPyRMDq0miG2L5y94Z7XqUKtB2uWl3gcqWth1vdPTvu7sP65vgfupx9xvcPZ8LNE/JHVDU138F6Bc2S5mxfKMUgVl+3Yv9i/XZfNf4qR95zxKGhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746473278; c=relaxed/simple;
	bh=8brw1Gjxn5zXovwDyimGvy7pHEterN2+6ivuHHAmf8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IaXFgkr73CvGbC3/U+GdeQc9gZ7tPyYcEhobyh3TfgvOJPYFh9tECfBPgfJT6AcufQo+xKGnMqGvdSpyjmv4q7lFPY+8kYLDcl4j6v6287KvwoYVTDsujsD+jOg96oHVD09gExpBrseFBy4mFn/64l6EvF35l29+fqvhYTbNVZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 93A9C43A0F;
	Mon,  5 May 2025 19:27:52 +0000 (UTC)
Message-ID: <d7232e99-e899-4e50-b60f-2527be709d2c@ghiti.fr>
Date: Mon, 5 May 2025 21:27:51 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Fix kernel crash due to PR_SET_TAGGED_ADDR_CTRL
Content-Language: en-US
To: Nam Cao <namcao@linutronix.de>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Samuel Holland <samuel.holland@sifive.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250504101920.3393053-1-namcao@linutronix.de>
 <c59f2632-d96f-43c6-869d-5e5f743f2dbd@ghiti.fr>
 <20250505160722.s_w3u1pd@linutronix.de>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250505160722.s_w3u1pd@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeduleegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpedtffduvdfhveefieefudffjeffffegudevfeffvdehhefhtddviefgledtgeehfeenucffohhmrghinhepmhgrnhhgohhpihdrohhrghdpihhnfhhrrgguvggrugdrohhrghenucfkphepvddttddumeekiedumeeffeekvdemvghfledtmedutgduvgemrgdutggsmehftdeisgemiegutdgtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddttddumeekiedumeeffeekvdemvghfledtmedutgduvgemrgdutggsmehftdeisgemiegutdgtpdhhvghloheplgfkrfggieemvddttddumeekiedumeeffeekvdemvghfledtmedutgduvgemrgdutggsmehftdeisgemiegutdgtngdpmhgrihhlfhhrohhmpegrlhgvgiesghhhihhtihdrfhhrpdhnsggprhgtphhtthhopeekpdhrtghpthhtohepnhgrmhgtrghosehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepphgruhhlrdifrghlmhhslhgvhiesshhif
 hhivhgvrdgtohhmpdhrtghpthhtohepphgrlhhmvghrsegurggssggvlhhtrdgtohhmpdhrtghpthhtoheprghouhesvggvtghsrdgsvghrkhgvlhgvhidrvgguuhdprhgtphhtthhopehsrghmuhgvlhdrhhholhhlrghnugesshhifhhivhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqrhhishgtvheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: alex@ghiti.fr

On 05/05/2025 18:07, Nam Cao wrote:
> Hi Alex,
>
> On Mon, May 05, 2025 at 06:02:26PM +0200, Alexandre Ghiti wrote:
>> On 04/05/2025 12:19, Nam Cao wrote:
>>> When userspace does PR_SET_TAGGED_ADDR_CTRL, but Supm extension is not
>>> available, the kernel crashes:
>>>
>>> Oops - illegal instruction [#1]
>>>       [snip]
>>> epc : set_tagged_addr_ctrl+0x112/0x15a
>>>    ra : set_tagged_addr_ctrl+0x74/0x15a
>>> epc : ffffffff80011ace ra : ffffffff80011a30 sp : ffffffc60039be10
>>>       [snip]
>>> status: 0000000200000120 badaddr: 0000000010a79073 cause: 0000000000000002
>>>       set_tagged_addr_ctrl+0x112/0x15a
>>>       __riscv_sys_prctl+0x352/0x73c
>>>       do_trap_ecall_u+0x17c/0x20c
>>>       andle_exception+0x150/0x15c
>>
>> It seems like the csr write is triggering this illegal instruction, can you
>> confirm it is?
> Yes, it is the "csr_write(CSR_ENVCFG, envcfg);" in envcfg_update_bits().
>
>> If so, I can't find in the specification that an implementation should do
>> that when writing envcfg and I can't reproduce it on qemu. Where did you
>> see this oops?
> I can't find it in the spec either. I think it is up to the implementation.


The reserved fields of senvcfg are WPRI and contrary to WLRL, it does 
not explicitly "permit" to raise an illegal instruction so I'd say it is 
not up to the implementation, I'll ask around.

Thanks,

Alex


>
> I got this crash on the MangoPI board:
> https://mangopi.org/mqpro
>
> Best regards,
> Nam
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

