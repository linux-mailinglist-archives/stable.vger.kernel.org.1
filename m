Return-Path: <stable+bounces-92802-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7889B9C5F74
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 18:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00A52BA13AC
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 15:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68B1200B81;
	Tue, 12 Nov 2024 15:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QGLM6zU6"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDB72003D7
	for <stable@vger.kernel.org>; Tue, 12 Nov 2024 15:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731424754; cv=none; b=EF7BYR2yJzH0KBlYwm6Mdh8PSDa/JetvDYureOIEjsLfOI0H7YHmAKW6v7Kb34LK3gcKjs+aGY2LTQdNkjlIDaHfW9Pz104pS/XVlqO/jLZB6Nbs39MGqANI1NqLxrlgAac6m8sbKPVDMWg74oOdcvpNtCywHXisHuw0aC4UndM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731424754; c=relaxed/simple;
	bh=Fug5eVS+HV+AyKB0lV6rEXP/sRYHncBJml/JfcboGgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ewLIqx7490gddxWtVCtPUvDfLI9z37W+pHc5T/oritWP5iL9ifY2h76m75dzcsWuL9IowEIMltCE7b6pZ3s4mPckewxwFxoj6vTF0FLQlUghqqxM4+LXQ7fUQdn0nFQFweLKc5nNShPY/toLtwjUzz3RZUkMoXAM10KDtidQjVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QGLM6zU6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731424751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7wkwdsubcbRIKLtd2XA6jvGbqtmNJMnexjmTKT6sw70=;
	b=QGLM6zU6yIeYDI8lgcBR0c/9f7oR/Fd3pbIha5w+cUM68hGUuCktt7ipXw1Ze9yAxUEqqX
	P2ToCTVuVxVe3Ii8PgQlA5qorj3pEr5rfP0gWK8SkHnuMV5qhjTG3gVuON5Eexnhkve8Qa
	0SkgYUsbbjcq/5hqTraEECFQ7W13mdw=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-vPfDDuYSPB-3ysHqlvwFMA-1; Tue, 12 Nov 2024 10:19:10 -0500
X-MC-Unique: vPfDDuYSPB-3ysHqlvwFMA-1
X-Mimecast-MFC-AGG-ID: vPfDDuYSPB-3ysHqlvwFMA
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-539f7abe2e6so4461635e87.1
        for <stable@vger.kernel.org>; Tue, 12 Nov 2024 07:19:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731424749; x=1732029549;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7wkwdsubcbRIKLtd2XA6jvGbqtmNJMnexjmTKT6sw70=;
        b=GCpHonINItVUad5S24XGqIh2b124kqop0ZKW1pBwYsfkwOgxhdHZLeIue2PCewksSV
         RYawgPMhisT9GDSzX2e6fAAYVV6ld4XdWgAee2i4o9VS9D3RaxrlTinfW5deAtt798q2
         YygkY/ZiMwMmtZ2mhLb0TbbV5WHIaCsOA1H+G+RP4rkTTbh8dI6bXMC4EbH+1oaikdo8
         cmnrxIi4xbH+6i+y3WIR6tKaucDXiGdrpKJAyriyA/Ki6xC7VsBGmZl0qnLz+AxaWBlf
         n9hflqsu6d5SUghUHTfyA2kXmyHkyXfMaqa1Xp4rfub3un+tNDOHL5cxduNIi1PWb3Bm
         bsew==
X-Forwarded-Encrypted: i=1; AJvYcCXLuD6hKDNLbseFqeYd6zm4kamjtQSBCpErFYBNddoC9bKe9Ces78YU+5grcGrsyvXFdq43EE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyppHnYHlixZd7r86uCxkBnVDuDme/aeCRIFt53aOppwyrq+2W6
	qVdaoDIf7ckIcJgxvB4SLz//18gnOpSAr1AjmUXeD7dUJdRwrLvljhSjZcmH2erXQGBUTCwPjRR
	e1sNzs1+H4oL9LXiyEKj9l6SViBJEdbOWXsqgEfAKHi/mCT20XPrjEQ==
X-Received: by 2002:a05:6512:3e05:b0:539:ed5e:e224 with SMTP id 2adb3069b0e04-53d9a40704dmr1891907e87.7.1731424749038;
        Tue, 12 Nov 2024 07:19:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHTk5oidVF9d34A0dcj0E3UxP3dLrIaDwjw4kGIKdz3rHR3Ttf58oYxTmqBudgH4LJ76xGurQ==
X-Received: by 2002:a05:6512:3e05:b0:539:ed5e:e224 with SMTP id 2adb3069b0e04-53d9a40704dmr1891885e87.7.1731424748571;
        Tue, 12 Nov 2024 07:19:08 -0800 (PST)
