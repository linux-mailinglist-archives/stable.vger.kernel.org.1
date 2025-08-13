Return-Path: <stable+bounces-169309-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA565B23EE4
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 05:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96A8C1A26D61
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 03:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98512690D9;
	Wed, 13 Aug 2025 03:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsgkdlnC"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F2F22338;
	Wed, 13 Aug 2025 03:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755055090; cv=none; b=TJK5NTaPfdrE7iuIDXPvLUDjNqE9bni4MFICuC2+AtdjTqLsYsFlbCEGaqB7/+2WwHDyhgci5kPaFZ/YXloG1wXpfXDf/uQy7cmXhseSh/t3VgRQ0NjS+j9Ai82qCWv4Kr9ofHzKIflxL7JoAY2AiVgLZqgQp/bQWgbxtlXt9pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755055090; c=relaxed/simple;
	bh=ep7lK0F99GEgxWEt/eIh0MesHhIBI5SzHWocRe7DRX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MDEXtq0aKSSMDPqVYiL0pQlILACbVzy/RZv/m1BYuKBKnlORL9TJ0GfCeqb9inzFEdZUxCb3/yon2pJgpIrzrhhFKi6giIaXGkpolcB3xn11DYu/jceMeriiD9xm45DXB+mgks1ydC5Vzs0C0K8Y7xyEIpGt+8/M7p5gWMrjTL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bsgkdlnC; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-3b78127c5d1so3963233f8f.3;
        Tue, 12 Aug 2025 20:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755055087; x=1755659887; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7XCYFs1Ir8nk3KK4TBgEVy6vlzhXtWwOkAnDASfP0Oo=;
        b=bsgkdlnCCYgKfetqx3bAnULUnWFfjqcNVsOkOUB3tRWseQgj4MVG8ifcc1c445Vlzf
         vulqfJVyrDRfeewn4lcOgW0MOWGDSzsYAYrsWS5WOg1HWz6nl2d4RM4MdQPm9bj0szA+
         gMp8tmGEGYxOzqxXiErmawEj+LDaT4Qgam/296NBDCCVbigEG0mQCAZ3R10oMTt5PwTX
         CkfjcCRfvYvpqYyWPaXocEiOtM21rU3bPkuX6GH/OHCnw56NPd5EQ9emn7xbl/w7l4Qx
         q4jqXo2J0d2zfOpeq4f4nlsBJ6Dl8H+Uxo+pHM4wJNWpB20DjS/IZEV5+C0PBO4Mf27e
         Iwqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755055087; x=1755659887;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7XCYFs1Ir8nk3KK4TBgEVy6vlzhXtWwOkAnDASfP0Oo=;
        b=d/JJpt/EW9hR3ggwIuKMkbXw4CczeI0w2UerYEtMvNYEbPr+K4Bk+aW4gFRONAzgQ6
         eCarZaYSHqu+VxMdMBHyHVWhyXO+qo5Y6pm3PvxGKTdt4hSfGgzn1qSrPk9VjJFNUYKp
         AHBa5NmR0cOZqZt3l63eXTxMIgm1jr1w+iXlL3g1VBx+hhjGay4g1FEGhtHIM6y8MHnp
         /L6DYtOARKVWf5U6FWIEYG1SaMsFHxCS/dN8XW6MMtu6hofTZoJs2MjDDJvjkvgqB1yf
         g6kFK/Ct9XRHW4+SNhRgxnI1xMUUd62pp8sfUjmkFmE/x7eYfNzEkV2Yvw5eG6fz3yQn
         1g9w==
X-Forwarded-Encrypted: i=1; AJvYcCV5PkOOdqZjxBVR5oqY35wVHgkh5ayyXxE3KlKiYK5lPTuUbHgjvkWQwyiYM7RvHj8N6Yojh5dc@vger.kernel.org, AJvYcCXb4zD/Yp5EatJOzram4aYYbtsNCzQ3rfq8x+TCZOnOm3kDSuapbph/Xxn5XKDl6JJsnFeXC37phMYQJZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS/oerijfcyr4tJwKrZMNy1Jq1NMXSI9XZndRYVICbGz0onz61
	I4ztwNakrGHTQqtIO8fEE+Tf7NtP+ZaRTjcLMKdcxJ8zrsb+RAkTIERr
