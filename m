Return-Path: <stable+bounces-127517-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9190BA7A32F
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 14:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C6D917558D
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 12:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D959E24E01E;
	Thu,  3 Apr 2025 12:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ixRK5UJD"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375501A254E
	for <stable@vger.kernel.org>; Thu,  3 Apr 2025 12:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743685061; cv=none; b=rYfwRRh11YxuHRSS7SfbJptdnZDFGsuycaID9/v1a6iZ/O/uyXoEQeQ+YJonu9zGz5FY1kyRUXhXeLX40lMazPrxXPlXZHYRrPbImz9rqOIihefoPaaNTQT/a9oZyewrv+xwTSt8PZIngS0uroPig2QjrKqDKxy9h20Fo0lqEcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743685061; c=relaxed/simple;
	bh=h6upok2UNXu6a8hbwBmkOZ2QnnvGNGbvXHfvfrECD7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FkAdEHwTqltUnttbAjPhFuohh3nT3nhlnenh3+0It+Q+xRRA5g/Zvzl6n+rHYESrFl7vbRHOd5j48HbhnR2orLUdWCiu2PjVNRthdCNvOfVaVMnj8ube3fSp+xTlFY+vf9L2qlbTQs1gLc9jo56EntpNyExmAft5HbjV13Oss5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ixRK5UJD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743685056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=07cCSo2B9aIbwxRVd8sNELEM0nr6NT8ZeyBNS30RCy8=;
	b=ixRK5UJDxtngDfasRUo/HRtLyEu5fQ8CvlOdV8I6TMUW7gakpFgtWFEb1Fa9ZB/tllB6ad
	aEoryZzHhwSTpPX0Ls94MdnCcmizuCLIQVjqEOU7KohSfOGZ83n1EXxvU5QLxMsgcnztOd
	sHfb3PEpinVF82wzIx0JOfCrs5tCZAk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-bFyCzLU9OQKAzSzu2Ip1-w-1; Thu, 03 Apr 2025 08:57:34 -0400
X-MC-Unique: bFyCzLU9OQKAzSzu2Ip1-w-1
X-Mimecast-MFC-AGG-ID: bFyCzLU9OQKAzSzu2Ip1-w_1743685052
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4394c489babso4582445e9.1
        for <Stable@vger.kernel.org>; Thu, 03 Apr 2025 05:57:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743685052; x=1744289852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=07cCSo2B9aIbwxRVd8sNELEM0nr6NT8ZeyBNS30RCy8=;
        b=wZJ5V3dfUQ44K3OtAYBbyBSKHiilbM7/3rmxzbgvx/LlKjgEp5jEZXjt68kFPvFx4u
         oTgpbpBgD1quj93VPaMTlqMIGUbc7CU0sgAHHqivOfe9KCztwRV7xj63dJEkujywJhDw
         VoawNejkIiJ4jLfSHWFSVojL/6YzIW54ow6ZncP1gHe+tDJVDsFC5q3U5cJMvWb2Fflt
         mz8oKReJ7PsLkEt3oXLxUBp/4SmhRo2ACfl0V7f/uqHcB9QuGIftuXyWjEdFE3kdJd8p
         2L0CRIreIF/GgJ3ss+ze//ByBCeIOGXd+EV1qA4Z4lNT77oEhYOOz5eclJ07DtzILbQo
         EQDg==
X-Forwarded-Encrypted: i=1; AJvYcCV7rRZgIRqSsegKJvfVS3KqKoJFrVTMrEp8aUmYsqfz5m9uL9Ez6qgWa5M2x3eS/W7VL5hPYpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGAPDdmVRGF/lpbEN4OIgtm9Hg+STX3QANvdeWesvXT+HIMy2G
	ecsqyZseUsCz314FOxcZFJIbZWOMPE+SVb/rAKvTl4TNtAN3r+X3mjW+9qu+UPbueQGhAtvhts8
	Gh+AJ6GfcuZs2L6sG3FUyx17I7FVb6bQ1dcw/eo9cwwCc+Gh8UA3JEA==
