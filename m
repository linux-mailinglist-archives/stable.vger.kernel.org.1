Return-Path: <stable+bounces-109540-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F72A16E0F
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 15:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 194733AB146
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 14:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0441E3DC4;
	Mon, 20 Jan 2025 14:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fuSi5zzF"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640611E2848
	for <stable@vger.kernel.org>; Mon, 20 Jan 2025 14:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737381682; cv=none; b=HxxwqYpLkRLP5VQ746BRHGwPmKqc8NHVP3RzuOtlkbk9zV+n/X/OLDMrBHK/ym1szsG47P0WzsvJHK8lrhW5AkYVBYldRX7KSAtcFfxoXwhabu0nsIh10kVTSPCPlt7pTqd12dREHBgtDKrecZqSDZQprY69YRaF3PVLTBBfkMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737381682; c=relaxed/simple;
	bh=P/dX7qtKmEZ3b9p7HzcprzzFKMRKPpP8C8n4ecr+VbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sr70SJ45byK/Hgfy0WMS3G9r23gYHJ70vfbt7p/+/pe530caYBjD/hE5llONrOFG4zyL3KC4P3qiMlmD0pXtWrRZ8Z4AoPGnFmjTbpKV1nw0VhA9fd9fY702uM6BH86xx7IAQylzUGSqoVFxMoQkoIQDvyyQOSvqfQKc66nb2+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fuSi5zzF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737381679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=s/mkn72W8t1XUEbeDrh1A3farpkJnU2/T6YwPc/jj1M=;
	b=fuSi5zzFzX1glLmkSstwZ++syAkA3dTj8Hy0NT8EGKb90EdMqnPQlK32UNka/vbwy/rzBJ
	3ONkkq8QYw3ATpLNi0krXxp+aTthYlH+ez73S0x14DQQ/o1v1p9IQrzdAVfz+UAasQV+Sq
	AzXyyHaZqIZ95b9INj9hiNN+CYVJ99w=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-sO6nCJstOM-7jsRHQs2QZQ-1; Mon, 20 Jan 2025 09:01:17 -0500
X-MC-Unique: sO6nCJstOM-7jsRHQs2QZQ-1
X-Mimecast-MFC-AGG-ID: sO6nCJstOM-7jsRHQs2QZQ
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-385d52591d6so1886833f8f.1
        for <stable@vger.kernel.org>; Mon, 20 Jan 2025 06:01:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737381676; x=1737986476;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s/mkn72W8t1XUEbeDrh1A3farpkJnU2/T6YwPc/jj1M=;
        b=klRbJZwoPBra3xEpxrh5jWHHZzZJIer650grT7ReM/Oi6TLVysR9i8Y9yVBWtGQ+G0
         4PaKHNL+cfSRG4vMaf2LV3IxoMDnfEbJU1N0tRfvqm+dIZ7ztHFeh05NkqHDdmZIiNMY
         fo3nIX24ZyRcRCB2VKmnPmHVcWqO59eGSwJb4habyic1E8mCramZK+0fYGo+GSY+bbhf
         RH0N50OprHa+vKVvqeU+gURb1023Mir4cUsZsvUvS30AY8uHUBaLxVdaXJQ2w1R5him2
         h6JExtJt1T1qjAqm/hwkR/IvP7xu/nScstq7GGo8Vg4dBWD+IJqjSdIL7lXkYSl8aIUZ
         x/eg==
X-Forwarded-Encrypted: i=1; AJvYcCWCPpwzZjZD/gKQ2ecN9tOK3U0EOuQ4vEvLLvzbGqPecR+IB00iunczXh5i8Wqfsl94Y2hnL4E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5vLpDxALoPbNiJBbiu9MK1Kyd/xcRtKieExTKA+rACzKtrw5U
	eyLmAUet+8DqOT+Gs/q6+B7rt6JEBQ3hXuPx7xDlvRrgWVzoXs+GnQATwr8sr3Bq+EBtjFeM/Zq
	UTs23k6Wa+gYIifXI2ySo2xhBtKvd0wYTSx16KBHpPWTRcV397LnnJw==
