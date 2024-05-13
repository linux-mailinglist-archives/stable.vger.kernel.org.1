Return-Path: <stable+bounces-43743-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA868C4886
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 22:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35D15286664
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 20:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30F680BE3;
	Mon, 13 May 2024 20:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="QnAau2Eh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UwnLhRyX"
X-Original-To: stable@vger.kernel.org
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD8529D02
	for <stable@vger.kernel.org>; Mon, 13 May 2024 20:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715633624; cv=none; b=io30xBGfCcWKfBvOtWuvp23UODaNlUZTtZM81697/LjMu0+dK+Qls5Aqf8CAHCRQRwnb7nlRxyoJXAtwPRfvpJV1Fovxb0rPfLgoTwZ9H1yQAuXywrwaYevcle1u6pBwlLVYpn+nBwSe1ZX7/2SFvAMv+TXDAFeyZIuoxaF34cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715633624; c=relaxed/simple;
	bh=26eitV7mhfrhYFBybW9Rq9/2Isco4Eh6JJceLQL37x0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MOf2Rj94MYQL3ezH9bH4U72pj0EjKw95Kane2r1oN5GD40muF1LNMqthTXuko4olgjAiqsd6tGPuXCmQ+hWTkd2+6aSmGmZ+F4GV4X6imk4adUiF1ELQl8/nnT6SmX0MxI8UuUMmpvMcSEyTGwetBcyr/y1iAONIRafhBDKcJTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=QnAau2Eh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UwnLhRyX; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 11D111381043;
	Mon, 13 May 2024 16:53:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Mon, 13 May 2024 16:53:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715633622; x=1715720022; bh=f6KJrYqtSP
	pLBSsBqfoNvhwV+jRWa90xJDqx74Z/t6A=; b=QnAau2Ehb94ZjAkGDqnosiXkjR
	fElFXZK/OKRc1VFjmX4CbnW3S0jLKyQb/LPzHvATZC+bmE10Yug6CCdJU/FkceiQ
	Z85Gb02KhZem8/oRxJTIYKtIbVvFCYabKfwPl8IqW7cukgRD0ytVmjhYsSbcgrh6
	I1sRfx64naAawi+f8XGpJx9zWNU8egvXENgWkLrZTlpuEtwXHmZSetSFtyXnDlDN
	bK7wou6q7z9d5iGOG35xsDpVrB1tIg+mPhJ41xsl6Wo3H0lyCMQ0rlTsMO7s9FSg
	3yjocZ+zlHfgp34wbZTKvLKKNz7PSRQCcKnyJcxIP8peQmU+VUU5XF38I0uQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715633622; x=1715720022; bh=f6KJrYqtSPpLBSsBqfoNvhwV+jRW
	a90xJDqx74Z/t6A=; b=UwnLhRyXygf35t47S/U7BGPeEp7e50CwZ3qxIotOu+x7
	dbQ08NjGfyJK0ZMeUB0I5IMT7D+pP4ScXjSvwyxPoa7+p1w0AkM+whOrR/otuWrZ
	r96h9gtOzyytf2GU+EZEwSzI/ThkXZ0Y6PYmS7I0QABkDw/V57+9VITXRbdzCOlz
	VNiMsw4C3xn/o9l8w1E032ViRfkXtsl6PozRMT+HarZZacVVvmfEq/Jc3n2jIhR0
	yhwZl+6gnb0v4Qgp2RrAAEaM4g1Xm66mP6i6vtPKWBR1K41Tgx06wxYmIvwU0vXg
	AGvCFhvw7EdASweWOARWlZx1YHTlyiODFu5S2zyMVA==
X-ME-Sender: <xms:1X1CZlKJz0sIFCgXQxTM8wC3qDqbEkyDFR-r54QRw57Ayj2ZU-1GsA>
    <xme:1X1CZhJAS7h7WU7a2Kyd7fR34eg8XJACekC9KLJzIL5FpPQTL2Ry-UWeU0SCgUiAa
    idLwv9jQQT5eQ>
X-ME-Received: <xmr:1X1CZtvLkrdLoor_p5j1eHdAJyfQWg3KtsWIkNp4fri3tQ3cT5eoyoCkKfxcQrIVSQJy-whFAEfl9wZGsMXAjkOIP7HCTpaDgQIJCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedgudehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeeghe
    euhefgtdeluddtleekfeegjeetgeeikeehfeduieffvddufeefleevtddtvdenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:1X1CZmb6bilY81ybnmmWXlovQFGseHbqg4xBAiq2bSmg0uTEEWuZOA>
    <xmx:1X1CZsYFhN-cUTTSzJO643k2Dm_EVOR24yqVmEde5BtuRWxHl0FAEw>
    <xmx:1X1CZqD11E93FVGSb7FZijXcdzOa-rKSooOlxRqJ-OWcshYzF1GLDA>
    <xmx:1X1CZqbmd_REs-tMSCQzifC2FWRQJU-b7DtSbhYKDT1Dnn02wS31aA>
    <xmx:1n1CZiNhyHhbANdATLHy16tM6Y1YG5sa9cH9D_OkjB1Nut7FTiSmvkiJ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 16:53:41 -0400 (EDT)
Date: Mon, 13 May 2024 22:53:39 +0200
From: Greg KH <greg@kroah.com>
To: Jeremy Bongio <bongiojp@gmail.com>
Cc: stable@vger.kernel.org, Li Nan <linan122@huawei.com>,
	Song Liu <song@kernel.org>
Subject: Re: [PATCH] md: fix kmemleak of rdev->serial
Message-ID: <2024051318-equator-jaybird-67e9@gregkh>
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

Any specific reason you are not using your google.com email address to
properly sign off on commits?

confused,

greg k-h