X-Gm-Gg: ASbGncuIKyVcAwCUe6PQCW+BcWgEHnIwfklmBUvRwCg2NuleaTbCS80hcQLXNT/LOc4
	CY4Vdm6XcVx6O8GolxEHyWbnT7eYvDFqRjs6+Tn6Ohs+OpsHANWCQOZZqaBSIdYg27j1PjkpYMT
	GPQRdJTZd5QtBKuMUyyhRcvUU1dQycd12xEfzfPZDJlY0Y5SxClTGe4hp4K+v6AsyD7M1DVHIHx
	ICPNoqNydn0no2BymO4i3n02B3oA48xNFkvrwwbbE1LNNyyrDNxrTGyymxvmWvgHhQzs69/9Fvg
	qSu3Xr53z4sC/V4Krgo/EAJehnpCn6d/NfF4bowdNlGe0PptY7iW6r/tFAVtjWxziJLjaMS+LYr
	Sj6xmhh3NXwX5eed/JxiMPu58VgccaWO9EeX3VDBHeDA1ucgVeSE3bYmPzpta3u36y1tzkxkRwI
	ult3wiJDGS2DJi1KTUVis4
X-Google-Smtp-Source: AGHT+IFK1DMyzcLy23ebyF7+rQb4+XbWoa8waTcmvm2yM0sRpo4qdIIwHXD6dXoIgYNTEroCcmTFnw==
X-Received: by 2002:a05:6000:2311:b0:3b7:8268:8335 with SMTP id ffacd0b85a97d-3b917eb8171mr822011f8f.42.1755055087110;
        Tue, 12 Aug 2025 20:18:07 -0700 (PDT)
Received: from [26.26.26.1] (95.112.207.35.bc.googleusercontent.com. [35.207.112.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8e04c7407sm36750215f8f.13.2025.08.12.20.18.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 20:18:05 -0700 (PDT)
Message-ID: <33b39588-5a39-4474-ac17-bde923803600@gmail.com>
Date: Wed, 13 Aug 2025 11:17:57 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
To: Jason Gunthorpe <jgg@nvidia.com>, Baolu Lu <baolu.lu@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Jann Horn <jannh@google.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Alistair Popple <apopple@nvidia.com>,
 Peter Zijlstra <peterz@infradead.org>, Uladzislau Rezki <urezki@gmail.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Andy Lutomirski <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>,
 iommu@lists.linux.dev, security@kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250806052505.3113108-1-baolu.lu@linux.intel.com>
 <d646d434-f680-47a3-b6b9-26f4538c1209@intel.com>
 <20250806155223.GV184255@nvidia.com>
 <d02cb97a-7cea-4ad3-82b3-89754c5278ad@intel.com>
 <20250806160904.GX184255@nvidia.com>
 <62d21545-9e75-41e3-89a3-f21dda15bf16@intel.com>
 <4a8df0e8-bd5a-44e4-acce-46ba75594846@linux.intel.com>
 <4ce79c80-1fc8-4684-920a-c8d82c4c3dc8@intel.com>
 <b6defa2a-164e-4c2f-ac55-fef5b4a9ba0f@linux.intel.com>
 <20250811125753.GT184255@nvidia.com>
Content-Language: en-US
From: Ethan Zhao <etzhao1900@gmail.com>
In-Reply-To: <20250811125753.GT184255@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/11/2025 8:57 PM, Jason Gunthorpe wrote:
> On Fri, Aug 08, 2025 at 01:15:12PM +0800, Baolu Lu wrote:
>> +static void kernel_pte_work_func(struct work_struct *work)
>> +{
>> +	struct ptdesc *ptdesc, *next;
>> +
>> +	iommu_sva_invalidate_kva_range(0, TLB_FLUSH_ALL);
>> +
>> +	guard(spinlock)(&kernel_pte_work.lock);
>> +	list_for_each_entry_safe(ptdesc, next, &kernel_pte_work.list, pt_list) {
>> +		list_del_init(&ptdesc->pt_list);
>> +		pagetable_dtor_free(ptdesc);
>> +	}
> 
> Do a list_move from kernel_pte_work.list to an on-stack list head and
> then immediately release the lock. No reason to hold the spinock while
> doing frees, also no reason to do list_del_init, that memory probably
> gets zerod in pagetable_dtor_free() 
Yep，using guard(spinlock)() for scope-bound lock management sacrifices
fine-grained control over the protected area. If offers convenience at
the cost of precision.

Out of my bias, calling it sluggard(spinlock)() might be proper.

Thanks，
Ethan
> 
> Jason
> 


