Return-Path: <stable+bounces-116309-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA90A349DE
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 17:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E52C73AF115
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 16:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9103B283812;
	Thu, 13 Feb 2025 16:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UOUi8GQK"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F0728380A
	for <stable@vger.kernel.org>; Thu, 13 Feb 2025 16:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739463405; cv=none; b=HyeZkLKrmwpJMuwhbsbZcnavmRry4zqqIWK9EOeJbNnw0FAvHmugdJ1+ExjYBVNlAWYZmjAc4CnLFgjpmiab+1+P2eDqJUpdQl6j6TRLUu1kJY1B+bIU6EFkhwtWxGnUVrUjEz1znQ/7IADfmMDZ49cR4+1EjYzgvzP/KyATI4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739463405; c=relaxed/simple;
	bh=wQfQUDOlMKIqY8ONyz/bt5HloO+0R2vMZiTEsqnsuu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B1StBNdo1gWu6EH87/Bw+D+8wXGWHAcYi2eBfW6WsmcUXT/eudZYSrBA2iduBcbPnyGx9ieiIqu5wXlc1zkmA4EDvxyOYwmc9+hx5526Nf/CCYS2hrAsmA0AqDdt/KOVBtOFj9zdJTx5TXrO+cdqo/yHTvvIHEcLAgDQWd3UJWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UOUi8GQK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739463402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=K9INglP8UbI2R4zAa8G0HHDOGm0nrMySeYcN3jzl1jQ=;
	b=UOUi8GQKUcZKWP5NrlPfnd1d4Bk3o0B0dhqozGvRCVvbJIonhFjzFeNgq5CbgnHPdvtxa6
	65iS9XhN0xJEV6ZQWslkpVijNuPgDz8NlARyfk3ljkGB0/pNnCHJRB1YO/rlzNBB/XV9Ld
	lx72jVWyKioBgtUMVcia15hO8ue34Qk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-4PNr2YMhOQKYKpGQ4xNTyg-1; Thu, 13 Feb 2025 11:16:41 -0500
X-MC-Unique: 4PNr2YMhOQKYKpGQ4xNTyg-1
X-Mimecast-MFC-AGG-ID: 4PNr2YMhOQKYKpGQ4xNTyg
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43935bcec74so6195355e9.3
        for <stable@vger.kernel.org>; Thu, 13 Feb 2025 08:16:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739463400; x=1740068200;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K9INglP8UbI2R4zAa8G0HHDOGm0nrMySeYcN3jzl1jQ=;
        b=YT+nr+I9PiEha/QrM1oGB7Iq9YDjUTzBaP2/WcTQ6IBr0/RHhAnZ6AgGm3+8hEvmcu
         BHUb8YHqlCKAj0uwtN33Fn/OnXyC2n5SRx9W/Iwl7boYZn7PscI+Ey4TRnqRmTFPVq0k
         B6aAC1miGLCiw4nESj7p+nR4iXPfIn4CS9ZrGMp38aisERBRGWUrWFdwXqPSDu4aJ3oy
         pkvBfMu2WCZcDuOFiIQIpmZMqPRpe3+fKILwCGWipBBdLpu/DY0OlHzUldk+D6C3jAyo
         9FN03I00Wj3YzqvyXKuTSipRpKTwEe1HYmuorzaSKXnfjZwdY1Iv0PFSsdkhaYAuLshR
         webw==
X-Forwarded-Encrypted: i=1; AJvYcCUWXaoNuZluW8kFStW1u7g543j8kg0Akm8Zth6OyxYUCfWsoHWLDWqjQlabOvLrEgSn/P3/qMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YztgBhy2GXGQsD6jdHMAT3D/Gf76Zc0LPIXd6LQNQgHHaSapNx2
	oNb9QVUcfGugnTHTG0vNNyfmNLJHo03ZvkcQ9tksGdt0D8uNDAk/M+RRbWJwUbDh1W1obhFdnu/
	d9DCFWj4fLMp6TMRdv9VEWxuVHhQV3H2UYnvRRoZaSH2iV5SZQzNmqg==
X-Gm-Gg: ASbGncsVonBZ4hZbvg/TDYcRdI1eqArmv9LpCPgLklVWct3UPIETKcxEozyqq2RYTXq
	7B37//tYMv7gkOiVq53RFcRIFdn5cOebnHOkisBB+rFM/euEI9vqeOr3uEC4UCLZ8HHbE38jE7y
	WvmddRyIDzIkkfk0nsNoBNK0tmTZ6D/Tr3ZyN4pOmMjGcm7/cDyk2SbSDviggbpPCF8riAnHG3l
	/rgR9A6qDfEB73LndgNqzo6o8JcBHURnGYbU98TrlXmuorftEnYW6guAFTHvvJHXQjw9f1P/WA3
	bLDz2DLvBSAaETBsbD/LQyAz3vH7DBksV56cp540EQmFTYShYdymUbvhZXlPNRxbxUQg6B7JpIY
	hvjOFHQaoz3gJQv8AwwqlVfjxfSdTkw==
