Return-Path: <stable+bounces-23353-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F0085FC63
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 16:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DB54284795
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 15:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D1A14D434;
	Thu, 22 Feb 2024 15:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cFXXswqg"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D975814C5B5
	for <stable@vger.kernel.org>; Thu, 22 Feb 2024 15:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708615874; cv=none; b=N/jOLAYLoxHv7MDt8fjkSdAtdXD8Z4nw+MORYSvafruX/gULIuhD3Zft/RGODvhZIge2JJ7qenxgnJUoxOHHZo59+SyiMbpg4thCGq1apHcfNSyzgNFRwgxfzHgOabjrPGYVPQ4JRu5mjci84skoS/h3QCIx32fmyn6kGOHtJSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708615874; c=relaxed/simple;
	bh=YQ8ABEakDucsJjgrjnT4oGIqS8F+izB7K8eXgRXG7qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Og1sOw9baCdKdrryFPA/zZQWOzeaef8fVaKW0NmNEA1Uw1shY4YBayGaG95WBwcEMbNPBCSG+V/AVe3cA3WdbWbfV7fkfjArD4Pw/3QFX/19f1Y5kmqR699y644JDeXHP37/7gtrmw+sFjDP6hb3UCLUN8tRCejv5L5eFklvaHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cFXXswqg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708615871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lG3DZJ4liCKFDLhiwb2y6WslPOOHg1knNqdeOCLSOt4=;
	b=cFXXswqgy02TiUaDukz3jRyqeaLFk29mU2R1qpNSoqYiTGPX2b241b72HXIPTY2Zh7I5mr
	7O4d9iB3t5AU2C56Mr4zEPQSM0hyYLn0L/5zjDm4Ayl9Bvpl7/thMmHtlpGxv36UuPkxOn
	SBg+Vjaq9OWSHMx3tQ9wlh+58YSW5OY=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-qcG-1EM5NyuC_cDaIQCc7w-1; Thu, 22 Feb 2024 10:31:10 -0500
X-MC-Unique: qcG-1EM5NyuC_cDaIQCc7w-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-512cca527f2so2740281e87.2
        for <stable@vger.kernel.org>; Thu, 22 Feb 2024 07:31:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708615868; x=1709220668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lG3DZJ4liCKFDLhiwb2y6WslPOOHg1knNqdeOCLSOt4=;
        b=oYTBtQJhTmRqHnPZszVNPzdlS3Ejj2CDGfonr6sY3yA8AjWRkQJQ6rpKRhQo1F41J4
         dtQnr3pvt7XT1sYNUr6IQkijpoOLNm7H+vIVYdzF1Cb2oy7+dm31Vk6J/H1Ph6nHFXnn
         T+kbHe5tfkQKs+1nnBPH9e2Q3HPB9ZwuwkqAi+3z1TpBpm/a3hBcA0d2H8t3/2SKrXsy
         yrceDq44OJUZg8x7fjzfAHtTZ5hMSK3RQsr+jyvPTlbR9V8zg/Hj0Yoine8iPi3KG8tc
         K18B99N0sthWuaHMRwKVqiaKPQsRmQ4r5TnqO7Fm2n9Nc2qoU002CdKAAAgDpZDfNyJf
         2eDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUg+McXu0MPrxI3Ic5cNIrj8SsBMTBSmPZDw3NfnCF1/nJ2njrq+knM3olXNGrDb2VUa5VMZJT4uUNPUTmChXLglOmzhsMQ
X-Gm-Message-State: AOJu0YzMdC2jRtN3jzQ8yLFeapPmYKpuJBexZsUiSQ49lP31dZ5INkNK
	h1H4ad31C1BWC+ap2m2HhuXPX6xd0g6NGJrqB7QRoCmf07wNtXyxHdsLYLnlmvASaOVeCbphmFZ
	cgz5/WKZVV1lJdweQK8WOpJ4UcYQjUkSJTZofmL6SgXM/4yoi7pWOJ7fCGtbPhw==
