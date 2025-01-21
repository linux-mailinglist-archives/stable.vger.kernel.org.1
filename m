Return-Path: <stable+bounces-109622-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFDCA17F82
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 15:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 727AB16B25A
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 14:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0117515442A;
	Tue, 21 Jan 2025 14:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wCjcjuC0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C45363CF
	for <stable@vger.kernel.org>; Tue, 21 Jan 2025 14:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737469017; cv=none; b=CP/xeURHxuGgkVc4ql29Vvc9r2STYwMANAWWSyPFvH5poxFzVOYbHJz6gtoCeK42PYebYQjDng2+CwX1B5ufAVSZRJlka9f9QMg0Bx8IbXbFv+WCofWDIqbA4/sAs8AlYIyPzambvlqdg6EM23V6mjx/5WqpgDygz1TmDNkK+FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737469017; c=relaxed/simple;
	bh=1V26GPqW2MX98GHgtMJxT2YOhkfXHAPN+2sH2V/ibcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rc5L/f5bOEl1rhsjOW/WkbqFGBuP7/iRIaP0dMpdGaxWTeojgmhMfsqEwBWOQQfWWA13zqdbSqkAt88r4Wpjl5HluShieRAbyLcuHXB691wQwqWPP/RNVTpkWdAtLfBGzdOOcn7vYyZgj43n4cEz7rp1MXybToa+SHqU+7mhFk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wCjcjuC0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE15CC4CEDF;
	Tue, 21 Jan 2025 14:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737469017;
	bh=1V26GPqW2MX98GHgtMJxT2YOhkfXHAPN+2sH2V/ibcM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wCjcjuC0YQ1hxebOMH22CME78q2mINRpjixYxGH12r7R92IR1apSCNXZQQWXyddum
	 hTFdlT/MUUMNF1COZya038fn1eoVGG4L7GrozTQzTcAdqUwA9GP3DnciksLu+/fXMs
	 j9rNftmrgdTdJB7Arlb2r050Hw15i3Wzn124TSvg=
Date: Tue, 21 Jan 2025 15:16:53 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Juergen Gross <jgross@suse.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH] x86/xen: fix SLS mitigation in xen_hypercall_iret()
Message-ID: <2025012147-glamour-hence-9653@gregkh>
References: <20250117110551.13930-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117110551.13930-1-jgross@suse.com>

On Fri, Jan 17, 2025 at 12:05:51PM +0100, Juergen Gross wrote:
> The backport of upstream patch a2796dff62d6 ("x86/xen: don't do PV iret
> hypercall through hypercall page") missed to adapt the SLS mitigation
> config check from CONFIG_MITIGATION_SLS to CONFIG_SLS.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
> This patch is meant to be applied to the following stable kernels:
> - linux-6.6
> - linux-6.1
> - linux-5.15
> - linux-5.10
> ---
>  arch/x86/xen/xen-asm.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/xen/xen-asm.S b/arch/x86/xen/xen-asm.S
> index 901b60516683..6231f6efb4ee 100644
> --- a/arch/x86/xen/xen-asm.S
> +++ b/arch/x86/xen/xen-asm.S
> @@ -221,7 +221,7 @@ SYM_CODE_END(xen_early_idt_handler_array)
>  	push %rax
>  	mov  $__HYPERVISOR_iret, %eax
>  	syscall		/* Do the IRET. */
> -#ifdef CONFIG_MITIGATION_SLS
> +#ifdef CONFIG_SLS
>  	int3
>  #endif
>  .endm
> -- 
> 2.43.0
> 
> 

Now queued up, thanks!

greg k-h

