Return-Path: <stable+bounces-27343-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F19A0878774
	for <lists+stable@lfdr.de>; Mon, 11 Mar 2024 19:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92BE91F21966
	for <lists+stable@lfdr.de>; Mon, 11 Mar 2024 18:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BA755C3A;
	Mon, 11 Mar 2024 18:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rp68y9y2"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0503F55C08
	for <stable@vger.kernel.org>; Mon, 11 Mar 2024 18:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182144; cv=none; b=T6C7RE4i9bVhgZBFIwSv21diFWWZc0mArZ7TbicoYkbP5esMOwSqp41B70izOnulG21xB5GdmvHzI2qNWY7UB8q8I3OlDiGQHMrJ3mnihsymcXvfshv9x1sRS3VjdtaoY57gxDwBvjRBKf1qT/aE65NgKsKYnt8Sw8ufrCLGxu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182144; c=relaxed/simple;
	bh=e8bU4wKPJrbJMns7//GeuypNWldumZT7uYDqqFiSqcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nMsUeCygc+tbrvOD5wea+JrizJE47IjVJ5ITFaxzd+GoNachPAN290cOp/4s9MTb+bCdYLas808th3LghGPO6o3PnMCm8bt1APAP4Vvf1ZMxYrJgesreghhWYYcZAoiIT2JaN4mZ3vIz1dVIutFKHKe4yMG29pswkz7iFLdLoqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rp68y9y2; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710182143; x=1741718143;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e8bU4wKPJrbJMns7//GeuypNWldumZT7uYDqqFiSqcw=;
  b=Rp68y9y27LugenqBNXuu9dFOZ+H3P3payF9JxlUmZ4B6ykH+YYaSirZo
   qnpm1nlX8PAR3b3w/Sn6Ecug5Z7saavQ1+XwH87FwLjry2leMo+wnIdyU
   9VemuOpFZXWYjra+YAaNSAwyGcuxPxx04BCFl7YQeC4IWqa1cbl9B0I08
   E3gDc7XSalWnfL/Cv6gSk3sREgW/9aSa9xFyvjzS0/YLJrjdif8hDTt/r
   CUcfBpBwmaSkv1ERCfWttu8JL611gDcCupbi1aNL3uUQA3LK7jIv6Ix38
   XYGO5WKkPR08t8NsP0aGY84R6Vt2wglzibl5wWiGqD3KuUW/xRJXEGgGX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="7811854"
X-IronPort-AV: E=Sophos;i="6.07,117,1708416000"; 
   d="scan'208";a="7811854"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 11:35:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,117,1708416000"; 
   d="scan'208";a="42239361"
Received: from psdamle-mobl1.amr.corp.intel.com (HELO desk) ([10.255.229.113])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 11:35:41 -0700
Date: Mon, 11 Mar 2024 11:35:35 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org,
	sasha.levin@desk.smtp.subspace.kernel.org,
	gregkh@desk.smtp.subspace.kernel.org
Cc: "H. Peter Anvin (Intel)" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>,
	Alyssa Milburn <alyssa.milburn@intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [PATCH 5.15.y 0/7] Delay VERW 5.15.y backport
Message-ID: <20240311183535.7zmt7ttqisn5q6es@desk>
References: <20240304-delay-verw-backport-5-15-y-v1-0-fd02afc00fec@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304-delay-verw-backport-5-15-y-v1-0-fd02afc00fec@linux.intel.com>

On Mon, Mar 04, 2024 at 09:01:52PM -0800, Pawan Gupta wrote:
> This is the backport of recently upstreamed series that moves VERW
> execution to a later point in exit-to-user path. This is needed because
> in some cases it may be possible for data accessed after VERW executions
> may end into MDS affected CPU buffers. Moving VERW closer to ring
> transition reduces the attack surface.
> 
> - The series includes a dependency commit f87bc8dc7a7c ("x86/asm: Add
>   _ASM_RIP() macro for x86-64 (%rip) suffix").
> 
> - Patch 2 includes a change that adds runtime patching for jmp (instead
>   of verw in original series) due to lack of rip-relative relocation
>   support in kernels <v6.5.
> 
> - Fixed warning:
>   arch/x86/entry/entry.o: warning: objtool: mds_verw_sel+0x0: unreachable instruction.
> 
> - Resolved merge conflicts in:
> 	swapgs_restore_regs_and_return_to_usermode in entry_64.S.
> 	__vmx_vcpu_run in vmenter.S.
> 	vmx_update_fb_clear_dis in vmx.c.
> 
> - Boot tested with KASLR and KPTI enabled.
> 
> - Verified VERW being executed with mitigation ON, and not being
>   executed with mitigation turned OFF.
> 
> To: stable@vger.kernel.org
> 
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> ---
> H. Peter Anvin (Intel) (1):
>       x86/asm: Add _ASM_RIP() macro for x86-64 (%rip) suffix
> 
> Pawan Gupta (5):
>       x86/bugs: Add asm helpers for executing VERW
>       x86/entry_64: Add VERW just before userspace transition
>       x86/entry_32: Add VERW just before userspace transition
>       x86/bugs: Use ALTERNATIVE() instead of mds_user_clear static key
>       KVM/VMX: Move VERW closer to VMentry for MDS mitigation
> 
> Sean Christopherson (1):
>       KVM/VMX: Use BT+JNC, i.e. EFLAGS.CF to select VMRESUME vs. VMLAUNCH

Could this and below backports be queue up?

5.10.y https://lore.kernel.org/stable/20240305-delay-verw-backport-5-10-y-v1-0-50bf452e96ba@linux.intel.com/
5.4.y  https://lore.kernel.org/stable/20240226122237.198921-1-nik.borisov@suse.com/

Just FYI.. this series is already in stable trees for 6.1, 6.6, 6.7.

Thanks,
Pawan

