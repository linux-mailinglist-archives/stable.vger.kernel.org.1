Return-Path: <stable+bounces-145803-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F56CABF1DC
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 12:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B14FE8E3C6C
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 10:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54F625F972;
	Wed, 21 May 2025 10:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J/5Iz1WM"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03AA25F961
	for <stable@vger.kernel.org>; Wed, 21 May 2025 10:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747824204; cv=none; b=LqLj6G4ftJ7FYc10ienuQqqYkIzW2pDCp6J1y9L/UNwKNUdMHrkPr1S9xxnQ0TFq4fWnCGT/IfyIzZE5kVtbBHueZDm5tTNX0UchptLAiSIFDYR7OQtUXmBibnSpzSb1kDjYoC3OGKDuc0NsLNb5HUZWOBT2yxYBvUp17e2sU2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747824204; c=relaxed/simple;
	bh=oa6MeRB5CJ/R3r6EFeH8af8vbkfDvVkcEcztqPBmLDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZUcrZKfUoFLfx/nopDod8yuP1DcPQyF48oZ5CU1vdS7cVRGN55cUYjfDoo0naAw0BhhP7Q8JG6IvEuxjKiOR40r/+fit3mt3kAa1OWJ2jSWkIadi6d3pqS+sKMgB8RjzNvoDNwIxE6sg5m1eZeaJdssKNnk8kghZygMlnlX6Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J/5Iz1WM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747824200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KaAAcn+DxIYRR3PXSp0qt/sOHsdn2bo8wrK71rZXEoI=;
	b=J/5Iz1WMD2GJHsDXD7K9/+K3qHrKXgw5IwJQqNC0ZUaUgzVOCbld6siJEaN5nHfKUPkgHU
	1x6+yneE9CZkD+Zn0XOikE280FS5jdUNMOqAIwU/utZObnz63LEJbQT1N657Cm0P+P0Jym
	GleoU3iqP3s4oAU1gU5goAeiW5ReR08=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-lEZEB_tyMiSkDKsCFR7EUw-1; Wed, 21 May 2025 06:43:19 -0400
X-MC-Unique: lEZEB_tyMiSkDKsCFR7EUw-1
X-Mimecast-MFC-AGG-ID: lEZEB_tyMiSkDKsCFR7EUw_1747824198
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43ea256f039so52651615e9.0
        for <stable@vger.kernel.org>; Wed, 21 May 2025 03:43:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747824198; x=1748428998;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KaAAcn+DxIYRR3PXSp0qt/sOHsdn2bo8wrK71rZXEoI=;
        b=SAYvFwy0kBkR/yeOBM+k3oHLXKs+Ef/QXbPgtm1XAQdL5y4NI+KQq46LJNTwm7VbdK
         ae3r4obFMald5gysS3MupotK4vtK0uOb1RTcMp2cYiaH/5c0YUwcKIp+MK5kiERkGcnT
         hXYcgmkpSchaNmu63+rpol8AgGWgm2r1n2aQBY8v120Fc3igu1Pi/fRcFlkg/fMxLLCG
         5TQ5k/MP3NsN4KzzP2dxbr49EHIM4k44NxOQNeo6uMKZf0NhmeDmfE6YdvxUNIvMaf7B
         qQvb9VvbkcsSKUzFei4cWWD8vpgxU/A85pfOQTh/DiTTvELq0SyanVdywqwe/bG0Wv2H
         fbcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFULKocPi8LSgu7VcfOEGD1KByIelKcQ234BDHPIdCoRPWQOdPysgcgW3oWoTcmpFQAwQfTlc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzphwk6u91Exb4XWkjDS9jBzvKuVYxZ/b77cVRXtJamwI8CVDA4
	e2gYD1R4bgU5cAHuohJ5oBKS/jztCoNRUsIj+RG109+iZVXIeacj+lNInzWXf7PY1MoC4whN9zR
	6JSbdMLMXOWPOUh0UKslY+wj+ipKZLXsETWnruqO/2WtkpSSWF7CulFIqaQ==
