Return-Path: <stable+bounces-87693-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C75D9A9E0E
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 11:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCC3928610F
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 09:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C681547E9;
	Tue, 22 Oct 2024 09:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Me7CmuUw"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3A2146019
	for <stable@vger.kernel.org>; Tue, 22 Oct 2024 09:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588392; cv=none; b=E8tx64G9hE59lT41KmAAYO0zoDD2ESDEiLt3z+cGpULfiNPbS2/Z3TwvGgCpOoMw+TeYzXCHT6keDw04TxVsYzxYSgHz+JEioFm7XEFOdfKWLAC86tDzwxguPWyiAocwxoAjFafQcwSk63zP4fYUTZtm6rvcOC7fhwwdawN22pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588392; c=relaxed/simple;
	bh=6oNaVHcJDbst9m3PA7oDHNZWjE6JPmuzeWgsdJI9gxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fD129xRgu9Ygxmy7he8IvumT4C/Q0nJO5E9o4u+ZcDkCoEI2/fVtleu3JHhbZpC/AXC7DHyZGsgV4a7Q1Y9ZofrpCTpoHVsMsbDg6BdgqITzbC6rOqLJYcmlBvYe5qZpBZLWVNC1HBHJBm3P2dgDEF0cFzeUkxvReOSupNdhftI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Me7CmuUw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729588389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qCewY910KkBbHnS5Rfdh9ZEgTE4a6d0a34lC2Qi4N3k=;
	b=Me7CmuUwnxkdOtuZGbq0f9YCsMXPWT6mZfoVFJtOVULcEAKZY90404UFRRSg/UYrwLZru4
	8lJXQt812If9p+TfhxFna1rmLGXOks9aIoGfe09x9cRjG1Is0YBpxeSlxZWrXRER4G03yU
	3q/0jLC8HoN82sl8h1+kBDhWsA/0028=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-DZpsGWnIN2yy8GD3Ey9Prw-1; Tue, 22 Oct 2024 05:13:08 -0400
X-MC-Unique: DZpsGWnIN2yy8GD3Ey9Prw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4315af466d9so37391625e9.3
        for <stable@vger.kernel.org>; Tue, 22 Oct 2024 02:13:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729588387; x=1730193187;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qCewY910KkBbHnS5Rfdh9ZEgTE4a6d0a34lC2Qi4N3k=;
        b=a31iViWZsIT0p5jppl6sQC3XPy+cesgiMy7x+Um9DOvpk0vLC3OJ79ob8U3ZkXY24g
         qcPDbrzFgarEPvXeWZpjRGlzHOj4fQLOEqN65T+9iBlDfdGnW+5On5g18XNz31ipcOfj
         4R93kcmRKeXLSWKqagWyBx+NScws3NwQjgnxNceaoXiRvp/pBoHjr9fgVaDnIt5xosBI
         +pbYn+jBSyHJnrN/2j7lE5OcOCFBFPpL1FYE6U1FNtroX5uGdQF/AlElfq7AswMBVmMD
         h+HWTZo+AZfBrR+eoho3LWmt2hl0KSgVomOiioMpJEHMWltJy2h7eAkTNBtXPc4s/26Z
         CLBg==
X-Gm-Message-State: AOJu0Yyum/DX8GHaQpDtHyGrGnsmB27OhJvE9wcdUgR+Yv357nmg/KKE
	/R4vUi8Yt6gtOGMzr3aRVpW1QDV718ExKAwi+brwnlF6hXgGSw69laVz+oBaYkOvfX07M1ge+/N
	I11P3IgvMWQa5VqDvNOvxuAlu7A5/aMGzTVQe1E5J7Bkc1vwVCcrgNsmqcqvvUtvifzlVuY4QWS
	zetQvjEWbFJ7Q8V40zfrEr2Uz/mtwdMx5DxKSu
X-Received: by 2002:a05:600c:354e:b0:42b:a7c7:5667 with SMTP id 5b1f17b1804b1-431616a3a15mr112410805e9.25.1729588386722;
        Tue, 22 Oct 2024 02:13:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFbqABdrlmsLwuviowOelH8LCbcHXTehVildp/mfojVAvgSRGtpowr7L3eTzcpP8oyXs94RA==
X-Received: by 2002:a05:600c:354e:b0:42b:a7c7:5667 with SMTP id 5b1f17b1804b1-431616a3a15mr112410365e9.25.1729588386222;
        Tue, 22 Oct 2024 02:13:06 -0700 (PDT)
Received: from [192.168.3.141] (p4ff23bb3.dip0.t-ipconnect.de. [79.242.59.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4317dde7b70sm11439995e9.1.2024.10.22.02.13.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 02:13:05 -0700 (PDT)
Message-ID: <a5f10198-836e-44b6-a148-af69347dc049@redhat.com>
Date: Tue, 22 Oct 2024 11:13:04 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1.y] mm: huge_memory: add vma_thp_disabled() and
 thp_disabled_by_hw()
To: stable@vger.kernel.org
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>, Leo Fu <bfu@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Hugh Dickins <hughd@google.com>,
 Janosch Frank <frankja@linux.ibm.com>, Matthew Wilcox <willy@infradead.org>
References: <2024101837-mammogram-headsman-2dec@gregkh>
 <20241022090018.4073306-1-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241022090018.4073306-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.10.24 11:00, David Hildenbrand wrote:
> From: Kefeng Wang <wangkefeng.wang@huawei.com>
> 
> Patch series "mm: don't install PMD mappings when THPs are disabled by the
> hw/process/vma".
> 
> During testing, it was found that we can get PMD mappings in processes
> where THP (and more precisely, PMD mappings) are supposed to be disabled.
> While it works as expected for anon+shmem, the pagecache is the
> problematic bit.
> 
> For s390 KVM this currently means that a VM backed by a file located on
> filesystem with large folio support can crash when KVM tries accessing the
> problematic page, because the readahead logic might decide to use a
> PMD-sized THP and faulting it into the page tables will install a PMD
> mapping, something that s390 KVM cannot tolerate.
> 
> This might also be a problem with HW that does not support PMD mappings,
> but I did not try reproducing it.
> 
> Fix it by respecting the ways to disable THPs when deciding whether we can
> install a PMD mapping.  khugepaged should already be taking care of not
> collapsing if THPs are effectively disabled for the hw/process/vma.
> 
> This patch (of 2):
> 
> Add vma_thp_disabled() and thp_disabled_by_hw() helpers to be shared by
> shmem_allowable_huge_orders() and __thp_vma_allowable_orders().
> 
> [david@redhat.com: rename to vma_thp_disabled(), split out thp_disabled_by_hw() ]
> Link: https://lkml.kernel.org/r/20241011102445.934409-2-david@redhat.com
> Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> Reported-by: Leo Fu <bfu@redhat.com>
> Tested-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Boqiao Fu <bfu@redhat.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Janosch Frank <frankja@linux.ibm.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit 963756aac1f011d904ddd9548ae82286d3a91f96)
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
> 
> Only contextual differences in shmem_allowable_huge_orders(). Note that
> this patch is required to backport the fix
> 2b0f922323ccfa76219bcaacd35cd50aeaa13592, which can be cleanly cherry
> picked on top.

ARG my backporting skills (or rather patch sending skills) are not 
strong today. This is the 6.11.y variant. Please ignore this mail ... :(

-- 
Cheers,

David / dhildenb


