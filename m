Return-Path: <stable+bounces-183010-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB45BB2ABF
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 09:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BD8E19259CF
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 07:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9DE28F935;
	Thu,  2 Oct 2025 07:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KoANV70f"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77878136351
	for <stable@vger.kernel.org>; Thu,  2 Oct 2025 07:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759389309; cv=none; b=Bpa+FjTREb/1E0Xs0MLALtvgkk5LZ2mX5RkDUDHEeOU03OF2ItkaUO5tT3uMZKkp2oJbLeaJlu6VRqVlWj6iMgyARJEWBuAfY0iXu94XzySaDxKn36EHztJrH0M1P3DnqqHLO3tO8w1VQL5XBu3iFNR5m+yYoFG6IY5w6H+TrEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759389309; c=relaxed/simple;
	bh=r1X7gjQp3q7PttXv0xXz9fxuLfZlwKxlgl236AtZkrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pxsckmnVCXJQ4rkcGYRmtD++iRngrybtJEzxjgfn7mGXgSC2n4p5VDHA5KwtqyyWqtaprw/3cFSWXWeJnjj+idhyPKe3iOtLRsS+6onoD0W7yA9/9J2++KJdJjpjsSFDs8vueS+nuqND4cgjZOmODuLihT16+/bVJK34ua++pbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KoANV70f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759389305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=W5Ac778AheL7NpJNRSTMLehCP0Q4ZljNAYBSiaX38qE=;
	b=KoANV70fVlX0yGCYJMNk+CZ0oHkTjwGhQm4eNlau0xP1wH4c+y7VKExrOsWUH29M8iWx3H
	0OQVgE2scgu1sOAiVlRx5S1fhE0J+xipuR+sofujqPFCEQNKCrQiSc0OR84+00W+b8aZM4
	ZZ1pTMUOwO6DFns2e3gQ2VUBxN54kB0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-SbXHb4-9N-qa6DmG2P0o8A-1; Thu, 02 Oct 2025 03:15:04 -0400
X-MC-Unique: SbXHb4-9N-qa6DmG2P0o8A-1
X-Mimecast-MFC-AGG-ID: SbXHb4-9N-qa6DmG2P0o8A_1759389303
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e2c11b94cso2742575e9.3
        for <stable@vger.kernel.org>; Thu, 02 Oct 2025 00:15:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759389303; x=1759994103;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W5Ac778AheL7NpJNRSTMLehCP0Q4ZljNAYBSiaX38qE=;
        b=T6tZdsJ5AVA/3Xovr3F1/fIMOSDsn8OsRQ0lHkTcXF9cQMRlOAInowpkT925lxVwm3
         73rGat10Bz92mtKpC4pQzV5IbEVSJnANdI5YSfF0Jx0ymsrpjOZANduaUwTGZRiVr25Q
         AnOd0ihOQlSdVA8sLhdP2/ruNg4H8L+Swv/+XH7dnHb6clVrD9GScLlKqkoatrniX1Ef
         o8lHzPxmpxxNqAnvMJbncJd2fsGdCUFidGVnZTP7Cp05cOcSQNiUm3jE1aIh3fCwpXho
         RqL88BHLAqP+FM7hIX7MyT8Ek7lEyvv1k/m64HDv1sbB5XFctI+NqgDXKZj6JkwbLURF
         VVmg==
X-Forwarded-Encrypted: i=1; AJvYcCV2Eb3TY3wlHTdDK1kHs/Ub4HbJY7RCC+uM/SMpXyMuY0wWT1RBzAf4cOkKCGjn1qms3CdUqbM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc+BkKMjOohrC3Da9RAvh+JyFcTklQoMqvo/LprJNA7Syn02If
	AVLsP7UdemvbYLplLYF7Mb5c9+V9OBa22xc/xwP4lG+1NexuGA+oWCfkXr0BOkYbCs62cBrjmiG
	mMJ5moWPxr1N5IKEZa5hfz4rrFPC725KNh0l7pXV1SihzLUfiqHzIh0W4pw==
X-Gm-Gg: ASbGncusV0tqoRdnnp8AeFXIuisCc2VgRb7b/A6pNGVV3wbOB8u+563xRZZPrXPyMfn
	M1akK3MZhLvIfGPn9UHRNjGy7LS8jTohCU6hk4mBQTBM7qMw4zP9h8XOaPUU+ufdYaURLLuI/zc
	ei8TpW14nZK96llPhJuJxX8t2VSbGyeO2wBuvKmn+wEaxb/M8u33FksJWyHWL82I7OKF+R2hPhu
	pVFCH312vCnJ2EaCgTwGj5kQITgMOqvL5vDfS/2isYLW7ekYD8HJ32aITMUA5u3XAcsLs6nMQj5
	6n/KJ+hvS603CzGMfW9Lf3pc4zIm/rneZtafseYJW2GVeGEpoykqwbYPy+TJ4F24B+pTzYVmCzl
	d0MOny5tk
X-Received: by 2002:a05:600c:1c95:b0:46e:6af4:ed83 with SMTP id 5b1f17b1804b1-46e6af4efffmr7952625e9.23.1759389302749;
        Thu, 02 Oct 2025 00:15:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8ldnTz2JbgHQGaCW5pgTHhvepIXyjeIE3ouCdne2DyJMLKZaH3KmUT6eErXmw4mzjZSH9zA==
X-Received: by 2002:a05:600c:1c95:b0:46e:6af4:ed83 with SMTP id 5b1f17b1804b1-46e6af4efffmr7952405e9.23.1759389302317;
        Thu, 02 Oct 2025 00:15:02 -0700 (PDT)
Received: from [192.168.3.141] (tmo-080-144.customers.d1-online.com. [80.187.80.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e6917a279sm23052245e9.4.2025.10.02.00.15.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 00:15:01 -0700 (PDT)
Message-ID: <4cd8bfef-c726-4097-a694-1781898c1d26@redhat.com>
Date: Thu, 2 Oct 2025 09:14:59 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2] mm/huge_memory: add pmd folio to ds_queue in
 do_huge_zero_wp_pmd()
To: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
 lorenzo.stoakes@oracle.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev,
 wangkefeng.wang@huawei.com
Cc: linux-mm@kvack.org, stable@vger.kernel.org
References: <20251002013825.20448-1-richard.weiyang@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251002013825.20448-1-richard.weiyang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.10.25 03:38, Wei Yang wrote:
> We add pmd folio into ds_queue on the first page fault in
> __do_huge_pmd_anonymous_page(), so that we can split it in case of
> memory pressure. This should be the same for a pmd folio during wp
> page fault.
> 
> Commit 1ced09e0331f ("mm: allocate THP on hugezeropage wp-fault") miss
> to add it to ds_queue, which means system may not reclaim enough memory
> in case of memory pressure even the pmd folio is under used.
> 
> Move deferred_split_folio() into map_anon_folio_pmd() to make the pmd
> folio installation consistent.
> 
> Fixes: 1ced09e0331f ("mm: allocate THP on hugezeropage wp-fault")
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Lance Yang <lance.yang@linux.dev>
> Cc: Dev Jain <dev.jain@arm.com>
> Cc: <stable@vger.kernel.org>

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