X-Received: by 2002:adf:e78a:0:b0:38d:df05:4d9 with SMTP id ffacd0b85a97d-38dea5f6f0cmr6761905f8f.43.1739463399966;
        Thu, 13 Feb 2025 08:16:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEaWYsikH2Lv8Z9qNVRrad0h+UPZ783FaoONtNdxJEhnSMR7NUvcampLUBmQfrbd517d1dGFg==
X-Received: by 2002:adf:e78a:0:b0:38d:df05:4d9 with SMTP id ffacd0b85a97d-38dea5f6f0cmr6761850f8f.43.1739463399532;
        Thu, 13 Feb 2025 08:16:39 -0800 (PST)
Received: from ?IPV6:2003:cb:c718:100:347d:db94:161d:398f? (p200300cbc7180100347ddb94161d398f.dip0.t-ipconnect.de. [2003:cb:c718:100:347d:db94:161d:398f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a04f217sm52297485e9.1.2025.02.13.08.16.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 08:16:38 -0800 (PST)
Message-ID: <b2964ea1-a22c-4b66-89ef-3082b6d00d21@redhat.com>
Date: Thu, 13 Feb 2025 17:16:37 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] arm64: mm: Populate vmemmap/linear at the page level
 for hotplugged sections
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Zhenhua Huang <quic_zhenhuah@quicinc.com>, anshuman.khandual@arm.com,
 will@kernel.org, ardb@kernel.org, ryan.roberts@arm.com,
 mark.rutland@arm.com, joey.gouly@arm.com, dave.hansen@linux.intel.com,
 akpm@linux-foundation.org, chenfeiyang@loongson.cn, chenhuacai@kernel.org,
 linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, quic_tingweiz@quicinc.com,
 stable@vger.kernel.org
References: <20250213075703.1270713-1-quic_zhenhuah@quicinc.com>
 <9bc91fe3-c590-48e2-b29f-736d0b056c34@redhat.com> <Z64UcwSGQ53mFmWF@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z64UcwSGQ53mFmWF@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.02.25 16:49, Catalin Marinas wrote:
> On Thu, Feb 13, 2025 at 01:59:25PM +0100, David Hildenbrand wrote:
>> On 13.02.25 08:57, Zhenhua Huang wrote:
>>> On the arm64 platform with 4K base page config, SECTION_SIZE_BITS is set
>>> to 27, making one section 128M. The related page struct which vmemmap
>>> points to is 2M then.
>>> Commit c1cc1552616d ("arm64: MMU initialisation") optimizes the
>>> vmemmap to populate at the PMD section level which was suitable
>>> initially since hot plug granule is always one section(128M). However,
>>> commit ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
>>> introduced a 2M(SUBSECTION_SIZE) hot plug granule, which disrupted the
>>> existing arm64 assumptions.
>>>
>>> Considering the vmemmap_free -> unmap_hotplug_pmd_range path, when
>>> pmd_sect() is true, the entire PMD section is cleared, even if there is
>>> other effective subsection. For example page_struct_map1 and
>>> page_strcut_map2 are part of a single PMD entry and they are hot-added
>>> sequentially. Then page_struct_map1 is removed, vmemmap_free() will clear
>>> the entire PMD entry freeing the struct page map for the whole section,
>>> even though page_struct_map2 is still active. Similar problem exists
>>> with linear mapping as well, for 16K base page(PMD size = 32M) or 64K
>>> base page(PMD = 512M), their block mappings exceed SUBSECTION_SIZE.
>>> Tearing down the entire PMD mapping too will leave other subsections
>>> unmapped in the linear mapping.
>>>
>>> To address the issue, we need to prevent PMD/PUD/CONT mappings for both
>>> linear and vmemmap for non-boot sections if corresponding size on the
>>> given base page exceeds SUBSECTION_SIZE(2MB now).
>>>
>>> Cc: <stable@vger.kernel.org> # v5.4+
>>> Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
>>> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
>>> Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
>>
>> Just so I understand correctly: for ordinary memory-sections-size hotplug
>> (NVDIMM, virtio-mem), we still get a large mapping where possible?
> 
> Up to 2MB blocks only since that's the SUBSECTION_SIZE value. The
> vmemmap mapping is also limited to PAGE_SIZE mappings (we could use
> contiguous mappings for vmemmap but it's not wired up; I don't think
> it's worth the hassle).

But that's messed up, no?

If someone hotplugs a memory section, they have to hotunplug a memory 
section, not parts of it.

That's why x86 does in vmemmap_populate():

if (end - start < PAGES_PER_SECTION * sizeof(struct page))
	err = vmemmap_populate_basepages(start, end, node, NULL);
else if (boot_cpu_has(X86_FEATURE_PSE))
	err = vmemmap_populate_hugepages(start, end, node, altmap);
...

Maybe I'm missing something. Most importantly, why the weird subsection 
stuff is supposed to degrade ordinary hotplug of dimms/virtio-mem etc.

-- 
Cheers,

David / dhildenb


