Return-Path: <stable+bounces-165790-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF618B18A88
	for <lists+stable@lfdr.de>; Sat,  2 Aug 2025 05:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4094B3A799F
	for <lists+stable@lfdr.de>; Sat,  2 Aug 2025 03:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C942319D093;
	Sat,  2 Aug 2025 03:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MfHgTPJ5"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C4F19C542
	for <stable@vger.kernel.org>; Sat,  2 Aug 2025 03:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754104182; cv=none; b=uGu9vQOLC3579POmh2JQhX8Ndjr/5e1aMAujKRS2fUGh8M7f4JZ4QRLW4iGNxvAijbNANdrcc30yryuwQTkeS51CROdaxT/E2OFoSuarAv5/nAv1QH5HqHITNTfGD00mspB7V3OHaxiKVcsUVEYmsrs/xvzGKlJzY+vhgbbKmTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754104182; c=relaxed/simple;
	bh=evI4X8lvVC2huATpVHsK6OAUxE0QjTCBDp1m9DluDdI=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=F8bVpz8Aw8rjoSg1+MKt2pMF3TzE0kub9/ykqdwafai9yEB2FISkCj5mlGhyrQABp7MH6vy2YdwecoHsO1nFFHy/Fm6/O+8MsBQX6z1bU75Qq75a9NsrP4z+O/vthWlogezqfFQpnsJRwTZ5Px4AF2+kOxOS06srQwiNd82p6pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MfHgTPJ5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754104177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CL4g8u4o13/qjXRMNenpP//2ihYZ7pT9I+G1Zdq2UUI=;
	b=MfHgTPJ5Bj5l8oH595HVVQuI/ImZpuZ7OxVPLp41cmDVX/lSp9PC9VxSSxGnvnGDPYXpfn
	+EP/uv4k2Dhl23O5giG1lqJQAjGhe+WiQNXb+ToTJHt/Gzlor+nsrAhcLYuqgdYPYEN1s1
	A4csIScsiZMJRdhXhKxSk8wK3dDs8PM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-QdWD50HKNROUt8A-HG78IA-1; Fri, 01 Aug 2025 23:09:35 -0400
X-MC-Unique: QdWD50HKNROUt8A-HG78IA-1
X-Mimecast-MFC-AGG-ID: QdWD50HKNROUt8A-HG78IA_1754104175
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4aeb2e0cb98so48082661cf.1
        for <stable@vger.kernel.org>; Fri, 01 Aug 2025 20:09:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754104174; x=1754708974;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CL4g8u4o13/qjXRMNenpP//2ihYZ7pT9I+G1Zdq2UUI=;
        b=ssRSyFHQzxhIKaET8a1TZgFgm8Wl6jFJ1gZ8h+diWnAZFT4YWOjOaswLHWinfQWZse
         wPvtVROXgt4zKjkoOqH5svcALh0u4tcgxkFFSV+j91Uo7DR0MJhMibAbfMZ27UmUA1Ye
         OjS0wP6+VOww27+fZJIqrRPe0zmxkjb0HKuLPh8v+Fb4GV1gyoOfeF9wSjNSSycmyU8m
         TIHgMO/ICMtj5Oyu+4gsg7V5QnuPgBD0sYfTw6zazznGlyuQzy5rzA2dsvgdmkdd9ycP
         PPlZRec2N+C1yX44M5ePbYMDdfqGxIR4yTP+fWHrMONhfgRWT2YZjhU0xHKKkVqfxXWD
         0UFg==
X-Forwarded-Encrypted: i=1; AJvYcCVrW1QjcwOItF4mUeeUv4jqKLpQ1mwHRZ5pkDOHakvW1w7LlubWJD1l85gqhTQymBW3QvRCja8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbT5Kj3wEAmTmfmohEciSXJCKb1qjuP7l46kysxbER8mDJTfTW
	Pw1DufMHENln/Ftesv7ggKtlWoBlW7Dvb7UJqyMjytWzaolG8iTlUjPxIBNOM0jxiMgIsSVJg4P
	1MVuabsf9cdM+ZxCENeDkFBt2WB5/EsC4AlXaIuJCxsV2rouXzbAWnVuoOWsofnr045M+
