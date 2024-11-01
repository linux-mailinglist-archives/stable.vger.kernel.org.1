Return-Path: <stable+bounces-89490-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CB29B91E2
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 14:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 448A51F22891
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 13:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147DE174EFC;
	Fri,  1 Nov 2024 13:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ePTchEVU"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E564594D
	for <stable@vger.kernel.org>; Fri,  1 Nov 2024 13:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730467267; cv=none; b=SQJgU4UzcXLVE5FmL8uIO/0VrVz8RDYWVD8JxeBPKUGdtIkl25adSb+jsfygO1UEWgCDr6hJLYAr4w0YEikve0IPhk9YrLwu4ze76ef2hkePp5vEN2m/Qgdh9HbeWP7uRwNOTCei6qqE3u/fB3rFNCbp8q3GKCVXfexuahgxgY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730467267; c=relaxed/simple;
	bh=1ASEgG2xQ413CWrh5QFSHQlB8KX65S3r1j0stYmpXBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lK/bb4AOwZhdKGptUbUXw1WQP734lyw/RJHO+5MrLUsoWGMp89TzpUuHaNVYLYtbvFWm56V6o8wmUA5Lkivc2ihGa2dSYCwp0h7T0ZVmyzchd5GTIwreQRvj/jDZUgo9FqcyeLV90Aa2PkmdIIC2urtuKxQIm/962qN0jwpyiHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ePTchEVU; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730467266; x=1762003266;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1ASEgG2xQ413CWrh5QFSHQlB8KX65S3r1j0stYmpXBI=;
  b=ePTchEVUpvw0trgrx5/R9KsZ0GP8udsZLh5/ATHbnUYX5PufdGpgD/Ap
   D27piUjTctfq+d4b5WP3X63o2SOJ03W7Qlgc1LWV7I3zKRPdTgIDm7cRh
   Sw9w+wpdCzE2PhmkcWSCq5iHKA5Izmj0KVhVUdrItrCnWd/yhY8jL1szI
   bGSf1gE9nkwbDQDOlygnUFVTtE880+idBEdkm+7m0Il72r6qv0s4MQpPe
   Y56nygWOgw7xDeMF/xnF4z0mLNRFW+WVXzziWjCJdKFjhB5fV7YW+UJGo
   rirJ3FyBcxShv2t+CaGukG0OKnL1TuGKddklCNsOQiBfFb88ZXIGxHJC7
   Q==;
X-CSE-ConnectionGUID: qq7dAU25T+Wx0QS/vqkSFQ==
X-CSE-MsgGUID: elIsfu58SYqfznIeNzT+7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30395937"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30395937"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 06:21:05 -0700
X-CSE-ConnectionGUID: hO8Og36ESzibQlpjPjrpkA==
X-CSE-MsgGUID: 87eRw875RuWEOe4kwyraCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="88086775"
Received: from oandoniu-mobl3.ger.corp.intel.com (HELO [10.245.244.34]) ([10.245.244.34])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 06:21:04 -0700
Message-ID: <9d9c47de-c1ab-4c5e-b4ac-9eeff730e4fb@intel.com>
Date: Fri, 1 Nov 2024 13:21:01 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] drm/xe/ufence: Flush xe ordered_wq in case of
 ufence timeout
To: Nirmoy Das <nirmoy.das@intel.com>, intel-xe@lists.freedesktop.org
Cc: Badal Nilawar <badal.nilawar@intel.com>,
 John Harrison <John.C.Harrison@Intel.com>,
 Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
 Lucas De Marchi <lucas.demarchi@intel.com>, stable@vger.kernel.org,
 Matthew Brost <matthew.brost@intel.com>
References: <20241029120117.449694-1-nirmoy.das@intel.com>
 <20241029120117.449694-2-nirmoy.das@intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20241029120117.449694-2-nirmoy.das@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/10/2024 12:01, Nirmoy Das wrote:
> Flush xe ordered_wq in case of ufence timeout which is observed
> on LNL and that points to recent scheduling issue with E-cores.
> 
> This is similar to the recent fix:
> commit e51527233804 ("drm/xe/guc/ct: Flush g2h worker in case of g2h
> response timeout") and should be removed once there is a E-core
> scheduling fix for LNL.
> 
> v2: Add platform check(Himal)
>      s/__flush_workqueue/flush_workqueue(Jani)
> v3: Remove gfx platform check as the issue related to cpu
>      platform(John)
> v4: Use the Common macro(John) and print when the flush resolves
>      timeout(Matt B)
> 
> Cc: Badal Nilawar <badal.nilawar@intel.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: John Harrison <John.C.Harrison@Intel.com>
> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
> Cc: <stable@vger.kernel.org> # v6.11+
> Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/2754
> Suggested-by: Matthew Brost <matthew.brost@intel.com>
> Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>
Reviewed-by: Matthew Auld <matthew.auld@intel.com>


