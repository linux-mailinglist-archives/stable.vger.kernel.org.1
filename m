Return-Path: <stable+bounces-166818-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DE9B1E191
	for <lists+stable@lfdr.de>; Fri,  8 Aug 2025 07:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9ABD1897B43
	for <lists+stable@lfdr.de>; Fri,  8 Aug 2025 05:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3A11DED42;
	Fri,  8 Aug 2025 05:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jbq910QD"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FBB2E36E2;
	Fri,  8 Aug 2025 05:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754629845; cv=none; b=jonWuhEbjEyv8caxP0IQ2eNDySHlwaZ/R0wfXpJ5+kXwmI9R3O5BiH0iz3O0qjD9Nn7rL2XijdipN7JHAuMXYSGct1jAcxe5Od6haK2YBoNUp09V76dNzgIdYzByhSwXT4HzRUKyuaWevQGmdmivVpG0wK7JxHJogSoSrI6nPRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754629845; c=relaxed/simple;
	bh=uNw/OYoOb46HSc9atpLRRzTZoGRK6zgt66qjXQVDJ5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kKpLdJSHlpLCmUIC7+xRCOw/GeQqfqQJUm1YJgFC08BVLw4DNABh59M5EM1ZxFfupOQ8ZEUTS77vezgPk25O5SRJj6TXRqNNuOs2+4cEo/m3VJDJk9c836eMQd0PDaB6I20l00nocGX5hphXmVWdd8zd3KlGZcy+Ypo38cKar4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jbq910QD; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754629844; x=1786165844;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uNw/OYoOb46HSc9atpLRRzTZoGRK6zgt66qjXQVDJ5o=;
  b=jbq910QDyKzh0J1Xs8+41ONTYjNAdjwdHTGmxUkLBAe2T7BwjR7wc0w7
   dNf/UL5xP5qOiu17GxzbsL0XE7sLHx85p/X797aHovxKarEIptTtcjgxr
   yOL+0IrneFPUcFWvdG8xyOLGMKg7rlDcCkCZBDpQFTNRwt10MXmx2bEoy
   bQ5NaP7moxPXO8tfairiXqBFLbbn7zlF95bms/6jJ4JBW0mF5PlRhpmOm
   Y10fVWJW6fpF/+/L/d/kkmoGQnjrmmd4aAFPYR5L1VfYWPrdiKvNKihA5
   KgOIaLNEVRMuPQuZqA8bj3JOlIvX3QbA3tC9Xu5CbN08JcrYV4UT4mVbZ
   A==;
X-CSE-ConnectionGUID: obBRA/1BSVuG7QraTpozqQ==
X-CSE-MsgGUID: 9iAk2sDoS9qzkp31VUgf8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="79531198"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="79531198"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 22:10:43 -0700
X-CSE-ConnectionGUID: rKySfyU8QPqHoTFM0Uo4ew==
X-CSE-MsgGUID: cjgfi0dCRTWDpnjcWBq+MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="169363203"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 22:10:39 -0700
Message-ID: <51ac107b-a1fa-4847-9f54-65194024462c@linux.intel.com>
Date: Fri, 8 Aug 2025 13:08:45 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
To: Jason Gunthorpe <jgg@nvidia.com>
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
 <20250807195154.GO184255@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250807195154.GO184255@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/8/25 03:51, Jason Gunthorpe wrote:
> On Thu, Aug 07, 2025 at 10:40:39PM +0800, Baolu Lu wrote:
>> +static void kernel_pte_work_func(struct work_struct *work)
>> +{
>> +	struct page *page, *next;
>> +
>> +	iommu_sva_invalidate_kva_range(0, TLB_FLUSH_ALL);
>> +
>> +	guard(spinlock)(&kernel_pte_work.lock);
>> +	list_for_each_entry_safe(page, next, &kernel_pte_work.list, lru) {
>> +		list_del_init(&page->lru);
> Please don't add new usages of lru, we are trying to get rid of this. 🙁
> 
> I think the memory should be struct ptdesc, use that..

Yes, sure.

Thanks,
baolu