X-Received: by 2002:a05:6512:3993:b0:512:df99:32af with SMTP id j19-20020a056512399300b00512df9932afmr1363400lfu.31.1708615868239;
        Thu, 22 Feb 2024 07:31:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFAiwUfe50qvq2g1UFfx40cd557jbXcO44d2B81os6mJYr3qZg2YB7k88wqReFA5UHrI0YDFA==
X-Received: by 2002:a05:6512:3993:b0:512:df99:32af with SMTP id j19-20020a056512399300b00512df9932afmr1363377lfu.31.1708615867819;
        Thu, 22 Feb 2024 07:31:07 -0800 (PST)
Received: from redhat.com ([2a06:c701:73fa:1600:1669:f0ad:816d:4f7])
        by smtp.gmail.com with ESMTPSA id m16-20020a05600c3b1000b0041262ec5f0esm15964207wms.1.2024.02.22.07.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 07:31:07 -0800 (PST)
Date: Thu, 22 Feb 2024 10:31:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>,
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
Message-ID: <20240222102755-mutt-send-email-mst@kernel.org>
References: <20240217180848.241068-1-parav@nvidia.com>
 <20240220220501.GA1515311@fedora>
 <PH0PR12MB54812D3772181FEAA46054BEDC562@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20240222152328.GA1810574@fedora>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222152328.GA1810574@fedora>

