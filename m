Return-Path: <stable+bounces-81533-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6888D994132
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 10:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AAD42878DE
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 08:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AE41E04AF;
	Tue,  8 Oct 2024 07:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="glh3wjA1"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37D61E04AD
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 07:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728373822; cv=none; b=HMV29BgTx5MjSp9bI940k/7j2mjANfBPKTDBdeVAOz5UUn80hs8B9hqshpe6eTVqPTsiKUVhd/HC1NJfqf3ZsJsFmChINunU56dTQrV4etErGHT0APhLyj/VqCmj543bkAVxO5TBG/QzPxRO4oCDOOvOUVgOWJ2tkfDHxGsD/nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728373822; c=relaxed/simple;
	bh=aONYALUEi47AhYG18AZ8I3Jue6GwQ11/Z7xT2lcouw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GAF91tANkakt2/nER48GE5Ae7zn9YIO5Ip3CxJEWZs+t3UxOrsm6S4XSefbbKgzL3+jtWlF25vHQuWH05zIkLjurY6qRnYP0mpe+MMDUjRnhqRElgqpD1ocA5yGzp44n1mZQxwgTsbFQzsPNZNetaxNU6OTWIxFSljOW6QTjjOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=glh3wjA1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728373819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8xv2thTV3Zvu6oGxZvIbDIQfodchFrQbt6h0I4tmoIY=;
	b=glh3wjA17BWPz0WWTWEza8tI3h8X1+Py3kVCwUTmNtPJElrc5Ki1luzIonYMA5v4OFuKLk
	qrHnD6rvbWAabFKT6bmR1fTf8EjQIDJxCClkvU47XhkKPxH3NUPGKSts+T+rzYmojAnY1+
	HtpMC+kCoc6FvQTTjxPUPGE8FTLUtQU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-kiotgIPeOoWqawLwCf8hBw-1; Tue, 08 Oct 2024 03:50:18 -0400
X-MC-Unique: kiotgIPeOoWqawLwCf8hBw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42f89a68c29so22138635e9.1
        for <stable@vger.kernel.org>; Tue, 08 Oct 2024 00:50:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728373817; x=1728978617;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8xv2thTV3Zvu6oGxZvIbDIQfodchFrQbt6h0I4tmoIY=;
        b=jDdO0VjCyb5TiEfryVS1ufFJ73nnIdmrGwj9TgIU1kzK01KWycOMLFaR6IKIPWrOFO
         bvZzPMVdgBKxPADQVQRzGKM2wwtsH2UX84qcMo7OSlzH92GXI7ngdSMLBZq/wd65FuIO
         zjt0wIe4PXbzYgw/D/Wjgpqq+ELfbdiDOi0mSYS4cQkUET7043YWt1o5z4HfiVcVSUOI
         boeaZXz8KLyc5pbl24zsMRsr/zE9LxXeS53TCUlIGmsFx6WZt0E9zfWrGLzSo1s6KnnY
         VRf9os8GJtx03fEiqmzrsTCNadU4N8drzQ4pIrEeH3UrbrL2GO/mg+w7GC+GXortli4F
         GNGA==
X-Forwarded-Encrypted: i=1; AJvYcCXCGB2jV/AzDDR5boWH885Nhy7+VyoE1PWqxjgPlb6LAO2EFfETfmoN4dSt3ruueVtd1vwmsN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIda+LnhXLP1sNB18xWe0myK+jsOZSwXM6RWwD4xbPL8/7WJwg
	pLgGdQ/yWDLnj0q7F+XjrW8WAiZ1K6xyHycXYSYZZVHcfEJr+TZYW/W/bSwyll7srsm7csnUjhz
	q2FXQajGPDNEtVdTK6th5lQWEttI2oRQQWWfXkEdKjfodhrnNuHsYWg==
X-Received: by 2002:a05:600c:1d0f:b0:42c:b9b1:8342 with SMTP id 5b1f17b1804b1-42f91e2a687mr38306965e9.19.1728373816831;
        Tue, 08 Oct 2024 00:50:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFg6ruzLn8LDKgfXnV6MKx6jltNtVtvGccSyCiFxaUA0QIsJGSSjTpd1hqO4U9OGDmYchlXgg==
X-Received: by 2002:a05:600c:1d0f:b0:42c:b9b1:8342 with SMTP id 5b1f17b1804b1-42f91e2a687mr38306785e9.19.1728373816396;
        Tue, 08 Oct 2024 00:50:16 -0700 (PDT)
