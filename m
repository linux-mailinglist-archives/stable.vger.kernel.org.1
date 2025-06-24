Return-Path: <stable+bounces-158453-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7A5AE6F2C
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 21:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9BA017F563
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 19:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8242343CF;
	Tue, 24 Jun 2025 19:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RZWMoeP1"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A5E170826
	for <stable@vger.kernel.org>; Tue, 24 Jun 2025 19:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750792018; cv=none; b=DOf0fc0fPAy8R6exnypMY+NqyUaWcSHPGX+qEyfzhJV7ST1g1cUi9x0wcOQ9E60a/ejV/w6CEs+mIlkhZ5ujME8PIR4kMPB0vEhVUvyVdEO+yjxSXMINk3YNQZS3XfpZxomi2iRk9Uz60knHADgdPJynu5fWkwceHj/2toR+XXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750792018; c=relaxed/simple;
	bh=BSikVd5xvSZ6ComeCvHQH7V+evnP3qlaa69GJyEvSEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R6KF2fBs1/EkpKkRApZxQCsZiKq10HavI1dCY//oWlyYkiEnN+Ih4j5YgDevFBPou62s5SBsfmSO1cgQUAZRqnxRB/DqX/NyDxf8Ioon6kFerciHytgZWmK58FLbjCk29pBCj1Zos+Wxa5+ijwnjHr9vBMPbNDLSaYTby+k0j3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RZWMoeP1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750792015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f0IWE3ksziEN+5IWDsiw1ZOMRz5q7QQYfoprVc+li2Q=;
	b=RZWMoeP1dzlAXjcZtFsTorC7deYMpwA7hcIMjvgfpYinM6KiKOSGsbWinkWQxGGPffxuNg
	XIIp5+Pz6nPEcnONECwE6rawxJ0B0WN8HEuFZDClRtU8MQ7Rp86b53i639ynuaJgoDMd3o
	ruoEdvImU3h442v5n7Zm+0jgy0pd/f4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-LkzcU0OUMcGt7wL4F6EcLg-1; Tue, 24 Jun 2025 15:06:54 -0400
X-MC-Unique: LkzcU0OUMcGt7wL4F6EcLg-1
X-Mimecast-MFC-AGG-ID: LkzcU0OUMcGt7wL4F6EcLg_1750792013
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-607142010bcso4263336a12.0
        for <stable@vger.kernel.org>; Tue, 24 Jun 2025 12:06:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750792013; x=1751396813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f0IWE3ksziEN+5IWDsiw1ZOMRz5q7QQYfoprVc+li2Q=;
        b=jF3P0WJ4W7roODXNb2MwRnTLqMJhGFiIsUp3jClmYzFyow4ixUfeaKCXpQUm1sC7vd
         laM8ieNTNQ3hfVImr2DupvPNEiv5fNCg4WVb4v9WK4go4iiUXUW3Y8OVlW/D4Be833TM
         4JzBuwHerfJHuHnqR5j8DklUfPTfaIJ+oNi3Xph1Bg9RJbeZJgJIzPsRHqCmWvKjUclA
         bK1RTeCODPHjviS/YoUmHHUbfKlpEGsUnzrAU+dns9x31nU5kqmL5PQ0rpC4sysHjJ3X
         7q3bnkKvAyPkJaoVINojonGpaB6XBmBknSV50QKS0MzJLNjxYMDZ8LSatOhIz0eK6/hh
         wepA==
X-Forwarded-Encrypted: i=1; AJvYcCV6sU36pqc5o/VfSjBAvNzTNFAmM5tyLWjYHN5CZ2hHcZccHYjYC26DzAXh6Ifn5V4a83FUco0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMnWNeHMByW4PmEanDQlagbJFTY6hUA87YfxLa9xb90WJmbhMb
	fpuZGbcK+ka4OOtvcqvDevls1i//yvH2Jji2R4mxsAvrddlk2xWiyUCOiZAfMJQLNpIwnR+w4MQ
	lZwfARGs6m95GjHGZ840LgotDb3bui0eueSCD1qCjpG583TAQ0h5XtrIuCA==