On Thu, Feb 22, 2024 at 10:23:28AM -0500, Stefan Hajnoczi wrote:
> On Thu, Feb 22, 2024 at 04:46:38AM +0000, Parav Pandit wrote:
> > 
> > 
> > > From: Stefan Hajnoczi <stefanha@redhat.com>
> > > Sent: Wednesday, February 21, 2024 3:35 AM
> > > To: Parav Pandit <parav@nvidia.com>
> > > 
> > > On Sat, Feb 17, 2024 at 08:08:48PM +0200, Parav Pandit wrote:
> > > > When the PCI device is surprise removed, requests won't complete from
> > > > the device. These IOs are never completed and disk deletion hangs
> > > > indefinitely.
> > > >
> > > > Fix it by aborting the IOs which the device will never complete when
> > > > the VQ is broken.
> > > >
> > > > With this fix now fio completes swiftly.
> > > > An alternative of IO timeout has been considered, however when the
> > > > driver knows about unresponsive block device, swiftly clearing them
> > > > enables users and upper layers to react quickly.
> > > >
> > > > Verified with multiple device unplug cycles with pending IOs in virtio
> > > > used ring and some pending with device.
> > > >
> > > > In future instead of VQ broken, a more elegant method can be used. At
> > > > the moment the patch is kept to its minimal changes given its urgency
> > > > to fix broken kernels.
> > > >
> > > > Fixes: 43bb40c5b926 ("virtio_pci: Support surprise removal of virtio
> > > > pci device")
> > > > Cc: stable@vger.kernel.org
> > > > Reported-by: lirongqing@baidu.com
> > > > Closes:
> > > > https://lore.kernel.org/virtualization/c45dd68698cd47238c55fb73ca9b474
> > > > 1@baidu.com/
> > > > Co-developed-by: Chaitanya Kulkarni <kch@nvidia.com>
> > > > Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> > > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > > > ---
> > > >  drivers/block/virtio_blk.c | 54
> > > > ++++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 54 insertions(+)
> > > >
> > > > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > > > index 2bf14a0e2815..59b49899b229 100644
> > > > --- a/drivers/block/virtio_blk.c
> > > > +++ b/drivers/block/virtio_blk.c
> > > > @@ -1562,10 +1562,64 @@ static int virtblk_probe(struct virtio_device
> > > *vdev)
> > > >  	return err;
> > > >  }
> > > >
> > > > +static bool virtblk_cancel_request(struct request *rq, void *data) {
> > > > +	struct virtblk_req *vbr = blk_mq_rq_to_pdu(rq);
> > > > +
> > > > +	vbr->in_hdr.status = VIRTIO_BLK_S_IOERR;
> > > > +	if (blk_mq_request_started(rq) && !blk_mq_request_completed(rq))
> > > > +		blk_mq_complete_request(rq);
> > > > +
> > > > +	return true;
> > > > +}
> > > > +
> > > > +static void virtblk_cleanup_reqs(struct virtio_blk *vblk) {
> > > > +	struct virtio_blk_vq *blk_vq;
> > > > +	struct request_queue *q;
> > > > +	struct virtqueue *vq;
> > > > +	unsigned long flags;
> > > > +	int i;
> > > > +
> > > > +	vq = vblk->vqs[0].vq;
> > > > +	if (!virtqueue_is_broken(vq))
> > > > +		return;
> > > > +
> > > > +	q = vblk->disk->queue;
> > > > +	/* Block upper layer to not get any new requests */
> > > > +	blk_mq_quiesce_queue(q);
> > > > +
> > > > +	for (i = 0; i < vblk->num_vqs; i++) {
> > > > +		blk_vq = &vblk->vqs[i];
> > > > +
> > > > +		/* Synchronize with any ongoing virtblk_poll() which may be
> > > > +		 * completing the requests to uppper layer which has already
> > > > +		 * crossed the broken vq check.
> > > > +		 */
> > > > +		spin_lock_irqsave(&blk_vq->lock, flags);
> > > > +		spin_unlock_irqrestore(&blk_vq->lock, flags);
> > > > +	}
> > > > +
> > > > +	blk_sync_queue(q);
> > > > +
> > > > +	/* Complete remaining pending requests with error */
> > > > +	blk_mq_tagset_busy_iter(&vblk->tag_set, virtblk_cancel_request,
> > > > +vblk);
> > > 
> > > Interrupts can still occur here. What prevents the race between
> > > virtblk_cancel_request() and virtblk_request_done()?
> > >
> > The PCI device which generates the interrupt is already removed so interrupt shouldn't arrive when executing cancel_request.
> > (This is ignoring the race that Ming pointed out. I am preparing the v1 that eliminates such condition.)
> > 
> > If there was ongoing virtblk_request_done() is synchronized by the for loop above.
> 
> Ah, I see now that:
> 
> +if (!virtqueue_is_broken(vq))
> +    return;
> 
> relates to:
> 
> static void virtio_pci_remove(struct pci_dev *pci_dev)
> {
> 	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
> 	struct device *dev = get_device(&vp_dev->vdev.dev);
> 
> 	/*
> 	 * Device is marked broken on surprise removal so that virtio upper
> 	 * layers can abort any ongoing operation.
> 	 */
> 	if (!pci_device_is_present(pci_dev))
> 		virtio_break_device(&vp_dev->vdev);

It's not 100% reliable though. We did it opportunistically but if you
suddenly want to rely on it then you need to also synchronize
callbacks.

> Please rename virtblk_cleanup_reqs() to virtblk_cleanup_broken_device()
> or similar so it's clear that this function only applies when the device
> is broken? For example, it won't handle ACPI hot unplug requests because
> the device will still be present.
> 
> Thanks,
> Stefan
> 
> > 
> >  
> > > > +	blk_mq_tagset_wait_completed_request(&vblk->tag_set);
> > > > +
> > > > +	/*
> > > > +	 * Unblock any pending dispatch I/Os before we destroy device. From
> > > > +	 * del_gendisk() -> __blk_mark_disk_dead(disk) will set GD_DEAD
> > > flag,
> > > > +	 * that will make sure any new I/O from bio_queue_enter() to fail.
> > > > +	 */
> > > > +	blk_mq_unquiesce_queue(q);
> > > > +}
> > > > +
> > > >  static void virtblk_remove(struct virtio_device *vdev)  {
> > > >  	struct virtio_blk *vblk = vdev->priv;
> > > >
> > > > +	virtblk_cleanup_reqs(vblk);
> > > > +
> > > >  	/* Make sure no work handler is accessing the device. */
> > > >  	flush_work(&vblk->config_work);
> > > >
> > > > --
> > > > 2.34.1
> > > >
> > 



