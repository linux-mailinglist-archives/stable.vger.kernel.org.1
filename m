Return-Path: <stable+bounces-78655-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C35D98D378
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24765283A3E
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 12:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60311D0418;
	Wed,  2 Oct 2024 12:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O6DtdAiu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697421D040E
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 12:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727872893; cv=none; b=VjdU8kJFXKkpYhenJga1puMw8gVlexjvFnnhcmM3qLrgYXoeW4bwD6JLh9/6NVAwViF2qK44UcNNCERtiSKnY/ZvgsQGJjv94+cXNQp/2qGBkZFJ4RfAsTiwhtX/C6+1nySRetWS3twcePx95fYsyRgE4124A19BKQBpUv8fCos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727872893; c=relaxed/simple;
	bh=891JsYRqKPjA1U/8qJ5D8CgoQUtBX3+jfNSxSkQeAcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVF6W+hjec0+BlITjJSMb2wpYwL6wT77AAm78fcZEV/0qV0XAt+YvK3ywZRLzJdjMyvpIVpv49skxCv4OBe5uZYj7rQwlM7I+xw7M+68WCoXtLc+rhGZ0chD/wO5SpcY7kmbReoMUb+MF6Z7ySVv4axDAXtmVh7fO+FfKgRvJuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O6DtdAiu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A03C4CEC5;
	Wed,  2 Oct 2024 12:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727872892;
	bh=891JsYRqKPjA1U/8qJ5D8CgoQUtBX3+jfNSxSkQeAcQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O6DtdAiuqZAKMLv21tYXFfepV3IFGvbz50uAijm6o3/PZKDMrLHBbQcoZcTUT/w6x
	 vtVD0frBaxwwowCDFezSTHTVm6xGJFRID1AnrxWXFnLuOWRcmckQ2hPOq+QnXw8tjX
	 +XNQ3tsRIiPT8YPIpClg+DZWfld0yA1YmErlHyR4=
Date: Wed, 2 Oct 2024 14:41:30 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Alexey Gladkov (Intel)" <legion@kernel.org>
Cc: stable@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 6.6.y] x86/tdx: Fix "in-kernel MMIO" check
Message-ID: <2024100217-casing-endeared-f49e@gregkh>
References: <2024100100-emperor-thespian-397f@gregkh>
 <20241002122359.83485-1-legion@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002122359.83485-1-legion@kernel.org>

On Wed, Oct 02, 2024 at 02:23:59PM +0200, Alexey Gladkov (Intel) wrote:
> TDX only supports kernel-initiated MMIO operations. The handle_mmio()
> function checks if the #VE exception occurred in the kernel and rejects
> the operation if it did not.
> 
> However, userspace can deceive the kernel into performing MMIO on its
> behalf. For example, if userspace can point a syscall to an MMIO address,
> syscall does get_user() or put_user() on it, triggering MMIO #VE. The
> kernel will treat the #VE as in-kernel MMIO.
> 
> Ensure that the target MMIO address is within the kernel before decoding
> instruction.
> 
> Fixes: 31d58c4e557d ("x86/tdx: Handle in-kernel MMIO")
> Signed-off-by: Alexey Gladkov (Intel) <legion@kernel.org>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc:stable@vger.kernel.org
> Link: https://lore.kernel.org/all/565a804b80387970460a4ebc67c88d1380f61ad1.1726237595.git.legion%40kernel.org
> (cherry picked from commit d4fc4d01471528da8a9797a065982e05090e1d81)
> Signed-off-by: Alexey Gladkov (Intel) <legion@kernel.org>
> ---
>  arch/x86/coco/tdx/tdx.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Now queued up, thanks.

greg k-h

