Return-Path: <stable+bounces-309-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EB07F78C0
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 17:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 785DB1C2099F
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 16:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C18F2EB15;
	Fri, 24 Nov 2023 16:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TbVL6ivL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E32615AEB
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 16:17:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500F8C433C7;
	Fri, 24 Nov 2023 16:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700842626;
	bh=YO4lb2aU/8kS68ZxjXFT4vp2sOLnBO2R2bKckFpBtzE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TbVL6ivL7iVhPwtV6PtiDICY5bEHleLWRBuN2r4PFRbjAFWzSvGclUCAwTxPDV6VW
	 PDiDp5ZwOSQQROk9yHyPgVk7sQJi3w7VPaHZBJf9P1wc9jnwNOKlhxe+P86Cw9Rw2t
	 LUADi5Sm29Xp0tG10LBsPIVMk89NkcTNQDDQmLHw=
Date: Fri, 24 Nov 2023 16:17:04 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Francis Laniel <flaniel@linux.microsoft.com>
Cc: stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 4.19.y] tracing/kprobes: Return EADDRNOTAVAIL when func
 matches several symbols
Message-ID: <2023112447-prevent-unbalance-4448@gregkh>
References: <2023102138-riverbed-senator-e356@gregkh>
 <20231124122413.95544-1-flaniel@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124122413.95544-1-flaniel@linux.microsoft.com>

On Fri, Nov 24, 2023 at 01:24:13PM +0100, Francis Laniel wrote:
> When a kprobe is attached to a function that's name is not unique (is
> static and shares the name with other functions in the kernel), the
> kprobe is attached to the first function it finds. This is a bug as the
> function that it is attaching to is not necessarily the one that the
> user wants to attach to.
> 
> Instead of blindly picking a function to attach to what is ambiguous,
> error with EADDRNOTAVAIL to let the user know that this function is not
> unique, and that the user must use another unique function with an
> address offset to get to the function they want to attach to.
> 
> Link: https://lore.kernel.org/all/20231020104250.9537-2-flaniel@linux.microsoft.com/
> 
> Cc: stable@vger.kernel.org
> Fixes: 413d37d1eb69 ("tracing: Add kprobe-based event tracer")
> Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Francis Laniel <flaniel@linux.microsoft.com>
> Link: https://lore.kernel.org/lkml/20230819101105.b0c104ae4494a7d1f2eea742@kernel.org/
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> (cherry picked from commit b022f0c7e404887a7c5229788fc99eff9f9a80d5)
> ---
>  kernel/trace/trace_kprobe.c | 48 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)

Again, we need a version for 5.4.y as well before we can take this
version.

thanks,

greg k-h

