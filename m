Return-Path: <stable+bounces-158540-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E924AE82DA
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 14:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C62951C2294D
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 12:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8526B25B30D;
	Wed, 25 Jun 2025 12:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UiS3c4GK"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06DF20ED
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 12:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750855157; cv=none; b=tdQI5GndAzMnZhgDkVTd4RrqOqwolxgZhLPPB54WNFl+IuV5QMCM0FabZKTAEodu6T9RY9/i/K2n4z9D7XwdOlLK8wd2gl4fN3hrgFymhVFrL9PZIaIR9uaD5yAK5fCjKkNIHYSz/3qRCZMXs+WRPOHR2GA/WUCGypxBbnWm7HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750855157; c=relaxed/simple;
	bh=+4o3PIxGblecPLXQPo7HXJT+oP1v6Y4BbGilVIDxAXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HTCAXwA9hGV57uHbIF38nlXJjpmE3a0vwDifOzBN52b3O656KBGDzWfjrNyIs2ca6nINmTTxmSOEnDuRuvbOvXs2WFrx3aplY6T0UtA1/8qxfcjIFr3aTw2TiPtPrWkSEpF256fodLrsMF+c3UAs7MoAvW5bPYblV/dyZLs64Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UiS3c4GK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750855154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e4bNJPQhEh1mvM7sPpimO979n6aXsflGYx498uhPxi4=;
	b=UiS3c4GKnNSc+UEd7c+Npt4QWkDk5T4lyafX5dQ3LvzXgLXGTZD6e16p6S6CbLv0ZQSR2H
	XiYgkbJsnGcbHtmPfSd9kAFTS/eBVLxK1zsfQcC/LgwvWp3iaGDQ57SRMazDHfnBS4WleQ
	I6G8wwlyy1auTXqef59q1Pnznqxul6o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-S00iuVLDPbWg8qOl6-u1uA-1; Wed, 25 Jun 2025 08:39:12 -0400
X-MC-Unique: S00iuVLDPbWg8qOl6-u1uA-1
X-Mimecast-MFC-AGG-ID: S00iuVLDPbWg8qOl6-u1uA_1750855151
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a503f28b09so512343f8f.0
        for <stable@vger.kernel.org>; Wed, 25 Jun 2025 05:39:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750855151; x=1751459951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4bNJPQhEh1mvM7sPpimO979n6aXsflGYx498uhPxi4=;
        b=w4O0RXtt9GkzdW93QR8g4e1hPlQx5cKN/zNmks6fqGoweqjMlo3CPOyTJJFwPevByr
         Vx527zZc4HiNkB4KD7r9lXjTeL8ygNKHxR8ZZnYzOY3EcpMl7kbDf8VNVvOK8dQhQ7l+
         RbroNo+cG6IdKhTbfp9luafll/jG+Axt+zHDX4Rw3QRHJ92pFXPd9JoyKlkLsijMFMrj
         JbykZwCVk9aj2ZmLyEMc/AY8gxMWfA/iwJoMQE/8+hyTekBChGosOV7vP2ebO9wG/4LS
         C6oG4m3Yc5gjSuE2t2RJole8JP6MN/duaVQxR5bWnmdhByox0HIS2x8CquF4maDQtbt8
         sadA==
X-Forwarded-Encrypted: i=1; AJvYcCXolOiVRZEIKjnH5Ssa2sG39rPbnH0DBdTSKi3UDMfDYv1ErdDhIYXorC4Zo+IRV9kNeTWvAHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV6TNK0ymzMwLZ2BCMTi0/URFHM8zyKPLmVXSlVY0uY8yn+piG
	vxr1ljlEo2IUsw+NyIWXLyZx6BC4b4cjSd2ICB6KBLTj6SIO8Fe3KFkud4EiV5JT4+L4QFWFIdD
	oYWp6WstjY81NdPc/FsjviTSkGqoxq8PPZqOpTTtiDxcRvqUwFhnfd67w/g==
X-Gm-Gg: ASbGncsP6Ne1hyPIG/DcF/2omcfYcvrBkEEpMgdi/6qlmLFEQmzU5HNUfGrguJ8HTCL
	861d3gvp6KpEGImxbugraKhsmd5urLDBO0lZhqX9/Cv3HLeSZ4Xrz2JmZR4xGsBkOPBMNBMHzAV
	Lie5XhwLYOgRfUBtEcjuKI4seurcFokjiEcBHfqKc4vrlgieS4P6KWz4RjOMY4a1x2eXKjksfkV
	MH2+EdaOTqHEH2qZPZUSIqdadxPZhyKAU0zlBkrIJBWOO+A8JSwmqdFJ27rkbNO8hpJ8hoeKS0o
	hsHObqBZki4yIwPC
