Return-Path: <stable+bounces-180990-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7847B92378
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 18:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA388177F36
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 16:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F93D3112DB;
	Mon, 22 Sep 2025 16:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="EMrPzHIk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-28.smtpout.orange.fr [80.12.242.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559F73112BF;
	Mon, 22 Sep 2025 16:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758558433; cv=none; b=fCQ5MZm8m3xjJyUgv6Rzp/TbO85l+AYnk2U614VzBU8H5EhbnwW/TdazoqMrEIX/5YJxoSldjstX/b4aCOoEhvb5zsSYKVsaFgEEvh7ANiDo5RZeUPaC/8t92tTn7hBOqgcQLQlBKZ75WaVALjdDWtr+cLokSKvTFYR6aaTgO+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758558433; c=relaxed/simple;
	bh=0WZeePctaXJTfHXGqOsHEP/CVINofRQZG8BFnjJa3Yk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D4/HjYvbdWiGE7E6dsTD7Gs9PIogFYO1j17LeGncRUardJnmwPduKzGjLVaigDNTFdchrmpLhU+DOMoHz3DBHhOQliUUZK2BADYyxeGSVwhngA21w/q1eu+N4P+0ctNLOvc2yfueIvY/vu+H5w9DBHby6NibBmE3FXgL/1Yv74Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=EMrPzHIk; arc=none smtp.client-ip=80.12.242.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id 0jNavqzqDFsG90jNavMclW; Mon, 22 Sep 2025 18:27:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1758558428;
	bh=BPCGKEaZqcaAW9eCNNuUTqO8gdvHoT6lFp43/zZE20E=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=EMrPzHIko64lPi6DPgWlZ6Q8XSPYroCk3hYuuAOVVL+E+Sd5JWRnyy7ANDELgFLcU
	 zbnsCqAOhfoIF85U2d6kQdyUz6B6kEVrP+6Dr9ZuqdWuiKLEVRirzZkvyXJok6vsL6
	 XWck3kX4nDEo82ljCKFbHjHRUCIMEBJlQYgPyQydrIoHWzs4yvg1M3zUsHOha9baUx
	 h/Kj1MNf8yZ6zvi4iVJlCi9ZPMkvfkRbTxQMC6oEElVXefnoQ2t4cmj7ayHWGJIWyz
	 EhkGUo11bwt2KoctuzdL7VQDXUNV1oPw5FiVJpldnjr5qmtD8d3nVA/jeE75GM4Gj+
	 nc5Jomjzd/1sA==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Mon, 22 Sep 2025 18:27:08 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
Message-ID: <3aaa6c7d-647f-47e6-a5fe-0051cf58cd2b@wanadoo.fr>
Date: Mon, 22 Sep 2025 18:27:06 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] powerpc/smp: Add check for kcalloc() failure in
 parse_thread_groups()
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
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
 <496a8ed4-b416-47f9-be1f-cda5472d004d@csgroup.eu>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Content-Language: en-US, fr-FR
In-Reply-To: <496a8ed4-b416-47f9-be1f-cda5472d004d@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 22/09/2025 à 18:07, Christophe Leroy a écrit :
> 
> 
> Le 22/09/2025 à 17:38, Christophe JAILLET a écrit :
>> Le 22/09/2025 à 17:10, Guangshuo Li a écrit :
>>> As kcalloc() may fail, check its return value to avoid a NULL pointer
>>> dereference when passing it to of_property_read_u32_array().
>>>
>>> Fixes: 790a1662d3a26 ("powerpc/smp: Parse ibm,thread-groups with 
>>> multiple properties")
>>> Cc: stable@vger.kernel.org
>>
>> Signed-off-by that was part of v1, is missing in v2.
> 
> I see it below the ---
> 
>>
>>> ---
>>> changelog:
>>> v2:
>>> - Return -ENOMEM directly on allocation failure.
>>
>> Except for a newline that is removed, v2 is the same as v1, or I miss 
>> something?
> 
> v1 was:
> 
> +       if (!thread_group_array) {
> +               ret = -ENOMEM;
> +               goto out_free;
> +       }
> 
> Which was wrong.
> 
> Well maybe there was several v1, I'm talking about https:// 
> lore.kernel.org/all/20250918131513.3557422-1-lgs201920130244@gmail.com/

Mine, was 
https://lore.kernel.org/lkml/20250922150442.1820675-1-lgs201920130244@gmail.com/

and apparently, there as been 3 v1 : 
https://lore.kernel.org/lkml/?q=powerpc%2Fsmp%3A+Add+check+for+kcalloc%28%29+in+parse_thread_groups%28%29

:/

CJ

> 
>>
>> CJ
>>
>>>
>>> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
>>> ---
>>>   arch/powerpc/kernel/smp.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
>>> index 5ac7084eebc0..cfccb9389760 100644
>>> --- a/arch/powerpc/kernel/smp.c
>>> +++ b/arch/powerpc/kernel/smp.c
>>> @@ -822,6 +822,8 @@ static int parse_thread_groups(struct device_node 
>>> *dn,
>>>       count = of_property_count_u32_elems(dn, "ibm,thread-groups");
>>>       thread_group_array = kcalloc(count, sizeof(u32), GFP_KERNEL);
>>> +    if (!thread_group_array)
>>> +        return -ENOMEM;
>>>       ret = of_property_read_u32_array(dn, "ibm,thread-groups",
>>>                        thread_group_array, count);
>>>       if (ret)
>>
> 
> 
> 


