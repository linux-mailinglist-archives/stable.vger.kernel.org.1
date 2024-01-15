Return-Path: <stable+bounces-10922-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6CD82E007
	for <lists+stable@lfdr.de>; Mon, 15 Jan 2024 19:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19B2D1F21C54
	for <lists+stable@lfdr.de>; Mon, 15 Jan 2024 18:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5699134A2;
	Mon, 15 Jan 2024 18:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sH7CuCMZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A708182A0;
	Mon, 15 Jan 2024 18:35:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A83C433C7;
	Mon, 15 Jan 2024 18:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705343750;
	bh=gwFwCQR02mqMJh+DxFoy4WZb/vmnLO4DD6kpklsd0Z0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sH7CuCMZSMA9YSmTxRIPYfWC+UJJ7cXAAVDqEemp+fkBQlXckddbHl3Va/nMwZwVf
	 mYX55hoJRjyf+f3Emr7Yw5OYVtngyQatobWmmXaxqCaJrYw2c5qb6WSw3gomp486Ki
	 xd3ZZZsLh2QDCWLIbj+99wyBPeYSrofTdk1NN10Y=
Date: Mon, 15 Jan 2024 19:35:48 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, x86@kernel.org,
	Borislav Petkov <bp@suse.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH stable] x86/microcode: do not cache microcode if it will
 not be used
Message-ID: <2024011502-shoptalk-gurgling-61f5@gregkh>
References: <20240115102202.1321115-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115102202.1321115-1-pbonzini@redhat.com>

On Mon, Jan 15, 2024 at 11:22:02AM +0100, Paolo Bonzini wrote:
> [ Upstream commit a7939f01672034a58ad3fdbce69bb6c665ce0024 ]

This really isn't this commit id, sorry.

> Builtin/initrd microcode will not be used the ucode loader is disabled.
> But currently, save_microcode_in_initrd is always performed and it
> accesses MSR_IA32_UCODE_REV even if dis_ucode_ldr is true, and in
> particular even if X86_FEATURE_HYPERVISOR is set; the TDX module does not
> implement the MSR and the result is a call trace at boot for TDX guests.
> 
> Mainline Linux fixed this as part of a more complex rework of microcode
> caching that went into 6.7 (see in particular commits dd5e3e3ca6,
> "x86/microcode/intel: Simplify early loading"; and a7939f0167203,
> "x86/microcode/amd: Cache builtin/initrd microcode early").  Do the bare
> minimum in stable kernels, setting initrd_gone just like mainline Linux
> does in mark_initrd_gone().

Why can't we take the changes in 6.7?  Doing a one-off almost always
causes problems :(

What exact commits are needed?

thanks,

greg

