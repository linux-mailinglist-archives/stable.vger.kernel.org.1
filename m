Return-Path: <stable+bounces-46276-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7300A8CF995
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 08:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A45091C209EA
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 06:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B3A134B6;
	Mon, 27 May 2024 06:54:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FF51754B;
	Mon, 27 May 2024 06:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716792849; cv=none; b=qAXkp0YZzStJdsDKz6Q6rZK7PQPy8kuMge4zxr/sM9StPqGg393jhgG6Z/E2La10o5XWSLmSYAVQAQ07rk4UPYqdycmorTbGebpRiaACAM8wrwhgwm//uTyJg3lmdRdpjxkMb/O182R1RzGWfuNhqFevpP9I4My+hLE/cgkWdbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716792849; c=relaxed/simple;
	bh=wEmRLmU/0I4+xSi2a6MkXlw+Hd17sMoSYos2JLMQvCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yui+TBmB9uoc5ISY9nNaNrEPMdGKzheFztdcp5WkMxo+KqsbVTrCeDt5hziU2E44MSKChhf2Vh5wAHX66JcJDl2wSd3JfyQUD7vg1XcCXlijRt/cyueKYhCMNagMkAqxlKSvMPiLkRnkjyYK00qwcZmv2/N2Rtly2JTV4JAbNEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id D31F1FF80B;
	Mon, 27 May 2024 06:53:56 +0000 (UTC)
Message-ID: <a00942ea-d208-475d-b595-922d8432ddc6@ghiti.fr>
Date: Mon, 27 May 2024 08:53:56 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: enable HAVE_ARCH_HUGE_VMAP for XIP kernel
Content-Language: en-US
To: Nam Cao <namcao@linutronix.de>, Alexandre Ghiti <alexghiti@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20240526110104.470429-1-namcao@linutronix.de>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240526110104.470429-1-namcao@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Nam,

On 26/05/2024 13:01, Nam Cao wrote:
> HAVE_ARCH_HUGE_VMAP also works on XIP kernel, so remove its dependency on
> !XIP_KERNEL.
>
> This also fixes a boot problem for XIP kernel introduced by the commit in
> "Fixes:". This commit used huge page mapping for vmemmap, but huge page
> vmap was not enabled for XIP kernel.
>
> Fixes: ff172d4818ad ("riscv: Use hugepage mappings for vmemmap")
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> Cc: <stable@vger.kernel.org>
> ---
> This patch replaces:
> https://patchwork.kernel.org/project/linux-riscv/patch/20240508173116.2866192-1-namcao@linutronix.de/
>
>   arch/riscv/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index b94176e25be1..0525ee2d63c7 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -106,7 +106,7 @@ config RISCV
>   	select HAS_IOPORT if MMU
>   	select HAVE_ARCH_AUDITSYSCALL
>   	select HAVE_ARCH_HUGE_VMALLOC if HAVE_ARCH_HUGE_VMAP
> -	select HAVE_ARCH_HUGE_VMAP if MMU && 64BIT && !XIP_KERNEL
> +	select HAVE_ARCH_HUGE_VMAP if MMU && 64BIT
>   	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL
>   	select HAVE_ARCH_JUMP_LABEL_RELATIVE if !XIP_KERNEL
>   	select HAVE_ARCH_KASAN if MMU && 64BIT


Great, thanks!

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Alex


