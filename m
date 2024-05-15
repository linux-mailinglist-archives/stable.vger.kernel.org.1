Return-Path: <stable+bounces-45131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A138C61BC
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 09:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50B5F1F22ACF
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 07:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7742D43AAE;
	Wed, 15 May 2024 07:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="q9bnKdoC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kbv6QzrO"
X-Original-To: stable@vger.kernel.org
Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E94A41C84
	for <stable@vger.kernel.org>; Wed, 15 May 2024 07:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715758424; cv=none; b=cVfzRElC789hZF6qrxYv4NiivqyejCRxUz1QHFyI4b7K6MvXriSCPlQjXgUjuDSMHi9vxitIpyL7v4SWP/mhNnaGT5zza6ZaLBTTqmX1mF+nv6jioJoYA15uu50naJh8fvJOuqKoxnbEhRXSJ5YyScQ9V+2k7sd/9wAnDaRzVj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715758424; c=relaxed/simple;
	bh=wnKW12VDR4DzSmrveXFWWVVy6Ur6UtPZG2bwDtSS2Lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HKPNVwGJfEIbFWPFTv8c6FBOg34WR0R82CrNKdIdakaPvUBvT0zZR6+bxb+EudvVtyTS3u52PTmOq9qYzvwVeohCVdiccIgRdrwMS8K7ie6KqVCNPS7PzIY/KOY6359hQem/WrFJHG1JFU3ayWf6xyYNTzTM5EC4M0yxSIu/TdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=q9bnKdoC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kbv6QzrO; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 8095D1380F83;
	Wed, 15 May 2024 03:33:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 15 May 2024 03:33:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715758420; x=1715844820; bh=Oa0FLwkRur
	byZIUib2cyWb5YwiqKadh/Avgr77Pgt0U=; b=q9bnKdoCNrQk1K0fZIRIfEYn+5
	50v0fIxY5fS8xkkb7+/4z5Mr5qbGi5/24rF8ofkeVZ09DB+v/4XnTOtb1yzT4r/s
	xr9nOod9FJjd5M1q7ombvuwn4Y2qojSa4QM3FSRg5oEpw/dgwOkROM24wMBLPc5W
	pZO16qYlIIKuYxfoScH+CUguSAKN9uma4KL9ud+3C+NnngpGknqFvuSYli3Us4zj
	GOi1dnQw2BmnC7ziOh5B5OeRhA8hmaMV67u7MHtdOOmLkhy56eCPfWXYSIUP+Eid
	zE+VVtqeI3endAl5wAzZmEY2IY8J7taeIUtlDF+iC7mPsVA5LxNWNVW/6ymw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715758420; x=1715844820; bh=Oa0FLwkRurbyZIUib2cyWb5YwiqK
	adh/Avgr77Pgt0U=; b=Kbv6QzrO3B+2ivKLRwVcbz6ZV68Mz3S3xKd8yFBH73FU
	tbuZ5ndRo5o2poRaihqAQYqM7FbtQIWufROPol0ErHKg8PtdORvD4xEjSfaFjiPZ
	YRcWlT8cAvSSQCXeP3J5qZFz8aUDeRtpPAAmY5/DdE6VnhxxdIk83fMgxpR0L7OK
	2wWZU60RD/IVZm09Ke0DfKmLLhl/gPMz0b2IJtY48ub8xahG25mYYq73IEcvLAhl
	lLdQbEfVLBICRzCU1idy5Q4sIYg1BBz5BQC34Cu0O5AethgJ64WLGTwGYdHiM/C3
	dHAuY9c5J7LX5X+sChiMPhWIssjTtYPLeRuM1wYKaw==
X-ME-Sender: <xms:U2VEZj5rwYVtuxEqKsMVnEm5_D4Ps9YvtfIy2sWkNAEc0mxlAByljg>
    <xme:U2VEZo550qKlvQPPJOF0dq7a5olj_B7TUbYGi9QTRSgNJ9pBxe9tpNVTIz7nM02_L
    o8fmzNUoN3Bmg>
X-ME-Received: <xmr:U2VEZqetG5fT5M91UIfaRj2qPWfBieOYQGmVoOix4mE0UWq2W9aBJ_OAYMuG3fOjVHUfaVLoIfYrEktS1fWaitJJCCq5ZqLdmc6gsw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegjedgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeeghe
    euhefgtdeluddtleekfeegjeetgeeikeehfeduieffvddufeefleevtddtvdenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:VGVEZkJmpGFSY5NryuZbAav42FIGahIeXOdMIoNPoHnkye-FdhpHRg>
    <xmx:VGVEZnKa-gMJGySO4D-Xssgk8tzlRCW_uUI-_MQji4FvZJJfvtjJPQ>
    <xmx:VGVEZtzKdJZYgnwktjvygZyVGZxKhvXHU3KK9P4FlDS2TO1fjm_T0g>
    <xmx:VGVEZjKZaTsIbDbKX6h4LbGeLJfIP_KRn25cZ0_xRp6GBlwHAVcAFA>
    <xmx:VGVEZu9NvRz2nj0ehExhL-FZkwFdAazZZPD89bD-OGqfWAFelz7evHf_>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 May 2024 03:33:39 -0400 (EDT)
Date: Wed, 15 May 2024 09:33:37 +0200
From: Greg KH <greg@kroah.com>
To: Jeremy Bongio <jbongio@google.com>
Cc: stable@vger.kernel.org, Li Nan <linan122@huawei.com>,
	Song Liu <song@kernel.org>
Subject: Re: [PATCH] md: fix kmemleak of rdev->serial
Message-ID: <2024051523-precision-rosy-eac3@gregkh>
References: <20240513233058.885052-1-jbongio@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513233058.885052-1-jbongio@google.com>

On Mon, May 13, 2024 at 11:30:58PM +0000, Jeremy Bongio wrote:
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
> Signed-off-by: Jeremy Bongio <jbongio@google.com>
> ---
> 
> This backport is tested on LTS 5.10, 6.1, 6.6

So this is not needed in 5.15.y or 5.4.y?  Why not?

thanks,

greg k-h

