Return-Path: <stable+bounces-177707-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A720B43645
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 10:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B40471B23894
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 08:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87282D0638;
	Thu,  4 Sep 2025 08:50:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20BF2C0F8F
	for <stable@vger.kernel.org>; Thu,  4 Sep 2025 08:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756975837; cv=none; b=U9DumgtVolQS6ZNJo0smDsUuLWZqoPmrrEJ1X2s61S6qliL8Mqd3htFHygKZLj0kMasFiaIyym6k9gD3doYFgUepIumewLcPLXewClzJkhjWw+Srtbnl4bAhEhhyqbfoIGoPvKUGZmMLMG0BO1iGI6zQYhI8wYUjzQZnsbUwN+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756975837; c=relaxed/simple;
	bh=1u+k3mH+0J2izAXkehtth/RNqZF+RuGo4o+mAYoMpmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=InUjo6T0eC3kswMk8/z947GSkAC0Gh13qNvpgtxz7UTGwrbvMu4weWL0J6pq79qJnCXDsnsGyZ/L4LO+UBVQYOc2WOUPs5LHCAPZhvtBslygpJ+7tqbFKx5gqsiOzY1PklYjpaIiOtREn4paWTnti5zZR9nsrnQOxeNbeWyTESs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cHXPv6szdz9sSb;
	Thu,  4 Sep 2025 10:16:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q0bCBb93aCZt; Thu,  4 Sep 2025 10:16:51 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cHXPZ2N6dz9sSK;
	Thu,  4 Sep 2025 10:16:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 3C32C8B764;
	Thu,  4 Sep 2025 10:16:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id zHQ165OB1h7X; Thu,  4 Sep 2025 10:16:34 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 03CAE8B763;
	Thu,  4 Sep 2025 10:16:33 +0200 (CEST)
Message-ID: <97fc7eed-c67e-4b5e-90bb-93eb8dd058d7@csgroup.eu>
Date: Thu, 4 Sep 2025 10:16:33 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 only v2] powerpc: boot: Remove leading zero in label
 in udelay()
To: Nathan Chancellor <nathan@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
References: <20250903211158.2844032-1-nathan@kernel.org>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <20250903211158.2844032-1-nathan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 03/09/2025 à 23:11, Nathan Chancellor a écrit :
> When building powerpc configurations in linux-5.4.y with binutils 2.43
> or newer, there is an assembler error in arch/powerpc/boot/util.S:
> 
>    arch/powerpc/boot/util.S: Assembler messages:
>    arch/powerpc/boot/util.S:44: Error: junk at end of line, first unrecognized character is `0'
>    arch/powerpc/boot/util.S:49: Error: syntax error; found `b', expected `,'
>    arch/powerpc/boot/util.S:49: Error: junk at end of line: `b'
> 
> binutils 2.43 contains stricter parsing of certain labels [1], namely
> that leading zeros are no longer allowed. The GNU assembler
> documentation already somewhat forbade this construct:
> 
>    To define a local label, write a label of the form 'N:' (where N
>    represents any non-negative integer).
> 
> Eliminate the leading zero in the label to fix the syntax error. This is
> only needed in linux-5.4.y because commit 8b14e1dff067 ("powerpc: Remove
> support for PowerPC 601") removed this code altogether in 5.10.
> 
> Link: https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=226749d5a6ff0d5c607d6428d6c81e1e7e7a994b [1]
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
> v1 -> v2:
> - Adjust commit message to make it clearer this construct was already
>    incorrect under the existing GNU assembler documentation (Segher)
> 
> v1: https://lore.kernel.org/20250902235234.2046667-1-nathan@kernel.org/
> ---
>   arch/powerpc/boot/util.S | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/boot/util.S b/arch/powerpc/boot/util.S
> index f11f0589a669..5ab2bc864e66 100644
> --- a/arch/powerpc/boot/util.S
> +++ b/arch/powerpc/boot/util.S
> @@ -41,12 +41,12 @@ udelay:
>   	srwi	r4,r4,16
>   	cmpwi	0,r4,1		/* 601 ? */
>   	bne	.Ludelay_not_601
> -00:	li	r0,86	/* Instructions / microsecond? */
> +0:	li	r0,86	/* Instructions / microsecond? */
>   	mtctr	r0
>   10:	addi	r0,r0,0 /* NOP */
>   	bdnz	10b
>   	subic.	r3,r3,1
> -	bne	00b
> +	bne	0b
>   	blr
>   
>   .Ludelay_not_601:
> 
> base-commit: c25f780e491e4734eb27d65aa58e0909fd78ad9f


