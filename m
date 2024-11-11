Return-Path: <stable+bounces-92084-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3246B9C3C0A
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 11:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55C161C216AB
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 10:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F419517B51A;
	Mon, 11 Nov 2024 10:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hSJQGwzn"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415E8156676
	for <stable@vger.kernel.org>; Mon, 11 Nov 2024 10:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731321227; cv=none; b=A9M0bC6+DrHpCWWZQweqVEswIqWvLAqJLUsZ1PKlfjdf3q6MAgtQXdrMxLMjkaW8i9A0zPJWQxiojdaHcvUXyak4czBwqUBzb3geN42LMGqmcZ9B+vCpDvMziwYoxAyoGCHBeVZQE0GIXFXlHqhyZ4P/1/cu5a8uQqUeQwIASYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731321227; c=relaxed/simple;
	bh=nkTiLitoCz0j79MxFwJGUEcQFxOksA+r8B4LuJzWaHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tENvzXtnMHeM4cKmyVyS/GhOcZiSocORxC88FOcApk10pzAuyHKoQT7VZYa6pUvr1H/a4Vwj+nlgifOulONZ8c4Ja+4GYGEQOKiJ+m8q6dns9CTcdWFWO7y9NSYOKFgdjvvNCJKPtPZqs8CI7jZuJKUgQ0PYSUI+uLNNWzzkkoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hSJQGwzn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731321224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UG96reEjGpmStIAjzddjyH3tkwNOTgH/uQ2TqmwJHjA=;
	b=hSJQGwznnvUQidphwUxYAMXF2AnyTWxdKARtdQpALXqfPxbiXnDP6lzl3x8enJHGBS6kkO
	KmkchuTLX3tfO0B1YNlqw+m6SGbvEQV+Id/lFWLXL54EROnL8IvZUqHO3WkBLp17BMeGTp
	yELallb+cz2oWFuxt60cgqy9BdrIE9A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-f5SL1fd8PdOaoWqQcJC8nA-1; Mon, 11 Nov 2024 05:33:42 -0500
X-MC-Unique: f5SL1fd8PdOaoWqQcJC8nA-1
X-Mimecast-MFC-AGG-ID: f5SL1fd8PdOaoWqQcJC8nA
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4315c1b5befso29465665e9.1
        for <stable@vger.kernel.org>; Mon, 11 Nov 2024 02:33:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731321221; x=1731926021;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UG96reEjGpmStIAjzddjyH3tkwNOTgH/uQ2TqmwJHjA=;
        b=mavqDwiitfKPCsRvkW1mR7znJDPu0JAsWgeFd2uB/i74U1hQfSwxzUmZCGAvjGGA+O
         zzBivQ2dhimNjalB5iYqKPtZKzSfnHxMcDFT3OKaS+zVSQsnYE3YtMkUu4Kk8TnAN02f
         mHYoM3xXpBEucZ2xD13QTSp0pIaIU1FCyHDsi1RFmNybsl0JaqiNy8UqaHpErNA7wQT0
         iqtD6FRuWNuozZ1rTaq8xX3i/siqMTrMa4/UQeXJduMQOwUgpIdxrm4IuHurDw2+ytbL
         4THEiXMC5ywj2uNK52Fsp+z73ViLT0ORmwlKMamPVaOK0n556/PWFYfowr5jZzjtiskL
         IJ+A==
X-Forwarded-Encrypted: i=1; AJvYcCUcPGT1zDIkgTzd9ymiZr1H7ouh6o8rG+oYEoLAZyY7T9fbW3Q8LDHiD3QrvlYJzQSjxuInbIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmgFsU07T7lEZr2hHgYfUnzLV8VZ1kKVSFftu1V+CHP+rU4Qos
	dAiRlbJbJLHK/rkWM5DK3X9fSC+tAJrYAwilXJTG4FMRxQuHupKGddv0HZZMwXttUHaKs1Zm5ZF
	Wm6HH+lnGePiBP53RUKWLnGX4/F1P7IxLEh1RQkeUzVPQjse07uaAQw==
X-Received: by 2002:a05:600c:3b09:b0:431:3bf9:3ebb with SMTP id 5b1f17b1804b1-432b7518365mr99473785e9.24.1731321221177;
        Mon, 11 Nov 2024 02:33:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmOK132Rd3omd+xYjBgijs0Ys5mpaNoZZlMVOUcsXMsbgkjv+TrglKeIaOUCZvlCKis7NxSg==
