Return-Path: <stable+bounces-23356-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7682185FC97
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 16:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4C96B21CEF
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 15:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0D014D42F;
	Thu, 22 Feb 2024 15:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IbNZNX0c"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F1214D447
	for <stable@vger.kernel.org>; Thu, 22 Feb 2024 15:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708616330; cv=none; b=nLaEvmJQFn8UP5rHjQpBh0nPuyg3YNGIg0Ha+UQ6PMhewYTSv+/k8D2iNAK+Uwv4XzU4T+mzNnLZhdTMQAm+7a6Uin4j1OglCfehGDf2Tgvmz/q7Io2anvUCbj5Y/e/PlJgR8qTU5j1LJB+gmuVpEfXgBdi7tfN8zPSnJ9oONIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708616330; c=relaxed/simple;
	bh=L5F8JnTZwR7MfRhy7vaTlwBFtRDJN5gOEZJoz5rwRKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oTK+E568fpPwAFWGdi6SPzg8+LNbZI0Q7JNhJrqNUyVnVdaXI8yOBXZf40iBxqFAcchBQsGWloXXC8Agun0WZU0QMeTCU2MUuKZbFsrHz6M49aEqtujQYSQYCjdLZve12Ul7JI6lnfbxtnuKq/cFFCHDWDKU7fwD6drP7UPGyw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IbNZNX0c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708616327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0X7c7Z3KoboVukw+ncoNPXIIn3mkdVyhY9kWZol2hQs=;
	b=IbNZNX0cUB3jrzbfwtQHvDSM62nhbpLG7yPmyXbKzaKSlI6RoYy/qVuYnaX+Xq4M1Qio+a
	jZxbS0OC9zdtH0FfQf4GQpcQuRqHt6gbcyOJRiGDkGEYPQxhAizaF+nViHJ8ossdZE0zx/
	foDafoYRtFEosQgNAk9ha2TSBgPi8Kk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-ygUDxRIuNkGlzIb9-ZJGkw-1; Thu, 22 Feb 2024 10:38:45 -0500
X-MC-Unique: ygUDxRIuNkGlzIb9-ZJGkw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-410e83001cbso42215175e9.3
        for <stable@vger.kernel.org>; Thu, 22 Feb 2024 07:38:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708616324; x=1709221124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0X7c7Z3KoboVukw+ncoNPXIIn3mkdVyhY9kWZol2hQs=;
        b=IrUZ/AzDe0L7O7zrKnaOa5vpKhhkD5DN3SCe44KNSQY56g2rr5yJEV41MERuMuIjDu
         Bc3VfiiHJ/FwDZH8r6pg89TPRJ8bz+qO/evwc0V9QhuqfXwP1ewbcLqS4Gvm0RsRwQq/
         cKdrA6naBIvjy9O9Xx3KeaDtSYEOACtAmv3NtJ/gzGkwc7yGpJLKF+AA17qQPoceHn1r
         l7eJQE19Le/v+pIR9oqK+gjlTQtKWXjandU5kAZ9VC/LCnqwgor9V9WEfxMrq0v1fDzU
         zbIN4zluL5zJiUf6F1QFhZtjFkNS8hgBcHoNHHGYBfj09c46435Z1TTxs9PMRq2qQtMZ
         FnKg==
X-Forwarded-Encrypted: i=1; AJvYcCW/oNDICFM526mVfFKjeOGnB1clJo/i89232NvYFJsUoQ+nsvassp1R5npRkPKpRdYZIkLCp8GTp7oV8fguIBBt9RMaaDD5
X-Gm-Message-State: AOJu0YxypZsdzNpWQRyLlKH1DC30Bxn9XQVfSKVc27aneDBNXpBLWjke
	LUo/j9iboy4hqXofgCf1YjtaQMzpPn2v67rkhVgQSUtZXePjIPnwzkLJ2h4Yxz8UiJscoOvsfMs
	IbeAA6CYFOdm5lkCSJFgVAG24/X5mV4r9aEVvCOk/+Gq5uJAYQOkduTFh8ihszA==
X-Received: by 2002:a05:600c:314f:b0:412:7676:ddbe with SMTP id h15-20020a05600c314f00b004127676ddbemr3676700wmo.29.1708616324047;
        Thu, 22 Feb 2024 07:38:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEpHfyfupJlHxWq69OK/dcT9TMXWoSOM2W0+/+Xp/Dg3NnAyZxxgBqYqYi0S1tcOGG+UvZZow==
X-Received: by 2002:a05:600c:314f:b0:412:7676:ddbe with SMTP id h15-20020a05600c314f00b004127676ddbemr3676679wmo.29.1708616323670;
        Thu, 22 Feb 2024 07:38:43 -0800 (PST)
Received: from redhat.com ([2a06:c701:73fa:1600:1669:f0ad:816d:4f7])
        by smtp.gmail.com with ESMTPSA id 21-20020a05600c229500b0041228b2e179sm21867188wmf.39.2024.02.22.07.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 07:38:43 -0800 (PST)
Date: Thu, 22 Feb 2024 10:38:40 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"NBU-Contact-Li Rongqing (EXTERNAL)" <lirongqing@baidu.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH] virtio_blk: Fix device surprise removal
Message-ID: <20240222103117-mutt-send-email-mst@kernel.org>
References: <20240217180848.241068-1-parav@nvidia.com>
 <20240220220501.GA1515311@fedora>
 <PH0PR12MB54812D3772181FEAA46054BEDC562@PH0PR12MB5481.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR12MB54812D3772181FEAA46054BEDC562@PH0PR12MB5481.namprd12.prod.outlook.com>

