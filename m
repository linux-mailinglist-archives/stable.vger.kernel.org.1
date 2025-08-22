Return-Path: <stable+bounces-172357-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F5BB31541
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 12:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B596C1CE83A0
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 10:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BAA2D7814;
	Fri, 22 Aug 2025 10:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e6tOU/MB"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C998129BDA0
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 10:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755858123; cv=none; b=jLhyDj3tMVRRsKsHNI0zArGrVveYXFoVPgY8P+BrcNmCTgvtepPYFtAnEB5EIbGvjWGjDKMazvXqaJRDWJ4lVzKstEaJaXIb6QBLM4CcL7r1bmreR/aakLTqFouGPPnG9CG76jFNdBu7WewxMepX5PAABc+1TIrWHdKQZazgN6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755858123; c=relaxed/simple;
	bh=QDSdtnZUnX3xJMyqT3lvdDtJgiNwcC+bStOaJK2QDQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QL5fNk0s5QLzlzWwA9/TkaSj3eA7nPodtaWcgIFkUw3kVxSB1ktqzSWdqoxZZS9yqsCnrw03s15j1/bUMhSfskHHNLrFqVFEBH4ZLlFDueyLHQWO1WWkarYTTcmr0bCKVorT+bjNETBGR50ZmgOezw2ypkWlhYg4DF/XE4HCm7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e6tOU/MB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755858118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BsR7WvFetJQPDV9UadbGaGgLU3t3WtTZVmLYnKWZWUw=;
	b=e6tOU/MBWwvxRPh3fvQpLAcT/ypnsoTZa9zTunf0Ax+oDCbt45VXSDhlTppm7TbDsEydLp
	f/xGgvB8rkZtMg72ozvG5Kjz8mKojjoSwgqwOk0qhNl3Lf0+8nkGGhIyV8+UWr6fzCee9k
	8booVe/cFEZiqT8R8sayLUmHsG/O0Uo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-NEgaiE0iMmGdXkgsUoqyxw-1; Fri, 22 Aug 2025 06:21:57 -0400
X-MC-Unique: NEgaiE0iMmGdXkgsUoqyxw-1
X-Mimecast-MFC-AGG-ID: NEgaiE0iMmGdXkgsUoqyxw_1755858116
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3b9d41b88ffso1146069f8f.0
        for <stable@vger.kernel.org>; Fri, 22 Aug 2025 03:21:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755858116; x=1756462916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BsR7WvFetJQPDV9UadbGaGgLU3t3WtTZVmLYnKWZWUw=;
        b=BDNIK2FhoBJ4Bpqcm1PgQCTYvDTb59GKdVFRKfmIicvXgkhk5KZSnZ2mgH9RD3f7sv
         Kw5b/xLjXkwIDJ5151BomznkDcC58cCEIHJli7hHZ2zvtJSeRmEHTEYGpfzu9aOe6qc9
         4N9iX3cl4yq01miSumuO7eWExYAUm7+DgnnOO/4PtMc0Cm6wzAzoEc1SiERxbSMY3krE
         1e9YCgGuygy58sLiK2g9dOi49KIeOGmy03+Id1S+jYR+E4G6Zyx8aA95Y5hzHoHsv2ZY
         ld9oiy09HiDG2jjjpbuEdSbiU8Zy8CtTV2n+cexKNTUBA6suydh5pmc8h8ptbZYgHclu
         dE5w==
X-Forwarded-Encrypted: i=1; AJvYcCU98AgbtAw0XXmXbw37YiyHr09STMRDrGHFQ4xm9PhQ7XNn5cK6Ne0WA0TAZK0M1Cl+QAH7z/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUUPgRHV4PmFPvbAnD0kBzek/zgJJ2SUvvEBGb6D1SgBcAj9Av
	5mh9sjSP63oDc4MiwEHSmXqy1+NfDfgr24ZRGZdW8SuAAPpfomoB0c0Pr5/lpXz4XcsIwGeTcUG
	6vPPhiJE2E0YX1HzLa2m3yzq6z+tlWZkxt6vzQbsX7bA3BHvVAAw0quRxrg==
X-Gm-Gg: ASbGncsn8rJqQf+06EA+UZ0w51Crs8Fq7KMgJ9U0QdZbzO684tZrC7jFR3N47IVm1qB
	m+ruWV/FrSE3mgMEVDEboQhyKL+WkhJ9GQsFLJ83m11xGsUFq7mtOIBGLjaYKh0o9V2k4nmVxmU
	BEJbR588wDgcpoz0Aekt7u3F/gKZpIcPXLXQ9PtwJQ5fdZlwC9UNxv79Xu7t/AahC+8jnvloD7o
	ezaUW3IBAkdAWsSIQ4qYP5WW2gaCWx9NcY2NNaSItTb8N61H7FYPlsN7HBDPR3m6kaOnyCYcWNl
	YKhjmKBWW9fWvWJBVkW1UGp7kkTyCPva
