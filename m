Return-Path: <stable+bounces-43741-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8678C4884
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 22:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FA1F1C20D56
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 20:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A2880BE3;
	Mon, 13 May 2024 20:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CG77KQJ/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868096F067
	for <stable@vger.kernel.org>; Mon, 13 May 2024 20:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715633587; cv=none; b=FGjkTTSJk2cndOuWK7TReJv5C/FkW33UpFp8p5QqiNOdGZJfab7zJPeuSf3ppM7LTblINx5fUpGxrC9IdKhxEbpBL9uCsOel16CASjEr3LSbxqv6HaqLlWn/2wFNjYu+76rnreQWsGTEw0X+Cii6UdFPa44xr7WIA00GYilIh+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715633587; c=relaxed/simple;
	bh=iZ4X8n9c8/17Dizc8QMCV3OpLhP3TDJYu3fAAYBbdsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ShNnESRe/Cg7mwJQOFKBPm+3Stc+u7dWCiaOxzpfWK9qpyWIQxYuaG8PIk7ulJbXC3rQ8HKEC37+G0KXJ1yj9JD51JIlkadAVOP8hBEAh7ee+k9CDnwQ44CLwatn5HD0lqGaICZ3cSKd50+0A/6WhCIEJ365bvYgDZR+uLQgS1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CG77KQJ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AA28C113CC;
	Mon, 13 May 2024 20:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715633587;
	bh=iZ4X8n9c8/17Dizc8QMCV3OpLhP3TDJYu3fAAYBbdsA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CG77KQJ//8bAYtSmfoxfcFHxD3Jx3wte4xlhlfJ5oVb42w/eYFG7R12ayMF7oRXLn
	 oEqcipY/0YZyjm81PXnmtWYSvGJIjhzDfq2Bkbzndk4LZB92gJCCID9teFLq0fe2K9
	 YfsLYXsAJdsEa3+PBIOwPfKvclgNd725iSBZQUo8=
Date: Mon, 13 May 2024 22:53:02 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jeremy Bongio <bongiojp@gmail.com>
Cc: stable@vger.kernel.org, Li Nan <linan122@huawei.com>,
	Song Liu <song@kernel.org>
Subject: Re: [PATCH] md: fix kmemleak of rdev->serial
Message-ID: <2024051346-numerous-recognize-8a0a@gregkh>
References: <20240513192024.568296-1-bongiojp@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513192024.568296-1-bongiojp@gmail.com>

On Mon, May 13, 2024 at 12:20:24PM -0700, Jeremy Bongio wrote:
> From: Li Nan <linan122@huawei.com>
> 
> If kobject_add() is fail in bind_rdev_to_array(), 'rdev->serial' will be
> alloc not be freed, and kmemleak occurs.
> 
> unreferenced object 0xffff88815a350000 (size 49152):
>   comm "mdadm", pid 789, jiffies 4294716910
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace (crc f773277a):
>     [<0000000058b0a453>] kmemleak_alloc+0x61/0xe0
>     [<00000000366adf14>] __kmalloc_large_node+0x15e/0x270
>     [<000000002e82961b>] __kmalloc_node.cold+0x11/0x7f
>     [<00000000f206d60a>] kvmalloc_node+0x74/0x150
>     [<0000000034bf3363>] rdev_init_serial+0x67/0x170
>     [<0000000010e08fe9>] mddev_create_serial_pool+0x62/0x220
>     [<00000000c3837bf0>] bind_rdev_to_array+0x2af/0x630
>     [<0000000073c28560>] md_add_new_disk+0x400/0x9f0
>     [<00000000770e30ff>] md_ioctl+0x15bf/0x1c10
>     [<000000006cfab718>] blkdev_ioctl+0x191/0x3f0
>     [<0000000085086a11>] vfs_ioctl+0x22/0x60
>     [<0000000018b656fe>] __x64_sys_ioctl+0xba/0xe0
>     [<00000000e54e675e>] do_syscall_64+0x71/0x150
>     [<000000008b0ad622>] entry_SYSCALL_64_after_hwframe+0x6c/0x74
> 
> Fixes: 963c555e75b0 ("md: introduce mddev_create/destroy_wb_pool for the change of member device")
> Signed-off-by: Li Nan <linan122@huawei.com>
> Signed-off-by: Song Liu <song@kernel.org>
> Link: https://lore.kernel.org/r/20240208085556.2412922-1-linan666@huaweicloud.com
> Change-Id: Icc4960dcaffedc663797e2d8b18a24c23e201932
> ---
>  drivers/md/md.c | 1 +
>  1 file changed, 1 insertion(+)


<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

