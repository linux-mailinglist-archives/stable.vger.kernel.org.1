Return-Path: <stable+bounces-43749-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 289FA8C4995
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 00:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4627E1C214EA
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 22:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD63884A5B;
	Mon, 13 May 2024 22:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2kwrxbcA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEDD2AF09
	for <stable@vger.kernel.org>; Mon, 13 May 2024 22:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715639085; cv=none; b=GG2XioES5aO23MKJK7Z6MSpfFecigxObRq9XbuoTkV40NwFN2HYLqPfI+kkmXItWxLWXLQEROKB+EH7/ZC9pK0ekDcPFNGLtec9T0XqDlt+kjZQGHCoF3tUaa2RZ19jAp7pzZ29lZfBk9KbTdlrIwuRRCCFnST4adGcAXKxDemA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715639085; c=relaxed/simple;
	bh=nwdJEEu3vuQLP6pF0fB6Zn1KbdLic0n8pYBM9dOL+20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S3Q+7IpgQ3szflYtPBT7WPfhzBvnG67Ja6ZdPdGiv1YUsrPj+CVd/I6oDpNY01vjv1oop8voQGEZeQS31ZDetSpBpO/c8urqO6W/LGWsqDizx5mWFlvAq4FOaeZtQtciOO7JfXbwimaNrYKZktUHR5dB6axTzK4E2o5Cq+rerpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2kwrxbcA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75C6DC113CC;
	Mon, 13 May 2024 22:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715639085;
	bh=nwdJEEu3vuQLP6pF0fB6Zn1KbdLic0n8pYBM9dOL+20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2kwrxbcAYfCT6IbhMg4kX7XEbH0ocE52NnhdVSybMLlkqL/2EQ9d8FvODfQaBQpdF
	 9LvCwCEGSCqkit2Mmg6vFYRAh57fvXm2WxLq9WuO6TiV1NeGLEqgzVREr4i4Ngdygc
	 dNFeQnZhvNuGkIfF8Mq9GsiBxx1OLgHMV8qAcC5A=
Date: Tue, 14 May 2024 00:24:40 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jeremy Bongio <bongiojp@gmail.com>
Cc: stable@vger.kernel.org, Li Nan <linan122@huawei.com>,
	Song Liu <song@kernel.org>, Jeremy Bongio <jbongio@google.com>
Subject: Re: [PATCH] md: fix kmemleak of rdev->serial
Message-ID: <2024051453-blah-pushpin-3d0b@gregkh>
References: <20240513213938.626201-1-bongiojp@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513213938.626201-1-bongiojp@gmail.com>

On Mon, May 13, 2024 at 02:39:38PM -0700, Jeremy Bongio wrote:
> From: Li Nan <linan122@huawei.com>
> 
> commit 6cf350658736681b9d6b0b6e58c5c76b235bb4c4 upstream.
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
> backport change:
> mddev_destroy_serial_pool third parameter was removed in mainline,
> where there is no need to suspend within this function anymore.
> 
> Fixes: 963c555e75b0 ("md: introduce mddev_create/destroy_wb_pool for the change of member device")
> Signed-off-by: Li Nan <linan122@huawei.com>
> Signed-off-by: Song Liu <song@kernel.org>
> Link: https://lore.kernel.org/r/20240208085556.2412922-1-linan666@huaweicloud.com
> Change-Id: Icc4960dcaffedc663797e2d8b18a24c23e201932

Why the change-id?

And what kernel tree(s) is this backport for?

> Signed-off-by: Jeremy Bongio <jbongio@google.com>

This doesn't match the From: line of your email :(

thanks,

greg k-h