X-Gm-Gg: ASbGncthfAlJ92zfcIcJ9EPNFD1buspJYBRlG8HqHt14aT1g565+VpSn8EzxP2pXo6s
	rXZ2hU8V5ucID3bi89lyQ0PYgx8Ij68Qxn9UOzeDf7ANegKYkXhhKmMOz+O/9sbDuyq+J+rmbKW
	mlMu129hyBFesHT3RhMY8zAnjo8NbzkQ4xMxUFWsEJonjg0iDAaXycw5oKCsHvVhtZ7890aT2JO
	IOdz14uzVrLouKMG+6W6eKD6Jio3siVlA/MKroks5pr2ehWhxUfDUq4kvc0jODUyMCv9OHVlPAd
	HmfPzw==
X-Received: by 2002:a05:600c:3d0c:b0:443:48:66d2 with SMTP id 5b1f17b1804b1-44300486a13mr211982215e9.16.1747824197894;
        Wed, 21 May 2025 03:43:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTb2nf0nJ4vg/zTNkehoTxERDFiMuMd4v0jMkv7rA71RWawlXZPW1wTpknzHIBNKPn+Se9Gg==
X-Received: by 2002:a05:600c:3d0c:b0:443:48:66d2 with SMTP id 5b1f17b1804b1-44300486a13mr211981755e9.16.1747824197410;
        Wed, 21 May 2025 03:43:17 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-448ba3d8facsm41029845e9.6.2025.05.21.03.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 03:43:16 -0700 (PDT)
Date: Wed, 21 May 2025 06:43:13 -0400
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
Message-ID: <20250521063626-mutt-send-email-mst@kernel.org>
References: <20250521062744.1361774-1-parav@nvidia.com>
 <20250521041506-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195F56A84CAF0D486B82239DC9EA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250521051556-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195A306A9A8CFE8FFC1B033DC9EA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250521061236-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195A01F9B43B25B19A64770DC9EA@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR12MB7195A01F9B43B25B19A64770DC9EA@CY8PR12MB7195.namprd12.prod.outlook.com>

