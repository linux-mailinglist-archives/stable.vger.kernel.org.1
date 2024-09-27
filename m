Return-Path: <stable+bounces-77857-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84418987DC4
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 07:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92E9B1C22242
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 05:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677533B1A1;
	Fri, 27 Sep 2024 05:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZpsNFZwT"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8365C2F2E
	for <stable@vger.kernel.org>; Fri, 27 Sep 2024 05:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727413437; cv=none; b=SmUX37UgRTkJ7k9Il92/Suqi2y7RiXfeiwKrfWGMgq0SzGYxNHlroSbY/Mlh0WzoRMLF+/ttyhJHpBUgGxf+0vWUwsr+Fg9rP499X0hrRyDNSjbPMRragCoP2FYnGnsJiH2kONUdfralN7bjiXM2fhhzUc7mX0AcsHJqTLMzrxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727413437; c=relaxed/simple;
	bh=h6tzTvMnd8vxUBKHtD8Uoe2/955haeq97F1DoJB+M0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pc203imLwVdYVpa5HDRjY9qt+OxHbVNfDdjMtBB6vAMPq2Dw5re7FnhOPPgdhlWB5BKBZasJkku/RNvJ6I6H5B++tBPHuY3/g+KZQtTArVQ1/SDW5L7ggqskii/YFUnFJPtKHgmWum2v1ydPh3taTZaqBc6D1QKIkGpoA7+WeiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZpsNFZwT; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727413436; x=1758949436;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=h6tzTvMnd8vxUBKHtD8Uoe2/955haeq97F1DoJB+M0o=;
  b=ZpsNFZwTWz6JJ291H73NI9LLufP4fiHLPBEtOAUN/JZKAYgGakckko4n
   l2QZ17jES48QwlzuCyyN8Jp3JGoO2DbAdQ7tv3EpGrc7zBhnDavAHTecg
   3eNkJFpoj+GybuVsC2lC8p2+mIT/0wVIQnt68ZD83yhkbLwTlyezH0iiu
   u9zcPXiIJEZtvjaxTYZbeL8D4tZRvMYkNwuVxDc8Zr/qs+X3WL2zd2mCF
   PFLewlljUsy6uUH/ULNRIvkFlnmhydM/pcvOhZSLe3JFEnBZfKVDmIo1Q
   WMRu4NGIjw/MiuKLoaLUgllQ/q2zGwRbIu5HKRcoVV9kneS0gLvJ9eD/m
   Q==;
X-CSE-ConnectionGUID: Kgj9gLP9Qy+owILHOJoD6A==
X-CSE-MsgGUID: r79JqNoiRwqJ+8xQwnbCSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="26414489"
X-IronPort-AV: E=Sophos;i="6.11,157,1725346800"; 
   d="scan'208";a="26414489"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 22:03:55 -0700
X-CSE-ConnectionGUID: 3gCinD+vSPKOjMmvCXCBdw==
X-CSE-MsgGUID: aEh2/unISPi/h9ov93XREQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,157,1725346800"; 
   d="scan'208";a="72297987"
Received: from ellisnea-mobl1.amr.corp.intel.com (HELO desk) ([10.125.147.235])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 22:03:54 -0700
Date: Thu, 26 Sep 2024 22:03:45 -0700
From: Pawan Kumar Gupta <pawan.kumar.gupta@intel.com>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: stable@vger.kernel.org, x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	Zhang Rui <rui.zhang@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
	Thomas Lindroth <thomas.lindroth@gmail.com>,
	Ricardo Neri <ricardo.neri@intel.com>
Subject: Re: [PATCH 6.1.y 1/2] powercap: RAPL: fix invalid initialization for
 pl4_supported field
Message-ID: <20240927050345.kmtdikzwmuflv2y5@desk>
References: <20240925150737.16882-1-ricardo.neri-calderon@linux.intel.com>
 <20240925150737.16882-2-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925150737.16882-2-ricardo.neri-calderon@linux.intel.com>

On Wed, Sep 25, 2024 at 08:07:36AM -0700, Ricardo Neri wrote:
> From: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
> 
> [ Upstream commit d05b5e0baf424c8c4b4709ac11f66ab726c8deaf ]
> 
> The current initialization of the struct x86_cpu_id via
> pl4_support_ids[] is partial and wrong. It is initializing
> "stepping" field with "X86_FEATURE_ANY" instead of "feature" field.
> 
> Use X86_MATCH_INTEL_FAM6_MODEL macro instead of initializing
> each field of the struct x86_cpu_id for pl4_supported list of CPUs.
> This X86_MATCH_INTEL_FAM6_MODEL macro internally uses another macro
> X86_MATCH_VENDOR_FAM_MODEL_FEATURE for X86 based CPU matching with
> appropriate initialized values.
> 
> Reported-by: Dave Hansen <dave.hansen@intel.com>
> Link: https://lore.kernel.org/lkml/28ead36b-2d9e-1a36-6f4e-04684e420260@intel.com
> Fixes: eb52bc2ae5b8 ("powercap: RAPL: Add Power Limit4 support for Meteor Lake SoC")
> Fixes: b08b95cf30f5 ("powercap: RAPL: Add Power Limit4 support for Alder Lake-N and Raptor Lake-P")
> Fixes: 515755906921 ("powercap: RAPL: Add Power Limit4 support for RaptorLake")
> Fixes: 1cc5b9a411e4 ("powercap: Add Power Limit4 support for Alder Lake SoC")
> Fixes: 8365a898fe53 ("powercap: Add Power Limit4 support")
> Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> [ Ricardo: I removed METEORLAKE and METEORLAKE_L from pl4_support_ids as
>   they are not included in v6.1. ]
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

Reviewed-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

