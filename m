Return-Path: <stable+bounces-112009-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 681BBA2582C
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 12:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B8F07A25B1
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 11:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598DD202F97;
	Mon,  3 Feb 2025 11:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0ng8D+xf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18120202F93
	for <stable@vger.kernel.org>; Mon,  3 Feb 2025 11:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738582162; cv=none; b=SCPDlwsNZO+a23r4k1EZ12FfH9yvVixI/7LVgPuDGjmghCijjisUuw7boCBuJbehqnV1bpsraYh7I6MFI77zLHdwrFGE6GSo7EeH59JgIFtlwuoIHBi98divXeE7uaPupOJZQylMsCofBpWOiaMCxgoEw0BEl/qp0yfLVRNbG2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738582162; c=relaxed/simple;
	bh=GTJX8jjH2ChOwfEl5V8O3H45tU8nYOpkKXDTQxiaHgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jM1v2njvpdZaL33ZcTBXyneumF1r5OrUg8MKeQE2CfNw4FMC7/Pk7600jxSWyOIRZa+bOXRaLfsPr30cUjSt/cNFLDrj95CJOzSMDJEJD0KcesqiYX9FsTj30i1PqKxh2yHWYp+W4AzaydktLx2b/wuuMSzdZJUWRrms8vHcbso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0ng8D+xf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE7B6C4CED2;
	Mon,  3 Feb 2025 11:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738582161;
	bh=GTJX8jjH2ChOwfEl5V8O3H45tU8nYOpkKXDTQxiaHgE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0ng8D+xfBTybdpORKFfWAhuSz5QULhHwMtJY2+LGnawNKcICR6QWWvcMsCKRmhNja
	 3cPE6P6UeJ5hP+z6dBSHl37IXNpBDxopSVLEMunxgATSJN9umhOT8odjqB2ksBBjUf
	 yJ+YJ/dVwTJ19k0bQuFMVG4YscfFvYJAJPtAVRmk=
Date: Mon, 3 Feb 2025 12:29:17 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Shubham Pushpkar <spushpka@cisco.com>
Cc: stable@vger.kernel.org
Subject: Re: [Fix CVE-2024-50217 in v6.6.y] [PATCH] btrfs: fix use-after-free
 of block device file in __btrfs_free_extra_devids()
Message-ID: <2025020310-daydream-crop-4269@gregkh>
References: <20250203104254.4146544-1-spushpka@cisco.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250203104254.4146544-1-spushpka@cisco.com>

On Mon, Feb 03, 2025 at 02:42:54AM -0800, Shubham Pushpkar wrote:
> From: Zhihao Cheng <chengzhihao1@huawei.com>
> 
> commit aec8e6bf839101784f3ef037dcdb9432c3f32343 ("btrfs:
> fix use-after-free of block device file in __btrfs_free_extra_devids()")
> 
> Mounting btrfs from two images (which have the same one fsid and two
> different dev_uuids) in certain executing order may trigger an UAF for
> variable 'device->bdev_file' in __btrfs_free_extra_devids(). And
> following are the details:
> 
> 1. Attach image_1 to loop0, attach image_2 to loop1, and scan btrfs
>    devices by ioctl(BTRFS_IOC_SCAN_DEV):
> 
>              /  btrfs_device_1 → loop0
>    fs_device
>              \  btrfs_device_2 → loop1
> 2. mount /dev/loop0 /mnt
>    btrfs_open_devices
>     btrfs_device_1->bdev_file = btrfs_get_bdev_and_sb(loop0)
>     btrfs_device_2->bdev_file = btrfs_get_bdev_and_sb(loop1)
>    btrfs_fill_super
>     open_ctree
>      fail: btrfs_close_devices // -ENOMEM
> 	    btrfs_close_bdev(btrfs_device_1)
>              fput(btrfs_device_1->bdev_file)
> 	      // btrfs_device_1->bdev_file is freed
> 	    btrfs_close_bdev(btrfs_device_2)
>              fput(btrfs_device_2->bdev_file)
> 
> 3. mount /dev/loop1 /mnt
>    btrfs_open_devices
>     btrfs_get_bdev_and_sb(&bdev_file)
>      // EIO, btrfs_device_1->bdev_file is not assigned,
>      // which points to a freed memory area
>     btrfs_device_2->bdev_file = btrfs_get_bdev_and_sb(loop1)
>    btrfs_fill_super
>     open_ctree
>      btrfs_free_extra_devids
>       if (btrfs_device_1->bdev_file)
>        fput(btrfs_device_1->bdev_file) // UAF !
> 
> Fix it by setting 'device->bdev_file' as 'NULL' after closing the
> btrfs_device in btrfs_close_one_device().
> 
> Fixes: CVE-2024-50217

Nit, as we assign CVEs _after_ a commit happens, there's no need to add
this to a commit here as it is implied by the assignment database of
cves-to-commits.

Also, any specific reason you didn't cc: everyone involved in this
commit for your backport as well?

thanks,

greg k-h

