Return-Path: <stable+bounces-38062-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCCF8A0A52
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 09:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F7BE1C20AAC
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 07:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F211B13E03B;
	Thu, 11 Apr 2024 07:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="av+dU8rO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B112913DDC7
	for <stable@vger.kernel.org>; Thu, 11 Apr 2024 07:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712821465; cv=none; b=JuPGEsD4anjtMrXviujHmRzJEArxEkSP89daakaojFsFM0F5cfkL0g7GfBbqqD/apPRuoZ00DWv+eOHXnNWLc0sgIv6ERvD56PUqtl1TSwp0511kEA0DUVOh7lHWwjksEF0gwHo/mu4zY//vrf89z3MR0bK6EH6Yf1l2VAt0X5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712821465; c=relaxed/simple;
	bh=GntZbhEWsxB0o6eDBPzXvA5RdMeC5WE1L4A4hsObVNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GO9eRker0oBL9bUBIFUMOjacbJ3/vsMOoA7VpCt1wd7T+og2ygycTzzhivIlKv8u1jSn7rglxDv2CpzB/CuXO3YwO96jQQNhc9cIVaw6DLQYWh7lmnvMoAUJ5iZNPgG2KU7yh3STA6JOoTImhAVX5wiuMry0ljufbuJ/vXwJT3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=av+dU8rO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC10C433C7;
	Thu, 11 Apr 2024 07:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712821464;
	bh=GntZbhEWsxB0o6eDBPzXvA5RdMeC5WE1L4A4hsObVNI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=av+dU8rOlwG4GbWh/Nf6vtlkrPivMQ6XfNxgA6Q7avk6X/bgxuvlTy10qLxr3Oh3n
	 sfoETRUmIqvZv812AwXkDCujl4dxFRqytMHE3mAYLc/0k1hyCB1x14kTlZ1LssCxhc
	 hStM9zHNDSDI0qiQ2Z9GVYTzRRqI2vAX6RLvcnCE=
Date: Thu, 11 Apr 2024 09:44:21 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: David Hildenbrand <david@redhat.com>
Cc: stable@vger.kernel.org, stable@kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 6.1.y] virtio: reenable config if freezing device failed
Message-ID: <2024041112-thrash-unstylish-2cf5@gregkh>
References: <20240327121237.2829658-1-sashal@kernel.org>
 <20240410092758.151321-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410092758.151321-1-david@redhat.com>

On Wed, Apr 10, 2024 at 11:27:58AM +0200, David Hildenbrand wrote:
> Currently, we don't reenable the config if freezing the device failed.
> 
> For example, virtio-mem currently doesn't support suspend+resume, and
> trying to freeze the device will always fail. Afterwards, the device
> will no longer respond to resize requests, because it won't get notified
> about config changes.
> 
> Let's fix this by re-enabling the config if freezing fails.
> 
> Fixes: 22b7050a024d ("virtio: defer config changed notifications")
> Cc: <stable@kernel.org>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> Message-Id: <20240213135425.795001-1-david@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> (cherry picked from commit 310227f42882c52356b523e2f4e11690eebcd2ab)
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/virtio/virtio.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

All now queued up,t hanks.

greg k-h

