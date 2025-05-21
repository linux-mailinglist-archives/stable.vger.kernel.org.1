Return-Path: <stable+bounces-145800-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA0DABF145
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 12:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8A93189026B
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 10:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACC525B1DA;
	Wed, 21 May 2025 10:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d27iojJS"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D4725C804
	for <stable@vger.kernel.org>; Wed, 21 May 2025 10:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747822589; cv=none; b=rEVYFHvnxj+G0eRuXHB+IeQykGqnh2GNt04pBcOic/RVO99f2iMZvLMtyuSApMt5iYiWTqHNSRBHO6zCk6Qxu7zrSb8OKJwUfweVFBY6yIlWVrwqoIHTxWCs7gXkN33IgQghEnRaXDnxrY2rdKHFngCGJCpvBUuhcjXvgD+srJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747822589; c=relaxed/simple;
	bh=XhkOnIFSZzfz8vBD/tR/JxVR+GPcZ8tyc76NnJLwy9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WQetfxMWhGd9kOY03DfQxAzx1hAqzCLfWA0DRtlb6W+8ACtillt9VQbg2Hk+FSiqCjFjZbwcjAPr+l/tFXbF+siulCsmkMZIna8b3Bh+FmqLaCT7qlzaUacDx1B+USJWz2MLiLwcpssD0YK/r1zcOb1vLY6RwcfAiE+owkj+L94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d27iojJS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747822586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9kkU7Xfk94mr2Cbd+PQ9YPHZhQWHng6qRUMVT0EvtHU=;
	b=d27iojJSNSKwVtoGVgCJzhDZCPT8ssTSNgaT7ek8dhH3EY4vLgAQ2R8SsVKSKT3nuINls5
	30qFDq4Bkn2OtZ2CGGMytkDfCmmFK+OiXKUxTTezAxSY6Lgu31oSlXVuLR0yya7ihNmEN9
	5IAWfD3+9KMS65uPoOUQoWcjBBzxEH4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-wcE2gGmaMA2gQkzPV27zrA-1; Wed, 21 May 2025 06:16:25 -0400
X-MC-Unique: wcE2gGmaMA2gQkzPV27zrA-1
X-Mimecast-MFC-AGG-ID: wcE2gGmaMA2gQkzPV27zrA_1747822584
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a3696a0d3aso1605474f8f.2
        for <stable@vger.kernel.org>; Wed, 21 May 2025 03:16:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747822584; x=1748427384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kkU7Xfk94mr2Cbd+PQ9YPHZhQWHng6qRUMVT0EvtHU=;
        b=Gk29Xo8p3o9C/P20xU9E14IRfvHhW9YT+iVJ24Utbzc2lw0+ChK+jIfcT4qpQcPTkz
         URlqbKchHZCSnILGPP5O6iGfBWwx9h5yKad3LnQojDaIXIGuVnI4KmKIMT7GlsJrbqVN
         f2m/tpxAal9l4gcS3bKVqyNFmxsT3c2eaSFK8QGVnMpunxBVj++6kMNCy8NjEw/Dvlbk
         kzndQNdAQdaz9T9btK3pmsP2ZnE+BXOH0szqIkcJUdKuSWZZE8AaHJE7ZTqB6tXUgAbf
         wsb6OVtlAO+zNOp+c9mz5tfrNEq+yn7Wf1LuzuWhJaAurlK0GWTnCcYpWyUkpumb7lUf
         eLQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUucrrH8UsoNig7k1P6HLk1jMgIEoSuMjDE1FZGhV3ezLk9TqUO/hJfAanf5Tiht32JcH0MMfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK0uKpZGz9Sx/6OJqxJwQYVpTHdX1OooOaYVMUwLCns6GHxdp0
	ciSZyeEvnY9VngRRNAiF8tDbGcAwhyU1Mfq54x1U7D7cRRGARfKg5Ueo9AZPDcno1N9KaFRRWoy
	5s3Ko5Fbp3vsKpQIffKywsQ+R3cNMGXc9vbdppjJEzb2MF6XvLfsz7KG7jQ==
X-Gm-Gg: ASbGncuHEszAZmChIYvEkNUlBXvecZauGllilShQB6av61rt1ucLYD3hHxwsxKcdpLw
	HyQu/jhJ7KjZC8ukK2O4T+nmZ99ctGWGcN/hFFSFk6OeA96qcNGZ7tPnGoL89UxSfL6FeoRtaIx
	AGjz+DgusuKAOH5mM1eRIgC1Nfz45PPBqcUNKXSICY3xST1WuPRbeAS7eaw6el7f1DTP61S9JMU
	8KsZzNFZoPGuDr6ICpqTqok1fYKAkJnpynzEMmByMYcx4UMWsjYnUm0Nlk74LtSk4jDJoFe0ZkI
	PeMS2g==
