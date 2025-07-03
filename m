Return-Path: <stable+bounces-159298-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9818CAF6FE1
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 12:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1E7E3A93DD
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 10:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212CA2E11DF;
	Thu,  3 Jul 2025 10:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uN2/XOLp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5221B95B;
	Thu,  3 Jul 2025 10:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751538090; cv=none; b=nTnnDsl6XWv6pnuYG5YY9KLg5Cou3Bzs6xGAo95fyspMxAj6urvY9paO5PDlIlxSpXv0vLWmKLrQ92G2AtJPqHmtrjnmSgEkAPtRlHcWhm7M/LFCkTpJuU4uu4x9xZMrvd8r2k9Z+u9BlCs2aRfwzjaSx9h0EzYDGsgTQ6x+/ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751538090; c=relaxed/simple;
	bh=37OE39yAqD+Z4rIt7ZPOz9DrBUeV7pwEDTCXEbnG5E0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EkPMsdSmVe08m5lK+MHkKngNy+YxcVAOB7SNLOG9tiGgBKSh/RDtjkbvaHojgnzPNKwghZR4Hfdw2ZG6p5kztXvIkLwMJsSgczh7Aw44pfSMLj01qLQHnO9jxxZWzEwcNjBeblA3i0Ub2+GoAovg4pDgZ5u9lMwJjUJp4mDcUq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uN2/XOLp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 050DAC4CEEB;
	Thu,  3 Jul 2025 10:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751538090;
	bh=37OE39yAqD+Z4rIt7ZPOz9DrBUeV7pwEDTCXEbnG5E0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uN2/XOLppmDWB0ta5U8ugs7ryEljX4GQWMbyyZy2rC926m98c6jmTizrAwQKkKeHf
	 CU35ibuAdk0RDfvIxI8OI1NeEHc8xbyCfo7EvlSnfhXaXCsOQsGolkJ8VmXOygIFqX
	 mIZ3p3jFMIoGfcB2lASpQjj+9SAwPfLRAq9QPP8Q=
Date: Thu, 3 Jul 2025 12:21:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH RESEND] x86/pmem: Fix a null pointer dereference in
 register_e820_pmem()
Message-ID: <2025070300-purgatory-improvise-898b@gregkh>
References: <20250703100809.2542430-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703100809.2542430-1-haoxiang_li2024@163.com>

On Thu, Jul 03, 2025 at 06:08:09PM +0800, Haoxiang Li wrote:
> Add check for the return value of platform_device_alloc()
> to prevent null pointer dereference.
> 
> Fixes: 7a67832c7e44 ("libnvdimm, e820: make CONFIG_X86_PMEM_LEGACY a tristate option")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
>  arch/x86/kernel/pmem.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/kernel/pmem.c b/arch/x86/kernel/pmem.c
> index 23154d24b117..04fb221716ff 100644
> --- a/arch/x86/kernel/pmem.c
> +++ b/arch/x86/kernel/pmem.c
> @@ -27,6 +27,8 @@ static __init int register_e820_pmem(void)
>  	 * simply here to trigger the module to load on demand.
>  	 */
>  	pdev = platform_device_alloc("e820_pmem", -1);
> +	if (!pdev)
> +		return -ENOMEM;

As this can only happen if you are out of memory, AND that really can't
happen at early boot time, how have you tested this code to verify that
this works?

thanks,

greg k-h

