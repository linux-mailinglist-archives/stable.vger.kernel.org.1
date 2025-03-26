Return-Path: <stable+bounces-126708-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3FCA716DF
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 13:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ECC5188A0BF
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 12:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31E218DB03;
	Wed, 26 Mar 2025 12:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XphyBOtT"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A361E51D
	for <stable@vger.kernel.org>; Wed, 26 Mar 2025 12:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742993197; cv=none; b=GRKjStXqkc7It0TimVNswRyGaW2jQUPzTvpkkaVwz30PeXhD20oyCJsY0m25CfQxcOyLvrqK5fvxPTIGjliCylKPoPaAPtSINkJ7ID3n5k1ptTZIFUZWdtd6n9clKTn67A568cfsJEcdYAgOxUxCgcLK7GBptSYcbzJOoIqRNEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742993197; c=relaxed/simple;
	bh=5wK7E07iRV1w8nsbK4WWm7B+/2pX2jiV7X5MntOmbPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C9HHYoFn5ELXbiJGvcCwj3i7FDnGJozLECCYWjsHsCX29uj1n9V1FXLzWwCulRiq/dS4+LA2BzEvzCN7Cz/k2WUKoChuzagE3V8E9nFf+UXwIn4fdaLB9WoF/umMdXimxpSoPwMKErB2XEinwx+VyX1diqIV2RF5KPoyee3G2b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XphyBOtT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742993194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=s77PIgFRT3AtQ1+X+1bT16Z9Vl7GBWDfTOwmyThXt4c=;
	b=XphyBOtTj5NNYPtkyXwSOqk0Uq+wlfGVaneH3OoS/k002Hgj4rIcSP5Cj8RXGGVKHe6jL1
	Sagf9omz87wnjIMFHbBzEyOkWpI2jkM9rHG/M4RDxLMy1hmADQIcT2UjrKe99n3WCs9BfR
	yU+Qdy66FCJ40tOHOQer87/+b3A2Z/A=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-tfClQAx2Nh2ynlGS2UNGjg-1; Wed, 26 Mar 2025 08:46:33 -0400
X-MC-Unique: tfClQAx2Nh2ynlGS2UNGjg-1
X-Mimecast-MFC-AGG-ID: tfClQAx2Nh2ynlGS2UNGjg_1742993193
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c5bb68b386so1707727285a.3
        for <stable@vger.kernel.org>; Wed, 26 Mar 2025 05:46:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742993193; x=1743597993;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s77PIgFRT3AtQ1+X+1bT16Z9Vl7GBWDfTOwmyThXt4c=;
        b=msgOtiaFcMTmUj4eZpdqSDzgFS/HnZXg5F8ikZn0HNhEq/eZPQf48atl//U3KaqWYD
         Q2m+/G2NQ0MIiClZVp37tzmq9YKjMJzb+Dsxbehzr36mbjrD5gGqXCDJuJi3VNNbX7lg
         jlfPYz2lAJGsCGN3QdnQZRF1NbLREhJahQ41wotYVi/xYlMxFC5u/dReWfZAu/ugEoyf
         yjW5I1iowkqP9lBGQIL6J/5SlTMwhaysei+WLdNgyFxUhdSGfUF5IJkEOCRu6/Hsa2Hi
         9N8lPDp+WASZSS6bydlgBJfFY7wiNiSfbd8eAdhrlzg4I0f5+R/O6MsRGduMQLhKFCSv
         S+0g==
X-Forwarded-Encrypted: i=1; AJvYcCVw9nbtWRaCuk8GXcyO2/zw1uHDDtRBv6m+ZhowrU5JYVZ4y+jenZdfsaL3RQ1SrOSi6dNqCnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHksiNkUZFN6/n0daCcSxPqD8wrjlrbYSkXA2QnrdNwBQRpFsr
	bq/yVzCFkzmK8SQerzlRg4OSbLPvUAy70otO2T0pCYjqrbJz7JjDgU0yvnsON3h1YmXRgfQxK9M
	T1Ga7oV4pmPeb5fJtTalzkJ/XO7n+LnxpUWZNl0u6ybRjExscrWCNaA==
