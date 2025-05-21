Return-Path: <stable+bounces-145791-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8FFABEF6D
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 11:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47FA63B2CAA
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 09:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0437423C517;
	Wed, 21 May 2025 09:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IewRUBxP"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B098A23C4F9
	for <stable@vger.kernel.org>; Wed, 21 May 2025 09:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747819167; cv=none; b=lentTn4/WGnfENoT4o8q6npaLZHZlIsWP1mIK8gmgPWh1CaGeGR6HCQ/TMk0MJr9IKfa6YpHio8573qCr2UHPn2rfJmXl5GwcMDEKf2qmJ0ILcb//lxnZvO+6XUgQ8VvIyiInInykvWbwBfU5kR+HJYba9PPHCKdiOdKu/EllO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747819167; c=relaxed/simple;
	bh=B7wXPyXUP2w07U8Up6D4wr9emBg7GtP6vgGU4Rn9vb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LYuAI96l8qbuw0B0WOWheCdJjCsu+o3baJY3HRfef40m3/8wx3a9Hfzd1kh/sxgGnnaTx+iIvXdUt4r7tClcCSJ6tcC53exvSlLu9If5V47YSNXpKjHMgcK6i5KwL8EwlqbY4PM/qPIv4JcaXd+LrEMdPGypwDZ/G6MTyDjp4Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IewRUBxP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747819164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z/o09y9SC9Ywr/vW/q2zNIFJBJF7X0kmooxajrWqv/s=;
	b=IewRUBxPcrP8Z2LV9yz7vevwl7FMJXgYSNWgfs9L/wJWmF32yBcyWfbAl/rS5cRL0KdsgM
	9WWLZG2j20Fk8XTi3yTi+KFHf6fWFMfsLgEFx5kp4LKCwE4m3h/UTE2VNDNKPCpLgNZbCn
	Vo+zFxjCtuAyeqSDB6xic7lvQZSBq8U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-aoh3WExKO3ySvf0nbXV6pw-1; Wed, 21 May 2025 05:19:23 -0400
X-MC-Unique: aoh3WExKO3ySvf0nbXV6pw-1
X-Mimecast-MFC-AGG-ID: aoh3WExKO3ySvf0nbXV6pw_1747819162
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a371fb826cso1478213f8f.1
        for <stable@vger.kernel.org>; Wed, 21 May 2025 02:19:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747819162; x=1748423962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/o09y9SC9Ywr/vW/q2zNIFJBJF7X0kmooxajrWqv/s=;
        b=VQrDllBOr26OUJaEK4BuXn2i5Q0fTrrz9LNwPS2n3dJUXGvRJ3NCfg9vK0fV3RK1wz
         4WIjqeVSkQ26256G7Hs7meGqzrgJwyDghWu/msVhVNI5tty4fGxNBrURAw7RFtyj7+zf
         2g6JMjPv2Yb1kt23FmqXjmU0bJZuK5L9RGbKYoVkSPE22q/s9e3DAUnFZuRlUwFVkCEU
         jVvGmmrhKOqrF/e5vYV4fpzg2SUoACpOAXLSNWWy45xmMuJtS66WzGTj0Z32YK4DGOoL
         sK/nAOf4GDksKnwcMNZJnqPsWwdBX1yYAsn0eFoc2WD0YVIqjYcf3cXtvZw/S2EN8tV4
         f09w==
X-Forwarded-Encrypted: i=1; AJvYcCVQjtqKGqyRJA1Wf2rwioQ/E4cU4CCBo9vM/BSL+zJHAIzbcdV8Cj7PVKDQhocrPW8wyxHiV98=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7XrfhTblwB1mxk0QxibvT+kIGm7rQ6E1e2qftBHrG0eGIKDuk
	7gff89E8ld3Qk4YqvlvHP2FrAJ7F1/NyrN6QOvxllODyK4Pu8R7MotnQoZ22S/m+4o4E/GiNasd
	p7o14jdIcl8x69z+oLlrpeOieuDT0TxEAU39oKKjEpaeHTDTfQDEd4Q/2gQ==
X-Gm-Gg: ASbGncuNDOxjMbZBvShGVJA5GG8c3xefBlGVCSytuI7xUWTth/J00x3519l6Bh53n1c
	FUmKf/KeWpi6wjowc380YDRr+p/tgg/v53BabPtHzIIS5nQ7X4xcjoyps7tp6wsiAE1VnPCL5nL
	qU4VD1sctIbdhRjYh1avhSwnXA0Q11BI43nqhRhJbRcO6RkKi0B4Ivtl1WPyELJ/fGJu5pwwqoX
	yRjO7+Wv/W/eU6LzJTit0yTRAYo4uxqJYbFFNCGqrKa6WG9/T8hiagRpIi4B1m+6oJ6dLgcXuam
	0Or+QA==
X-Received: by 2002:a05:6000:3103:b0:3a3:6415:96c8 with SMTP id ffacd0b85a97d-3a364159712mr14162627f8f.41.1747819161456;
        Wed, 21 May 2025 02:19:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLmTcHyyqMuzgg9O5ETbsMsgVAw3A3cvgRdzmCanUIuc6/dYk73VWGritQ97Q4VSUoXhdZCA==
X-Received: by 2002:a05:6000:3103:b0:3a3:6415:96c8 with SMTP id ffacd0b85a97d-3a364159712mr14162590f8f.41.1747819161026;
        Wed, 21 May 2025 02:19:21 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f6ffaa6esm63402155e9.16.2025.05.21.02.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 02:19:20 -0700 (PDT)
