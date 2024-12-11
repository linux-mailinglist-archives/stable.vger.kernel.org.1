Return-Path: <stable+bounces-100620-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CF39ECDDF
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 15:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D07B188C9EB
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 14:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11160232379;
	Wed, 11 Dec 2024 14:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PaguQmRM"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8148225A56
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 14:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733925680; cv=none; b=RpaLaySgzHl5kZt6Lqp4ghBaZpxx1RZop1KSokbQierlladpiPEXXQi2Ilyd9f5rGJ1QWqfYgMtNOnuq0Luti5/JWZP9wuTuA2js6z+s6iKyklT+P6STrd78Xftz99EUBUuaL5fG3vNGp9s2YHjPauV4KNMWGewB0Mvgb+oehno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733925680; c=relaxed/simple;
	bh=5IFeaz2YHkUwph6UDtgpTT6eZgX98wuNPz5AJrxjZQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cJ07gMFGC0JT1Aek/9VMyeELIvTT0zkPvLA4q5XqwEyWnap8BSr+HrYm5/V0UMr3SO/G/ovrk9OKEX4X6glErJUGdxmMWtubE0kb9qQitau90JTl5wyAoePNwPtUFTnp3HivKL50Hk0qapmYx//W+lXRupWj4ptP3i4Qk4t1Wc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PaguQmRM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733925677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gwfz6/OfdN4Q2D935AIoJNb36wsbwbsmuPglWOQvFko=;
	b=PaguQmRM1m+eq1LB2Mi8J8i1bQn38fROA8Z/ZbQ/Fe15Xp0W6HBTSc9cdrFiIHXVSc607H
	9ffkSVfBFkKVWjkvheJVMCxrIRplf4pjNSHwv3JRHhOVX7EpRrtHVHZ40VKkKFcoYXpl6+
	JqwIHnGU2M7seksuyxMScPiaWdqJF2k=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-hOPYG7lOMPaZp_8JjVk5lw-1; Wed, 11 Dec 2024 09:01:16 -0500
X-MC-Unique: hOPYG7lOMPaZp_8JjVk5lw-1
X-Mimecast-MFC-AGG-ID: hOPYG7lOMPaZp_8JjVk5lw
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-aa6732a1af5so59425966b.3
        for <stable@vger.kernel.org>; Wed, 11 Dec 2024 06:01:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733925675; x=1734530475;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gwfz6/OfdN4Q2D935AIoJNb36wsbwbsmuPglWOQvFko=;
        b=LqmiCmNWps3HnTbrPwRd+7GTZdL47Y5TVfoT8qHIVCnZhguGEnf/v06sFTFik49YeN
         0cksHZ9o75UVNzc4oR+nUi3sTwWjHwMY4yMgIsnTc7f90kL95od8ZeG9LCAMPnIRd9d4
         uIaAKkDzSjPkBd4QLxslQT6C+Burcltp1gXHb8IVWCEp5FDjprhS07ga2cBD+pblYzVz
         fTQW1NraNH3PJDdoHNqjyl0HZ62Hgk3UkpIHvtDZiw4VspA5q6B4UJ6aqN/bhcaqaAPK
         GMJkCjP/LFTkl/dszlU0KExq5/Tvvpcz0Bo1i5mlUXK/HvxOg0eGJGEnCVjnFa7dyz/K
         kHxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsgl6ssajFeHAb7pyC6B1/HvTrMv3LJLeO6O3Eyun0H81P08vDfFyjPTUybGNioEq2PkZcG1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh1OoF1WCJ3pH2Pp9WH0szWSAWrIVLz1nWsAcgR8UmcwgAGEY0
	5sxxUjG8quZimJ7lecOWo49hmPTwj7cXm4yNpZHWjmB27Y6qeRHKUB/oLCNqse5TnBDOIwhJdXJ
	ZiUb7QyxiA3EK8tDlLz2FnV/qSPryboV2ixebSnBKIQCSskym2F3lWA==