Received: from ?IPV6:2003:cb:c72f:c700:a76f:473d:d5cf:25a8? (p200300cbc72fc700a76f473dd5cf25a8.dip0.t-ipconnect.de. [2003:cb:c72f:c700:a76f:473d:d5cf:25a8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86a20595sm117161735e9.14.2024.10.08.00.50.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 00:50:15 -0700 (PDT)
Message-ID: <316dadcb-b199-4b94-8d07-94b40bf534df@redhat.com>
Date: Tue, 8 Oct 2024 09:50:14 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/mremap: Fix move_normal_pmd/retract_page_tables race
To: Jann Horn <jannh@google.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, willy@infradead.org, hughd@google.com,
 lorenzo.stoakes@oracle.com, joel@joelfernandes.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20241007-move_normal_pmd-vs-collapse-fix-2-v1-1-5ead9631f2ea@google.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241007-move_normal_pmd-vs-collapse-fix-2-v1-1-5ead9631f2ea@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.10.24 23:42, Jann Horn wrote:
> In mremap(), move_page_tables() looks at the type of the PMD entry and the
> specified address range to figure out by which method the next chunk of
> page table entries should be moved.
> At that point, the mmap_lock is held in write mode, but no rmap locks are
> held yet. For PMD entries that point to page tables and are fully covered
> by the source address range, move_pgt_entry(NORMAL_PMD, ...) is called,
> which first takes rmap locks, then does move_normal_pmd().
> move_normal_pmd() takes the necessary page table locks at source and
> destination, then moves an entire page table from the source to the
> destination.
> 
> The problem is: The rmap locks, which protect against concurrent page table
> removal by retract_page_tables() in the THP code, are only taken after the
> PMD entry has been read and it has been decided how to move it.
> So we can race as follows (with two processes that have mappings of the
> same tmpfs file that is stored on a tmpfs mount with huge=advise); note
> that process A accesses page tables through the MM while process B does it
> through the file rmap:
> 
> 
> process A                      process B
> =========                      =========
> mremap
>    mremap_to
>      move_vma
>        move_page_tables
>          get_old_pmd
>          alloc_new_pmd
>                        *** PREEMPT ***
>                                 madvise(MADV_COLLAPSE)
>                                   do_madvise
>                                     madvise_walk_vmas
>                                       madvise_vma_behavior
>                                         madvise_collapse
>                                           hpage_collapse_scan_file
>                                             collapse_file
>                                               retract_page_tables
>                                                 i_mmap_lock_read(mapping)
>                                                 pmdp_collapse_flush
>                                                 i_mmap_unlock_read(mapping)
>          move_pgt_entry(NORMAL_PMD, ...)
>            take_rmap_locks
>            move_normal_pmd
>            drop_rmap_locks
> 
> When this happens, move_normal_pmd() can end up creating bogus PMD entries
> in the line `pmd_populate(mm, new_pmd, pmd_pgtable(pmd))`.
> The effect depends on arch-specific and machine-specific details; on x86,
> you can end up with physical page 0 mapped as a page table, which is likely
> exploitable for user->kernel privilege escalation.
> 
> 
> Fix the race by letting process B recheck that the PMD still points to a
> page table after the rmap locks have been taken. Otherwise, we bail and let
> the caller fall back to the PTE-level copying path, which will then bail
> immediately at the pmd_none() check.
> 
> Bug reachability: Reaching this bug requires that you can create shmem/file
> THP mappings - anonymous THP uses different code that doesn't zap stuff
> under rmap locks. File THP is gated on an experimental config flag
> (CONFIG_READ_ONLY_THP_FOR_FS), so on normal distro kernels you need shmem
> THP to hit this bug. As far as I know, getting shmem THP normally requires
> that you can mount your own tmpfs with the right mount flags, which would
> require creating your own user+mount namespace; though I don't know if some
> distros maybe enable shmem THP by default or something like that.
> 
> Bug impact: This issue can likely be used for user->kernel privilege
> escalation when it is reachable.
> 
> Cc: stable@vger.kernel.org
> Fixes: 1d65b771bc08 ("mm/khugepaged: retract_page_tables() without mmap or vma lock")
> Closes: https://project-zero.issues.chromium.org/371047675
> Co-developed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> @David: please confirm we can add your Signed-off-by to this patch after
> the Co-developed-by.

Sure, thanks for sending this out!

Signed-off-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