On Thu, Feb 22, 2024 at 04:46:38AM +0000, Parav Pandit wrote:
> 
> 
> > From: Stefan Hajnoczi <stefanha@redhat.com>
> > Sent: Wednesday, February 21, 2024 3:35 AM
> > To: Parav Pandit <parav@nvidia.com>
> > 
> > On Sat, Feb 17, 2024 at 08:08:48PM +0200, Parav Pandit wrote:
> > > When the PCI device is surprise removed, requests won't complete from
> > > the device. These IOs are never completed and disk deletion hangs
> > > indefinitely.
> > >
> > > Fix it by aborting the IOs which the device will never complete when
> > > the VQ is broken.
> > >
> > > With this fix now fio completes swiftly.
> > > An alternative of IO timeout has been considered, however when the
> > > driver knows about unresponsive block device, swiftly clearing them
> > > enables users and upper layers to react quickly.
> > >
> > > Verified with multiple device unplug cycles with pending IOs in virtio
> > > used ring and some pending with device.
> > >
> > > In future instead of VQ broken, a more elegant method can be used. At
> > > the moment the patch is kept to its minimal changes given its urgency
> > > to fix broken kernels.
> > >
> > > Fixes: 43bb40c5b926 ("virtio_pci: Support surprise removal of virtio
> > > pci device")
> > > Cc: stable@vger.kernel.org
> > > Reported-by: lirongqing@baidu.com
> > > Closes:
> > > https://lore.kernel.org/virtualization/c45dd68698cd47238c55fb73ca9b474
> > > 1@baidu.com/
> > > Co-developed-by: Chaitanya Kulkarni <kch@nvidia.com>
> > > Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > > ---
> > >  drivers/block/virtio_blk.c | 54
> > > ++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 54 insertions(+)
> > >
> > > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > > index 2bf14a0e2815..59b49899b229 100644
> > > --- a/drivers/block/virtio_blk.c
> > > +++ b/drivers/block/virtio_blk.c
> > > @@ -1562,10 +1562,64 @@ static int virtblk_probe(struct virtio_device
> > *vdev)
> > >  	return err;
> > >  }
> > >
> > > +static bool virtblk_cancel_request(struct request *rq, void *data) {
> > > +	struct virtblk_req *vbr = blk_mq_rq_to_pdu(rq);
> > > +
> > > +	vbr->in_hdr.status = VIRTIO_BLK_S_IOERR;
> > > +	if (blk_mq_request_started(rq) && !blk_mq_request_completed(rq))
> > > +		blk_mq_complete_request(rq);
> > > +
> > > +	return true;
> > > +}
> > > +
> > > +static void virtblk_cleanup_reqs(struct virtio_blk *vblk) {
> > > +	struct virtio_blk_vq *blk_vq;
> > > +	struct request_queue *q;
> > > +	struct virtqueue *vq;
> > > +	unsigned long flags;
> > > +	int i;
> > > +
> > > +	vq = vblk->vqs[0].vq;
> > > +	if (!virtqueue_is_broken(vq))
> > > +		return;
> > > +
> > > +	q = vblk->disk->queue;
> > > +	/* Block upper layer to not get any new requests */
> > > +	blk_mq_quiesce_queue(q);
> > > +
> > > +	for (i = 0; i < vblk->num_vqs; i++) {
> > > +		blk_vq = &vblk->vqs[i];
> > > +
> > > +		/* Synchronize with any ongoing virtblk_poll() which may be
> > > +		 * completing the requests to uppper layer which has already
> > > +		 * crossed the broken vq check.
> > > +		 */
> > > +		spin_lock_irqsave(&blk_vq->lock, flags);
> > > +		spin_unlock_irqrestore(&blk_vq->lock, flags);
> > > +	}
> > > +
> > > +	blk_sync_queue(q);
> > > +
> > > +	/* Complete remaining pending requests with error */
> > > +	blk_mq_tagset_busy_iter(&vblk->tag_set, virtblk_cancel_request,
> > > +vblk);
> > 
> > Interrupts can still occur here. What prevents the race between
> > virtblk_cancel_request() and virtblk_request_done()?
> >
> The PCI device which generates the interrupt is already removed so interrupt shouldn't arrive when executing cancel_request.
> (This is ignoring the race that Ming pointed out. I am preparing the v1 that eliminates such condition.)
> 
> If there was ongoing virtblk_request_done() is synchronized by the for loop above.
> 

Yes, this works, but I feel this is very subtle. This is why I am asking
whether we should instead call virtio_synchronize_cbs and then just
invoke all the callbacks one last time from virtio core? 


> > > +	blk_mq_tagset_wait_completed_request(&vblk->tag_set);
> > > +
> > > +	/*
> > > +	 * Unblock any pending dispatch I/Os before we destroy device. From
> > > +	 * del_gendisk() -> __blk_mark_disk_dead(disk) will set GD_DEAD
> > flag,
> > > +	 * that will make sure any new I/O from bio_queue_enter() to fail.
> > > +	 */
> > > +	blk_mq_unquiesce_queue(q);
> > > +}
> > > +
> > >  static void virtblk_remove(struct virtio_device *vdev)  {
> > >  	struct virtio_blk *vblk = vdev->priv;
> > >
> > > +	virtblk_cleanup_reqs(vblk);
> > > +
> > >  	/* Make sure no work handler is accessing the device. */
> > >  	flush_work(&vblk->config_work);
> > >
> > > --
> > > 2.34.1
> > >


