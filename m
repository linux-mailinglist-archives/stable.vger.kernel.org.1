Return-Path: <stable+bounces-53792-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD6D90E653
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 10:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49711B2227E
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 08:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9966F7CF18;
	Wed, 19 Jun 2024 08:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n3FsT0fp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8772139B1
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 08:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718787166; cv=none; b=HUPqGbHOtM1CdFmV9843ZIdMhnqNgw+m8W8nKM0ut/V6BUBNeOK6A+5qjAtcBY5L0lvcRH1RqvBBlCosSSg06aOfKoBSlwaMg650TKNKtVRfcPxcXDb7SeUsMxfQ4dG+kkqveE6RQc8NeQ2Cucyn7gkc034FC/nGKmF2YrrW1Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718787166; c=relaxed/simple;
	bh=AoZPh+wkUhf02qKgNW2DdDgBIMTTE4bsKqoLTtvMjOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uqT0k7wh/5txUZGP06+bOfMHf/SFfQu598c/UPqoW7G9rAXpI9DYB+KGK6wcjZGxT4cl6efqbPa7lypEPliJnb4DE1+/nlQSnEQJ3O99G0z8Ad18FgY5DuvFsbjlTzZk5AX771j3pKFmbQ9deOPy6+YpDGoJHajsKAnEFUOQDs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n3FsT0fp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73829C32786;
	Wed, 19 Jun 2024 08:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718787165;
	bh=AoZPh+wkUhf02qKgNW2DdDgBIMTTE4bsKqoLTtvMjOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n3FsT0fp971G5e4TLSshIUGe0gskxtlsiZmmkZ+aoAKCgcOg7lvKWN7U/7MYVimKF
	 qOv5M7z26PS31+ohDsS5dXLcjUmBDxeFaJFTpZ2ezZ306NGqvEiCBPPqPbm657epqq
	 ZBHX2xoT9s8n/os9QJO7NIlKl1M80jWNAx6ejCJk=
Date: Wed, 19 Jun 2024 10:52:43 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 4.19 5.4 5.10 5.15 6.1 6.6] nilfs2: fix potential kernel
 bug due to lack of writeback flag waiting
Message-ID: <2024061937-anaconda-justness-92fc@gregkh>
References: <20240616181729.6672-1-konishi.ryusuke@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240616181729.6672-1-konishi.ryusuke@gmail.com>

On Mon, Jun 17, 2024 at 03:17:29AM +0900, Ryusuke Konishi wrote:
> commit a4ca369ca221bb7e06c725792ac107f0e48e82e7 upstream.
> 
> Destructive writes to a block device on which nilfs2 is mounted can cause
> a kernel bug in the folio/page writeback start routine or writeback end
> routine (__folio_start_writeback in the log below):
> 
>  kernel BUG at mm/page-writeback.c:3070!
>  Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
>  ...
>  RIP: 0010:__folio_start_writeback+0xbaa/0x10e0
>  Code: 25 ff 0f 00 00 0f 84 18 01 00 00 e8 40 ca c6 ff e9 17 f6 ff ff
>   e8 36 ca c6 ff 4c 89 f7 48 c7 c6 80 c0 12 84 e8 e7 b3 0f 00 90 <0f>
>   0b e8 1f ca c6 ff 4c 89 f7 48 c7 c6 a0 c6 12 84 e8 d0 b3 0f 00
>  ...
>  Call Trace:
>   <TASK>
>   nilfs_segctor_do_construct+0x4654/0x69d0 [nilfs2]
>   nilfs_segctor_construct+0x181/0x6b0 [nilfs2]
>   nilfs_segctor_thread+0x548/0x11c0 [nilfs2]
>   kthread+0x2f0/0x390
>   ret_from_fork+0x4b/0x80
>   ret_from_fork_asm+0x1a/0x30
>   </TASK>
> 
> This is because when the log writer starts a writeback for segment summary
> blocks or a super root block that use the backing device's page cache, it
> does not wait for the ongoing folio/page writeback, resulting in an
> inconsistent writeback state.
> 
> Fix this issue by waiting for ongoing writebacks when putting
> folios/pages on the backing device into writeback state.
> 
> Link: https://lkml.kernel.org/r/20240530141556.4411-1-konishi.ryusuke@gmail.com
> Fixes: 9ff05123e3bf ("nilfs2: segment constructor")
> Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> Please apply this patch to the stable trees indicated by the subject
> prefix instead of the patch that failed.
> 
> This patch is tailored to account for page/folio conversion and can
> be applied to v6.7 and earlier.
> 
> Also, all the builds and tests I did on each stable tree passed.

Now queued up, thanks.

greg k-h

