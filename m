Return-Path: <stable+bounces-203285-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1BACD88F3
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 10:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BE8993002771
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 09:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48562F691F;
	Tue, 23 Dec 2025 09:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kQP5GmPM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BD52B2D7;
	Tue, 23 Dec 2025 09:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766481576; cv=none; b=FAvS6ngy8X8KYmKdaMkiogoolNremzUDAOgslWWOLWgwXNEAAGG6XIa71YI0a3pCNFU13f3+gZZJyC07tqRZteU5Yj576r92XGMMQlwi+3GYfSNyDUBTeH/M6SekCTNbkI1nH4Hr12I/DT9ylJMMtIMpn+t2PhoEW2Md6162SQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766481576; c=relaxed/simple;
	bh=VzvoVI3etT0APm7HG+qTcGwy4MLWTSrogBEsYHCX5F0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hbrINi5dWjAPyiXZLV95N58BVeOTjRxjDeA9omVEN23cJUOM4ndwFEU5i3UYLRMjCah4WhbCaZIV0zZ8A2p1Q5WlG0xu/Y39vCH7mDpAM94MtkfQKz2l2m4XH0pQZPEXfvYCMnQc0nEeNuCmI6da6hfS53413kR5Ftu9WLYvGOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kQP5GmPM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73865C113D0;
	Tue, 23 Dec 2025 09:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1766481575;
	bh=VzvoVI3etT0APm7HG+qTcGwy4MLWTSrogBEsYHCX5F0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kQP5GmPMKx5jG6JQJetX6Xrx04/ORX8/j83K+VqC8OmUIIgxS3V2evf+5eEz5vkUM
	 3WEQIxOqHQK+RbZTfoRoOiMV9TMA+JdN7LUGCHuXCgiWjcN0rT80zP3rI+LV109uzD
	 JTnLNzGir+zOdbrrK85y4j5I4BQDoEXanUp3rQOY=
Date: Tue, 23 Dec 2025 10:19:32 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: yangshiguang <yangshiguang1011@163.com>
Cc: rafael@kernel.org, dakr@kernel.org, peterz@infradead.org,
	linux-kernel@vger.kernel.org, yangshiguang@xiaomi.com,
	stable@vger.kernel.org
Subject: Re: Re: Re: [PATCH] debugfs: Fix NULL pointer dereference at
 debugfs_read_file_str
Message-ID: <2025122311-earflap-deploy-e32d@gregkh>
References: <20251222093615.663252-2-yangshiguang1011@163.com>
 <2025122234-crazy-remix-3098@gregkh>
 <17647e4c.d461.19b46144a4e.Coremail.yangshiguang1011@163.com>
 <2025122221-gag-malt-75ba@gregkh>
 <2de8b181.5007.19b48fb047f.Coremail.yangshiguang1011@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2de8b181.5007.19b48fb047f.Coremail.yangshiguang1011@163.com>

On Tue, Dec 23, 2025 at 10:12:48AM +0800, yangshiguang wrote:
> At 2025-12-22 22:11:38, "Greg KH" <gregkh@linuxfoundation.org> wrote:
> >On Mon, Dec 22, 2025 at 08:41:33PM +0800, yangshiguang wrote:
> >> 
> >> At 2025-12-22 19:54:22, "Greg KH" <gregkh@linuxfoundation.org> wrote:
> >> >On Mon, Dec 22, 2025 at 05:36:16PM +0800, yangshiguang1011@163.com wrote:
> >> >> From: yangshiguang <yangshiguang@xiaomi.com>
> >> >> 
> >> >> Check in debugfs_read_file_str() if the string pointer is NULL.
> >> >> 
> >> >> When creating a node using debugfs_create_str(), the string parameter
> >> >> value can be NULL to indicate empty/unused/ignored.
> >> >
> >> >Why would you create an empty debugfs string file?  That is not ok, we
> >> >should change that to not allow this.
> >> 
> >> Hi greg k-h,
> >> 
> >> Thanks for your reply.
> >> 
> >> This is due to the usage step, should write first and then read.
> >> However, there is no way to guarantee that everyone will know about this step.
> >
> >True.
> >
> >> And debugfs_create_str() allows passing in a NULL string. 
> >
> >Then we should fix that :)
> >
> >> Therefore, when reading a NULL string, should return an invalid error 
> >> instead of panic.
> >
> >If you call write on a NULL string, then you could call strlen() of that
> >NULL string, and do a memcpy out of that NULL string.  All not good
> >things, so your quick fix here really doesn't solve the root problem :(
> >
> 
> We all know that the problem is a NULL pointer exceptions that occur in strlen().
> However, strlen() is basic function, and we cannot pass abnormal parameters.
> We should intercept them, and this is common in the kernel.
> That's why I submitted this patch.
> 
> >> >>  	str = *(char **)file->private_data;
> >> >> +	if (!str)
> >> >> +		return -EINVAL;
> >> >
> >> >What in kernel user causes this to happen?  Let's fix that up instead
> >> >please.
> >> >
> >> 
> >> Currently I known problematic nodes in the kernel:
> >> 
> >> drivers/interconnect/debugfs-client.c:
> >>   155: 	debugfs_create_str("src_node", 0600, client_dir, &src_node);
> >>   156: 	debugfs_create_str("dst_node", 0600, client_dir, &dst_node);
> >
> >Ick, ok, that should be fixed.
> >
> >> drivers/soundwire/debugfs.c:
> >>   362: 	debugfs_create_str("firmware_file", 0200, d, &firmware_file);
> >
> >That too should be fixed, all should just create an "empty" string to
> >start with.
> >
> >> test case:
> >> 1. create a NULL string node
> >> char *test_node = NULL;
> >> debugfs_create_str("test_node", 0600, parent_dir, &test_node);
> >> 
> >> 2. read the node, like bellow:
> >> cat /sys/kernel/debug/test_node
> >
> >With your patch, you could change step 2 to do a write, and still cause
> >a crash :)
> >
> 
> This shouldn't happen. The write node calls debugfs_write_file_str().
> My test results:
> $: cat dst_node
> $: cat: dst_node: Invalid argument

I would argue that this is not ok, it should just return an empty value.

> 1|&: echo 1 > dst_node
> $: cat dst_node
> $: 1
> 
> Anyway, please show the stack.

If you call write on a NULL string, with an offset set, it will crash
based on the code paths.  I don't have a traceback as I don't want to
write the code to crash my running system at the moment :)

> >So let's fix this properly, let's just fail the creation of NULL
> >strings, and fix up all callers.
> >
> 
> As mentioned above, we shold allow the creation of NULL string nodes
> to indicate empty/unused/ignored.

No, that's not a good idea, let's just fix this properly and not allow
such things at all.  If someone really wants to do this "no value set is
illegal", then they can write their own debugfs callbacks and not use
the built-in helper.

And really, the string debugfs helper has been such a pain over the
years, I'm regretting even accepting it at all :(

thanks,

greg k-h

