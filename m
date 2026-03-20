Return-Path: <stable+bounces-227555-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iG75DzFivWlF9gIAu9opvQ
	(envelope-from <stable+bounces-227555-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 16:05:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E762DC47C
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 16:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EE22D302D728
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 14:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825443C7E08;
	Fri, 20 Mar 2026 14:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQltsbGi"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BED03C73C6
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 14:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774018393; cv=none; b=c83pUQJovid6KoT1wB/og1HBuT1HaNBkSOxVHCdZO6dGmZATDA6mtBY0hYncY5sp0e2odOVezEr3HY/0mptqgSxk6v8GyblhOa0gMXpVR6jcb+QI+jdhEQFHe0VklBxoSSXew4FTunxHIntJGmt6hccqUEDL5bldyXRzhoIqkmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774018393; c=relaxed/simple;
	bh=Jfmttwx8FBEnXpEGQIu0ujjRU8fBebfRwySfXrGmTaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NLWs6I9II5g3pVADNOVf6EJfJbMiVhsjYsqsY38sGPTuBTO9I8lPDDbo0zrVxv3RKMckHqFCXgCVNTmiN2MPOyJlM9NFxtAbGTwJNns6bL+t183Hn6+PWaQ26rWRGZ11htwbU3pBfT3FaF87+FF15Ii4E4K7IzX4LRulaFTjpTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQltsbGi; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82c20f1e890so308778b3a.3
        for <stable@vger.kernel.org>; Fri, 20 Mar 2026 07:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774018390; x=1774623190; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=rTHKXCWTdDkx4cn++Ba0jyyHVgHk9d/lYR5yOZKUNRA=;
        b=IQltsbGiz6ehLog+mWJ2KaQqA55FebXU+UpXz7b//FMAY7KE1Wl02lRyC7603Bb1QX
         0gLe5IfAYano0fqjTeNvhHzGEcvaRUYvBQIk6Fbct1BIXV81xOeHAfPmPeX9h8l6P7fT
         QxWp1mile5sH3hAxjAUnhAarGFbMFf5gUBkaW5cWpCZf4CaXjcuI1j8vBHsG7TyffcVg
         n+WtggHZMmIYSX6s6bhlVi3i/ugWjdAeL7KGG9p11iZovBKC/QvHB2YUhbm1cpotpsTL
         LZYR+PCLtzW6xSWSatCD2FOTdHJuk8y/Jam+l3W/NB55QiEMJ0Vq/RK6mfZ7jesnEgiZ
         /0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774018390; x=1774623190;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rTHKXCWTdDkx4cn++Ba0jyyHVgHk9d/lYR5yOZKUNRA=;
        b=FRmJlGzDPBC5zAIM08i3zVNU5msON6ausx7d1mcbZRh5tqry9DNiwSXYQu7/LbxWOo
         8Eal1GeLDv8pBanl4TQ1wdS93rUJnv8fQH+U4tGhu3HXp+ShArRUn3jZj4dOaHTd7w52
         de/lmlNZiwuaEb0dwsn2+A55/aG0G3DkZ3o/00RYeL9ktN/RLs6KBj/ggC3kiOlbAmab
         kMjzgE6y+ae8JMnjcWww4kcKw/8ZxqK/7ZhMUpmmc4ROMhm8ykoQqOAnw6XFhujKHYdm
         1kaBiLv53BjJRH8JY6Yim53yGjf5MByAtL6e3uA9cLzWXdTm3vngrHwdeUON7oFrtVid
         9/7A==
X-Forwarded-Encrypted: i=1; AJvYcCV6gJPn0aP6LA/hEzbUgwavmcGMAnU9fz994S1439W/EuI1OjVPFdkx7ZD5yEF6YgrMpVNX5EI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ9qU38ZRvyDBPVrcn2rTjWvhWGprSbpc8Qp9dd4ABpWyzTw9r
	b9wvZagX/QokUt59nrAClWU3qo+HCGAzDWHQ50WFyhqMi0yPom0aAKQP
X-Gm-Gg: ATEYQzxQ2ks940p7ARU063opebKbJpAxMVaIGwBlFCcoZycfQdN1+naZC1MGspHEOcF
	IEyVtBop8rBaNZA98nLyT4hESzCqGhl9H/vUFWq6h5AfzRdxe3mlxa2rDLBoP38yWaFnWk0vZk9
	V5gJ69Ptolf69jD2+kxe/7aYzwnOITjoYX1pW3WG2/FQfsGDlJpphWdoM0HihCik20rhLpmAyCk
	4LTsOzOI66b+HDy4ZO7QweZQRPmx+klhbi3/aTTO4chUA6uvgAuxxHIEpQT8IQLhZ7F/KQA8wRx
	LXW13KB46WJsGBvIcwenYeEnVjkWO/PpB9hP2PYHCmzTmJvJhV7khMqaND8XqYEoWoaOBm+Nc2A
	KcAEEE+5GogkyXFiaobLBkLWvufDLOpfV5pHlGDB6fFifUzBAGOwa0sh4YAw4h0In8AW5DsCZ/Q
	lU8+oQLdC0HS4Lngy3quNjKVDu7HH9v8IX8RYWJQrmpOe5/Wa7TrS+8W0RzIA14t3fvenO66Wc
X-Received: by 2002:a05:6a00:3491:b0:82a:955:50d3 with SMTP id d2e1a72fcca58-82a8c395ad2mr2483562b3a.45.1774018390304;
        Fri, 20 Mar 2026 07:53:10 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b03bbf0c2sm2799129b3a.15.2026.03.20.07.53.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 07:53:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b58a981a-6264-42d9-b158-650dd194ca9c@roeck-us.net>
Date: Fri, 20 Mar 2026 07:53:08 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/efi: defer freeing of boot services memory
To: Mike Rapoport <rppt@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
 Ard Biesheuvel <ardb@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Thomas Gleixner <tglx@kernel.org>, linux-efi@vger.kernel.org,
 linux-mm@kvack.org, stable@vger.kernel.org
References: <20260225065555.2471844-1-rppt@kernel.org>
 <100b9ae1-74cc-48b3-ba63-1a72cfa2ebbd@roeck-us.net>
 <ab1U59ye2eBOz6x3@kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <ab1U59ye2eBOz6x3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-227555-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[roeck-us.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,roeck-us.net:email,roeck-us.net:mid]
X-Rspamd-Queue-Id: D1E762DC47C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/20/26 07:08, Mike Rapoport wrote:
> On Thu, Mar 19, 2026 at 09:06:52PM -0700, Guenter Roeck wrote:
>> Hi,
>>
>>> +void __init efi_unmap_boot_services(void)
>>>   {
>>>   	struct efi_memory_map_data data = { 0 };
>>>   	efi_memory_desc_t *md;
>>>   	int num_entries = 0;
>>> +	int idx = 0;
>>> +	size_t sz;
>>>   	void *new, *new_md;
>>>   
>>>   	/* Keep all regions for /sys/kernel/debug/efi */
>>>   	if (efi_enabled(EFI_DBG))
>>>   		return;
>>>   
>>> +	sz = sizeof(*ranges_to_free) * efi.memmap.nr_map + 1;
>>
>> Was this possibly supposed to be
>> 	sz = sizeof(*ranges_to_free) * (efi.memmap.nr_map + 1);
>> 				       ^		     ^
>> ?
> 
> Yes, thanks for catching this.
>   

Thanks for confirming.

Just for the record, it wasn't really me, it was an instance of Sashiko
running on the LTS backport of the patch.

Guenter

> @Ard, can you please pick the fix:
> 
>  From 8fc5c5e828e7d127e6210bc9952451300591cdce Mon Sep 17 00:00:00 2001
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> Date: Fri, 20 Mar 2026 15:59:48 +0200
> Subject: [PATCH] x86/efi: efi_unmap_boot_services: fix calculation of
>   ranges_to_free size
> 
> ranges_to_free array should have enough room to store the entire EFI
> memmap plus an extra element for NULL entry.
> The calculation of this array size wrongly adds 1 to the overall size
> instead of adding 1 to the number of elements.
> 
> Add parentheses to properly size the array.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Fixes: a4b0bf6a40f3 ("x86/efi: defer freeing of boot services memory")
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>   arch/x86/platform/efi/quirks.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
> index 35caa5746115..79f0818131e8 100644
> --- a/arch/x86/platform/efi/quirks.c
> +++ b/arch/x86/platform/efi/quirks.c
> @@ -424,7 +424,7 @@ void __init efi_unmap_boot_services(void)
>   	if (efi_enabled(EFI_DBG))
>   		return;
>   
> -	sz = sizeof(*ranges_to_free) * efi.memmap.nr_map + 1;
> +	sz = sizeof(*ranges_to_free) * (efi.memmap.nr_map + 1);
>   	ranges_to_free = kzalloc(sz, GFP_KERNEL);
>   	if (!ranges_to_free) {
>   		pr_err("Failed to allocate storage for freeable EFI regions\n");


