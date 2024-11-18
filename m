Return-Path: <stable+bounces-93795-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 007189D1170
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 14:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD8041F23603
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 13:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8910C1991B4;
	Mon, 18 Nov 2024 13:07:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A82194125
	for <stable@vger.kernel.org>; Mon, 18 Nov 2024 13:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731935274; cv=none; b=RTMFqi3/NdgmnkvMYZ+xXTot9vSSeXssrZHo5XsXWrYYdiyXW/nbtbvnccWUhHnYSZJaYi7akuNt/k2gENmBQwuzIfvYNgn7oob3QTRUdXIUboBDOyyyJvBxxVXjAJGn6IgOWgIn+T9ccZK5mBg0AmCVMVA1ABtqPZeflEm0wrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731935274; c=relaxed/simple;
	bh=4NRZ9CUDo2mgC2ACDz3nHAnQFx3bNRXDkV9K2ja7KSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lE31mocIthVkF55VTc45c++uowzWlYX5OdiGsv86QYStmlAHSYGzq5UD7DB/S3e71VbNqNXKSqupp/SKeG3+Bsl7VVk+DhIEfxzhivskwDtCYG/GZGkx47ef66gDH7mD/2FxrfNXs7WLzuTAb3e5GAmQflemxyYWaf8Z8pdFz2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D7C3C1682;
	Mon, 18 Nov 2024 05:08:20 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E8F33F5A1;
	Mon, 18 Nov 2024 05:07:48 -0800 (PST)
Date: Mon, 18 Nov 2024 13:07:43 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Will Deacon <will@kernel.org>
Cc: Gax-c <zichenxie0106@gmail.com>, catalin.marinas@arm.com,
	robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
	chenyuan0y@gmail.com, zzjas98@gmail.com, stable@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] arm64: uaccess: Restrict user access to kernel memory in
 __copy_user_flushcache()
Message-ID: <Zzs8DtlbCqmBgzJV@J2N7QTR9R3>
References: <20241115205206.17678-1-zichenxie0106@gmail.com>
 <20241118115654.GA27696@willie-the-truck>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118115654.GA27696@willie-the-truck>

[ adding uaccess / iov_iter / pmem folk, question at the end ]

On Mon, Nov 18, 2024 at 11:56:55AM +0000, Will Deacon wrote:
> On Fri, Nov 15, 2024 at 02:52:07PM -0600, Gax-c wrote:
> > From: Zichen Xie <zichenxie0106@gmail.com>
> > 
> > raw_copy_from_user() do not call access_ok(), so this code allowed
> > userspace to access any virtual memory address. Change it to
> > copy_from_user().
> 
> How can you access *any* virtual memory address, given that we force the
> address to map userspace via __uaccess_mask_ptr()?
> 
> > Fixes: 9e94fdade4d8 ("arm64: uaccess: simplify __copy_user_flushcache()")
> 
> I don't think that commit changed the semantics of the code, so if it's
> broken then I think it was broken before that change as well.

AFAICT we've never had an access_ok() in __copy_user_flushcache() or
__copy_from_user_flushcache() (which is the only caller of
__copy_user_flushcache()).

We could fold the two together to make that aspect slightly clearer;
IIUC we only had this out-of-line due ot the PAN toggling that we used
to have.

> > Signed-off-by: Zichen Xie <zichenxie0106@gmail.com>
> > Cc: stable@vger.kernel.org
> > ---
> >  arch/arm64/lib/uaccess_flushcache.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/lib/uaccess_flushcache.c b/arch/arm64/lib/uaccess_flushcache.c
> > index 7510d1a23124..fb138a3934db 100644
> > --- a/arch/arm64/lib/uaccess_flushcache.c
> > +++ b/arch/arm64/lib/uaccess_flushcache.c
> > @@ -24,7 +24,7 @@ unsigned long __copy_user_flushcache(void *to, const void __user *from,
> >  {
> >  	unsigned long rc;
> >  
> > -	rc = raw_copy_from_user(to, from, n);
> > +	rc = copy_from_user(to, from, n);
> 
> Does anybody actually call this with an unchecked user address?
> 
> From a quick look, there are two callers of _copy_from_iter_flushcache():
> 
>   1. pmem_recovery_write() - looks like it's using a kernel address?
> 
>   2. dax_copy_from_iter() - has a comment saying the address was already
>                             checked in vfs_write().
> 
> What am I missing? It also looks like x86 elides the check.

IIUC the intent is that __copy_from_user_flushcache() is akin to
raw_copy_from_user(), and requires that the caller has already checked
access_ok(). The addition of __copy_from_user_flushcache() conicided
with __copy_from_user() being replaced with raw_copy_from_user(), and I
suspect the naming divergence was accidental.

That said, plain copy_from_user_iter() has an access_ok() check while
copy_from_user_iter_flushcache() doesn't (and it lakcs any explanatory
comment), so even if that's ok for current callers it seems like it
might be fragile.

So the real question is where is the access_ok() call intended to live?
I don't think it's meant to be in __copy_from_user_flushcache(), and is
intended to live in *some* caller, but it seems odd that
copy_from_user_iter() and copy_from_user_iter_flushcache() diverge.

Mark.