Received: from ?IPV6:2003:cb:c739:8e00:7a46:1b8c:8b13:d3d? (p200300cbc7398e007a461b8c8b130d3d.dip0.t-ipconnect.de. [2003:cb:c739:8e00:7a46:1b8c:8b13:d3d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b05305a4sm214906925e9.5.2024.11.12.07.19.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 07:19:07 -0800 (PST)
Message-ID: <a1fe53f7-a520-488c-9136-4e5e1421427e@redhat.com>
Date: Tue, 12 Nov 2024 16:19:07 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/readahead: Fix large folio support in async
 readahead
To: Yafang Shao <laoar.shao@gmail.com>
Cc: willy@infradead.org, akpm@linux-foundation.org, linux-mm@kvack.org,
 stable@vger.kernel.org
References: <20241108141710.9721-1-laoar.shao@gmail.com>
 <85cfc467-320f-4388-b027-2cbad85dfbed@redhat.com>
 <CALOAHbAe8GSf2=+sqzy32pWM2jtENmDnZcMhBEYruJVyWa_dww@mail.gmail.com>
 <fe1b512e-a9ba-454a-b4ac-d4471f1b0c6e@redhat.com>
 <CALOAHbD6HsrMhY0S_d9XA0LRdMGr6wwxFYAnv6u-d7VRFt6aKg@mail.gmail.com>
 <cf446ada-ad3a-41a4-b775-6cb32f846f2a@redhat.com>
 <CALOAHbA=GuxdfQ8j-bnz=MT=0DTnrcNu5PcXvftfNh37WzRy1Q@mail.gmail.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CALOAHbA=GuxdfQ8j-bnz=MT=0DTnrcNu5PcXvftfNh37WzRy1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

>> Sorry, but this code is getting quite confusing, especially with such
>> misleading "large folio" comments.
>>
>> Even without MADV_HUGEPAGE we will be allocating large folios, as
>> emphasized by Willy [1]. So the only thing MADV_HUGEPAGE controls is
>> *which* large folios we allocate. .. as Willy says [2]: "We were only
>> intending to breach the 'max' for the MADV_HUGE case, not for all cases."
>>
>> I have no idea how *anybody* should derive from the code here that we
>> treat MADV_HUGEPAGE in a special way.
>>
>> Simply completely confusing.
>>
>> My interpretation of "I don't know if we should try to defend a stupid
>> sysadmin against the consequences of their misconfiguration like this"
>> means" would be "drop this patch and don't change anything".
> 
> Without this change, large folios won’t function as expected.
> Currently, to support MADV_HUGEPAGE, you’d need to set readahead_kb to
> 2MB, 4MB, or more. However, many applications run without
 > MADV_HUGEPAGE, and a larger readahead_kb might not be optimal for> them.

Someone configured: "Don't readahead more than 128KiB"

And then we complain why we "don't readahead more than 128KiB".

:)

"mm/filemap: Support VM_HUGEPAGE for file mappings" talks about "even if 
we have no history of readahead being successful".

So not about exceeding the configured limit, but exceeding the 
"readahead history".

So I consider VM_HUGEPAGE the sign here to "ignore readahead history" 
and not to "violate the config".

But that's just my opinion.

> 
>>
>> No changes to API, no confusing code.
> 
> New features like large folios can often create confusion with
> existing rules or APIs, correct?

We should not try making it even more confusing, if possible.

> 
>>
>> Maybe pr_info_once() when someone uses MADV_HUGEPAGE with such backends
>> to tell the sysadmin that something stupid is happening ...
> 
> It's not a flawed setup; it's just that this new feature doesn’t work
> well with the existing settings, and updating those settings to
> accommodate it isn't always feasible.
I don't agree. But it really is Willy's take.

The code, as it stands is confusing and nobody will be able to figure 
out how MADV_HUGEPAGE comes into play here and why we suddenly exceed 
"max/config" simply because "cur" is larger than max.

For example, in the code

ra->size = start - index;	/* old async_size */
ra->size += req_count;
ra->size = get_next_ra_size(ra, max_pages);

What happens if ra->size was at max, then we add "req_count" and 
suddenly we exceed "max" and say "well, sure that's fine now". Even if 
MADV_HUGEPAGE was never involved? Maybe it cannot happen, but it sure is 
confusing.


Not to mention that "It's worth noting that if read_ahead_kb is set to a 
larger value that isn't aligned with huge page sizes (e.g., 4MB + 
128KB), it may still fail to map to hugepages." sounds very odd :(

-- 
Cheers,

David / dhildenb


