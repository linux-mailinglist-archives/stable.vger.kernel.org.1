Return-Path: <stable+bounces-136614-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9906A9B51E
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 19:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D07E5A6893
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 17:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A098A28BA8B;
	Thu, 24 Apr 2025 17:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PySRH5SH"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A830D284673;
	Thu, 24 Apr 2025 17:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745515166; cv=none; b=dpsD2o0pgZKf5c7hQb4phxEQVCF3uAMgrzldcHlDYfyn1LJJOA/3Vc9JYS6JsiBEyC+NHPYUxbUuNB5AjwMFyQLtkidFDO+U6t97XiZQxv7BbqpbUDxZZ+ZIj6K44ToRGy+QJ2sMfcQhTLhq+t2Prb+y1yxvsvmAHhaNNh9R/Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745515166; c=relaxed/simple;
	bh=ItVrLqgKGeOUFRj5iB6zphXpB+2yCMawqMR3Hb/E/W4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVHahgbSQH2u/GuJCgEf/KDmg+lVklT97n1Ke1Iqv6E9ULGya4uH067rQGMml4kngs/dax1SKqv7RjXGw9DbLxB9VSp23Ns/lJYAEdoLa4ENQHSCEcI1xr3NRFF6DwA7NUA9pyQKiOP0wsTZBzFR8Pc5G93RLXU9SxhIwhhQzfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PySRH5SH; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745515165; x=1777051165;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ItVrLqgKGeOUFRj5iB6zphXpB+2yCMawqMR3Hb/E/W4=;
  b=PySRH5SHNMwvHqLmAq8SbnZhhOb2/TLcwEdG3JBn2WAUNz0YysPK6/hl
   SEJFPYZZI0dh/cWU4iE0lM9WWRczu+ith4DMAaZIcA+pTs9/3fDR3l3eV
   vEimlijzBItehTd3d6WjtmjTZl+LtmSQ1cnDLlECMnLHkokb5+qnZ1PDE
   +NEZB3aHAL3cddnzG+xyjJ7IfVi5hJBXCxISmSSpm85YEWLes2y565IhP
   1ik0J8hQ4WgMoehfmgxV0Gp6nFCTT8J53iUJTsb+9APD9/Ny869IIf1PF
   X1k8LDCSFMINNUWGYUWhcIf+mT+Sd0AdJ2s9A/f01bRwbndjkDi+wcvDH
   A==;
X-CSE-ConnectionGUID: dP9ug0ItSQWIvOWG/GJvfA==
X-CSE-MsgGUID: O+7ijbfhTWugORlGGAE9/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="57802002"
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="57802002"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 10:19:24 -0700
X-CSE-ConnectionGUID: YQmfbH4uQ+a3WDn2GGMy8Q==
X-CSE-MsgGUID: lO9HtIHSQPO+InIyvQlNWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="137526823"
Received: from smile.fi.intel.com ([10.237.72.55])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 10:19:20 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1u80EG-000000003GS-3pQ2;
	Thu, 24 Apr 2025 20:19:16 +0300
Date: Thu, 24 Apr 2025 20:19:16 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Zhenhua Huang <quic_zhenhuah@quicinc.com>, cl@linux.com,
	rientjes@google.com, roman.gushchin@linux.dev, harry.yoo@oracle.com,
	surenb@google.com, pasha.tatashin@soleen.com,
	akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, quic_tingweiz@quicinc.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] mm, slab: clean up slab->obj_exts always
Message-ID: <aApylNvOXzNdYRaN@smile.fi.intel.com>
References: <20250421075232.2165527-1-quic_zhenhuah@quicinc.com>
 <aApoFXmDE-k2KFFV@black.fi.intel.com>
 <da89dcd6-9369-4a87-9794-a0bf5772509b@suse.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da89dcd6-9369-4a87-9794-a0bf5772509b@suse.cz>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 24, 2025 at 06:48:46PM +0200, Vlastimil Babka wrote:
> On 4/24/25 18:34, Andy Shevchenko wrote:
> > On Mon, Apr 21, 2025 at 03:52:32PM +0800, Zhenhua Huang wrote:
> >> When memory allocation profiling is disabled at runtime or due to an
> >> error, shutdown_mem_profiling() is called: slab->obj_exts which
> >> previously allocated remains.
> >> It won't be cleared by unaccount_slab() because of
> >> mem_alloc_profiling_enabled() not true. It's incorrect, slab->obj_exts
> >> should always be cleaned up in unaccount_slab() to avoid following error:
> >> 
> >> [...]BUG: Bad page state in process...
> >> ..
> >> [...]page dumped because: page still charged to cgroup
> > 
> > Please, always compile test with `make W=1`. Since CONFIG_WERROR=y this
> > effectively breaks the build with Clang.
> 
> I don't see why, nor observe any W=1 warnings, can you be more specific? Thanks.

Specifics are in the fix I sent. Just a relatively new Clang and
relatively recent enabling of warning for unused static inline functions
in the C code. If you are insisting in seeing the exact kernel
configuration I have, tell me where to send, I'll send it privately
to avoid noise here.

-- 
With Best Regards,
Andy Shevchenko



