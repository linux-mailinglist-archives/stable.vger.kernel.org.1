Return-Path: <stable+bounces-180988-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BA5B92348
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 18:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF3C4190407D
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 16:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0ED831196B;
	Mon, 22 Sep 2025 16:20:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178AE3115B0;
	Mon, 22 Sep 2025 16:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758558038; cv=none; b=AdLnQ2GahUfV9T2WXgcMXfJc05C/Mf8Ubj1HX1EO0/jWi9UbApzlogYX4La68naXwnHEfAgkU2rlPtRGIpSut3B4a/iMNLU/VAXV7iX+mF9maDkhrAaX6NiiZ0OMu2k456/6USn7z4cAp4+TYAUXV1khJH19Ig2XFYEmPvRYmV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758558038; c=relaxed/simple;
	bh=w3Rks/o7ddO724oJ4zZ5VCqBo/PbM7CidoyxIls/Z48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c/urluN0S1sqnYRVZc0BtblC/gLe5f7SKIjPe5SmXf/J4rz2imc6dVJ3MlUyNjxoRwLBRsrqAP8JmcD4O9riuRPPcIHs+4vvEgHCyrXVd5rvpky3iUsuWzakGqDiDsTJw24vr249NYfa9nsTXXXoc8hzM7AtmeRKNiI2VC9Gz94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cVp180JGjz9sSR;
	Mon, 22 Sep 2025 18:07:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ld71iZbvQBsJ; Mon, 22 Sep 2025 18:07:55 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cVp176jLFz9sSN;
	Mon, 22 Sep 2025 18:07:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id D70678B768;
	Mon, 22 Sep 2025 18:07:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id uyoeSwRWo3u9; Mon, 22 Sep 2025 18:07:55 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 8E8198B763;
	Mon, 22 Sep 2025 18:07:54 +0200 (CEST)
Message-ID: <496a8ed4-b416-47f9-be1f-cda5472d004d@csgroup.eu>
Date: Mon, 22 Sep 2025 18:07:53 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] powerpc/smp: Add check for kcalloc() failure in
 parse_thread_groups()
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Guangshuo Li <lgs201920130244@gmail.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20250922151025.1821411-1-lgs201920130244@gmail.com>
 <a7453bdc-16f3-43e6-a06d-bd6144eeae72@wanadoo.fr>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <a7453bdc-16f3-43e6-a06d-bd6144eeae72@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 22/09/2025 à 17:38, Christophe JAILLET a écrit :
> Le 22/09/2025 à 17:10, Guangshuo Li a écrit :
>> As kcalloc() may fail, check its return value to avoid a NULL pointer
>> dereference when passing it to of_property_read_u32_array().
>>
>> Fixes: 790a1662d3a26 ("powerpc/smp: Parse ibm,thread-groups with 
>> multiple properties")
>> Cc: stable@vger.kernel.org
> 
> Signed-off-by that was part of v1, is missing in v2.

I see it below the ---

> 
>> ---
>> changelog:
>> v2:
>> - Return -ENOMEM directly on allocation failure.
> 
> Except for a newline that is removed, v2 is the same as v1, or I miss 
> something?

v1 was:

+       if (!thread_group_array) {
+               ret = -ENOMEM;
+               goto out_free;
+       }

Which was wrong.

Well maybe there was several v1, I'm talking about 
https://lore.kernel.org/all/20250918131513.3557422-1-lgs201920130244@gmail.com/

> 
> CJ
> 
>>
>> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
>> ---
>>   arch/powerpc/kernel/smp.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
>> index 5ac7084eebc0..cfccb9389760 100644
>> --- a/arch/powerpc/kernel/smp.c
>> +++ b/arch/powerpc/kernel/smp.c
>> @@ -822,6 +822,8 @@ static int parse_thread_groups(struct device_node 
>> *dn,
>>       count = of_property_count_u32_elems(dn, "ibm,thread-groups");
>>       thread_group_array = kcalloc(count, sizeof(u32), GFP_KERNEL);
>> +    if (!thread_group_array)
>> +        return -ENOMEM;
>>       ret = of_property_read_u32_array(dn, "ibm,thread-groups",
>>                        thread_group_array, count);
>>       if (ret)
> 


