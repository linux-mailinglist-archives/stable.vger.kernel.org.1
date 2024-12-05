Return-Path: <stable+bounces-98792-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7F99E54AD
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 12:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBE76166ECB
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 11:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3832144C2;
	Thu,  5 Dec 2024 11:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FnZnzleO"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AF21E0493
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 11:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733399758; cv=none; b=lGNa+mox9fl37L1S4saVAsaVZ4p0hf9r/xtJAWGjqahGxasQTanL64M2m7WWnxMWqTWwS179iA9SL6HnprvhIwbly7Uoi8HhnJTRAJZUn1qEWvZ2hDrzK22A4LfHVmqdAYzz35vHYa6YT8zvEFx25NSK0LyhKuDU6DslOQhfj9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733399758; c=relaxed/simple;
	bh=Wtjgy1C0ui0x8O4Mucja+7I8AmaiRMUHagXywMBkxXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PtTpAVsqpLD7oqqUDh7KIOweNtGsnwXiqy5xYlbXbl1qLqlUmjXC7jyzIJRkpqGWitHMJP+iLE9Mcg/fAi5VtIYydOqzHdO73dnvJYBmhWxDEGtboOrobesCTysTvtXOWqgagBBHMS5stkVePQgzk4+KYeb5STSrRny4m0+RMMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FnZnzleO; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733399756; x=1764935756;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Wtjgy1C0ui0x8O4Mucja+7I8AmaiRMUHagXywMBkxXc=;
  b=FnZnzleOthW8fc53P/GQJuoaYeSCpWrf+PlzZBxg9efeyouWUVGeRmFZ
   ao2LNGGQjnR5VRaspVIWIvcl+1Unp3GD5A5j/1M+EofRnCDyR+eHWnWr0
   M1iVGlEbCMDZiFUpS5vioV+lcxy5skUpCEpRISeNx/lzjXm0hHKPV/xLN
   JdilWbzjlyUnN4XLSiMTladxLc7pdiGIQQmXKnP/HKgE/WqEJIQSpcz0c
   e6+3ZMAm+YwM1SWjjKWZ2VwqQOA+t7KJOoxFzEbWhPBPvWZ4aIvVBYaDH
   s12BBmQQmwaNHAMxYAUK4XiBSfi88yoWTla9JbBuCqGsIoU2mLRi0Dp4c
   g==;
X-CSE-ConnectionGUID: THn+ddC+SVCTkdwwZ0RSoQ==
X-CSE-MsgGUID: yhe0erH/RgyHywqJop0OKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33039049"
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="33039049"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 03:55:56 -0800
X-CSE-ConnectionGUID: zjnYdqWUQSeKj5OCASk4SQ==
X-CSE-MsgGUID: AGPns/8JRsu5APSFCMfDJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="93943923"
Received: from oandoniu-mobl3.ger.corp.intel.com (HELO [10.245.244.50]) ([10.245.244.50])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 03:55:54 -0800
Message-ID: <ba6ee80b-967c-450a-b44c-bbb65754e569@intel.com>
Date: Thu, 5 Dec 2024 11:55:52 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/xe: Use non-interruptible wait when moving BO
 to system
To: Nirmoy Das <nirmoy.das@intel.com>, intel-xe@lists.freedesktop.org
Cc: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Lucas De Marchi <lucas.demarchi@intel.com>, stable@vger.kernel.org
References: <20241205120253.2015537-1-nirmoy.das@intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20241205120253.2015537-1-nirmoy.das@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05/12/2024 12:02, Nirmoy Das wrote:
> Ensure a non-interruptible wait is used when moving a bo to
> XE_PL_SYSTEM. This prevents dma_mappings from being removed prematurely
> while a GPU job is still in progress, even if the CPU receives a
> signal during the operation.
> 
> Fixes: 75521e8b56e8 ("drm/xe: Perform dma_map when moving system buffer objects to TT")
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
> Cc: <stable@vger.kernel.org> # v6.11+
> Suggested-by: Matthew Auld <matthew.auld@intel.com>
> Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>
Reviewed-by: Matthew Auld <matthew.auld@intel.com>


