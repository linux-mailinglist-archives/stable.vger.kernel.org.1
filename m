Return-Path: <stable+bounces-180555-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 330ECB85CB4
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 17:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF72D5636B4
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 15:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B51231283A;
	Thu, 18 Sep 2025 15:50:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803E3313540;
	Thu, 18 Sep 2025 15:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210642; cv=none; b=CGzckNdgl+YwmMenHLq+awfj0CpvlNSJJYD25c2V3BerL28YHp93bQVeTA/4NhbtyB+2n8/lachbKov5C5oqUCcxhMVDOLSnPDUK/lEv7mc2u/avTnR8UU9PVu/ZELW/IifGX62t8/mx3faaGSvu3RJeLVHWNTr0NzeAxcRIm64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210642; c=relaxed/simple;
	bh=Prh02CQG9ODvGSXqACqCSdotMXdagtSWRb0Bf36A2pQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oR3lF/lmi2a2vr1T+1HN9ZTSGlwrX2JrYvWW7wT83bKuUrdSgzyA5t4Q1A9L/8ZH+DiHdxtaDhp2mgrbNskAa8OHS8EGKksHAtftW0zjw9Zklk6w+3/p20tuWsb4rpwICa8eNzR/QMXFGbzcd9tLYQuEVAY7NjxI9PRrlqDmKN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cSK5K1F5gz9shQ;
	Thu, 18 Sep 2025 17:17:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FqKmve-d9GL7; Thu, 18 Sep 2025 17:17:57 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cSK5K0PKRz9shF;
	Thu, 18 Sep 2025 17:17:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id EFA5D8B775;
	Thu, 18 Sep 2025 17:17:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id yA9-sMw8lPFZ; Thu, 18 Sep 2025 17:17:56 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 55C098B767;
	Thu, 18 Sep 2025 17:17:56 +0200 (CEST)
Message-ID: <7c0c53bc-1436-4a48-8afa-8bfff439ce67@csgroup.eu>
Date: Thu, 18 Sep 2025 17:17:55 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/smp: Add check for kcalloc() in
 parse_thread_groups()
To: Guangshuo Li <lgs201920130244@gmail.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20250918131513.3557422-1-lgs201920130244@gmail.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <20250918131513.3557422-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 18/09/2025 à 15:15, Guangshuo Li a écrit :
> [Vous ne recevez pas souvent de courriers de lgs201920130244@gmail.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> As kcalloc() may fail, check its return value to avoid a NULL pointer
> dereference when passing it to of_property_read_u32_array().
> 
> Fixes: 790a1662d3a26 ("powerpc/smp: Parse ibm,thread-groups with multiple properties")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>   arch/powerpc/kernel/smp.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 5ac7084eebc0..fa0cd3f7a93c 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -822,6 +822,10 @@ static int parse_thread_groups(struct device_node *dn,
> 
>          count = of_property_count_u32_elems(dn, "ibm,thread-groups");
>          thread_group_array = kcalloc(count, sizeof(u32), GFP_KERNEL);
> +       if (!thread_group_array) {
> +               ret = -ENOMEM;
> +               goto out_free;

out_free does nothing as thread_group_array is NULL, so don't goto 
out_free, instead return -ENOMEM immediately:

	if (!thread_group_array)
		return -ENOMEM;


> +       }
>          ret = of_property_read_u32_array(dn, "ibm,thread-groups",
>                                           thread_group_array, count);
>          if (ret)
> --
> 2.43.0
> 


