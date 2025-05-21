Return-Path: <stable+bounces-145772-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DDCABEDAA
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 10:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 656894A3A74
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 08:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AF7234987;
	Wed, 21 May 2025 08:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iF31CoGF"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA0F22D4F2
	for <stable@vger.kernel.org>; Wed, 21 May 2025 08:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747815477; cv=none; b=jnaDbgkkpfegi21HRF8EAuSfdwMyOvraSJ791eq6TJF3kN7vc0DMkOrsvECHejCpRsycHrtZNrNKInWLCmI2tAdhAINOKN1l2NTUz9eIn/EYHp1GBnDoQ3+nEjNtDhczR32I+8/XZ8kVoNcvo9wNknzr1bvOAGyGLN7DG1fFGVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747815477; c=relaxed/simple;
	bh=/Md1wVc8jsu8RCloniLIcrAHX4lRcINHKYCHDmb1GT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwI7KjIIPWwbSsJSQSRiVi5sSPd7EgbshO9U9Y2b1nRiW1fxylglqjgh1AxRhbPlpSOQu9QXj9hHJTkpzVGPDxuYPzUQbAfnQaGdQxA9AM8/e3aVxVt5sFLJog3QhgDzp+LXzj8Y6YWWC4+wfSIdjAPrsV11AXI6Rn4rOAWbSok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iF31CoGF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747815474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5XzrO8wxMVXlpPsshH+MqZE9AXciR/wR4/zf6Sx4tJ8=;
	b=iF31CoGFJHKw9efrhZJ9m5P7ajbmb0Lo8DykJ6NI4+Oti1elrWPgeMYxm8NDFWzzF6JT96
	lMDSK7NWmAkrEcjnjoI/bq+/gxDtMQaLLg/CirbaWhh53XLyjg70rQ+cwyDst5xbeC2Zp+
	o/V3Vfd6qh7aeM7BM2lGZsxYcBC1BJE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-By6axXOkNBK_cKCgFFMFWA-1; Wed, 21 May 2025 04:17:53 -0400
X-MC-Unique: By6axXOkNBK_cKCgFFMFWA-1
X-Mimecast-MFC-AGG-ID: By6axXOkNBK_cKCgFFMFWA_1747815472
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43d0a037f97so38848185e9.2
        for <stable@vger.kernel.org>; Wed, 21 May 2025 01:17:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747815472; x=1748420272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5XzrO8wxMVXlpPsshH+MqZE9AXciR/wR4/zf6Sx4tJ8=;
        b=C02xEkMv3oB+QB4kPoeS1OCZwnuMR0rn+uDyE5yD0pghHQSDzp1azB3kAfH5O0U4SM
         jh+/UE1lS5cMtJsFSQFXB5/G+jD2fpiu6WaOEqPY74AGWR7kzhoTs2wRHJxgfW4tqAw0
         eCYh8Kw/8uoWdyHqo3RP8yFMOzJDlX93xGLElnUdbZLDaHLmjOwFNJ0Bu7s1/N51fiWz
         7mlyeQPgsbALbyS3SWGnHt1lyWy7Ru0GmcF97KA/MzGFfz0eda3Mmle/VHKS25s+ShL5
         zhNaxyXbuZxCxdTcQyE8GKOaOYoBggmUyor6S162cLKP0r2jBHcWasFOD1BvlrsJzubW
         hDVA==
X-Forwarded-Encrypted: i=1; AJvYcCVYrRKQRFx9FX3wK19Q9IABVA0xRkJAPNpNJ4k5jEit9OWA+tRvaXIXCgsobOFCASabszzAgZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBc3qqI9ZuOVfIZodLwRbdoEFEg+WU2r8OKvJ5pEAz41OdUaSP
	H8TEdRMgK/1KmeiKQmink4maGFgwgmmLWtvi/wFKbVAIlx2qc/a2wfOOe4qvkntMQF3jLLXb0Wo
	OzX8nU7YEakITRF/pqvhWVGp2f1OuS3RXnUI42ZksTJDMiX3D9fCtvubygA==
