Return-Path: <stable+bounces-227140-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAg+Gmj7umlwdwIAu9opvQ
	(envelope-from <stable+bounces-227140-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 20:22:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3612C1F6A
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 20:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFDC13082A78
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 19:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AF13EE1C8;
	Wed, 18 Mar 2026 19:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="hRh0SdJi"
X-Original-To: stable@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39853F211B;
	Wed, 18 Mar 2026 19:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773861316; cv=none; b=b9tyIdWAQG0ajw/02T5k+xVvcm5hIRZZbUTXv9XUzgoWgt3jabIifyUwgOOZGwdLS5OkBsjR8chJ+N7QbQWKMlvs6zeOx7s/WReCp2nsCHNqmZtmz4PlyI1DSzL89VY611LC2QhxXpNTgArv9KM/FVaq3xv0p8k6I/Odc4MriVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773861316; c=relaxed/simple;
	bh=yzyAUPXuBDJQBn5ODIDE875rFjEIb6AQupobEv9sfw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g6r0PXG8Mo6RMZXrp2xr2wtrnLhOR/05YhUAK+KrOlDUJ/cYOMmz1MFp9I8oZRzeU6Fy/RnunroD/kfilI35/ymobRTPisOfvLk5zMBojg1ouG1v1a0nITVhcsyO+zdUkgxtPuiCAqf6ICVu3M9SVbbHgittalxNHvmqvLiPyFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=hRh0SdJi; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from killaraus.ideasonboard.com (2001-14ba-703d-e500--2a1.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::2a1])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id A4478308;
	Wed, 18 Mar 2026 20:13:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1773861239;
	bh=yzyAUPXuBDJQBn5ODIDE875rFjEIb6AQupobEv9sfw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hRh0SdJiL8FMNObexdQcy7lhrsJ3vc4Xqglv6epdGiUdd2v2Fj9tMw4rPP8QcV4Hm
	 Q0RgAtibYZ1W7P9+N7kS1DmTeunefx+x9ZkawXr/UgS74L34KdAc3zXiNIRmKUDRg9
	 ZaD5vlBB5YFdaQn2mohMOA39Rt9Qn8nc8SxpwVt0=
Date: Wed, 18 Mar 2026 21:15:11 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yunke Cao <yunkec@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] media: uvcvideo: Enable VB2_DMABUF for metadata
 stream
Message-ID: <20260318191511.GA718539@killaraus.ideasonboard.com>
References: <20260309-uvc-metadata-dmabuf-v1-0-fc8b87bd29c5@chromium.org>
 <20260309-uvc-metadata-dmabuf-v1-1-fc8b87bd29c5@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260309-uvc-metadata-dmabuf-v1-1-fc8b87bd29c5@chromium.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ideasonboard.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ideasonboard.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227140-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[ideasonboard.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[laurent.pinchart@ideasonboard.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,chromium.org:email,ideasonboard.com:dkim,ideasonboard.com:email]
X-Rspamd-Queue-Id: CB3612C1F6A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 09, 2026 at 03:01:54PM +0000, Ricardo Ribalda wrote:
> The UVC driver has two video streams, one for the frames and another one
> for the metadata. Both streams share most of the codebase, but only the
> data stream declares support for DMABUF transfer mode.
> 
> I have tried the DMABUF transfer mode with CONFIG_DMABUF_HEAPS_SYSTEM
> and the frames looked correct.
> 
> This patch announces the support for DMABUF for the metadata stream.
> This is useful for apps/HALs that only want to support DMABUF.

Is that something you plan to use in Android ?

> Cc: stable@vger.kernel.org
> Fixes: 088ead2552458 ("media: uvcvideo: Add a metadata device node")
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_queue.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_queue.c b/drivers/media/usb/uvc/uvc_queue.c
> index 8b8f44b4a045..0eddd4f872ca 100644
> --- a/drivers/media/usb/uvc/uvc_queue.c
> +++ b/drivers/media/usb/uvc/uvc_queue.c
> @@ -243,7 +243,7 @@ int uvc_queue_init(struct uvc_video_queue *queue, enum v4l2_buf_type type)
>  	int ret;
>  
>  	queue->queue.type = type;
> -	queue->queue.io_modes = VB2_MMAP | VB2_USERPTR;
> +	queue->queue.io_modes = VB2_MMAP | VB2_USERPTR | VB2_DMABUF;

One day we should start warning about USERPTR being deprecated.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  	queue->queue.drv_priv = queue;
>  	queue->queue.buf_struct_size = sizeof(struct uvc_buffer);
>  	queue->queue.mem_ops = &vb2_vmalloc_memops;
> @@ -256,7 +256,6 @@ int uvc_queue_init(struct uvc_video_queue *queue, enum v4l2_buf_type type)
>  		queue->queue.ops = &uvc_meta_queue_qops;
>  		break;
>  	default:
> -		queue->queue.io_modes |= VB2_DMABUF;
>  		queue->queue.ops = &uvc_queue_qops;
>  		break;
>  	}
> 

-- 
Regards,

Laurent Pinchart

