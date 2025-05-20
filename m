Return-Path: <stable+bounces-145694-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF6FABE258
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 20:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 853C317E627
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 18:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C56B26FDB9;
	Tue, 20 May 2025 18:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jc43qRPW"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6E71BD9F0
	for <stable@vger.kernel.org>; Tue, 20 May 2025 18:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747764639; cv=none; b=T6NDUfiRSPHA73XcjRl/ESeiQDY/5hnBF4nXHcnHIdSyEY1vW3SfaoX9/SaS4Mldf/ugoWeCfdJdaIiqF/D1l3FzlxEcu+RI/b2KeNA/S6t5lwvwpdLVbf1tD8n2mp4ZOgEKHvMJRKXAe1L0MWP3RQBxe123ossIT8F64hC6yl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747764639; c=relaxed/simple;
	bh=aKDn3vLoSnjVSVa1sA31kz+IllVs/d1XPuCkY1Baebk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QCezFnTH3a/fA0QDD3Z2wchhtPadYLwKGSgRhnqyFwloj6bsglaKr6JyYkQJ/mF+yJxRhnzS6c07n1rhxypJb8NCLOQ/lBwQ1yFH3qsPBeKYEpDA405g4NVILXgnPKEyxw0L8STb2MTpRGn47V06F6pPVU27JKaznzQC2qRh5OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jc43qRPW; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747764638; x=1779300638;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=aKDn3vLoSnjVSVa1sA31kz+IllVs/d1XPuCkY1Baebk=;
  b=jc43qRPWxRRFKs0/pufT8cuFd7qqefoysxtmF+Q5iEK6Iw99J72Iac91
   VSEDqqwLXXuG9XaPUayX6m1ha0N5wthMSNxm5WyBAJNbVNbRPwUVo5024
   g9/4pU0cn+f5ICe+wW7rsMgI1QqjpOmDX7Gj4Pu+J88xv/2e0Nd9epnH5
   yzEWGE8RJg2C54dYLEUngoQ9nwbkWJO++5jarE2yDX+ACTatZaeWXgMES
   dVJZwXjmHYZnwaUQJRF1p9HSRbW6j0/ZGI0yQgk1OxBwqjUiDsTi/icHk
   vnZ0rrozp9q6NFDh56CQ4nUP9b1k+6TjGJWyXmpQwl+0SsMFaWT189Rj0
   Q==;
X-CSE-ConnectionGUID: fvZzwgcuTlCF1TKQ+U4R+Q==
X-CSE-MsgGUID: 0hi6iBqETimyOhlx6ckn4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="52341212"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="52341212"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 11:10:37 -0700
X-CSE-ConnectionGUID: DyzUohwXT561HAIJmKG+8A==
X-CSE-MsgGUID: yQrgOVUQRg2VXUKHDdSn2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="139648761"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.168])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 11:10:34 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Matthew Auld <matthew.auld@intel.com>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
Cc: Haoxiang Li <haoxiang_li2024@163.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/7] drm/i915/display: Add check for
 alloc_ordered_workqueue() and alloc_workqueue()
In-Reply-To: <8c1002cd-e5bf-4d1b-880c-5e7ac7d08f70@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <cover.1747397638.git.jani.nikula@intel.com>
 <20d3d096c6a4907636f8a1389b3b4dd753ca356e.1747397638.git.jani.nikula@intel.com>
 <8c1002cd-e5bf-4d1b-880c-5e7ac7d08f70@intel.com>
Date: Tue, 20 May 2025 21:10:32 +0300
Message-ID: <87ecwjtap3.fsf@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, 16 May 2025, Matthew Auld <matthew.auld@intel.com> wrote:
> On 16/05/2025 13:16, Jani Nikula wrote:
>> From: Haoxiang Li <haoxiang_li2024@163.com>
>> 
>> Add check for the return value of alloc_ordered_workqueue()
>> and alloc_workqueue(). Furthermore, if some allocations fail,
>> cleanup works are added to avoid potential memory leak problem.
>> 
>> Fixes: 40053823baad ("drm/i915/display: move modeset probe/remove functions to intel_display_driver.c")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
>> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
>
> Reviewed-by: Matthew Auld <matthew.auld@intel.com>

Thanks for the review, pushed the lot to drm-intel-next.

BR,
Jani.


-- 
Jani Nikula, Intel

