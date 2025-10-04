Return-Path: <stable+bounces-183352-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A2229BB8830
	for <lists+stable@lfdr.de>; Sat, 04 Oct 2025 04:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 62F764E3A2B
	for <lists+stable@lfdr.de>; Sat,  4 Oct 2025 02:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6EB27CB02;
	Sat,  4 Oct 2025 02:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XE40yy8P"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA6627B4E5
	for <stable@vger.kernel.org>; Sat,  4 Oct 2025 02:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759543492; cv=none; b=NsekbyL5A0yfSCBPy8amUEUlyChv2BBqACWCL2T6ckZL0w3DACScGMrGLbOB9+6fCs9rhZc8psMmQ46Gsck2GvIbXL5bTO6EU5FI7ohvPPOkUqtByinkgJbKLL/edYboXPgVKsHEvOnBnV4KnkPzNykRbgaHPY2Uj/Wj0AEXU/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759543492; c=relaxed/simple;
	bh=WDDZsOZwZa9YUhMOjILbEPO6mHVX9FMY8wOwG2a8evQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gB99wWc4I7v2HUXE/jJoGwXJmpcWD4mCYZJEBnfGVKZ+pVyHf7IwPW0dUFd6yMLSjYTUKINa8ATHXaeupD61FGU35kweGpxoI4HyXo+W9ku4zJqO8//4Xsc9BcVj+fi5m4JvfKrJOaSN/Dy4/2BUeRY3792ZrXlmYCd3ARS8HzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XE40yy8P; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b3d196b7eeeso448625366b.0
        for <stable@vger.kernel.org>; Fri, 03 Oct 2025 19:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759543488; x=1760148288; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1D7C9zfNsAR/zhcIDvXmSkVC80C03VQ0i27Aj45Yc+c=;
        b=XE40yy8PF9VpxAhC+Njvrgc94a+aXuuYRalXvB4CVfH3dKKSDLVhQwcrbuEIDEDzkn
         WNEIYEiVTjQ40ZVkDl/o0gt+5FPjA8TkWWL1fKpVLvD103M6UF+HXsE+mbSzXVCbrQNW
         ZggJ4Qq40ZErufmu9HltwSja/UDnrgty+MMSj3KUK8AQhbbH90LBMzlmTl6nE2ZxtUJ2
         Z/C6LWKAlzkbnIuO3/fUv4qmLFtTjCi+8xpfg8OzH98RA2zNvKuZxPw9yZhUMlKsY25f
         elFyy8u2pFd+c7tcyV6B/sjwOpPyQLhSBu2hXdMlSKFk+K1ucXJRPscidIIMsPh0ENAZ
         yv5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759543488; x=1760148288;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1D7C9zfNsAR/zhcIDvXmSkVC80C03VQ0i27Aj45Yc+c=;
        b=YkHUP8ay0TiIAhA4lO2zD30Fl5ZTHbnxX95ZSu+5S087JleLMcbkY0yTqKZURNPuvz
         7Z510Y1uaBQqu8cTyZ7fE+pjOR5VVDyeOeGN6J4djktU3Tq2UE3vS7oKbH2CxG5wFKed
         uhGpMBAQI/4LyLR004I8wWgHaJAqOEG2sWIuqLGOA1EW5kL9ASs0n7M6E2CCWZSCuOQ1
         0HGk4F6y4DTwuzqE0q41qSWP/mEeDR3jNWv2hEt2OVxX66knD58CFbQlTVpi97M+pW9u
         lUdgPqQNsDwU3gvCCONG/NqdoqUDcL3xRyMYkGs6kXCZUgZe7O2ne5nWJiF8tytDTSyQ
         Ji0g==
X-Forwarded-Encrypted: i=1; AJvYcCWnrohu4Ww2dMWJa9mK1deUbip1Bcto1Z3R1nG5FCGrAAyQfd8OYtJywqTsTdXkgUeapUQR8KQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN1cYnzD8jG0Cs1YRv+ugLM/IakbPTx9DfHVES4SVLUkhf93Tm
	xKA/b8/1V6nUVrMq8e3Kr+GUKse49RvzjMj7uO/VDDET8TNQNj2nOU9t