X-Gm-Gg: ASbGncveukkMH/maNrPsfENX7T7AF3AqQ5IFCoF1t5YYS9YewpkVg3w9HWnvmGlHXtm
	Xp++ICltiUqxaVgyCumKSGsA6CDs1/Z8nc22hQYlbD4iUM1VS/V6OZPNLSgOL2uGZ+MeHDW4bIh
	MX9WbaEJVi1YUYbT2VWX5dm0q7dTVIY9IXtAlovXRT+XOcMbY7iPet65LRvwhbrDFzoi8cxgG1Q
	sKkl3ZNJkicajJbx33gd3dqkqCQWQqUhCqDKQNx5noy3qWYFOWmEV0mAlUJj+kuxV7G7EEra0av
	RCbqEg1OekU=
X-Received: by 2002:a17:906:ae94:b0:ade:3eb6:3c6 with SMTP id a640c23a62f3a-ae0becbbf6dmr38677866b.15.1750792012971;
        Tue, 24 Jun 2025 12:06:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFW2LkEBrKlc7ZIszzDJMsj20/dhGL36Cj8Knqyxm6oUxjiW9zrOJYlhfSO9ujC4Ss7+7Tb+g==
X-Received: by 2002:a17:906:ae94:b0:ade:3eb6:3c6 with SMTP id a640c23a62f3a-ae0becbbf6dmr38675066b.15.1750792012428;
        Tue, 24 Jun 2025 12:06:52 -0700 (PDT)
Received: from redhat.com ([31.187.78.68])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0541b75b0sm902890966b.126.2025.06.24.12.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 12:06:52 -0700 (PDT)
Date: Tue, 24 Jun 2025 15:06:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"NBU-Contact-Li Rongqing (EXTERNAL)" <lirongqing@baidu.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Israel Rukshin <israelr@nvidia.com>
Subject: Re: [PATCH v5] virtio_blk: Fix disk deletion hang on device surprise
 removal
Message-ID: <20250624150635-mutt-send-email-mst@kernel.org>
References: <20250602024358.57114-1-parav@nvidia.com>
 <20250624185622.GB5519@fedora>
 <CY8PR12MB719579F7DAD8B0C0A98CBC7FDC78A@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR12MB719579F7DAD8B0C0A98CBC7FDC78A@CY8PR12MB7195.namprd12.prod.outlook.com>

On Tue, Jun 24, 2025 at 07:01:44PM +0000, Parav Pandit wrote:
> 
> 
> > From: Stefan Hajnoczi <stefanha@redhat.com>
> > Sent: 25 June 2025 12:26 AM
> > 
> > On Mon, Jun 02, 2025 at 02:44:33AM +0000, Parav Pandit wrote:
> > > When the PCI device is surprise removed, requests may not complete the
> > > device as the VQ is marked as broken. Due to this, the disk deletion
> > > hangs.
> > 
> > There are loops in the core virtio driver code that expect device register reads
> > to eventually return 0:
> > drivers/virtio/virtio_pci_modern.c:vp_reset()
> > drivers/virtio/virtio_pci_modern_dev.c:vp_modern_set_queue_reset()
> > 
> > Is there a hang if these loops are hit when a device has been surprise
> > removed? I'm trying to understand whether surprise removal is fully
> > supported or whether this patch is one step in that direction.
> >
> In one of the previous replies I answered to Michael, but don't have the link handy.
> It is not fully supported by this patch. It will hang.
> 
> This patch restores driver back to the same state what it was before the fixes tag patch.
> The virtio stack level work is needed to support surprise removal, including the reset flow you rightly pointed.

Have plans to do that?

