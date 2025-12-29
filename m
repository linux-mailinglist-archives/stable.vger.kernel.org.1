Return-Path: <stable+bounces-203575-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DFECE6F04
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 14:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75421300976F
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 13:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024CA3191BF;
	Mon, 29 Dec 2025 13:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jb4vi6OU"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D7C2D0600
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 13:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767016755; cv=none; b=AYG/cNycWnVPlut+5DzkV7itgkRwMBvdn+6S4Rzfuw/dYEOEb6otSF4KWO9WYZzTaykjpGLEN9/U5MiVJX0lBMuPKNxeB7CYzY+g1Dg6Rhxekz9YUzd4SjMAbKYSFAp+KR9n6Ktsfk9oppj28odqEfxPkqDmdhV3Ebh0gDeAzqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767016755; c=relaxed/simple;
	bh=k257uZ3HPDKFfAze/hz1Hfmw8/7Hf+9ogZi61Nyan10=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a0ZpElldPCe4vBRF9/Fh3gspEanZhJZqmxFhVeq4jGst8gAHdiUKD0yWjS0bPDi2m693uvgldbK6OGE8de/44rHxVwcxonoG52N9T9IGRhAFz8cK51zAnS1pwiJRqJvzCB70fIX5erUG5VraEH1VftVaTulwhBuKOwXc/5UtVrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jb4vi6OU; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-430f3692d4aso615668f8f.1
        for <stable@vger.kernel.org>; Mon, 29 Dec 2025 05:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767016752; x=1767621552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jnurlv5ZkeGevc2yEP3yL2OMFl89R04sLNUEhoXlc4A=;
        b=Jb4vi6OUmolZ4NXViQlAkeq0JttPiAGs85sSgTroLRQN6PTW3eJ0Qx3lk4q4uljvuw
         hY9QD7hSwXfbp/I/Uuldx6Pou/8Kv8NqMzpG1+EEMTiaOxSHjdDOUPMdooPJvLO3bgrQ
         fCL2C1VDR+wLBEildF9gD831DPeJGwNsvtKw2eWJOCRVAgEIEVwo1HVLcH+aXZV4KGRO
         DZX1zoLxHJ7+zgAsrUl5a+N7J5DC9d3PYmD1CsE1BDztKcCSRKebIWEKm//NvNf/38rp
         ohxAD8pFkM6X7cwgMPp7NlvYiagUcfRxNBB2dPAcNvO1i8nCJWNeGB+GRHYYwDMjZv6u
         z8bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767016752; x=1767621552;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jnurlv5ZkeGevc2yEP3yL2OMFl89R04sLNUEhoXlc4A=;
        b=PWcU/oemt1xDlB5ZLjL4kzZ/hybi8yaKwMITYJ3Z1RdTCETB2aylXw3n61v/D520bc
         Yd/lmeewKlAL89vMLRJVlv2SCmGvlDvMKlXz+bdd+xF9Pa3L6WTODxq6jET8Yup5k/CK
         xEWHcGCyXE+hjvBuPv+0U5u86UBD/szRyAY5K4SxJQ70ysY/NjjPHMWvaXMkQ1/rVGSQ
         adT1ZqRb31F7kSXwomu4qp9N4qIJsr9uzEaPgunVokTcH+IzjFoLD8DXrB1fGl5We4Du
         4Pzf/qqVjR2tGhnHXNbGl/YsQXpj+Ntek5bp1SJ4V5rxiXU8qF2Pgcy7xEmV6tYUDKy6
         m/GA==
X-Forwarded-Encrypted: i=1; AJvYcCV969Pufc8UMW/laiRwXWeY0tIMjsl2UYc7ntdtte7bk9UkscJBtN50SouA3mhNpVpeBCrCRh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOBrbA2g0+A4jWdqGP5S2A8WzTdE4BtDnMSHWI6fiy0oHsP98D
	ibGa3l20WVsNBdDwr9Tq0T3R7zl2AXW5IrJr+lls+l3u16lwFyFrOWnj
