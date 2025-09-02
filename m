Return-Path: <stable+bounces-176999-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4E5B3FE5B
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 13:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 861347B0552
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 11:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1377304BDA;
	Tue,  2 Sep 2025 11:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MHFskezs"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029852F90D8
	for <stable@vger.kernel.org>; Tue,  2 Sep 2025 11:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756813538; cv=none; b=ebUwSheeaZP1CubUMeno1m1i4KdXH+zCNOLevQdq+NCEfSbPCgQWflt0nW8k404Orpmi93th7d3TPPkADgH9aaKXASJf77wqKtJl1OAouOrBBE9XW6D3BZJTNu+pYtcWqjzFM4PcsFxEVxx+ckrUJihADB6JnT2AxVZG/udSqgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756813538; c=relaxed/simple;
	bh=VJR6ejNydKtend2W9OJCQCt4N74aEA5gY7zIWN6Im5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dZJ2Tulr1S1LJBwWizFEu8isf+MnzzrZa4mA4UFeSwh3LiCTkmH274nj0xPQd+yTlWUKShYwEZxaPhFIY7uXsCoqBHlXi+kJd2jmoU0FitSzQ/Ychm7ZQ/E2IPD7ISnT/EfF9YoxLVhiERldgx2DOCFYcL2IgjxB8UPZEvzkzg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MHFskezs; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756813537; x=1788349537;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VJR6ejNydKtend2W9OJCQCt4N74aEA5gY7zIWN6Im5c=;
  b=MHFskezsCNNcWNF4Q2Q26v22t+SAJhwacR1a/cciopdb1UkPbT2g4UON
   +ktWfKQZAuAf51Ew+vjGNCrWY5uXt34q5puLP0I9s1+YDvmHSKShTxOOW
   uXkTn98EVORNKXy3BxWcgyVOOBRvFIxPJw31FvfXeEA8s212qSxgy+IdB
   SXq1LEoMSlpHPSYK8W7axLyibQXsTM9vUySopSA9edk/w07+fMbE2AAg5
   plISqVf3oGQufYCmgXYKA6B8yDq2/AB8tEDRmzke8EprBytRqHKJC+mpJ
   H40bOSw9U30Ya5Zqr6rl2QjT9VefqfmuofnS0GqYVIAh6+TobDjIJVWcp
   A==;
X-CSE-ConnectionGUID: yj6AvO2PT3O5ilUDX4J/Og==
X-CSE-MsgGUID: osvXGDQsTiSq4DiYivVnwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11540"; a="61723669"
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="61723669"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 04:45:36 -0700
X-CSE-ConnectionGUID: HY6MteJpR9CiMJs6geDZCQ==
X-CSE-MsgGUID: dEDbT+FeSr+pCdOtcecmgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="171696062"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO [10.245.245.71]) ([10.245.245.71])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 04:45:35 -0700
Message-ID: <6cc837f4-ed1d-4c42-b8c9-46514e5084f7@intel.com>
Date: Tue, 2 Sep 2025 12:45:32 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] drm/xe: Attempt to bring bos back to VRAM after
 eviction
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>, stable@vger.kernel.org,
 Rodrigo vivi <rodrigo.vivi@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
References: <20250901083829.27341-1-thomas.hellstrom@linux.intel.com>
 <20250901083829.27341-2-thomas.hellstrom@linux.intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20250901083829.27341-2-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01/09/2025 09:38, Thomas Hellström wrote:
> VRAM+TT bos that are evicted from VRAM to TT may remain in
> TT also after a revalidation following eviction or suspend.
> 
> This manifests itself as applications becoming sluggish
> after buffer objects get evicted or after a resume from
> suspend or hibernation.
> 
> If the bo supports placement in both VRAM and TT, and
> we are on DGFX, mark the TT placement as fallback. This means
> that it is tried only after VRAM + eviction.
> 
> This flaw has probably been present since the xe module was
> upstreamed but use a Fixes: commit below where backporting is
> likely to be simple. For earlier versions we need to open-
> code the fallback algorithm in the driver.
> 
> v2:
> - Remove check for dgfx. (Matthew Auld)
> - Update the xe_dma_buf kunit test for the new strategy (CI)
> - Allow dma-buf to pin in current placement (CI)
> - Make xe_bo_validate() for pinned bos a NOP.
> 
> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/5995
> Fixes: a78a8da51b36 ("drm/ttm: replace busy placement with flags v6")
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: <stable@vger.kernel.org> # v6.9+
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Reviewed-by: Matthew Auld <matthew.auld@intel.com> #v1

Reviewed-by: Matthew Auld <matthew.auld@intel.com>

