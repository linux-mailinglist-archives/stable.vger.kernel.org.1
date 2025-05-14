Return-Path: <stable+bounces-144457-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F608AB796D
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 01:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C08FF4C4264
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 23:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E508B203706;
	Wed, 14 May 2025 23:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aLeh2Mx+"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168CE4C9F;
	Wed, 14 May 2025 23:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747265430; cv=none; b=ufPM2Ndka25jD2cg71Xbf53LuvzYtBkC+TXR/jC7pLzQMQ+MHvIKGxcd9EXRpnMDv5FT9HHiG6iqiKbfxwWqmj5nHCFnXbuN60ONEP7I7zz+UfSOqQLyby5LRoAgKBCHcQkH1qBxYMpBTYU4ZDLusiktN4St/rsnci8fNd7gaTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747265430; c=relaxed/simple;
	bh=Zbdtc9nGX/BlLp05VNDP53lvcblNsMgnV9hUlUHBtCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hRBLsXK5bx8HzQ2TSo+OZKA7SvGeHjuzEouqTZgw/ewcazE65mbtzbCjx3AvtL4eGhiZ1Vj7YZJ72dH9kGC/9lRs3aaohePmtDzauezBNYO3S8QkJFSXOlTzMTHS2YXFAcqksrri/PGUt5PAKB/rguw+vcJEKIzUifaRFOkezkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aLeh2Mx+; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747265429; x=1778801429;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Zbdtc9nGX/BlLp05VNDP53lvcblNsMgnV9hUlUHBtCY=;
  b=aLeh2Mx+6FJXryHNeXahlZ0skppzFvMGbTulb920/0fjk5L7vFqTvq4F
   OZTLpWyl6QAOHFpy7Wiu+oml6bHuu+afBwrU6J+J1JYZLABcgsfVviFjY
   muZgeB1WV5VtZiq7RN/xyesekFuB7zYCpP6Os6AZLjGEVMEFP3soppszE
   jmqHhsamVv4VMfT5gpPgGWeZUMVhWBhR39g1mlP5Z8Al1kOUAkX2Ywycu
   h8YFzWMAkYqrJyn8EjKAXk7AQITxxV5kTUDPIHcSqQz95G919ubcuOuRK
   6A/N1rBDwSEwY3MQPKgWAa1B7eCzcK55pIS8i5pR12EqJwnl7lCBnXo9V
   A==;
X-CSE-ConnectionGUID: CUiP9ghbTSC8f2NPHwxzUQ==
X-CSE-MsgGUID: 6y00/+28Rc6IP/J1tyMKWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="49120381"
X-IronPort-AV: E=Sophos;i="6.15,289,1739865600"; 
   d="scan'208";a="49120381"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 16:30:28 -0700
X-CSE-ConnectionGUID: 9FjKg8P5Te63BRR62lCjag==
X-CSE-MsgGUID: qlyIhVq3TIu/p+ImOQ56dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,289,1739865600"; 
   d="scan'208";a="137911897"
Received: from mfrick-mobl2.amr.corp.intel.com (HELO desk) ([10.125.146.12])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 16:30:28 -0700
Date: Wed, 14 May 2025 16:30:22 -0700
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
Message-ID: <20250514233022.t72lijzi4ipgmmpj@desk>
References: <20250514220835.370700-1-surajjs@amazon.com>
 <20250514222507.GKaCUYQ9TVadHl7zMv@fat_crate.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514222507.GKaCUYQ9TVadHl7zMv@fat_crate.local>

On Thu, May 15, 2025 at 12:25:07AM +0200, Borislav Petkov wrote:
> On Wed, May 14, 2025 at 03:08:35PM -0700, Suraj Jitindar Singh wrote:
> > -	if (x86_return_thunk != __x86_return_thunk)
> > +	/*
> > +	 * There can only be one return thunk enabled at a time, so issue a
> > +	 * warning when overwriting it. retbleed_return_thunk is a special case
> > +	 * which is safe to be overwritten with srso_return_thunk since it
> > +	 * provides a superset of the functionality and is handled correctly in
> > +	 * entry_untrain_ret().
> > +	 */
> > +	if ((x86_return_thunk != __x86_return_thunk) &&
> > +	    (thunk != srso_return_thunk ||
> > +	     x86_return_thunk != retbleed_return_thunk))
> 
> Instead of making this an unreadable conditional, why don't we ...
> 
> >  		pr_warn("x86/bugs: return thunk changed\n");
> 
> ... turn this into a
> 
> 	pr_info("set return thunk to: %ps\n", ...)
> 
> and simply say which thunk was set?

This was discussed during the mitigation, and pr_warn() was chosen because
it was not obvious that srso mitigation also mitigates retbleed. (On a
retrospect, there should have been a comment about it).

The conclusion was to make the srso and retbleed relationship clear and
then take care of the pr_warn().

