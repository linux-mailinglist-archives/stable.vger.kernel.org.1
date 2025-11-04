Return-Path: <stable+bounces-192437-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD76C32709
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 18:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 983253ADB45
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 17:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C9632570F;
	Tue,  4 Nov 2025 17:50:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F562F3C28;
	Tue,  4 Nov 2025 17:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762278606; cv=none; b=cfIWs1l2e3uRRNVPKJkQuM6u6tml5Gqeo8q3OCWHVxvIFpJLKQZmbz1UDOlIGMusP49QdTwJ+5RItNgX2mSOzXaJRMCLMSM8uIiicsm9MLiEnD5s7562Yz1qG/2VjZM2ttTHpvSwUq2hFX8tJRI+QEU5spY+/2WsL6UhY0HWvMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762278606; c=relaxed/simple;
	bh=udJ2m632fXvX5DKfm77vXswEpwSjP22xMdTxTUuGdCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NNoM8tMI6r+XvQ0nxDvQTcD1JNJkAzMYB3vgA4hkBTFm3a6j+FyXZXw293sataRW3NC2wATmDix8MVaFC9le5LXgYTSDgWrP85c6DpVDXo5uSkI7WQw6SBJg3GxRia7TOWzY8oNph4Un4POMI4FI3iBt9bXfJ6D6JNcl+S6zlKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4d1FkL5Pf0z9sS7;
	Tue,  4 Nov 2025 18:26:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZFw0wj0g-XqU; Tue,  4 Nov 2025 18:26:50 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4d1FkL4gnPz9sRy;
	Tue,  4 Nov 2025 18:26:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 90CF78B76E;
	Tue,  4 Nov 2025 18:26:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id sWXRh3sG0pVU; Tue,  4 Nov 2025 18:26:50 +0100 (CET)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 84DFE8B76D;
	Tue,  4 Nov 2025 18:26:49 +0100 (CET)
Message-ID: <a0921920-d381-4a67-8b4d-d91e5319a354@csgroup.eu>
Date: Tue, 4 Nov 2025 18:26:48 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/flipper-pic: Fix device node reference leak in
 flipper_pic_init
To: Miaoqian Lin <linmq006@gmail.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Albert Herranz <albert_herranz@yahoo.es>,
 Grant Likely <grant.likely@secretlab.ca>,
 Segher Boessenkool <segher@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20251027150914.59811-1-linmq006@gmail.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <20251027150914.59811-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 27/10/2025 à 16:09, Miaoqian Lin a écrit :
> The flipper_pic_init() function calls of_get_parent() which increases
> the device node reference count, but fails to call of_node_put() to
> balance the reference count.
> 
> Add calls to of_node_put() in all paths to fix the leak.
> 
> Found via static analysis.
> 
> Fixes: 028ee972f032 ("powerpc: gamecube/wii: flipper interrupt controller support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>   arch/powerpc/platforms/embedded6xx/flipper-pic.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/embedded6xx/flipper-pic.c b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
> index 91a8f0a7086e..cf6f795c8d76 100644
> --- a/arch/powerpc/platforms/embedded6xx/flipper-pic.c
> +++ b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
> @@ -135,13 +135,13 @@ static struct irq_domain * __init flipper_pic_init(struct device_node *np)
>   	}
>   	if (!of_device_is_compatible(pi, "nintendo,flipper-pi")) {
>   		pr_err("unexpected parent compatible\n");
> -		goto out;
> +		goto out_put_node;
>   	}
>   
>   	retval = of_address_to_resource(pi, 0, &res);
>   	if (retval) {
>   		pr_err("no io memory range found\n");
> -		goto out;
> +		goto out_put_node;
>   	}
>   	io_base = ioremap(res.start, resource_size(&res));
>   
> @@ -154,9 +154,12 @@ static struct irq_domain * __init flipper_pic_init(struct device_node *np)
>   					      &flipper_irq_domain_ops, io_base);
>   	if (!irq_domain) {
>   		pr_err("failed to allocate irq_domain\n");
> +		of_node_put(pi);

irq_domain is NULL here so instead of adding this of_node_put() you 
could just remove below 'return NULL' (and the {} of the if) and 
fallthrough.

>   		return NULL;
>   	}
>   
> +out_put_node:
> +	of_node_put(pi);
>   out:
>   	return irq_domain;
>   }


