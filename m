Return-Path: <stable+bounces-41628-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E1D8B55F6
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 13:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A28F61C23529
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 11:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92403BBFE;
	Mon, 29 Apr 2024 11:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zVjs+rUU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB6E2DF84
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 11:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714388646; cv=none; b=sS64OuFzZNvj1DeW56wv9Bq6HDRp2frfU7u3CjSuATQGt/g6rPq/lvMrvp9mOHIczdajP0G6usmThPlGnOIjoJWIvMkdGTyVWe18A0EVaGScIeapvvN3qHMOBP2dC13QpESXWFvIfyWcXhvLt+KSf95MbKo1V0Uk1Xh/pkmuJMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714388646; c=relaxed/simple;
	bh=dDZJAokPlyONfexGRVyPKTvl3211jYrI0Yo63JDuVng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tWTAYAcLPLzEdwFtLHxF+/y+2M/uWMcCC8UdlbTaNbloskgROv6tP3neKNMRQtv1WtJewbhz1hC4cSfaJRaJmshtPeUWWMvFgP75oK6qQtTmFyy1z3tJaX8GlJTrWzFCWKTsFZjpFmQ8Qi2ZCpc3S3MGt0pTT07/eAp4ZZCxjeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zVjs+rUU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A62B7C113CD;
	Mon, 29 Apr 2024 11:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714388646;
	bh=dDZJAokPlyONfexGRVyPKTvl3211jYrI0Yo63JDuVng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zVjs+rUUwlAowsvyfotajioUzGuQjJ1x+vDst0SWfPtkT743FKpbTB1f3KG38CH8D
	 +VydJU1w2HE2f9H3FxZxeFxSVK1vtyMwxP0IbLExB9CH9AUngCLJSyvJabSBvkOsza
	 26qu+YoKtHKLvpsoxbK32JwSYcwIcJjUUQCM19HY=
Date: Mon, 29 Apr 2024 13:04:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Konstantin Ovsepian <ovs@ovs.to>
Cc: stable@vger.kernel.org, davem@davemloft.net, hengqi@linux.alibaba.com,
	leitao@debian.org, xuanzhuo@linux.alibaba.com, ovs@meta.com,
	qemu-devel@nongnu.org
Subject: Re: [PATCH 6.1.y] virtio_net: Do not send RSS key if it is not
 supported
Message-ID: <2024042953-husked-nurture-4641@gregkh>
References: <2024041414-humming-alarm-eb41@gregkh>
 <20240424105704.182708-1-ovs@ovs.to>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424105704.182708-1-ovs@ovs.to>

On Wed, Apr 24, 2024 at 03:57:04AM -0700, Konstantin Ovsepian wrote:
> From: Breno Leitao <leitao@debian.org>
> 
> commit 059a49aa2e25c58f90b50151f109dd3c4cdb3a47 upstream
> 
> There is a bug when setting the RSS options in virtio_net that can break
> the whole machine, getting the kernel into an infinite loop.
> 
> Running the following command in any QEMU virtual machine with virtionet
> will reproduce this problem:
> 
>     # ethtool -X eth0  hfunc toeplitz
> 
> This is how the problem happens:
> 
> 1) ethtool_set_rxfh() calls virtnet_set_rxfh()
> 
> 2) virtnet_set_rxfh() calls virtnet_commit_rss_command()
> 
> 3) virtnet_commit_rss_command() populates 4 entries for the rss
> scatter-gather
> 
> 4) Since the command above does not have a key, then the last
> scatter-gatter entry will be zeroed, since rss_key_size == 0.
> sg_buf_size = vi->rss_key_size;
> 
> 5) This buffer is passed to qemu, but qemu is not happy with a buffer
> with zero length, and do the following in virtqueue_map_desc() (QEMU
> function):
> 
>   if (!sz) {
>       virtio_error(vdev, "virtio: zero sized buffers are not allowed");
> 
> 6) virtio_error() (also QEMU function) set the device as broken
> 
>     vdev->broken = true;
> 
> 7) Qemu bails out, and do not repond this crazy kernel.
> 
> 8) The kernel is waiting for the response to come back (function
> virtnet_send_command())
> 
> 9) The kernel is waiting doing the following :
> 
>       while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> 	     !virtqueue_is_broken(vi->cvq))
> 	      cpu_relax();
> 
> 10) None of the following functions above is true, thus, the kernel
> loops here forever. Keeping in mind that virtqueue_is_broken() does
> not look at the qemu `vdev->broken`, so, it never realizes that the
> vitio is broken at QEMU side.
> 
> Fix it by not sending RSS commands if the feature is not available in
> the device.
> 
> Fixes: c7114b1249fa ("drivers/net/virtio_net: Added basic RSS support.")
> Cc: stable@vger.kernel.org
> Cc: qemu-devel@nongnu.org
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Reviewed-by: Heng Qi <hengqi@linux.alibaba.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> (cherry picked from commit 059a49aa2e25c58f90b50151f109dd3c4cdb3a47)
> Signed-off-by: Konstantin Ovsepian <ovs@ovs.to>
> ---
>  drivers/net/virtio_net.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)

Now queued up,t hanks.

greg k-h

