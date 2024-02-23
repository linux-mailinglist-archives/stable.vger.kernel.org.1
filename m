Return-Path: <stable+bounces-23497-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1D886162A
	for <lists+stable@lfdr.de>; Fri, 23 Feb 2024 16:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0348B20F45
	for <lists+stable@lfdr.de>; Fri, 23 Feb 2024 15:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC57F82866;
	Fri, 23 Feb 2024 15:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mwWCZzz1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF19560260
	for <stable@vger.kernel.org>; Fri, 23 Feb 2024 15:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708703117; cv=none; b=EuI05IjRIlW5XoJcN5TFmdBi0Sw3R7UNlxo2X+af0vTgE2ntaYCyI6ahhpzncXZhLjaB6GRa2Av0lZhwWEh1R7mYHy62dvFgHfUY8CdPV2SNHEkgsrlIFq2xte4/FjKmIEonaoH8x8f78LiHDl1Kml0rJW6ORa+tYdo8ZJfhHII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708703117; c=relaxed/simple;
	bh=Ap1OGXERk+IgBj6y6b8o56Q0ZiE77FfKzQVmEVGIeco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a6n1Zhl2jSPGCpJCbYbUeBamwwPEj9ANfpK91/RtoMRUVmHTv4dYJP7hHdpwcM6D0aZBESncvyHBGC1LOnJLbOzckZOSQku6rEpPNDrOHGE7VGlrfOZKmtWVtQBorr7pP90vO2iBwQOsYKaBpLIq+R+268/on+fg5eosKmOHatk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mwWCZzz1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E322DC433F1;
	Fri, 23 Feb 2024 15:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708703117;
	bh=Ap1OGXERk+IgBj6y6b8o56Q0ZiE77FfKzQVmEVGIeco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mwWCZzz1TNuDBZ5CelBnPXcku8moO3QrV2b6jFb/teoIVj+FGXxRy0m8tQtczDpxt
	 ++3zRXO4yaWrqBQI8OoAMWkLE+ZSEdWU20oKpNl2tFV1kUUHtsxhkarb8McnJRos8/
	 6a2DcxULj9rZkesPizbeCntCm7oJurzQ07akfyK4=
Date: Fri, 23 Feb 2024 16:45:14 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 4.19 5.4] nilfs2: replace WARN_ONs for invalid DAT
 metadata block requests
Message-ID: <2024022308-stamp-unwelcome-81f9@gregkh>
References: <20240221163624.3831-1-konishi.ryusuke@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221163624.3831-1-konishi.ryusuke@gmail.com>

On Thu, Feb 22, 2024 at 01:36:24AM +0900, Ryusuke Konishi wrote:
> commit 5124a0a549857c4b87173280e192eea24dea72ad upstream.
> 
> If DAT metadata file block access fails due to corruption of the DAT file
> or abnormal virtual block numbers held by b-trees or inodes, a kernel
> warning is generated.
> 
> This replaces the WARN_ONs by error output, so that a kernel, booted with
> panic_on_warn, does not panic.  This patch also replaces the detected
> return code -ENOENT with another internal code -EINVAL to notify the bmap
> layer of metadata corruption.  When the bmap layer sees -EINVAL, it
> handles the abnormal situation with nilfs_bmap_convert_error() and finally
> returns code -EIO as it should.
> 
> Link: https://lkml.kernel.org/r/0000000000005cc3d205ea23ddcf@google.com
> Link: https://lkml.kernel.org/r/20230126164114.6911-1-konishi.ryusuke@gmail.com
> Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> Reported-by: <syzbot+5d5d25f90f195a3cfcb4@syzkaller.appspotmail.com>
> Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> Please use this patch for these versions instead of the patch I asked
> you to drop in the previous review comments.
> 
> This replacement patch uses an equivalent call using nilfs_msg()
> instead of nilfs_err(), which does not exist in these versions.

Now queued up, thanks.

greg k-h