X-Gm-Gg: ASbGncvHnX4/XlTnU2WQz+mS+vjDbNucqWu7WymCVqpBe63bSPHJqrOwh0/kQuRlE5A
	I5CKP4+TW424ga+F6DjBGjEmXfAhwdg7RHyoZ93WAnTFUJLneNt7mo92Vww1HgaL7ssXhgCB4RX
	0jMR7YJZFu+7Uk0KsDmHM6Z5XlG09SPeJ+CYgujdeNXTLAPkHJnpCV2+Bj/XAI5JZLsg418sC6O
	2ZF4ru+AjDWXAL8QK9O+rPql366QJMJLNoC9lLero+2OWo5fwYzgXJv8zoC8J0deOe5jO+ihsSH
	GblgdxQg+pRi+FF2JscybMIxxBXNQlKbwKAo0LQ0P2JNgSorkLRwmk8Rl+gKxlVCEk7X/jfXXeT
	lhO/LqXyuQ+FNWdMlBd7uSw==
X-Received: by 2002:a5d:64ad:0:b0:38a:5dc4:6dcd with SMTP id ffacd0b85a97d-38bf5b02b35mr11556564f8f.22.1737381674258;
        Mon, 20 Jan 2025 06:01:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkvpw6N9bbmfHHasViK+AHy/K6leeD0foDQE8jUVDigAwqhSf9+Yp1CRL595t8b3c+PzTPbg==
X-Received: by 2002:a5d:64ad:0:b0:38a:5dc4:6dcd with SMTP id ffacd0b85a97d-38bf5b02b35mr11556158f8f.22.1737381670471;
        Mon, 20 Jan 2025 06:01:10 -0800 (PST)
Received: from ?IPV6:2003:d8:2f22:1000:d72d:fd5f:4118:c70b? (p200300d82f221000d72dfd5f4118c70b.dip0.t-ipconnect.de. [2003:d8:2f22:1000:d72d:fd5f:4118:c70b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf3221b70sm10384941f8f.26.2025.01.20.06.01.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2025 06:01:09 -0800 (PST)
Message-ID: <3964f3ff-ce24-4656-ae4b-bc9ffdf6532a@redhat.com>
Date: Mon, 20 Jan 2025 15:01:07 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] mm: Clear uffd-wp PTE/PMD state on mremap()
To: Ryan Roberts <ryan.roberts@arm.com>, Peter Xu <peterx@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Muchun Song <muchun.song@linux.dev>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Shuah Khan <shuah@kernel.org>, =?UTF-8?Q?Miko=C5=82aj_Lenczewski?=
 <miko.lenczewski@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org
References: <20250107144755.1871363-1-ryan.roberts@arm.com>
 <20250107144755.1871363-2-ryan.roberts@arm.com> <Z4gaUAt9w8s1rLPK@x1n>
 <873aede9-bfcd-4c95-a93d-ec1881554f39@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <873aede9-bfcd-4c95-a93d-ec1881554f39@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16.01.25 10:04, Ryan Roberts wrote:
> On 15/01/2025 20:28, Peter Xu wrote:
>> On Tue, Jan 07, 2025 at 02:47:52PM +0000, Ryan Roberts wrote:
>>> When mremap()ing a memory region previously registered with userfaultfd
>>> as write-protected but without UFFD_FEATURE_EVENT_REMAP, an
>>> inconsistency in flag clearing leads to a mismatch between the vma flags
>>> (which have uffd-wp cleared) and the pte/pmd flags (which do not have
>>> uffd-wp cleared). This mismatch causes a subsequent mprotect(PROT_WRITE)
>>> to trigger a warning in page_table_check_pte_flags() due to setting the
>>> pte to writable while uffd-wp is still set.
>>>
>>> Fix this by always explicitly clearing the uffd-wp pte/pmd flags on any
>>> such mremap() so that the values are consistent with the existing
>>> clearing of VM_UFFD_WP. Be careful to clear the logical flag regardless
>>> of its physical form; a PTE bit, a swap PTE bit, or a PTE marker. Cover
>>> PTE, huge PMD and hugetlb paths.
>>>
>>> Co-developed-by: Mikołaj Lenczewski <miko.lenczewski@arm.com>
>>> Signed-off-by: Mikołaj Lenczewski <miko.lenczewski@arm.com>
>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>> Closes: https://lore.kernel.org/linux-mm/810b44a8-d2ae-4107-b665-5a42eae2d948@arm.com/
>>> Fixes: 63b2d4174c4a ("userfaultfd: wp: add the writeprotect API to userfaultfd ioctl")
>>> Cc: stable@vger.kernel.org
>>
>> Nothing I see wrong:
>>
>> Reviewed-by: Peter Xu <peterx@redhat.com>
> 
> Great thanks!

Thanks Peter, for your feedback while I was out.

I remember that I skimmed over it without anything obvious jumping at 
me, but decided to set it aside for later to take a closer look .... 
which never happened.

Took another look, and it looks good to me! (we really must clear the 
uffd-wp flags when losing the VMA flag)

-- 
Cheers,

David / dhildenb


