Return-Path: <stable+bounces-173750-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 722D4B35F7C
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EF426884AB
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 12:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B9118024;
	Tue, 26 Aug 2025 12:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aa7qRiQ9"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDD438DD8
	for <stable@vger.kernel.org>; Tue, 26 Aug 2025 12:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756212574; cv=none; b=XwMkRdH2flRujzC0asZhGqDwBeUzEpgTKoPfHo8U9EW8wzBq3EzeZrDeIjkN0q68kj2wsX+lAl3CSW6A0jbeN7zt191S1MIFdpNTaBkMUXJGeDLyBeIAFH4/nZGoCvAQEJiCo1ZEe6EERU+wOkvJfGn0Gw9fNWq3kd5NZVVGD40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756212574; c=relaxed/simple;
	bh=StGlkjzOfLZRODGmqc8aP+w4Aisl09EJRAcFgJI82tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XF4KXkUpdZXY1zAQQEcSRZGTXmJkaQFeEnyJC21jBljNn6F++lyJUE0znlRhheiiJrPfGn6qXF3wgsGVSbNLr1s0V9mYytOZzW2YbGoBpEqxb/SNH+0R2+lPHqifXurxaj17h9x7YReXInhLsPVBaNnux8attrXDI8de8vSI/Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aa7qRiQ9; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-afcb7a16441so880878666b.2
        for <stable@vger.kernel.org>; Tue, 26 Aug 2025 05:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756212571; x=1756817371; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E9Sbt6rcunNyWvDfSlRKWRHDJPajA+dW2r+/5L7KKtw=;
        b=aa7qRiQ9iLcp7sVaNxePyYMb7+h5Bh6yopIYwDNecmJOP228geLBqszDHgWMOJH9CL
         eLRckB1WR9foYGSlIqr84xaBygDVYBBVkyUd1e4kFTVPkeHPyEZWHIFDBNg9EZbnwXgh
         2fQwFplxAiNCHWv28jEYEe/AHDmyvHfPC9A4I3MUCmEgr3EEsDGY4C29/G7/fkvBG4DF
         Tz1+rYjCh4ky086FdUL4lYpr3eBDgO/Ww5/HFVKw3o5ze590Vo9PVJoBKeIDywW5DzRI
         wl+do/PIEOyZzWuO/R1g7YsjkHs20o0kAMTS41n9AvHNFmAC6j02H055k70zKvxR6cJ4
         dpeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756212571; x=1756817371;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E9Sbt6rcunNyWvDfSlRKWRHDJPajA+dW2r+/5L7KKtw=;
        b=Qk7yaCm7wS2kswh+FF2jpOJfMd8/zuAkrxuhI2PX8SXFtC0S12TfsVFSMYV6YMm5p5
         HL+8GDdxQoux2ACsitb8ZMi+mHPWlvnpM8UaSJYi/c+mD/GWk3QWzTyXv8mCy4oZ1sLw
         hfdPEows6eawNBp861HF6XoIOu/uTk7Fhv8bO4fsadyEo+iJKVl81KkhCSZ7qVsNFPSM
         wJ3mBEJew24S9bpq1onMZbbRAgULJghgVH64o/BhvmCVR6jAoUPirU0TiVpf8MHq72PF
         81T+CyPuavynUOoJcSQ4uTzsCgiFrnzUsneLNfornmiNlB6LnRTv6UfrEywFRsTMcy/O
         kAwA==
X-Forwarded-Encrypted: i=1; AJvYcCWiVa6KNR4jDl3/aUXrJTMRS92FZD1UkEEZqtEj0N37DVSVRL4l5J4OZl9sadXyA11AJEKCXoY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx90vlpJHsQh91ewPKfgA3zLplM7vZYeyWAwbJ3+NODzngUWCpD
	aLZSrO1z/I1LgaJFpc8XbbhvJUAKuBJVuD2/W/LEZ3UxZdzFsHeUScLZ
