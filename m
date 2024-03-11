Return-Path: <stable+bounces-27398-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7CB878867
	for <lists+stable@lfdr.de>; Mon, 11 Mar 2024 19:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D04DF286977
	for <lists+stable@lfdr.de>; Mon, 11 Mar 2024 18:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4948955C3A;
	Mon, 11 Mar 2024 18:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Th/8hs4K"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361335579A
	for <stable@vger.kernel.org>; Mon, 11 Mar 2024 18:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710183310; cv=none; b=DG0DIRLQp9Dn5opX3SF+JpeeDZuNTiM9Xw90bMnk/45doxJDcUldxSWB7joUXd4FBsFFlP3KNRxwF/ydn/u2uXKvgNzhCSlLEwCGgxbMlbxXZ4ygXuDVBgB15+csjh216dFZ8S9cuLQhmZsfFHrOU5a6BkKSuSrwBgbA7jf25YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710183310; c=relaxed/simple;
	bh=XVhOAKhHl9shPUn+Cyswu6Us6TrdEOD5kDxyQW/Be8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oTrI5O41GsHRV9VDMP0mT8z5H9k07iCxfRoHchOUEn5uiDeVnSC3/QYZAWm8HkJV6I5FTSCbg1cT8LCv5XYFpNtcRazy8T9AuKYco1onnngoiIHVaJYNhfIh1w2MfRIH5AlkRoO6ddEB1cyjmfvTg5yM8tGdQwTuFYbWoVrOH0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Th/8hs4K; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710183308; x=1741719308;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XVhOAKhHl9shPUn+Cyswu6Us6TrdEOD5kDxyQW/Be8c=;
  b=Th/8hs4KdLtEG715Qu3n9P79NuBJvROEOXNPNUfKwkTgDCv9EZLP4MJT
   lfZVD5GVH3RiexlbCB504iF4mP9uCp7us6CTJAHXuar+ZamKC0hnmAMig
   3DAkGcsHMRlpNT1Om4eD657lKfzVWixTFWSjSaHOubLCW0GVameZYIIh/
   dvPr5naJuBUSeZrCz/URRY7UxV5YF7CruF38Ydyfd8CFLfzNk5x6aQhmO
   K9yS77J+zUOOAmYSSDZn+4lAtmvXGxNVbmD3g75NirmSGMsIkAHg9eo4b
   SdACxAidnYvjfpGzQBDxaPpEI9CqCDRMGse9HC9vzFiQs+ZaFyFKtpgKv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="22323460"
X-IronPort-AV: E=Sophos;i="6.07,117,1708416000"; 
   d="scan'208";a="22323460"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 11:55:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,117,1708416000"; 
   d="scan'208";a="11336266"
Received: from psdamle-mobl1.amr.corp.intel.com (HELO desk) ([10.255.229.113])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 11:55:07 -0700
Date: Mon, 11 Mar 2024 11:55:02 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "H. Peter Anvin (Intel)" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>,
	Alyssa Milburn <alyssa.milburn@intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [RESEND][PATCH 5.15.y 0/7] Delay VERW 5.15.y backport
Message-ID: <20240311185502.dgwi3jy2br23bnnv@desk>
References: <20240304-delay-verw-backport-5-15-y-v1-0-fd02afc00fec@linux.intel.com>
 <20240311183535.7zmt7ttqisn5q6es@desk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311183535.7zmt7ttqisn5q6es@desk>

On Mon, Mar 11, 2024 at 11:35:38AM -0700, Pawan Gupta wrote:
> On Mon, Mar 04, 2024 at 09:01:52PM -0800, Pawan Gupta wrote:
> > This is the backport of recently upstreamed series that moves VERW
> > execution to a later point in exit-to-user path. This is needed because
> > in some cases it may be possible for data accessed after VERW executions
> > may end into MDS affected CPU buffers. Moving VERW closer to ring
> > transition reduces the attack surface.
> > 
> > - The series includes a dependency commit f87bc8dc7a7c ("x86/asm: Add
> >   _ASM_RIP() macro for x86-64 (%rip) suffix").
> > 
> > - Patch 2 includes a change that adds runtime patching for jmp (instead
> >   of verw in original series) due to lack of rip-relative relocation
> >   support in kernels <v6.5.
> > 
> > - Fixed warning:
> >   arch/x86/entry/entry.o: warning: objtool: mds_verw_sel+0x0: unreachable instruction.
> > 
> > - Resolved merge conflicts in:
> > 	swapgs_restore_regs_and_return_to_usermode in entry_64.S.
> > 	__vmx_vcpu_run in vmenter.S.
> > 	vmx_update_fb_clear_dis in vmx.c.
> > 
> > - Boot tested with KASLR and KPTI enabled.
> > 
> > - Verified VERW being executed with mitigation ON, and not being
> >   executed with mitigation turned OFF.
> > 
> > To: stable@vger.kernel.org
> > 
> > Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> > ---
> > H. Peter Anvin (Intel) (1):
> >       x86/asm: Add _ASM_RIP() macro for x86-64 (%rip) suffix
> > 
> > Pawan Gupta (5):
> >       x86/bugs: Add asm helpers for executing VERW
> >       x86/entry_64: Add VERW just before userspace transition
> >       x86/entry_32: Add VERW just before userspace transition
> >       x86/bugs: Use ALTERNATIVE() instead of mds_user_clear static key
> >       KVM/VMX: Move VERW closer to VMentry for MDS mitigation
> > 
> > Sean Christopherson (1):
> >       KVM/VMX: Use BT+JNC, i.e. EFLAGS.CF to select VMRESUME vs. VMLAUNCH

[Resending this. Sorry, last time my mutt aliases didn't resolve
correctly for some reason.]

Could this and below backports be queue up?

5.10.y https://lore.kernel.org/stable/20240305-delay-verw-backport-5-10-y-v1-0-50bf452e96ba@linux.intel.com/
5.4.y  https://lore.kernel.org/stable/20240226122237.198921-1-nik.borisov@suse.com/

Just FYI.. this series is already in stable trees for 6.1, 6.6, 6.7.

