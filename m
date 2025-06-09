Return-Path: <stable+bounces-152022-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6177EAD1EE6
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 15:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C7671884A67
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 13:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A60BEEAB;
	Mon,  9 Jun 2025 13:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bix19D6u"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F04D528
	for <stable@vger.kernel.org>; Mon,  9 Jun 2025 13:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749475900; cv=none; b=RtffRvD70HmBhKXLcFq02Z9VoMAzNSWCeSdPLUW3shmibkcYSp0lvlRgDvW4CcsJfzv0VvcjeG/X4VHvjNxkKX8uTglLvJu6kX91akAyPFLeJkgRRyGLmIlrDHUkNK6Lq1RONkzH1gZp8Ne5K8dYyWe7tPBajR5Ddf3XTQnWvB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749475900; c=relaxed/simple;
	bh=CilfPUBuQdZJdhPOBJMjCYScKL2a/bvF0k7WK28n5fA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dE9jE1BjcycaghXTqEg0rGQcOVTtpys2j6BIY5QhOCI8lVFX2Rqnsnopt3Qp6SUGW4VQk+s+oA64ToRchGXgX3hkeGLV+Nmi169swIavZqm4ThZDg7U6B5pHey/MCxeeUUbdkb3r/56qZY9+wlZv4gFU+7dqPV4HRn1oKzFfJoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bix19D6u; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749475898; x=1781011898;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CilfPUBuQdZJdhPOBJMjCYScKL2a/bvF0k7WK28n5fA=;
  b=Bix19D6uSoawIDSpSwCSloGaEbH8v4tnirQb8JVJnqMYzK86jgaVxW1J
   OSu2H70jFQwhO6oEfUzwk/JvCCki+xu7l2pD3PIBdBGHbchsMhYJa4PDx
   NqV+DO1HRgvAYDcTGrIrUCctxFn1dhv7UHtMnfC0ufDcVdwS9PCFEpGpl
   /rxqO5SwJw8kYS/bn1EskdU6AtsnuGH7zt6OY/hHWZikBTpkV45Z/rgoE
   k1E1Qna48Z8ppDiKc4h0aGa9OgxCPkNWfkpWUPUmFlYYijUfRKkatZQT8
   TXc1MnQhdUbvOB5OyV/2b9EnC0wUUeAPOEWFjTvE7SAQo/68IzIPiA7H+
   g==;
X-CSE-ConnectionGUID: Aua1cEgVSEOdIhOoSM9MCg==
X-CSE-MsgGUID: lE/FXhFISzKCbHeMmY08BQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="39174409"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; 
   d="scan'208";a="39174409"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 06:31:38 -0700
X-CSE-ConnectionGUID: aQpBzy3VTu+T3nbxS5+0fQ==
X-CSE-MsgGUID: jspV/qQNTRuO6L1R2bvLeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; 
   d="scan'208";a="183695496"
Received: from clustinx-mobl.amr.corp.intel.com (HELO desk) ([10.125.146.43])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 06:31:37 -0700
Date: Mon, 9 Jun 2025 06:31:30 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 5.15 v3 00/16] ITS mitigation
Message-ID: <20250609133130.ieub7pgnestuosal@desk>
References: <20250516-its-5-15-v3-0-16fcdaaea544@linux.intel.com>
 <aEQHkmGXOel3BcOF@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEQHkmGXOel3BcOF@eldamar.lan>

On Sat, Jun 07, 2025 at 11:34:10AM +0200, Salvatore Bonaccorso wrote:
> Hi Pawan,
> 
> On Fri, May 16, 2025 at 04:59:28PM -0700, Pawan Gupta wrote:
> > v3:
> > - Added patches:
> >   x86/its: Fix build errors when CONFIG_MODULES=n
> >   x86/its: FineIBT-paranoid vs ITS
> > 
> > v2:
> > - Added missing patch to 6.1 backport.
> > 
> > This is a backport of mitigation for Indirect Target Selection (ITS).
> > 
> > ITS is a bug in some Intel CPUs that affects indirect branches including
> > RETs in the first half of a cacheline. Mitigation is to relocate the
> > affected branches to an ITS-safe thunk.
> > 
> > Below additional upstream commits are required to cover some of the special
> > cases like indirects in asm and returns in static calls:
> > 
> > cfceff8526a4 ("x86/speculation: Simplify and make CALL_NOSPEC consistent")
> > 052040e34c08 ("x86/speculation: Add a conditional CS prefix to CALL_NOSPEC")
> > c8c81458863a ("x86/speculation: Remove the extra #ifdef around CALL_NOSPEC")
> > d2408e043e72 ("x86/alternative: Optimize returns patching")
> > 4ba89dd6ddec ("x86/alternatives: Remove faulty optimization")
> > 
> > [1] https://github.com/torvalds/linux/commit/6f5bf947bab06f37ff931c359fd5770c4d9cbf87
> 
> AFAICS there are no backports yet for as well older stable series than
> 5.15, in particular 5.10.y (which is used in Debian bullseye yet). Are
> you planning to make as well backports for the 5.10.y stable series?

I wasn't planning it earlier, but now that there is a good reason, I will
work on the backport for 5.10.

Thanks,
Pawan

