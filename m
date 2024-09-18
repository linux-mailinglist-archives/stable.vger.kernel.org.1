Return-Path: <stable+bounces-76661-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CE597BBAA
	for <lists+stable@lfdr.de>; Wed, 18 Sep 2024 13:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7C111F22FCE
	for <lists+stable@lfdr.de>; Wed, 18 Sep 2024 11:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D9917CA04;
	Wed, 18 Sep 2024 11:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VO0C0OHU"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB4C172BB9
	for <stable@vger.kernel.org>; Wed, 18 Sep 2024 11:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726659072; cv=none; b=NViWMzAQvdv8U15e8/6wYph7si+w0aur761nzWvQBP8TwM+j5tO/66Ry++Txh6fdyxuoM6wLA1RiYFGpavCLp+gZOglRIfq73/0SXZJLu3hI3nCSqcW3mNwUMZz1ehVYb36QCJJD6p2+Dt48oKwEVDmJFZXVtL5TetLLx+sNrBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726659072; c=relaxed/simple;
	bh=OJrNEhSOsy3j4Cz2hwE2E5f6GquprjhhwcVphim765M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=um9VWjmxQibr/F19RTys91hJqvHU6KT2NRFMnSHRGzsJRVJH+Ui2xi5XrgcNwCaORJ50KyCOv2r4F3aITrnjIyIWNCHIQtG46Tmy7ODuLk7WW4i6u+M0+l5DeswQuqRVokE9nqLetMj8YFAblYlo6KdW8osGDsaEHgQkw/J/nHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VO0C0OHU; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726659071; x=1758195071;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OJrNEhSOsy3j4Cz2hwE2E5f6GquprjhhwcVphim765M=;
  b=VO0C0OHU+6Supf53rq2hjr8EFA/b12sTQwdMXApxp4htcx2UxbSdQIoE
   IrU4BUdcfVA6a4zShp4BlZ1jcJQK7mQsJo2/WALhB04gU12O5nljgHOMG
   9Un/seB0vIYWfYcC5RRydGBUv65Cfkh5DtOKKV3/tsoFYvf01sqTlTPRd
   14DqLPS4x/EDJO+8QN1VjZGRisJ8umeR5OHbap39X2aU2HGaBV1l7O5IM
   e2rhKpxcqiwgmL51eq8Li0qMVCI+atGD7tCNsst3b6QAPe1GqMP4VaNtY
   2P/AGiIJIHSvPxB6q6sl41FsoIsjgSEIs8iAKa8KDX/riZhTcvZ+rf91v
   w==;
X-CSE-ConnectionGUID: IgQ0t+DmQlG1C8YGXrtGmw==
X-CSE-MsgGUID: JNlT2+deQDSV7B+MD3TBbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11198"; a="25050561"
X-IronPort-AV: E=Sophos;i="6.10,238,1719903600"; 
   d="scan'208";a="25050561"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2024 04:31:10 -0700
X-CSE-ConnectionGUID: QNoauVOSRPOCuXCOB+EF9A==
X-CSE-MsgGUID: jXJGSoPdQ7uMSlaK1CbmDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,238,1719903600"; 
   d="scan'208";a="100211240"
Received: from carterle-desk.ger.corp.intel.com (HELO [10.245.245.137]) ([10.245.245.137])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2024 04:31:08 -0700
Message-ID: <30f6a93c-eb20-4f48-b006-e8e4fa2315f9@intel.com>
Date: Wed, 18 Sep 2024 12:31:06 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] drm/i915/gem: fix bitwise and logical AND mixup
To: Jani Nikula <jani.nikula@intel.com>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Anshuman Gupta <anshuman.gupta@intel.com>,
 Andi Shyti <andi.shyti@linux.intel.com>, stable@vger.kernel.org
References: <cover.1726658138.git.jani.nikula@intel.com>
 <dec5992d78db5bc556600c64ce72aa9b19c96c77.1726658138.git.jani.nikula@intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <dec5992d78db5bc556600c64ce72aa9b19c96c77.1726658138.git.jani.nikula@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/09/2024 12:17, Jani Nikula wrote:
> CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND is an int, defaulting to 250. When
> the wakeref is non-zero, it's either -1 or a dynamically allocated
> pointer, depending on CONFIG_DRM_I915_DEBUG_RUNTIME_PM. It's likely that
> the code works by coincidence with the bitwise AND, but with
> CONFIG_DRM_I915_DEBUG_RUNTIME_PM=y, there's the off chance that the
> condition evaluates to false, and intel_wakeref_auto() doesn't get
> called. Switch to the intended logical AND.
> 
> Fixes: ad74457a6b5a ("drm/i915/dgfx: Release mmap on rpm suspend")
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Anshuman Gupta <anshuman.gupta@intel.com>
> Cc: Andi Shyti <andi.shyti@linux.intel.com>
> Cc: <stable@vger.kernel.org> # v6.1+
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Reviewed-by: Matthew Auld <matthew.auld@intel.com>

