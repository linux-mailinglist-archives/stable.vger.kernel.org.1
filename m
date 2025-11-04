Return-Path: <stable+bounces-192334-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3C3C2F5B7
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 06:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A7EA188768D
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 05:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991CF26B08F;
	Tue,  4 Nov 2025 05:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zsKl4KLe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E98757EA;
	Tue,  4 Nov 2025 05:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762233347; cv=none; b=f4MX7ldDdiN0NcuzqiX2X128SRK9g7PWZsiRT+UGjAW+hMXSn6IHiu5OQgkEETEk5nDXSpOh6438Irel27maGI8JmToHr8cEk04tY7LLIjAxAIsa9qXqHhZYoupMuf01TpJKsyAGIz8ah5JY209/dfLR1UHWpYPAoN20Ol7rbTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762233347; c=relaxed/simple;
	bh=CG/77hDlBA5GAi+YsvTXUU6wq+DW2FoxpA4mz+wRsT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhU6li0ifd6IKAJBIcsUd41EaY911YIzFQCjnxH58K1Mv+7S+CKj28vYjvQjKJ/kejCXpwr6Zv7lGG5vIE7rWnqRYPf58HybCCxVNk+7AaLXAFdlnArvcgyC1T+GLSIHIJl3gFq3/Gd2XF4lUwnlitXCvmj4tLr+8dluywQfg6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zsKl4KLe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56DDFC4CEF8;
	Tue,  4 Nov 2025 05:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762233346;
	bh=CG/77hDlBA5GAi+YsvTXUU6wq+DW2FoxpA4mz+wRsT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zsKl4KLeRKR6BOr+L/GctUjALH92R4J9iOWiTTpAanB//7lFP/tEVZOBTBWCqBmhN
	 eajqB9JtkWpp+rli6dLKkByyuJDzBpGdsaIs3nxNoU5Y7pAtqei6jwFnP9+FAtxclX
	 qSAEIVlLS0t/3ti07tWm7/CUDeFS4LQIjX+NEuho=
Date: Tue, 4 Nov 2025 14:15:44 +0900
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: guhuinan <guhuinan@xiaomi.com>
Cc: stable@vger.kernel.org, linux-usb@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	Ingo Rohloff <ingo.rohloff@lauterbach.com>,
	Christian Brauner <brauner@kernel.org>,
	Chen Ni <nichen@iscas.ac.cn>, Peter Zijlstra <peterz@infradead.org>,
	Sabyrzhan Tasbolatov <snovitoll@gmail.com>,
	Akash M <akash.m5@samsung.com>, Chenyu <chenyu45@xiaomi.com>,
	Yudongbin <yudongbin@xiaomi.com>, Mahongwei <mahongwei3@xiaomi.com>,
	Jiangdayu <jiangdayu@xiaomi.com>
Subject: Re: [PATCH 6.12.y] usb: gadget: f_fs: Fix epfile null pointer access
 after ep enable.
Message-ID: <2025110452-graffiti-blizzard-9cbc@gregkh>
References: <20251104034946.605-1-guhuinan@xiaomi.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104034946.605-1-guhuinan@xiaomi.com>

On Tue, Nov 04, 2025 at 11:49:46AM +0800, guhuinan wrote:
> From: Owen Gu <guhuinan@xiaomi.com>
> 
> [ Upstream commit cfd6f1a7b42f ("usb: gadget: f_fs: Fix epfile null
> pointer access after ep enable.") ]
> 
> A race condition occurs when ffs_func_eps_enable() runs concurrently
> with ffs_data_reset(). The ffs_data_clear() called in ffs_data_reset()
> sets ffs->epfiles to NULL before resetting ffs->eps_count to 0, leading
> to a NULL pointer dereference when accessing epfile->ep in
> ffs_func_eps_enable() after successful usb_ep_enable().
> 
> The ffs->epfiles pointer is set to NULL in both ffs_data_clear() and
> ffs_data_close() functions, and its modification is protected by the
> spinlock ffs->eps_lock. And the whole ffs_func_eps_enable() function
> is also protected by ffs->eps_lock.
> 
> Thus, add NULL pointer handling for ffs->epfiles in the
> ffs_func_eps_enable() function to fix issues
> 
> Signed-off-by: Owen Gu <guhuinan@xiaomi.com>
> Link: https://lore.kernel.org/r/20250915092907.17802-1-guhuinan@xiaomi.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/usb/gadget/function/f_fs.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

What about 6.17.y?  You do not want to upgrade from 6.12 to a newer
kernel and have a regression.

And if this fixes a bug, why was it not marked with a Fixes: tag or a
 cc: stable tag?  Did I just miss that before?

thanks,

greg k-h

