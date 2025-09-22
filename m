Return-Path: <stable+bounces-180987-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D84B92342
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 18:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22F0B16FE8D
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 16:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CDF311944;
	Mon, 22 Sep 2025 16:20:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36271311595;
	Mon, 22 Sep 2025 16:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758558038; cv=none; b=tQQzCv9QAxFwKm99TE9KaBK6bAt9Zxu8GoPfgeIPbLA+OQh6MoQ/FTypSPF/l7bKDkVVtGizPwaIohnO2BkerPHvs2ftZUoqH0uYxULQ0M76Flx3Xam5yTLZzJCwgEFEiPIOnxEnIzv9zF+RLJy/eRH44J6Oj+9H44EEKpvt8FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758558038; c=relaxed/simple;
	bh=/b6LZkKz++JM5BAJmEVxfRNTiKyfcQ7AX3Z9ffGHfjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hw57zo6gSahTtS9oEQ3hDZIOOeStTbFE45+bLXhfHqS7FteHDt7xFm8mSFTfIk/cebHfKjx+arw5sjjkoWFIYhfVHEl1/mNAX+Yebti9GOygfpn7SMiFqoyxurU8txQ3HJD5Ji5QVNXx/YdqSAUn5wGB67xipdQJxItZLV0RvCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cVnyB1Lhlz9sSL;
	Mon, 22 Sep 2025 18:05:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RQGetHUt7Al8; Mon, 22 Sep 2025 18:05:22 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cVnyB0Zhlz9sSK;
	Mon, 22 Sep 2025 18:05:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id F32C18B768;
	Mon, 22 Sep 2025 18:05:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 1HyZsWwZsQmv; Mon, 22 Sep 2025 18:05:21 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 891948B763;
	Mon, 22 Sep 2025 18:05:20 +0200 (CEST)
Message-ID: <71cabf42-ce79-4030-a08e-475275c19f05@csgroup.eu>
Date: Mon, 22 Sep 2025 18:05:19 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] powerpc/smp: Add check for kcalloc() failure in
 parse_thread_groups()
To: Guangshuo Li <lgs201920130244@gmail.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20250922151025.1821411-1-lgs201920130244@gmail.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <20250922151025.1821411-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 22/09/2025 à 17:10, Guangshuo Li a écrit :
> [Vous ne recevez pas souvent de courriers de lgs201920130244@gmail.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> As kcalloc() may fail, check its return value to avoid a NULL pointer
> dereference when passing it to of_property_read_u32_array().
> 
> Fixes: 790a1662d3a26 ("powerpc/smp: Parse ibm,thread-groups with multiple properties")
> Cc: stable@vger.kernel.org
> ---
> changelog:
> v2:
> - Return -ENOMEM directly on allocation failure.
> 
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

The Signed-off-by: must be above the ---, otherwise it will be lost when 
applying the commit.

With that fixed,

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>



> ---
>   arch/powerpc/kernel/smp.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 5ac7084eebc0..cfccb9389760 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -822,6 +822,8 @@ static int parse_thread_groups(struct device_node *dn,
> 
>          count = of_property_count_u32_elems(dn, "ibm,thread-groups");
>          thread_group_array = kcalloc(count, sizeof(u32), GFP_KERNEL);
> +       if (!thread_group_array)
> +               return -ENOMEM;
>          ret = of_property_read_u32_array(dn, "ibm,thread-groups",
>                                           thread_group_array, count);
>          if (ret)
> --
> 2.43.0
> 


