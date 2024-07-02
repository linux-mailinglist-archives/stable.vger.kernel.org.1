Return-Path: <stable+bounces-56359-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 227A0924191
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 16:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D4A2B21208
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 14:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B5F1BA86F;
	Tue,  2 Jul 2024 14:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NgHzVu1X"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABA01DFE3
	for <stable@vger.kernel.org>; Tue,  2 Jul 2024 14:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719932271; cv=none; b=XAiKiY75Qt8VSGkSKmWgKgVRuHc6GBLJAKqmOG4IxjHOvsF4mJ6w66GGUM0If93ZHZLU5xNUncpzeDnThs/DPRR2NjarfGpiskMl+R7arXW0PGJDGtuCfs49Ok4yFuEwAO8gXNSbJa318HKfuv++d5tx/uV8eHQJ7lWlZ7oopw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719932271; c=relaxed/simple;
	bh=/CgyK46HdK2hUZHWsjXOa3N+7bMlrtcHyHdWQLnPcX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cHi8yeve1uY+Iab4ChMecnB3mSerLxwnfYlpd/AcRafWEkwFBE/TQCbKGblzVGsUIcezN+qebZJNjzr7yX0d6YvX9EzsjcBv2lzqzM2vRWcXLufc1rz9AwA8h3pswEuBTXZUboLf1gu8Kf4ony4AqS+c895lr8Ga1tzt0IVK2wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NgHzVu1X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719932269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Skfcwdt+j48BYnr0l9jeHaERQcRlGVKWEr4NqGvPOM4=;
	b=NgHzVu1XjtRiye7ru/VFE8QYQFxe3uZCpX353jidnJ3qLo41VHUh2DBQOvTZi5SrAyX+WB
	U/BcYZam6YCAl6bHJ42wQIHqX+dTJAVF2pMShtTk2hv/GJAEnNEa0O7BD9X43l5W9bH1X4
	ctB2jcR49y2BES4vrn1my84EPxpHYnA=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-Utnjnlr8NsmJFB5yEZ89AQ-1; Tue, 02 Jul 2024 10:57:47 -0400
X-MC-Unique: Utnjnlr8NsmJFB5yEZ89AQ-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-52e6e19e6d4so4284916e87.3
        for <stable@vger.kernel.org>; Tue, 02 Jul 2024 07:57:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719932266; x=1720537066;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Skfcwdt+j48BYnr0l9jeHaERQcRlGVKWEr4NqGvPOM4=;
        b=xFqnNleS8IT/KL4v+XnGGk4qNGhmaqu21WvQ2+tYGDA3h3AnjVyQEFotBBLLmMmDWx
         8Hd3/UFj3zYnZnAT8GbtBGTsEP1dHSdOvTDedV8sbjPtHaLuct8+0s2GY9N9q4V0DROT
         ehul5/alXEd/ScWou1x1gp7WpmZHKfNC65VkK1AeUYPdaj/Y6C+27mYVYB4DMbwgfKG1
         qbUS8835uGmGDFHcLGJFfBC7x8JIf5UuL6dTtzqkjsNgGnyQIJn4+dlM+G8oKWKSP616
         flwcjLzhm0xCS3WSVXEiYkdDesSvrppSciHgRbmNGMsHTTsMtsfeBq0B89Rl5jfQworF
         Fwqg==
X-Forwarded-Encrypted: i=1; AJvYcCUwYftV+gRuPOCOLqi+40ZcLxcL7YEH3HrzJ8gxyUryO0KTXrka+EiOfs2ZdZ+xGH47Ds+kEl7BGu5nHaP93H0JeZbiH3Fx
X-Gm-Message-State: AOJu0YwhGNn45K4Kx5U35WtIlYSCamN+y0oS+sDhm7OCmiDFV6OxIE8Y
	cQAeQZn6VQg0v8M+MkNHxLqOWL9dBuOHGwCUZO/cClUD5LBu26zC1D+nMYVIBtulBKq2ROwOyxS
	SuueRYboaDORDj9vKDWtqkW2e07i/yqSq1ZO57rUIdk4TzbtSD379pg==
