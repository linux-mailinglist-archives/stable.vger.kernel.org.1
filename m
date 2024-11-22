Return-Path: <stable+bounces-94613-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD449D6062
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 15:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 217A12827A7
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 14:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B691DEFF0;
	Fri, 22 Nov 2024 14:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IqBMrwrG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C98A7E0E8;
	Fri, 22 Nov 2024 14:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732286062; cv=none; b=RVD/jRzsaPnMw0SM/KMakZ2aRT+PgPuxUgOCNDimBwxorcXND9tLp5u4XZ9PoVD3bdjdqRe2+8RqfSRGhAywMAL1REh/Roa5UJd/4/WHN67xr26iuD0QteS++pwLmof5VQMORvEVr+7h4bMoNqG+XCHYM0dJaXdK+DSi685RXok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732286062; c=relaxed/simple;
	bh=iclNCr33GxoF5d4u3B+W9QeY8OuYhhF37i+VUhPOunY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YQzJvGtjrWe3ZJxzxyn6eSa+RGByQbpDrz91yRPVTfbAGT5Xg7AHspoqE94TCvQjxRD3qHcJs/lP8rsGk5by8VZecP87ChKkJ6C5RC5HOSsSRpY5S4yvIuVNdYJksSKVThq7cXV55ESa28yeINe6Rl+K1RnrXhZXE88N5XicE1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IqBMrwrG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9BE2C4CED7;
	Fri, 22 Nov 2024 14:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732286061;
	bh=iclNCr33GxoF5d4u3B+W9QeY8OuYhhF37i+VUhPOunY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IqBMrwrG1ZPyPIv6GbisHYrYziwcppOevtFuUfQ/cmQ+pT8Z1/SkfcdDkA/Tu5Uyx
	 4om4SQWc6+jCiHlGnNwteMqwU5QEJD3jt9CNtjWl4XkbCD4PSRXFzzNJEn/mPiMn0V
	 PxpmftWGNU1lH2ga5Jcidt8H/qXhAF8YL81VRDkM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.12.1
Date: Fri, 22 Nov 2024 15:33:46 +0100
Message-ID: <2024112234-economy-dotted-efe5@gregkh>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <2024112234-circle-number-6388@gregkh>
References: <2024112234-circle-number-6388@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 68a8faff2543..70070e64d267 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 12
-SUBLEVEL = 0
+SUBLEVEL = 1
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 0fac689c6350..13db0026dc1a 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -371,7 +371,7 @@ static int uvc_parse_format(struct uvc_device *dev,
 	 * Parse the frame descriptors. Only uncompressed, MJPEG and frame
 	 * based formats have frame descriptors.
 	 */
-	while (buflen > 2 && buffer[1] == USB_DT_CS_INTERFACE &&
+	while (ftype && buflen > 2 && buffer[1] == USB_DT_CS_INTERFACE &&
 	       buffer[2] == ftype) {
 		unsigned int maxIntervalIndex;
 
diff --git a/mm/mmap.c b/mm/mmap.c
index 79d541f1502b..4f6e566d52fa 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1491,7 +1491,18 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 				vm_flags = vma->vm_flags;
 				goto file_expanded;
 			}
-			vma_iter_config(&vmi, addr, end);
+
+			/*
+			 * In the unlikely even that more memory was needed, but
+			 * not available for the vma merge, the vma iterator
+			 * will have no memory reserved for the write we told
+			 * the driver was happening.  To keep up the ruse,
+			 * ensure the allocation for the store succeeds.
+			 */
+			if (vmg_nomem(&vmg)) {
+				mas_preallocate(&vmi.mas, vma,
+						GFP_KERNEL|__GFP_NOFAIL);
+			}
 		}
 
 		vm_flags = vma->vm_flags;
diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
index e2157e387217..56c232cf5b0f 100644
--- a/net/vmw_vsock/hyperv_transport.c
+++ b/net/vmw_vsock/hyperv_transport.c
@@ -549,6 +549,7 @@ static void hvs_destruct(struct vsock_sock *vsk)
 		vmbus_hvsock_device_unregister(chan);
 
 	kfree(hvs);
+	vsk->trans = NULL;
 }
 
 static int hvs_dgram_bind(struct vsock_sock *vsk, struct sockaddr_vm *addr)

