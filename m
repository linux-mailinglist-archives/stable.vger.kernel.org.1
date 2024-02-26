Return-Path: <stable+bounces-23666-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D668671AE
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 11:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 860AD1F285C5
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 10:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D921EEE7;
	Mon, 26 Feb 2024 10:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1C424lVx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3D31DDEE
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 10:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708943766; cv=none; b=AEwvoMt/FOsN4dmFrLJc3NHLwpvxdDJVtJyIgRXhhmorUwnaGQJttgNNDJnwpTcbo2Wsi8xQs+9mhZcUfET5VdH0jk4cQBimWCp+53cZDCDidPe7ZA4J6yhuqzHXRi/Sou8xJ0TBQlRY+POB6/k3YT4G26BZjtvUMLGZizuRzL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708943766; c=relaxed/simple;
	bh=IwiMcqNOPTtlWwBpco+1owNO/H+Yn34+U/erasa+rzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h6Qv6akYLRvubQrmuUSGfXGrkG7wS2bFMiLDCg9IjoD84JUyC6+TdkDk53ermnbfRGbYf3FpXVlMCNlSuW6ivK+DHaPh27QEn8zmIiThsrVwLG01vUcyKPxr03ofgIGEsUcrYzA4Fzh+13v5QmjQ8Rw3vlhLzhJnE88Xzko9KjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1C424lVx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C38C433F1;
	Mon, 26 Feb 2024 10:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708943766;
	bh=IwiMcqNOPTtlWwBpco+1owNO/H+Yn34+U/erasa+rzk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1C424lVxx9h9wE+B+RRd5dgC4gV0cIh4VPwdC+h+E2mVPrkSnYc4ifEzG5VLbI9UF
	 mcODWXMmY9lwVSLpWUkYpSVsEbLsxci9Cj2OM3gO3m3irL/0l9vwoOgawWc4SuZNxy
	 DnRywNVyH2x4ImDPOMhIU923hs9o8npCfGG/YwbI=
Date: Mon, 26 Feb 2024 11:36:03 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 0/7] 5.4 backport of recent mds improvement patches
Message-ID: <2024022641-nearest-engraving-ed9c@gregkh>
References: <20240226101239.17633-1-nik.borisov@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226101239.17633-1-nik.borisov@suse.com>

On Mon, Feb 26, 2024 at 12:12:32PM +0200, Nikolay Borisov wrote:
> Here's the recently merged mds improvement patches adapted to latest stable tree.
> I've only compile tested them, but since I have also done similar backports for
> older kernels I'm sure they should work.
> The main difference is in the definition of the CLEAR_CPU_BUFFERS macro since
> 5.4 doesn't contains the alternative relocation handling logic hence the verw
> instruction is moved out of the alternative definition and instead we have a jump which
> skips the verw instruction there. That way the relocation will be handled by the
> toolchain rather than the kernel.
> 
> H. Peter Anvin (Intel) (1):
>   x86/asm: Add _ASM_RIP() macro for x86-64 (%rip) suffix
> 
> Pawan Gupta (5):
>   x86/bugs: Add asm helpers for executing VERW
>   x86/entry_64: Add VERW just before userspace transition
>   x86/entry_32: Add VERW just before userspace transition
>   x86/bugs: Use ALTERNATIVE() instead of mds_user_clear static key
>   KVM/VMX: Move VERW closer to VMentry for MDS mitigation
> 
> Sean Christopherson (1):
>   KVM/VMX: Use BT+JNC, i.e. EFLAGS.CF to select VMRESUME vs. VMLAUNCH
> 
>  Documentation/x86/mds.rst            | 38 ++++++++++++++++++++--------
>  arch/x86/entry/Makefile              |  2 +-
>  arch/x86/entry/common.c              |  2 --
>  arch/x86/entry/entry.S               | 23 +++++++++++++++++
>  arch/x86/entry/entry_32.S            |  3 +++
>  arch/x86/entry/entry_64.S            | 10 ++++++++
>  arch/x86/entry/entry_64_compat.S     |  1 +
>  arch/x86/include/asm/asm.h           |  6 ++++-
>  arch/x86/include/asm/cpufeatures.h   |  2 +-
>  arch/x86/include/asm/irqflags.h      |  1 +
>  arch/x86/include/asm/nospec-branch.h | 26 ++++++++++---------
>  arch/x86/kernel/cpu/bugs.c           | 15 +++++------
>  arch/x86/kernel/nmi.c                |  3 ---
>  arch/x86/kvm/vmx/run_flags.h         |  7 +++--
>  arch/x86/kvm/vmx/vmenter.S           |  9 ++++---
>  arch/x86/kvm/vmx/vmx.c               | 12 ++++++---
>  16 files changed, 111 insertions(+), 49 deletions(-)
>  create mode 100644 arch/x86/entry/entry.S

I don't see the git commit id in any of these patches, can you fix that
up and resend them?

thanks,

greg k-h

