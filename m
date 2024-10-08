Return-Path: <stable+bounces-81503-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 892ED993DB4
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 05:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D91B1F24F92
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 03:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3CA61FEB;
	Tue,  8 Oct 2024 03:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Sqow9lV9"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9EC1DA5F
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 03:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728359613; cv=none; b=kPfGZw0JV0ue5YtkHhHo9LNlAjSnbWFxgsIlePrfHs00fptSdSWZ+qNmDCJeQMk+nWkDJWLw7dG+cIPz4hLlgK754d/jQ98XJZEIBAyBjppTqla2ZoFOUHcau4Vj9bdRr2F3BQRMF87/sAVmkN30x5O8KFb49Kn3alnLQTH3gWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728359613; c=relaxed/simple;
	bh=RDBNanjeTqAsh9rPG2jAlXFjrg3LR8U84MfLAQ6XceI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LpK3jMgl6Ry7A5Z+vIe4GMbQp3ryWatoe63XRzKCE+TxX4Dod+A2pEDjfiJVulB9roo7+gW4nC7SG2eMbaR8/6cVrGOOW4M8Sm3I69rnJw3dv/bcvrHWr0SaWP1ylLnn2RYLiQlMbQzvW2y69s9Pl7QKfoOSHDT3kLLVdvhvAf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Sqow9lV9; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7e9fd82f1a5so1475886a12.1
        for <stable@vger.kernel.org>; Mon, 07 Oct 2024 20:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1728359610; x=1728964410; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bZmM1kivjY+OP9fhZeIHR6lGq4KOb7jxhbJjcjvyqC4=;
        b=Sqow9lV9cIVb81dSGgA5ionHvRU86QzWK3f2WAzktCajEHUaDZgaHKlgHs3xKk0TJ3
         RiGzciQbqA86i6PVz0oVWRf1uy0kdo2EEvpeDSHhaTspLBNLCE4Eb+J6zNYWT0B6Jan/
         gzp1qGTT4JYBB56dN5ejQ6IesuaKi3Jkf+jYCEZWaXMcIGYbhzXpd4Y9nALEYIOM8z7D
         xizBSQqZnSwYDpzXG7J5h6BnwUltCu6iWhuEY+i761nahI2Aqc0SxeASumFEjW7EjRFc
         ff99mcjWUE/VL5bh6Y0S1CSQdFSc8gP32ZzPzMIWJNt5ZaMWdw2RppkcH8y/+3ZHX+iS
         JULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728359610; x=1728964410;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bZmM1kivjY+OP9fhZeIHR6lGq4KOb7jxhbJjcjvyqC4=;
        b=dHJc2+j8qWu0Teo7SdGUuimss96NAz1kQhD3wN9HSLXvVADf6fqf09VdI+t7IG11mT
         o30k5F9bp4kte1JUrAW8zNSWGl1NIwfwbdrsy/OX02UrXYMM02Ki5XPtqw3TUj4tj6uD
         +PVDf3CcNUe0emtlCzWDBynLLsuJkodQ8+J/3OpaCR8ZtvDMWEbfwaBEPCjfSA8US5z5
         HkdHTh/Wdk25BRj1D47bccYpo3BsJ+t67BTUUd44kwu7E+oRsmB4OV7vnIYOvVO5Wh15
         F0rMHSB4oKgSzVaylflFQ+I9lYHZoBmxrhFdlqAgDqPfP5n9tiWhIzzvLTe8By2d9pcF
         msuw==
X-Forwarded-Encrypted: i=1; AJvYcCXhB1I7myK6qNZWZr8yeMzCVs+N8hJmjgUl+AQcPejUIEpeUp+EE30792T5oLm+8Q/LmgOKauM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq4WKB7Tbpe2p1+QtVS7SC3VMeGNvKi4n0lPKi7Tc7wWJlldDq
	O0uraTmBPsxQME1yf8CXIET3aSP0IUlGYUFOJ82pPX4XnLHNQ5gae6a9q5+PW0s=
X-Google-Smtp-Source: AGHT+IEKN2Kdq3MW9os/92sJ7powcTTKtvPCz4qyJxzSGTfT7D+tIcgPx2zAUwMNJC9bB5QI33ZTzA==
X-Received: by 2002:a05:6a21:38b:b0:1cf:4c70:f26f with SMTP id adf61e73a8af0-1d6dfa3a765mr20221207637.17.1728359610462;
        Mon, 07 Oct 2024 20:53:30 -0700 (PDT)
Received: from [10.68.125.128] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f680c732sm5718701a12.12.2024.10.07.20.53.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 20:53:30 -0700 (PDT)
Message-ID: <1c114925-9206-42b1-b24b-bb123853a359@bytedance.com>
Date: Tue, 8 Oct 2024 11:53:23 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/mremap: Fix move_normal_pmd/retract_page_tables race
Content-Language: en-US
To: Jann Horn <jannh@google.com>
Cc: akpm@linux-foundation.org, david@redhat.com, linux-mm@kvack.org,
 willy@infradead.org, hughd@google.com, lorenzo.stoakes@oracle.com,
 joel@joelfernandes.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20241007-move_normal_pmd-vs-collapse-fix-2-v1-1-5ead9631f2ea@google.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20241007-move_normal_pmd-vs-collapse-fix-2-v1-1-5ead9631f2ea@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jann,

On 2024/10/8 05:42, Jann Horn wrote:

[...]

> 
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 24712f8dbb6b..dda09e957a5d 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -238,6 +238,7 @@ static bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
>   {
>   	spinlock_t *old_ptl, *new_ptl;
>   	struct mm_struct *mm = vma->vm_mm;
> +	bool res = false;
>   	pmd_t pmd;
>   
>   	if (!arch_supports_page_table_move())
> @@ -277,19 +278,25 @@ static bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
>   	if (new_ptl != old_ptl)
>   		spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
>   
> -	/* Clear the pmd */
>   	pmd = *old_pmd;
> +
> +	/* Racing with collapse? */
> +	if (unlikely(!pmd_present(pmd) || pmd_leaf(pmd)))

Since we already hold the exclusive mmap lock, after a racing
with collapse occurs, the pmd entry cannot be refilled with
new content by page fault. So maybe we only need to recheck
pmd_none(pmd) here?

Thanks,
Qi

> +		goto out_unlock;
> +	/* Clear the pmd */
>   	pmd_clear(old_pmd);
> +	res = true;
>   
>   	VM_BUG_ON(!pmd_none(*new_pmd));
>   
>   	pmd_populate(mm, new_pmd, pmd_pgtable(pmd));
>   	flush_tlb_range(vma, old_addr, old_addr + PMD_SIZE);
> +out_unlock:
>   	if (new_ptl != old_ptl)
>   		spin_unlock(new_ptl);
>   	spin_unlock(old_ptl);
>   
> -	return true;
> +	return res;
>   }
>   #else
>   static inline bool move_normal_pmd(struct vm_area_struct *vma,
> 
> ---
> base-commit: 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b
> change-id: 20241007-move_normal_pmd-vs-collapse-fix-2-387e9a68c7d6

