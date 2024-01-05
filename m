Return-Path: <stable+bounces-9796-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 791F7825567
	for <lists+stable@lfdr.de>; Fri,  5 Jan 2024 15:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 942411C22E86
	for <lists+stable@lfdr.de>; Fri,  5 Jan 2024 14:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D121E4A9;
	Fri,  5 Jan 2024 14:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x8baXqh5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F9A2D051
	for <stable@vger.kernel.org>; Fri,  5 Jan 2024 14:34:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA163C433C8;
	Fri,  5 Jan 2024 14:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704465275;
	bh=zGhz4HK3OqtoT/s7fHpDT0nLKMtykEIhvfAADd+RUpc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=x8baXqh5mpSOXAlekxjBBlbAJ0N/7Vm+hMJPgEoLHVeYPKpTWflYJVwgUSMlAhn4X
	 pW8tbuJ+0Ijd7HjSRp94oZybG+DsL6GOuU+Mz8iy/Ps7DmpI4B34yIKd73teYKpf/u
	 myLBKBkGE0mTZFF3Jw1XE3bNnEIvBVexroWt0nbY=
Date: Fri, 5 Jan 2024 15:34:32 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Sarthak Kukreti <sarthakkukreti@chromium.org>
Cc: stable@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 4.14.y] block: Don't invalidate pagecache for invalid
 falloc modes
Message-ID: <2024010520-arming-resonate-825b@gregkh>
References: <2023101517-patriarch-reuse-cc1c@gregkh>
 <20240104222745.1783780-1-sarthakkukreti@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104222745.1783780-1-sarthakkukreti@chromium.org>

On Thu, Jan 04, 2024 at 02:27:45PM -0800, Sarthak Kukreti wrote:
> Only call truncate_bdev_range() if the fallocate mode is supported. This
> fixes a bug where data in the pagecache could be invalidated if the
> fallocate() was called on the block device with an invalid mode.
> 
> Fixes: 25f4c41415e5 ("block: implement (some of) fallocate for block devices")
> Cc: stable@vger.kernel.org
> Reported-by: "Darrick J. Wong" <djwong@kernel.org>
> Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> Link: https://lore.kernel.org/r/20231011201230.750105-1-sarthakkukreti@chromium.org
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> (cherry picked from commit 1364a3c391aedfeb32aa025303ead3d7c91cdf9d)
> Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> ---
>  fs/block_dev.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

All now queued up, thanks for the backports.

greg k-h

