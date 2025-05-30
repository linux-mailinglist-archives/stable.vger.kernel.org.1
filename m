Return-Path: <stable+bounces-148322-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E530BAC95D0
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 20:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23DDAA26C4D
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 18:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2278F25228E;
	Fri, 30 May 2025 18:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WI+8oGVE"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E918189513
	for <stable@vger.kernel.org>; Fri, 30 May 2025 18:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748631083; cv=none; b=dY3G3K3UgGzAScjQqiON8DF9ksULl5DsqmRN6eoNEyMZzljSsMASTsmSNQs4TFY+j2qjVgIfbH9IEU9g9nW7ze9N+zcHuXGpo35z3eAqGPHxNwvp2FYs+f+zVftwv17xHH611/gxb9LmKw4cc8F54YjGW7rw46rOrKRxDCMgLA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748631083; c=relaxed/simple;
	bh=eVV9xeVeiv2yXILMXk2UmpohCzZ0JzvHyAW4iBGaRic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PCs5Aj1Fiwp4NW+gtHckeKdW2vyleCTxoJThRIHRwWeP4FV8CMF5htIWGXfZ9EKRR6RBlFs/DSEvufBjU/d7/QgnvDqgdFOZbkrWnN0j0GyQmr3rYP9yKJLwV1ZZ2iGCr1fzwJlFO7j7GyGZUWQKpzx7wqkNTsfOKqmg0oZ+hk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WI+8oGVE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748631078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YJzGuOEyCD92yoey5UJsZHsZc4atn6WQPDIRCxciOwU=;
	b=WI+8oGVE0Huc1UWq8k+SsL70W0axn6rFBZHqlrnca+W6tP8T+6qyWtG6bP2TBMQeCC6D1a
	DDIgWljYWyfdNQJjNkiUiA8zda9bipfTI2rpQwSFlj0Mh8QWOm2tt3orjxae9Kh+/NQlDH
	aLzVfrzUwiV2p81mDjlW2sT308H/2D0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-NgCk06kyOiicY7k0BuQa3w-1; Fri, 30 May 2025 14:51:17 -0400
X-MC-Unique: NgCk06kyOiicY7k0BuQa3w-1
X-Mimecast-MFC-AGG-ID: NgCk06kyOiicY7k0BuQa3w_1748631076
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4eec544c6so1071210f8f.0
        for <stable@vger.kernel.org>; Fri, 30 May 2025 11:51:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748631076; x=1749235876;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YJzGuOEyCD92yoey5UJsZHsZc4atn6WQPDIRCxciOwU=;
        b=KAJ8Bsm9+Fws3KSm6SrxADvjbWxzn5noA8CxZgo3NLumIuNmBCjXzV15tchJOFezPP
         J+cemErRSY5i6Sfdlmn6RHLvmLNy+x+G4McIAarRZXcYt5v7IaEQo0QImwGcjYK1BjYk
         1lNeudlyq1oSzwQBVplAih5kKLn8v5qmwSzOLaN9x3jpB1d/0I/Koa/MeFxRA+ajLr7v
         1GUH48U6vgDYC0xsIan5xri3X0nwoNtODKpIs5h082iWTjc6ibC83xEqAyUhL7Jv9zHw
         RV3EwtJ4X5OVo6zGS9mZjxw2GdswW6qCbulj9ddXtI+HZmzXECF4m5ey+g81fxGQVt//
         Dgjw==
X-Forwarded-Encrypted: i=1; AJvYcCUXY9E/1UAbLQQcehow4e4Ym8Irqcut+VFmpzR1NAePErF0WP8h4ZTIEn+7VboHCrjbH53wtUI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4hFcJjf5mFNrSh0HtfVIyzQjc1xVpEWqMFXPL0VKKZx8RIcGz
	GFOm307zCcCDUOZSL4HOBuh3OAPZpyrXhOBANkgz4nDg6LS44Ufl516SJncIRP6R0b1MbONFb6o
	AIQYWK3h0aaEKMrbGyaBML8nbY3Wy49LR6ipzs05AYjqtKxeTNB80mV/Ugw==
X-Gm-Gg: ASbGncvco9otF215UnoSzB9+EyfLyln5YiCOjUqw2KhDnfYYtds/GfzTBVxeH022s33
	WbNpv4SjVUZUsphUOfWt0G0Wv1H4X6cGIE62jgFe6JJsAhNBgnwDCwNjaAItTGv3FM6iEuigPwr
	PhwU5GEFlkazVV3O+RxyTQwGmf6ToiPYH0LDTlW79+6jZOsjyeIv21FA+wVHRWMhPFH6PCkX1wu
	p0rLNMZ00/mlgaZg1aWqSNaR9LxiLGcag7zGMmFBu0A3T2vBgib3Nbyyn5OWLhByKJrW782KrO7
	n5cJMtZvKpo4FERLX5QFa1hIJ31hEjticvMjPb7BJzC53AgpXkLfBIGZun/u6Nm3h3Dek+xg1Ga
	Z+DSgevicTFILv1tvsOZXUtasgDRHUfXfA6AlrtA=
X-Received: by 2002:a05:6000:18ab:b0:3a4:ea40:4d3f with SMTP id ffacd0b85a97d-3a4f7aafa70mr4212776f8f.53.1748631076242;
        Fri, 30 May 2025 11:51:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXz9jboLNudDIoWr1Y0bfqfhAVm5ux5WqC9fB4zaCC4yD21pmClOISusCFn1KSYiqhpVoOfg==
X-Received: by 2002:a05:6000:18ab:b0:3a4:ea40:4d3f with SMTP id ffacd0b85a97d-3a4f7aafa70mr4212755f8f.53.1748631075852;
        Fri, 30 May 2025 11:51:15 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f03:5b00:f549:a879:b2d3:73ee? (p200300d82f035b00f549a879b2d373ee.dip0.t-ipconnect.de. [2003:d8:2f03:5b00:f549:a879:b2d3:73ee])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe5b8besm5586306f8f.16.2025.05.30.11.51.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 May 2025 11:51:15 -0700 (PDT)
Message-ID: <962c6be7-e37a-4990-8952-bf8b17f6467d@redhat.com>
Date: Fri, 30 May 2025 20:51:14 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] mm: Fix uprobe pte be overwritten when expanding
 vma
To: Pu Lehui <pulehui@huaweicloud.com>, mhiramat@kernel.org, oleg@redhat.com,
 peterz@infradead.org, akpm@linux-foundation.org, Liam.Howlett@oracle.com,
 lorenzo.stoakes@oracle.com, vbabka@suse.cz, jannh@google.com,
 pfalcato@suse.de
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 pulehui@huawei.com
References: <20250529155650.4017699-1-pulehui@huaweicloud.com>
 <20250529155650.4017699-2-pulehui@huaweicloud.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250529155650.4017699-2-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>   
>   	if (vp->remove) {
> @@ -1823,6 +1829,14 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
>   		faulted_in_anon_vma = false;
>   	}
>   
> +	/*
> +	 * If the VMA we are copying might contain a uprobe PTE, ensure
> +	 * that we do not establish one upon merge. Otherwise, when mremap()
> +	 * moves page tables, it will orphan the newly created PTE.
> +	 */
> +	if (vma->vm_file)
> +		vmg.skip_vma_uprobe = true;
> +

Assuming we extend the VMA on the way (not merge), would we handle that 
properly?

Or is that not possible on this code path or already broken either way?

-- 
Cheers,

David / dhildenb