> > Apart from that, I'm happy with the virtio_blk.c aspects of the patch:
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > 
> Thanks.
> 
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
> > > v4->v5:
> > > - fixed comment style where comment to start with one empty line at
> > > start
> > > - Addressed comments from Alok
> > > - fixed typo in broken vq check
> > > v3->v4:
> > > - Addressed comments from Michael
> > > - renamed virtblk_request_cancel() to
> > >   virtblk_complete_request_with_ioerr()
> > > - Added comments for virtblk_complete_request_with_ioerr()
> > > - Renamed virtblk_broken_device_cleanup() to
> > >   virtblk_cleanup_broken_device()
> > > - Added comments for virtblk_cleanup_broken_device()
> > > - Moved the broken vq check in virtblk_remove()
> > > - Fixed comment style to have first empty line
> > > - replaced freezed to frozen
> > > - Fixed comments rephrased
> > >
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
> > > ---
> > >  drivers/block/virtio_blk.c | 95
> > > ++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 95 insertions(+)
> > >
> > > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > > index 7cffea01d868..c5e383c0ac48 100644
> > > --- a/drivers/block/virtio_blk.c
> > > +++ b/drivers/block/virtio_blk.c
> > > @@ -1554,6 +1554,98 @@ static int virtblk_probe(struct virtio_device
> > *vdev)
> > >  	return err;
> > >  }
> > >
> > > +/*
> > > + * If the vq is broken, device will not complete requests.
> > > + * So we do it for the device.
> > > + */
> > > +static bool virtblk_complete_request_with_ioerr(struct request *rq,
> > > +void *data) {
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
> > > +/*
> > > + * If the device is broken, it will not use any buffers and waiting
> > > + * for that to happen is pointless. We'll do the cleanup in the
> > > +driver,
> > > + * completing all requests for the device.
> > > + */
> > > +static void virtblk_cleanup_broken_device(struct virtio_blk *vblk) {
> > > +	struct request_queue *q = vblk->disk->queue;
> > > +
> > > +	/*
> > > +	 * Start freezing the queue, so that new requests keeps waiting at the
> > > +	 * door of bio_queue_enter(). We cannot fully freeze the queue
> > because
> > > +	 * frozen queue is an empty queue and there are pending requests, so
> > > +	 * only start freezing it.
> > > +	 */
> > > +	blk_freeze_queue_start(q);
> > > +
> > > +	/*
> > > +	 * When quiescing completes, all ongoing dispatches have completed
> > > +	 * and no new dispatch will happen towards the driver.
> > > +	 */
> > > +	blk_mq_quiesce_queue(q);
> > > +
> > > +	/*
> > > +	 * Synchronize with any ongoing VQ callbacks that may have started
> > > +	 * before the VQs were marked as broken. Any outstanding requests
> > > +	 * will be completed by virtblk_complete_request_with_ioerr().
> > > +	 */
> > > +	virtio_synchronize_cbs(vblk->vdev);
> > > +
> > > +	/*
> > > +	 * At this point, no new requests can enter the queue_rq() and
> > > +	 * completion routine will not complete any new requests either for
> > the
> > > +	 * broken vq. Hence, it is safe to cancel all requests which are
> > > +	 * started.
> > > +	 */
> > > +	blk_mq_tagset_busy_iter(&vblk->tag_set,
> > > +				virtblk_complete_request_with_ioerr, vblk);
> > > +	blk_mq_tagset_wait_completed_request(&vblk->tag_set);
> > > +
> > > +	/*
> > > +	 * All pending requests are cleaned up. Time to resume so that disk
> > > +	 * deletion can be smooth. Start the HW queues so that when queue
> > is
> > > +	 * unquiesced requests can again enter the driver.
> > > +	 */
> > > +	blk_mq_start_stopped_hw_queues(q, true);
> > > +
> > > +	/*
> > > +	 * Unquiescing will trigger dispatching any pending requests to the
> > > +	 * driver which has crossed bio_queue_enter() to the driver.
> > > +	 */
> > > +	blk_mq_unquiesce_queue(q);
> > > +
> > > +	/*
> > > +	 * Wait for all pending dispatches to terminate which may have been
> > > +	 * initiated after unquiescing.
> > > +	 */
> > > +	blk_mq_freeze_queue_wait(q);
> > > +
> > > +	/*
> > > +	 * Mark the disk dead so that once we unfreeze the queue, requests
> > > +	 * waiting at the door of bio_queue_enter() can be aborted right
> > away.
> > > +	 */
> > > +	blk_mark_disk_dead(vblk->disk);
> > > +
> > > +	/* Unfreeze the queue so that any waiting requests will be aborted. */
> > > +	blk_mq_unfreeze_queue_nomemrestore(q);
> > > +}
> > > +
> > >  static void virtblk_remove(struct virtio_device *vdev)  {
> > >  	struct virtio_blk *vblk = vdev->priv; @@ -1561,6 +1653,9 @@ static
> > > void virtblk_remove(struct virtio_device *vdev)
> > >  	/* Make sure no work handler is accessing the device. */
> > >  	flush_work(&vblk->config_work);
> > >
> > > +	if (virtqueue_is_broken(vblk->vqs[0].vq))
> > > +		virtblk_cleanup_broken_device(vblk);
> > > +
> > >  	del_gendisk(vblk->disk);
> > >  	blk_mq_free_tag_set(&vblk->tag_set);
> > >
> > > --
> > > 2.34.1
> > >