X-Received: by 2002:a05:6512:1385:b0:52c:e030:1450 with SMTP id 2adb3069b0e04-52e8264b681mr4832524e87.14.1719932266361;
        Tue, 02 Jul 2024 07:57:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDHilUwaAXcPVxexTTUeQlNBFNURMx0L6gn/9TdAm2ayvdLGuwxeSBGKDJMYwjtgRzoGuRxg==
X-Received: by 2002:a05:6512:1385:b0:52c:e030:1450 with SMTP id 2adb3069b0e04-52e8264b681mr4832496e87.14.1719932265851;
        Tue, 02 Jul 2024 07:57:45 -0700 (PDT)
Received: from ?IPV6:2003:cb:c739:2400:78ac:64bb:a39e:2578? (p200300cbc739240078ac64bba39e2578.dip0.t-ipconnect.de. [2003:cb:c739:2400:78ac:64bb:a39e:2578])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0e141esm13345649f8f.58.2024.07.02.07.57.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 07:57:45 -0700 (PDT)
Message-ID: <c877a136-4294-4f00-b0ac-7194fe170452@redhat.com>
Date: Tue, 2 Jul 2024 16:57:44 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm: Fix khugepaged activation policy
To: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>,
 Barry Song <baohua@kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Lance Yang <ioworker0@gmail.com>, Yang Shi <shy828301@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240702144617.2291480-1-ryan.roberts@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240702144617.2291480-1-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.07.24 16:46, Ryan Roberts wrote:
> Since the introduction of mTHP, the docuementation has stated that
> khugepaged would be enabled when any mTHP size is enabled, and disabled
> when all mTHP sizes are disabled. There are 2 problems with this; 1.
> this is not what was implemented by the code and 2. this is not the
> desirable behavior.
> 
> Desirable behavior is for khugepaged to be enabled when any PMD-sized
> THP is enabled, anon or file. (Note that file THP is still controlled by
> the top-level control so we must always consider that, as well as the
> PMD-size mTHP control for anon). khugepaged only supports collapsing to
> PMD-sized THP so there is no value in enabling it when PMD-sized THP is
> disabled. So let's change the code and documentation to reflect this
> policy.
> 
> Further, per-size enabled control modification events were not
> previously forwarded to khugepaged to give it an opportunity to start or
> stop. Consequently the following was resulting in khugepaged eroneously
> not being activated:
> 
>    echo never > /sys/kernel/mm/transparent_hugepage/enabled
>    echo always > /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/enabled
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> Fixes: 3485b88390b0 ("mm: thp: introduce multi-size THP sysfs interface")
> Closes: https://lore.kernel.org/linux-mm/7a0bbe69-1e3d-4263-b206-da007791a5c4@redhat.com/
> Cc: stable@vger.kernel.org
> ---
> 
> Hi All,
> 
> Applies on top of today's mm-unstable (9bb8753acdd8). No regressions observed in
> mm selftests.
> 
> When fixing this I also noticed that khugepaged doesn't get (and never has been)
> activated/deactivated by `shmem_enabled=`. I'm not sure if khugepaged knows how
> to collapse shmem - perhaps it should be activated in this case?
> 

Call me confused.

khugepaged_scan_mm_slot() and madvise_collapse() only all 
hpage_collapse_scan_file() with ... IS_ENABLED(CONFIG_SHMEM) ?

collapse_file() is only called by hpage_collapse_scan_file() ... and 
there we check "shmem_file(file)".

So why is the IS_ENABLED(CONFIG_SHMEM) check in there if collapse_file() 
seems to "collapse filemap/tmpfs/shmem pages into huge one".

Anyhow, we certainly can collapse shmem (that's how it all started IIUC).

Besides that, khugepaged only seems to collapse !shmem with
   VM_BUG_ON(!IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && !is_shmem);

The thp_vma_allowable_order() check tests if we are allowed to collapse 
a PMD_ORDER in that VMA.

-- 
Cheers,

David / dhildenb


