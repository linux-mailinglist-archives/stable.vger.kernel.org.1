Return-Path: <stable+bounces-5505-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B61B80CEC2
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 15:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA0DE1F21383
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 14:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDAA495F9;
	Mon, 11 Dec 2023 14:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Lr0A/IQz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7BA495EE;
	Mon, 11 Dec 2023 14:56:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B8FC433C8;
	Mon, 11 Dec 2023 14:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702306596;
	bh=yeGJvoAhrRUdjjLyjIJiQRRidjJWgvKa+3GL2nDVUtM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lr0A/IQzptm9L/e+o5KMT9FMS3j80GX6sEJbS6KS607y4WTzHTs6rXMSTMV+TjcFK
	 46Nr8O+JVoKoj9tJ88rsIM6K6+jL+E7IUF6VFHYLuqvpT2SuSLCb/C4wzJ2PfKSFwL
	 HbgUe7TcvMQgCp+JN5/Xm2LcjIeh7TkbvyEwWxFw=
Date: Mon, 11 Dec 2023 15:56:31 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com
Subject: Re: [PATCH 5.4 00/90] 5.4.263-rc3 review
Message-ID: <2023121118-snagged-ninja-7efb@gregkh>
References: <20231205183241.636315882@linuxfoundation.org>
 <5b0eb360-3765-40e1-854a-9da6d97eb405@roeck-us.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b0eb360-3765-40e1-854a-9da6d97eb405@roeck-us.net>

On Fri, Dec 08, 2023 at 10:09:17AM -0800, Guenter Roeck wrote:
> On 12/5/23 11:22, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.4.263 release.
> > There are 90 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu, 07 Dec 2023 18:32:16 +0000.
> > Anything received after that time might be too late.
> > 
> [ ... ]
> > Qu Wenruo <wqu@suse.com>
> >      btrfs: add dmesg output for first mount and last unmount of a filesystem
> > 
> 
> This patch results in the following code in fs/btrfs/disk-io.c:open_ctree():
> 
> 	struct btrfs_super_block *disk_super;
> 	... (no access to disk_super)
> 	btrfs_info(fs_info, "first mount of filesystem %pU", disk_super->fsid);
> 
> which I would assume _should_ result in btrfs crashes. No idea why that isn't
> actually happening or why gcc doesn't complain. Building allmodconfig with
> clang does complain, but doesn't bail out.
> 
> s/btrfs/disk-io.c:2832:55: warning: variable 'disk_super' is uninitialized when used here [-Wuninitialized]
>         btrfs_info(fs_info, "first mount of filesystem %pU", disk_super->fsid);
>                                                              ^~~~~~~~~~
> 
> The actual log output is:
> 
> [    7.302427] BTRFS info (device nvme0n1): first mount of filesystem (efault)
> 
> It might be a good idea to either revert this patch or fix it up
> (though I don't know how to fix it up).

yeah, that doesn't look good, now reverted, thanks!

greg k-h

