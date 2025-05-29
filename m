Return-Path: <stable+bounces-148078-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5315FAC7B97
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 12:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AC6D9E2DEA
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 10:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B03228D850;
	Thu, 29 May 2025 10:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L46LgeBs"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3374A2192FC
	for <stable@vger.kernel.org>; Thu, 29 May 2025 10:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748513323; cv=none; b=o9jgAM1cw8kcLn+fd1iluLgGftGYIf+1Zt8cAhqlizIKI2GwATMYbhaoY89s7p/W9YSHxAlQHIh/6nKWm9noeecwO/g3eu5X/bFKTCFThR8OOs/n2JORHFyY5NJVNGuZHejZmisUJ99wvQd3uQ1mkmgj5IzNHkiDJSSdxPFNblA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748513323; c=relaxed/simple;
	bh=iTL8afo3upObsZUfVWgkwONBfVzOhwVSwCc3lUD98ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AOSwaPMJpszvNdAHr7U3Lg3R18/a8nsPID2WfgQ2dGJvktRx+HoIPtJo6lIWWlt5x/BNon9eWQ2GZIyH5K64HbdxYsRBUTF0FxuJVCbabWWKj/vX2keoi6hNMO3NbiszgqFk4+GQUaxwQvyVmqvBOx9bQLQhko0WiT+Nli9vMec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L46LgeBs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748513320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=btRqMMebw6c3jrXfN6v/1i5J68O0mGeiYn75Juwat/E=;
	b=L46LgeBsD/nKe/alEtdnd6tjaU5jFar82XVen03UDQ0aiXMozRCmIEIT3ntRS+Eq1X+Ovr
	msFcGYpiwc9Gi3vBGmBK9LdJihM6dqhNnPRqFlRwByS4v37cIqGeFVlX79Qxa+iphQBXH9
	r9400IDVc5/13y3RwKIV5jL01/a0Usg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-8SxWHO_qMLSjBHRA5zc0bg-1; Thu, 29 May 2025 06:08:38 -0400
X-MC-Unique: 8SxWHO_qMLSjBHRA5zc0bg-1
X-Mimecast-MFC-AGG-ID: 8SxWHO_qMLSjBHRA5zc0bg_1748513317
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4d95f197dso501822f8f.3
        for <stable@vger.kernel.org>; Thu, 29 May 2025 03:08:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748513317; x=1749118117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=btRqMMebw6c3jrXfN6v/1i5J68O0mGeiYn75Juwat/E=;
        b=ibGrVIMP9SaK0YDdkiE/ruIP3kEt8kXLkj0ZV3wpvIFrQkV5BcrU8bjFIE9my5Mlrc
         BAJrMFlS0x6JiVMw9c42E3VNCR0Ggi2bj5P3VlJ5bQMyJJFrYmqttz+ipU+Zm3v2dg8I
         uMxr1aD8oGbpEMl4WdlQhMl1uQa7xoesa+srgLmjz0uwD9UggPhxTsl4Git8XyzU+vHK
         ppnt3fWBwGwQwTDWRZvu38QXm2qIH0VgTAtHqu4nkdoh/7+dSJsGFu5G8qZftvaofM2o
         GP4aPvdwJm9AihVhmA9K5Iba++k2YNI1aI+grvT4PF+lzQRizIWqRuHOvPIafXZI6vhg
         +AzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgQn+lZ+9FT2jnxvh8Jk6J6nDc4ff3qYGXcv3kr4xIpPH8d6/xVUx/eXz4e9gm+Idvm7bNNyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNbO+vjPNAzS4FPmfpILIg8CJblS/1GXlVmnR85b0tOS9msf6R
	wFph75kYYnzcysR7NbGComogV8KNJDo5eVTCXn80u9F4jreczPfeirDZgzBmCRNqhwizrclA3pe
	fKhsso2GMhWukN6/iSAUAdi+kXS0Tmhl7epcRAMKKFGy6xyaG0uZ/bWjcAg==
X-Gm-Gg: ASbGnctSR+no7jWcVjH06hDPaqXUz0dQ99nO06x6sLYyGgElemKGhQds/tSEHy3wmpd
	kxFn2jBvhbZsWm+vtVlKXLwAfPVHox9QtfemvEP0C2NXPJOUnYz0s0EhiOzLJBi2cc28if0UD0E
	yeO6rBlmQZ7wCVCbGC8Q/vhTPD/MdZCUaIn9wQaSkXkAthJHUKlDlCqjiK8zULF30UXNuJmyAZ5
	rq5hs1D6rvQgDoAItkK1dtzFS7GjJfeGXBskLpZhpurcb534O4r2KZOnB+4aMvbbmPfZfM/2FWX
	Kn8xMA==
