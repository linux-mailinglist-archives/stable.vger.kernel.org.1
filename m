Return-Path: <stable+bounces-107991-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC34A05CF0
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 14:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D1173A5DA9
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 13:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D8B1FC7F5;
	Wed,  8 Jan 2025 13:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aS5RCwqD"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2691FC0FF
	for <stable@vger.kernel.org>; Wed,  8 Jan 2025 13:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736343427; cv=none; b=UXRADZFGu9g7xICOftwpRzQUSvyatcJ8ep9ivS5CkNDlx3uP3Z/X8TBt0EOx9zaDt2R+4T37PUzcPBY7tMX+pdN9zcahE3QMcZ0FSPOEY8fsRnMzOiudLGIi0VgbwLQXT9aeXlu2zSXPdvP/rcHioBoRcrDrjWJPFpkFp6UyVBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736343427; c=relaxed/simple;
	bh=bR49NeAcqnBpYnIGt3UxD0ltl98y8XRMc2zqRmIn4Jw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=owx1K5Or+XnbPBV96Zg9qeAbRe/Cm5aT27QBRkTOCl3nm0A3ywxsNxH+VqZeLU5TvhR856eI5ovI6AnKjz7rQKFdL854BWSAOj6hW0TGz36+JzU3BzAkjt8PxA2PmHBNyBC+Fh9iTaA+e09MGIfiAbCXsTf9KGBsy6uPqdqEJmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aS5RCwqD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736343424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zsYn+ubCj/k9frOyIineKG0YZObECCsgzLG4WJOG0aI=;
	b=aS5RCwqDDdvsxpJI/OKWmQaZQxwhQGQuvl6TBSyrvzhtzQiSCX9oLuCtNBisgeeE48t5c9
	TeBrelNMnwRo8cqT84TtaFC0NSyGUxcIlUPfNObnrIi0XvZVrY7q6GH1N3R4BOi5/2Fcvq
	wQpz2eYwS0mnOUDStPnwNdkOlbIWp8Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-2gDMSlBwNACbTG3t5z1T6A-1; Wed, 08 Jan 2025 08:37:01 -0500
X-MC-Unique: 2gDMSlBwNACbTG3t5z1T6A-1
X-Mimecast-MFC-AGG-ID: 2gDMSlBwNACbTG3t5z1T6A
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-436379713baso81113475e9.2
        for <stable@vger.kernel.org>; Wed, 08 Jan 2025 05:37:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736343420; x=1736948220;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zsYn+ubCj/k9frOyIineKG0YZObECCsgzLG4WJOG0aI=;
        b=XiHwuPqFZL7fx4Xa6Z9Ab3uGJBLT5t0U8G1Px1nzkYOUHydZwZiNhw421ugv1OSmVs
         vfzaVl8l/Z9Ajb4dlxDvdrFOLSoheOwEBq8WI0ZvafbDL5CX6s5G4+yIa3P5rCVu9uM6
         hEC0casJo6d4wG41fluYs1kktWvhyvwRp8wm13g/f7z6KCPYorT+7e7mHpIxSx+xm7Zq
         CGKi8uBGMQEc+BnMC5S1n4nmElcnMeTV9cTXx6PGHC4f8DPG8IwBHSXVT5+dxSkDW4+V
         s0tsVo8uxEh7OPWYZKb99MA/Ft0Ht92kBOotWcbDhaO/4L/xrHfvZNYl1jU0ADPZPCr/
         62Xg==
X-Forwarded-Encrypted: i=1; AJvYcCX09NI/R35n+9+KaabF/NWu5wTvQlgb7iVAGfeBOFodfKu4l6BabSOqOfEhIwy7LR77z4DyhmU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbo5RG8WSFTmGaaTs01BNxaDmn9Vjt0385LEwoPsE48d/5/4Ul
	tE0TxsgFmCveTfkQM/w2PsKeB8+eZdvCf2SzWzPE4lBQXvXyTzKjRSVrh/4XBg64Fh7Bd/jcSYw
	CjXBV0NQ5MVKyYNkGcAEl+9O+vOX39tvo4J4vPUXFjAqhCcTxy40raQ==
X-Gm-Gg: ASbGncvjKXPQStyaJoLmTYy3R6K5+dSdaSDjzx3LXArvnRxil7uieMYdCnYmtqdAF9I
	s8CnAxIfuyRuq7SyhJnYoj5uEF8ph058N2NZIKb2X+wzi8zrfZgoFqRklXuwMg05SLs/dCh57E2
	4Sxn4AhutaASxTA4ZMqdCFGbeJlMs/4lKRaYQvrAB0ouwV3UzSNPU8e3/G31n0Aa5lPeqpZI275
	WF/M9seTbQtxPQakT1jUW2Y4UoVlCKgssqtd9WtWniF5O0+Mlz7jLIDbwpiJomz9NMWmEDxV7El
	f3ODh02zSv+rxV7ZALcoeu8NNpuWkKlb9giYvh6WT0JcrJuT5+dzhQ3tzncoy2zRJYEbjD3HRmu
	0RAAQ6A==
X-Received: by 2002:a05:600c:1388:b0:434:f871:1b97 with SMTP id 5b1f17b1804b1-436e26fa594mr21206245e9.33.1736343420381;
        Wed, 08 Jan 2025 05:37:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrSkuA9DL05/QwULjdNVhbRGazffwqTwips2esLt0D2KtCFRWfwckJpNfcFhO/QWP//kZ1mw==