X-Gm-Gg: ASbGncsGkOinCSddmZrWQjDpQx69U3iAOdsqRJvtOHvd4XJx4BDNsm4wvXoiqsoxeVW
	ZCQwJAUXJ/x4eKzMvNvJfZlg9k0dGVi3VQYJyZstrGeTTKrabSOGskDFcPezg1qXn4cSbTnsY0j
	+cg8tsrt0Bb+ft3kAiSdHACWmvb8N/ZwCoat3wRMRqHNsr5YETioPtQK6pA81iqmnWrBnNYdJA5
	ZJBcR5qfpSiF0Nf0C2GfIOzGiyikR33LHzBLo14RGyT08TZh+ggImHgYtuIbiBKLYknU8NV5iaF
	lrKsMw==
X-Received: by 2002:a05:600c:4e14:b0:43d:563:6fef with SMTP id 5b1f17b1804b1-442ff031969mr162418325e9.21.1747815471659;
        Wed, 21 May 2025 01:17:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8z097l9PyFs5Kuqq7TGJjpdpAXxCe0BbGPvzb+M7qRUc6JXFhcT9Qb/VQ01c59gV3kROxQQ==
X-Received: by 2002:a05:600c:4e14:b0:43d:563:6fef with SMTP id 5b1f17b1804b1-442ff031969mr162417805e9.21.1747815471129;
        Wed, 21 May 2025 01:17:51 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f73d3defsm58843485e9.18.2025.05.21.01.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 01:17:50 -0700 (PDT)
Date: Wed, 21 May 2025 04:17:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: stefanha@redhat.com, axboe@kernel.dk, virtualization@lists.linux.dev,
	linux-block@vger.kernel.or, stable@vger.kernel.org,
	lirongqing@baidu.com, kch@nvidia.com, xuanzhuo@linux.alibaba.com,
	pbonzini@redhat.com, jasowang@redhat.com,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Israel Rukshin <israelr@nvidia.com>
Subject: Re: [PATCH v1] virtio_blk: Fix disk deletion hang on device surprise
 removal
Message-ID: <20250521041506-mutt-send-email-mst@kernel.org>
References: <20250521062744.1361774-1-parav@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521062744.1361774-1-parav@nvidia.com>

On Wed, May 21, 2025 at 06:37:41AM +0000, Parav Pandit wrote:
> When the PCI device is surprise removed, requests may not complete
> the device as the VQ is marked as broken. Due to this, the disk
> deletion hangs.
> 
> Fix it by aborting the requests when the VQ is broken.
> 
> With this fix now fio completes swiftly.
> An alternative of IO timeout has been considered, however
> when the driver knows about unresponsive block device, swiftly clearing
> them enables users and upper layers to react quickly.
> 
> Verified with multiple device unplug iterations with pending requests in
> virtio used ring and some pending with the device.
> 
> Fixes: 43bb40c5b926 ("virtio_pci: Support surprise removal of virtio pci device")
> Cc: stable@vger.kernel.org
> Reported-by: lirongqing@baidu.com
> Closes: https://lore.kernel.org/virtualization/c45dd68698cd47238c55fb73ca9b4741@baidu.com/
> Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> ---
> changelog:
> v0->v1:
> - Fixed comments from Stefan to rename a cleanup function
> - Improved logic for handling any outstanding requests
>   in bio layer
> - improved cancel callback to sync with ongoing done()

thanks for the patch!
questions:


> ---
>  drivers/block/virtio_blk.c | 95 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 95 insertions(+)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 7cffea01d868..5212afdbd3c7 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -435,6 +435,13 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
>  	blk_status_t status;
>  	int err;
>  
> +	/* Immediately fail all incoming requests if the vq is broken.
> +	 * Once the queue is unquiesced, upper block layer flushes any pending
> +	 * queued requests; fail them right away.
> +	 */
> +	if (unlikely(virtqueue_is_broken(vblk->vqs[qid].vq)))
> +		return BLK_STS_IOERR;
> +
>  	status = virtblk_prep_rq(hctx, vblk, req, vbr);
>  	if (unlikely(status))
>  		return status;

