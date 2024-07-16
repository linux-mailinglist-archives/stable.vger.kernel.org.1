Return-Path: <stable+bounces-59400-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7143393236C
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 11:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E5492848B3
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 09:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D845C197A61;
	Tue, 16 Jul 2024 09:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lvlxd0wm"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4FE2E832
	for <stable@vger.kernel.org>; Tue, 16 Jul 2024 09:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721123705; cv=none; b=YDBj5mB5VT80L4jgKSdSlhkh1m1hDEJzkPS3aj2fMUz6AookdpLHPSwxpr7+AqRO5QklIfQui0DiAzp8nj7v18861+s9Y/xZc2sGf+SP5L3zdHgWQPDa0MwSlX4pdMRZP0tJxZco3mkogmjlJ96BFpNJth479UD6LUSH/6KVFjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721123705; c=relaxed/simple;
	bh=ds1biXbXIWkTSsdB0y9iUmwLmE9tUaNFwkZkwt+FOGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pUM310PMIr1O1NKMT2nmQ8ES+e6MTRwBk5M41dh3y2DNOR2r0hIOaAtSNqLlNKPNF0UcmQ/7/sWmegjHqTi7Ofw0KgamQUZ4uu9Xp+UfoZR76XswBgtAcfPyOaB7DGts9qoILPbCm9BS8T8cH9fjiv170Q0qaZUrrjh1xuxaHuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lvlxd0wm; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721123704; x=1752659704;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ds1biXbXIWkTSsdB0y9iUmwLmE9tUaNFwkZkwt+FOGU=;
  b=lvlxd0wmwrcBJipf6HvSEKm46aI53JfBhsrrCIiIHeJRnLeCW9g8PKTQ
   fgM366QBM8eesRhLopksluSriv3L8LWwNhOVhxrpGaaqKeurywdnyd8j9
   EGHbwE49bAgNC10p4sZLwf9nq91buTE4h9WjIdtVAHivRJaII7+aFlZSk
   mExlMeiUx29i0jTH0q7mLApZGqyCNvB1dQk0ww1tqWFHGk/IYn26xDLY+
   OxTt8G08m0Own1pAwEVQMwQ8q2qkkRtID+40q5ASU3VSOp39F36J6K1K4
   S34aUb8jdwyAukls2wPEKolCVWpscvZRtxxK6/bp+RVvE8ZInsZ+/+mrU
   Q==;
X-CSE-ConnectionGUID: 1uZ326ttSQeaE7PiAom46g==
X-CSE-MsgGUID: WGrq95htQEqUhZYsjPP4qw==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="41075126"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="41075126"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2024 02:55:03 -0700
X-CSE-ConnectionGUID: 4jR0Id70RXCZxcFhe+VTUA==
X-CSE-MsgGUID: UoH08PBHT4Gu1d5QT37C0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="80637535"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO intel.com) ([10.245.246.212])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2024 02:55:01 -0700
Date: Tue, 16 Jul 2024 11:54:56 +0200
From: Andi Shyti <andi.shyti@linux.intel.com>
To: Nitin Gote <nitin.r.gote@intel.com>
Cc: chris.p.wilson@intel.com, tursulin@ursulin.net,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	nirmoy.das@intel.com, janusz.krzysztofik@linux.intel.com,
	Chris Wilson <chris.p.wilson@linux.intel.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] drm/i915/gt: Do not consider preemption during
 execlists_dequeue for gen8
Message-ID: <ZpZDcGxmwSQ3ze8t@ashyti-mobl2.lan>
References: <20240711163208.1355736-1-nitin.r.gote@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711163208.1355736-1-nitin.r.gote@intel.com>

Hi Nitin,

On Thu, Jul 11, 2024 at 10:02:08PM +0530, Nitin Gote wrote:
> We're seeing a GPU HANG issue on a CHV platform, which was caused by
> bac24f59f454 ("drm/i915/execlists: Enable coarse preemption boundaries for gen8").
> 
> Gen8 platform has only timeslice and doesn't support a preemption mechanism
> as engines do not have a preemption timer and doesn't send an irq if the
> preemption timeout expires. So, add a fix to not consider preemption
> during dequeuing for gen8 platforms.
> 
> v2: Simplify can_preempt() function (Tvrtko Ursulin)
> 
> v3:
>  - Inside need_preempt(), condition of can_preempt() is not required
>    as simplified can_preempt() is enough. (Chris Wilson)
> 
> Fixes: bac24f59f454 ("drm/i915/execlists: Enable coarse preemption boundaries for gen8")
> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/11396
> Suggested-by: Andi Shyti <andi.shyti@intel.com>
> Signed-off-by: Nitin Gote <nitin.r.gote@intel.com>
> Cc: Chris Wilson <chris.p.wilson@linux.intel.com>
> CC: <stable@vger.kernel.org> # v5.2+

with the commit message fixed and the checkpatch as well, merged
to drm-intel-gt-next.

Thank you,
Andi