X-Gm-Gg: ASbGncsIeTVI/Bd936HGs7ztBtbEtq+p21FQfxl2dvOGUfTYrmZWWYrubkQghk/QLlV
	TBwxjgEeOQST5jM0i0lKaxqry0E+zhwmZ/u1fNFrF9s4cLufQEe231sZx8Y8ioHiGtAe/PNQOzk
	drVrANMI/Fxhlv9RmjSKSF/ad3Itd+7NuQqtquunwVtfy1T2Zzn39j2A6sLQ9slIYbZm3B91OBZ
	fh3zt/2a8jt2WqApNhUGz6+JeY2HpKOPd/lwSvDKbWQiwhIfOZJuN4vVUad1LQQk0Y48LKkUMCk
	PV+CVmmaj3KsDw3dHDqtLM0S3E66lo6N7Rqu8FMdL70pGD1Za6zGuBUdm4+DqkHEijmH6yazTSY
	SfXv//kPOoAMKB/+WplnQRu7fwPHP
X-Received: by 2002:a17:907:7710:b0:aa6:7cae:dba7 with SMTP id a640c23a62f3a-aa6b1141793mr253754166b.4.1733925673189;
        Wed, 11 Dec 2024 06:01:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHShBsvPaHWhI/8fmw0L3o8/xwvo4/lcquvnrYBPjp46anUggm78B+DFRGSKiA7cO1jdhceCA==
X-Received: by 2002:a17:907:7710:b0:aa6:7cae:dba7 with SMTP id a640c23a62f3a-aa6b1141793mr253736066b.4.1733925671522;
        Wed, 11 Dec 2024 06:01:11 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa69afa395csm343450766b.71.2024.12.11.06.01.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 06:01:10 -0800 (PST)
Message-ID: <17c332ad-a714-4b42-8522-3cd085fb9aca@redhat.com>
Date: Wed, 11 Dec 2024 15:01:09 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12.y] media: ipu6: use the IPU6 DMA mapping APIs to do
 mapping
To: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Genes Lists <lists@sapience.com>, linux-media@vger.kernel.org,
 sakari.ailus@linux.intel.com, bingbu.cao@intel.com,
 Hans Verkuil <hverkuil@xs4all.nl>
