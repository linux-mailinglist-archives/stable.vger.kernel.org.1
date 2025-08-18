Return-Path: <stable+bounces-169936-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B390AB29BB9
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 10:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 385F018A7645
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 08:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF49429B8E8;
	Mon, 18 Aug 2025 08:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJMTFD2u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF6F27A448;
	Mon, 18 Aug 2025 08:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755504705; cv=none; b=q41ixDQuEiiYWEsHcIZWhoJqnl0iE3SGhYaZvglKK50FWgUt3fIZy3Bt8jVqfaVXsM+xYbBgmVSVS6gBjWKrywFLpCMmc7RKG4OI9mPHxbzSVNA2zFPjgOGdIdmAWXlRtRkKc78i1mH77iLmbNc97ERVlPEoePTbSkkZVHjYmMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755504705; c=relaxed/simple;
	bh=DP1KwazJClhVRXDrH8PWSnWLV9BsJ0COvD3e1e112j8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WP3ykHzw7cCx1FVp4SaavzdsYiZXvzO4jpQNxMD70NIsWhugVxa/DkvlvsILnUv0YGk3U80ryUGq6/bX7TN3fbs6qZJk8fKTptTgydLz4SClsPnwz9ULPuHJCsgN2fMKsrf0Fqk7sVE3rymqFFps9iZwkcvYq1McUvE8vfnYT1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sJMTFD2u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73DAC4CEEB;
	Mon, 18 Aug 2025 08:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755504705;
	bh=DP1KwazJClhVRXDrH8PWSnWLV9BsJ0COvD3e1e112j8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sJMTFD2uI0JkILTnes8k6jr6NjS/+jH9DNG+uSbV/PURDCsjvhBS2up6rStMzrYpg
	 ROlxVInCCtaFEUp77ikP/xDRAa4ThG2Y0hlDxEqOED7f98taYVd3FLbnD0uUmwY0X+
	 reGOGTubd9nX+nAHaaleplrtKd1S23ZZNnG0fdMYebLWcNCRzLMHmYhQjfyTyS6zgI
	 E2VDZyhCrrlm2ZDRtuM4uFeCNwXyKT01GPYKdsUErCtz66cW214dhLcl1HIeoZQKBI
	 UaaLZOdiqgxsmcx3x3XSZEb8KqkyVz2c4IrFeAnW3NOzPkpc4nY8wCHO45bmJMNNMs
	 GJNybeRqAIqug==
Message-ID: <6b4debbf-028d-49e0-858f-dc72b37948c7@kernel.org>
Date: Mon, 18 Aug 2025 10:11:41 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] proc: fix wrong behavior of FMODE_LSEEK clearing for net
 related proc file
To: wangzijie <wangzijie1@honor.com>
Cc: adobriyan@gmail.com, akpm@linux-foundation.org, ast@kernel.org,
 gregkh@linuxfoundation.org, polynomial-c@gmx.de,
 regressions@lists.linux.dev, rick.p.edgecombe@intel.com,
 stable@vger.kernel.org, viro@zeniv.linux.org.uk, k.shutemov@gmail.com
