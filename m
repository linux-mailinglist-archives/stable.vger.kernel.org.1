Return-Path: <stable+bounces-5347-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C13780CAC4
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 14:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02B1C1F2160F
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 13:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB033E465;
	Mon, 11 Dec 2023 13:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jY0wlhI/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706553D96A
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 13:21:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 711C9C433C7;
	Mon, 11 Dec 2023 13:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702300889;
	bh=ouz5H8/ogB3hwmNQH/kIZ1Cv9NzNLzeF7rBWobpYydk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jY0wlhI/Po8zrzGSxJ2aLYGsh9KDsj9+jwwgQo1JRSu07FTvahJcGhy8dEVgciRZq
	 Jy8QQgK34UgoTsqGCysJrkxnu89ESchbnGnzxSHkdytu3YrH3lB4X2NXpjcnj1fhqN
	 RK650cBsw4cFuhIwiO50ILa/5Mcl5lGGxcxoFcPI=
Date: Mon, 11 Dec 2023 14:21:27 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 4.14 4.19 5.4] nilfs2: fix missing error check for
 sb_set_blocksize call
Message-ID: <2023121112-kitty-scarily-b463@gregkh>
References: <CAKFNMokAa1hUUL95wxCZRXzLMuOPiQ6Cu0yOrcdbKvW=zT1z0g@mail.gmail.com>
 <20231210072648.3054-1-konishi.ryusuke@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231210072648.3054-1-konishi.ryusuke@gmail.com>

On Sun, Dec 10, 2023 at 04:26:48PM +0900, Ryusuke Konishi wrote:
> commit d61d0ab573649789bf9eb909c89a1a193b2e3d10 upstream.
> 
> When mounting a filesystem image with a block size larger than the page
> size, nilfs2 repeatedly outputs long error messages with stack traces to
> the kernel log, such as the following:
> 
>  getblk(): invalid block size 8192 requested
>  logical block size: 512
>  ...
>  Call Trace:
>   dump_stack_lvl+0x92/0xd4
>   dump_stack+0xd/0x10
>   bdev_getblk+0x33a/0x354
>   __breadahead+0x11/0x80
>   nilfs_search_super_root+0xe2/0x704 [nilfs2]
>   load_nilfs+0x72/0x504 [nilfs2]
>   nilfs_mount+0x30f/0x518 [nilfs2]
>   legacy_get_tree+0x1b/0x40
>   vfs_get_tree+0x18/0xc4
>   path_mount+0x786/0xa88
>   __ia32_sys_mount+0x147/0x1a8
>   __do_fast_syscall_32+0x56/0xc8
>   do_fast_syscall_32+0x29/0x58
>   do_SYSENTER_32+0x15/0x18
>   entry_SYSENTER_32+0x98/0xf1
>  ...
> 
> This overloads the system logger.  And to make matters worse, it sometimes
> crashes the kernel with a memory access violation.
> 
> This is because the return value of the sb_set_blocksize() call, which
> should be checked for errors, is not checked.
> 
> The latter issue is due to out-of-buffer memory being accessed based on a
> large block size that caused sb_set_blocksize() to fail for buffers read
> with the initial minimum block size that remained unupdated in the
> super_block structure.
> 
> Since nilfs2 mkfs tool does not accept block sizes larger than the system
> page size, this has been overlooked.  However, it is possible to create
> this situation by intentionally modifying the tool or by passing a
> filesystem image created on a system with a large page size to a system
> with a smaller page size and mounting it.
> 
> Fix this issue by inserting the expected error handling for the call to
> sb_set_blocksize().
> 
> Link: https://lkml.kernel.org/r/20231129141547.4726-1-konishi.ryusuke@gmail.com
> Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> Please apply this patch to the stable trees indicated by the subject line
> prefix, instead of the patch I asked you to drop earlier.
> 
> In this patch, "nilfs_err()" is replaced with its equivalent since it
> doesn't yet exist in these kernels.  With this tweak, this patch is
> applicable from v4.8 to v5.8.  Also this patch has been tested against
> these three stable trees.

Now replaced with this version, thanks for catching this!

greg k-h

