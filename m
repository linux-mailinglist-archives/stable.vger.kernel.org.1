Return-Path: <stable+bounces-141848-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0E4AACB0D
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 18:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D06C718921D2
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 16:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D3F284B5B;
	Tue,  6 May 2025 16:31:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA7F284B3B;
	Tue,  6 May 2025 16:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746549112; cv=none; b=PIPOdoHJ1Sk43UZOYbRp6b2+MUUH03AhbnPqLCViKuNRKDunYBRUlCXN6yrk3/edSSZ6tqplNoNCSRGHetQ7zLJLVTh4NwAZKsICAn6u41Cjr0k8+ykksR2axbYBbb5EEjltn31+7LG8I9Qs17tNtofpOPBqUkyQp4ZvFSaBHzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746549112; c=relaxed/simple;
	bh=PHoTVTfZ1ZEwEICE2WqavS02UFhuhVT/TKmdSzWLQiM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=MsAgpv9+Tvv+tFy+ijxplfP/MRnIv4aCfS+ptoFg3nD8eQsSQYCd4eKi2lk9iCWkiOrTK7f+0L2rtAe+n8baVvsM9GMpmX/bHWVORsGsX6bXrIWTBWoG+jWUfxVZEEZjXCNd57MvBN+Pf7Ue5+ccWDKNFV1sD8uHD0d7xMiqWkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id CFBBB43B1A;
	Tue,  6 May 2025 16:31:42 +0000 (UTC)
Message-ID: <570ce61a-00ca-446f-ae89-7ab7c340828f@ghiti.fr>
Date: Tue, 6 May 2025 18:31:41 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Fix kernel crash due to PR_SET_TAGGED_ADDR_CTRL
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
To: Nam Cao <namcao@linutronix.de>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Samuel Holland <samuel.holland@sifive.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250504101920.3393053-1-namcao@linutronix.de>
 <c59f2632-d96f-43c6-869d-5e5f743f2dbd@ghiti.fr>
 <20250505160722.s_w3u1pd@linutronix.de>
 <d7232e99-e899-4e50-b60f-2527be709d2c@ghiti.fr>
In-Reply-To: <d7232e99-e899-4e50-b60f-2527be709d2c@ghiti.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeeggeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuhffvvehfjggtgfesthekredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpeffudduledvfeehvdefueduveffkedugeetjeetveduvddtudehieduudehtdfhueenucffohhmrghinhepmhgrnhhgohhpihdrohhrghdpihhnfhhrrgguvggrugdrohhrghenucfkphepvddttddumeekiedumeeffeekvdemvghfledtmegstdgvieemhehfgehfmeefugejrgemrgdvfhdtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddttddumeekiedumeeffeekvdemvghfledtmegstdgvieemhehfgehfmeefugejrgemrgdvfhdtpdhhvghloheplgfkrfggieemvddttddumeekiedumeeffeekvdemvghfledtmegstdgvieemhehfgehfmeefugejrgemrgdvfhdtngdpmhgrihhlfhhrohhmpegrlhgvgiesghhhihhtihdrfhhrpdhnsggprhgtphhtthhopeekpdhrtghpthhtohepnhgrmhgtrghosehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepphgruhhlrdifrghlmhhslhgvhiesshhif
 hhivhgvrdgtohhmpdhrtghpthhtohepphgrlhhmvghrsegurggssggvlhhtrdgtohhmpdhrtghpthhtoheprghouhesvggvtghsrdgsvghrkhgvlhgvhidrvgguuhdprhgtphhtthhopehsrghmuhgvlhdrhhholhhlrghnugesshhifhhivhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqrhhishgtvheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: alex@ghiti.fr

On 05/05/2025 21:27, Alexandre Ghiti wrote:
> On 05/05/2025 18:07, Nam Cao wrote:
>> Hi Alex,
>>
>> On Mon, May 05, 2025 at 06:02:26PM +0200, Alexandre Ghiti wrote:
>>> On 04/05/2025 12:19, Nam Cao wrote:
>>>> When userspace does PR_SET_TAGGED_ADDR_CTRL, but Supm extension is not
>>>> available, the kernel crashes:
>>>>
>>>> Oops - illegal instruction [#1]
>>>>       [snip]
>>>> epc : set_tagged_addr_ctrl+0x112/0x15a
>>>>    ra : set_tagged_addr_ctrl+0x74/0x15a
>>>> epc : ffffffff80011ace ra : ffffffff80011a30 sp : ffffffc60039be10
>>>>       [snip]
>>>> status: 0000000200000120 badaddr: 0000000010a79073 cause: 
>>>> 0000000000000002
>>>>       set_tagged_addr_ctrl+0x112/0x15a
>>>>       __riscv_sys_prctl+0x352/0x73c
>>>>       do_trap_ecall_u+0x17c/0x20c
>>>>       andle_exception+0x150/0x15c
>>>
>>> It seems like the csr write is triggering this illegal instruction, 
>>> can you
>>> confirm it is?
>> Yes, it is the "csr_write(CSR_ENVCFG, envcfg);" in envcfg_update_bits().
>>
>>> If so, I can't find in the specification that an implementation 
>>> should do
>>> that when writing envcfg and I can't reproduce it on qemu. Where did 
>>> you
>>> see this oops?
>> I can't find it in the spec either. I think it is up to the 
>> implementation.
>
>
> The reserved fields of senvcfg are WPRI and contrary to WLRL, it does 
> not explicitly "permit" to raise an illegal instruction so I'd say it 
> is not up to the implementation, I'll ask around.


So I had confirmation that WPRI should not raise an illegal instruction 
so that's an issue with the platform. Your patch is not wrong but I'd 
rather have an explicit errata, what do you think?

Thanks,

Alex


>
> Thanks,
>
> Alex
>
>
>>
>> I got this crash on the MangoPI board:
>> https://mangopi.org/mqpro
>>
>> Best regards,
>> Nam
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

