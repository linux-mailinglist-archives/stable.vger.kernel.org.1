Return-Path: <stable+bounces-137056-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEA9AA09A6
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 13:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C57251B66189
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 11:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F0C2C17BB;
	Tue, 29 Apr 2025 11:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="L51LcWUS"
X-Original-To: stable@vger.kernel.org
Received: from smtp102.iad3a.emailsrvr.com (smtp102.iad3a.emailsrvr.com [173.203.187.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108AC253F1E
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 11:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.203.187.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745926312; cv=none; b=WFI3cLgwkyo9j7rOqsLZEDdbHkkpxIOK68/IpGAEGVf3OgzYcClMZtFkm5F92FHHRMd0bQaDBKeziwrebamLrtYKKB3cbUE0ICMlvgGYtR5/KHSD7MqkbeVLigL07jB5nAcNM7ySFY+p2eYalIGn67K4uGmB/xAoxPYXa0SAE/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745926312; c=relaxed/simple;
	bh=yzdtvQHd66YpVgJhqctghd5lhSNMCX1l7GfnmiRrRZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QLg0VxMqyTj2Ci8D+qEQDU5CdlYyG/iX3yI1lTIFCASxpu8i/JVUAdxxF1z7+aZxPD6nTCmWIjQmdL8MnEModtWGNYx4csYm9wxaqi1LlvBv8mmC0iKqsRvFctmZd1JbEf2yH/m8IoGuFHtwFK30Qznlr06sbX0aJDC/17VBiFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=L51LcWUS; arc=none smtp.client-ip=173.203.187.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1745921656;
	bh=yzdtvQHd66YpVgJhqctghd5lhSNMCX1l7GfnmiRrRZo=;
	h=From:To:Subject:Date:From;
	b=L51LcWUSBUW61BMtMCUL5KS569NDSOOZO2PZ0p2LPhyk2a+XH8x+FukliNu7CEnA7
	 V1g1T7jzXzjG92i3M5ZarFKapgD3GxILzNKJ9PVWnw2fKHnQWrUjMkuTiwooF7pfnZ
	 cyJlBYrvHDpmklfI5d3nS6L5Kk775VVwCyUadYqo=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp29.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 8213E24CCA;
	Tue, 29 Apr 2025 06:14:15 -0400 (EDT)
From: Ian Abbott <abbotti@mev.co.uk>
To: stable@vger.kernel.org
Cc: Ian Abbott <abbotti@mev.co.uk>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.6.y] comedi: jr3_pci: Fix synchronous deletion of timer
Date: Tue, 29 Apr 2025 11:14:04 +0100
Message-ID: <20250429101404.98379-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <2025042806-speculate-arose-b5b8@gregkh>
References: <2025042806-speculate-arose-b5b8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: ef4a0d5e-acb2-4263-8f11-5f6fbaf3f2ff-1-1

commit 44d9b3f584c59a606b521e7274e658d5b866c699 upstream.

When `jr3_pci_detach()` is called during device removal, it calls
`timer_delete_sync()` to stop the timer, but the timer expiry function
always reschedules the timer, so the synchronization is ineffective.

Call `timer_shutdown_sync()` instead.  It does not matter that the timer
expiry function pointer is cleared, because the device is being removed.

Fixes: 07b509e6584a5 ("Staging: comedi: add jr3_pci driver")
Cc: stable <stable@kernel.org>
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
Link: https://lore.kernel.org/r/20250415123901.13483-1-abbotti@mev.co.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/comedi/drivers/jr3_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/comedi/drivers/jr3_pci.c b/drivers/comedi/drivers/jr3_pci.c
index 951c23fa0369..75dce1ff2419 100644
--- a/drivers/comedi/drivers/jr3_pci.c
+++ b/drivers/comedi/drivers/jr3_pci.c
@@ -758,7 +758,7 @@ static void jr3_pci_detach(struct comedi_device *dev)
 	struct jr3_pci_dev_private *devpriv = dev->private;
 
 	if (devpriv)
-		del_timer_sync(&devpriv->timer);
+		timer_shutdown_sync(&devpriv->timer);
 
 	comedi_pci_detach(dev);
 }
-- 
2.47.2