X-Gm-Gg: AY/fxX6Qf4RaEi9k0fcVftc/fDXxa4L9FthvdvFWO4LtPzdkl/H0Yf7kHPYLRwZU58x
	m0NUSXbVu5D+Vv7cZ4d7yKIGdHduFzVO8sSS0fBu7ssPTFIZ/aZItL0UMFjlhSG1kZ3e517Yj4D
	ud7/3yzZRJQpAn2nHp0+vs7ALfvd1NHgF5R+pq1PPksIWASv+nvk7po/L2i5fxYzB6K62khtzbu
	/ulArhbgpkES5R154biNJLkpjRD8DXKXy7oHcZct/dbT7c2otyA8IK97JEYjHOkOXTdrYNBAQdf
	xebAf1UJkt/+Z7wPiQz7ZS7JoMwDkV2twMaGWCqRRErEgZbFOlcgTYYTf+FKOI86mVa+8VKCEL5
	tYdEJ0yTDnz7Mpme+IU2K00v2ry4zRFusRnaxWEpcmfTbYh95VaBXCzAVuk9ddxqS9FBOm2wgEd
	zXszd8O0rfGxM1QVs8aHGuQZX9jHJr9Q4dHnOhG6AS8z51HTY2PzVAD5lKqJPH9WDKRl2uPVU7F
	GyWDMs=
X-Google-Smtp-Source: AGHT+IG9xRAmZubwF+oTURx72QKNS8IBmfurtixzLyk4corHAwr+82eB/ZvmEfCyKAkZ8m72tcMOWQ==
X-Received: by 2002:a05:600c:3ba4:b0:468:7a5a:14cc with SMTP id 5b1f17b1804b1-47d1957af0emr232438825e9.3.1767016752121;
        Mon, 29 Dec 2025 05:59:12 -0800 (PST)
Received: from thomas-precision3591.paris.inria.fr (wifi-pro-83-215.paris.inria.fr. [128.93.83.215])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4324ea1b1bdsm61881417f8f.8.2025.12.29.05.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 05:59:11 -0800 (PST)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Wayne Chang <waynec@nvidia.com>,
	Haotien Hsu <haotienh@nvidia.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Liao Yuanhong <liaoyuanhong@vivo.com>,
	Nagarjuna Kristam <nkristam@nvidia.com>,
	Felipe Balbi <felipe.balbi@linux.intel.com>,
	linux-usb@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] usb: gadget: Fix trb_virt_to_phys() error value
Date: Mon, 29 Dec 2025 14:58:49 +0100
Message-ID: <20251229135853.33222-1-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

0 is a valid DMA address, so returning DMA_MAPPING_ERROR in
trb_virt_to_phys().  Also, dma_mapping_error() wouldn't
flag 0 as an error address.
Checking the return value directly because the dma_addr
does not come directly from dma_map().

Fixes: 49db427232fe ("usb: gadget: Add UDC driver for tegra XUSB device mode controller")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
v1->v2:
  - Add Cc: tag
 drivers/usb/gadget/udc/tegra-xudc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/udc/tegra-xudc.c b/drivers/usb/gadget/udc/tegra-xudc.c
index 9d2007f448c0..63f7eeddb401 100644
--- a/drivers/usb/gadget/udc/tegra-xudc.c
+++ b/drivers/usb/gadget/udc/tegra-xudc.c
@@ -904,7 +904,7 @@ static dma_addr_t trb_virt_to_phys(struct tegra_xudc_ep *ep,
 	index = trb - ep->transfer_ring;
 
 	if (WARN_ON(index >= XUDC_TRANSFER_RING_SIZE))
-		return 0;
+		return DMA_MAPPING_ERROR;
 
 	return (ep->transfer_ring_phys + index * sizeof(*trb));
 }
@@ -1484,7 +1484,7 @@ __tegra_xudc_ep_dequeue(struct tegra_xudc_ep *ep,
 			deq_ptr = trb_virt_to_phys(ep,
 					&ep->transfer_ring[ep->enq_ptr]);
 
-			if (dma_mapping_error(xudc->dev, deq_ptr)) {
+			if (deq_ptr == DMA_MAPPING_ERROR) {
 				ret = -EINVAL;
 			} else {
 				ep_ctx_write_deq_ptr(ep->context, deq_ptr);
@@ -2834,7 +2834,7 @@ static void tegra_xudc_reset(struct tegra_xudc *xudc)
 
 	deq_ptr = trb_virt_to_phys(ep0, &ep0->transfer_ring[ep0->deq_ptr]);
 
-	if (!dma_mapping_error(xudc->dev, deq_ptr)) {
+	if (deq_ptr != DMA_MAPPING_ERROR) {
 		ep_ctx_write_deq_ptr(ep0->context, deq_ptr);
 		ep_ctx_write_dcs(ep0->context, ep0->pcs);
 	}
-- 
2.43.0