X-Received: by 2002:a05:6000:2dc1:b0:3a4:dfc1:ecb8 with SMTP id ffacd0b85a97d-3a4dfc1ed20mr10339686f8f.53.1748513317237;
        Thu, 29 May 2025 03:08:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjnM7LmvHpgO5lah8oxHxaFhizhn7q6GhcdIvp2FmnsbfEdYot02tUwMUrBXH33LLHSkyXIw==
X-Received: by 2002:a05:6000:2dc1:b0:3a4:dfc1:ecb8 with SMTP id ffacd0b85a97d-3a4dfc1ed20mr10339646f8f.53.1748513316666;
        Thu, 29 May 2025 03:08:36 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe5b83dsm1514577f8f.1.2025.05.29.03.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 03:08:35 -0700 (PDT)
Date: Thu, 29 May 2025 06:08:32 -0400
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
Subject: Re: [PATCH v3] virtio_blk: Fix disk deletion hang on device surprise
 removal
Message-ID: <20250529060716-mutt-send-email-mst@kernel.org>
References: <20250529061913.28868-1-parav@nvidia.com>
 <20250529035007-mutt-send-email-mst@kernel.org>
 <CY8PR12MB71954B0FEBAC97F368EF1EBCDC66A@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR12MB71954B0FEBAC97F368EF1EBCDC66A@CY8PR12MB7195.namprd12.prod.outlook.com>

On Thu, May 29, 2025 at 09:57:51AM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Thursday, May 29, 2025 1:34 PM
> > 
> > On Thu, May 29, 2025 at 06:19:31AM +0000, Parav Pandit wrote:
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
> > > Reported-by: Li RongQing <lirongqing@baidu.com>
> > > Closes:
> > > https://lore.kernel.org/virtualization/c45dd68698cd47238c55fb73ca9b474
> > > 1@baidu.com/
> > > Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > >
> > > ---
> > > v2->v3:
> > > - Addressed comments from Michael
> > > - updated comment for synchronizing with callbacks
> > >
> > > v1->v2:
> > > - Addressed comments from Stephan
> > > - fixed spelling to 'waiting'
> > > - Addressed comments from Michael
> > > - Dropped checking broken vq from queue_rq() and queue_rqs()
> > >   because it is checked in lower layer routines in virtio core
> > >
> > > v0->v1:
> > > - Fixed comments from Stefan to rename a cleanup function
> > > - Improved logic for handling any outstanding requests
> > >   in bio layer
> > > - improved cancel callback to sync with ongoing done()
> > 
> > 
> > Thanks!
> > Something else small to improve.
> > 
> > > ---
> > >  drivers/block/virtio_blk.c | 82
> > > ++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 82 insertions(+)
> > >
> > > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > > index 7cffea01d868..d37df878f4e9 100644
> > > --- a/drivers/block/virtio_blk.c
> > > +++ b/drivers/block/virtio_blk.c
> > > @@ -1554,6 +1554,86 @@ static int virtblk_probe(struct virtio_device
> > *vdev)
> > >  	return err;
> > >  }
> > >
> > > +static bool virtblk_request_cancel(struct request *rq, void *data)
> > 
> > it is more
> > 
> > virtblk_request_complete_broken_with_ioerr
> > 
> > and maybe a comment?
> > /*
> >  * If the vq is broken, device will not complete requests.
> >  * So we do it for the device.
> >  */
> > 
> Ok. will add.
> 
> > > +{
> > > +	struct virtblk_req *vbr = blk_mq_rq_to_pdu(rq);
> > > +	struct virtio_blk *vblk = data;
> > > +	struct virtio_blk_vq *vq;
> > > +	unsigned long flags;
> > > +
> > > +	vq = &vblk->vqs[rq->mq_hctx->queue_num];
> > > +
> > > +	spin_lock_irqsave(&vq->lock, flags);
> > > +
> > > +	vbr->in_hdr.status = VIRTIO_BLK_S_IOERR;
> > > +	if (blk_mq_request_started(rq) && !blk_mq_request_completed(rq))
> > > +		blk_mq_complete_request(rq);
> > > +
> > > +	spin_unlock_irqrestore(&vq->lock, flags);
> > > +	return true;
> > > +}
> > > +
> > > +static void virtblk_broken_device_cleanup(struct virtio_blk *vblk)
> > 
> > and one goes okay what does it do exactly? cleanup device in a broken way?
> > turns out no, it cleans up a broken device.
> > And an overview would be good. Maybe, a small comment will help:
> > 
> Virtblk_cleanup_broken_device()?
> 
> Is that name ok?

better, I think.

