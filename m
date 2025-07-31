Return-Path: <stable+bounces-165609-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D36B16A5B
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 04:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E706718C5C7C
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 02:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2C1233728;
	Thu, 31 Jul 2025 02:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6jaJoQR"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775AA22318;
	Thu, 31 Jul 2025 02:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753928367; cv=none; b=fsu/XdmRa6+kHsx9o2KZRiBRoRjlCJ0RmXU810LC4BuAcwPx9PUNzaGHQuGkF8Crb6xrnbEGqil1ZQTREFaoFnriXR77jGLXzjfSh+QSzWmYdOBMFCvxDJf7f6VBhvLz/wx5uj26CgMWg9ET98Iqib9RVncQZrw0wh6Ickguchg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753928367; c=relaxed/simple;
	bh=/EMZUGIb+jSGRcKKS31fRFqZ32wWToO8WQ5zfarulMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZeoIrJVFTX6IHRQzIutwztBEuJ6shpKzgSvEeXfIgtK8m2RDDU5+MnmBHDTEBjrQUXQ3inLF170/vlSgVJT+SmutrIb0r4Zdi/xR2q8Hlt6YkxqZGZEMsH2WhlfvedixgvhV/bQ2jyWJlviWBO2Z9ovlLYBJKEhtqqFAs2BcPBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F6jaJoQR; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4561a4a8bf2so4045895e9.1;
        Wed, 30 Jul 2025 19:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753928364; x=1754533164; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b/rG/4GRP2jN1wvu1hAC2b4sTXSJWfazoIpwk4Gm8xA=;
        b=F6jaJoQR+E8uIGYSNJTAEVBN3Y02LtYrI/QwUUhAC9z1PcRQRBSxBGAQG9c3fle5TA
         J+1USHXhnLoTw5fhE930OwCJtpGD2hHP66AcI712e53DRlfIo7pfXMZXHqBYX4P3kQRg
         4yE9oRTy0nfEM6C2ofTy7t6xJ1zchp3a5pckRwoDJR+vo5HSJQo7ZXQLwZgiWaBBlyl+
         IlVLmUhd7V+CRdfBdAsYCuxuj7w6mA/8p3HI1yf+h4liHq7h9hTfM4SOokjvfrn4+ta4
         Q8gwUUCa79PcqK4Kg2WE/QwJRQS1drZKjJJBkZ4AtgypugDria1DOPlOKc2iFZ9G0omK
         7sHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753928364; x=1754533164;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b/rG/4GRP2jN1wvu1hAC2b4sTXSJWfazoIpwk4Gm8xA=;
        b=JkBYlNxUldnC5MQNsxdMkHZW+sBHL6G3o0z2HKHgUMlgR5lcsvuL7XJNZeuLizujF5
         UcjU3neNZzAEnTOA6qNt0Lj3keW24ww1xGpbj/ZqKpImVy1McjBcUUXQ+Dyvu9eqCkxI
         WpTxtyR49/qRy34NsA6SoyiJlR+0XbOdGtVZs2QKmN/pBbd3+1kbp9NGEaVN9nPRvNCF
         h/YFieNHdFpFncewzqEV8ZTSVSXOagSCN7UOEpVc4yxWr8hv91X2DQQ/j07SABggK+rm
         eE8Ecl3y2hvCScCWw4PYN7PHM+kqE3wyX+QeZZM0J8fi2lJeioTMAzLbWtT5nqRnPJEb
         ZX3g==
X-Forwarded-Encrypted: i=1; AJvYcCVya+KhdyO4/tN/62ad1jw1hTnZcECtEfKGTuX7/IHc87R3ptiZLd2zjUe0sZUjhS+ayKJGAtzI@vger.kernel.org, AJvYcCXQz1RltgycgJYlVUdaYsQxXhm70rc2Z5hDcsyVnzU4fPxwxLDLWWE+VKdeo+488BW9YU4IPzJEwyIt9o6A@vger.kernel.org, AJvYcCXkn7e90E0/jXFbUnNAs5im4DVy3HHqu0d+PI8cWzGqsxK0j2Df3yfQQwidNlJrZRWUeGHZMfQJauGpjr+p7Vo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvMvRGlblT9h8O0NcvXy+bmDnCZsb2N15SdZMVM3Ku1M/nSu61
	T8LK2D7HOvErAcSvrQ/OWB27h9+nDy3FDqLYToF2ZNJ2fEsd5k7/De/xh91dmFYr