Date: Wed, 21 May 2025 05:19:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "stefanha@redhat.com" <stefanha@redhat.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"linux-block@vger.kernel.or" <linux-block@vger.kernel.or>,
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
Message-ID: <20250521051556-mutt-send-email-mst@kernel.org>
References: <20250521062744.1361774-1-parav@nvidia.com>
 <20250521041506-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195F56A84CAF0D486B82239DC9EA@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR12MB7195F56A84CAF0D486B82239DC9EA@CY8PR12MB7195.namprd12.prod.outlook.com>

On Wed, May 21, 2025 at 09:14:31AM +0000, Parav Pandit wrote:
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, May 21, 2025 1:48 PM
> > 
> > On Wed, May 21, 2025 at 06:37:41AM +0000, Parav Pandit wrote:
> > > When the PCI device is surprise removed, requests may not complete the
> > > device as the VQ is marked as broken. Due to this, the disk deletion
> > > hangs.
> > >
> > > Fix it by aborting the requests when the VQ is broken.
> > >
> > > With this fix now fio completes swiftly.
> > > An alternative of IO timeout has been considered, however when the
> > > driver knows about unresponsive block device, swiftly clearing them
> > > enables users and upper layers to react quickly.
> > >
> > > Verified with multiple device unplug iterations with pending requests
> > > in virtio used ring and some pending with the device.
> > >
> > > Fixes: 43bb40c5b926 ("virtio_pci: Support surprise removal of virtio
> > > pci device")
> > > Cc: stable@vger.kernel.org
> > > Reported-by: lirongqing@baidu.com
> > > Closes:
> > >
> > https://lore.kernel.org/virtualization/c45dd68698cd47238c55fb73ca9b474
> > > 1@baidu.com/
> > > Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > > ---
> > > changelog:
> > > v0->v1:
> > > - Fixed comments from Stefan to rename a cleanup function
> > > - Improved logic for handling any outstanding requests
> > >   in bio layer
> > > - improved cancel callback to sync with ongoing done()
> > 
> > thanks for the patch!
> > questions:
> > 
> > 
> > > ---
> > >  drivers/block/virtio_blk.c | 95
> > > ++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 95 insertions(+)
> > >
> > > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > > index 7cffea01d868..5212afdbd3c7 100644
> > > --- a/drivers/block/virtio_blk.c
> > > +++ b/drivers/block/virtio_blk.c
> > > @@ -435,6 +435,13 @@ static blk_status_t virtio_queue_rq(struct
> > blk_mq_hw_ctx *hctx,
> > >  	blk_status_t status;
> > >  	int err;
> > >
> > > +	/* Immediately fail all incoming requests if the vq is broken.
> > > +	 * Once the queue is unquiesced, upper block layer flushes any
> > pending
> > > +	 * queued requests; fail them right away.
> > > +	 */
> > > +	if (unlikely(virtqueue_is_broken(vblk->vqs[qid].vq)))
> > > +		return BLK_STS_IOERR;
> > > +
> > >  	status = virtblk_prep_rq(hctx, vblk, req, vbr);
> > >  	if (unlikely(status))
> > >  		return status;
> > 
> > just below this:
> >         spin_lock_irqsave(&vblk->vqs[qid].lock, flags);
> >         err = virtblk_add_req(vblk->vqs[qid].vq, vbr);
> >         if (err) {
> > 
> > 
> > and virtblk_add_req calls virtqueue_add_sgs, so it will fail on a broken vq.
> > 
> > Why do we need to check it one extra time here?
> > 
> It may work, but for some reason if the hw queue is stopped in this flow, it can hang the IOs flushing.

> I considered it risky to rely on the error code ENOSPC returned by non virtio-blk driver.
> In other words, if lower layer changed for some reason, we may end up in stopping the hw queue when broken, and requests would hang.
> 
> Compared to that one-time entry check seems more robust.

I don't get it.
Checking twice in a row is more robust?
What am I missing?
Can you describe the scenario in more detail?

> 
> > 
> > 
> > > @@ -508,6 +515,11 @@ static void virtio_queue_rqs(struct rq_list *rqlist)
> > >  	while ((req = rq_list_pop(rqlist))) {
> > >  		struct virtio_blk_vq *this_vq = get_virtio_blk_vq(req-
> > >mq_hctx);
> > >
> > > +		if (unlikely(virtqueue_is_broken(this_vq->vq))) {
> > > +			rq_list_add_tail(&requeue_list, req);
> > > +			continue;
> > > +		}
> > > +
> > >  		if (vq && vq != this_vq)
> > >  			virtblk_add_req_batch(vq, &submit_list);
> > >  		vq = this_vq;
> > 
> > similarly
> > 
> The error code is not surfacing up here from virtblk_add_req().


but wait a sec:

static void virtblk_add_req_batch(struct virtio_blk_vq *vq,
                struct rq_list *rqlist)
{       
        struct request *req; 
        unsigned long flags;
        bool kick;
        
        spin_lock_irqsave(&vq->lock, flags);
        
        while ((req = rq_list_pop(rqlist))) {
                struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
                int err;
                        
                err = virtblk_add_req(vq->vq, vbr);
                if (err) {
                        virtblk_unmap_data(req, vbr);
                        virtblk_cleanup_cmd(req);
                        blk_mq_requeue_request(req, true);
                }
        }

        kick = virtqueue_kick_prepare(vq->vq);
        spin_unlock_irqrestore(&vq->lock, flags);

        if (kick)
                virtqueue_notify(vq->vq);
}


it actually handles the error internally?




> It would end up adding checking for special error code here as well to abort by translating broken VQ -> EIO to break the loop in virtblk_add_req_batch().
> 
> Weighing on specific error code-based data path that may require audit from lower layers now and future, an explicit check of broken in this layer could be better.
> 
> [..]


Checking add was successful is preferred because it has to be done
*anyway* - device can get broken after you check before add.

So I would like to understand why are we also checking explicitly and I
do not get it so far.