X-Received: by 2002:a5d:588d:0:b0:3a4:edf5:8a41 with SMTP id ffacd0b85a97d-3a6e71b86f6mr6479131f8f.4.1750855151336;
        Wed, 25 Jun 2025 05:39:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoof/kcQj6EiHD8phskEoSt5Jd80UBJdNlsfnTMCY5+ROTqwx0M7qzM/M2LNKp+Y8Bpd1tLg==
X-Received: by 2002:a5d:588d:0:b0:3a4:edf5:8a41 with SMTP id ffacd0b85a97d-3a6e71b86f6mr6479099f8f.4.1750855150779;
        Wed, 25 Jun 2025 05:39:10 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:4300:f7cc:3f8:48e8:2142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823671cbsm18931125e9.29.2025.06.25.05.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 05:39:10 -0700 (PDT)
Date: Wed, 25 Jun 2025 08:39:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, axboe@kernel.dk,
	virtualization@lists.linux.dev, linux-block@vger.kernel.org,
	stable@vger.kernel.org, lirongqing@baidu.com, kch@nvidia.com,
	xuanzhuo@linux.alibaba.com, pbonzini@redhat.com,
	jasowang@redhat.com, alok.a.tiwari@oracle.com,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Israel Rukshin <israelr@nvidia.com>
Subject: Re: [PATCH v5] virtio_blk: Fix disk deletion hang on device surprise
 removal
Message-ID: <20250625083746-mutt-send-email-mst@kernel.org>
References: <20250602024358.57114-1-parav@nvidia.com>
 <20250624185622.GB5519@fedora>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624185622.GB5519@fedora>

On Tue, Jun 24, 2025 at 02:56:22PM -0400, Stefan Hajnoczi wrote:
> On Mon, Jun 02, 2025 at 02:44:33AM +0000, Parav Pandit wrote:
> > When the PCI device is surprise removed, requests may not complete
> > the device as the VQ is marked as broken. Due to this, the disk
> > deletion hangs.
> 
> There are loops in the core virtio driver code that expect device
> register reads to eventually return 0:
> drivers/virtio/virtio_pci_modern.c:vp_reset()
> drivers/virtio/virtio_pci_modern_dev.c:vp_modern_set_queue_reset()
> 
> Is there a hang if these loops are hit when a device has been surprise
> removed? I'm trying to understand whether surprise removal is fully
> supported or whether this patch is one step in that direction.
> 
> Apart from that, I'm happy with the virtio_blk.c aspects of the patch:
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Is this as simple as this?

-->


Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

---

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 7182f43ed055..df983fa9046a 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -555,8 +555,12 @@ static void vp_reset(struct virtio_device *vdev)
 	 * This will flush out the status write, and flush in device writes,
 	 * including MSI-X interrupts, if any.
 	 */
-	while (vp_modern_get_status(mdev))
+	while (vp_modern_get_status(mdev)) {
+		/* If device is removed meanwhile, it will never respond. */
+		if (!pci_device_is_present(vp_dev->pci_dev))
+			break;
 		msleep(1);
+	}
 
 	vp_modern_avq_cleanup(vdev);
 
diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
index 0d3dbfaf4b23..7177ce0d63be 100644
--- a/drivers/virtio/virtio_pci_modern_dev.c
+++ b/drivers/virtio/virtio_pci_modern_dev.c
@@ -523,11 +523,19 @@ void vp_modern_set_queue_reset(struct virtio_pci_modern_device *mdev, u16 index)
 	vp_iowrite16(index, &cfg->cfg.queue_select);
 	vp_iowrite16(1, &cfg->queue_reset);
 
-	while (vp_ioread16(&cfg->queue_reset))
+	while (vp_ioread16(&cfg->queue_reset)) {
+		/* If device is removed meanwhile, it will never respond. */
+		if (!pci_device_is_present(vp_dev->pci_dev))
+			break;
 		msleep(1);
+	}
 
-	while (vp_ioread16(&cfg->cfg.queue_enable))
+	while (vp_ioread16(&cfg->cfg.queue_enable)) {
+		/* If device is removed meanwhile, it will never respond. */
+		if (!pci_device_is_present(vp_dev->pci_dev))
+			break;
 		msleep(1);
+	}
 }
 EXPORT_SYMBOL_GPL(vp_modern_set_queue_reset);
 


