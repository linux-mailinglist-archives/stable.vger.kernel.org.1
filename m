Return-Path: <stable+bounces-108377-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC10A0B233
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 10:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CF5E188895B
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 09:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B567023A586;
	Mon, 13 Jan 2025 09:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Esc745qO"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB2F2397BC
	for <stable@vger.kernel.org>; Mon, 13 Jan 2025 09:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736758882; cv=none; b=i9SEThccvR7lPvwHfTOigPuXdWx0VzU52FI7kWSeK3yYWjRE1WYAEmO1+cDgmUx7BypoPu+sw28F44TVLSl2dXZW1o9V53V1QJzH0VRPlcUC170WV4yKeInylOgkJ0MMpSLaOUVGoCyQWbXdn7CPrMfJTW9sCL7BPcN6euYDgws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736758882; c=relaxed/simple;
	bh=QfxFDE/SxN65YW8tROnk89UHpBfj2EpK7USnpplK1hA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pm+Jbs2ViwKRuBRgUz6w615V4rvIOL3nbyUPARLh8pUfCGquqQEjbiqzh+GVw4XjIYPVh0mf0bWnGvCec82S+FblZH0e1g15VxosfLrC+8yhqAX1hLlA+UD6IR8EIuqZrafVS8pCF+eQyZ4l2LYBBf0gE+mlvl77uhSNpFmME44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Esc745qO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736758880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bg84P2K9ssfrVByrnuh9eaewIWJz6nPH137Kv912h5Y=;
	b=Esc745qOW5A46+xDgESCUUX0fIetQZWKHFX9SlajLRnuTyVz4RRdcmilZch/S5HlkP5O5G
	VSXdr8QXUFJqtSccC/EsIFQXVrd/tpacgNpon2Oxr7eOS9Sk1UufYtvOPxAgtqSIRy5NKI
	MjQX/ZDmuZb+wW+kbQ0ry1M7WOWTnBs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-77-XNn9SKZQMqqh7Q_yC_NeJw-1; Mon,
 13 Jan 2025 04:01:16 -0500
X-MC-Unique: XNn9SKZQMqqh7Q_yC_NeJw-1
X-Mimecast-MFC-AGG-ID: XNn9SKZQMqqh7Q_yC_NeJw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B5E7019560B9;
	Mon, 13 Jan 2025 09:01:14 +0000 (UTC)
Received: from fedora (unknown [10.72.116.4])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BCA4919560AD;
	Mon, 13 Jan 2025 09:01:09 +0000 (UTC)
Date: Mon, 13 Jan 2025 17:01:04 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	John Garry <john.g.garry@oracle.com>, stable@vger.kernel.org
Subject: Re: [PATCH V2] block: mark GFP_NOIO around sysfs ->store()
Message-ID: <Z4TWUCoZV_NVzHMa@fedora>
References: <20250113084103.762630-1-ming.lei@redhat.com>
 <076ee902633a7293393748cb972cc4a7743ec5c1.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <076ee902633a7293393748cb972cc4a7743ec5c1.camel@linux.intel.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Mon, Jan 13, 2025 at 09:50:37AM +0100, Thomas Hellstr�m wrote:
> Hi!
> 
> On Mon, 2025-01-13 at 16:41 +0800, Ming Lei wrote:
> > sysfs ->store is called with queue freezed, meantime we have several
> > ->store() callbacks(update_nr_requests, wbt, scheduler) to allocate
> > memory with GFP_KERNEL which may run into direct reclaim code path,
> > then potential deadlock can be caused.
> > 
> > Fix the issue by marking NOIO around sysfs ->store()
> > 
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Reviewed-by: John Garry <john.g.garry@oracle.com>
> > Reported-by: Thomas Hellstr�m <thomas.hellstrom@linux.intel.com>
> > Closes:
> > https://lore.kernel.org/linux-block/ead7c5ce5138912c1f3179d62370b84a64014a38.camel@linux.intel.com/
> > Fixes: bd166ef183c2 ("blk-mq-sched: add framework for MQ capable IO
> > schedulers")
> 
> Does this fix also the #2 lockdep splat in that email?

No.

The #2 splat fix has been merged to for-6.14/block, and this patch only
covers the one reported in the Closes link.

https://lore.kernel.org/linux-block/20250110054726.1499538-1-hch@lst.de/


Thanks, 
Ming


