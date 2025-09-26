Return-Path: <stable+bounces-181779-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C73E5BA48BC
	for <lists+stable@lfdr.de>; Fri, 26 Sep 2025 18:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82155623C82
	for <lists+stable@lfdr.de>; Fri, 26 Sep 2025 16:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D8D231858;
	Fri, 26 Sep 2025 16:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bKpo5tuB"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CC88287E
	for <stable@vger.kernel.org>; Fri, 26 Sep 2025 16:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758902746; cv=none; b=QklUjXzF6mOGbmiN6RibvFhCSblYyAPWDPh0s5G7Xo+g/ETCCPpvAQ5s4sX9LTrw3+AqpjhL41RJxCUzX5e5/NlrkEPDT0/5J5vIhompCIVpRooLw49yt75dmmo80Mys2CID6X6kaqvWQMKkGI8g+8J7jlMaQzYCpvhtiaqjGAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758902746; c=relaxed/simple;
	bh=rd+7hbNMpp75M/aBANgHZpJMCcqOEXVDoS/5QQiFAzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N6s/L6SqX/a9KHlbRQbpJYvODEeuwoKVGFIJhx/a8Gm/57Hxat16i7+5IJeCIPD3e8cAOgD1WGrff4qTCUYQNglQcithKZfOAcDtb7IeksT6XK/Brl6pG3EhrFyGyQ3ZWQootcRP+apBEwi05eFEpjy9dzlFlLeL/bswjF4D9+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bKpo5tuB; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758902744; x=1790438744;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rd+7hbNMpp75M/aBANgHZpJMCcqOEXVDoS/5QQiFAzg=;
  b=bKpo5tuBzc9ibYqUpbLHwsnjKECH992YJ1Kp3ZXFnzmjal7ZhtaxyLYX
   Dt0zvDCNRiPTyieY/j+LV7Y5MJGMa9wka0abbgx6zzercKhxEiQ4TOdOv
   QG7JywOsSYmfIY5e4Ay7CyGmnedQXAS5Xh5Vay6G1bzTi6bwIJEQReiBX
   ZJmKOyFomIkvirIT1mu6Jo9DzfkEGJOiS9W8LRDyP+TdSj4FpHGzrNCg5
   7Kqb2V141R8dNh0sxRe8N8mmSu3chAYYK7VfiSmg/kuJA1qguEiI0IaYF
   23LscPx4Bjty73Rb3rpohjN4CxG8uDIzwd+bbjBnBMJb1215zVU7AtKuU
   Q==;
X-CSE-ConnectionGUID: Z+wj647STv6HHdk0ZSGH2Q==
X-CSE-MsgGUID: yRoxeympQO+Qg2wU5gS7tA==
X-IronPort-AV: E=McAfee;i="6800,10657,11565"; a="86683347"
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="86683347"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 09:05:44 -0700
X-CSE-ConnectionGUID: rhVB3u+zTRGCnz7LOGFJKA==
X-CSE-MsgGUID: En2DyOE6Rza804+hgeyW0w==
X-ExtLoop1: 1
Received: from abityuts-desk.ger.corp.intel.com (HELO [10.245.245.9]) ([10.245.245.9])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 09:05:42 -0700
Message-ID: <25825f68-e17b-492e-877b-9282667e2dff@intel.com>
Date: Fri, 26 Sep 2025 17:05:40 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/3] drm/buddy: Optimize free block management with RB
 tree
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
Cc: alexander.deucher@amd.com, jani.nikula@linux.intel.com,
 peterz@infradead.org, samuel.pitoiset@gmail.com, stable@vger.kernel.org
References: <20250923090242.60649-1-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20250923090242.60649-1-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/09/2025 10:02, Arunpravin Paneer Selvam wrote:
> Replace the freelist (O(n)) used for free block management with a
> red-black tree, providing more efficient O(log n) search, insert,
> and delete operations. This improves scalability and performance
> when managing large numbers of free blocks per order (e.g., hundreds
> or thousands).
> 
> In the VK-CTS memory stress subtest, the buddy manager merges
> fragmented memory and inserts freed blocks into the freelist. Since
> freelist insertion is O(n), this becomes a bottleneck as fragmentation
> increases. Benchmarking shows list_insert_sorted() consumes ~52.69% CPU
> with the freelist, compared to just 0.03% with the RB tree
> (rbtree_insert.isra.0), despite performing the same sorted insert.
> 
> This also improves performance in heavily fragmented workloads,
> such as games or graphics tests that stress memory.
> 
> As the buddy allocator evolves with new features such as clear-page
> tracking, the resulting fragmentation and complexity have grown.
> These RB-tree based design changes are introduced to address that
> growth and ensure the allocator continues to perform efficiently
> under fragmented conditions.
> 
> The RB tree implementation with separate clear/dirty trees provides:
> - O(n log n) aggregate complexity for all operations instead of O(n^2)
> - Elimination of soft lockups and system instability
> - Improved code maintainability and clarity
> - Better scalability for large memory systems
> - Predictable performance under fragmentation
> 
> v3(Matthew):
>    - Remove RB_EMPTY_NODE check in force_merge function.
>    - Rename rb for loop macros to have less generic names and move to
>      .c file.
>    - Make the rb node rb and link field as union.
> 
> v4(Jani Nikula):
>    - The kernel-doc comment should be "/**"
>    - Move all the rbtree macros to rbtree.h and add parens to ensure
>      correct precedence.
> 
> v5:
>    - Remove the inline in a .c file (Jani Nikula).
> 
> v6(Peter Zijlstra):
>    - Add rb_add() function replacing the existing rbtree_insert() code.
> 
> v7:
>    - A full walk iteration in rbtree is slower than the list (Peter Zijlstra).
>    - The existing rbtree_postorder_for_each_entry_safe macro should be used
>      in scenarios where traversal order is not a critical factor (Christian).
> 
> Cc: stable@vger.kernel.org
> Fixes: a68c7eaa7a8f ("drm/amdgpu: Enable clear page functionality")
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

Reviewed-by: Matthew Auld <matthew.auld@intel.com>