X-Gm-Gg: ASbGncvHe+s9GLWoqpnml/3nLX/Ley4bZaKCTld6ONci24cMKFwwnhrerKUy5edLgVF
	b5mM11KGwjhAxEBmptNHN4dkL1mZi0nzwt7ltfbh7b6vaHC03cT7yryzt1vuy0Gr4kQP99d7Rm1
	A1Mj4xyTBGZsBCHdIeOPtlKqpMGmK3EHmKu6F2NH7xTr1yar0c2lzZTvN2ZVBxAATvIQOSr/88n
	Dgod1AlwPrjwb+HnlRaRNlDf/JvmmxtYa16UjCYMaecKdNeWxJdsqP2mK0U3UQI5UcvMad+WnwV
	cHAKYD/H+3f6MiS98zthbog5moleTOogQCgniwcmofmTWkZkWT6yXOtWy8m/sU/2zqhEwYX7g/s
	lszG/sPKGpKL3o1zq++hnpK193WaaubfcZdTK
X-Google-Smtp-Source: AGHT+IH7PQQbfmJgJD7GH8Vm6B00ERalcVbwZY3ujfWQ/Sk8USaPy2rNxpFq+BU/9m6gePXLTLpqZQ==
X-Received: by 2002:a17:907:7b8a:b0:afa:f1:ff98 with SMTP id a640c23a62f3a-afe2953d368mr1503376866b.37.1756212570825;
        Tue, 26 Aug 2025 05:49:30 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe49310dc1sm771790266b.86.2025.08.26.05.49.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Aug 2025 05:49:30 -0700 (PDT)
Date: Tue, 26 Aug 2025 12:49:29 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
	lorenzo.stoakes@oracle.com, ziy@nvidia.com,
	baolin.wang@linux.alibaba.com, npache@redhat.com,
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
	linux-mm@kvack.org, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/khugepaged: fix the address passed to notifier on
 testing young
Message-ID: <20250826124929.w5zll53rzgdfok3u@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250822063318.11644-1-richard.weiyang@gmail.com>
 <0a2004c2-76e7-43ea-be47-b6c957e0fc14@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a2004c2-76e7-43ea-be47-b6c957e0fc14@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Tue, Aug 26, 2025 at 10:53:45AM +0200, David Hildenbrand wrote:
>On 22.08.25 08:33, Wei Yang wrote:
>> Commit 8ee53820edfd ("thp: mmu_notifier_test_young") introduced
>> mmu_notifier_test_young(), but we should pass the address need to test.
>
>... "but we are passing the wrong address".
>
>> In xxx_scan_pmd(), the actual iteration address is "_address" not
>> "address". We seem to misuse the variable on the very beginning.
>> 
>> Change it to the right one.
>> 
>> Fixes: 8ee53820edfd ("thp: mmu_notifier_test_young")
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>> Cc: Zi Yan <ziy@nvidia.com>
>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
>> Cc: Nico Pache <npache@redhat.com>
>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>> Cc: Dev Jain <dev.jain@arm.com>
>> Cc: Barry Song <baohua@kernel.org>
>> CC: <stable@vger.kernel.org>
>> 
>> ---
>> The original commit 8ee53820edfd is at 2011.
>> Then the code is moved to khugepaged.c in commit b46e756f5e470 ("thp:
>> extract khugepaged from mm/huge_memory.c") in 2022.
>> ---
>>   mm/khugepaged.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index 24e18a7f8a93..b000942250d1 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -1418,7 +1418,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
>>   		if (cc->is_khugepaged &&
>>   		    (pte_young(pteval) || folio_test_young(folio) ||
>>   		     folio_test_referenced(folio) || mmu_notifier_test_young(vma->vm_mm,
>> -								     address)))
>> +								     _address)))
>
>Please just put that into a single line, that's a perfectly reasonable case
>to exceed 80 chars.
>
>
>Acked-by: David Hildenbrand <david@redhat.com>

Thanks.

@Andrew

Would you mind adjust the changelog and put it into one line?

>
>>   			referenced++;
>>   	}
>>   	if (!writable) {
>
>Maybe, just maybe, it's because of *horrible* variable naming.
>
>Can someone please send a cleanup to rename address -> pmd_addr and
>_address -> pte_addr or sth like that?
>
>pretty much any naming is better than this.
>
>-- 
>Cheers
>
>David / dhildenb

-- 
Wei Yang
Help you, Help me

