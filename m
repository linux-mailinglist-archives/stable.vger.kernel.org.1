Return-Path: <stable+bounces-32342-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E4F88C90F
	for <lists+stable@lfdr.de>; Tue, 26 Mar 2024 17:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85A271F3BB6F
	for <lists+stable@lfdr.de>; Tue, 26 Mar 2024 16:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A99013CAB7;
	Tue, 26 Mar 2024 16:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LYbxrmfZ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C31C13CAB6
	for <stable@vger.kernel.org>; Tue, 26 Mar 2024 16:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711470259; cv=none; b=fBWl6Hc//kYmx763m/Yh2vOxRCvBzVdm+/2nqY5QM3hFwXD25syPVRtHtOUKWk1+QfkXN6BGhurkk16tnQdpEol5+6LMd4BHtGl/nZ7eKSTUmXK8UhTGYckaRRg43SZ039K2eEtZGUyzNDThQj8xqpzFRJIBc6EENMrjgLnBvWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711470259; c=relaxed/simple;
	bh=FfwX0VEtAy+auA9LmxwyTk7bWi3IdaPEomwQSo/jBEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TsTv/zhL25fOOmhQa426Ft/nazZ8PzdEXwu/XOPsCdITwwNM3VEp4sWDDERF803ybLnmIQynyPcxydQU2uh3ZQUTQXt7RqIrYapWdzswcQ02GfZu0w92VIRKHSdcGJxD7hFqeFQESrEx3wGOavxVoeGT0OZPmEGbTKd8ZeXXlUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LYbxrmfZ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711470258; x=1743006258;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FfwX0VEtAy+auA9LmxwyTk7bWi3IdaPEomwQSo/jBEQ=;
  b=LYbxrmfZHWH12gBuxG5JtW1iusJTtO7ba834WnLWsBmuARXCt2VlzmzW
   7GZIfgSxsP+d44VlFBNJJzSGbOD/LyC+ZuPllOhBtwERSW26kPkxgAY90
   wbp+6nX69XYuDPaBTW0wjNd1on9s5OmTs8pg9in114vpDGYQilQVRFQ0J
   SvqOXPuy4mONOhcTirRXvcGCEUuqL4RPpMAfXMyQcRtGbBvLFZs+ntInE
   6mQQ+CQT7xhfUyqcyLM8YBkuQQMZVWGBSwD146I9sBiMf9uLzKt5abSQt
   ntDXn+poCa6tO7cHDeq6k0DiuGHj6AlUB6ptRPTUEAklN/vL7lFd+9Oc3
   w==;
X-CSE-ConnectionGUID: 6XGsSR0qSKW+sdVMD4RxYA==
X-CSE-MsgGUID: Cf8wVPASQTepAhbI01oLIg==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="10332384"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="10332384"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 09:24:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="47026954"
Received: from unknown (HELO intel.com) ([10.247.118.204])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 09:24:10 -0700
Date: Tue, 26 Mar 2024 17:24:03 +0100
From: Andi Shyti <andi.shyti@linux.intel.com>
To: Andi Shyti <andi.shyti@linux.intel.com>
Cc: intel-gfx <intel-gfx@lists.freedesktop.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	Chris Wilson <chris.p.wilson@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	John Harrison <John.C.Harrison@intel.com>, stable@vger.kernel.org,
	Andi Shyti <andi.shyti@kernel.org>,
	Tvrtko Ursulin <tursulin@ursulin.net>, michal.mrozek@intel.com,
	mark.j.buxton@intel.com
Subject: Re: [PATCH v6 0/3] Disable automatic load CCS load balancing
Message-ID: <ZgL2o7c0R_Z7shFJ@ashyti-mobl2.lan>
References: <20240313201955.95716-1-andi.shyti@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313201955.95716-1-andi.shyti@linux.intel.com>

Hi Michal, Mark,

can you please ack from your side this first batch of changes?

Thanks,
Andi

On Wed, Mar 13, 2024 at 09:19:48PM +0100, Andi Shyti wrote:
> Hi,
> 
> this series does basically two things:
> 
> 1. Disables automatic load balancing as adviced by the hardware
>    workaround.
> 
> 2. Assigns all the CCS slices to one single user engine. The user
>    will then be able to query only one CCS engine
> 
> >From v5 I have created a new file, gt/intel_gt_ccs_mode.c where
> I added the intel_gt_apply_ccs_mode(). In the upcoming patches,
> this file will contain the implementation for dynamic CCS mode
> setting.
> 
> Thanks Tvrtko, Matt, John and Joonas for your reviews!
> 
> Andi
> 
> Changelog
> =========
> v5 -> v6 (thanks Matt for the suggestions in v6)
>  - Remove the refactoring and the for_each_available_engine()
>    macro and instead do not create the intel_engine_cs structure
>    at all.
>  - In patch 1 just a trivial reordering of the bit definitions.
> 
> v4 -> v5
>  - Use the workaround framework to do all the CCS balancing
>    settings in order to always apply the modes also when the
>    engine resets. Put everything in its own specific function to
>    be executed for the first CCS engine encountered. (Thanks
>    Matt)
>  - Calculate the CCS ID for the CCS mode as the first available
>    CCS among all the engines (Thanks Matt)
>  - create the intel_gt_ccs_mode.c function to host the CCS
>    configuration. We will have it ready for the next series.
>  - Fix a selftest that was failing because could not set CCS2.
>  - Add the for_each_available_engine() macro to exclude CCS1+ and
>    start using it in the hangcheck selftest.
> 
> v3 -> v4
>  - Reword correctly the comment in the workaround
>  - Fix a buffer overflow (Thanks Joonas)
>  - Handle properly the fused engines when setting the CCS mode.
> 
> v2 -> v3
>  - Simplified the algorithm for creating the list of the exported
>    uabi engines. (Patch 1) (Thanks, Tvrtko)
>  - Consider the fused engines when creating the uabi engine list
>    (Patch 2) (Thanks, Matt)
>  - Patch 4 now uses a the refactoring from patch 1, in a cleaner
>    outcome.
> 
> v1 -> v2
>  - In Patch 1 use the correct workaround number (thanks Matt).
>  - In Patch 2 do not add the extra CCS engines to the exposed
>    UABI engine list and adapt the engine counting accordingly
>    (thanks Tvrtko).
>  - Reword the commit of Patch 2 (thanks John).
> 
> Andi Shyti (3):
>   drm/i915/gt: Disable HW load balancing for CCS
>   drm/i915/gt: Do not generate the command streamer for all the CCS
>   drm/i915/gt: Enable only one CCS for compute workload
> 
>  drivers/gpu/drm/i915/Makefile               |  1 +
>  drivers/gpu/drm/i915/gt/intel_engine_cs.c   | 20 ++++++++---
>  drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.c | 39 +++++++++++++++++++++
>  drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.h | 13 +++++++
>  drivers/gpu/drm/i915/gt/intel_gt_regs.h     |  6 ++++
>  drivers/gpu/drm/i915/gt/intel_workarounds.c | 30 ++++++++++++++--
>  6 files changed, 103 insertions(+), 6 deletions(-)
>  create mode 100644 drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.c
>  create mode 100644 drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.h
> 
> -- 
> 2.43.0

