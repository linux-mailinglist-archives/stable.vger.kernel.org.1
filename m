Return-Path: <stable+bounces-119703-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C08A46589
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 16:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C8A1189FDB9
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 15:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1762253FC;
	Wed, 26 Feb 2025 15:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NsC51dH/"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FB521CA01
	for <stable@vger.kernel.org>; Wed, 26 Feb 2025 15:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740584574; cv=none; b=cU0X8enE8UJxHY3PmQNDxhbRAUIA+o+Omdzpr+rfjKfyP3yNX1BryBRqvYVIuDJJ5lJshxeMUkHNw9WVA3ZU+5y4ZSBx5iEHS1XQW3/kxFQo5uBCnjm1VQ/AjEMwucUY9FLwIrOfWG5vXQByQFPxYS2ZMbGPXAjt8YR5i/l0JxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740584574; c=relaxed/simple;
	bh=POU8QNJ9X/te7g6dCobHnwovQlMSESoeY5rZ+D0LycY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rKhgZA/WJpecZqZjNzXB2ZGgQ7+PCAMmRkoCqQNGMkzfMZPsqMGysL81e8pcuXxDTHlqTIYGn0HJnOrV1TauMJDL1878VxbvnlFZiozebmlACRcDCV6CbQigetvLsgY2cgHdjXf0WlpWULDuUvEjQc13HAE5SrG80/e0Fv5PvM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NsC51dH/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740584571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ct1usEIE5mCrQ0cI4Z5Fw7l48vyi/uJCgaNsySRiXLc=;
	b=NsC51dH/oZTQ0mvKHrTT/TyHEwY2M1qgPxPHrNlgX4gIBh+YIJZ53OFYFB1YKVtG6/p5r+
	F0EBt8FgAEH394pTHdi6vH/I5rZ3T7916NW7e62FaI++sJBTHboBOqtzvx8riwzch8+/NT
	DJEZgZ7A7jIrFp7J9b/Xz/3jmFPQ4as=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-DlnA1lDsNBSUBnCF7rywXQ-1; Wed, 26 Feb 2025 10:42:50 -0500
X-MC-Unique: DlnA1lDsNBSUBnCF7rywXQ-1
X-Mimecast-MFC-AGG-ID: DlnA1lDsNBSUBnCF7rywXQ_1740584569
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38f455a8fcaso4993393f8f.2
        for <stable@vger.kernel.org>; Wed, 26 Feb 2025 07:42:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740584569; x=1741189369;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ct1usEIE5mCrQ0cI4Z5Fw7l48vyi/uJCgaNsySRiXLc=;
        b=M3uXjNisMcB1kxFSiDNwEDwaPt6sws5Z6IaKY9fjCMlfTBv7gSVfzEaO7tIV3YPAxQ
         VfGyZcbDMYYqbAyovxxuVTklhYVEI2THhFeWUAErgVhmW2z6BsrPikFXVTKP6J8NIqGk
         p15X+GDNznXG1woAhfqXV8q0SRcEiAKjeGVKcISMfK9yOtyTGpo06mATzsqQJ+xRu+b8
         gn1a1BKQ+nHdDvgRTfRgT+otg3U06KwHAxtpp4egUCKyrcuessRM32VFZj6Fnu0A+Qms
         nPKoozQPlKBl27gdJh2rgE6ek1qKjtVZI6ibvcq+URpbX/kdR/FzlIGehVsMHuNxmhwG
         MkOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYMyUA3AiAviIWnPe7jXt8YQ2QhENfjnlHLqJyYc0dEjEFPG4F6DwuC9HLv0Vyqo3jfpxU2x0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzBabXV1iAc1lDGjCgN2azLNqJaDdSbUfJNBoQF9mzft29vI9R
	e/4oGFDUBT2jPh/AIj/IB7rz/LGGfMVYMgQG/Jd0DrOxNvMWOmfR7bbYe58WwZwEAVKwpbh6YIC
	Mp3To6N1zy3W5mJsaKP9Erau7Lg63hCL/pRBQ1FOUyXgBM5QMBdREYQ==
X-Gm-Gg: ASbGncv8wiYfVnC8Qx4oaI7pU0X5ANXdShABIjM+T6AXTzD/c5u4nEFBSL01QYAuYOJ
	znysXRPkv8REt/g3GElT9xCwFQLySvXOMjcpusc6IzDL6Wraw29xfMKNwZGy2VuRL5tVtgxCfMC
	UJun+Ua2NnGBWyTO10ZOUMzjV6pkY9iozMkUoW9waDVh2li1ax9kHrZNPYab59KT5ro7zhWfsAb
	Wz4MVGkvY6w+4lVlhZFQS//3UJFXRwCzFdzF+w5M2PGf8r3lahD8TF94sSEzOstOhkfXxbJqO8Y
	s5rk/tnomqS9k5+H4bDw39WrJXvd541GiIncx/PpfETKP/eUVEJSntg1u38K2LzM5hZhhOw86lu
	5ArrxJ0vOBaSn7evVn4VuhpGpTyEhXKXRf8anPSfF2w8=
X-Received: by 2002:a05:6000:18ad:b0:38f:2766:759f with SMTP id ffacd0b85a97d-390d4f8b640mr3418215f8f.41.1740584568845;
        Wed, 26 Feb 2025 07:42:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHc5f9sSVXsb/drkwgCC3GgZAvsBZeyAI1Ocx1CUODtH/g4ViRNzrq1fZFuXosu2Ho0LLxVFA==
X-Received: by 2002:a05:6000:18ad:b0:38f:2766:759f with SMTP id ffacd0b85a97d-390d4f8b640mr3418195f8f.41.1740584568465;
        Wed, 26 Feb 2025 07:42:48 -0800 (PST)
Received: from ?IPV6:2003:cb:c747:ff00:9d85:4afb:a7df:6c45? (p200300cbc747ff009d854afba7df6c45.dip0.t-ipconnect.de. [2003:cb:c747:ff00:9d85:4afb:a7df:6c45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd8fcca2sm6029159f8f.96.2025.02.26.07.42.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 07:42:48 -0800 (PST)
Message-ID: <121abab9-5090-486b-a3af-776a9cae04fb@redhat.com>
Date: Wed, 26 Feb 2025 16:42:46 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: fix finish_fault() handling for large folios
To: Matthew Wilcox <willy@infradead.org>, Brian Geffon <bgeffon@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>,
 Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Hugh Dickins
 <hughd@google.com>, Marek Maslanka <mmaslanka@google.com>
References: <20250226114815.758217-1-bgeffon@google.com>
 <Z78fT2H3BFVv50oI@casper.infradead.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z78fT2H3BFVv50oI@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.02.25 15:03, Matthew Wilcox wrote:
> On Wed, Feb 26, 2025 at 06:48:15AM -0500, Brian Geffon wrote:
>> When handling faults for anon shmem finish_fault() will attempt to install
>> ptes for the entire folio. Unfortunately if it encounters a single
>> non-pte_none entry in that range it will bail, even if the pte that
>> triggered the fault is still pte_none. When this situation happens the
>> fault will be retried endlessly never making forward progress.
>>
>> This patch fixes this behavior and if it detects that a pte in the range
>> is not pte_none it will fall back to setting just the pte for the
>> address that triggered the fault.
> 
> Surely there's a similar problem in do_anonymous_page()?

I recall we handle it in there correctly the last time I stared at it.

We check pte_none to decide which folio size we can allocate (including 
basing the decision on other factors like VMA etc), and after retaking 
the PTL, we recheck vmf_pte_changed / pte_range_none() to make sure 
there were no races.

-- 
Cheers,

David / dhildenb


