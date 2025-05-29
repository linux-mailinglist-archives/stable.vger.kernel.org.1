Return-Path: <stable+bounces-148065-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 747B6AC7A06
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 10:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3512C4A796A
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 08:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F520219307;
	Thu, 29 May 2025 08:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ePxEsu2b"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE5B1E9919
	for <stable@vger.kernel.org>; Thu, 29 May 2025 08:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748505842; cv=none; b=DAhzkXyshSYOF0FmMirgqgZTob0y2yatEWx9RIqElgS7o8j8ga1S3qeyrJHsoeLeR4ZKjE69yfwSbgj0Hdw7rSyeoyFW1MfOEL4AudEyNb4rQOoMoop3HCuEvkPgwDjX9gd3KpQ6x+VL4boElyybpCs4WT6fZKJLtWtS38TvQZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748505842; c=relaxed/simple;
	bh=dR9QGKE90y/lp9jy4v7nUrC3OvpRiFOEyRDIq/Mb0K0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBfwp9yBFYFM2uLMx6NWmlQKFuKl1g+9ZHf0dSIoIHVj3xGggXrOwRlA2lX7XI79Rg9//jkeAyYF/tXokuEqBiu6ZKFnev11AMI/a5Xwf/7YFlmNyGBWlzQbfox7yn7q9gI0A8uRsmbNvhn2TVESwS0z/8yAMzE6EE7cZpP5PDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ePxEsu2b; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748505839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E+E8ddedkpspBDqc7m7TRdYhn2aSST9La2vzARWwv0M=;
	b=ePxEsu2bkQHFS2NNCvKY7HAE2IQ09Ev/1OIyKBhBjiNEfVePACSDKF7uHlzYyKlM+771R/
	5HLWVj9HYZO9GqXx3dQ8XbLCkc2ASi1E8VYCH2DBfgHY3fm/asI5Yu9vJFfA3ach0PQr69
	KxgFKOgQJCrnSLiY0erygh2OiY0xPJg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-jemxYxkEOtmHcgySC7660w-1; Thu, 29 May 2025 04:03:57 -0400
X-MC-Unique: jemxYxkEOtmHcgySC7660w-1
X-Mimecast-MFC-AGG-ID: jemxYxkEOtmHcgySC7660w_1748505836
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43cf5196c25so3848035e9.0
        for <stable@vger.kernel.org>; Thu, 29 May 2025 01:03:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748505836; x=1749110636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E+E8ddedkpspBDqc7m7TRdYhn2aSST9La2vzARWwv0M=;
        b=VRrLiQa1v5iXrQfWWcabKqGebL5y6EtbZ6lQunoipBNZGBuMj+hyyC+jJib0BVPK/Z
         nad0uAhyi+qlkjoT1UnDDm4CZ1rsdK7Hl5I0yclBimtnG9HVgoK3aqxe0SMlZiLod+ir
         qnR5RlbSmVUglOebWektskSYn5CFXRBrLtGf1P3aPN2xKA/R4KeRUvdMzSLhXDxo1ypt
         u2dm89MGsmEnxbFgvdQOSiAXVFRtCAdO9kOKh9kfo6Ki5hZ7VqgGoCElpO1RQLopFsOO
         ZvcDqjvpRX+PJubwm9rP5/98zKn4SxGu5/z6zrliIo3nvR/sQyGxBEzAKsjNGOuC9ovQ
         r1iA==
X-Forwarded-Encrypted: i=1; AJvYcCVBzcYxFglOUDxUXLLmkSGXqdlVbtzs8wfaP1u4WmsKIiCIM8kIluFwELmwbNy2fQn+G/BH+vM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwByC2vtZfd2INyAtL6bid1QFViUVR11CrzSElNhLrKaLfCm9iR
	/1rtFa8UF40d02TRz2hiiVfh7DApbbXJcn3Ft8BrBZp48fp6N/E7YGzawjjrGY1CUKQruMn+jfs
	/ceeXQjC32tzEqg4VpvZ2+3tMLx8FskdNXXwYAb3Nqz41XCRwpwvi44oaLA==
X-Gm-Gg: ASbGncvmYllNQ4IdVWXh1PXffg/pcSeMtZok3rmw7ft07AjAEasvidM+/Q0++cJg2Iv
	x5/qg30zXMXUZRYig1JyOaCU36SFF4dwZxhQzKR9e2+fErijsSH3baraJIbaWVVoc/m6g3bz3gK
	JGShXvIhZVGhedLRd3VuxrVTjqVdFMPnp4GFpk/W1Xu69RGDbFjh/4LRocCJPuunD2eQ0Mhp3W5
	fhsCDwiGQxccw397F7SBuPSP+qGiIRtdBWguhpGyyh5YFc3FNy2q9wov+lRJsL86ojhIFgbFzSG
	RMU8Fw==
