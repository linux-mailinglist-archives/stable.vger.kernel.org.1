Return-Path: <stable+bounces-144665-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC927ABA894
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 08:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 657729E4509
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 06:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68ADD19D087;
	Sat, 17 May 2025 06:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lm9Iu7kN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F313B676
	for <stable@vger.kernel.org>; Sat, 17 May 2025 06:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747464921; cv=none; b=bt1CeXLgptlCJv39juG6Esi/2OpMVnAV2JYCuUmRR6EP9yrUEalheBb0GsuD0oUQtFGkolxwHfz0wyPAmf4eK0orJyryP8surdlQliODgi20VmcAX7D6XmGwM4X9/AoEmDWkJmCNDPqJ65oVrkX/5YyhQfVeOvSDc2Q4MBv6YEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747464921; c=relaxed/simple;
	bh=k4I7YVdT2UUM3JFBBdIbAqKmKpyGsKb04+/7PignoH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iu+Mnn3Wd9gV70eaDZqEMzYHlNLl5B+F1tsPxwxo1uCKXHotNgPVGhE/PT2Hv4Ws1CapqqSn0gxVFs06liZmI+T+yxC3PfggNWPgjgfQHIG9B/azd5cP36SrmU1vcEeNz5a+V0TxpleJ9AfcFJXrtO8fj4vT1FTEhyF1JSa6MXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lm9Iu7kN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25BE4C4CEE3;
	Sat, 17 May 2025 06:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747464920;
	bh=k4I7YVdT2UUM3JFBBdIbAqKmKpyGsKb04+/7PignoH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lm9Iu7kNbLn7UQH+Y7hamXoQkn61k3FVJGM/+QYz0eDuHOuu8TR589jIW7JDxZhMI
	 CzxBvtr8j791aArJZWxTKMn/m3KJWUeFC2Tt9vHdW6G9ohv02petBDE7U1/OBenFFh
	 TxvSh1qHeaXDeA55rJiakQPk9JhjVUco3mWpZm3k=
Date: Sat, 17 May 2025 08:53:31 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: stable@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
	Alexandre Chartre <alexandre.chartre@oracle.com>
Subject: Re: [PATCH 6.1] x86/its: Fix build errors when CONFIG_MODULES=n
Message-ID: <2025051724-reaffirm-embezzle-a8e0@gregkh>
References: <2025051632-uncaring-immature-ed38@gregkh>
 <20250516-its-module-alloc-fix-6-1-v1-1-f3b597b5ea35@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516-its-module-alloc-fix-6-1-v1-1-f3b597b5ea35@linux.intel.com>

On Fri, May 16, 2025 at 01:42:37PM -0700, Pawan Gupta wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> commit 9f35e33144ae5377d6a8de86dd3bd4d995c6ac65 upstream.
> 
> Fix several build errors when CONFIG_MODULES=n, including the following:
> 
> ../arch/x86/kernel/alternative.c:195:25: error: incomplete definition of type 'struct module'
>   195 |         for (int i = 0; i < mod->its_num_pages; i++) {
> 
>   [ pawan: backport: Bring ITS dynamic thunk code under CONFIG_MODULES ]
> 
> Fixes: 872df34d7c51 ("x86/its: Use dynamic thunks for indirect branches")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> Acked-by: Dave Hansen <dave.hansen@intel.com>
> Tested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> ---
>  arch/x86/kernel/alternative.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index 44bff34f7d10cb6868ad079ca1cb87e458d3f91b..acf6fce287dc0804cfea0377f6f8714a68d10452 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -402,6 +402,7 @@ static int emit_indirect(int op, int reg, u8 *bytes)
>  
>  #ifdef CONFIG_MITIGATION_ITS
>  
> +#ifdef CONFIG_MODULES
>  static struct module *its_mod;
>  static void *its_page;
>  static unsigned int its_offset;
> @@ -518,6 +519,14 @@ static void *its_allocate_thunk(int reg)
>  
>  	return thunk;
>  }
> +#else /* CONFIG_MODULES */
> +
> +static void *its_allocate_thunk(int reg)
> +{
> +	return NULL;
> +}
> +
> +#endif /* CONFIG_MODULES */
>  
>  static int __emit_trampoline(void *addr, struct insn *insn, u8 *bytes,
>  			     void *call_dest, void *jmp_dest)
> 
> ---
> change-id: 20250516-its-module-alloc-fix-6-1-abb11f2e3829
> 
> 

THanks, now queued up.

greg k-h

