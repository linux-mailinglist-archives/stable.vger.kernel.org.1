Return-Path: <stable+bounces-155124-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A74AE19F1
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 13:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 036FD3A5238
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 11:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7E7283FDA;
	Fri, 20 Jun 2025 11:24:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A330D78F4A;
	Fri, 20 Jun 2025 11:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750418645; cv=none; b=Gt1v6rgTgrMc8BPGaKIdg7G4fUE+VL93EyTLj6/+/FfsLQQ6FXYmawnMtiknpjvNlsaEI0kdbeGTyDWsMxqZRhuvzGmfV4G8SCE5aGqHuvACwFs3wmQVLkF1ZjZcZIig4qfyj/4W34fb93G93ryKjjIEpkelycDZjlIHTM+Xawo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750418645; c=relaxed/simple;
	bh=vPvzD8auiKqrrd5DjYZNOQJwyQxrMebWgV0Mo4yBAs8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F46H0tYYaOeijMOTcR18RBKEojx20aoeWGajDfeThKWu1Lww9UIkI8+eMCRbDpXN2HVXY+8suXCBnn2gPAI9eZXTbFwj1RoGJa4JDz5YieEe1jKEf5UeuWuOjQwQTtjMse0Vm0cDBfWTSthmWAtBe3tcLBR6LP4I+lQJpG9q6KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1307941C7B;
	Fri, 20 Jun 2025 11:23:57 +0000 (UTC)
Message-ID: <f90f6843-4ffd-48a3-9813-0d1c52f8e48e@ghiti.fr>
Date: Fri, 20 Jun 2025 13:23:57 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "riscv: misaligned: fix sleeping function called
 during misaligned access handling"
To: Nam Cao <namcao@linutronix.de>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 Nylon Chen <nylon.chen@sifive.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20250620110939.1642735-1-namcao@linutronix.de>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250620110939.1642735-1-namcao@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdekvdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpeejieeuudejieekveeutdeguefhkeduledugeevhefffeejudeggedufffgleeugfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtddtudemkeeiudemfeefkedvmegvfheltdemkegsgeegmegrvdelsgemvghffhehmeeirgejfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvtddtudemkeeiudemfeefkedvmegvfheltdemkegsgeegmegrvdelsgemvghffhehmeeirgejfhdphhgvlhhopeglkffrggeimedvtddtudemkeeiudemfeefkedvmegvfheltdemkegsgeegmegrvdelsgemvghffhehmeeirgejfhgnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepledprhgtphhtthhopehnrghmtggroheslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehprghulhdrfigrlhhmshhlvgihsehsihhfihhvvgdrtghomhdprhgtphhtthhopehpr
 ghlmhgvrhesuggrsggsvghlthdrtghomhdprhgtphhtthhopegrohhusegvvggtshdrsggvrhhkvghlvgihrdgvughupdhrtghpthhtoheptghlvghgvghrsehrihhvohhsihhntgdrtghomhdprhgtphhtthhopehnhihlohhnrdgthhgvnhesshhifhhivhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqrhhishgtvheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: alex@ghiti.fr

On 6/20/25 13:09, Nam Cao wrote:
> This reverts commit 61a74ad25462 ("riscv: misaligned: fix sleeping function
> called during misaligned access handling"). The commit addresses a sleeping
> in atomic context problem, but it is not the correct fix as explained by
> Clément:
>
> "Using nofault would lead to failure to read from user memory that is paged
> out for instance. This is not really acceptable, we should handle user
> misaligned access even at an address that would generate a page fault."
>
> This bug has been properly fixed by commit 453805f0a28f ("riscv:
> misaligned: enable IRQs while handling misaligned accesses").
>
> Revert this improper fix.
>
> Link: https://lore.kernel.org/linux-riscv/b779beed-e44e-4a5e-9551-4647682b0d21@rivosinc.com/
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> Cc: stable@vger.kernel.org
> ---
>   arch/riscv/kernel/traps_misaligned.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
> index dd8e4af6583f4..93043924fe6c6 100644
> --- a/arch/riscv/kernel/traps_misaligned.c
> +++ b/arch/riscv/kernel/traps_misaligned.c
> @@ -454,7 +454,7 @@ static int handle_scalar_misaligned_load(struct pt_regs *regs)
>   
>   	val.data_u64 = 0;
>   	if (user_mode(regs)) {
> -		if (copy_from_user_nofault(&val, (u8 __user *)addr, len))
> +		if (copy_from_user(&val, (u8 __user *)addr, len))
>   			return -1;
>   	} else {
>   		memcpy(&val, (u8 *)addr, len);
> @@ -555,7 +555,7 @@ static int handle_scalar_misaligned_store(struct pt_regs *regs)
>   		return -EOPNOTSUPP;
>   
>   	if (user_mode(regs)) {
> -		if (copy_to_user_nofault((u8 __user *)addr, &val, len))
> +		if (copy_to_user((u8 __user *)addr, &val, len))
>   			return -1;
>   	} else {
>   		memcpy((u8 *)addr, &val, len);


Of course this is a wrong fix:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks for catching this,

Alex


