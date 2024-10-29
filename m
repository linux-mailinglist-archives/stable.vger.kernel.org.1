Return-Path: <stable+bounces-89148-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 789109B3FB5
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 02:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F05C1F230D3
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 01:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E857580054;
	Tue, 29 Oct 2024 01:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWWAES9H"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856E741A84
	for <stable@vger.kernel.org>; Tue, 29 Oct 2024 01:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730165050; cv=none; b=VbnR4duAf92TZleRCyqZE2PtoV4fc5ti/1oJgJRM/WZOcYvlfQ4e/O0Z/2+2Jsn5bY88qufrSsiTc5I9iSWWkX2uBYSuyKra0S/FAd50aPdBlhFj54NaEdRmZW3IYOjecg2v8PDPLgUg3NLkZO4pwtsu3bZ/MZWctTFFX59cj7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730165050; c=relaxed/simple;
	bh=nYuzoirCf+f+6oQJi+7AeNHYYEHpdZCt82zdY1Y5UmY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FfJGX5JrYqO6VBYyO9VeH3AyncYRsme/B2hPh9NGwiHAUZHgV0HU0R2Tiy/IHl3iGAzp3aksLsTaY++0QGsEqiUB5BTLBWJNOQsrBAinmo+ls6nzN+ALtuSxlhwMS9WmLE7UZjcIIwaCKc+B23pAbviaXMOxSYUCjl+fm8AYLvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BWWAES9H; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9a0ec0a94fso686966966b.1
        for <stable@vger.kernel.org>; Mon, 28 Oct 2024 18:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730165047; x=1730769847; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s/mAWDikvIDQw+vWG+QrRFU5cEDrxs26l3aEcKfA+60=;
        b=BWWAES9HV3NIsGOr22zPBKGWJ62Wz11STEUoX9fhkS/wdphzGI8uSXhIkAx5A8ezOT
         1yG0TCAjgi10isEPkXeOCs7CSgkS28ymO4f6LwnrLf8Y0555MAdTQBeOfq7XubmRX4FK
         a4Qq6oDKM1APyAB2MWptYV3LZ6HqL0kqodmGNOow61lM25bsmwXWpdAa0/hwhork6mQc
         ZRqoniwt7Z9aX29UAnlFxSaJaAaoCI1V9R3wMekK8NfPr/6fqqwYBGMuktAsq9cu5G9i
         2oaKvUSnQtU6ic3wqqgUxfoYpB1mc/H5dMTi30+kwsCHKUbq+g7s8xUCuFLFAX4HwbqL
         mTRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730165047; x=1730769847;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s/mAWDikvIDQw+vWG+QrRFU5cEDrxs26l3aEcKfA+60=;
        b=XhwpxBcEOC4/Gsp/psYzs9Tjdy5yFm3kNs4RG40bob5Yce3bcs1Z/ViZEd8ZQcyVCu
         uNCEhWMiIrMpKyYfnp+ipzu9HGwFz5HGcQ6XlhPT6Cf5IXExEbYz4Q9YrOXb0uEDdgpl
         bOP639e1OtTS5Fvhq1PssJC9Sh/65CdjYn1sEJqExoUiN8r4+GsGYX0pizb9X23vRktY
         iY3Ix1pUCH9R+cMO/aEgzU6LAtBjoQge9qbdMZFbmMY+OrEKGxkPPRIIGbHZ+1kT0YLm
         HmsQfraGvtKbYybT9ImZiEe2KajF4uZ3LyOHHpL84QnXL8pl94LVK1A5uxzc1TQYl8RE
         awmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVI6bd59UzjgxqBU1Aay2fkOCNX59N2cnRWTv6s7xu8WNOgQHTd7pjSJlpVBBnQ8dwbtzzpcB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVtqJrsz8irj0BgLlfXn7WW4fp4LRXoUwnbwmuPhtbZI63d32N
	2cmtc3q7dnYq2f2wwI8KZABrW/N7o3QcfbjtuIWOssH/EzDJxYtD
