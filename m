Return-Path: <stable+bounces-71634-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 040CF96605D
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 13:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37B8A1C22D94
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 11:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F39D199923;
	Fri, 30 Aug 2024 11:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NVabzB48"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3AD1946DF
	for <stable@vger.kernel.org>; Fri, 30 Aug 2024 11:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725016413; cv=none; b=S1OihF6aUilBGFKsSWQpJuD7MgXFSKKcO8yrk4mOUoo1W3xki8yG5/K5kB8uwDbpsvfQlpPvLY+a6eOpz/yvEClvGyh/+dAhorZ2Btx0jVWVqRxE/v401GlAyFGcmZJ7y0Iqs0C9CIlYN5lBTm96Y/y/IOy8W17jzRoo0+gVQEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725016413; c=relaxed/simple;
	bh=FtvC94QL1XSeK54GWnSQmsGC26NVpityqZOenaCj8cE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VCJMjoTRLJaeeDNA+4kHNUMxMr/vb5g6yyRN/DpZyDpGxcoPxmiKnR+T3uqWm2nNoN1djKvBhKnzxs9N1Tg5sRjVnu8Ga4uKwtxK96zMnP9iYXxQNXzO9Gf2ibKlZzRhXdnYmJmXnLT9HAQHI+X2qmmR5PmnO9/Twx69E7EcoFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NVabzB48; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22977C4CEC2;
	Fri, 30 Aug 2024 11:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725016412;
	bh=FtvC94QL1XSeK54GWnSQmsGC26NVpityqZOenaCj8cE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NVabzB483FoO7q1LM5B8ImIWPaq1u33vzD+a4nRprUSphrYh6fVIjSpEzIXD+E5/9
	 ne+mJd5Q5HKp1t27AgbkludyBntQf5oNpJiBlyruz3azhF8lGFvV+q7+Wmn+8UYD90
	 LypHgVd6m5iP/Ein1ZNKKNyLOXlQvhP/IqEtBQ1w=
Date: Fri, 30 Aug 2024 13:13:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Long Li <leo.lilong@huawei.com>
Cc: stable@vger.kernel.org, jannh@google.com, yangerkun@huawei.com
Subject: Re: [PATCH 5.4] filelock: Correct the filelock owner in
 fcntl_setlk/fcntl_setlk64
Message-ID: <2024083007-goes-banter-58c6@gregkh>
References: <20240816050627.2122228-1-leo.lilong@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816050627.2122228-1-leo.lilong@huawei.com>

On Fri, Aug 16, 2024 at 01:06:27PM +0800, Long Li wrote:
> The locks_remove_posix() function in fcntl_setlk/fcntl_setlk64 is designed
> to reliably remove locks when an fcntl/close race is detected. However, it
> was passing in the wrong filelock owner, it looks like a mistake and
> resulting in a failure to remove locks. More critically, if the lock
> removal fails, it could lead to a uaf issue while traversing the locks.
> 
> This problem occurs only in the 4.19/5.4 stable version.
> 
> Fixes: 4c43ad4ab416 ("filelock: Fix fcntl/close race recovery compat path")
> Fixes: dc2ce1dfceaa ("filelock: Remove locks reliably when fcntl/close race is detected")
> Cc: stable@vger.kernel.org
> Signed-off-by: Long Li <leo.lilong@huawei.com>
> ---
>  fs/locks.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/locks.c b/fs/locks.c
> index 85c8af53d4eb..cf6ed857664b 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -2542,7 +2542,7 @@ int fcntl_setlk(unsigned int fd, struct file *filp, unsigned int cmd,
>  		f = fcheck(fd);
>  		spin_unlock(&current->files->file_lock);
>  		if (f != filp) {
> -			locks_remove_posix(filp, &current->files);
> +			locks_remove_posix(filp, current->files);

Ick, sorry about this, that was my fault in my backport.

both now queued up, thanks.

greg k-h

