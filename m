Return-Path: <stable+bounces-28500-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC096881709
	for <lists+stable@lfdr.de>; Wed, 20 Mar 2024 19:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 700531F23305
	for <lists+stable@lfdr.de>; Wed, 20 Mar 2024 18:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2C66AFB9;
	Wed, 20 Mar 2024 18:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DBEDFaCH"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B986A8BE
	for <stable@vger.kernel.org>; Wed, 20 Mar 2024 18:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710957792; cv=none; b=EF9M6+bF7fks64ddnO3dtHNRL79iEXaYRs4FwFaD2nzWsEuu1AV3GDX0kJJN8tZHL5YnF6pmdcQ5cGPkaSuZcS4BvwpoIP7VJuI+y5cIS6nBFK0gdSVz3BbZyofld9R10V5YIO46M7wKvUW3NRjixsgWFraiA7k8RFoam0JQ2/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710957792; c=relaxed/simple;
	bh=LK2peCM+6ulC4Y1PdKmTswKWjTlonY5Ab0f7U8l24bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z9+l3ViPicQf9znmwAUhOWqcPGXvP+BXrbviXcYND1EY7aVjC2Z2Fk9jEzASC4NYk/doYtHkmEEnNwegv3SfATmwuTLDh/4tn/AuNj5/E3ghiCv4FKLhpudfYPdldljW6AI2tyIwaRip1Nvr4+VUqODQWAgeObGkLqHw+KY99+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DBEDFaCH; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710957791; x=1742493791;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LK2peCM+6ulC4Y1PdKmTswKWjTlonY5Ab0f7U8l24bg=;
  b=DBEDFaCHka0A5i5va4M4CxW12JN5KyM26L6t2WV26lFn38fMmSSveStv
   z+9pCEUIkeWmGyOET1Y0mkc51EY28NXWYmnlgv1eBcdd5H1df8I0lD2YR
   nEtWnSbCV02z/E9UYmAfx5n5bLMEiB/8DolU8ZVm8kpnqPv/t8Zd8lPrc
   iXhoGNZ3+Ugo0HCnPVQHUReqail5WsAhF/6k0/M8Oyx8R8oCD1DUbHtNm
   gaqrJl+Mma4febg6vDvdtdaVxp3YFjalOjQ6KyS+LdTRjy3NrdjWY7/5U
   AyBxSq4nyg7QQ3gdgwT4du/YdbrZmtoSo0eCTPaaxtUlho8noT6GsOZ1P
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="28376201"
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="28376201"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 11:03:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="37340658"
Received: from unknown (HELO intel.com) ([10.247.118.186])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 11:02:58 -0700
Date: Wed, 20 Mar 2024 19:02:52 +0100
From: Andi Shyti <andi.shyti@linux.intel.com>
To: Tvrtko Ursulin <tursulin@ursulin.net>
Cc: Andi Shyti <andi.shyti@linux.intel.com>,
	intel-gfx <intel-gfx@lists.freedesktop.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	Chris Wilson <chris.p.wilson@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	John Harrison <John.C.Harrison@intel.com>, stable@vger.kernel.org,
	Andi Shyti <andi.shyti@kernel.org>
Subject: Re: [PATCH v6 0/3] Disable automatic load CCS load balancing
Message-ID: <ZfskzEC_ToR9o-Xc@ashyti-mobl2.lan>
References: <20240313201955.95716-1-andi.shyti@linux.intel.com>
 <Zfr7hPs_VAUkTNTX@ashyti-mobl2.lan>
 <3fe26c42-cc34-42b2-a5cc-21a6a9468b4e@ursulin.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fe26c42-cc34-42b2-a5cc-21a6a9468b4e@ursulin.net>

Hi Tvrtko,

On Wed, Mar 20, 2024 at 03:40:18PM +0000, Tvrtko Ursulin wrote:
> On 20/03/2024 15:06, Andi Shyti wrote:
> > Ping! Any thoughts here?
> 
> I only casually observed the discussion after I saw Matt suggested further
> simplifications. As I understood it, you will bring back the uabi engine
> games when adding the dynamic behaviour and that is fine by me.

yes, the refactoring suggested by you will come later.

Thanks,
Andi

