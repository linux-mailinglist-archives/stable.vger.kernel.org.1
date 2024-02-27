Return-Path: <stable+bounces-23829-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32047868A1B
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 08:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EDA31C21373
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 07:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F3D54BD8;
	Tue, 27 Feb 2024 07:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VP2LtfDq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AE8335D8
	for <stable@vger.kernel.org>; Tue, 27 Feb 2024 07:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709020070; cv=none; b=A3I0stDBzvV24UDQNHYT1+xi5IjN74b+mVnutUuFQeh7uAMsf+hiezoI1cjEWbPXGhnoea/hB7Txw6HKRfrKsl/VftEGfYBO95lWw2rsVjm7moaquH48YcnnDFbYq7ofiIw7n6q6ugkhlFsK+PcgY1laScT17JVCZDuR89xzJug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709020070; c=relaxed/simple;
	bh=+SQvwLyZ44ekEC3sXDRKQnJZ/cRRyn3ptkhSdBptLJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W60diJiT5skcBgDMf2dTHU4WAyYwY+Gk0Ah79HnOPsubq44mqT7KFteqw/51YZHN2ZDUeu0ZhZ/bpZXHuyXTnh3h1VPY5pdawNFJ5jhPPuhWX9bwjyhOXkyqN72vr+afA45/pVEbRg37GFp9/RXFzeR4PcQ8CyEhy1nhHcZfk5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VP2LtfDq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B4B1C433F1;
	Tue, 27 Feb 2024 07:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709020069;
	bh=+SQvwLyZ44ekEC3sXDRKQnJZ/cRRyn3ptkhSdBptLJ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VP2LtfDqZ1iTnKd5mN3SYl8J9I/npFrJVVSeaHMQNlG1w/LEW974MjbBJ30m2Yw7F
	 jaEvJX03al/ity4RSRD9oI+MLY82YDsHLj460nFnaJDs4Gy5rpMBEB5f9FXCH9zoeG
	 c4ML1n+hjGzEpNx37wBDmA9ski1PVpUyer1sr/tw=
Date: Tue, 27 Feb 2024 08:47:46 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jiri Slaby <jirislaby@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, stable@vger.kernel.org,
	Alyssa Milburn <alyssa.milburn@intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 6.7.y 1/6] x86/bugs: Add asm helpers for executing VERW
Message-ID: <2024022716-dormitory-breeches-574a@gregkh>
References: <20240226-delay-verw-backport-6-7-y-v1-0-ab25f643173b@linux.intel.com>
 <20240226-delay-verw-backport-6-7-y-v1-1-ab25f643173b@linux.intel.com>
 <c9ede8e2-5066-435b-bd1d-1971a8072952@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9ede8e2-5066-435b-bd1d-1971a8072952@kernel.org>

On Tue, Feb 27, 2024 at 08:40:26AM +0100, Jiri Slaby wrote:
> On 27. 02. 24, 6:00, Pawan Gupta wrote:
> > commit baf8361e54550a48a7087b603313ad013cc13386 upstream.
> > 
> > MDS mitigation requires clearing the CPU buffers before returning to
> > user. This needs to be done late in the exit-to-user path. Current
> > location of VERW leaves a possibility of kernel data ending up in CPU
> > buffers for memory accesses done after VERW such as:
> > 
> >    1. Kernel data accessed by an NMI between VERW and return-to-user can
> >       remain in CPU buffers since NMI returning to kernel does not
> >       execute VERW to clear CPU buffers.
> >    2. Alyssa reported that after VERW is executed,
> >       CONFIG_GCC_PLUGIN_STACKLEAK=y scrubs the stack used by a system
> >       call. Memory accesses during stack scrubbing can move kernel stack
> >       contents into CPU buffers.
> >    3. When caller saved registers are restored after a return from
> >       function executing VERW, the kernel stack accesses can remain in
> >       CPU buffers(since they occur after VERW).
> > 
> > To fix this VERW needs to be moved very late in exit-to-user path.
> > 
> > In preparation for moving VERW to entry/exit asm code, create macros
> > that can be used in asm. Also make VERW patching depend on a new feature
> > flag X86_FEATURE_CLEAR_CPU_BUF.
> ...
> > --- a/arch/x86/include/asm/nospec-branch.h
> > +++ b/arch/x86/include/asm/nospec-branch.h
> > @@ -315,6 +315,17 @@
> >   #endif
> >   .endm
> > +/*
> > + * Macro to execute VERW instruction that mitigate transient data sampling
> > + * attacks such as MDS. On affected systems a microcode update overloaded VERW
> > + * instruction to also clear the CPU buffers. VERW clobbers CFLAGS.ZF.
> > + *
> > + * Note: Only the memory operand variant of VERW clears the CPU buffers.
> > + */
> > +.macro CLEAR_CPU_BUFFERS
> > +	ALTERNATIVE "", __stringify(verw mds_verw_sel), X86_FEATURE_CLEAR_CPU_BUF
> 
> Why is not rip-relative preserved here? Will this work at all (it looks like
> verw would now touch random memory)?
> 
> In any way, should you do any changes during the backport, you shall
> document that.

s/shall/MUST/

thanks,

greg k-h

