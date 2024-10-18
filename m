Return-Path: <stable+bounces-86792-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 989D79A3911
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 10:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 392281F21B02
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 08:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D285418EFDC;
	Fri, 18 Oct 2024 08:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EaaKvKW8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7144F18E74D
	for <stable@vger.kernel.org>; Fri, 18 Oct 2024 08:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729241378; cv=none; b=bRXJCikz8WFB/WtlTSTamWo/vOVmo1JWoT5Q1TfAd5IRHSQ3mxc7bJL0MmhonU/jevwrJmMlUXWPg1/VWSI+JHdS9OnoVz/GNlAtRFCuZZ7XK+lLP3AIt0g6msyczaQh11L6ogxq3ma80mSXx2k3FdVsLAdezCV5NYY8zCPvaPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729241378; c=relaxed/simple;
	bh=c0GpjwIsbZdM9CRxEhlW+x8BR4baY6JErWFjliDA0bA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FoYRK+Uekpflv/K6ed2WHbCazDqpKztososDY3ruy3Z38MWO1aPAgZIQrQVVAa9HsNVn5K+5j22NSz3b0Lu5yLjth3uY/TnH0qlyelBgOlvbi2sky0fsWOI1tfR7wi/UtrLoYCYkx7LpfYKfMb1DHcF1pyuQdk0LuXRycsmB32I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EaaKvKW8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E077C4CEC3;
	Fri, 18 Oct 2024 08:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729241377;
	bh=c0GpjwIsbZdM9CRxEhlW+x8BR4baY6JErWFjliDA0bA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EaaKvKW8Qthz0BoczJXbaz3kedq+83YcWBOmGC9JPMPLgHOEvwTk3HqYHgoqHVTTJ
	 J6UqnxTY6WlVJNpVfKjqtjsoEz9REx8ZElmzhFoOvf4XFmQVNvoa2j4KOsgCbJ1s3z
	 EZz/Hj7zwqM6rP7w3A4uwAv10tcEAr5gAQIqGq8Q=
Date: Fri, 18 Oct 2024 10:49:34 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Puranjay Mohan <pjy@amazon.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, stable@vger.kernel.org,
	puranjay12@gmail.com, amazon-linux-kernel@amazon.com
Subject: Re: [PATCH 6.1.y] nvme: fix metadata handling in nvme-passthrough
Message-ID: <2024101848-paparazzi-cornea-6389@gregkh>
References: <20241016090739.43470-1-pjy@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016090739.43470-1-pjy@amazon.com>

On Wed, Oct 16, 2024 at 09:07:39AM +0000, Puranjay Mohan wrote:
> [ Upstream commit 7c2fd76048e95dd267055b5f5e0a48e6e7c81fd9 ]
> 
> On an NVMe namespace that does not support metadata, it is possible to
> send an IO command with metadata through io-passthru. This allows issues
> like [1] to trigger in the completion code path.
> nvme_map_user_request() doesn't check if the namespace supports metadata
> before sending it forward. It also allows admin commands with metadata to
> be processed as it ignores metadata when bdev == NULL and may report
> success.
> 
> Reject an IO command with metadata when the NVMe namespace doesn't
> support it and reject an admin command if it has metadata.
> 
> [1] https://lore.kernel.org/all/mb61pcylvnym8.fsf@amazon.com/
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> [ Minor changes to make it work on 6.1 ]

What about 6.6?  And 5.15?  We can't take patches for only some
branches, otherwise when you upgrade you would have regressions.

Please send ALL needed patches and then we will be glad to queue them
up.  I've dropped the two submissions you sent for now.

thanks,

greg k-h