> > /*
> >  * if the device is broken, it will not use any buffers and waiting
> >  * for that to happen is pointless. We'll do it in the driver,
> >  * completing all requests for the device.
> >  */
> >
> Will add it.
>  
> > 
> > > +{
> > > +	struct request_queue *q = vblk->disk->queue;
> > > +
> > > +	if (!virtqueue_is_broken(vblk->vqs[0].vq))
> > > +		return;
> > 
> > so one has to read it, and understand that we did not need to call it in the 1st
> > place on a non broken device.
> > Moving it to the caller would be cleaner.
> > 
> Ok. will move.
> > 
> > > +
> > > +	/* Start freezing the queue, so that new requests keeps waiting at
> > > +the
> > 
> > wrong style of comment for blk.
> > 
> > /* this is
> >  * net style
> >  */
> > 
> > /*
> >  * this is
> >  * rest of the linux style
> >  */
> > 
> Ok. will fix it.
> 
> > > +	 * door of bio_queue_enter(). We cannot fully freeze the queue
> > because
> > > +	 * freezed queue is an empty queue and there are pending requests,
> > > +so
> > 
> > a frozen queue
> > 
> Will fix it.
> 
> > > +	 * only start freezing it.
> > > +	 */
> > > +	blk_freeze_queue_start(q);
> > > +
> > > +	/* When quiescing completes, all ongoing dispatches have completed
> > > +	 * and no new dispatch will happen towards the driver.
> > > +	 * This ensures that later when cancel is attempted, then are not
> > 
> > they are not?
> > 
> Will fix this too.
> 
> > > +	 * getting processed by the queue_rq() or queue_rqs() handlers.
> > > +	 */
> > > +	blk_mq_quiesce_queue(q);
> > > +
> > > +	/*
> > > +	 * Synchronize with any ongoing VQ callbacks that may have started
> > > +	 * before the VQs were marked as broken. Any outstanding requests
> > > +	 * will be completed by virtblk_request_cancel().
> > > +	 */
> > > +	virtio_synchronize_cbs(vblk->vdev);
> > > +
> > > +	/* At this point, no new requests can enter the queue_rq() and
> > > +	 * completion routine will not complete any new requests either for
> > the
> > > +	 * broken vq. Hence, it is safe to cancel all requests which are
> > > +	 * started.
> > > +	 */
> > > +	blk_mq_tagset_busy_iter(&vblk->tag_set, virtblk_request_cancel,
> > vblk);
> > > +	blk_mq_tagset_wait_completed_request(&vblk->tag_set);
> > > +
> > > +	/* All pending requests are cleaned up. Time to resume so that disk
> > > +	 * deletion can be smooth. Start the HW queues so that when queue
> > is
> > > +	 * unquiesced requests can again enter the driver.
> > > +	 */
> > > +	blk_mq_start_stopped_hw_queues(q, true);
> > > +
> > > +	/* Unquiescing will trigger dispatching any pending requests to the
> > > +	 * driver which has crossed bio_queue_enter() to the driver.
> > > +	 */
> > > +	blk_mq_unquiesce_queue(q);
> > > +
> > > +	/* Wait for all pending dispatches to terminate which may have been
> > > +	 * initiated after unquiescing.
> > > +	 */
> > > +	blk_mq_freeze_queue_wait(q);
> > > +
> > > +	/* Mark the disk dead so that once queue unfreeze, the requests
> > 
> > ... once we unfreeze the queue
> > 
> > 
> Ok.
> 
> > > +	 * waiting at the door of bio_queue_enter() can be aborted right
> > away.
> > > +	 */
> > > +	blk_mark_disk_dead(vblk->disk);
> > > +
> > > +	/* Unfreeze the queue so that any waiting requests will be aborted.
> > */
> > > +	blk_mq_unfreeze_queue_nomemrestore(q);
> > > +}
> > > +
> > >  static void virtblk_remove(struct virtio_device *vdev)  {
> > >  	struct virtio_blk *vblk = vdev->priv; @@ -1561,6 +1641,8 @@ static
> > > void virtblk_remove(struct virtio_device *vdev)
> > >  	/* Make sure no work handler is accessing the device. */
> > >  	flush_work(&vblk->config_work);
> > >
> > 
> > I prefer simply moving the test here:
> > 
> > 	if (virtqueue_is_broken(vblk->vqs[0].vq))
> > 		virtblk_broken_device_cleanup(vblk);
> > 
> > makes it much clearer what is going on, imho.
> > 
> No strong preference, some maintainers prefer the current way others the way you preferred.
> So will fix as you proposed here along with above fixes in v4.
> 
> Thanks
> 
> > 
> > >  	del_gendisk(vblk->disk);
> > >  	blk_mq_free_tag_set(&vblk->tag_set);
> > >
> > > --
> > > 2.34.1


