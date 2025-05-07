Return-Path: <stable+bounces-142009-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8834AADB66
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 11:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22D131BC5325
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 09:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8EE21C188;
	Wed,  7 May 2025 09:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Uj4wtUjo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE991EB5DD
	for <stable@vger.kernel.org>; Wed,  7 May 2025 09:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746609815; cv=none; b=CbHIHQX1XLu5RQtTtzpUd89xBSSTv0bDvIwMk7OtWoowgKiFpBK6xPEBuBSd4pQjyZFqVSCi78clHQ9poj6NKPHeLFlOONpU8Sx6RAMTJ555y7WnXTwNNn/OkyPr9vlhoSN60V7Wa/+tC+mvYnB5qji46uvZX86LWZ9SG6wLoS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746609815; c=relaxed/simple;
	bh=yJhJnrCP4Ayns4k/Yaqo1CAJie3fE9MqIONDIIVpXEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZLjTUxSS7XE8klsupi2HK6bTcPz1yvr+uX9sNRvDJ1EFL+YSQPnqhnRLhZa2GhnjsXbpHw71UVmSl+H13PD/RvJWUZrQQzTlppeija4vTlBGl71wRVyURh4sIxX+jd+dKIi9MZs4c+fY/1CkwX3Ipx8N+TKQMqn1mPdm2H27s9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Uj4wtUjo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE13C4CEEE;
	Wed,  7 May 2025 09:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746609814;
	bh=yJhJnrCP4Ayns4k/Yaqo1CAJie3fE9MqIONDIIVpXEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uj4wtUjoa5oepyL1B37mq+1748mfBDO+Sci3qklWba4rcXwi657bZxSsPxMBq7aQE
	 uFkTLO+d/xCXI9IxdqWI0mYjU0fxPxRtaY976nMuoz5fP1535sZzNDzhUwjRBVMVFg
	 AHoLWnz5vqpFTkTOLXnrkI6qaZ/mCnPs/v26Lgo0=
Date: Wed, 7 May 2025 11:23:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Penglei Jiang <superman.xpt@gmail.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH v2 6.14.y] btrfs: fix the inode leak in btrfs_iget()
Message-ID: <2025050752-maturely-urology-62bd@gregkh>
References: <2025050558-charger-crumpled-6ca4@gregkh>
 <20250505150322.40733-1-superman.xpt@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505150322.40733-1-superman.xpt@gmail.com>

On Mon, May 05, 2025 at 08:03:22AM -0700, Penglei Jiang wrote:
> The commit 48c1d1bb525b1c44b8bdc8e7ec5629cb6c2b9fc4 fails to compile
> in kernel version 6.14.
> 
> Version 6.14:
>     struct inode *btrfs_iget(u64 ino, struct btrfs_root *root)
>     {
>             struct inode *inode;
>             ~~~~~~~~~~~~~~
>             ...
>             inode = btrfs_iget_locked(ino, root);
>             ...
>     }
> 
> Version 6.15:
>     struct btrfs_inode *btrfs_iget(u64 ino, struct btrfs_root *root)
>     {
>             struct btrfs_inode *inode;
>             ~~~~~~~~~~~~~~~~~~~~
>             ...
>             inode = btrfs_iget_locked(ino, root);
>             ...
>     }
> 
> In kernel version 6.14, the function btrfs_iget_locked() returns a
> struct inode *, so the patch code adjusts to use iget_failed(inode).
> 
> Reported-by: Penglei Jiang <superman.xpt@gmail.com>
> Link: https://lore.kernel.org/linux-btrfs/20250421102425.44431-1-superman.xpt@gmail.com/
> Fixes: 7c855e16ab72 ("btrfs: remove conditional path allocation in btrfs_read_locked_inode()")
> Signed-off-by: Penglei Jiang <superman.xpt@gmail.com>
> ---
>  fs/btrfs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This is not a v2, it is a totally different patch.

Please just fix up your original backport to build properly when you
submit it, don't send a "fix up patch" to solve a build problem a
previous patch added.

thanks,

greg k-h

