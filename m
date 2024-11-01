Return-Path: <stable+bounces-89489-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 902419B91D9
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 14:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1ADA1C24D45
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 13:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D061381B9;
	Fri,  1 Nov 2024 13:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UDlXDrrT"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0106C19BBC
	for <stable@vger.kernel.org>; Fri,  1 Nov 2024 13:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730467187; cv=none; b=D8Yj8LfhlBjrU1eppc6vduwSgz0tEE0YGLBZDMzO27kC1CJerUUx1WFtF4rj6Hv4GsovOzB/YP+vTTvaJrtocScU0vt4yYldBhX3EDEypDi4T7ozjNYyv5tm2KouxKPLU4eCJP+OTbHKqudAbTdex1YW2IZU8FzYlvGX4qTHGAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730467187; c=relaxed/simple;
	bh=9p2kb3bO5opTy0aNcFxhbFWPUORNiqYTzLzH9wwhr1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rlh5GTRiK3wMjwXvF+3e9FbVp3O6DQwKo1ddCIej2yVrpEV2BrgNTwK77ohn4X21FUXpI4xoBKgaaMcAoTTx3NcfWLZAtyhd4GP7R0RPZtoELVPvrFmYhznIykeIHfbUHGgZ+yJCk/OhNTljUu9pRSglGvVek10hMcnQfWuZZIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UDlXDrrT; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730467185; x=1762003185;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9p2kb3bO5opTy0aNcFxhbFWPUORNiqYTzLzH9wwhr1c=;
  b=UDlXDrrTDyDZPeRsjP8qbpR8l93MSEhWgjWWHjZJgPqFp0oLLXNA89j3
   zyzgjf6J2dnGhqVx4F7NxyBuCzvUfPoK2vwAeDQBI27Qc1+EQT7dnZHDq
   ND6Chy0xgqDfbZ7H1yoCkWBpO4r5jFfeSbRTJbReDZ9cCh1LqFM4vInLw
   4KsEHlDlmdbSeHNgy4BFjOdCR0B4GkuDoEA8Udp7ny78zuP9wZdubkd+W
   0T0dZ2e3uPSd29uQWd6MbHFwZdA+8xcE66Dgb+fF8onMFKfOwlwXc8Xy/
   ZoI54I6t8G3vw3Wc+i+bloOBIE0KDjp1+EBHNr6N6TTMGrbRnocmoEBRj
   w==;
X-CSE-ConnectionGUID: rOAZ+dCUQSqNxtRsO/KY1g==
X-CSE-MsgGUID: GpVPsr/2Q0CbpBNxrlsT1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30395886"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30395886"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 06:19:44 -0700
X-CSE-ConnectionGUID: fSOBA+mKQkO9+pwSfxWjVQ==
X-CSE-MsgGUID: Gw0f7l9wT1KoC22NV8CpeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="88086594"
Received: from oandoniu-mobl3.ger.corp.intel.com (HELO [10.245.244.34]) ([10.245.244.34])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 06:19:43 -0700
Message-ID: <48d004c2-86a8-4d5e-97f2-9e5071b75ee9@intel.com>
Date: Fri, 1 Nov 2024 13:19:40 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] drm/xe/guc/tlb: Flush g2h worker in case of tlb
 timeout
To: Nirmoy Das <nirmoy.das@intel.com>, intel-xe@lists.freedesktop.org
Cc: Badal Nilawar <badal.nilawar@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 John Harrison <John.C.Harrison@Intel.com>,
 Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
 Lucas De Marchi <lucas.demarchi@intel.com>, stable@vger.kernel.org
References: <20241029120117.449694-1-nirmoy.das@intel.com>
 <20241029120117.449694-3-nirmoy.das@intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20241029120117.449694-3-nirmoy.das@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/10/2024 12:01, Nirmoy Das wrote:
> Flush the g2h worker explicitly if TLB timeout happens which is
> observed on LNL and that points to the recent scheduling issue with
> E-cores on LNL.
> 
> This is similar to the recent fix:
> commit e51527233804 ("drm/xe/guc/ct: Flush g2h worker in case of g2h
> response timeout") and should be removed once there is E core
> scheduling fix.
> 
> v2: Add platform check(Himal)
> v3: Remove gfx platform check as the issue related to cpu
>      platform(John)
>      Use the common WA macro(John) and print when the flush
>      resolves timeout(Matt B)
> v4: Remove the resolves log and do the flush before taking
>      pending_lock(Matt A)
> 
> Cc: Badal Nilawar <badal.nilawar@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: John Harrison <John.C.Harrison@Intel.com>
> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
> Cc: <stable@vger.kernel.org> # v6.11+
> Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/2687
> Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>
Reviewed-by: Matthew Auld <matthew.auld@intel.com>


