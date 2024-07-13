Return-Path: <stable+bounces-59225-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F629302FF
	for <lists+stable@lfdr.de>; Sat, 13 Jul 2024 03:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC572B22CF1
	for <lists+stable@lfdr.de>; Sat, 13 Jul 2024 01:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A3BDF53;
	Sat, 13 Jul 2024 01:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H/8qeVwW"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8010C13C
	for <stable@vger.kernel.org>; Sat, 13 Jul 2024 01:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720833663; cv=none; b=i3Yc0zkVWRcVN3oiumSn0hzSvrPRHuJSibRa/0pOwpo6oHcbLaIyTwJ7FgXLp+Ch5AWJlyu1U/OVw8bMNsYgw2HoIdFOSnDEs2Sgrccx+Bv37JrnqzlRnCol9nC23/Bl0gsdJ4liXGU/q+HFODBaKyGBiTpahntCFXRznAgNmmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720833663; c=relaxed/simple;
	bh=aVyfw7JdPdUtf4GaiIYGi/odljZbAjGNkPFeSDeaUgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K07CTyxUBErifIyS1kiiJ+hMIT/6+yoQ27WP7L6Bl5UYbug5sZ/8vxR+phX+ltqEfoebDUewx6kK3QgjlM6E9nmFJYWkKnDJp3h0oE5gK5aLmPGcakH04QZrnlaRnCt9nNlHF2e5A74VbKJU/FJwD1joLGN+pjJIb1LMcrYRDr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H/8qeVwW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720833660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/iL0dvijJhywJqZhh6YxHqmlU8neDjGAit2qrbamF7g=;
	b=H/8qeVwWF+gH9Y4/VjvH19R07AOc5+N2si6P0JSrindelMG0kTaVa7OS+E22NT9BZhWYm9
	uLWCM9KmCwrT05DKhm96qdH4iYgzeBT7VAeCOJ6uVPo4qvvavRGG6d5CpfXuyIpJs4Hcco
	92LzPC3A+MEH9Jk1JqjCEt+aks0zPpc=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-h2QOJeMEMSamV67eWL8png-1; Fri, 12 Jul 2024 21:20:59 -0400
X-MC-Unique: h2QOJeMEMSamV67eWL8png-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3d92b2a96beso2271164b6e.3
        for <stable@vger.kernel.org>; Fri, 12 Jul 2024 18:20:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720833658; x=1721438458;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/iL0dvijJhywJqZhh6YxHqmlU8neDjGAit2qrbamF7g=;
        b=jgf7MzzIjqhcmPyQStfCQndeGAuZUQrRJXOmYf77xD4D0YIA7upK8AZi0fvEG4y0bh
         B3JHN5SNMs+RfCjZXUjYBj2IRRLnwGlBuby+82mrfJ2cuz/z/TKf382fzeoveb5DbqIn
         s5qq7ASoE0bK/M/RM7T0sXJE28OoUzLLCTNYImDfZ+DLvfosSiF5r+LOgbyhgztJB8Ez
         M3Ifrm+5MY0EffrxdkNC2HPz1lGtCit2f3AAg9/X4bdshk3qcBnx9Tha9mMtfMHeIa45
         ADAW/7itty5F4lrILoPEGR9tKdZQOaaHlMMOxtjl1uNEH4fR6OfYda7Wbx+pa0nkEkyq
         wIlA==
X-Forwarded-Encrypted: i=1; AJvYcCXYYTJQNNklH2JEIscAwXAnW9ZxlF7U5vLPDGF9YjDSWb9Yvw5fn6alj2ZL1MuMUdkZtTpske96t7lEZLUr3iCHVJdQeHxs
X-Gm-Message-State: AOJu0Yzx41SV94P/9qrmGVVgehoqIHMCTsUW5I/G+/dQWxKqvrD2Toid
	7pAnGC0WL0SoWii6SvvwSh4FKwK0us/50WyPMYpSAHXcsKUXQbAPJ2DLpCkgqJlKTMfjGXf1BDk
	YeDrlwcbx/tNPKc/JEktMqhEKL7MWFFuu2AlH6tGlgJT7c05ODWVJpw==
X-Received: by 2002:a05:6808:16a8:b0:3d9:1dfd:d79a with SMTP id 5614622812f47-3d93c014e65mr14870361b6e.20.1720833658627;
        Fri, 12 Jul 2024 18:20:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwM1KZ3Ckytuh5q+rnuDDvKzvS9TWQso2ZWcE9TuCoNXLEdoSIGRCCXm3q/1jvM2uAYdKVfg==
X-Received: by 2002:a05:6808:16a8:b0:3d9:1dfd:d79a with SMTP id 5614622812f47-3d93c014e65mr14870348b6e.20.1720833658226;
        Fri, 12 Jul 2024 18:20:58 -0700 (PDT)
Received: from [172.20.2.228] ([4.28.11.157])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-78e34d2c4edsm66714a12.49.2024.07.12.18.20.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jul 2024 18:20:57 -0700 (PDT)
Message-ID: <801b3438-92e6-4b34-8238-cce67f1899f1@redhat.com>
Date: Sat, 13 Jul 2024 03:20:56 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: huge_memory: use !CONFIG_64BIT to relax huge page
 alignment on 32 bit machines
To: Yang Shi <yang@os.amperecomputing.com>, corsac@debian.org,
 willy@infradead.org, jirislaby@kernel.org, surenb@google.com,
 riel@surriel.com, cl@linux.com, carnil@debian.org, ben@decadent.org.uk,
 akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240712155855.1130330-1-yang@os.amperecomputing.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240712155855.1130330-1-yang@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.07.24 17:58, Yang Shi wrote:
> Yves-Alexis Perez reported commit 4ef9ad19e176 ("mm: huge_memory: don't
> force huge page alignment on 32 bit") didn't work for x86_32 [1].  It is
> because x86_32 uses CONFIG_X86_32 instead of CONFIG_32BIT.
> 
> !CONFIG_64BIT should cover all 32 bit machines.
> 
> [1] https://lore.kernel.org/linux-mm/CAHbLzkr1LwH3pcTgM+aGQ31ip2bKqiqEQ8=FQB+t2c3dhNKNHA@mail.gmail.com/
> 
> Fixes: 4ef9ad19e176 ("mm: huge_memory: don't force huge page alignment on 32 bit")
> Reported-by: Yves-Alexis Perez <corsac@debian.org>
> Tested-By: Yves-Alexis Perez <corsac@debian.org>
> Cc: <stable@vger.kernel.org>    [6.8+]
> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
> ---
>   mm/huge_memory.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 2120f7478e55..64f00aedf9af 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -857,7 +857,7 @@ static unsigned long __thp_get_unmapped_area(struct file *filp,
>   	loff_t off_align = round_up(off, size);
>   	unsigned long len_pad, ret, off_sub;
>   
> -	if (IS_ENABLED(CONFIG_32BIT) || in_compat_syscall())
> +	if (!IS_ENABLED(CONFIG_64BIT) || in_compat_syscall())
>   		return 0;
>   
>   	if (off_end <= off_align || (off_end - off_align) < size)

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


