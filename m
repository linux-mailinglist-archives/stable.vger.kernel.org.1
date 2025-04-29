Return-Path: <stable+bounces-137058-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 632C2AA0B30
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 14:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1175C846989
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 12:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E157B2C2AD7;
	Tue, 29 Apr 2025 12:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="gIy+SoZO"
X-Original-To: stable@vger.kernel.org
Received: from smtp91.iad3a.emailsrvr.com (smtp91.iad3a.emailsrvr.com [173.203.187.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131432BD5A0
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 12:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.203.187.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745928411; cv=none; b=nIlIT26+anJJ1EToryl8LQ7o0nqpezOwnCWzynvEKw/P+TH7Vd6D4EpUvEPHI78xSRcng+2V5edLHLFDmsWFdP62mBm3Ox4Uhq/7q8N/2KxULqQKoG1qSUU5m5tQJ+qP9sQDFph7uHvc+fqoZ7abcP8g+Tesv0mG//jElnR9RKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745928411; c=relaxed/simple;
	bh=yzdtvQHd66YpVgJhqctghd5lhSNMCX1l7GfnmiRrRZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WqG29nlahLPGBBokqNcxQLWHY84/giNuPXKSps1h5k+9OAdHZDbZm1tRO4WzRzGqETs5xNgC1vRmYW8FxVRXN427yYxWXs2Dvmrp+oXUt/wPpHYeM1GiJbC12sCI+q+Ax37QYuygZsvvk1b7NLoo1RoeaIpHFLdRaRBO/qrxMaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=gIy+SoZO; arc=none smtp.client-ip=173.203.187.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1745921513;
	bh=yzdtvQHd66YpVgJhqctghd5lhSNMCX1l7GfnmiRrRZo=;
	h=From:To:Subject:Date:From;
	b=gIy+SoZOU0/Cn4BzHcYOIuCB/j6MvepK2o86AhSW8OQyz13dcHX3SeKW8C2ifDMgN
	 +7s8w/+ltKlupCiaUTQULhNuT/CXpoGuQ5ZZiAt08p3ThRO7dMN4wvv0sBjRzjsUub
	 5COoi5+rNQ2iqc6yddysUn9ZwZLMMBXQaR8BfULw=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp36.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id F3068534B;
	Tue, 29 Apr 2025 06:11:52 -0400 (EDT)
From: Ian Abbott <abbotti@mev.co.uk>
To: stable@vger.kernel.org
Cc: Ian Abbott <abbotti@mev.co.uk>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.12.y] comedi: jr3_pci: Fix synchronous deletion of timer
Date: Tue, 29 Apr 2025 11:11:33 +0100
Message-ID: <20250429101134.98228-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <2025042806-snowy-deftly-db68@gregkh>
References: <2025042806-snowy-deftly-db68@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 3b5fbf52-78d4-4588-a36c-4c7989fa2cc6-1-1

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


