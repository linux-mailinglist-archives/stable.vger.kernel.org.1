Return-Path: <stable+bounces-203221-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E23EDCD655E
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 15:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07D1E3015ABC
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 14:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AE5286D5E;
	Mon, 22 Dec 2025 14:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x3p6ePHF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192FC274FCB;
	Mon, 22 Dec 2025 14:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766412702; cv=none; b=NqcZJyfAQYt7b47pX/1LgFE3m+eYJOX3NPOsfSGykhsLK6hvMX+QE/+7nAdlcvUHraFvvBTeJxMmmqXTzGNcr4zZns9nwv50mrHzGs0leiKSH78dl0AKSrqHfGkMBVoFpm31nurb82eOSQ007YsgmaCz3EeEzZ+MRcQDPcgiZBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766412702; c=relaxed/simple;
	bh=gQhbp+GvEc6d/SEvzgMl2xtERZsm+rvhjk6V1PglOY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F293TwUGy3elALtBfQd/5eLme+MBy/nh3HTHmd41Q3QwCjG64zEh+1p0wtvOVhBNawaVhJRR50XYvKv3JlzHlf5asUhpIdVqPwC5YPgvd1bcXLM4dwMji2ot3vo0MND85myT7yreueyERiYW0Ft6oz5NtsdJ0sdCPYytZl1+Jn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x3p6ePHF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49084C4CEF1;
	Mon, 22 Dec 2025 14:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1766412701;
	bh=gQhbp+GvEc6d/SEvzgMl2xtERZsm+rvhjk6V1PglOY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=x3p6ePHF/D36ZDPIZ76OM2q06p/tNxFkRk1+MRAsiAI3nfquTQBm0KDtMKeIz4ZN2
	 JflnCtemzPOWv6zVr3IYZQISEGq+3gER6SeNW8CdfxjOmzsvENMyquc4FAaXMos8pL
	 skOX191+9fEJh4wtj/WkPM2ENZ/8xKYxPnX8WDvQ=
Date: Mon, 22 Dec 2025 15:11:38 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: yangshiguang <yangshiguang1011@163.com>
Cc: rafael@kernel.org, dakr@kernel.org, peterz@infradead.org,
	linux-kernel@vger.kernel.org, yangshiguang@xiaomi.com,
	stable@vger.kernel.org
Subject: Re: Re: [PATCH] debugfs: Fix NULL pointer dereference at
 debugfs_read_file_str
Message-ID: <2025122221-gag-malt-75ba@gregkh>
References: <20251222093615.663252-2-yangshiguang1011@163.com>
 <2025122234-crazy-remix-3098@gregkh>
 <17647e4c.d461.19b46144a4e.Coremail.yangshiguang1011@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17647e4c.d461.19b46144a4e.Coremail.yangshiguang1011@163.com>

On Mon, Dec 22, 2025 at 08:41:33PM +0800, yangshiguang wrote:
> 
> At 2025-12-22 19:54:22, "Greg KH" <gregkh@linuxfoundation.org> wrote:
> >On Mon, Dec 22, 2025 at 05:36:16PM +0800, yangshiguang1011@163.com wrote:
> >> From: yangshiguang <yangshiguang@xiaomi.com>
> >> 
> >> Check in debugfs_read_file_str() if the string pointer is NULL.
> >> 
> >> When creating a node using debugfs_create_str(), the string parameter
> >> value can be NULL to indicate empty/unused/ignored.
> >
> >Why would you create an empty debugfs string file?  That is not ok, we
> >should change that to not allow this.
> 
> Hi greg k-h,
> 
> Thanks for your reply.
> 
> This is due to the usage step, should write first and then read.
> However, there is no way to guarantee that everyone will know about this step.

True.

> And debugfs_create_str() allows passing in a NULL string. 

Then we should fix that :)

> Therefore, when reading a NULL string, should return an invalid error 
> instead of panic.

If you call write on a NULL string, then you could call strlen() of that
NULL string, and do a memcpy out of that NULL string.  All not good
things, so your quick fix here really doesn't solve the root problem :(

> >>  	str = *(char **)file->private_data;
> >> +	if (!str)
> >> +		return -EINVAL;
> >
> >What in kernel user causes this to happen?  Let's fix that up instead
> >please.
> >
> 
> Currently I known problematic nodes in the kernel:
> 
> drivers/interconnect/debugfs-client.c:
>   155: 	debugfs_create_str("src_node", 0600, client_dir, &src_node);
>   156: 	debugfs_create_str("dst_node", 0600, client_dir, &dst_node);

Ick, ok, that should be fixed.

> drivers/soundwire/debugfs.c:
>   362: 	debugfs_create_str("firmware_file", 0200, d, &firmware_file);

That too should be fixed, all should just create an "empty" string to
start with.

> test case:
> 1. create a NULL string node
> char *test_node = NULL;
> debugfs_create_str("test_node", 0600, parent_dir, &test_node);
> 
> 2. read the node, like bellow:
> cat /sys/kernel/debug/test_node

With your patch, you could change step 2 to do a write, and still cause
a crash :)

So let's fix this properly, let's just fail the creation of NULL
strings, and fix up all callers.

thanks,

greg k-h