X-Gm-Gg: ASbGncslOppdVwQoSeyxR8FuTPmUokf+JDsbtWbam1SL3YfFbJxrdlWIIBKhV4Img0G
	BigPBu9x6u0Md2e22j1ukw+X8AbVYV4UFDuKexkc1L7TyPJfQ4GYbgnFsCOPVt4C5Oo5J6b0QnJ
	1jok2CDdABR3mOpWlQ/V1rHDxD6N52UAQqmiH5mZ6vnfThCATIwCsJqwio25IWdQ9+NlwZh9dai
	kdOqb3+JsqfyRI+kQf/N/p2rVxR1TJXH2AthCWKIlvQFdw1qExiAmAxHKLoDwvNmfXRMWXSWHyP
	GNFy5MrRDLCCDm2uHf0Amf2WmGsfftlB/weAcADvredr5VJD3kerQVjdz9kqlZE/x/dHSn9DLaW
	NVTqp9oIvSJ4kTlWeEhuGXVNYmh2rEtULvAGgSIu9yJsi5A==
X-Google-Smtp-Source: AGHT+IGdf6+OJ2c9+tXrX4oHWR5q+E8r/dTC8pl8N733c73y1ngTRj5iM5bJ0CancYL7rUU+jL2oLg==
X-Received: by 2002:a17:907:3f8f:b0:b3c:4ebc:85e6 with SMTP id a640c23a62f3a-b49c146e65dmr579667266b.10.1759543488268;
        Fri, 03 Oct 2025 19:04:48 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486970b32bsm588129566b.50.2025.10.03.19.04.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Oct 2025 19:04:47 -0700 (PDT)
Date: Sat, 4 Oct 2025 02:04:47 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Lance Yang <lance.yang@linux.dev>
Cc: Wei Yang <richard.weiyang@gmail.com>, linux-mm@kvack.org,
	baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, wangkefeng.wang@huawei.com,
	stable@vger.kernel.org, ziy@nvidia.com, ryan.roberts@arm.com,
	dev.jain@arm.com, npache@redhat.com, baohua@kernel.org,
	akpm@linux-foundation.org, david@redhat.com
Subject: Re: [Patch v2] mm/huge_memory: add pmd folio to ds_queue in
 do_huge_zero_wp_pmd()
Message-ID: <20251004020447.slfiuvu5elidwosl@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251002013825.20448-1-richard.weiyang@gmail.com>
 <d8467e83-aa89-4f98-b035-210c966ef263@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8467e83-aa89-4f98-b035-210c966ef263@linux.dev>
User-Agent: NeoMutt/20170113 (1.7.2)

On Fri, Oct 03, 2025 at 09:49:28PM +0800, Lance Yang wrote:
>Hey Wei,
>
>On 2025/10/2 09:38, Wei Yang wrote:
>> We add pmd folio into ds_queue on the first page fault in
>> __do_huge_pmd_anonymous_page(), so that we can split it in case of
>> memory pressure. This should be the same for a pmd folio during wp
>> page fault.
>> 
>> Commit 1ced09e0331f ("mm: allocate THP on hugezeropage wp-fault") miss
>> to add it to ds_queue, which means system may not reclaim enough memory
>
>IIRC, it was commit dafff3f4c850 ("mm: split underused THPs") that
>started unconditionally adding all new anon THPs to _deferred_list :)
>

Thanks for taking a look.

While at this time do_huge_zero_wp_pmd() is not introduced, how it fix a
non-exist case? And how could it be backported? I am confused here.

>> in case of memory pressure even the pmd folio is under used.
>> 
>> Move deferred_split_folio() into map_anon_folio_pmd() to make the pmd
>> folio installation consistent.
>> 
>> Fixes: 1ced09e0331f ("mm: allocate THP on hugezeropage wp-fault")
>
>Shouldn't this rather be the following?
>
>Fixes: dafff3f4c850 ("mm: split underused THPs")
>
>Thanks,
>Lance

-- 
Wei Yang
Help you, Help me