X-Received: by 2002:a05:600c:1388:b0:434:f871:1b97 with SMTP id 5b1f17b1804b1-436e26fa594mr21205985e9.33.1736343419988;
        Wed, 08 Jan 2025 05:36:59 -0800 (PST)
Received: from ?IPV6:2003:cb:c70d:3a00:d73c:6a8:ca9f:1df7? (p200300cbc70d3a00d73c06a8ca9f1df7.dip0.t-ipconnect.de. [2003:cb:c70d:3a00:d73c:6a8:ca9f:1df7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2e21e1esm21180205e9.38.2025.01.08.05.36.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 05:36:58 -0800 (PST)
Message-ID: <05edee1e-04f1-4f19-816f-db03c182a201@redhat.com>
Date: Wed, 8 Jan 2025 14:36:57 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] selftests/mm: virtual_address_range: Fix error when
 CommitLimit < 1GiB
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Dev Jain <dev.jain@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Ryan Roberts <ryan.roberts@arm.com>
References: <20250107-virtual_address_range-tests-v1-0-3834a2fb47fe@linutronix.de>
 <20250107-virtual_address_range-tests-v1-1-3834a2fb47fe@linutronix.de>
 <5811cf74-d333-4653-ab64-0e981eda7745@arm.com>
 <20250108083855-840c688b-003f-423b-8327-2a10a2b27d58@linutronix.de>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250108083855-840c688b-003f-423b-8327-2a10a2b27d58@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08.01.25 09:05, Thomas Weißschuh wrote:
> On Wed, Jan 08, 2025 at 11:46:19AM +0530, Dev Jain wrote:
>>
>> On 07/01/25 8:44 pm, Thomas Weißschuh wrote:
>>> If not enough physical memory is available the kernel may fail mmap();
>>> see __vm_enough_memory() and vm_commit_limit().
>>> In that case the logic in validate_complete_va_space() does not make
>>> sense and will even incorrectly fail.
>>> Instead skip the test if no mmap() succeeded.
>>>
>>> Fixes: 010409649885 ("selftests/mm: confirm VA exhaustion without reliance on correctness of mmap()")
>>> Cc: stable@vger.kernel.org

CC stable on tests is ... odd.

>>> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
>>>
>>> ---
>>> The logic in __vm_enough_memory() seems weird.
>>> It describes itself as "Check that a process has enough memory to
>>> allocate a new virtual mapping", however it never checks the current
>>> memory usage of the process.
>>> So it only disallows large mappings. But many small mappings taking the
>>> same amount of memory are allowed; and then even automatically merged
>>> into one big mapping.
>>> ---
>>>    tools/testing/selftests/mm/virtual_address_range.c | 6 ++++++
>>>    1 file changed, 6 insertions(+)
>>>
>>> diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
>>> index 2a2b69e91950a37999f606847c9c8328d79890c2..d7bf8094d8bcd4bc96e2db4dc3fcb41968def859 100644
>>> --- a/tools/testing/selftests/mm/virtual_address_range.c
>>> +++ b/tools/testing/selftests/mm/virtual_address_range.c
>>> @@ -178,6 +178,12 @@ int main(int argc, char *argv[])
>>>    		validate_addr(ptr[i], 0);
>>>    	}
>>>    	lchunks = i;
>>> +
>>> +	if (!lchunks) {
>>> +		ksft_test_result_skip("Not enough memory for a single chunk\n");
>>> +		ksft_finished();
>>> +	}
>>> +
>>>    	hptr = (char **) calloc(NR_CHUNKS_HIGH, sizeof(char *));
>>>    	if (hptr == NULL) {
>>>    		ksft_test_result_skip("Memory constraint not fulfilled\n");
>>>
>>
>> I do not  know about __vm_enough_memory(), but I am going by your description:
>> You say that the kernel may fail mmap() when enough physical memory is not
>> there, but it may happen that we have already done 100 mmap()'s, and then
>> the kernel fails mmap(), so if (!lchunks) won't be able to handle this case.
>> Basically, lchunks == 0 is not a complete indicator of kernel failing mmap().
> 
> __vm_enough_memory() only checks the size of each single mmap() on its
> own. It does not actually check the current memory or address space
> usage of the process.
> This seems a bit weird, as indicated in my after-the-fold explanation.
> 
>> The basic assumption of the test is that any process should be able to exhaust
>> its virtual address space, and running the test under memory pressure and the
>> kernel violating this behaviour defeats the point of the test I think?
> 
> The assumption is correct, as soon as one mapping succeeds the others
> will also succeed, until the actual address space is exhausted.
> 
> Looking at it again, __vm_enough_memory() is only called for writable
> mappings, so it would be possible to use only readable mappings in the
> test. The test will still fail with OOM, as the many PTEs need more than
> 1GiB of physical memory anyways, but at least that produces a usable
> error message.
> However I'm not sure if this would violate other test assumptions.
> 

Note that with MAP_NORESRVE, most setups we care about will allow 
mapping as much as you want, but on access OOM will fire.

So one could require that /proc/sys/vm/overcommit_memory is setup 
properly and use MAP_NORESRVE.

Reading from anonymous memory will populate the shared zeropage. To 
mitigate OOM from "too many page tables", one could simply unmap the 
pieces as they are verified (or MAP_FIXED over them, to free page tables).

-- 
Cheers,

David / dhildenb