X-Received: by 2002:a05:6000:248a:b0:3a4:dd16:a26d with SMTP id ffacd0b85a97d-3a4dd16a2e9mr12199951f8f.38.1748505836076;
        Thu, 29 May 2025 01:03:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGur16GF9vO5hI+T4bVnnBBYKGhZTcRLwWon1WeRZpP41jJWLYSKKmtOvCAP2xoidG+N+83g==
X-Received: by 2002:a05:6000:248a:b0:3a4:dd16:a26d with SMTP id ffacd0b85a97d-3a4dd16a2e9mr12199917f8f.38.1748505835566;
        Thu, 29 May 2025 01:03:55 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f00a00d4sm1207464f8f.92.2025.05.29.01.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 01:03:54 -0700 (PDT)
Date: Thu, 29 May 2025 04:03:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: stefanha@redhat.com, axboe@kernel.dk, virtualization@lists.linux.dev,
	linux-block@vger.kernel.org, stable@vger.kernel.org,
	lirongqing@baidu.com, kch@nvidia.com, xuanzhuo@linux.alibaba.com,
	pbonzini@redhat.com, jasowang@redhat.com,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Israel Rukshin <israelr@nvidia.com>
Subject: Re: [PATCH v3] virtio_blk: Fix disk deletion hang on device surprise
 removal
Message-ID: <20250529035007-mutt-send-email-mst@kernel.org>
References: <20250529061913.28868-1-parav@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529061913.28868-1-parav@nvidia.com>

On Thu, May 29, 2025 at 06:19:31AM +0000, Parav Pandit wrote:
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
> Reported-by: Li RongQing <lirongqing@baidu.com>
> Closes: https://lore.kernel.org/virtualization/c45dd68698cd47238c55fb73ca9b4741@baidu.com/
> Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> 
> ---
> v2->v3:
> - Addressed comments from Michael
> - updated comment for synchronizing with callbacks
> 
> v1->v2:
> - Addressed comments from Stephan
> - fixed spelling to 'waiting'
> - Addressed comments from Michael
> - Dropped checking broken vq from queue_rq() and queue_rqs()
>   because it is checked in lower layer routines in virtio core
> 
> v0->v1:
> - Fixed comments from Stefan to rename a cleanup function
> - Improved logic for handling any outstanding requests
>   in bio layer
> - improved cancel callback to sync with ongoing done()


Thanks!
Something else small to improve.

> ---
>  drivers/block/virtio_blk.c | 82 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 82 insertions(+)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 7cffea01d868..d37df878f4e9 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -1554,6 +1554,86 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	return err;
>  }
>  
> +static bool virtblk_request_cancel(struct request *rq, void *data)

it is more

virtblk_request_complete_broken_with_ioerr

and maybe a comment?
/*
 * If the vq is broken, device will not complete requests.
 * So we do it for the device.
 */

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

and one goes okay what does it do exactly? cleanup device in
a broken way? turns out no, it cleans up a broken device.
And an overview would be good. Maybe, a small comment will help:

/*
 * if the device is broken, it will not use any buffers and waiting
 * for that to happen is pointless. We'll do it in the driver,
 * completing all requests for the device.
 */


> +{
> +	struct request_queue *q = vblk->disk->queue;
> +
> +	if (!virtqueue_is_broken(vblk->vqs[0].vq))
> +		return;

so one has to read it, and understand that we did not need to call
it in the 1st place on a non broken device.
Moving it to the caller would be cleaner.


> +
> +	/* Start freezing the queue, so that new requests keeps waiting at the

wrong style of comment for blk.

/* this is
 * net style
 */

/*
 * this is
 * rest of the linux style
 */

> +	 * door of bio_queue_enter(). We cannot fully freeze the queue because
> +	 * freezed queue is an empty queue and there are pending requests, so

a frozen queue

> +	 * only start freezing it.
> +	 */
> +	blk_freeze_queue_start(q);
> +
> +	/* When quiescing completes, all ongoing dispatches have completed
> +	 * and no new dispatch will happen towards the driver.
> +	 * This ensures that later when cancel is attempted, then are not

they are not?

> +	 * getting processed by the queue_rq() or queue_rqs() handlers.
> +	 */
> +	blk_mq_quiesce_queue(q);
> +
> +	/*
> +	 * Synchronize with any ongoing VQ callbacks that may have started
> +	 * before the VQs were marked as broken. Any outstanding requests
> +	 * will be completed by virtblk_request_cancel().
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

... once we unfreeze the queue


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
> @@ -1561,6 +1641,8 @@ static void virtblk_remove(struct virtio_device *vdev)
>  	/* Make sure no work handler is accessing the device. */
>  	flush_work(&vblk->config_work);
>

I prefer simply moving the test here:
  
	if (virtqueue_is_broken(vblk->vqs[0].vq))
		virtblk_broken_device_cleanup(vblk);

makes it much clearer what is going on, imho.


>  	del_gendisk(vblk->disk);
>  	blk_mq_free_tag_set(&vblk->tag_set);
>  
> -- 
> 2.34.1