just below this:
        spin_lock_irqsave(&vblk->vqs[qid].lock, flags);
        err = virtblk_add_req(vblk->vqs[qid].vq, vbr);
        if (err) {


and virtblk_add_req calls virtqueue_add_sgs, so it will fail
on a broken vq.

Why do we need to check it one extra time here?



> @@ -508,6 +515,11 @@ static void virtio_queue_rqs(struct rq_list *rqlist)
>  	while ((req = rq_list_pop(rqlist))) {
>  		struct virtio_blk_vq *this_vq = get_virtio_blk_vq(req->mq_hctx);
>  
> +		if (unlikely(virtqueue_is_broken(this_vq->vq))) {
> +			rq_list_add_tail(&requeue_list, req);
> +			continue;
> +		}
> +
>  		if (vq && vq != this_vq)
>  			virtblk_add_req_batch(vq, &submit_list);
>  		vq = this_vq;

similarly

> @@ -1554,6 +1566,87 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	return err;
>  }
>  
> +static bool virtblk_request_cancel(struct request *rq, void *data)
> +{
> +	struct virtblk_req *vbr = blk_mq_rq_to_pdu(rq);
> +	struct virtio_blk *vblk = data;
> +	struct virtio_blk_vq *vq;
> +	unsigned long flags;
> +
> +	vq = &vblk->vqs[rq->mq_hctx->queue_num];
> +
> +	spin_lock_irqsave(&vq->lock, flags);
> +
> +	vbr->in_hdr.status = VIRTIO_BLK_S_IOERR;
> +	if (blk_mq_request_started(rq) && !blk_mq_request_completed(rq))
> +		blk_mq_complete_request(rq);
> +
> +	spin_unlock_irqrestore(&vq->lock, flags);
> +	return true;
> +}
> +
> +static void virtblk_broken_device_cleanup(struct virtio_blk *vblk)
> +{
> +	struct request_queue *q = vblk->disk->queue;
> +
> +	if (!virtqueue_is_broken(vblk->vqs[0].vq))
> +		return;
> +
> +	/* Start freezing the queue, so that new requests keeps waitng at the
> +	 * door of bio_queue_enter(). We cannot fully freeze the queue because
> +	 * freezed queue is an empty queue and there are pending requests, so
> +	 * only start freezing it.
> +	 */
> +	blk_freeze_queue_start(q);
> +
> +	/* When quiescing completes, all ongoing dispatches have completed
> +	 * and no new dispatch will happen towards the driver.
> +	 * This ensures that later when cancel is attempted, then are not
> +	 * getting processed by the queue_rq() or queue_rqs() handlers.
> +	 */
> +	blk_mq_quiesce_queue(q);
> +
> +	/*
> +	 * Synchronize with any ongoing VQ callbacks, effectively quiescing
> +	 * the device and preventing it from completing further requests
> +	 * to the block layer. Any outstanding, incomplete requests will be
> +	 * completed by virtblk_request_cancel().
> +	 */
> +	virtio_synchronize_cbs(vblk->vdev);
> +
> +	/* At this point, no new requests can enter the queue_rq() and
> +	 * completion routine will not complete any new requests either for the
> +	 * broken vq. Hence, it is safe to cancel all requests which are
> +	 * started.
> +	 */
> +	blk_mq_tagset_busy_iter(&vblk->tag_set, virtblk_request_cancel, vblk);
> +	blk_mq_tagset_wait_completed_request(&vblk->tag_set);
> +
> +	/* All pending requests are cleaned up. Time to resume so that disk
> +	 * deletion can be smooth. Start the HW queues so that when queue is
> +	 * unquiesced requests can again enter the driver.
> +	 */
> +	blk_mq_start_stopped_hw_queues(q, true);
> +
> +	/* Unquiescing will trigger dispatching any pending requests to the
> +	 * driver which has crossed bio_queue_enter() to the driver.
> +	 */
> +	blk_mq_unquiesce_queue(q);
> +
> +	/* Wait for all pending dispatches to terminate which may have been
> +	 * initiated after unquiescing.
> +	 */
> +	blk_mq_freeze_queue_wait(q);
> +
> +	/* Mark the disk dead so that once queue unfreeze, the requests
> +	 * waiting at the door of bio_queue_enter() can be aborted right away.
> +	 */
> +	blk_mark_disk_dead(vblk->disk);
> +
> +	/* Unfreeze the queue so that any waiting requests will be aborted. */
> +	blk_mq_unfreeze_queue_nomemrestore(q);
> +}
> +
>  static void virtblk_remove(struct virtio_device *vdev)
>  {
>  	struct virtio_blk *vblk = vdev->priv;
> @@ -1561,6 +1654,8 @@ static void virtblk_remove(struct virtio_device *vdev)
>  	/* Make sure no work handler is accessing the device. */
>  	flush_work(&vblk->config_work);
>  
> +	virtblk_broken_device_cleanup(vblk);
> +
>  	del_gendisk(vblk->disk);
>  	blk_mq_free_tag_set(&vblk->tag_set);
>  
> -- 
> 2.34.1