On Wed, May 21, 2025 at 10:34:46AM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, May 21, 2025 3:46 PM
> > 
> > On Wed, May 21, 2025 at 09:32:30AM +0000, Parav Pandit wrote:
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: Wednesday, May 21, 2025 2:49 PM
> > > > To: Parav Pandit <parav@nvidia.com>
> > > > Cc: stefanha@redhat.com; axboe@kernel.dk;
> > > > virtualization@lists.linux.dev; linux-block@vger.kernel.or;
> > > > stable@vger.kernel.org; NBU-Contact-Li Rongqing
> > > > (EXTERNAL) <lirongqing@baidu.com>; Chaitanya Kulkarni
> > > > <chaitanyak@nvidia.com>; xuanzhuo@linux.alibaba.com;
> > > > pbonzini@redhat.com; jasowang@redhat.com; Max Gurtovoy
> > > > <mgurtovoy@nvidia.com>; Israel Rukshin <israelr@nvidia.com>
> > > > Subject: Re: [PATCH v1] virtio_blk: Fix disk deletion hang on device
> > > > surprise removal
> > > >
> > > > On Wed, May 21, 2025 at 09:14:31AM +0000, Parav Pandit wrote:
> > > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > > Sent: Wednesday, May 21, 2025 1:48 PM
> > > > > >
> > > > > > On Wed, May 21, 2025 at 06:37:41AM +0000, Parav Pandit wrote:
> > > > > > > When the PCI device is surprise removed, requests may not
> > > > > > > complete the device as the VQ is marked as broken. Due to
> > > > > > > this, the disk deletion hangs.
> > > > > > >
> > > > > > > Fix it by aborting the requests when the VQ is broken.
> > > > > > >
> > > > > > > With this fix now fio completes swiftly.
> > > > > > > An alternative of IO timeout has been considered, however when
> > > > > > > the driver knows about unresponsive block device, swiftly
> > > > > > > clearing them enables users and upper layers to react quickly.
> > > > > > >
> > > > > > > Verified with multiple device unplug iterations with pending
> > > > > > > requests in virtio used ring and some pending with the device.
> > > > > > >
> > > > > > > Fixes: 43bb40c5b926 ("virtio_pci: Support surprise removal of
> > > > > > > virtio pci device")
> > > > > > > Cc: stable@vger.kernel.org
> > > > > > > Reported-by: lirongqing@baidu.com
> > > > > > > Closes:
> > > > > > >
> > > > > > https://lore.kernel.org/virtualization/c45dd68698cd47238c55fb73c
> > > > > > a9b4
> > > > > > 74
> > > > > > > 1@baidu.com/
> > > > > > > Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > > > > > Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> > > > > > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > > > > > > ---
> > > > > > > changelog:
> > > > > > > v0->v1:
> > > > > > > - Fixed comments from Stefan to rename a cleanup function
> > > > > > > - Improved logic for handling any outstanding requests
> > > > > > >   in bio layer
> > > > > > > - improved cancel callback to sync with ongoing done()
> > > > > >
> > > > > > thanks for the patch!
> > > > > > questions:
> > > > > >
> > > > > >
> > > > > > > ---
> > > > > > >  drivers/block/virtio_blk.c | 95
> > > > > > > ++++++++++++++++++++++++++++++++++++++
> > > > > > >  1 file changed, 95 insertions(+)
> > > > > > >
> > > > > > > diff --git a/drivers/block/virtio_blk.c
> > > > > > > b/drivers/block/virtio_blk.c index 7cffea01d868..5212afdbd3c7
> > > > > > > 100644
> > > > > > > --- a/drivers/block/virtio_blk.c
> > > > > > > +++ b/drivers/block/virtio_blk.c
> > > > > > > @@ -435,6 +435,13 @@ static blk_status_t
> > > > > > > virtio_queue_rq(struct
> > > > > > blk_mq_hw_ctx *hctx,
> > > > > > >  	blk_status_t status;
> > > > > > >  	int err;
> > > > > > >
> > > > > > > +	/* Immediately fail all incoming requests if the vq is broken.
> > > > > > > +	 * Once the queue is unquiesced, upper block layer flushes
> > > > > > > +any
> > > > > > pending
> > > > > > > +	 * queued requests; fail them right away.
> > > > > > > +	 */
> > > > > > > +	if (unlikely(virtqueue_is_broken(vblk->vqs[qid].vq)))
> > > > > > > +		return BLK_STS_IOERR;
> > > > > > > +
> > > > > > >  	status = virtblk_prep_rq(hctx, vblk, req, vbr);
> > > > > > >  	if (unlikely(status))
> > > > > > >  		return status;
> > > > > >
> > > > > > just below this:
> > > > > >         spin_lock_irqsave(&vblk->vqs[qid].lock, flags);
> > > > > >         err = virtblk_add_req(vblk->vqs[qid].vq, vbr);
> > > > > >         if (err) {
> > > > > >
> > > > > >
> > > > > > and virtblk_add_req calls virtqueue_add_sgs, so it will fail on a broken
> > vq.
> > > > > >
> > > > > > Why do we need to check it one extra time here?
> > > > > >
> > > > > It may work, but for some reason if the hw queue is stopped in
> > > > > this flow, it
> > > > can hang the IOs flushing.
> > > >
> > > > > I considered it risky to rely on the error code ENOSPC returned by
> > > > > non virtio-
> > > > blk driver.
> > > > > In other words, if lower layer changed for some reason, we may end
> > > > > up in
> > > > stopping the hw queue when broken, and requests would hang.
> > > > >
> > > > > Compared to that one-time entry check seems more robust.
> > > >
> > > > I don't get it.
> > > > Checking twice in a row is more robust?
> > > No. I am not confident on the relying on the error code -ENOSPC from layers
> > outside of virtio-blk driver.
> > 
> > You can rely on virtio core to return an error on a broken vq.
> > The error won't be -ENOSPC though, why would it?
> > 
> Presently that is not the API contract between virtio core and driver.
> When the VQ is broken the error code is EIO. This is from the code inspection.

yes

> If you prefer to rely on the code inspection of lower layer to define the virtio-blk, I am fine and remove the two checks.
> I just find it fragile, but if you prefer this way, I am fine.

I think it's better, yes. 

> > > If for a broken VQ, ENOSPC arrives, then hw queue is stopped and requests
> > could be stuck.
> > 
> > Can you describe the scenario in more detail pls?
> > where does ENOSPC arrive from? when is the vq get broken ...
> > 
> ENOSPC arrives when it fails to enqueue the request in present form.
> EIO arrives when VQ is broken.
> 
> If in the future, ENOSPC arrives for broken VQ, following flow can trigger a hang.
> 
> cpu_0:
> virtblk_broken_device_cleanup()
> ...
>     blk_mq_unquiesce_queue();
>     ... stage_1:
>     blk_mq_freeze_queue_wait().
> 
> 
> Cpu_1:
> Queue_rq()
>   virtio_queue_rq()
>      virtblk_add_req()
>         -ENOSPC
>             Stop_hw_queue()
>                 At this point, new requests in block layer may get stuck and may not be enqueued to queue_rq().
> 
> > 
> > > > What am I missing?
> > > > Can you describe the scenario in more detail?
> > > >
> > > > >
> > > > > >
> > > > > >
> > > > > > > @@ -508,6 +515,11 @@ static void virtio_queue_rqs(struct
> > > > > > > rq_list
> > > > *rqlist)
> > > > > > >  	while ((req = rq_list_pop(rqlist))) {
> > > > > > >  		struct virtio_blk_vq *this_vq = get_virtio_blk_vq(req-
> > > > > > >mq_hctx);
> > > > > > >
> > > > > > > +		if (unlikely(virtqueue_is_broken(this_vq->vq))) {
> > > > > > > +			rq_list_add_tail(&requeue_list, req);
> > > > > > > +			continue;
> > > > > > > +		}
> > > > > > > +
> > > > > > >  		if (vq && vq != this_vq)
> > > > > > >  			virtblk_add_req_batch(vq, &submit_list);
> > > > > > >  		vq = this_vq;
> > > > > >
> > > > > > similarly
> > > > > >
> > > > > The error code is not surfacing up here from virtblk_add_req().
> > > >
> > > >
> > > > but wait a sec:
> > > >
> > > > static void virtblk_add_req_batch(struct virtio_blk_vq *vq,
> > > >                 struct rq_list *rqlist) {
> > > >         struct request *req;
> > > >         unsigned long flags;
> > > >         bool kick;
> > > >
> > > >         spin_lock_irqsave(&vq->lock, flags);
> > > >
> > > >         while ((req = rq_list_pop(rqlist))) {
> > > >                 struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
> > > >                 int err;
> > > >
> > > >                 err = virtblk_add_req(vq->vq, vbr);
> > > >                 if (err) {
> > > >                         virtblk_unmap_data(req, vbr);
> > > >                         virtblk_cleanup_cmd(req);
> > > >                         blk_mq_requeue_request(req, true);
> > > >                 }
> > > >         }
> > > >
> > > >         kick = virtqueue_kick_prepare(vq->vq);
> > > >         spin_unlock_irqrestore(&vq->lock, flags);
> > > >
> > > >         if (kick)
> > > >                 virtqueue_notify(vq->vq); }
> > > >
> > > >
> > > > it actually handles the error internally?
> > > >
> > > For all the errors it requeues the request here.
> > 
> > ok and they will not prevent removal will they?
> > 
> It should not prevent removal.
> One must be careful every single time changing it to make sure that hw queues are not stopped in lower layer, but may be this is ok.
> 
> > 
> > > >
> > > >
> > > >
> > > > > It would end up adding checking for special error code here as
> > > > > well to abort
> > > > by translating broken VQ -> EIO to break the loop in
> > virtblk_add_req_batch().
> > > > >
> > > > > Weighing on specific error code-based data path that may require
> > > > > audit from
> > > > lower layers now and future, an explicit check of broken in this
> > > > layer could be better.
> > > > >
> > > > > [..]
> > > >
> > > >
> > > > Checking add was successful is preferred because it has to be done
> > > > *anyway* - device can get broken after you check before add.
> > > >
> > > > So I would like to understand why are we also checking explicitly
> > > > and I do not get it so far.
> > >
> > > checking explicitly to not depend on specific error code-based logic.
> > 
> > 
> > I do not understand. You must handle vq add errors anyway.
> 
> I believe removal of the two vq broken checks should also be fine.
> I would probably add the comment in the code indicating virtio block driver assumes that ENOSPC is not returned for broken VQ.

You can include this in the series if you like. Tweak to taste:

-->

virtio: document ENOSPC

drivers handle ENOSPC specially since it's an error one can
get from a working VQ. Document the semantics.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

---

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index b784aab66867..97ab0cce527d 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2296,6 +2296,10 @@ static inline int virtqueue_add(struct virtqueue *_vq,
  * at the same time (except where noted).
  *
  * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
+ *
+ * NB: ENOSPC is a special code that is only returned on an attempt to add a
+ * buffer to a full VQ. It indicates that some buffers are outstanding and that
+ * the operation can be retried after some buffers have been used.
  */
 int virtqueue_add_sgs(struct virtqueue *_vq,
 		      struct scatterlist *sgs[],