X-Received: by 2002:a05:6000:4383:b0:3c5:9e0f:7607 with SMTP id ffacd0b85a97d-3c5dc734286mr1744623f8f.33.1755858116063;
        Fri, 22 Aug 2025 03:21:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUO6AnrO7QzlxlMIJWKsxbYeqV/MnPslbbUlNJDbzbnkOgi3Hgch3hfndltvEmRoBM6OkOwA==
X-Received: by 2002:a05:6000:4383:b0:3c5:9e0f:7607 with SMTP id ffacd0b85a97d-3c5dc734286mr1744598f8f.33.1755858115600;
        Fri, 22 Aug 2025 03:21:55 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c66f532bbbsm1005865f8f.44.2025.08.22.03.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 03:21:55 -0700 (PDT)
Date: Fri, 22 Aug 2025 06:21:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtualization@lists.linux.dev, jasowang@redhat.com,
	stefanha@redhat.com, pbonzini@redhat.com,
	xuanzhuo@linux.alibaba.com, stable@vger.kernel.org,
	mgurtovoy@nvidia.com, lirongqing@baidu.com
Subject: Re: [PATCH] Revert "virtio_pci: Support surprise removal of virtio
 pci device"
Message-ID: <20250822060839-mutt-send-email-mst@kernel.org>
References: <20250822091706.21170-1-parav@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822091706.21170-1-parav@nvidia.com>

On Fri, Aug 22, 2025 at 12:17:06PM +0300, Parav Pandit wrote:
> This reverts commit 43bb40c5b926 ("virtio_pci: Support surprise removal of virtio pci device").
> 
> Virtio drivers and PCI devices have never fully supported true
> surprise (aka hot unplug) removal. Drivers historically continued
> processing and waiting for pending I/O and even continued synchronous
> device reset during surprise removal. Devices have also continued
> completing I/Os, doing DMA and allowing device reset after surprise
> removal to support such drivers.
> 
> Supporting it correctly would require a new device capability

If a device is removed, it is removed. Windows drivers supported
this since forever and it's just a Linux bug that it does not
handle all the cases. This is not something you can handle
with a capability.





> and
> driver negotiation in the virtio specification to safely stop
> I/O and free queue memory. Failure to do so either breaks all the
> existing drivers with call trace listed in the commit or crashes the
> host on continuing the DMA.

If the device is gone, then DMA does not continue.

IIUC what is going on for you, is that you have developed a surprise
removal emulation that pretends to remove the device but
actually the device is doing DMA. So of course things break then.

> Hence, until such specification and devices
> are invented, restore the previous behavior of treating surprise
> removal as graceful removal to avoid regressions and maintain system
> stability same as before the
> commit 43bb40c5b926 ("virtio_pci: Support surprise removal of virtio pci device").
> 
> As explained above, previous analysis of solving this only in driver
> was incomplete and non-reliable at [1] and at [2]; Hence reverting commit
> 43bb40c5b926 ("virtio_pci: Support surprise removal of virtio pci device")
> is still the best stand to restore failures of virtio net and
> block devices.
> 
> [1] https://lore.kernel.org/virtualization/CY8PR12MB719506CC5613EB100BC6C638DCBD2@CY8PR12MB7195.namprd12.prod.outlook.com/#t


I can only repeat what I said then, this is not how we do kernel
development.

> [2] https://lore.kernel.org/virtualization/20250602024358.57114-1-parav@nvidia.com/

What was missing here, is handling corner cases. So let us please 
try to handle them.

Here is how I would try to do it:

- add a new driver callback
- start a periodic timer task in virtio core on remove
- in the timer, probe that the device is still present.
  if not, invoke a driver callback
- cancel the task on device reset

If you do not have the time, let me know and I will try to look into it.

> Fixes: 43bb40c5b926 ("virtio_pci: Support surprise removal of virtio pci device")
> Cc: stable@vger.kernel.org
> Reported-by: lirongqing@baidu.com
> Closes: https://lore.kernel.org/virtualization/c45dd68698cd47238c55fb73ca9b4741@baidu.com/
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> ---
>  drivers/virtio/virtio_pci_common.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index d6d79af44569..dba5eb2eaff9 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -747,13 +747,6 @@ static void virtio_pci_remove(struct pci_dev *pci_dev)
>  	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
>  	struct device *dev = get_device(&vp_dev->vdev.dev);
>  
> -	/*
> -	 * Device is marked broken on surprise removal so that virtio upper
> -	 * layers can abort any ongoing operation.
> -	 */
> -	if (!pci_device_is_present(pci_dev))
> -		virtio_break_device(&vp_dev->vdev);
> -
>  	pci_disable_sriov(pci_dev);
>  
>  	unregister_virtio_device(&vp_dev->vdev);
> -- 
> 2.26.2


