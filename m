Return-Path: <stable+bounces-177703-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E93DDB43555
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 10:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 774191892879
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 08:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816F128BA81;
	Thu,  4 Sep 2025 08:15:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF5D279781;
	Thu,  4 Sep 2025 08:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756973731; cv=none; b=j4Rf8016ESH/eFIcl4w5QyciWz80Tzrk5FKSEZkHb5hdex0jePaFpS69jCGBtieu6QEOJeGsWhTkfWS/jMcx/X+ZnHo4Y7dxfw0D38/cjpO4iZcFPSZCaKHnp1v12gSTDI/5lwZ44gjZ73qzdiCeEyRS2NAp7yBDKYvPajjPhUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756973731; c=relaxed/simple;
	bh=wHgAp1bPS67y9L/pNxvKgZMwcYuvEFp49cXyVS+95h4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eArs3r7kmBma0hiUU5az5QyvhWHhGSJRKNdl8FA3EyXNlwnt/bZRpXTCpuiNpXueqrO3ECWQGpHUXPywX7PiE4U59cUOhOeGQad6GNDeogSffOrX9Bljl7gFS5bA0Ya1jH2m60ZKFaI2jIktpJIrQRihhOl7pGHKv7jACWB02oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 8A79F5846D7;
	Thu,  4 Sep 2025 07:59:57 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id DA75643CB6;
	Thu,  4 Sep 2025 07:59:46 +0000 (UTC)
Message-ID: <ca18ee32-db74-4ec7-a6e2-805ac7abdee6@ghiti.fr>
Date: Thu, 4 Sep 2025 09:59:46 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] riscv: Do not handle break traps from kernel as nmi
To: Peter Zijlstra <peterz@infradead.org>,
 Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Guo Ren <guoren@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>, Palmer Dabbelt <palmer@rivosinc.com>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250903-dev-alex-break_nmi_v1-v1-1-4a3d81c29598@rivosinc.com>
 <20250903202803.GQ4067720@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250903202803.GQ4067720@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehgeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpeetieeitefghfeuvddvjeeiudehheeiffffgeeviedtleehgeffgfdtveekteehudenucffohhmrghinhepihhnfhhrrgguvggrugdrohhrghenucfkphepvddttddumeekiedumeeffeekvdemvghfledtmeekheeftgemfegrfhegmegvfhegheemsggvudejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddttddumeekiedumeeffeekvdemvghfledtmeekheeftgemfegrfhegmegvfhegheemsggvudejpdhhvghloheplgfkrfggieemvddttddumeekiedumeeffeekvdemvghfledtmeekheeftgemfegrfhegmegvfhegheemsggvudejngdpmhgrihhlfhhrohhmpegrlhgvgiesghhhihhtihdrfhhrpdhnsggprhgtphhtthhopeduvddprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopegrlhgvgihghhhithhisehrihhvohhsihhntgdrtghomhdprhgtphhtthhop
 ehrohhsthgvughtsehgohhoughmihhsrdhorhhgpdhrtghpthhtohepphgruhhlrdifrghlmhhslhgvhiesshhifhhivhgvrdgtohhmpdhrtghpthhtohepphgrlhhmvghrsegurggssggvlhhtrdgtohhmpdhrtghpthhtoheprghouhesvggvtghsrdgsvghrkhgvlhgvhidrvgguuhdprhgtphhtthhopehguhhorhgvnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghjohhrnhesrhhivhhoshhinhgtrdgtohhm
X-GND-Sasl: alex@ghiti.fr

Hi Peter,

On 9/3/25 22:28, Peter Zijlstra wrote:
> On Wed, Sep 03, 2025 at 07:54:29PM +0000, Alexandre Ghiti wrote:
>> kprobe has been broken on riscv for quite some time. There is an attempt
>> [1] to fix that which actually works. This patch works because it enables
>> ARCH_HAVE_NMI_SAFE_CMPXCHG and that makes the ring buffer allocation
>> succeed when handling a kprobe because we handle *all* kprobes in nmi
>> context. We do so because Peter advised us to treat all kernel traps as
>> nmi [2].
>>
>> But that does not seem right for kprobe handling, so instead, treat
>> break traps from kernel as non-nmi.
> You can put a kprobe inside: local_irq_disable(), no? Inside any random
> spinlock region in fact. How is the probe then not NMI like?


Yes yes, in that case that will be NMI-like, sorry this patch is coarse 
grain. The ideal solution would be to re-enable the interrupts if they 
were enabled at the moment of the trap. In that case, would that make 
sense to you?

Thanks,

Alex


>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

