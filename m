Return-Path: <stable+bounces-163042-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81936B0691A
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 00:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF09E17821C
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 22:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B182BE64E;
	Tue, 15 Jul 2025 22:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XGQC6qaq"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74256DF76
	for <stable@vger.kernel.org>; Tue, 15 Jul 2025 22:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752617438; cv=none; b=YLI0BefDEhRWr7ThEwDcyCQAtdRmRGZZ+NjUHF+dAu97uQB3Mjb0xtHD2sNkgqBy9cmUM337oU6MRA2BXLrQoy0apcGyp8+OehJ4SqsN+MjjzjcSkZN/4491xLpISPfIPyRi3mNbeHgS4bsYfzkJ0ZL84iaiaHhquNfvlDxjSyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752617438; c=relaxed/simple;
	bh=7Pi5i8c1oOsD44JSwXy+KCYbfn/pw/8qQKAyrPzsiM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p3pOf1IpSNtyY6yQ3uFNTwwhku5gba4kOvuhjan/202O7zu0/DULd9eEarU4hj+ZKruVIgHMUv4iSeaJMl77LGMAOtbwOlav651peZGqHOFv5ZELb88Co4uXNcYAClVL58hfnpBGvntvp7lKp4d37HVga9lWBaAj2x3RaKHDa3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XGQC6qaq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752617435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y+67HnVcSFpNiw/rBFyAFgRiuoVZq7tztY8c0N72Msk=;
	b=XGQC6qaqjYU+onou+LTsrLWwEurLjaslFGejdZFSQ6asrU986S9gkMJMgWUfcErnTfanFf
	FvSpTpjSGpjCjNrRms6/9SIUBE3+w644oUSFSDklzXMv2U55eUoc66FG9Czkmyf3kG/CrD
	Dbc8vemupCcth+XU/VAF0+JZpXNaqg0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128--Z3hxt6SN2yfSnpb7tYODg-1; Tue, 15 Jul 2025 18:10:32 -0400
X-MC-Unique: -Z3hxt6SN2yfSnpb7tYODg-1
X-Mimecast-MFC-AGG-ID: -Z3hxt6SN2yfSnpb7tYODg_1752617431
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a5780e8137so127693f8f.1
        for <stable@vger.kernel.org>; Tue, 15 Jul 2025 15:10:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752617431; x=1753222231;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y+67HnVcSFpNiw/rBFyAFgRiuoVZq7tztY8c0N72Msk=;
        b=AAKC7ZKptdhqB5wbyW803LZXWmmLXAQQJDP2kGozXcgUn/j/sXTj3HckGOH/zke5k3
         pmYKnD9XLZCYk64k5dv+SxMozdGMegQq8shIXMZRpfq8koertuSnQ3lO5XvjvxIosWjN
         wpdi3XTZpon1urjqWrJV0gzj8LOBBYupo4CUQ5mouDtNpHvfKz2PQnOGbVZEKVAwmRd8
         Xya4O7CTBn8Pi/LpMi9em6WgCVbUWoHl9yIoiz5yog2Q6CyMO5ozILWheRvtr2dkCign
         steDcGZ6k6vhqJG40pL3Zj6/F6lFRJlkycTDEvR8wsX8p6llmTvbf0C5CkbgH1HO154+
         snNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVch2oXCA4JVZYN07p0TaFzFcaShhTHL4aVEtF16EeBzfaq8eB44pkkxt+pBkO8tcQwLbZbsvs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy36BCBc2diHOF8IIR/I/2teoItJUe3JHuarQVr1ydB5ea4ZjAw
	gdcp41lGui9icLcgEkmKzuWHKivBsBZuv/p/X8JBfMnPo/5+tM8d3dlQk7gmKfjRcXS/HBXoAjG
	yKN2OP7UKyJ0CJ6cEcWlkywMgraFscpXscbfJQBsYCI2T6mbVbGoCGuIcdw==
X-Gm-Gg: ASbGnctSlcR2l6JZUQMH8gnThyKFcEIf1ZrJfj8a07K4l5kssUjP2u9ZGZAaH1CAJ8T
	shbVaNETZiCky3dowJ7YIbi1UdE+AnfqUHACPsN/KmxMC3GUHjpEys5YvbkCoUV7zlvriMoQIdH
	HGNo40Z0qJt5ycUb18qZzBKCJj930LeFECkQIVcuYOHTpRzQwT9nX5UEOij3hpqAR0veJLhtKPJ
	sE2BkQpl4s0TdPg0PoUHvFspvVCjEwJpFtM7pPXszjnwKWKXCsKaieoYg5jorVXUtUsjLu58QeR
	hXWNvilwovhINnOGZkP5+u2eTrAM03Fa2sfx0OVWI/NGJSQepIMGqVWImpomKUxfJ91RR5hAja6
	JZuN9dfd4z8lMUXiwyyMMYQtLWdeif07tCBQMzW1wIbfRHDuqXMopzlQTixfUlcIZgH8=
