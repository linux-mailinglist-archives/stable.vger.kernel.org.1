Return-Path: <stable+bounces-20673-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDAC85AAF5
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 19:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C9E81C21085
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 18:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3C2481B3;
	Mon, 19 Feb 2024 18:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rZJ6ntiL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C652482C6
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 18:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708367368; cv=none; b=agZ1biF22z/bF/8kXgRsAAi9Zr9Q03TPWsC2h7RtDPxa5YMRpqKehbMmzDcS6Ww7RnqQrDxpvTIPf821PbHmIpgSfpLzjidR/9C0A9byhAWaV0nnSTNuxe/KftxMtTjZWKBLChJDB7YpRT1uDVhpopjFA5A877bhDDh4Wf+iDC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708367368; c=relaxed/simple;
	bh=VFjcCGau1HXqBUcYBXF5zIRc/ZFrGI+E9kDjZkPkzgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZ3J4DRKWRWnQySEs8MEMAY4rLhsDJ2r3UK1TeSbdRbpAOl4gpZrS7L8odl+rJLhH0D8ElXgtcF+7XbmV6egoRrehYrB0AgfLnrpLpi4QCnl8PyyTxAfaqBIrZfrqa45AculAvJSQ1+OIOUSDZtBouIB5ExJN4nxo0LYrBXYsHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rZJ6ntiL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 417D9C433C7;
	Mon, 19 Feb 2024 18:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708367367;
	bh=VFjcCGau1HXqBUcYBXF5zIRc/ZFrGI+E9kDjZkPkzgg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rZJ6ntiL1Utl6HnALV1rjtT9nlJXL022Rl+opVuyaw39+GB1AhrghprZcCZpM9GVW
	 aRtx0okBDIG5nUg9U7XEkNOLiGXu2OJVzV70Apc7TnAn48lRc1WLsyU+mvFgUet+5N
	 h8JtB6FmH3ccr2++5zBP22HG6NAYJPkoOIT/b1QM=
Date: Mon, 19 Feb 2024 19:29:24 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.6 6.7] nilfs2: fix hang in
 nilfs_lookup_dirty_data_buffers()
Message-ID: <2024021917-lash-scowling-1692@gregkh>
References: <20240214110110.6331-1-konishi.ryusuke@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214110110.6331-1-konishi.ryusuke@gmail.com>

On Wed, Feb 14, 2024 at 08:01:10PM +0900, Ryusuke Konishi wrote:
> commit 38296afe3c6ee07319e01bb249aa4bb47c07b534 upstream.
> 
> Syzbot reported a hang issue in migrate_pages_batch() called by mbind()
> and nilfs_lookup_dirty_data_buffers() called in the log writer of nilfs2.
> 
> While migrate_pages_batch() locks a folio and waits for the writeback to
> complete, the log writer thread that should bring the writeback to
> completion picks up the folio being written back in
> nilfs_lookup_dirty_data_buffers() that it calls for subsequent log
> creation and was trying to lock the folio.  Thus causing a deadlock.
> 
> In the first place, it is unexpected that folios/pages in the middle of
> writeback will be updated and become dirty.  Nilfs2 adds a checksum to
> verify the validity of the log being written and uses it for recovery at
> mount, so data changes during writeback are suppressed.  Since this is
> broken, an unclean shutdown could potentially cause recovery to fail.
> 
> Investigation revealed that the root cause is that the wait for writeback
> completion in nilfs_page_mkwrite() is conditional, and if the backing
> device does not require stable writes, data may be modified without
> waiting.
> 
> Fix these issues by making nilfs_page_mkwrite() wait for writeback to
> finish regardless of the stable write requirement of the backing device.
> 
> Link: https://lkml.kernel.org/r/20240131145657.4209-1-konishi.ryusuke@gmail.com
> Fixes: 1d1d1a767206 ("mm: only enforce stable page writes if the backing device requires it")
> Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> Reported-by: syzbot+ee2ae68da3b22d04cd8d@syzkaller.appspotmail.com
> Closes: https://lkml.kernel.org/r/00000000000047d819061004ad6c@google.com
> Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> Please apply this patch to the stable trees indicated by the subject line
> prefix.
> 
> These versions do not yet have page-to-folio conversion applied to the
> target function, so page-based "wait_on_page_writeback()" is used instead
> of "folio_wait_writeback()" in this patch.  This did not apply as-is to
> v6.5 and earlier versions due to an fs-wide change.  So I would like to
> post a separate patch for earlier stable trees.

All now queued up, thanks!

greg k-h

