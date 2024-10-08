Return-Path: <stable+bounces-81557-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 887DA9944F8
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 12:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC8FF287CA7
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 10:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B881A78276;
	Tue,  8 Oct 2024 10:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JbnAyAuY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768F3178CE4
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 10:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728381695; cv=none; b=haLxL2jv94Z9OewW0h460jzicqO7/VDClx5Xx1P84qQ+Ogcw7hsH13sisgp1seZajOFvALheW7PmAD5fsSQZcoLwlNdgUykNJWeoOPxn6RJAFFEzlSXTRWCCjYg1XUzYxHlkcWydIS7L0gpEz531nVXFonfWYUDQufTNmMkyHHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728381695; c=relaxed/simple;
	bh=uFReK3umy3wpzZkc/PIXjIPAZAmsscD5Xjl1RzpQ4zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=USn9d59Uywy2bI3U7D54z/B77uyDJMQaju8lPZJZioHEFBemXng0a3/bU9r1FvvM+3ClsdQEdmVbjFKXcPoaDoAXU0IBiKpo4nhA7+x98uQK2/2tAxK2h9Xg+a7bul1CfoRwsxzDwoXxaO95TdwkF9iGRkQWh65cgZPKnQksSy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JbnAyAuY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5352C4CECD;
	Tue,  8 Oct 2024 10:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728381695;
	bh=uFReK3umy3wpzZkc/PIXjIPAZAmsscD5Xjl1RzpQ4zw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JbnAyAuYytn2l3hKW3y2whSxcmYKEvUDak82Lf59pEWjFHBzE9fWDK2vOyvXe+NFi
	 JYFzCgrwICyV3Vqx/9cByrxkmEE3CQ2t48/OqjwwMHpHnOALCm107jBlAjSZnFZLTU
	 NADIvf7tbCUNZtzsQeoDdJfaiFqXL+0C5p90x8Nw=
Date: Tue, 8 Oct 2024 12:01:32 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Christoph Hellwig <hch@infradead.org>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	kernel-dev@igalia.com
Subject: Re: [PATCH 5.15,6.1 0/3] Fix block integrity violation of kobject
 rules
Message-ID: <2024100824-provable-unwed-aeea@gregkh>
References: <20241002140123.2311471-1-cascardo@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241002140123.2311471-1-cascardo@igalia.com>

On Wed, Oct 02, 2024 at 11:01:19AM -0300, Thadeu Lima de Souza Cascardo wrote:
> integrity_kobj did not have a release function and with
> CONFIG_DEBUG_KOBJECT_RELEASE, a use-after-free would be triggered as its
> holding struct gendisk would be freed without relying on its refcount.
> 
> Thomas Weißschuh (3):
>   blk-integrity: use sysfs_emit
>   blk-integrity: convert to struct device_attribute
>   blk-integrity: register sysfs attributes on struct device
> 
>  block/blk-integrity.c  | 175 ++++++++++++++---------------------------
>  block/blk.h            |  10 +--
>  block/genhd.c          |  12 +--
>  include/linux/blkdev.h |   3 -
>  4 files changed, 66 insertions(+), 134 deletions(-)
> 
> -- 
> 2.34.1
> 
> 

This series is crazy to apply, you have 1 different patch for two
branches branch, and 2 for both, meaning I can't just apply a normal
series at all.  Would you want to recieve such a thing?

Please resubmit these as 2 different series so they can be applied like
normal.

thanks,

greg k-h