References: <f2ff00e6-a931-4c61-a43d-fb3e450f7ffd@kernel.org>
 <20250818080125.843285-1-wangzijie1@honor.com>
 <c3866652-dcba-4cc7-b2b3-8c33a8898ccd@kernel.org>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 xsFNBE6S54YBEACzzjLwDUbU5elY4GTg/NdotjA0jyyJtYI86wdKraekbNE0bC4zV+ryvH4j
 rrcDwGs6tFVrAHvdHeIdI07s1iIx5R/ndcHwt4fvI8CL5PzPmn5J+h0WERR5rFprRh6axhOk
 rSD5CwQl19fm4AJCS6A9GJtOoiLpWn2/IbogPc71jQVrupZYYx51rAaHZ0D2KYK/uhfc6neJ
 i0WqPlbtIlIrpvWxckucNu6ZwXjFY0f3qIRg3Vqh5QxPkojGsq9tXVFVLEkSVz6FoqCHrUTx
 wr+aw6qqQVgvT/McQtsI0S66uIkQjzPUrgAEtWUv76rM4ekqL9stHyvTGw0Fjsualwb0Gwdx
 ReTZzMgheAyoy/umIOKrSEpWouVoBt5FFSZUyjuDdlPPYyPav+hpI6ggmCTld3u2hyiHji2H
 cDpcLM2LMhlHBipu80s9anNeZhCANDhbC5E+NZmuwgzHBcan8WC7xsPXPaiZSIm7TKaVoOcL
 9tE5aN3jQmIlrT7ZUX52Ff/hSdx/JKDP3YMNtt4B0cH6ejIjtqTd+Ge8sSttsnNM0CQUkXps
 w98jwz+Lxw/bKMr3NSnnFpUZaxwji3BC9vYyxKMAwNelBCHEgS/OAa3EJoTfuYOK6wT6nadm
 YqYjwYbZE5V/SwzMbpWu7Jwlvuwyfo5mh7w5iMfnZE+vHFwp/wARAQABzSFKaXJpIFNsYWJ5
 IDxqaXJpc2xhYnlAa2VybmVsLm9yZz7CwXcEEwEIACEFAlW3RUwCGwMFCwkIBwIGFQgJCgsC
 BBYCAwECHgECF4AACgkQvSWxBAa0cEnVTg//TQpdIAr8Tn0VAeUjdVIH9XCFw+cPSU+zMSCH
 eCZoA/N6gitEcnvHoFVVM7b3hK2HgoFUNbmYC0RdcSc80pOF5gCnACSP9XWHGWzeKCARRcQR
 4s5YD8I4VV5hqXcKo2DFAtIOVbHDW+0okOzcecdasCakUTr7s2fXz97uuoc2gIBB7bmHUGAH
 XQXHvdnCLjDjR+eJN+zrtbqZKYSfj89s/ZHn5Slug6w8qOPT1sVNGG+eWPlc5s7XYhT9z66E
 l5C0rG35JE4PhC+tl7BaE5IwjJlBMHf/cMJxNHAYoQ1hWQCKOfMDQ6bsEr++kGUCbHkrEFwD
 UVA72iLnnnlZCMevwE4hc0zVhseWhPc/KMYObU1sDGqaCesRLkE3tiE7X2cikmj/qH0CoMWe
 gjnwnQ2qVJcaPSzJ4QITvchEQ+tbuVAyvn9H+9MkdT7b7b2OaqYsUP8rn/2k1Td5zknUz7iF
 oJ0Z9wPTl6tDfF8phaMIPISYrhceVOIoL+rWfaikhBulZTIT5ihieY9nQOw6vhOfWkYvv0Dl
 o4GRnb2ybPQpfEs7WtetOsUgiUbfljTgILFw3CsPW8JESOGQc0Pv8ieznIighqPPFz9g+zSu
 Ss/rpcsqag5n9rQp/H3WW5zKUpeYcKGaPDp/vSUovMcjp8USIhzBBrmI7UWAtuedG9prjqfO
 wU0ETpLnhgEQAM+cDWLL+Wvc9cLhA2OXZ/gMmu7NbYKjfth1UyOuBd5emIO+d4RfFM02XFTI
 t4MxwhAryhsKQQcA4iQNldkbyeviYrPKWjLTjRXT5cD2lpWzr+Jx7mX7InV5JOz1Qq+P+nJW
 YIBjUKhI03ux89p58CYil24Zpyn2F5cX7U+inY8lJIBwLPBnc9Z0An/DVnUOD+0wIcYVnZAK
 DiIXODkGqTg3fhZwbbi+KAhtHPFM2fGw2VTUf62IHzV+eBSnamzPOBc1XsJYKRo3FHNeLuS8
 f4wUe7bWb9O66PPFK/RkeqNX6akkFBf9VfrZ1rTEKAyJ2uqf1EI1olYnENk4+00IBa+BavGQ
 8UW9dGW3nbPrfuOV5UUvbnsSQwj67pSdrBQqilr5N/5H9z7VCDQ0dhuJNtvDSlTf2iUFBqgk
 3smln31PUYiVPrMP0V4ja0i9qtO/TB01rTfTyXTRtqz53qO5dGsYiliJO5aUmh8swVpotgK4
 /57h3zGsaXO9PGgnnAdqeKVITaFTLY1ISg+Ptb4KoliiOjrBMmQUSJVtkUXMrCMCeuPDGHo7
 39Xc75lcHlGuM3yEB//htKjyprbLeLf1y4xPyTeeF5zg/0ztRZNKZicgEmxyUNBHHnBKHQxz
 1j+mzH0HjZZtXjGu2KLJ18G07q0fpz2ZPk2D53Ww39VNI/J9ABEBAAHCwV8EGAECAAkFAk6S
 54YCGwwACgkQvSWxBAa0cEk3tRAAgO+DFpbyIa4RlnfpcW17AfnpZi9VR5+zr496n2jH/1ld
 wRO/S+QNSA8qdABqMb9WI4BNaoANgcg0AS429Mq0taaWKkAjkkGAT7mD1Q5PiLr06Y/+Kzdr
 90eUVneqM2TUQQbK+Kh7JwmGVrRGNqQrDk+gRNvKnGwFNeTkTKtJ0P8jYd7P1gZb9Fwj9YLx
 jhn/sVIhNmEBLBoI7PL+9fbILqJPHgAwW35rpnq4f/EYTykbk1sa13Tav6btJ+4QOgbcezWI
 wZ5w/JVfEJW9JXp3BFAVzRQ5nVrrLDAJZ8Y5ioWcm99JtSIIxXxt9FJaGc1Bgsi5K/+dyTKL
 wLMJgiBzbVx8G+fCJJ9YtlNOPWhbKPlrQ8+AY52Aagi9WNhe6XfJdh5g6ptiOILm330mkR4g
 W6nEgZVyIyTq3ekOuruftWL99qpP5zi+eNrMmLRQx9iecDNgFr342R9bTDlb1TLuRb+/tJ98
 f/bIWIr0cqQmqQ33FgRhrG1+Xml6UXyJ2jExmlO8JljuOGeXYh6ZkIEyzqzffzBLXZCujlYQ
 DFXpyMNVJ2ZwPmX2mWEoYuaBU0JN7wM+/zWgOf2zRwhEuD3A2cO2PxoiIfyUEfB9SSmffaK/
 S4xXoB6wvGENZ85Hg37C7WDNdaAt6Xh2uQIly5grkgvWppkNy4ZHxE+jeNsU7tg=