X-Google-Smtp-Source: AGHT+IHK3aubRbgRaYLdcR7bNT1nVGNqr7Om4S8pl5QtTE406/X2ywglFxTqnscPyMG6gTbMZecstw==
X-Received: by 2002:a17:907:7d8b:b0:a9a:1739:91e9 with SMTP id a640c23a62f3a-a9de5edb1efmr916394666b.24.1730165046500;
        Mon, 28 Oct 2024 18:24:06 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f030193sm423364666b.85.2024.10.28.18.24.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Oct 2024 18:24:04 -0700 (PDT)
Date: Tue, 29 Oct 2024 01:24:03 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
	vbabka@suse.cz, lorenzo.stoakes@oracle.com, linux-mm@kvack.org,
	Jann Horn <jannh@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH hotfix 6.12 v2] mm/mlock: set the correct prev on failure
Message-ID: <20241029012403.5h7sajuj5rxtoyn5@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20241027123321.19511-1-richard.weiyang@gmail.com>
 <z54jwszrhsjewssvswsmucnbjgzyzygvzlmnkiniwxct6akcfw@nwc2kwht2ofq>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <z54jwszrhsjewssvswsmucnbjgzyzygvzlmnkiniwxct6akcfw@nwc2kwht2ofq>
User-Agent: NeoMutt/20170113 (1.7.2)

On Mon, Oct 28, 2024 at 11:00:43AM -0400, Liam R. Howlett wrote:
>* Wei Yang <richard.weiyang@gmail.com> [241027 08:34]:
>> After commit 94d7d9233951 ("mm: abstract the vma_merge()/split_vma()
>> pattern for mprotect() et al."), if vma_modify_flags() return error, the
>> vma is set to an error code. This will lead to an invalid prev be
>> returned.
>> 
>> Generally this shouldn't matter as the caller should treat an error as
>> indicating state is now invalidated, however unfortunately
>> apply_mlockall_flags() does not check for errors and assumes that
>> mlock_fixup() correctly maintains prev even if an error were to occur.
>> 
>> This patch fixes that assumption.
>> 
>> [lorenzo: provide a better fix and rephrase the log]
>> 
>> Fixes: 94d7d9233951 ("mm: abstract the vma_merge()/split_vma() pattern for mprotect() et al.")
>> 
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> CC: Liam R. Howlett <Liam.Howlett@Oracle.com>
>> CC: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>> CC: Vlastimil Babka <vbabka@suse.cz>
>> CC: Jann Horn <jannh@google.com>
>> Cc: <stable@vger.kernel.org>
>> 
>> ---
>> v2: 
>>    rearrange the fix and change log per Lorenzo's suggestion
>>    add fix tag and cc stable
>> 
>> ---
>>  mm/mlock.c | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>> 
>> diff --git a/mm/mlock.c b/mm/mlock.c
>> index e3e3dc2b2956..cde076fa7d5e 100644
>> --- a/mm/mlock.c
>> +++ b/mm/mlock.c
>> @@ -725,14 +725,17 @@ static int apply_mlockall_flags(int flags)
>>  	}
>>  
>>  	for_each_vma(vmi, vma) {
>> +		int error;
>>  		vm_flags_t newflags;
>>  
>>  		newflags = vma->vm_flags & ~VM_LOCKED_MASK;
>>  		newflags |= to_add;
>>  
>> -		/* Ignore errors */
>> -		mlock_fixup(&vmi, vma, &prev, vma->vm_start, vma->vm_end,
>> -			    newflags);
>> +		error = mlock_fixup(&vmi, vma, &prev, vma->vm_start, vma->vm_end,
>> +				    newflags);
>> +		/* Ignore errors, but prev needs fixing up. */
>> +		if (error)
>> +			prev = vma;
>
>I don't think we need a local variable for the error since it's not used
>for anything besides ensuring there was a non-zero return here, but it
>probably doesn't make a difference.  I'd have to check the assembly to
>be sure.
>
>Either way,
>
>Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
>

Thanks

>>  		cond_resched();
>>  	}
>>  out:
>> -- 
>> 2.34.1
>> 

-- 
Wei Yang
Help you, Help me