X-Gm-Gg: ASbGnculmlrhHmzjnp8ohzWmahbB08E1O/Fdd6bMek8URMerPJRXEY33xfcZkr3TSdD
	WadS/cVPq7PIh4m46eSnnKUkKSwlcZlK9wkaLoL9+PjX5NsAOt/slsUbPUXJr921JYqQK5kT8OZ
	m3tRH/MIaw8HAk4gtJLg70m0YR+j4ReCqb29BaLuUIzQAHzp88K8c1S4hmmknZGe+N7GTZgvonF
	E4JdpHhMBtODVRk9usVCLRUFmqfawa9EyyKjEJAQruj7vo41ARAV/z6hRVzoZQAqL88Krog+Mxh
	Mlv87I9l1g==
X-Received: by 2002:a05:600c:4708:b0:43d:7588:667b with SMTP id 5b1f17b1804b1-43ec139b6admr28421815e9.10.1743685052182;
        Thu, 03 Apr 2025 05:57:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFj3KdFXqOkrApLxIkl3uzI14klWQC5RUU1qjAJxrr83aJQ/gFpzH2cPz5OLOhh6nW1riyB2Q==
X-Received: by 2002:a05:600c:4708:b0:43d:7588:667b with SMTP id 5b1f17b1804b1-43ec139b6admr28421515e9.10.1743685051709;
        Thu, 03 Apr 2025 05:57:31 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec34be2f4sm17636075e9.19.2025.04.03.05.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 05:57:31 -0700 (PDT)
Date: Thu, 3 Apr 2025 08:57:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	Chandra Merla <cmerla@redhat.com>, Stable@vger.kernel.org,
	Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v1] s390/virtio_ccw: don't allocate/assign airqs for
 non-existing queues
Message-ID: <20250403085637-mutt-send-email-mst@kernel.org>
References: <20250402203621.940090-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402203621.940090-1-david@redhat.com>

On Wed, Apr 02, 2025 at 10:36:21PM +0200, David Hildenbrand wrote:
> If we finds a vq without a name in our input array in
> virtio_ccw_find_vqs(), we treat it as "non-existing" and set the vq pointer
> to NULL; we will not call virtio_ccw_setup_vq() to allocate/setup a vq.
> 
> Consequently, we create only a queue if it actually exists (name != NULL)
> and assign an incremental queue index to each such existing queue.
> 
> However, in virtio_ccw_register_adapter_ind()->get_airq_indicator() we
> will not ignore these "non-existing queues", but instead assign an airq
> indicator to them.
> 
> Besides never releasing them in virtio_ccw_drop_indicators() (because
> there is no virtqueue), the bigger issue seems to be that there will be a
> disagreement between the device and the Linux guest about the airq
> indicator to be used for notifying a queue, because the indicator bit
> for adapter I/O interrupt is derived from the queue index.
> 
> The virtio spec states under "Setting Up Two-Stage Queue Indicators":
> 
> 	... indicator contains the guest address of an area wherein the
> 	indicators for the devices are contained, starting at bit_nr, one
> 	bit per virtqueue of the device.
> 
> And further in "Notification via Adapter I/O Interrupts":
> 
> 	For notifying the driver of virtqueue buffers, the device sets the
> 	bit in the guest-provided indicator area at the corresponding
> 	offset.
> 
> For example, QEMU uses in virtio_ccw_notify() the queue index (passed as
> "vector") to select the relevant indicator bit. If a queue does not exist,
> it does not have a corresponding indicator bit assigned, because it
> effectively doesn't have a queue index.
> 
> Using a virtio-balloon-ccw device under QEMU with free-page-hinting
> disabled ("free-page-hint=off") but free-page-reporting enabled
> ("free-page-reporting=on") will result in free page reporting
> not working as expected: in the virtio_balloon driver, we'll be stuck
> forever in virtballoon_free_page_report()->wait_event(), because the
> waitqueue will not be woken up as the notification from the device is
> lost: it would use the wrong indicator bit.
> 
> Free page reporting stops working and we get splats (when configured to
> detect hung wqs) like:
> 
>  INFO: task kworker/1:3:463 blocked for more than 61 seconds.
>        Not tainted 6.14.0 #4
>  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>  task:kworker/1:3 [...]
>  Workqueue: events page_reporting_process
>  Call Trace:
>   [<000002f404e6dfb2>] __schedule+0x402/0x1640
>   [<000002f404e6f22e>] schedule+0x3e/0xe0
>   [<000002f3846a88fa>] virtballoon_free_page_report+0xaa/0x110 [virtio_balloon]
>   [<000002f40435c8a4>] page_reporting_process+0x2e4/0x740
>   [<000002f403fd3ee2>] process_one_work+0x1c2/0x400
>   [<000002f403fd4b96>] worker_thread+0x296/0x420
>   [<000002f403fe10b4>] kthread+0x124/0x290
>   [<000002f403f4e0dc>] __ret_from_fork+0x3c/0x60
>   [<000002f404e77272>] ret_from_fork+0xa/0x38
> 
> There was recently a discussion [1] whether the "holes" should be
> treated differently again, effectively assigning also non-existing
> queues a queue index: that should also fix the issue, but requires other
> workarounds to not break existing setups.
> 
> Let's fix it without affecting existing setups for now by properly ignoring
> the non-existing queues, so the indicator bits will match the queue
> indexes.
> 
> [1] https://lore.kernel.org/all/cover.1720611677.git.mst@redhat.com/
> 
> Fixes: a229989d975e ("virtio: don't allocate vqs when names[i] = NULL")
> Reported-by: Chandra Merla <cmerla@redhat.com>
> Cc: <Stable@vger.kernel.org>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Eric Farman <farman@linux.ibm.com>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Wei Wang <wei.w.wang@intel.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>


