Return-Path: <stable+bounces-45666-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C928CD1A4
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 14:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73A431F22B2E
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 12:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2715B13B5B3;
	Thu, 23 May 2024 12:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fpn8Rvcu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D812113B5B0;
	Thu, 23 May 2024 12:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716465699; cv=none; b=DnffSxpKo7n0ktERCApom7sQa7KIGV1E2UZyJFDfjknqiegFTWJeF/4YaoB/dwtvoMPfZx4Y7ftZRfJkttMb6lVlAcj82ba43j2l6pstsVGROu1kjVZiTpN8Ec9sbaWKYsTVcnuVWd959geYn8ez9kOVx04zmwUthT3G8UlOdq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716465699; c=relaxed/simple;
	bh=h02E3oFYubYEDTBjPHWQMILPffcs9Y5ozx2D/Cpn738=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mdjb58sljqwoXM1+OZiC86qxQwlcQrD8f9dA0H++6qJxCzNLTyKvTINhx596xYaG4GiR8Eb92FbOGsNhjIB9rqobnniFrR7ZR9TZ+qgXzgD76zqmqBC2vVwc35npGj35wwXQL22vqwgL2Sjl4ado3C8XSje+GdC1bJNiOoSsRIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fpn8Rvcu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17325C2BD10;
	Thu, 23 May 2024 12:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716465698;
	bh=h02E3oFYubYEDTBjPHWQMILPffcs9Y5ozx2D/Cpn738=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fpn8RvcuUBRaz0NAFbRL3QRC+uHBJU3DeW2OxTGOqNvHMpY9AoFhxyqd/6nNPKCqg
	 B5c+Y6fTDx2jPGjC5aaJfpTBMawrkUOZ9zERlGDpYno8aPHMkS8hffWv2wznr2JqdX
	 SCXM0NgarcfTfVK2zuvxskahj0cQDQQeeFqexANY=
Date: Thu, 23 May 2024 14:01:35 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: stable@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	Baokun Li <libaokun1@huawei.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Jingbo Xu <jefflexu@linux.alibaba.com>, Chao Yu <chao@kernel.org>
Subject: Re: [PATCH 6.8.y 2/2] erofs: reliably distinguish block based and
 fscache mode
Message-ID: <2024052329-apostle-product-fced@gregkh>
References: <20240521065032.4192363-1-hsiangkao@linux.alibaba.com>
 <20240521065032.4192363-2-hsiangkao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521065032.4192363-2-hsiangkao@linux.alibaba.com>

On Tue, May 21, 2024 at 02:50:32PM +0800, Gao Xiang wrote:
> From: Christian Brauner <brauner@kernel.org>
> 
> commit 7af2ae1b1531feab5d38ec9c8f472dc6cceb4606 upstream.
> 
> When erofs_kill_sb() is called in block dev based mode, s_bdev may not
> have been initialised yet, and if CONFIG_EROFS_FS_ONDEMAND is enabled,
> it will be mistaken for fscache mode, and then attempt to free an anon_dev
> that has never been allocated, triggering the following warning:
> 
> ============================================
> ida_free called for id=0 which is not allocated.
> WARNING: CPU: 14 PID: 926 at lib/idr.c:525 ida_free+0x134/0x140
> Modules linked in:
> CPU: 14 PID: 926 Comm: mount Not tainted 6.9.0-rc3-dirty #630
> RIP: 0010:ida_free+0x134/0x140
> Call Trace:
>  <TASK>
>  erofs_kill_sb+0x81/0x90
>  deactivate_locked_super+0x35/0x80
>  get_tree_bdev+0x136/0x1e0
>  vfs_get_tree+0x2c/0xf0
>  do_new_mount+0x190/0x2f0
>  [...]
> ============================================
> 
> Now when erofs_kill_sb() is called, erofs_sb_info must have been
> initialised, so use sbi->fsid to distinguish between the two modes.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Reviewed-by: Chao Yu <chao@kernel.org>
> Link: https://lore.kernel.org/r/20240419123611.947084-3-libaokun1@huawei.com
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/super.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)

All now queued up, thanks.

greg k-h