X-Received: by 2002:a05:600c:3b09:b0:431:3bf9:3ebb with SMTP id 5b1f17b1804b1-432b7518365mr99473565e9.24.1731321220757;
        Mon, 11 Nov 2024 02:33:40 -0800 (PST)
Received: from ?IPV6:2003:cb:c730:4300:18eb:6c63:a196:d3a2? (p200300cbc730430018eb6c63a196d3a2.dip0.t-ipconnect.de. [2003:cb:c730:4300:18eb:6c63:a196:d3a2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b0566544sm166915385e9.24.2024.11.11.02.33.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 02:33:40 -0800 (PST)
Message-ID: <85cfc467-320f-4388-b027-2cbad85dfbed@redhat.com>
Date: Mon, 11 Nov 2024 11:33:38 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/readahead: Fix large folio support in async
 readahead
To: Yafang Shao <laoar.shao@gmail.com>, willy@infradead.org,
 akpm@linux-foundation.org
Cc: linux-mm@kvack.org, stable@vger.kernel.org
References: <20241108141710.9721-1-laoar.shao@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241108141710.9721-1-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08.11.24 15:17, Yafang Shao wrote:
> When testing large folio support with XFS on our servers, we observed that
> only a few large folios are mapped when reading large files via mmap.
> After a thorough analysis, I identified it was caused by the
> `/sys/block/*/queue/read_ahead_kb` setting. On our test servers, this
> parameter is set to 128KB. After I tune it to 2MB, the large folio can
> work as expected. However, I believe the large folio behavior should not be
> dependent on the value of read_ahead_kb. It would be more robust if the
> kernel can automatically adopt to it.

Now I am extremely confused.

Documentation/ABI/stable/sysfs-block:

"[RW] Maximum number of kilobytes to read-ahead for filesystems on this 
block device."


So, with your patch, will we also be changing the readahead size to 
exceed that, or simply allocate larger folios and not exceeding the 
readahead size (e.g., leaving them partially non-filled)?

If you're also changing the readahead behavior to exceed the 
configuration parameter it would sound to me like "I am pushing the 
brake pedal and my care brakes; fix the brakes to adopt whether to brake 
automatically" :)

Likely I am missing something here, and how the read_ahead_kb parameter 
is used after your patch.


> 
> With /sys/block/*/queue/read_ahead_kb set to 128KB and performing a
> sequential read on a 1GB file using MADV_HUGEPAGE, the differences in
> /proc/meminfo are as follows:
> 
> - before this patch
>    FileHugePages:     18432 kB
>    FilePmdMapped:      4096 kB
> 
> - after this patch
>    FileHugePages:   1067008 kB
>    FilePmdMapped:   1048576 kB
> 
> This shows that after applying the patch, the entire 1GB file is mapped to
> huge pages. The stable list is CCed, as without this patch, large folios
> don’t function optimally in the readahead path.
 >> It's worth noting that if read_ahead_kb is set to a larger value 
that isn't
> aligned with huge page sizes (e.g., 4MB + 128KB), it may still fail to map
> to hugepages.
> 
> Fixes: 4687fdbb805a ("mm/filemap: Support VM_HUGEPAGE for file mappings")
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: stable@vger.kernel.org
> 
> ---
>   mm/readahead.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> Changes:
> v1->v2:
> - Drop the align (Matthew)
> - Improve commit log (Andrew)
> 
> RFC->v1: https://lore.kernel.org/linux-mm/20241106092114.8408-1-laoar.shao@gmail.com/
> - Simplify the code as suggested by Matthew
> 
> RFC: https://lore.kernel.org/linux-mm/20241104143015.34684-1-laoar.shao@gmail.com/
> 
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 3dc6c7a128dd..9b8a48e736c6 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -385,6 +385,8 @@ static unsigned long get_next_ra_size(struct file_ra_state *ra,
>   		return 4 * cur;
>   	if (cur <= max / 2)
>   		return 2 * cur;
> +	if (cur > max)
> +		return cur;
>   	return max;

Maybe something like

return max_t(unsigned long, cur, max);

might be more readable (likely "max()" cannot be used because of the 
local variable name "max" ...).


... but it's rather weird having a "max" and then returning something 
larger than the "max" ... especially with code like

"ra->size = get_next_ra_size(ra, max_pages);"


Maybe we can improve that by renaming "max_pages" / "max" to what it 
actually is supposed to be (which I haven't quite understood yet).

-- 
Cheers,

David / dhildenb


