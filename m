Return-Path: <stable+bounces-126000-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A87A6EC18
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 10:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23DE5188419B
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 09:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3C91DB924;
	Tue, 25 Mar 2025 09:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PGkz+VyM"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760FF1F63D9
	for <stable@vger.kernel.org>; Tue, 25 Mar 2025 09:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742893402; cv=none; b=cgn28vulnfimtMxtV3CGDr6thiyMZupsB8TLAbZJcxp+PPQhz0sEirKopDEPjSRoHWkS67RM1t9bI58AX0kV7TQvCo1HIbZSg55o1L0Xe2bWAtM/YHR8HvHn/HtMPqhdZisMoLqIU/iMs5hxisyIsj7wOl5BsDa5AJltNI6D2D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742893402; c=relaxed/simple;
	bh=UvzxqcOL6OUkTtr4lFFzh6hnAD3fKjSDEzEco6HYaHk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s7JHFrtaA+RcBfsFwjCdGSMZJYiUmJMGgATg7e9dpOK71KsjMqbduZkg3tTDVT2qD9ILlZfTmVUAsJFjiLMYPPbPV8x5p8HZyMRoilSGhavOmtYxRMjdqtbR6ieNbZTm1MJ/XMS4Y32F93G3scijs/Q8sW6WGBgNBCrfrU+JB7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PGkz+VyM; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742893400; x=1774429400;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=UvzxqcOL6OUkTtr4lFFzh6hnAD3fKjSDEzEco6HYaHk=;
  b=PGkz+VyMU5bBPVExvBos7s3DvBk/48M+Bt0BsbxtyjdTojRsuWRaOnEB
   1AulRoMdH3jT4cLCkHpfV6kPETP+34jbwdlAqHfd5TNPCYlD+rQT7R55Z
   GtVN6rUKMWH/igusWkNNjWLgt4YMjhQnH/T0KAeukxTNSGXDSPD817l9E
   xRi6Vwj4is3nyTFnY0vTbNmBC0ZJWLazYxOKLy87qLLBaTQ3HpC1dnzyi
   s+fvW7KM0xh3qfjzJMEiJTTvrqwpTXRtAaGu1YdjYJcXobMX5Ey/CVQ0K
   MNWfQZuazZKLq/zUTk40IeNs06Hyqebdxfu00hQHE0rgRth9NixKTh5pr
   w==;
X-CSE-ConnectionGUID: mRH+H7lISUe3iXaGnsB2qA==
X-CSE-MsgGUID: vFZdot0pSKCqMlsqDNIWSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11383"; a="46868685"
X-IronPort-AV: E=Sophos;i="6.14,274,1736841600"; 
   d="scan'208";a="46868685"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 02:03:17 -0700
X-CSE-ConnectionGUID: luqqJcHrQk6tUwGnEbb1tA==
X-CSE-MsgGUID: huEGemd5QLq1wid3od2j/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,274,1736841600"; 
   d="scan'208";a="125091586"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.134])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 02:03:15 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>, Matt Roper
 <matthew.d.roper@intel.com>
Cc: intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, Vivek
 Kasireddy <vivek.kasireddy@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/i915/xe2hpd: Identify the memory type for SKUs
 with GDDR + ECC
In-Reply-To: <32lakxysapix2hgoh5e7n2b6zlv544nh6vcvmg6zllzjnlikmd@7k37w7pqy4p2>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250324-tip-v2-1-38397de319f8@intel.com>
 <20250324200207.GN3175483@mdroper-desk1.amr.corp.intel.com>
 <32lakxysapix2hgoh5e7n2b6zlv544nh6vcvmg6zllzjnlikmd@7k37w7pqy4p2>
Date: Tue, 25 Mar 2025 11:03:13 +0200
Message-ID: <87bjtpa3e6.fsf@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 24 Mar 2025, Lucas De Marchi <lucas.demarchi@intel.com> wrote:
> On Mon, Mar 24, 2025 at 01:02:07PM -0700, Matt Roper wrote:
>>On Mon, Mar 24, 2025 at 10:22:33AM -0700, Lucas De Marchi wrote:
>>> From: Vivek Kasireddy <vivek.kasireddy@intel.com>
>>>
>>> Some SKUs of Xe2_HPD platforms (such as BMG) have GDDR memory type
>>> with ECC enabled. We need to identify this scenario and add a new
>>> case in xelpdp_get_dram_info() to handle it. In addition, the
>>> derating value needs to be adjusted accordingly to compensate for
>>> the limited bandwidth.
>>>
>>> Bspec: 64602
>>> Cc: Matt Roper <matthew.d.roper@intel.com>
>>> Fixes: 3adcf970dc7e ("drm/xe/bmg: Drop force_probe requirement")
>>> Cc: stable@vger.kernel.org

FYI, this does not cherry-pick cleanly to drm-intel-next-fixes, and
needs a backport.

There are dependencies on at least

4051c59e2a6a ("drm/i915/xe3lpd: Update bandwidth parameters")
9377c00cfdb5 ("drm/i915/display: Convert intel_bw.c internally to intel_display")
d706998b6da6 ("drm/i915/display: Convert intel_bw.c externally to intel_display")

but I don't think we want to backport those.

BR,
Jani.




>>> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
>>> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
>>
>>Reviewed-by: Matt Roper <matthew.d.roper@intel.com>
>
> Thanks. Patch pushed to drm-intel-next.
>
> Lucas De Marchi

-- 
Jani Nikula, Intel