X-Gm-Gg: ASbGncsuRu7MKhNeX1ASsxgFv3WSOK5DdOWqadNvYVpGkDYEysM81/EzFzw0xyGXFog
	Lk3Gr3UWjvfXyFyzlbtXSkf0heBm13keiTW5utmNYx8/gHUXA3z4LUuDRazDfGPFwMSpmsZdG/H
	wSqhAn9MbFbG1CVVYXFTtfeVhPKU7jUbMPAs1TI5uaJL7mmVgr6LJIIgMWV4yvYAW+vbBAPxKYK
	LbH8AmiVSsMsrWYT9F5qbbfm2hqH7BYK1BEv7SuO6UM3/rQZ3HphSBCCTaqRNrjH7sUiuHdjg8x
	lnnBidT/8eoH3RzlPJTbkEaxxiSlY0+9LQmQ8+dHkXxpsfSsWOftyt1unf0zW6rTGUNgcA5XzCe
	NuWhveEKV74Q=
X-Google-Smtp-Source: AGHT+IFO4MHztFKSK6takGVorJXNttTmeTk7NbkHF16a2QXKUseuUs1uqQ2pxHvICB01OcSO4cpZAQ==
X-Received: by 2002:a05:600c:3ba1:b0:456:1fd9:c8f0 with SMTP id 5b1f17b1804b1-45892b947c9mr57241695e9.2.1753928363779;
        Wed, 30 Jul 2025 19:19:23 -0700 (PDT)
Received: from pc ([165.51.119.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c48de68sm719878f8f.67.2025.07.30.19.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 19:19:22 -0700 (PDT)
Date: Thu, 31 Jul 2025 03:19:19 +0100
From: Salah Triki <salah.triki@gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: salah.triki@gmail.com
Subject: [PATCH V3] Bluetooth: bfusb: Fix use-after-free and memory leak in
 device lifecycle
Message-ID: <aIrSp18mz3GS67a1@pc>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The driver stores a reference to the `usb_device` structure (`udev`)
in its private data (`data->udev`), which can persist beyond the
immediate context of the `bfusb_probe()` function.

Without proper reference count management, this can lead to two issues:

1. A `use-after-free` scenario if `udev` is accessed after its main
   reference count drops to zero (e.g., if the device is disconnected
   and the `data` structure is still active).
2. A `memory leak` if `udev`'s reference count is not properly
   decremented during driver disconnect, preventing the `usb_device`
   object from being freed.

To correctly manage the `udev` lifetime, explicitly increment its
reference count with `usb_get_dev(udev)` when storing it in the
driver's private data. Correspondingly, decrement the reference count
with `usb_put_dev(data->udev)` in the `bfusb_disconnect()` callback.

This ensures `udev` remains valid while referenced by the driver's
private data and is properly released when no longer needed.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
Fixes: 9c724357f432d ("[Bluetooth] Code cleanup of the drivers source code")
Cc: stable@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes in v3:
    - Add tag Cc

Changes in v2:
    - Add tags Fixes and Cc
 drivers/bluetooth/bfusb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
index 8df310983bf6..f966bd8361b0 100644
--- a/drivers/bluetooth/bfusb.c
+++ b/drivers/bluetooth/bfusb.c
@@ -622,7 +622,7 @@ static int bfusb_probe(struct usb_interface *intf, const struct usb_device_id *i
 	if (!data)
 		return -ENOMEM;
 
-	data->udev = udev;
+	data->udev = usb_get_dev(udev);
 	data->bulk_in_ep    = bulk_in_ep->desc.bEndpointAddress;
 	data->bulk_out_ep   = bulk_out_ep->desc.bEndpointAddress;
 	data->bulk_pkt_size = le16_to_cpu(bulk_out_ep->desc.wMaxPacketSize);
@@ -701,6 +701,8 @@ static void bfusb_disconnect(struct usb_interface *intf)
 
 	usb_set_intfdata(intf, NULL);
 
+	usb_put_dev(data->udev);
+
 	bfusb_close(hdev);
 
 	hci_unregister_dev(hdev);
-- 
2.43.0