X-Gm-Gg: ASbGncvnenUpncw2+22R7kw1QA+w0iVnFdhXe8qFj8D/NfqNsjo0YGQEao54CBVIT5Q
	xDzvdRLdMGStx7lsVOsx7UQ4PgPjy8lPeiDgbnuqQIJdc8YID1OevRUIW6FdX5izR8AlU1/mlep
	CKNVpUdlxeGgw7nmPwG81IkZRm8YUIIV4SUX2xydoXJL8SAtdd1nga7Xcj25Aqb4KJGQHyMF6DE
	ZW0oECYNddR29hTbOt9pmPcj0ycuCp8/tkwSacwzsW7R0+zcmodwDz9MxwzPsyJ+nxhK7ovrNsE
	W1iAVJzyvfZX
X-Received: by 2002:a05:622a:8c8:b0:476:a713:f792 with SMTP id d75a77b69052e-4771de76b37mr393709851cf.49.1742993193084;
        Wed, 26 Mar 2025 05:46:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzkqpqjEwPUTEAvDnO0P+5L0dcnCmpDb5RpBr8CRpdw+f+sjDwy6OQgYyXF4UGIgJUyGBQKQ==
X-Received: by 2002:a05:622a:8c8:b0:476:a713:f792 with SMTP id d75a77b69052e-4771de76b37mr393709461cf.49.1742993192666;
        Wed, 26 Mar 2025 05:46:32 -0700 (PDT)
Received: from [172.20.3.205] ([99.209.85.25])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4771d51fec4sm71024641cf.52.2025.03.26.05.46.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 05:46:32 -0700 (PDT)
Message-ID: <91ac638d-b2d6-4683-ab29-fb647f58af63@redhat.com>
Date: Wed, 26 Mar 2025 13:46:31 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4] mm/gup: Clear the LRU flag of a page before adding to
 LRU batch
To: Jinjiang Tu <tujinjiang@huawei.com>, yangge1116@126.com,
 akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 21cnbao@gmail.com, baolin.wang@linux.alibaba.com,
 aneesh.kumar@linux.ibm.com, liuzixing@hygon.cn,
 Kefeng Wang <wangkefeng.wang@huawei.com>
References: <1720075944-27201-1-git-send-email-yangge1116@126.com>
 <4119c1d0-5010-b2e7-3f1c-edd37f16f1f2@huawei.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <4119c1d0-5010-b2e7-3f1c-edd37f16f1f2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.03.25 13:42, Jinjiang Tu wrote:
> Hi,
> 

Hi!

> We notiched a 12.3% performance regression for LibMicro pwrite testcase due to
> commit 33dfe9204f29 ("mm/gup: clear the LRU flag of a page before adding to LRU batch").
> 
> The testcase is executed as follows, and the file is tmpfs file.
>      pwrite -E -C 200 -L -S -W -N "pwrite_t1k" -s 1k -I 500 -f $TFILE

Do we know how much that reflects real workloads? (IOW, how much should 
we care)

> 
> this testcase writes 1KB (only one page) to the tmpfs and repeats this step for many times. The Flame
> graph shows the performance regression comes from folio_mark_accessed() and workingset_activation().
> 
> folio_mark_accessed() is called for the same page for many times. Before this patch, each call will
> add the page to cpu_fbatches.activate. When the fbatch is full, the fbatch is drained and the page
> is promoted to active list. And then, folio_mark_accessed() does nothing in later calls.
> 
> But after this patch, the folio clear lru flags after it is added to cpu_fbatches.activate. After then,
> folio_mark_accessed will never call folio_activate() again due to the page is without lru flag, and
> the fbatch will not be full and the folio will not be marked active, later folio_mark_accessed()
> calls will always call workingset_activation(), leading to performance regression.

Would there be a good place to drain the LRU to effectively get that 
processed? (we can always try draining if the LRU flag is not set)


-- 
Cheers,

David / dhildenb


