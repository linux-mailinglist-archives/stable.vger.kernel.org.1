Return-Path: <stable+bounces-188122-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4C9BF18A7
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 15:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 029F84EA168
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 13:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4555C311978;
	Mon, 20 Oct 2025 13:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GhXZGPVt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB72012CDA5;
	Mon, 20 Oct 2025 13:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760967160; cv=none; b=dPe5KdGHzJcwTQZ2Ds6CKx7Dvs3uB2ophVJb+qnCIlFSpT6cU6/CczMM68BGgnGFHon5Gvfylw9tnL8TgOeT4bmf5YXYLsZ462AP/5inYphfeRIkTVV/ERsbS5Vjymj+PHtpxx0UbhfMpEiFsH2iR8FeMdsNzVLypfo3lQjEdns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760967160; c=relaxed/simple;
	bh=Z9owQ97yl4AOBrwwWi1Jnwx7il5M9EeyCFPulCNxT30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWOF8BMEr4jtr+GLB9ETyAb/1kfz+Q2OHLbDHnSmBDP9VU9KdFHcU1E1ELvJOVE5aGxfThhifZVanI9Zmkc9YwoSFUUx/AiJzmsVLK3sZoPoMobrLLjRIFZViLuv1TjDOXalp3IjGYggY5hp37FmrUB/2yOdO4h2FPBOtLStT40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GhXZGPVt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD0EC4CEF9;
	Mon, 20 Oct 2025 13:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760967159;
	bh=Z9owQ97yl4AOBrwwWi1Jnwx7il5M9EeyCFPulCNxT30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GhXZGPVtqQK0Aj5if05g+CQoVMtapN/p2AWVKhGoGdHdIBJhsMfuehwSlpwUTI6IR
	 BS8ySHLEgdAXjHGC0iL1cNIuDfdjyuF1o05n3FIYblrjYSNZkRfoajdy0eRV1hXwxu
	 7JCAn4LRfNHxWGPKgnAdUawUmHP3znRIe8UcJjYE=
Date: Mon, 20 Oct 2025 15:32:37 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	MPTCP Upstream <mptcp@lists.linux.dev>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	"H. Peter Anvin (Intel)" <hpa@zytor.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Douglas Raillard <douglas.raillard@arm.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 5.10.y 0/3] v5.10: fix build with GCC 15
Message-ID: <2025102055-result-magnolia-96ba@gregkh>
References: <20251017-v5-10-gcc-15-v1-0-cdbbfe1a2100@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017-v5-10-gcc-15-v1-0-cdbbfe1a2100@kernel.org>

On Fri, Oct 17, 2025 at 06:53:24PM +0200, Matthieu Baerts (NGI0) wrote:
> This kernel version doesn't build with GCC 15:
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
> the GCC 15 release and not mentioning the error I had. This is the first
> patch.
> 
> When I was investigating my error, I noticed other commits were already
> backported to stable versions. They were all adding -std=gnu11 in
> different Makefiles. In their commit message, they were mentioning
> 'gnu11' was picked to use the same as the one from the main Makefile.
> But this is not the case in this kernel version. Patch 2 fixes that.
> 
> Finally, I noticed an extra warning that I didn't have in v5.15. Patch 3
> fixes that.

As with 5.4.y, this kernel isn't going to be around all that much
longer, and I strongly doubt anyone that relies on it is also using
gcc15 with it.  Normally near the end of the 6 year window of kernels,
we are "stuck" with using older gcc releases with that, and not newer
ones, and that's fine, as that's what the users of those kernels are
also doing.

So I don't think the effort is worth it.  gcc14 will be around in
distros for the next year so all should be ok here.  Just like gcc13 was
around long enough for us to keep 4.19.y working just fine with that
maximum compiler release as well.

thanks,

greg k-h