feel free to merge.

> ---
>  drivers/s390/virtio/virtio_ccw.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> index 21fa7ac849e5c..4904b831c0a75 100644
> --- a/drivers/s390/virtio/virtio_ccw.c
> +++ b/drivers/s390/virtio/virtio_ccw.c
> @@ -302,11 +302,17 @@ static struct airq_info *new_airq_info(int index)
>  static unsigned long *get_airq_indicator(struct virtqueue *vqs[], int nvqs,
>  					 u64 *first, void **airq_info)
>  {
> -	int i, j;
> +	int i, j, queue_idx, highest_queue_idx = -1;
>  	struct airq_info *info;
>  	unsigned long *indicator_addr = NULL;
>  	unsigned long bit, flags;
>  
> +	/* Array entries without an actual queue pointer must be ignored. */
> +	for (i = 0; i < nvqs; i++) {
> +		if (vqs[i])
> +			highest_queue_idx++;
> +	}
> +
>  	for (i = 0; i < MAX_AIRQ_AREAS && !indicator_addr; i++) {
>  		mutex_lock(&airq_areas_lock);
>  		if (!airq_areas[i])
> @@ -316,7 +322,7 @@ static unsigned long *get_airq_indicator(struct virtqueue *vqs[], int nvqs,
>  		if (!info)
>  			return NULL;
>  		write_lock_irqsave(&info->lock, flags);
> -		bit = airq_iv_alloc(info->aiv, nvqs);
> +		bit = airq_iv_alloc(info->aiv, highest_queue_idx + 1);
>  		if (bit == -1UL) {
>  			/* Not enough vacancies. */
>  			write_unlock_irqrestore(&info->lock, flags);
> @@ -325,8 +331,10 @@ static unsigned long *get_airq_indicator(struct virtqueue *vqs[], int nvqs,
>  		*first = bit;
>  		*airq_info = info;
>  		indicator_addr = info->aiv->vector;
> -		for (j = 0; j < nvqs; j++) {
> -			airq_iv_set_ptr(info->aiv, bit + j,
> +		for (j = 0, queue_idx = 0; j < nvqs; j++) {
> +			if (!vqs[j])
> +				continue;
> +			airq_iv_set_ptr(info->aiv, bit + queue_idx++,
>  					(unsigned long)vqs[j]);
>  		}
>  		write_unlock_irqrestore(&info->lock, flags);
> -- 
> 2.48.1


