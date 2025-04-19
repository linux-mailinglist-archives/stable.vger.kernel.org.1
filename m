Return-Path: <stable+bounces-134673-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEAEA942FD
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 12:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB66D7B0920
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 10:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687721C862B;
	Sat, 19 Apr 2025 10:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1PYQXlV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DFD1D5CDE;
	Sat, 19 Apr 2025 10:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745059623; cv=none; b=Qe7AG1kvC87IERmovk9Zv4XBN+cSYH7f+/DwrxM1XFtlh5G6bxK9A0+SnIxpoVMLY75NvIsspYZoJ1xI7+Pwr0jcsVBQK7pzQq+DVpVnuQyVjPAACYTwZ5tFI3iU2yonfhsWw+MPJGZ8mpueW4dNNz9G/WFbRls++HwMz2NhJ38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745059623; c=relaxed/simple;
	bh=ZK97eIHavdRm0uW60AowomN0H4pL21DdC6QD66D5J3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VfffaB50nhhTtacuhh/NY1IHG09RKOCBK/4797NgYUP5PPcNsQNO46y0GubR2/NQKjTkZTmjq+hU4cQBNK6gv5vDnuACyWzo1TOTAHVcYUScgtN0m5wFnr6xmw5qQ1bbONjLC5fl2J9tDSycUk0+hV7US07txWfFAjXtqj3xbdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1PYQXlV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A48FDC4CEE7;
	Sat, 19 Apr 2025 10:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745059622;
	bh=ZK97eIHavdRm0uW60AowomN0H4pL21DdC6QD66D5J3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U1PYQXlVRGstbxNxCwsF1iMeg2YV/lgOZwzfswcy0qsiYt1Q10mC9ZDc00/HC8s16
	 17QCMV6jGqZv9VM2SGDPJW7nMmPGwz7PDyTke3ZHWQkCBJVK5d6PId9HzKtuYonA82
	 gPbJFsnwsSSlN3W6K4BQA7euDJOVKV6vRkv29U3yXr7CZNNr2PqEp+joxp6ll2jjSn
	 LCMDVflg+ABlJ5B4z3WXln8N6i4fgCpTU4DP28G56bHSaFj3CNfZ5nVxYmh5wVnGqC
	 n6LwWDPr062OzKDZCvDpNqF81oLvfdv/g3iE7U0vWXhiRMHentH7NvHq+yGUznbKf0
	 qFRzBTn4yUGHg==
Date: Sat, 19 Apr 2025 16:12:52 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	linux-trace-kernel@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Michael Ellerman <mpe@ellerman.id.au>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Viktor Malik <vmalik@redhat.com>, stable@vger.kernel.org
Subject: Re: [PATCH] powerpc64/ftrace: fix clobbered r15 during livepatching
Message-ID: <dgqps5smhncufxkayqrdwvni6md2tfawkomkcx4uctatkttoif@biii6zo3c3iv>
References: <20250416191227.201146-1-hbathini@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416191227.201146-1-hbathini@linux.ibm.com>

On Thu, Apr 17, 2025 at 12:42:27AM +0530, Hari Bathini wrote:
> While r15 is clobbered always with PPC_FTRACE_OUT_OF_LINE, it is
> not restored in livepatch sequence leading to not so obvious fails
> like below:
> 
>   BUG: Unable to handle kernel data access on write at 0xc0000000000f9078
>   Faulting instruction address: 0xc0000000018ff958
>   Oops: Kernel access of bad area, sig: 11 [#1]
>   ...
>   NIP:  c0000000018ff958 LR: c0000000018ff930 CTR: c0000000009c0790
>   REGS: c00000005f2e7790 TRAP: 0300   Tainted: G              K      (6.14.0+)
>   MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 2822880b  XER: 20040000
>   CFAR: c0000000008addc0 DAR: c0000000000f9078 DSISR: 0a000000 IRQMASK: 1
>   GPR00: c0000000018f2584 c00000005f2e7a30 c00000000280a900 c000000017ffa488
>   GPR04: 0000000000000008 0000000000000000 c0000000018f24fc 000000000000000d
>   GPR08: fffffffffffe0000 000000000000000d 0000000000000000 0000000000008000
>   GPR12: c0000000009c0790 c000000017ffa480 c00000005f2e7c78 c0000000000f9070
>   GPR16: c00000005f2e7c90 0000000000000000 0000000000000000 0000000000000000
>   GPR20: 0000000000000000 c00000005f3efa80 c00000005f2e7c60 c00000005f2e7c88
>   GPR24: c00000005f2e7c60 0000000000000001 c0000000000f9078 0000000000000000
>   GPR28: 00007fff97960000 c000000017ffa480 0000000000000000 c0000000000f9078
>   ...
>   Call Trace:
>     check_heap_object+0x34/0x390 (unreliable)
>   __mutex_unlock_slowpath.isra.0+0xe4/0x230
>   seq_read_iter+0x430/0xa90
>   proc_reg_read_iter+0xa4/0x200
>   vfs_read+0x41c/0x510
>   ksys_read+0xa4/0x190
>   system_call_exception+0x1d0/0x440
>   system_call_vectored_common+0x15c/0x2ec
> 
> Fix it by restoring r15 always.
> 
> Fixes: eec37961a56a ("powerpc64/ftrace: Move ftrace sequence out of line")
> Reported-by: Viktor Malik <vmalik@redhat.com>
> Closes: https://lore.kernel.org/lkml/1aec4a9a-a30b-43fd-b303-7a351caeccb7@redhat.com
> Cc: stable@vger.kernel.org # v6.13+
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> ---
>  arch/powerpc/kernel/trace/ftrace_entry.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/trace/ftrace_entry.S b/arch/powerpc/kernel/trace/ftrace_entry.S
> index 2c1b24100eca..3565c67fc638 100644
> --- a/arch/powerpc/kernel/trace/ftrace_entry.S
> +++ b/arch/powerpc/kernel/trace/ftrace_entry.S
> @@ -212,10 +212,10 @@
>  	bne-	1f
>  
>  	mr	r3, r15
> +1:	mtlr	r3
>  	.if \allregs == 0
>  	REST_GPR(15, r1)
>  	.endif
> -1:	mtlr	r3
>  #endif

LGTM.
Acked-by: Naveen N Rao (AMD) <naveen@kernel.org>


- Naveen