X-Received: by 2002:a05:6000:1881:b0:3a2:595:e8cb with SMTP id ffacd0b85a97d-3a35ffd28c6mr16271027f8f.45.1747822583794;
        Wed, 21 May 2025 03:16:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHl5MRnm/anUQ/+Mk3nQZ83R7M1qg6DNqqWQEJvci6mEU3aauLFjKYMXFRTCdchPrjbC/Gz5Q==
X-Received: by 2002:a05:6000:1881:b0:3a2:595:e8cb with SMTP id ffacd0b85a97d-3a35ffd28c6mr16270982f8f.45.1747822583350;
        Wed, 21 May 2025 03:16:23 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca5a04csm19026409f8f.23.2025.05.21.03.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 03:16:22 -0700 (PDT)
Date: Wed, 21 May 2025 06:16:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "stefanha@redhat.com" <stefanha@redhat.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"NBU-Contact-Li Rongqing (EXTERNAL)" <lirongqing@baidu.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Israel Rukshin <israelr@nvidia.com>
Subject: Re: [PATCH v1] virtio_blk: Fix disk deletion hang on device surprise
 removal
Message-ID: <20250521061236-mutt-send-email-mst@kernel.org>
References: <20250521062744.1361774-1-parav@nvidia.com>
 <20250521041506-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195F56A84CAF0D486B82239DC9EA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250521051556-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195A306A9A8CFE8FFC1B033DC9EA@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR12MB7195A306A9A8CFE8FFC1B033DC9EA@CY8PR12MB7195.namprd12.prod.outlook.com>

