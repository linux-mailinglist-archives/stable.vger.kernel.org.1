Return-Path: <stable+bounces-188120-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C0ECBBF1897
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 15:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 915CD4E2BE3
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 13:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4487723507E;
	Mon, 20 Oct 2025 13:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DS0xv5gl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E800F2E65D;
	Mon, 20 Oct 2025 13:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760966963; cv=none; b=GcxdPQ8yL9aHsp/MQXfR81LOizy3lHsEovki13SqxLsDgf3sCjMUokngE8qYjPve4/tS4zHy8VWxjd3tCRMyRlmodzMf7mmDVLJroaQCjBqpjfBIMC6rwsvshTTKnttmdhGN8jbGEfVTRXm0Vn2T5dnrBEscAwx36suheogn9no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760966963; c=relaxed/simple;
	bh=AGoj+KwZhuzWZ5kaFZOzLXxUG3XpBoJtlLLk8axqN+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EdAq726f5SlaR88aYs0BJlUqPEa+3FX4nXE+7LAroIsa+jREApZcUweDzu/RTc0l3iOg0PFx2Zeb6AeVI2fXYI8wZysrtN98uqi/q4eCGyBgP/zgEbusR4mkCSwNBGxTHP89NLlL3OaOQkLLEqRuWv0KbE1nbtDQgsyD6m+xrxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DS0xv5gl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C40DEC4CEF9;
	Mon, 20 Oct 2025 13:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760966962;
	bh=AGoj+KwZhuzWZ5kaFZOzLXxUG3XpBoJtlLLk8axqN+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DS0xv5gl8J3Fo07x3dl8+2d0LhfmP/nrCPOyKDNkrOUHWedPd4SSj2MxW7HeuSlzB
	 MZD73c9EE6+4XvGgBkdeOlWTG7lMlg8eKkzOU64evoNNmrXC7MRIyiLgU8lJ8RmCz+
	 WEhESfiVqrewJF7jvl+mvePhfCSOMLj6MjqUVEDg=
Date: Mon, 20 Oct 2025 15:29:19 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	MPTCP Upstream <mptcp@lists.linux.dev>,
	Nathan Chancellor <nathan@kernel.org>,
	Kostadin Shishmanov <kostadinshishmanov@protonmail.com>,
	Jakub Jelinek <jakub@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	"H. Peter Anvin (Intel)" <hpa@zytor.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <natechancellor@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 5.4.y 0/5] v5.4: fix build with GCC 15
Message-ID: <2025102004-throwaway-compare-75c2@gregkh>
References: <20251017-v5-4-gcc-15-v1-0-6d6367ee50a1@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017-v5-4-gcc-15-v1-0-6d6367ee50a1@kernel.org>

On Fri, Oct 17, 2025 at 07:33:37PM +0200, Matthieu Baerts (NGI0) wrote:
> Two backports linked to build issues with GCC 15 have failed in this
> version:
> 
>   - ee2ab467bddf ("x86/boot: Use '-std=gnu11' to fix build with GCC 15")
>   - 8ba14d9f490a ("efi: libstub: Use '-std=gnu11' to fix build with GCC 15")
> 
> Conflicts have been solved, and described.
> 
> After that, this kernel version still didn't build with GCC 15:
> 
>   In file included from include/uapi/linux/posix_types.h:5,
>                    from include/uapi/linux/types.h:14,
>                    from include/linux/types.h:6,
>                    from arch/x86/realmode/rm/wakeup.h:11,
>                    from arch/x86/realmode/rm/wakemain.c:2:
>   include/linux/stddef.h:11:9: error: cannot use keyword 'false' as enumeration constant
>      11 |         false   = 0,
>         |         ^~~~~
>   include/linux/stddef.h:11:9: note: 'false' is a keyword with '-std=c23' onwards
>   include/linux/types.h:30:33: error: 'bool' cannot be defined via 'typedef'
>      30 | typedef _Bool                   bool;
>         |                                 ^~~~
>   include/linux/types.h:30:33: note: 'bool' is a keyword with '-std=c23' onwards
>   include/linux/types.h:30:1: warning: useless type name in empty declaration
>      30 | typedef _Bool                   bool;
>         | ^~~~~~~
> 
> I initially fixed this by adding -std=gnu11 in arch/x86/Makefile, then I
> realised this fix was already done in an upstream commit, created before
> the GCC 15 release and not mentioning the error I had. This is patch 3.
> 
> When I was investigating my error, I noticed other commits were already
> backported to stable versions. They were all adding -std=gnu11 in
> different Makefiles. In their commit message, they were mentioning
> 'gnu11' was picked to use the same as the one from the main Makefile.
> But this is not the case in this kernel version. Patch 4 fixes that.
> 
> Finally, I noticed extra warnings I didn't have in v5.10. Patch 5 fixes
> that.

5.4 is only going to be alive for about 1 more month, so I really don't
think trying to "downgrade" things here is worth it at all.  Anyone
still stuck on this old, obsolete, and very insecure kernel tree isn't
going to be attempting to build it using the bleeding edge gcc release :)

So thanks for the patches, but i'll hold off on them for now.

thanks,

greg k-h

