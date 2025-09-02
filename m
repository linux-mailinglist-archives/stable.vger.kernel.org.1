Return-Path: <stable+bounces-177541-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D67B40D11
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 20:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 482FE20288D
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 18:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E93734DCC6;
	Tue,  2 Sep 2025 18:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SWj6zFiB"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710DC34AB07
	for <stable@vger.kernel.org>; Tue,  2 Sep 2025 18:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756837301; cv=none; b=SgAeHJwEXctr+/vsiWK2CEoYipqRFXJhOlswsEfiQRrnoZS7/VXMCU4TPCt4yhNW2AiAdhR7nsB/H4NAQqFkU9PnX4IpmHUcmbH/cfbIG4qohS02SpIqHAJ88WuKsOBK+mTXs7Q+zKZh+A7y/oQxZwP/p7OzuDjb1QewWB5Gwxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756837301; c=relaxed/simple;
	bh=ujvP5ppYIq+mrTdhQyLILyCVzNShUHT9r5skpRwxy6k=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kg3QAuPR+zZAe5DZdtO38wK4UunmikjhMuhiv6MOBxoMcYKCYBJQn2LcMwG7xrhiHPPx5N3PX+BTWO9FAexkf23kk0+zupWF5p9qRXFKc4VACFliNHETvbRQLjZ7TknnifbJLsAuYb29pgpIA5SLQ93O6Ih5uzdxYRfPVAve71A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SWj6zFiB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756837298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L7RY1WsUY1lF18R/9EMCOt/PXAzdHUz71EA85shZ7EU=;
	b=SWj6zFiB+RyYget2CLtgl508/PlESswY/BNg23Xavo5ou/VfdhjsC7LRa8uIHA2zbzreXD
	u6JW31TzYHQ95ubV51eNnsHFs2F+YZ4WkK8qWiuNwceNMJiEsgt4x8w5lhPYbT2cQOxSKy
	uWJ4fkL8hWQQlICfVvncM/j+orzPrc8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-ik-54jEmOaSs1ihejF6MIg-1; Tue, 02 Sep 2025 14:21:36 -0400
X-MC-Unique: ik-54jEmOaSs1ihejF6MIg-1
X-Mimecast-MFC-AGG-ID: ik-54jEmOaSs1ihejF6MIg_1756837287
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e870646b11so1218108685a.2
        for <stable@vger.kernel.org>; Tue, 02 Sep 2025 11:21:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756837287; x=1757442087;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L7RY1WsUY1lF18R/9EMCOt/PXAzdHUz71EA85shZ7EU=;
        b=gXbF/UITOcZDjXC2tXufkAlm4rslTrgeGUDn+Ns/VlB3t9M/OwRiaSpq+XyAHpbc0m
         GpPVCPdYClxSNtZ0WM6LQijTnlUr8o4kLshhYuvrxfu/brR7nTjspOvZNwIcuAMg6EjC
         3DITB/vTNsLlYMb+MvMgF8wOB39XSUs+4jjv7ulnRrdv/PAYLRL5wm36DVPI/aE2Gv8d
         0U7IWphb1ALgvidliZgx984sKnIlKM+qN3eXSP0Kh5GK7OOjVq/E3D5phjmx4U2G02Gt
         JPxH0Xwn6i2TInSP6T2Zz9XNhsVn/avq7GeRj3bhnEkh4+cW2mI58FG3DwIAl5yI7RuF
         TyIw==
X-Forwarded-Encrypted: i=1; AJvYcCWqwbv/AEIWNmitGGYcldSQvfed++fMQQDHHgMVZZ/dT14Dn3GsmGBMnmcv6C6sluBZv76yFEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmMl6LzGrgvbVULXFCs4roUE+V3oqRTmPmOPBAv3XB5RpuCDzF
	4cZQAnGxJiZq1nLx6ZQ3gPhbFxYbNU9A6dSFLXQAYsKGVY3g1uEhEuqhXpdr3xLdYA/VobCNYp0
	ZH7heFfQWqlxlftAI95MtgRcFKMjTmb9uH7Te6D1bhFlNqgxe6FamcG1MeQ==
