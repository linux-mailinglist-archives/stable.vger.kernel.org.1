Return-Path: <stable+bounces-26877-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E528729F4
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 23:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD040282D77
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 22:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A09712D1FD;
	Tue,  5 Mar 2024 22:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QyGx57qH"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7DB12BEAE
	for <stable@vger.kernel.org>; Tue,  5 Mar 2024 22:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709676564; cv=none; b=btCe6lu0QtJLWirKs3QKL/wF9WgSDX2H1bZs9HpX6YYx6LWzYkIT3ysxrtxhwIkm4zQvm+lGz8IK1c20lZ8MvBo0y8dgoCQNgouxu+QY1ltrAiLqisIZ4BGP5JKD9/2lgdvwOVGp6DimHwiG+trInA6MtFH067WiavCJ2JpHhPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709676564; c=relaxed/simple;
	bh=wwD1q/PxjwTPIg7ZV6cSFQ9+GziYmdbWXY9T6DjqDq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HOey4hgKBM38qipGAeG6VGEOGWdjnyDJvHKl/waOTQIhY1hVQrpOV0O6GBeJg2nCtIgZfZJw85qNeynuUrMdbh1auItuMhfRdeG/sYlIt+0Av6XG0qr1W/SBfck9sjb1ckyUHLjKzfePQ3NxZTb6ho4n+pzWckabolmqfEpW948=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QyGx57qH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709676562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=K4VpQlZR1zxkgk8t2TVWrM5Ais8tnCZJx4xwBYy3Ypk=;
	b=QyGx57qHUPOWnPYcF3Jo9HzbrKHNegO4Gwyjwa9GZxBwmjScgyIIGymMlvbcscOfUqAJdy
	piCv0ke+U6TmG1NRukoRH9hkhHnNHKOtIPcaXSJvhfE5f9EZVt7Gk3UArdpmtuxDCvbsVg
	1wD0laYxa67iwwAOqFFTLJPDStcGIM8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-dndjHbmTMEe0UAYHGqkHjQ-1; Tue, 05 Mar 2024 17:09:20 -0500
X-MC-Unique: dndjHbmTMEe0UAYHGqkHjQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-412edc9d70aso6648665e9.0
        for <stable@vger.kernel.org>; Tue, 05 Mar 2024 14:09:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709676559; x=1710281359;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4VpQlZR1zxkgk8t2TVWrM5Ais8tnCZJx4xwBYy3Ypk=;
        b=Td2rLiTInuAmRQQ1yS7Y+p9wlJjWrg1WiFUHtlTER31ouzOWFsdVFTfnMRiiux4f1v
         X3EfT5snqPqjC4Pphg9maGALHjPJVqjEYvymwDXTDM2hMIW3Fx+lSav9roZBic1EeRex
         atd9m9YeaTnSp2AboaHnh1Zv6vzCsdDdmISQpZhJv5AQZJh5pRsZA451Qu0L+seoAel3
         FfdKrcc7X9GDWLHaEXL9ZJbqBEmmW2eIyYfwuJHIyyrQpU6iTcS1lXzsZYHjFw8yQGhG
         A+qMABgMcJm6EtEsVFMd4KapEq3QzgL+jTuzKiNiGQNTcWuCi5rfAQTAS6ou1KiURx3H
         5hvw==
X-Gm-Message-State: AOJu0Yz0wW0pEQVDOgcGmrGGihts6BHdoj9fweMZcH+ttiEsRPlCvVkQ
	oFm9MN9K3h7Og7Y0gfK0Lt8hvXXUR+0S9CCRcFoUWishuOhYIL2FVAMf1oNUMe7agwVaQmdrKIr
	qP2kl5fxaSNDZqb1eme6MUc1DpmLndhrdt+0OPXOFtcS2AAkLOUTXbA==
X-Received: by 2002:a05:600c:1550:b0:412:f005:4b1c with SMTP id f16-20020a05600c155000b00412f0054b1cmr1293673wmg.40.1709676559389;
        Tue, 05 Mar 2024 14:09:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGh61YUciCaitZa6/SS9zakjpQP42It7gFr3OVnoKhvqcmmW8mFu1+B4ea/evt4Orq0Gd7n7A==
X-Received: by 2002:a05:600c:1550:b0:412:f005:4b1c with SMTP id f16-20020a05600c155000b00412f0054b1cmr1293661wmg.40.1709676559056;
        Tue, 05 Mar 2024 14:09:19 -0800 (PST)
Received: from ?IPV6:2003:cb:c73c:8100:600:a1e5:da94:a13a? (p200300cbc73c81000600a1e5da94a13a.dip0.t-ipconnect.de. [2003:cb:c73c:8100:600:a1e5:da94:a13a])
        by smtp.gmail.com with ESMTPSA id n10-20020a05600c4f8a00b0040fd1629443sm19324148wmq.18.2024.03.05.14.09.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 14:09:18 -0800 (PST)
Message-ID: <0910e8f0-5490-4d08-ac64-da4077a1e703@redhat.com>
Date: Tue, 5 Mar 2024 23:09:17 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH STABLE v6.1.y] mm/migrate: set swap entry values of THP
 tail pages properly.
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>, Zi Yan <ziy@nvidia.com>
Cc: stable@vger.kernel.org, linux-mm@kvack.org,
 Charan Teja Kalla <quic_charante@quicinc.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>, Huang Ying
 <ying.huang@intel.com>, Naoya Horiguchi <naoya.horiguchi@linux.dev>
References: <20240305161313.90954-1-zi.yan@sent.com>
 <2024030506-quotable-kerosene-6820@gregkh>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <2024030506-quotable-kerosene-6820@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.03.24 23:04, Greg KH wrote:
> On Tue, Mar 05, 2024 at 11:13:13AM -0500, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> The tail pages in a THP can have swap entry information stored in their
>> private field. When migrating to a new page, all tail pages of the new
>> page need to update ->private to avoid future data corruption.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>   mm/migrate.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> What is the git commit id of this change in Linus's tree?

Unfortunately, we had to do stable-only versions, because the backport
of the "accidental" fix that removes the per-subpage "private" 
information would be non-trivial, especially for pre-folio-converison times.

The accidental fix is

07e09c483cbef2a252f75d95670755a0607288f5

-- 
Cheers,

David / dhildenb


