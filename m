Return-Path: <stable+bounces-41742-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A478B5C12
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 16:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24E9D1F22494
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 14:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF1980029;
	Mon, 29 Apr 2024 14:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NLntf43X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A574745C5
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 14:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714402653; cv=none; b=MDqklwGD5x09HV9stfdETKoe2yoJVCSP8HnbdI+9P+MSeak2LXUVTlmXlSFyFk2P7yRqbVKDbvnW9j+Cj5mIlfgjG56ZghrHEt2TdNtihtlrgx7i/oCDR4Q8XJ3RLsaoiM3wBvo/lg7FFmVN9Rnd6/8qJTx56RDNBLaQ6nrW3yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714402653; c=relaxed/simple;
	bh=8r0P58xs7RkJkaLYeTE0S+NOa4GIjsTXtLOzguDs/rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ekiyVKBe2Np4/Nq6yo7Nz9BB4SxQR5ywoSLzE/VbiRUFHqEWz4oP0RsC3VsSGX/sDjCDH7hl41ZgKmenogo1qtv+tLzMrHHjPDOYBlcC+0s2wirTWC3RzNn57JCVW7RDebg/ynjwrQVs6+ioN7S0wR+aCfAHRBmL7yvNVSw1bwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NLntf43X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 363C0C113CD;
	Mon, 29 Apr 2024 14:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714402652;
	bh=8r0P58xs7RkJkaLYeTE0S+NOa4GIjsTXtLOzguDs/rk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NLntf43XUN8VBkk4Z6J23Faa0s7NdSJ6kSuj56mNeyrEvMlKWSFuwP4HPUa630ZJ5
	 ypx1w+KTZQNqfusJpiZZLu+4dCAixquJVv7KLQAqKQYmtuJbYF/45Vutn+1CPtvwWW
	 pqIc4YC+OJHTmLx16iK4fCWnkNHdHkUCgKkohdWQ=
Date: Mon, 29 Apr 2024 16:57:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Nam Cao <namcao@linutronix.de>
Cc: stable@vger.kernel.org,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 5.15.y] fbdev: fix incorrect address computation in
 deferred IO
Message-ID: <2024042920-sacrament-wages-b9eb@gregkh>
References: <2024042951-barbell-aeration-a1ce@gregkh>
 <20240429144041.3498362-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429144041.3498362-1-namcao@linutronix.de>

On Mon, Apr 29, 2024 at 04:40:41PM +0200, Nam Cao wrote:
> commit 78d9161d2bcd442d93d917339297ffa057dbee8c upstream.
> 
> With deferred IO enabled, a page fault happens when data is written to the
> framebuffer device. Then driver determines which page is being updated by
> calculating the offset of the written virtual address within the virtual
> memory area, and uses this offset to get the updated page within the
> internal buffer. This page is later copied to hardware (thus the name
> "deferred IO").
> 
> This offset calculation is only correct if the virtual memory area is
> mapped to the beginning of the internal buffer. Otherwise this is wrong.
> For example, if users do:
>     mmap(ptr, 4096, PROT_WRITE, MAP_FIXED | MAP_SHARED, fd, 0xff000);
> 
> Then the virtual memory area will mapped at offset 0xff000 within the
> internal buffer. This offset 0xff000 is not accounted for, and wrong page
> is updated.
> 
> Correct the calculation by using vmf->pgoff instead. With this change, the
> variable "offset" will no longer hold the exact offset value, but it is
> rounded down to multiples of PAGE_SIZE. But this is still correct, because
> this variable is only used to calculate the page offset.
> 
> Reported-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> Closes: https://lore.kernel.org/linux-fbdev/271372d6-e665-4e7f-b088-dee5f4ab341a@oracle.com
> Fixes: 56c134f7f1b5 ("fbdev: Track deferred-I/O pages in pageref struct")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Link: https://patchwork.freedesktop.org/patch/msgid/20240423115053.4490-1-namcao@linutronix.de
> [rebase to v5.15]
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
>  drivers/video/fbdev/core/fb_defio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Now queued up, thanks.

greg k-h

