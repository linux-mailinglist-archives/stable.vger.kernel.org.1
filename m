Return-Path: <stable+bounces-155328-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E81AE39A6
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 11:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B1D41896725
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 09:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5AF221B19D;
	Mon, 23 Jun 2025 09:16:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B2813FD86;
	Mon, 23 Jun 2025 09:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750670162; cv=none; b=ohfmvWSR6VD1EYlrONZ3BzDZf20KMc5JaEGXM9z/M+90z9jVLiG6Cuio95kk7a9ijGRYh4Aj/pSyN+hVM/DpNZiO85DrWOaii4nL60Ml/dLNyuQ6EfzAXPnWpkTQLEZXEH3srGax2ZE7uTBa5KwBVlhd2PCGhGH2/9lJHmQBbvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750670162; c=relaxed/simple;
	bh=CdYWB1HHn5KIwcQQ9Kqi9JFPTBckXzWwoZEkVi60h3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RhHUTcgNnG2lgMEwD/jQUGwFk3LS4m+s8mKvPnZYabjLuHTq+oKM5AAFUzMqHCdp+FZs9QIVUxXZPZRxf47Jk5advIK7QEM2qMyeg48e1+uByyoE18N4hIl1Qb4o5a4EPDicOZ2H4kRz5gjDxkZJWTSaRng+xqKuwBt0+nDDm7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id BD23D41B5F;
	Mon, 23 Jun 2025 09:15:48 +0000 (UTC)
Message-ID: <027ef1a9-6a5c-4dba-8816-159411739b71@ghiti.fr>
Date: Mon, 23 Jun 2025 11:15:48 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "riscv: Define TASK_SIZE_MAX for __access_ok()"
To: Nam Cao <namcao@linutronix.de>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: rtm@csail.mit.edu, stable@vger.kernel.org
References: <20250619155858.1249789-1-namcao@linutronix.de>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250619155858.1249789-1-namcao@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdduieeigecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeetlhgvgigrnhgurhgvucfihhhithhiuceorghlvgigsehghhhithhirdhfrheqnecuggftrfgrthhtvghrnhephffhuddtveegleeggeefledtudfhudelvdetudfhgeffffeigffgkeethfejudejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddttddumeekiedumeeffeekvdemvghfledtmedvieeijeemvgejvgdtmeehudeltdemfhgvtdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddttddumeekiedumeeffeekvdemvghfledtmedvieeijeemvgejvgdtmeehudeltdemfhgvtdehpdhhvghloheplgfkrfggieemvddttddumeekiedumeeffeekvdemvghfledtmedvieeijeemvgejvgdtmeehudeltdemfhgvtdehngdpmhgrihhlfhhrohhmpegrlhgvgiesghhhihhtihdrfhhrpdhnsggprhgtphhtthhopeekpdhrtghpthhtohepnhgrmhgtrghosehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepphgruhhlrdifrghlmhhslhgvhiesshhifhhivhgvrdgtohhmpdhrtghpthhtohepp
 hgrlhhmvghrsegurggssggvlhhtrdgtohhmpdhrtghpthhtoheprghouhesvggvtghsrdgsvghrkhgvlhgvhidrvgguuhdprhgtphhtthhopehlihhnuhigqdhrihhstghvsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhtmhestghsrghilhdrmhhithdrvgguuhdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: alex@ghiti.fr

Hi Nam,

On 6/19/25 17:58, Nam Cao wrote:
> This reverts commit ad5643cf2f69 ("riscv: Define TASK_SIZE_MAX for
> __access_ok()").
>
> This commit changes TASK_SIZE_MAX to be LONG_MAX to optimize access_ok(),
> because the previous TASK_SIZE_MAX (default to TASK_SIZE) requires some
> computation.
>
> The reasoning was that all user addresses are less than LONG_MAX, and all
> kernel addresses are greater than LONG_MAX. Therefore access_ok() can
> filter kernel addresses.
>
> Addresses between TASK_SIZE and LONG_MAX are not valid user addresses, but
> access_ok() let them pass. That was thought to be okay, because they are
> not valid addresses at hardware level.
>
> Unfortunately, one case is missed: get_user_pages_fast() happily accepts
> addresses between TASK_SIZE and LONG_MAX. futex(), for instance, uses
> get_user_pages_fast(). This causes the problem reported by Robert [1].
>
> Therefore, revert this commit. TASK_SIZE_MAX is changed to the default:
> TASK_SIZE.
>
> This unfortunately reduces performance, because TASK_SIZE is more expensive
> to compute compared to LONG_MAX. But correctness first, we can think about
> optimization later, if required.
>
> Reported-by: <rtm@csail.mit.edu>
> Closes: https://lore.kernel.org/linux-riscv/77605.1750245028@localhost/
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> Cc: stable@vger.kernel.org
> ---
>   arch/riscv/include/asm/pgtable.h | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 438ce7df24c39..5bd5aae60d536 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -1075,7 +1075,6 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
>    */
>   #ifdef CONFIG_64BIT
>   #define TASK_SIZE_64	(PGDIR_SIZE * PTRS_PER_PGD / 2)
> -#define TASK_SIZE_MAX	LONG_MAX
>   
>   #ifdef CONFIG_COMPAT
>   #define TASK_SIZE_32	(_AC(0x80000000, UL) - PAGE_SIZE)


I agree with this revert, the next step is to implement the same 
optimization using alternatives (like x86 does).

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

It should land into -fixes.

Thanks,

Alex


