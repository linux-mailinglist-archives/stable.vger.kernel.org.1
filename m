Return-Path: <stable+bounces-59150-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9993892EEFE
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 20:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50D231F223E1
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 18:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9B316DEC8;
	Thu, 11 Jul 2024 18:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ByKtwIve"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A81D26AEC;
	Thu, 11 Jul 2024 18:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720722993; cv=none; b=F0w3Y0kyrgE2D9piPDVM+oIQGqlE/d5fVKc6BuRDZx9NXaTpZPDRJ0+2rL9wU704nzax2k3tgNvVyJzXrwgN8Ee39MCf/uP9tDWn5qvRgoIA6BZLNvXjaxMkxZr6pvDwWoYLgSkQ1EDwW3uPTf3TCcXX6QBTz5RuGmgBrR4v6lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720722993; c=relaxed/simple;
	bh=7DmaJalLbfP14u8GDuE6W1F6/LmCBVJUh9IBvr3Yaok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UXtjqVWYFkuGjBMd0o1DZer7PQ/p/Qy+egAjxOm3JIdyR2YkLuE2JiTC9dR2iVbO2f8peF1zWi5hVpCNvRj1Yyxmg9KcKMWA15AECWr/LkDQsWiltqs2OVdUNeqHFTeQr2GvYs/8ewCHtV39Ssg+ftmQ7O2LMVw8himsPQT/m48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ByKtwIve; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720722993; x=1752258993;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7DmaJalLbfP14u8GDuE6W1F6/LmCBVJUh9IBvr3Yaok=;
  b=ByKtwIveOWyqMcEj/qxCHNv8xn2Vc+t39M0Y0pj0M1GflY+iRtrVCoO+
   Y6QOYSYouCKsF9838cENp4C1HPuDnWH77NO4LgsF06CqoyLFQPvaTiiuF
   F9p5h0OnlVQWW6U5Nw+iiaDoZ/t/BI83ZqDnYCFvy8GnZPiYaLtHuLsh9
   9zHkbR5sSa0xSuAVY8WETIRSgWCSX1Dk4NmfP+G/uKp+wA7breikKQ32u
   iQhjZxR4If7LcTLbVUlpTocTF5EwH8w9cEO0aL4JFcHem7WlEF1tV2WzK
   2DQ3HH4wnAR1UhBjM6sqtYymkFtHNO7b3bBy0OuGJ7rzgJWNbjRpBf51w
   Q==;
X-CSE-ConnectionGUID: LllwidnoT2igg5T/iUJbRA==
X-CSE-MsgGUID: db+7gA8PQkiFZqhTFx+z1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="29283451"
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="29283451"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 11:36:32 -0700
X-CSE-ConnectionGUID: ZJM7WQXDS/WdtprzeOT4xA==
X-CSE-MsgGUID: PWj/ztAAS5iUBVssWWqbMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="53047385"
Received: from tmsagapo-mobl2.amr.corp.intel.com (HELO desk) ([10.209.8.238])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 11:36:31 -0700
Date: Thu, 11 Jul 2024 11:36:20 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Robert Gill <rtgill82@gmail.com>,
	Jari Ruusu <jariruusu@protonmail.com>,
	Brian Gerst <brgerst@gmail.com>,
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>,
	antonio.gomez.iglesias@linux.intel.com,
	daniel.sneddon@linux.intel.com, stable@vger.kernel.org
Subject: Re: [PATCH v4] x86/entry_32: Use stack segment selector for VERW
 operand
Message-ID: <20240711183620.j5di5gnsn6bt2ppw@desk>
References: <20240710-fix-dosemu-vm86-v4-1-aa6464e1de6f@linux.intel.com>
 <20240711090329.GI4587@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711090329.GI4587@noisy.programming.kicks-ass.net>

On Thu, Jul 11, 2024 at 11:03:29AM +0200, Peter Zijlstra wrote:
> On Wed, Jul 10, 2024 at 12:06:47PM -0700, Pawan Gupta wrote:
> > +/*
> > + * Safer version of CLEAR_CPU_BUFFERS that uses %ss to reference VERW operand
> > + * mds_verw_sel. This ensures VERW will not #GP for an arbitrary user %ds.
> > + */
> > +.macro CLEAR_CPU_BUFFERS_SAFE
> > +	ALTERNATIVE "jmp .Lskip_verw\@", "", X86_FEATURE_CLEAR_CPU_BUF
> > +	verw	%ss:_ASM_RIP(mds_verw_sel)
> > +.Lskip_verw\@:
> > +.endm
> 
> I know this is somewhat of a common pattern, but I think it is silly in
> this case. Since we already have the ALTERNATIVE() why not NOP the one
> VERW instruction instead?
> 
> That is,
> 
> 	ALTERNATIVE("", "verw %ss:_ASM_RIP(mds_verw_sel)", X86_FEATURE_CLEAR_CPU_BUF)

Will do, thanks.

