Return-Path: <stable+bounces-120352-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9459AA4E9B1
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 18:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F2F4886327
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 17:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599E72BF3DE;
	Tue,  4 Mar 2025 16:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e/WkyzXV"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754A827BF84
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 16:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741107210; cv=none; b=hacG0Kt6LGD+NQ/qq8+CWDuau6BiQRTPY3oZuq4BThxInOxZtkcrVGq7j6o+umdY+WV0Zp5CUfHZ/gdImc+SA7t6uAV9X5qHNY/gZuAQ0NCz6PSiqUFk49swVw2dKvL1ltnJwnkRykmtHu/q9Gb1lAIFgp+KEp7bDYIQ6257gy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741107210; c=relaxed/simple;
	bh=pmJiKXm1wcFFEIkPRaSCM/11zJX5KYMUAtbvJogZ00E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DJvojh+wxKzsqUzdSStW2gx9FbNSy38Qt9WebjV8KzfH5L2rkglwWDQOaJ7dHU6CJO7SbrXepezrbREcEo/mBL7MkDxGc9TicmRlzJ4RZQWmd6vHstdBKGNT+wLrauwlXDueti/sWEPAUjJBfdXpFNwnMPW0n1P1Hep98PZ/GrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e/WkyzXV; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741107208; x=1772643208;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pmJiKXm1wcFFEIkPRaSCM/11zJX5KYMUAtbvJogZ00E=;
  b=e/WkyzXVmYuGRJ8yr5C+b/xQUoyFxIY7BDospBGdHtIXMbY0U68iAni9
   L2ueCFT9lMoUdFOSIpuC0aOozbEPA5OM0CLOQcHA3MNqiykAMvCZzFxWK
   PHmRNHc/KXN5od6zEx4gY28pgfloO8rmnpjYPif6N8Crs2BaM6sdENI7m
   KAUO4lafjCYucQf/JKBrCvzndVLkvcDV9ARoJRFTIVG2icSwuZSRyVZzg
   reSO+8svb9WRWPWaKDepaLnchcePPjAS2Pz5LaXChzYAIJ0sNOjHhhZzV
   j/S9+T5GKTqn4w1EQHswjx5Tq23XNu0HEXRtxCcOQpW46RgiHsion7cMO
   w==;
X-CSE-ConnectionGUID: 7VKq3DH8RxyqPKB/zhTTow==
X-CSE-MsgGUID: S9e2uJnsQEaspXzdjIwmbg==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="52674261"
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="52674261"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 08:53:28 -0800
X-CSE-ConnectionGUID: s6myUBAXSSKZ9Z5eUUQLLw==
X-CSE-MsgGUID: dseNKyNfQA6cjac5Bm7tyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="149370282"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.245.188]) ([10.245.245.188])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 08:53:26 -0800
Message-ID: <ac71f5fd-b207-4ceb-8b3e-b794d11a7ea5@intel.com>
Date: Tue, 4 Mar 2025 16:53:24 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] drm/xe/userptr: Unmap userptrs in the mmu notifier
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: Oak Zeng <oak.zeng@intel.com>, stable@vger.kernel.org
References: <20250304113758.67889-1-thomas.hellstrom@linux.intel.com>
 <20250304113758.67889-4-thomas.hellstrom@linux.intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20250304113758.67889-4-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/03/2025 11:37, Thomas Hellström wrote:
> If userptr pages are freed after a call to the xe mmu notifier,
> the device will not be blocked out from theoretically accessing
> these pages unless they are also unmapped from the iommu, and
> this violates some aspects of the iommu-imposed security.
> 
> Ensure that userptrs are unmapped in the mmu notifier to
> mitigate this. A naive attempt would try to free the sg table, but
> the sg table itself may be accessed by a concurrent bind
> operation, so settle for unly unmapping.

only

> 
> Fixes: 81e058a3e7fd ("drm/xe: Introduce helper to populate userptr")
> Cc: Oak Zeng <oak.zeng@intel.com>
> Cc: <stable@vger.kernel.org> # v6.10+
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Reviewed-by: Matthew Auld <matthew.auld@intel.com>