X-Received: by 2002:a05:6000:240c:b0:3b5:f151:207f with SMTP id ffacd0b85a97d-3b60dd400b9mr641207f8f.3.1752617430831;
        Tue, 15 Jul 2025 15:10:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHB84MFGi05rY35yL6MIzZQ0EALiVeKmmgXNHM4/pemU7kxyusO5BHrdWD1UdN7S4Bt+4ZHCw==
X-Received: by 2002:a05:6000:240c:b0:3b5:f151:207f with SMTP id ffacd0b85a97d-3b60dd400b9mr641184f8f.3.1752617430413;
        Tue, 15 Jul 2025 15:10:30 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:4900:2c24:4e20:1f21:9fbd? (p200300d82f2849002c244e201f219fbd.dip0.t-ipconnect.de. [2003:d8:2f28:4900:2c24:4e20:1f21:9fbd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e26c97sm16385239f8f.90.2025.07.15.15.10.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 15:10:29 -0700 (PDT)
Message-ID: <ff2b8113-4fca-4de6-8703-f3e50a27bb68@redhat.com>
Date: Wed, 16 Jul 2025 00:10:28 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/ksm: Fix -Wsometimes-uninitialized from clang-21 in
 advisor_mode_show()
To: Andrew Morton <akpm@linux-foundation.org>,
 Nathan Chancellor <nathan@kernel.org>
Cc: Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>,
 Stefan Roesch <shr@devkernel.io>, linux-mm@kvack.org, llvm@lists.linux.dev,
 stable@vger.kernel.org
References: <20250715-ksm-fix-clang-21-uninit-warning-v1-1-f443feb4bfc4@kernel.org>
 <20250715144926.90546c48efc5f288cfde319e@linux-foundation.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Organization: Red Hat
In-Reply-To: <20250715144926.90546c48efc5f288cfde319e@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.07.25 23:49, Andrew Morton wrote:
> On Tue, 15 Jul 2025 12:56:16 -0700 Nathan Chancellor <nathan@kernel.org> wrote:
> 
>> After a recent change in clang to expose uninitialized warnings from
>> const variables [1], there is a warning from the if statement in
>> advisor_mode_show().
> 
> I'll change this to "a false positive warning".
> 
>>    mm/ksm.c:3687:11: error: variable 'output' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
>>     3687 |         else if (ksm_advisor == KSM_ADVISOR_SCAN_TIME)
>>          |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    mm/ksm.c:3690:33: note: uninitialized use occurs here
>>     3690 |         return sysfs_emit(buf, "%s\n", output);
>>          |                                        ^~~~~~
>>
>> Rewrite the if statement to implicitly make KSM_ADVISOR_NONE the else
>> branch so that it is obvious to the compiler that ksm_advisor can only
>> be KSM_ADVISOR_NONE or KSM_ADVISOR_SCAN_TIME due to the assignments in
>> advisor_mode_store().
>>
>> --- a/mm/ksm.c
>> +++ b/mm/ksm.c
>> @@ -3682,10 +3682,10 @@ static ssize_t advisor_mode_show(struct kobject *kobj,
>>   {
>>   	const char *output;
>>   
>> -	if (ksm_advisor == KSM_ADVISOR_NONE)
>> -		output = "[none] scan-time";
>> -	else if (ksm_advisor == KSM_ADVISOR_SCAN_TIME)
>> +	if (ksm_advisor == KSM_ADVISOR_SCAN_TIME)
>>   		output = "none [scan-time]";
>> +	else
>> +		output = "[none] scan-time";
>>   
>>   	return sysfs_emit(buf, "%s\n", output);
>>   }
> 
> Ho hum OK, but the code did deteriorate a bit.
> 
> static ssize_t advisor_mode_show(struct kobject *kobj,
> 				 struct kobj_attribute *attr, char *buf)
> {
> 	const char *output;
> 
> 	if (ksm_advisor == KSM_ADVISOR_SCAN_TIME)
> 		output = "none [scan-time]";
> 	else
> 		output = "[none] scan-time";
> 
> 	return sysfs_emit(buf, "%s\n", output);
> }
> 
> Inconsistent with the other code which looks at this enum.  Previously
> the code explicitly recognized that there are only two modes and that
> became implicit.
> 
> Oh well, no big deal and we don't want clang builds erroring out like
> this.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


