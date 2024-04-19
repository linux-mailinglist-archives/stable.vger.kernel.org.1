Return-Path: <stable+bounces-40282-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DE98AAD6F
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 13:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A669C1F222FC
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 11:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DB980618;
	Fri, 19 Apr 2024 11:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="3M3RmUQQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dQJo3Tt3"
X-Original-To: stable@vger.kernel.org
Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CE380029
	for <stable@vger.kernel.org>; Fri, 19 Apr 2024 11:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713525027; cv=none; b=MGHay7IP+ZeBc2J6gd6qirt1DrXEvrwoa/ndC2uaWeP6Q2mCA9BAtl2B6Zy4J3Nt39pDruYFL3zmIrX5I8DHhGGpC5Biq7xEika3ZCw9HF0586b23EI4ZU/qOODgVh4rPOEgSmHiPkf0j1JviqjUzm7MTZ5nq9HABjcuGqFwFOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713525027; c=relaxed/simple;
	bh=g0C05++Q8oo/MJZpTbuKs/tskVPX5bHwfdJ4cDB2z/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CAGq9tmNyCsQmYjKP0Uh1OKKrBKC7bTL5nUTopdRFaWXM8BdELeDs2bkajOlMZt34SpJQ4fVBDRQamI3LNoY5xtDniq6nRrlK29dTmv7ssFAiQdCD1o4d9otboVxXakA6DkZbblt1o46vgIvJWDAT4N75pKFu0Bgs1ZpGv3N4XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=3M3RmUQQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dQJo3Tt3; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 2D3CE11400DD;
	Fri, 19 Apr 2024 07:10:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 19 Apr 2024 07:10:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713525025; x=1713611425; bh=QZ9Br4dtFB
	xru/ANlQT3GVvGkNkL2hPgS81H0Zv45u4=; b=3M3RmUQQJRLCDmTB03gWyb6kWd
	VkEtJu9/YFU0IX3zeCjdBLeM1SXsCzvAgJBuvdUQ8q7sUGhIlE94395vV/tqO1eE
	tBlm/V4z2zxc3ei0zPxtnsY+upJkWADVzHivBOgeiCwA9zc+gF3HyCtyvxQWIn9Y
	rurJnQpfBzoo7AA1n+Zh43zq87C/T6n7B9ZQQ81ODIoV1OPr4bf7OdOD6JZVDuhR
	FUj4Smuhwd7Ub0TuR7uWUUXdg7zP70J/w97MPIoZ91heMLEUHRFfFgw2QFFcNR92
	dcNr7LR8rsUN31fzInlExXBPLW2utVmNaFzN+7mOpQxZN9I8DznI4N8/cnMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713525025; x=1713611425; bh=QZ9Br4dtFBxru/ANlQT3GVvGkNkL
	2hPgS81H0Zv45u4=; b=dQJo3Tt3nylgW2GBEZBI28jfCz8ldPhoJrrjYBzD3FOk
	/TNVYAeUvH3PQQJVXv/4vPOGggsD3ohFFzbSag77wMiBsiUwj8LBcfFm912Y3hks
	DJu7nCmcuX+5sdLBm1GGQ3FKxCPPp8Pyp95ZZSAxDPvMM4IaiGJkwy01stiK0SKz
	dlMNRDtnNUqShhtKp5aDTYvm7yne/9sO7Onl9l8uqgfHJbljAYjYz7XOT52Y6NFb
	8p+06o37sOSAtmm9s31hLxFQn6VRNqJylYS2GFJfJwjTwyb76WyVTCn+Wpyw07Kf
	0FlNNKchmBVmH0IiK1pfRKmu6ez1Cxk+NS/tFZ1aXw==
X-ME-Sender: <xms:IFEiZtfYnQ4t7yQMARjR8vlniylYR2DaHjWj_ojreFxj72ctSonqvg>
    <xme:IFEiZrOZMKpwp4xu9eSzQzsYgygBd--Xwhz89t6yukjIGzXo_YS9SOVJij3ygRo3w
    p0M0rkVROpQNg>
X-ME-Received: <xmr:IFEiZmibLAOVjkF7Bl-t_aKe9c9QTnAgOXQd908Y1TUVxbJ7ygqPU3jBppI0gsH4NAxPYFkal-iq4C68VQbQEprESQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudekvddgfeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgeehue
    ehgfdtledutdelkeefgeejteegieekheefudeiffdvudeffeelvedttddvnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:IFEiZm8HYSbho8HmbGmbKThCmDo9QgyJV0FtPNCnB8e4Cx5ws9YFug>
    <xmx:IFEiZpuoldzJDJ8sIujjAs1wzHA5HsYp2t45q3v8xCx43r0Hzvnsjg>
    <xmx:IFEiZlGo_rr5F8nYseMPkNJ3UlxuI2gnQSy1LCzHEcXVP-PJCcnFTQ>
    <xmx:IFEiZgMC8EQ7-cLm20zbljBk2sJpqSaU_efDXWILBe-IS3OIIcF-Jg>
    <xmx:IVEiZjKukHDaXCGSpmYw0a3GJBbNSJ0xTcZRi4dO41jRvo4dXMVMHpUN>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Apr 2024 07:10:24 -0400 (EDT)
Date: Fri, 19 Apr 2024 13:10:13 +0200
From: Greg KH <greg@kroah.com>
To: Zheng Yejian <zhengyejian1@huawei.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 5.15.y] kprobes: Fix possible use-after-free issue on
 kprobe registration
Message-ID: <2024041905-hamstring-quit-892c@gregkh>
References: <2024041524-monoxide-kilobyte-1c44@gregkh>
 <20240416021654.1184927-1-zhengyejian1@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416021654.1184927-1-zhengyejian1@huawei.com>

On Tue, Apr 16, 2024 at 10:16:54AM +0800, Zheng Yejian wrote:
> commit 325f3fb551f8cd672dbbfc4cf58b14f9ee3fc9e8 upstream.
> 
> When unloading a module, its state is changing MODULE_STATE_LIVE ->
>  MODULE_STATE_GOING -> MODULE_STATE_UNFORMED. Each change will take
> a time. `is_module_text_address()` and `__module_text_address()`
> works with MODULE_STATE_LIVE and MODULE_STATE_GOING.
> If we use `is_module_text_address()` and `__module_text_address()`
> separately, there is a chance that the first one is succeeded but the
> next one is failed because module->state becomes MODULE_STATE_UNFORMED
> between those operations.
> 
> In `check_kprobe_address_safe()`, if the second `__module_text_address()`
> is failed, that is ignored because it expected a kernel_text address.
> But it may have failed simply because module->state has been changed
> to MODULE_STATE_UNFORMED. In this case, arm_kprobe() will try to modify
> non-exist module text address (use-after-free).
> 
> To fix this problem, we should not use separated `is_module_text_address()`
> and `__module_text_address()`, but use only `__module_text_address()`
> once and do `try_module_get(module)` which is only available with
> MODULE_STATE_LIVE.
> 
> Link: https://lore.kernel.org/all/20240410015802.265220-1-zhengyejian1@huawei.com/
> 
> Fixes: 28f6c37a2910 ("kprobes: Forbid probing on trampoline and BPF code areas")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> [Fix conflict due to lack dependency
> commit 223a76b268c9 ("kprobes: Fix coding style issues")]
> Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
> ---
>  kernel/kprobes.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)

All now queued up, thanks.

greg k-h

