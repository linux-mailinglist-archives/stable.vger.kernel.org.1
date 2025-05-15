Return-Path: <stable+bounces-144547-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60983AB8DF5
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 19:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 401B51892CAA
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 17:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89268253B68;
	Thu, 15 May 2025 17:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gxobAHzS"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAC7146593;
	Thu, 15 May 2025 17:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747330726; cv=none; b=GF8V1gkwchEhJl/GDAB3G1oc/9BFtcl1LeFhiaZZpzhtpOwMmRmKGh9kCo+w9N3JeTOTb5RK6hfupFth3zQY58dUKMOowpaeMk7XRQLQrxiqim5F70gRPAsGxL/BrR1rEtjKHekrCsSctnzQuMTE2GVeE7Zu4LE65glW6zoRgY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747330726; c=relaxed/simple;
	bh=JiwD1Gy0uaW7HHY1vaYnzNHkDtpWS+jR3kWTTOq6+gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fj7jj4fPnPtPanUO/QmJladDgHyVKVTzgsZJT8UtKCixJ+bF8WfsYr4zHzXcSVYUnxrc24auMo2atMX6J22RaK7mzG2MouytXhwJr+DUrm9M5ud6tNGICuC8AOPuH5mVGG0dMTc2Y+FfljmA3Ce+YswSpXoe+gWd6aWS+i1b3os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gxobAHzS; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747330725; x=1778866725;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JiwD1Gy0uaW7HHY1vaYnzNHkDtpWS+jR3kWTTOq6+gc=;
  b=gxobAHzS0IEyITKdC1Vs8p9u6B51CXmfMEwmsVNc7ekQTR9rj1y0Z1e4
   kAiJEQxoEjADTJFeR+5liC01owIooKpcfJitvtIjUjyYq5Mse23pxWe5g
   nzjF7okxsX64wr2tzfyqtfRq7Zbh0jxxaNWBK5QNiyZuW4vrbXlIghTn/
   huhWryYfFhI1awoR98Ra5KSqrPlQufein49GjKusoucYH3WSxhtTzcpeS
   sl1mrXhlpkX4GOe5weSembVhJy2d/G4tj9lQ9Ixnyz7xyihB3OuT4F6H9
   mBVz9fZ1Nd0l8VdyWpjdYgiB2+3ubyLdZLUaB2wy7XAZkllK2u8Yv3VY4
   Q==;
X-CSE-ConnectionGUID: JlPCsdQkTuiMgZS7w/ZzJQ==
X-CSE-MsgGUID: Yi6MkxjTSCuh+qAmgaw4jg==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="59922724"
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; 
   d="scan'208";a="59922724"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 10:38:44 -0700
X-CSE-ConnectionGUID: 9Eq5Gmi5SFGKOKhierxPuw==
X-CSE-MsgGUID: gf7gXwIWRtyKXu7W3JQPsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; 
   d="scan'208";a="139328056"
Received: from gkhatri-mobl.amr.corp.intel.com (HELO desk) ([10.125.146.13])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 10:38:43 -0700
Date: Thu, 15 May 2025 10:38:30 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Suraj Jitindar Singh <surajjs@amazon.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH] x86/bugs: Don't warn when overwriting
 retbleed_return_thunk with srso_return_thunk
Message-ID: <20250515173830.uulahmrm37vyjopx@desk>
References: <20250514220835.370700-1-surajjs@amazon.com>
 <20250514222507.GKaCUYQ9TVadHl7zMv@fat_crate.local>
 <20250514233022.t72lijzi4ipgmmpj@desk>
 <20250515093652.GBaCW1tARiE2jkVs_d@fat_crate.local>
 <20250515170633.sn27zil2wie54yhn@desk>
 <20250515172355.GIaCYjK_fz-n71Aruz@fat_crate.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515172355.GIaCYjK_fz-n71Aruz@fat_crate.local>

On Thu, May 15, 2025 at 07:23:55PM +0200, Borislav Petkov wrote:
> On Thu, May 15, 2025 at 10:06:33AM -0700, Pawan Gupta wrote:
> > As I said above, a mitigation unintentionally make another mitigation
> > ineffective.
> 
> I actually didn't need an analysis - my point is: if you're going to warn
> about it, then make it big so that it gets caught.
> 
> > Yes, maybe a WARN_ON() conditional to sanity checks for retbleed/SRSO.
> 
> Yes, that.
> 
> At least.
> 
> The next step would be if this whole "let's set a thunk without overwriting
> a previously set one" can be fixed differently.
> 
> For now, though, the *least* what should be done here is catch the critical
> cases where a mitigation is rendered ineffective. And warning Joe Normal User
> about it doesn't bring anything. We do decide for the user what is safe or
> not, practically. At least this has been the strategy until now.
> 
> So the goal here should be to make Joe catch this and tell us to fix it.
> 
> Makes sense?

Absolutely makes sense.

Suraj, do want to revise this patch? Or else I can do it too.

