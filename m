Return-Path: <stable+bounces-33028-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FFA88F0A2
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 22:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB8F41C22A05
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 21:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED76C152197;
	Wed, 27 Mar 2024 21:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fcqUH9Vh"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4BD1514D9
	for <stable@vger.kernel.org>; Wed, 27 Mar 2024 21:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711573801; cv=none; b=kvE3H5RhCVbISdlAUyOYuAdujHJQqy2R+IuPj87Q6Sy9UkiAD1sQdOwB+TT/qWbPFbGti0Eah30PA6/i+6xXDohEabvXDYkesTLUETVPwW9rLt17RU9ct3+vWnUbz1CglJaxThzaJLfeXtAhihJ08suXcA8xc2mbKRw5ibknQ2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711573801; c=relaxed/simple;
	bh=HIR6ORA8ivaGvER4UfQMPmG83USC1ryp+tI4TXFkQm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m1juMKz3RgsQisiNTqDmMDenr3hJwQ71MJkrxSHi5Ul7nJrMFxJql7va4l2Btl1J0PhwYpox5u3migfVjEQY9CdThrns2UOtq5bpPgnNjDphFm9s/pwB26/afxmZLpbXXHgXe3bH0DykYhsWUyY7V01TqXfJBx3AtqxW3XPH1ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fcqUH9Vh; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711573800; x=1743109800;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HIR6ORA8ivaGvER4UfQMPmG83USC1ryp+tI4TXFkQm8=;
  b=fcqUH9VhGU0N6Mth1E81+LOuNLl1wlTohdjr4j14brK8I1ZJbfy+wtV3
   WjANv81atpx/v+2uTAn+YEA+NjAOT9pY9t9Lru4CB1Qi8fhGlfZnbPXKP
   wzfDZt4dyuPJvxhXm8M6AhjIDiNncfsovG1EuDpCokFvDmmirFLhyc0xz
   gOrys/OATDoZX7/2WrAStT/GSoA/iP/p4XSuq4tV4L6PRrXRVwDyx+gwx
   z3/Gr9uEMguy0UZ6PLe2VVmFu9ATcp/7bl7T01efYR+cjbaPh+T1YEdjJ
   iG5I9PtiPH0qH5Q67DtvtxpOEpz/zqgHeqfuvVVIKIaTfRxcBtU34ImPV
   Q==;
X-CSE-ConnectionGUID: cjL0OQuuQBac4NOWv5ag8Q==
X-CSE-MsgGUID: /q6Pt/dDQ8iLoqqQlvgCoQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="18140959"
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="18140959"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 14:10:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="16883526"
Received: from unknown (HELO intel.com) ([10.247.118.215])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 14:09:52 -0700
Date: Wed, 27 Mar 2024 22:09:46 +0100
From: Andi Shyti <andi.shyti@linux.intel.com>
To: Andi Shyti <andi.shyti@linux.intel.com>
Cc: intel-gfx <intel-gfx@lists.freedesktop.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	Michal Mrozek <michal.mrozek@intel.com>,
	Lionel Landwerlin <lionel.g.landwerlin@intel.com>,
	mateusz.jablonski@intel.com, Andi Shyti <andi.shyti@kernel.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Chris Wilson <chris.p.wilson@linux.intel.com>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>,
	Nirmoy Das <nirmoy.das@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH] drm/i915/gt: Limit the reserved VM space to only the
 platforms that need it
Message-ID: <ZgSLGqazTlpUzlIm@ashyti-mobl2.lan>
References: <20240327200546.640108-1-andi.shyti@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327200546.640108-1-andi.shyti@linux.intel.com>

Hi,

On Wed, Mar 27, 2024 at 09:05:46PM +0100, Andi Shyti wrote:
> Commit 9bb66c179f50 ("drm/i915: Reserve some kernel space per
> vm") reduces the available VM space of one page in order to apply
> Wa_16018031267 and Wa_16018063123.
> 
> This page was reserved indiscrimitely in all platforms even when
> not needed. Limit it to DG2 onwards.
> 
> Fixes: 9bb66c179f50 ("drm/i915: Reserve some kernel space per vm")
> Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
> Cc: Andrzej Hajda <andrzej.hajda@intel.com>
> Cc: Chris Wilson <chris.p.wilson@linux.intel.com>
> Cc: Jonathan Cavitt <jonathan.cavitt@intel.com>
> Cc: Nirmoy Das <nirmoy.das@intel.com>

I forgot to add stable here:

Cc: <stable@vger.kernel.org> # v6.8+

Sorry about that!

Andi

