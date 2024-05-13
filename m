Return-Path: <stable+bounces-43742-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 092D08C4885
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 22:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74A451F21D5D
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 20:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7EC80BE3;
	Mon, 13 May 2024 20:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="ZvQHPYp5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eX6Ldby1"
X-Original-To: stable@vger.kernel.org
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B766F067
	for <stable@vger.kernel.org>; Mon, 13 May 2024 20:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715633602; cv=none; b=MYTOP3S6XpRnyBxMG+tmRpoW2SPQe/Pmf4X9ysMiI1WXrnXhDYotK/BrtXLPbHwlVA8npn0/908ZOnYF5c5sK82jLRoGdGpDR83u7RrSjBwN8ZwjajqHwT+GZ2huqMojMBrvoQOquKAgK4+C4L8YgYQrv41PIWu0Yj+wB4GazKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715633602; c=relaxed/simple;
	bh=ZXvVW/IkDm+MWFZjvqPD6xW9FHnMNrCnZuT3x4lZwnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kDd7R7jqX04nvRt60S8eThKQlNPv35WoGKT1JqrXxfNqSGmW5/C6vEIH5pnZg1jkpL10HcqJhyEYJ0tcLPqACAsnaMje16Ux0JJmGTIe8M4uOJb2X1Aj5RnQikRxU9zdh1dV8QmAZaiYMCfm7IbR9UPPQEWaAm5ev0cbUojH0JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=ZvQHPYp5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eX6Ldby1; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 8B70B1380F80;
	Mon, 13 May 2024 16:53:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 13 May 2024 16:53:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715633599; x=1715719999; bh=6zKblBGV2v
	epNESo2RhU0/pp+dOyUKzDaQhvAht1FJk=; b=ZvQHPYp5WbFiA36/ecide1DmYs
	jk71vQliCme671UHhvQE5STuq0boNZB9m6nCvtqQOespk4812Ogtg/lVlxHCOkMl
	FweMVr4TZj2qkKw5T2qrw4r1D/RXtvtcJfF7mDGMnULTbIlVtHxxiCePCT/IUzAo
	mivJiZBgZA03rqiKW8WB+jJIEvSoSgtltR1xpJKe1RT7eAi2lGnBy5yiWRXqMjxX
	d95CfxMR/lXPrTuTPTSEJLjGm3fUREFodrBin9QeLLx5JFrbArMo6RK8VwLSmp4c
	nqoQ4/Hx52thn6ckf66jlfiqdzVjNhM1ODr7B2zWWKkJbSSo7WLSq2VWceAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715633599; x=1715719999; bh=6zKblBGV2vepNESo2RhU0/pp+dOy
	UKzDaQhvAht1FJk=; b=eX6Ldby1qHsB7YXeHBTyrSvQFMOowZLxiQ7MdzB834T6
	Ur2R8QTZ4h+9Eo/TLuhzhr5QcdjDaztLnmbTbNcCUhfXLEZj1FwMVv1H/AuR0hAJ
	Nw2IQ8ixe9+A91PDhYn97E1ObUtpIu10TyiHZVA+i5WuSYTt58G/sph4gO9jXaYw
	5nO8L7ugoHWOL6omj22urR268YQVYnpAD5FhtLcMG7iUD5IKIwqxjU3S98Fj+aKP
	+K0aaFBjHOUwcD5Vzm2/iJxzRW6NrJu4rR7XvUb2cF6Eq0qOOwR2ry7n+kSjzpvV
	pWN2yOeOsips5Hkq6aXDL4HEAlanv0FX2YOkjQU0dw==
X-ME-Sender: <xms:v31CZrKeB6N6B5rp9b9O6vdDsuwbjnB8FjD33QFWYrw5-OhVuK5HFA>
    <xme:v31CZvKZ4DI1BgW2BeUh91ZIMSbBpMohRPtlGPESuOywJRuxG0hjZDrT9FNmyhNEY
    YEPOvDOUBBvqQ>
X-ME-Received: <xmr:v31CZjtQaTJPwJ1WnH04kqAv6y7v4wybi6p-fkbDfrfJWziNpkeWyva3HO-Qp6K1cp-we-sUawTP641MgWByqx-HDuMcuR2FoYw9gw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedgudehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeeghe
    euhefgtdeluddtleekfeegjeetgeeikeehfeduieffvddufeefleevtddtvdenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:v31CZkaXM3q--B0g-WrwfnKOK0HfpxbzkVv-t9xYTSDi-xY6Yywp9A>
    <xmx:v31CZiYRrMbHuU9hGjwMf6HI_pZUmvP5tLWiKORI5Ai7rL_1S-Fi0A>
    <xmx:v31CZoANmnLL39tyr1w2Nofv0MiYUj_EvWmQ43G3b_pmZ0YmEYa8Ng>
    <xmx:v31CZgZRVhifroLPXp_25hWf04U6TeXvmn3d5AzSwAPcaZEM_ztA9A>
    <xmx:v31CZoO9yFGuGeQNRMkHLvecw-LB8VQtz6cvoaCGGyoK8z3frh1KUMyS>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 16:53:18 -0400 (EDT)
Date: Mon, 13 May 2024 22:53:15 +0200
From: Greg KH <greg@kroah.com>
To: Jeremy Bongio <bongiojp@gmail.com>
Cc: stable@vger.kernel.org, Li Nan <linan122@huawei.com>,
	Song Liu <song@kernel.org>
Subject: Re: [PATCH] md: fix kmemleak of rdev->serial
Message-ID: <2024051307-nintendo-collected-ceed@gregkh>
References: <20240513192030.568328-1-bongiojp@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513192030.568328-1-bongiojp@gmail.com>

On Mon, May 13, 2024 at 12:20:30PM -0700, Jeremy Bongio wrote:
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
> 
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 09c7f52156f3f..67ceab4573be4 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -2532,6 +2532,7 @@ static int bind_rdev_to_array(struct md_rdev *rdev, struct mddev *mddev)
>   fail:
>  	pr_warn("md: failed to register dev-%s for %s\n",
>  		b, mdname(mddev));
> +	mddev_destroy_serial_pool(mddev, rdev, false);
>  	return err;
>  }
>  
> -- 
> 2.45.0.118.g7fe29c98d7-goog
> 
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