X-Gm-Gg: ASbGncuNcunnmEMgOMwgKfUOSI4eziRydu4gStBeQqc/xARQCTBxsvt5q8k9Hh7d8Er
	kxfa10i61CaJhG7ZN5HyVWSDYmMm/ltGq1kMMs38Eat+cXdXYIsq1nI9o4k9vUyyQ3P7VqW7Pp1
	nT36eQZsJ+3Z5MCmtyl4bNhIh2eOURBAqwIEqcvToOx2b/bGyi40UPuWaOrcVwxmLq7+X/91SJl
	zhYrJ3ngnW+sMbowUKkKKOW61RbkoCVaADDtUNhQJej4MlpwnpnIsitKfKGyXBSUrHNNF7ledn7
	R0ry2dWPnLayvhHU4PeNsPrGl0rt+S6xdKswJKgb5QXlz2n0uom47x47plZ/3G+J8nn3vzaPRfU
	jqTPXsntv7A==
X-Received: by 2002:a05:620a:1a83:b0:802:6dc6:4f32 with SMTP id af79cd13be357-8026dc65a5bmr816925385a.78.1756837286756;
        Tue, 02 Sep 2025 11:21:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtHLm2OtG+zzbOosERCZVrDaqy0yh4F5L/NztF4x8PsJuHDw2CVmuA9sllL/wLi9X6VpZ5Mw==
X-Received: by 2002:a05:620a:1a83:b0:802:6dc6:4f32 with SMTP id af79cd13be357-8026dc65a5bmr816922985a.78.1756837286340;
        Tue, 02 Sep 2025 11:21:26 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-806975c37e5sm177580185a.10.2025.09.02.11.21.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 11:21:25 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <927f1afc-4fd4-4d42-948b-5da355443a4a@redhat.com>
Date: Tue, 2 Sep 2025 14:21:25 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpuset: prevent freeing unallocated cpumask in hotplug
 handling
To: Ashay Jaiswal <quic_ashayj@quicinc.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Tejun Heo <tj@kernel.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Johannes Weiner <hannes@cmpxchg.org>
References: <20250902-cpuset-free-on-condition-v1-1-f46ffab53eac@quicinc.com>
 <533633c5-90cc-4a35-9ec3-9df2720a6e9e@redhat.com>
Content-Language: en-US
In-Reply-To: <533633c5-90cc-4a35-9ec3-9df2720a6e9e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/2/25 1:14 PM, Waiman Long wrote:
>
> On 9/2/25 12:26 AM, Ashay Jaiswal wrote:
>> In cpuset hotplug handling, temporary cpumasks are allocated only when
>> running under cgroup v2. The current code unconditionally frees these
>> masks, which can lead to a crash on cgroup v1 case.
>>
>> Free the temporary cpumasks only when they were actually allocated.
>>
>> Fixes: 4b842da276a8 ("cpuset: Make CPU hotplug work with partition")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Ashay Jaiswal <quic_ashayj@quicinc.com>
>> ---
>>   kernel/cgroup/cpuset.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 
>> a78ccd11ce9b43c2e8b0e2c454a8ee845ebdc808..a4f908024f3c0a22628a32f8a5b0ae96c7dccbb9 
>> 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -4019,7 +4019,8 @@ static void cpuset_handle_hotplug(void)
>>       if (force_sd_rebuild)
>>           rebuild_sched_domains_cpuslocked();
>>   -    free_tmpmasks(ptmp);
>> +    if (on_dfl && ptmp)
>> +        free_tmpmasks(ptmp);
>>   }
>>     void cpuset_update_active_cpus(void)
> The patch that introduces the bug is actually commit 5806b3d05165 
> ("cpuset: decouple tmpmasks and cpumasks freeing in cgroup") which 
> removes the NULL check. The on_dfl check is not necessary and I would 
> suggest adding the NULL check in free_tmpmasks().

As this email was bounced back from your email account because it is 
full, I decide to send out another patch on your behalf. Note that this 
affects only the linux-next tree as the commit to be fixed isn't merged 
into the mainline yet. There is no need for stable branch backport.

Cheers,
Longman


