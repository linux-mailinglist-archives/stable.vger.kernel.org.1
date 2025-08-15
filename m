Return-Path: <stable+bounces-169711-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0D6B27D11
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 11:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28813177D60
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 09:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDB8271469;
	Fri, 15 Aug 2025 09:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f+O2XvlA"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8A4271455;
	Fri, 15 Aug 2025 09:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755249822; cv=none; b=oRuRGF2TuJByAmj6Ur1ZtoCtzB99MZWxzQp5u9BnZUkcGVnCBLDDuh7t0mj5Hixo5glQ1nY1IRmvhACreIUQjwi4BkkmbV3WHIwks5PpnOVPuteaXrnRFdTBLY+qATPwMqRKStMXIC3pmHUps10Yy9QwnMP8fZ61zRiVQf7oGJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755249822; c=relaxed/simple;
	bh=jHqU7C3cB2Y7jqGzJ6MmHNkSMTZoaJzqNsLyTa1jD5Q=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=u2bFxkKQrGcVznYievHowyGq7meHpGblvln2dH6nkFRbElHngU8XA1LbMdGaSysfJcGBSI9qUuwz3HDUqWnOj1v2olLEBVAlY1wEvw9JEuBRkw+AWyqfVimMsxJ2UFTLDbY7VZWJ37rrID40FjL7yvLGboL3MC0cpqxp31atCR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f+O2XvlA; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755249821; x=1786785821;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jHqU7C3cB2Y7jqGzJ6MmHNkSMTZoaJzqNsLyTa1jD5Q=;
  b=f+O2XvlAYo+BWBg23zOzp2VQrwpyFWXyPq4kq47N39yGElhr9IvfDFTn
   SQjvgJrGPO8W6zIJVQbrKr7pUd2rRCgU/YHe3OPupx4XOGNA0EgS4vRPX
   4evC7t+kbG2AJe1mxxjH7tbb1MW0YbEuTC41lvv4t3rAwhmrcOy73lttX
   3zsI8kMfN8TYH75cVRojJl04Y0NJDfCf5/7EDWlNS76eweeLxlpXhOFDm
   tNO2wLTCkRZhqG3EmsecBQ+8xIvYagOyoSeJf8XqVtxjHgzCnXMcu+CxA
   erjn+Q8USjHOVfKaBPJLpCs/1wQJ2yyag/71JEpW0tK8jR/bqvUQsIHDi
   Q==;
X-CSE-ConnectionGUID: WOounE12QuWaWIGrPmrVjQ==
X-CSE-MsgGUID: Rza15byRRIOTHbCNQwM6bA==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="83006025"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="83006025"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 02:23:40 -0700
X-CSE-ConnectionGUID: jFtXsV/JRuOtvLDAMSV6Kw==
X-CSE-MsgGUID: WArP5uIUQUmuo0UOlMgv/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="171180582"
Received: from yongfeih-mobl5.ccr.corp.intel.com (HELO [10.124.241.96]) ([10.124.241.96])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 02:23:36 -0700
Message-ID: <4c956b03-d956-4f23-ad7e-f67286cf6b4a@linux.intel.com>
Date: Fri, 15 Aug 2025 17:23:33 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Ethan Zhao <etzhao1900@gmail.com>,
 Dave Hansen <dave.hansen@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Jann Horn <jannh@google.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Alistair Popple <apopple@nvidia.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Andy Lutomirski <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>,
 iommu@lists.linux.dev, security@kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v3 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
To: Jason Gunthorpe <jgg@nvidia.com>, Uladzislau Rezki <urezki@gmail.com>
References: <d646d434-f680-47a3-b6b9-26f4538c1209@intel.com>
 <20250806155223.GV184255@nvidia.com>
 <d02cb97a-7cea-4ad3-82b3-89754c5278ad@intel.com>
 <20250806160904.GX184255@nvidia.com>
 <62d21545-9e75-41e3-89a3-f21dda15bf16@intel.com>
 <4a8df0e8-bd5a-44e4-acce-46ba75594846@linux.intel.com>
 <4ce79c80-1fc8-4684-920a-c8d82c4c3dc8@intel.com>
 <b6defa2a-164e-4c2f-ac55-fef5b4a9ba0f@linux.intel.com>
 <2611981e-3678-4619-b2ab-d9daace5a68a@gmail.com> <aJm0znaAqBRWqOCT@pc636>
 <20250811125559.GS184255@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250811125559.GS184255@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/11/2025 8:55 PM, Jason Gunthorpe wrote:
> On Mon, Aug 11, 2025 at 11:15:58AM +0200, Uladzislau Rezki wrote:
> 
>> Agree, unless it is never considered as a hot path or something that can
>> be really contented. It looks like you can use just a per-cpu llist to drain
>> thinks.
> I think we already largely agreed this was not a true fast path, I
> don't think we need a per-cpu here.
> 
> But I would not make it extern unless there is a user?

Fixed. Thanks!

Thanks,
baolu

