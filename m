Return-Path: <stable+bounces-197961-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1A8C987EC
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 18:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F398A4E3549
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 17:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE6F33769A;
	Mon,  1 Dec 2025 17:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="vR/cCa6y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3F73375C3;
	Mon,  1 Dec 2025 17:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764609622; cv=none; b=AaVnpF2Rdq+DeAGZTgBqkZN6JPngecqrOEfOUyU9ulD1AjSotBYuVOO7if9/L5LhcrpEiZjHeUNroDKE/d86H5oPM3eCIrodIMKVaQZkStDw/GubBvAQjGy7uecvQXm4EN9oRQQPjuhllkyEgv/aV+vI1sOgUO1Fp4M0pDFcIFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764609622; c=relaxed/simple;
	bh=S5a+d6emgr/Iva9e8ncOVixfJRwirVeWhvpdG02do3I=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=oXU+SE2iRBi4cOq+H7jKKU9+v+wLd0M8hesCKo9vQOD5C4qz3nIF3s4rCo1r8YFVNRerWnmTWOGZlS8zc4sXGQ7RvnfPu1Z2qGGlsCnLcBLZbnsBU2V0YgvtTmcX75mkci1DNoM9gOrOWfa6VioSEQXUzdOFBL8ipbewOMliAxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=vR/cCa6y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A5FDC116C6;
	Mon,  1 Dec 2025 17:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1764609622;
	bh=S5a+d6emgr/Iva9e8ncOVixfJRwirVeWhvpdG02do3I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vR/cCa6yOIVGeLqdeWTtgu9JUqtUit3dVCFWNWPy5TOAjrDzsJbggz4zvAqse27nh
	 HGudb+UvaoMrcJDaASlZwU9p/yCbhT+ayt+9R6Qh1zFJSek+tEu5LbqZ1+Sbe7XGmE
	 h0OhTYERVksOXO1AyVk1vPe6zTdHK1K484D2c00A=
Date: Mon, 1 Dec 2025 09:20:20 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: henry.willard@oracle.com, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>, Jiri Bohac
 <jbohac@suse.cz>, Sourabh Jain <sourabhjain@linux.ibm.com>, Guo Weikang
 <guoweikang.kernel@gmail.com>, Ard Biesheuvel <ardb@kernel.org>, Joel
 Granados <joel.granados@kernel.org>, Alexander Graf <graf@amazon.com>,
 Sohil Mehta <sohil.mehta@intel.com>, Mimi Zohar <zohar@linux.ibm.com>,
 Jonathan McDowell <noodles@fb.com>, linux-kernel@vger.kernel.org,
 yifei.l.liu@oracle.com, stable@vger.kernel.org, Paul Webb
 <paul.x.webb@oracle.com>
Subject: Re: [PATCH] x86/kexec: Add a sanity check on previous kernel's ima
 kexec buffer
Message-Id: <20251201092020.88628d787ac7e66dd3c31a15@linux-foundation.org>
In-Reply-To: <20251112193005.3772542-1-harshit.m.mogalapalli@oracle.com>
References: <20251112193005.3772542-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 12 Nov 2025 11:30:02 -0800 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com> wrote:

> When the second-stage kernel is booted via kexec with a limiting command
> line such as "mem=<size>", the physical range that contains the carried
> over IMA measurement list may fall outside the truncated RAM leading to
> a kernel panic.
> 
>     BUG: unable to handle page fault for address: ffff97793ff47000
>     RIP: ima_restore_measurement_list+0xdc/0x45a
>     #PF: error_code(0x0000) – not-present page
> 
> Other architectures already validate the range with page_is_ram(), as
> done in commit: cbf9c4b9617b ("of: check previous kernel's
> ima-kexec-buffer against memory bounds") do a similar check on x86.

Thanks.

> Cc: stable@vger.kernel.org
> Fixes: b69a2afd5afc ("x86/kexec: Carry forward IMA measurement log on kexec")

That was via the x86 tree so I assume the x86 team (Boris?) will be
processing this patch.

I'll put it into mm.git's mm-hotfixes branch for now, to get a bit of
testing and to generally track its progress.

> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -439,9 +439,23 @@ int __init ima_free_kexec_buffer(void)
>  
>  int __init ima_get_kexec_buffer(void **addr, size_t *size)
>  {
> +	unsigned long start_pfn, end_pfn;
> +
>  	if (!ima_kexec_buffer_size)
>  		return -ENOENT;
>  
> +	/*
> +	 * Calculate the PFNs for the buffer and ensure
> +	 * they are with in addressable memory.

"within" ;)

> +	 */
> +	start_pfn = PFN_DOWN(ima_kexec_buffer_phys);
> +	end_pfn = PFN_DOWN(ima_kexec_buffer_phys + ima_kexec_buffer_size - 1);
> +	if (!pfn_range_is_mapped(start_pfn, end_pfn)) {
> +		pr_warn("IMA buffer at 0x%llx, size = 0x%zx beyond memory\n",
> +			ima_kexec_buffer_phys, ima_kexec_buffer_size);
> +		return -EINVAL;
> +	}
> +
>  	*addr = __va(ima_kexec_buffer_phys);
>  	*size = ima_kexec_buffer_size;