X-Gm-Gg: ASbGncvF4mH9amlyvfqLa1utwW5fAvCbixpi4K1PFyt6UnaJKFrbJaOTOg0FQ1T3cvL
	kErDXp+nHBPrrSxPkeZzo/aJE0xSnR6ZwGrpavXAINHy6RuseI6pPjsnurYevJB9j2sOFgPfxLq
	PiKsxfez2NCQaqzhsvtc0kdsREEjGv0JVSJP2gBlf9o59fQBhaNzLpxHfUzSzufE4kRAfBfOkrk
	igNOdq10HD5zzkwbCjY0dERPevaCFAVDTjprOfnvBn2Tl9A26aUAtaOOKg+47QO0hCsHtDvaGAd
	WxvOji/yyP5wZJUtPIpDq6asswGCZa7yemN7TwOrHDTyH84XIK3YojOJkm6K3yZ9XzFZaUg5t2q
	7EFf/R053xA==
X-Received: by 2002:ad4:5baa:0:b0:707:7090:5400 with SMTP id 6a1803df08f44-70935f8f7cbmr27351186d6.17.1754104174055;
        Fri, 01 Aug 2025 20:09:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1puuEw1P293tnjOkDiVKdYXSn6TSnuALZUCmtdCwjli+78ruN24cTnD1KiLalWtE0lBEqfw==
X-Received: by 2002:ad4:5baa:0:b0:707:7090:5400 with SMTP id 6a1803df08f44-70935f8f7cbmr27351016d6.17.1754104173694;
        Fri, 01 Aug 2025 20:09:33 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077c9d6db9sm28743746d6.14.2025.08.01.20.09.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 20:09:32 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <5ca375cd-4a20-4807-b897-68b289626550@redhat.com>
Date: Fri, 1 Aug 2025 23:09:31 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Fix possible deadlock in console_trylock_spinning
To: Andrew Morton <akpm@linux-foundation.org>, Gu Bowen <gubowen5@huawei.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, stable@vger.kernel.org,
 linux-mm@kvack.org, Lu Jialin <lujialin4@huawei.com>,
 Breno Leitao <leitao@debian.org>
References: <20250730094914.566582-1-gubowen5@huawei.com>
 <20250801153303.cee42dcfc94c63fb5026bba0@linux-foundation.org>
Content-Language: en-US
In-Reply-To: <20250801153303.cee42dcfc94c63fb5026bba0@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/1/25 6:33 PM, Andrew Morton wrote:
> On Wed, 30 Jul 2025 17:49:14 +0800 Gu Bowen <gubowen5@huawei.com> wrote:
>
>> kmemleak_scan_thread() invokes scan_block() which may invoke a nomal
>> printk() to print warning message. This can cause a deadlock in the
>> scenario reported below:
>>
>>         CPU0                    CPU1
>>         ----                    ----
>>    lock(kmemleak_lock);
>>                                 lock(&port->lock);
>>                                 lock(kmemleak_lock);
>>    lock(console_owner);
>>
>> To solve this problem, switch to printk_safe mode before printing warning
>> message, this will redirect all printk()-s to a special per-CPU buffer,
>> which will be flushed later from a safe context (irq work), and this
>> deadlock problem can be avoided.
>>
>> Our syztester report the following lockdep error:
>>
>> ...
>>
>> index 4801751cb6b6..d322897a1de1 100644
>> --- a/mm/kmemleak.c
>> +++ b/mm/kmemleak.c
>> @@ -390,9 +390,11 @@ static struct kmemleak_object *lookup_object(unsigned long ptr, int alias)
>>   		else if (object->pointer == ptr || alias)
>>   			return object;
>>   		else {
>> +			__printk_safe_enter();
>>   			kmemleak_warn("Found object by alias at 0x%08lx\n",
>>   				      ptr);
>>   			dump_object_info(object);
>> +			__printk_safe_exit();
>>   			break;
>>   		}
>>   	}
> Thanks.
>
> There have been a few kmemleak locking fixes lately.
>
> I believe this fix is independent from the previous ones:
>
> https://lkml.kernel.org/r/20250731-kmemleak_lock-v1-1-728fd470198f@debian.org
> https://lkml.kernel.org/r/20250728190248.605750-1-longman@redhat.com
>
> But can people please check?

I believe that __printk_safe_enter()/_printk_safe_exit() are for printk 
internal use only. The proper API to use should be 
printk_deferred_enter()/printk_deferred_exit() if we want to deferred 
the printing. Since kmemleak_lock will have been acquired with irq 
disabled, it meets the condition that printk_deferred_*() APIs can be used.

Cheers,
Longman


