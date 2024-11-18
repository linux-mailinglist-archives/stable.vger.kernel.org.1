Return-Path: <stable+bounces-93791-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D67A09D1041
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 12:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C9C028265D
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 11:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE5D194A63;
	Mon, 18 Nov 2024 11:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KizvJHfF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F177176AA9
	for <stable@vger.kernel.org>; Mon, 18 Nov 2024 11:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731931021; cv=none; b=INTf+dyikwZvCGbmpKapOqPR92sUhR+6Kp5V9/zXGNBZgWfOvVSYQ22iCCRNF1rexs5edw6IYvpj2UKGJyRjz1ePym1aDG539/T7bxRStXU5TaGgGQLu56Ums4XPDMscunSa/GpjqRV6HKPQhHCSRsTyl2ZlgZ7cBjIGwK8Uzbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731931021; c=relaxed/simple;
	bh=q64Cj5gfNQRbm22pEVpRN+2YfLJFUaDCOEu7yxyDpjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cV3Tm0NdOhKAI9zDY1yoiiwlJ2oUgs1qTxKCWMAFNMNADhcUfidqdxtkcwFu4/CD1DkZhm28n5ex336GvBY1XZahPnzIKNdbGS1TaIjEP1iHPxfN8CJ1gJO4oCywCAbDocEFHHNa0To/JlXsnRPI5AcBxwXZ453D//FaqXtMK/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KizvJHfF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03432C4CED6;
	Mon, 18 Nov 2024 11:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731931020;
	bh=q64Cj5gfNQRbm22pEVpRN+2YfLJFUaDCOEu7yxyDpjc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KizvJHfFWezkiBD+AQdhr9vC6oTyUJ8HX5Thl81gGGqJ1GE899miak+4/8zMn/jPi
	 Zjd+qCINlEfZBtnny2Z3UH57R2G8tKIURo3tYjmQTdhGlT3yI6EnYo1RCkRLVNFyd4
	 EXEcjc2WDIeFO5pjRqiw7W5VIpsVtdhA6b1OGVEGMVC9JvsS7nakHBQ/uY/U8id8kG
	 8naWjvNILiXv/R3lL8xP5qHNCVE+Br8d2eaF89Qgt+aQTjmt8LAhxxT9sGyz4l26UK
	 1eOLG6NU42hm5GpC+pp/DLpmmSzY7ucuukSZtfmRhtozM55+2x2y7yPr4KlMMkHuU8
	 Y0WTu85KQhGgg==
Date: Mon, 18 Nov 2024 11:56:55 +0000
From: Will Deacon <will@kernel.org>
To: Gax-c <zichenxie0106@gmail.com>
Cc: catalin.marinas@arm.com, robin.murphy@arm.com, mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org, chenyuan0y@gmail.com,
	zzjas98@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH] arm64: uaccess: Restrict user access to kernel memory in
 __copy_user_flushcache()
Message-ID: <20241118115654.GA27696@willie-the-truck>
References: <20241115205206.17678-1-zichenxie0106@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115205206.17678-1-zichenxie0106@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Nov 15, 2024 at 02:52:07PM -0600, Gax-c wrote:
> From: Zichen Xie <zichenxie0106@gmail.com>
> 
> raw_copy_from_user() do not call access_ok(), so this code allowed
> userspace to access any virtual memory address. Change it to
> copy_from_user().

How can you access *any* virtual memory address, given that we force the
address to map userspace via __uaccess_mask_ptr()?

> Fixes: 9e94fdade4d8 ("arm64: uaccess: simplify __copy_user_flushcache()")

I don't think that commit changed the semantics of the code, so if it's
broken then I think it was broken before that change as well.

> Signed-off-by: Zichen Xie <zichenxie0106@gmail.com>
> Cc: stable@vger.kernel.org
> ---
>  arch/arm64/lib/uaccess_flushcache.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/lib/uaccess_flushcache.c b/arch/arm64/lib/uaccess_flushcache.c
> index 7510d1a23124..fb138a3934db 100644
> --- a/arch/arm64/lib/uaccess_flushcache.c
> +++ b/arch/arm64/lib/uaccess_flushcache.c
> @@ -24,7 +24,7 @@ unsigned long __copy_user_flushcache(void *to, const void __user *from,
>  {
>  	unsigned long rc;
>  
> -	rc = raw_copy_from_user(to, from, n);
> +	rc = copy_from_user(to, from, n);

Does anybody actually call this with an unchecked user address?

From a quick look, there are two callers of _copy_from_iter_flushcache():

  1. pmem_recovery_write() - looks like it's using a kernel address?

  2. dax_copy_from_iter() - has a comment saying the address was already
                            checked in vfs_write().

What am I missing? It also looks like x86 elides the check.

Will