In-Reply-To: <c3866652-dcba-4cc7-b2b3-8c33a8898ccd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

k.shutemov no longer @ intel -> use gmail.

On 18. 08. 25, 10:08, Jiri Slaby wrote:
> On 18. 08. 25, 10:01, wangzijie wrote:
>>> Hi,
>>>
>>> On 18. 08. 25, 6:05, wangzijie wrote:
>>>> For avoiding pde->proc_ops->... dereference(which may cause UAF in 
>>>> rmmod race scene),
>>>> we call pde_set_flags() to save this kind of information in PDE 
>>>> itself before
>>>> proc_register() and call pde_has_proc_XXX() to replace pde- 
>>>> >proc_ops->... dereference.
>>>> But there has omission of pde_set_flags() in net related proc file 
>>>> create, which cause
>>>> the wroing behavior of FMODE_LSEEK clearing in proc_reg_open() for 
>>>> net related proc file
>>>> after commit ff7ec8dc1b64("proc: use the same treatment to check 
>>>> proc_lseek as ones for
>>>> proc_read_iter et.al"). Lars reported it in this link[1]. So call 
>>>> pde_set_flags() when
>>>> create net related proc file to fix this bug.
>>>
>>> I wonder, why is pde_set_flags() not a part of proc_register()?
>>
>> Not all proc_dir_entry have proc_ops, so you mean this will be a 
>> better modification?
>>
>> diff --git a/fs/proc/generic.c b/fs/proc/generic.c
>> index 76e800e38..d52197c35 100644
>> --- a/fs/proc/generic.c
>> +++ b/fs/proc/generic.c
>> @@ -367,6 +367,20 @@ static const struct inode_operations 
>> proc_dir_inode_operations = {
>>          .setattr        = proc_notify_change,
>>   };
>>
>> +static void pde_set_flags(struct proc_dir_entry *pde)
>> +{
>> +       if (pde->proc_ops->proc_flags & PROC_ENTRY_PERMANENT)
>> +               pde->flags |= PROC_ENTRY_PERMANENT;
>> +       if (pde->proc_ops->proc_read_iter)
>> +               pde->flags |= PROC_ENTRY_proc_read_iter;
>> +#ifdef CONFIG_COMPAT
>> +       if (pde->proc_ops->proc_compat_ioctl)
>> +               pde->flags |= PROC_ENTRY_proc_compat_ioctl;
>> +#endif
>> +       if (pde->proc_ops->proc_lseek)
>> +               pde->flags |= PROC_ENTRY_proc_lseek;
>> +}
>> +
>>   /* returns the registered entry, or frees dp and returns NULL on 
>> failure */
>>   struct proc_dir_entry *proc_register(struct proc_dir_entry *dir,
>>                  struct proc_dir_entry *dp)
>> @@ -374,6 +388,9 @@ struct proc_dir_entry *proc_register(struct 
>> proc_dir_entry *dir,
>>          if (proc_alloc_inum(&dp->low_ino))
>>                  goto out_free_entry;
>>
>> +       if (dp->proc_ops)

And to be honest, I would possibly move the 'if' into pde_set_flags().

>> +               pde_set_flags(dp);

As here, it is not completely clear why you would want to test 
"dp->proc_ops" for something called "pde_set_flags".

-- 
js
suse labs