On Wed, May 21, 2025 at 09:32:30AM +0000, Parav Pandit wrote:
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, May 21, 2025 2:49 PM
> > To: Parav Pandit <parav@nvidia.com>
> > Cc: stefanha@redhat.com; axboe@kernel.dk; virtualization@lists.linux.dev;
> > linux-block@vger.kernel.or; stable@vger.kernel.org; NBU-Contact-Li Rongqing
> > (EXTERNAL) <lirongqing@baidu.com>; Chaitanya Kulkarni
> > <chaitanyak@nvidia.com>; xuanzhuo@linux.alibaba.com;
> > pbonzini@redhat.com; jasowang@redhat.com; Max Gurtovoy
> > <mgurtovoy@nvidia.com>; Israel Rukshin <israelr@nvidia.com>
> > Subject: Re: [PATCH v1] virtio_blk: Fix disk deletion hang on device surprise
> > removal
> > 
> > On Wed, May 21, 2025 at 09:14:31AM +0000, Parav Pandit wrote:
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: Wednesday, May 21, 2025 1:48 PM
> > > >
> > > > On Wed, May 21, 2025 at 06:37:41AM +0000, Parav Pandit wrote:
> > > > > When the PCI device is surprise removed, requests may not complete
> > > > > the device as the VQ is marked as broken. Due to this, the disk
> > > > > deletion hangs.
> > > > >
> > > > > Fix it by aborting the requests when the VQ is broken.
> > > > >
> > > > > With this fix now fio completes swiftly.
> > > > > An alternative of IO timeout has been considered, however when the
> > > > > driver knows about unresponsive block device, swiftly clearing
> > > > > them enables users and upper layers to react quickly.
> > > > >
> > > > > Verified with multiple device unplug iterations with pending
> > > > > requests in virtio used ring and some pending with the device.
> > > > >
> > > > > Fixes: 43bb40c5b926 ("virtio_pci: Support surprise removal of
> > > > > virtio pci device")
> > > > > Cc: stable@vger.kernel.org
> > > > > Reported-by: lirongqing@baidu.com
> > > > > Closes:
> > > > >
> > > > https://lore.kernel.org/virtualization/c45dd68698cd47238c55fb73ca9b4
> > > > 74
> > > > > 1@baidu.com/
> > > > > Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > > > Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> > > > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > > > > ---
> > > > > changelog:
> > > > > v0->v1:
> > > > > - Fixed comments from Stefan to rename a cleanup function
> > > > > - Improved logic for handling any outstanding requests
> > > > >   in bio layer
> > > > > - improved cancel callback to sync with ongoing done()
> > > >
> > > > thanks for the patch!
> > > > questions:
> > > >
> > > >
> > > > > ---
> > > > >  drivers/block/virtio_blk.c | 95
> > > > > ++++++++++++++++++++++++++++++++++++++
> > > > >  1 file changed, 95 insertions(+)
> > > > >
> > > > > diff --git a/drivers/block/virtio_blk.c
> > > > > b/drivers/block/virtio_blk.c index 7cffea01d868..5212afdbd3c7
> > > > > 100644
> > > > > --- a/drivers/block/virtio_blk.c
> > > > > +++ b/drivers/block/virtio_blk.c
> > > > > @@ -435,6 +435,13 @@ static blk_status_t virtio_queue_rq(struct
> > > > blk_mq_hw_ctx *hctx,
> > > > >  	blk_status_t status;
> > > > >  	int err;
> > > > >
> > > > > +	/* Immediately fail all incoming requests if the vq is broken.
> > > > > +	 * Once the queue is unquiesced, upper block layer flushes any
> > > > pending
> > > > > +	 * queued requests; fail them right away.
> > > > > +	 */
> > > > > +	if (unlikely(virtqueue_is_broken(vblk->vqs[qid].vq)))
> > > > > +		return BLK_STS_IOERR;
> > > > > +
> > > > >  	status = virtblk_prep_rq(hctx, vblk, req, vbr);
> > > > >  	if (unlikely(status))
> > > > >  		return status;
> > > >
> > > > just below this:
> > > >         spin_lock_irqsave(&vblk->vqs[qid].lock, flags);
> > > >         err = virtblk_add_req(vblk->vqs[qid].vq, vbr);
> > > >         if (err) {
> > > >
> > > >
> > > > and virtblk_add_req calls virtqueue_add_sgs, so it will fail on a broken vq.
> > > >
> > > > Why do we need to check it one extra time here?
> > > >
> > > It may work, but for some reason if the hw queue is stopped in this flow, it
> > can hang the IOs flushing.
> > 
> > > I considered it risky to rely on the error code ENOSPC returned by non virtio-
> > blk driver.
> > > In other words, if lower layer changed for some reason, we may end up in
> > stopping the hw queue when broken, and requests would hang.
> > >
> > > Compared to that one-time entry check seems more robust.
> > 
> > I don't get it.
> > Checking twice in a row is more robust?
> No. I am not confident on the relying on the error code -ENOSPC from layers outside of virtio-blk driver.

You can rely on virtio core to return an error on a broken vq.
The error won't be -ENOSPC though, why would it?

> If for a broken VQ, ENOSPC arrives, then hw queue is stopped and requests could be stuck.

Can you describe the scenario in more detail pls?
where does ENOSPC arrive from? when is the vq get broken ...


> > What am I missing?
> > Can you describe the scenario in more detail?
> > 
> > >
> > > >
> > > >
> > > > > @@ -508,6 +515,11 @@ static void virtio_queue_rqs(struct rq_list
> > *rqlist)
> > > > >  	while ((req = rq_list_pop(rqlist))) {
> > > > >  		struct virtio_blk_vq *this_vq = get_virtio_blk_vq(req-
> > > > >mq_hctx);
> > > > >
> > > > > +		if (unlikely(virtqueue_is_broken(this_vq->vq))) {
> > > > > +			rq_list_add_tail(&requeue_list, req);
> > > > > +			continue;
> > > > > +		}
> > > > > +
> > > > >  		if (vq && vq != this_vq)
> > > > >  			virtblk_add_req_batch(vq, &submit_list);
> > > > >  		vq = this_vq;
> > > >
> > > > similarly
> > > >
> > > The error code is not surfacing up here from virtblk_add_req().
> > 
> > 
> > but wait a sec:
> > 
> > static void virtblk_add_req_batch(struct virtio_blk_vq *vq,
> >                 struct rq_list *rqlist)
> > {
> >         struct request *req;
> >         unsigned long flags;
> >         bool kick;
> > 
> >         spin_lock_irqsave(&vq->lock, flags);
> > 
> >         while ((req = rq_list_pop(rqlist))) {
> >                 struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
> >                 int err;
> > 
> >                 err = virtblk_add_req(vq->vq, vbr);
> >                 if (err) {
> >                         virtblk_unmap_data(req, vbr);
> >                         virtblk_cleanup_cmd(req);
> >                         blk_mq_requeue_request(req, true);
> >                 }
> >         }
> > 
> >         kick = virtqueue_kick_prepare(vq->vq);
> >         spin_unlock_irqrestore(&vq->lock, flags);
> > 
> >         if (kick)
> >                 virtqueue_notify(vq->vq); }
> > 
> > 
> > it actually handles the error internally?
> > 
> For all the errors it requeues the request here.

ok and they will not prevent removal will they?


> > 
> > 
> > 
> > > It would end up adding checking for special error code here as well to abort
> > by translating broken VQ -> EIO to break the loop in virtblk_add_req_batch().
> > >
> > > Weighing on specific error code-based data path that may require audit from
> > lower layers now and future, an explicit check of broken in this layer could be
> > better.
> > >
> > > [..]
> > 
> > 
> > Checking add was successful is preferred because it has to be done
> > *anyway* - device can get broken after you check before add.
> > 
> > So I would like to understand why are we also checking explicitly and I do not
> > get it so far.
> 
> checking explicitly to not depend on specific error code-based logic.


I do not understand. You must handle vq add errors anyway.

-- 
MST