References: <20241209175416.59433-1-stanislaw.gruszka@linux.intel.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241209175416.59433-1-stanislaw.gruszka@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9-Dec-24 6:54 PM, Stanislaw Gruszka wrote:
> From: Bingbu Cao <bingbu.cao@intel.com>
> 
> commit 1d4a000289979cc7f2887c8407b1bfe2a0918354 upstream.
> 
> dma_ops is removed from the IPU6 auxiliary device, ISYS driver
> should use the IPU6 DMA mapping APIs directly instead of depending
> on the device callbacks.
> 
> ISYS driver switch from the videobuf2 DMA contig memory allocator to
> scatter/gather memory allocator.
> 
> Signed-off-by: Bingbu Cao <bingbu.cao@intel.com>
> [Sakari Ailus: Rebased on recent videobuf2 wait changes.]
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
> Signed-off-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> ---
>  drivers/media/pci/intel/ipu6/Kconfig          |  2 +-
>  .../media/pci/intel/ipu6/ipu6-isys-queue.c    | 66 +++++++++++++++----
>  .../media/pci/intel/ipu6/ipu6-isys-queue.h    |  1 +
>  drivers/media/pci/intel/ipu6/ipu6-isys.c      | 19 +++---
>  4 files changed, 64 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/media/pci/intel/ipu6/Kconfig b/drivers/media/pci/intel/ipu6/Kconfig
> index a4537818a58c..cd1c54529357 100644
> --- a/drivers/media/pci/intel/ipu6/Kconfig
> +++ b/drivers/media/pci/intel/ipu6/Kconfig
> @@ -8,7 +8,7 @@ config VIDEO_INTEL_IPU6
>  	select IOMMU_IOVA
>  	select VIDEO_V4L2_SUBDEV_API
>  	select MEDIA_CONTROLLER
> -	select VIDEOBUF2_DMA_CONTIG
> +	select VIDEOBUF2_DMA_SG
>  	select V4L2_FWNODE
>  	help
>  	  This is the 6th Gen Intel Image Processing Unit, found in Intel SoCs
> diff --git a/drivers/media/pci/intel/ipu6/ipu6-isys-queue.c b/drivers/media/pci/intel/ipu6/ipu6-isys-queue.c
> index 03dbb0e0ea79..bbb66b56ee88 100644
> --- a/drivers/media/pci/intel/ipu6/ipu6-isys-queue.c
> +++ b/drivers/media/pci/intel/ipu6/ipu6-isys-queue.c
> @@ -13,17 +13,48 @@
>  
>  #include <media/media-entity.h>
>  #include <media/v4l2-subdev.h>
> -#include <media/videobuf2-dma-contig.h>
> +#include <media/videobuf2-dma-sg.h>
>  #include <media/videobuf2-v4l2.h>
>  
>  #include "ipu6-bus.h"
> +#include "ipu6-dma.h"
>  #include "ipu6-fw-isys.h"
>  #include "ipu6-isys.h"
>  #include "ipu6-isys-video.h"
>  
> -static int queue_setup(struct vb2_queue *q, unsigned int *num_buffers,
> -		       unsigned int *num_planes, unsigned int sizes[],
> -		       struct device *alloc_devs[])
> +static int ipu6_isys_buf_init(struct vb2_buffer *vb)
> +{
> +	struct ipu6_isys *isys = vb2_get_drv_priv(vb->vb2_queue);
> +	struct sg_table *sg = vb2_dma_sg_plane_desc(vb, 0);
> +	struct vb2_v4l2_buffer *vvb = to_vb2_v4l2_buffer(vb);
> +	struct ipu6_isys_video_buffer *ivb =
> +		vb2_buffer_to_ipu6_isys_video_buffer(vvb);
> +	int ret;
> +
> +	ret = ipu6_dma_map_sgtable(isys->adev, sg, DMA_TO_DEVICE, 0);
> +	if (ret)
> +		return ret;
> +
> +	ivb->dma_addr = sg_dma_address(sg->sgl);
> +
> +	return 0;
> +}
> +
> +static void ipu6_isys_buf_cleanup(struct vb2_buffer *vb)
> +{
> +	struct ipu6_isys *isys = vb2_get_drv_priv(vb->vb2_queue);
> +	struct sg_table *sg = vb2_dma_sg_plane_desc(vb, 0);
> +	struct vb2_v4l2_buffer *vvb = to_vb2_v4l2_buffer(vb);
> +	struct ipu6_isys_video_buffer *ivb =
> +		vb2_buffer_to_ipu6_isys_video_buffer(vvb);
> +
> +	ivb->dma_addr = 0;
> +	ipu6_dma_unmap_sgtable(isys->adev, sg, DMA_TO_DEVICE, 0);
> +}
> +
> +static int ipu6_isys_queue_setup(struct vb2_queue *q, unsigned int *num_buffers,
> +				 unsigned int *num_planes, unsigned int sizes[],
> +				 struct device *alloc_devs[])
>  {
>  	struct ipu6_isys_queue *aq = vb2_queue_to_isys_queue(q);
>  	struct ipu6_isys_video *av = ipu6_isys_queue_to_video(aq);
> @@ -207,9 +238,11 @@ ipu6_isys_buf_to_fw_frame_buf_pin(struct vb2_buffer *vb,
>  				  struct ipu6_fw_isys_frame_buff_set_abi *set)
>  {
>  	struct ipu6_isys_queue *aq = vb2_queue_to_isys_queue(vb->vb2_queue);
> +	struct vb2_v4l2_buffer *vvb = to_vb2_v4l2_buffer(vb);
> +	struct ipu6_isys_video_buffer *ivb =
> +		vb2_buffer_to_ipu6_isys_video_buffer(vvb);
>  
> -	set->output_pins[aq->fw_output].addr =
> -		vb2_dma_contig_plane_dma_addr(vb, 0);
> +	set->output_pins[aq->fw_output].addr = ivb->dma_addr;
>  	set->output_pins[aq->fw_output].out_buf_id = vb->index + 1;
>  }
>  
> @@ -332,7 +365,7 @@ static void buf_queue(struct vb2_buffer *vb)
>  
>  	dev_dbg(dev, "queue buffer %u for %s\n", vb->index, av->vdev.name);
>  
> -	dma = vb2_dma_contig_plane_dma_addr(vb, 0);
> +	dma = ivb->dma_addr;
>  	dev_dbg(dev, "iova: iova %pad\n", &dma);
>  
>  	spin_lock_irqsave(&aq->lock, flags);
> @@ -724,10 +757,14 @@ void ipu6_isys_queue_buf_ready(struct ipu6_isys_stream *stream,
>  	}
>  
>  	list_for_each_entry_reverse(ib, &aq->active, head) {
> +		struct ipu6_isys_video_buffer *ivb;
> +		struct vb2_v4l2_buffer *vvb;
>  		dma_addr_t addr;
>  
>  		vb = ipu6_isys_buffer_to_vb2_buffer(ib);
> -		addr = vb2_dma_contig_plane_dma_addr(vb, 0);
> +		vvb = to_vb2_v4l2_buffer(vb);
> +		ivb = vb2_buffer_to_ipu6_isys_video_buffer(vvb);
> +		addr = ivb->dma_addr;
>  
>  		if (info->pin.addr != addr) {
>  			if (first)
> @@ -766,10 +803,12 @@ void ipu6_isys_queue_buf_ready(struct ipu6_isys_stream *stream,
>  }
>  
>  static const struct vb2_ops ipu6_isys_queue_ops = {
> -	.queue_setup = queue_setup,
> +	.queue_setup = ipu6_isys_queue_setup,
>  	.wait_prepare = vb2_ops_wait_prepare,
>  	.wait_finish = vb2_ops_wait_finish,
> +	.buf_init = ipu6_isys_buf_init,
>  	.buf_prepare = ipu6_isys_buf_prepare,
> +	.buf_cleanup = ipu6_isys_buf_cleanup,
>  	.start_streaming = start_streaming,
>  	.stop_streaming = stop_streaming,
>  	.buf_queue = buf_queue,
> @@ -779,16 +818,17 @@ int ipu6_isys_queue_init(struct ipu6_isys_queue *aq)
>  {
>  	struct ipu6_isys *isys = ipu6_isys_queue_to_video(aq)->isys;
>  	struct ipu6_isys_video *av = ipu6_isys_queue_to_video(aq);
> +	struct ipu6_bus_device *adev = isys->adev;
>  	int ret;
>  
>  	/* no support for userptr */
>  	if (!aq->vbq.io_modes)
>  		aq->vbq.io_modes = VB2_MMAP | VB2_DMABUF;
>  
> -	aq->vbq.drv_priv = aq;
> +	aq->vbq.drv_priv = isys;
>  	aq->vbq.ops = &ipu6_isys_queue_ops;
>  	aq->vbq.lock = &av->mutex;
> -	aq->vbq.mem_ops = &vb2_dma_contig_memops;
> +	aq->vbq.mem_ops = &vb2_dma_sg_memops;
>  	aq->vbq.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
>  	aq->vbq.min_queued_buffers = 1;
>  	aq->vbq.timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
> @@ -797,8 +837,8 @@ int ipu6_isys_queue_init(struct ipu6_isys_queue *aq)
>  	if (ret)
>  		return ret;
>  
> -	aq->dev = &isys->adev->auxdev.dev;
> -	aq->vbq.dev = &isys->adev->auxdev.dev;
> +	aq->dev = &adev->auxdev.dev;
> +	aq->vbq.dev = &adev->isp->pdev->dev;
>  	spin_lock_init(&aq->lock);
>  	INIT_LIST_HEAD(&aq->active);
>  	INIT_LIST_HEAD(&aq->incoming);
> diff --git a/drivers/media/pci/intel/ipu6/ipu6-isys-queue.h b/drivers/media/pci/intel/ipu6/ipu6-isys-queue.h
> index 95cfd4869d93..fe8fc796a58f 100644
> --- a/drivers/media/pci/intel/ipu6/ipu6-isys-queue.h
> +++ b/drivers/media/pci/intel/ipu6/ipu6-isys-queue.h
> @@ -38,6 +38,7 @@ struct ipu6_isys_buffer {
>  struct ipu6_isys_video_buffer {
>  	struct vb2_v4l2_buffer vb_v4l2;
>  	struct ipu6_isys_buffer ib;
> +	dma_addr_t dma_addr;
>  };
>  
>  #define IPU6_ISYS_BUFFER_LIST_FL_INCOMING	BIT(0)
> diff --git a/drivers/media/pci/intel/ipu6/ipu6-isys.c b/drivers/media/pci/intel/ipu6/ipu6-isys.c
> index c4aff2e2009b..c85e056cb904 100644
> --- a/drivers/media/pci/intel/ipu6/ipu6-isys.c
> +++ b/drivers/media/pci/intel/ipu6/ipu6-isys.c
> @@ -34,6 +34,7 @@
>  
>  #include "ipu6-bus.h"
>  #include "ipu6-cpd.h"
> +#include "ipu6-dma.h"
>  #include "ipu6-isys.h"
>  #include "ipu6-isys-csi2.h"
>  #include "ipu6-mmu.h"
> @@ -933,29 +934,27 @@ static const struct dev_pm_ops isys_pm_ops = {
>  
>  static void free_fw_msg_bufs(struct ipu6_isys *isys)
>  {
> -	struct device *dev = &isys->adev->auxdev.dev;
>  	struct isys_fw_msgs *fwmsg, *safe;
>  
>  	list_for_each_entry_safe(fwmsg, safe, &isys->framebuflist, head)
> -		dma_free_attrs(dev, sizeof(struct isys_fw_msgs), fwmsg,
> -			       fwmsg->dma_addr, 0);
> +		ipu6_dma_free(isys->adev, sizeof(struct isys_fw_msgs), fwmsg,
> +			      fwmsg->dma_addr, 0);
>  
>  	list_for_each_entry_safe(fwmsg, safe, &isys->framebuflist_fw, head)
> -		dma_free_attrs(dev, sizeof(struct isys_fw_msgs), fwmsg,
> -			       fwmsg->dma_addr, 0);
> +		ipu6_dma_free(isys->adev, sizeof(struct isys_fw_msgs), fwmsg,
> +			      fwmsg->dma_addr, 0);
>  }
>  
>  static int alloc_fw_msg_bufs(struct ipu6_isys *isys, int amount)
>  {
> -	struct device *dev = &isys->adev->auxdev.dev;
>  	struct isys_fw_msgs *addr;
>  	dma_addr_t dma_addr;
>  	unsigned long flags;
>  	unsigned int i;
>  
>  	for (i = 0; i < amount; i++) {
> -		addr = dma_alloc_attrs(dev, sizeof(struct isys_fw_msgs),
> -				       &dma_addr, GFP_KERNEL, 0);
> +		addr = ipu6_dma_alloc(isys->adev, sizeof(*addr),
> +				      &dma_addr, GFP_KERNEL, 0);
>  		if (!addr)
>  			break;
>  		addr->dma_addr = dma_addr;
> @@ -974,8 +973,8 @@ static int alloc_fw_msg_bufs(struct ipu6_isys *isys, int amount)
>  					struct isys_fw_msgs, head);
>  		list_del(&addr->head);
>  		spin_unlock_irqrestore(&isys->listlock, flags);
> -		dma_free_attrs(dev, sizeof(struct isys_fw_msgs), addr,
> -			       addr->dma_addr, 0);
> +		ipu6_dma_free(isys->adev, sizeof(struct isys_fw_msgs), addr,
> +			      addr->dma_addr, 0);
>  		spin_lock_irqsave(&isys->listlock, flags);
>  	}
>  	spin_unlock_irqrestore(&isys->listlock, flags);


