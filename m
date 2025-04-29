Return-Path: <stable+bounces-137048-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BFCAA089B
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 12:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B380F4820F3
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 10:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34B920FAB1;
	Tue, 29 Apr 2025 10:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="dX3TQCN0"
X-Original-To: stable@vger.kernel.org
Received: from smtp94.iad3b.emailsrvr.com (smtp94.iad3b.emailsrvr.com [146.20.161.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D571FDA8C
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 10:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745922718; cv=none; b=j/TGQIGT9RV0oV9RbtE90Dk6hiTdqJBMZhtcVRHzQkusIecOJq4aJi+g+Kq2Daz6GFBy2CG46w7A4xebJCyiw6558EJeSMIqP3JKu+z/PJKg1WALPrRPwl95oPigahwKqgunqDpbzLqwohMAlIIoo3pmd914s7rLb9eL475CJ1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745922718; c=relaxed/simple;
	bh=yzdtvQHd66YpVgJhqctghd5lhSNMCX1l7GfnmiRrRZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p1cKMBff1Mc911+NzbzAFOZegpRQlr/Tg42NrIEKJcUj+dHBIroukYxmxfNBC1AabnxmCUn1aDukuKyxXgR9TOiayQoBaO4RTuqPESx9SGJUVwYq56nrLtZjlPyPwCnsZCdPpOp999Tw+K8Bij5d0qRvOjvtxWoxccl5XSz8r0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=dX3TQCN0; arc=none smtp.client-ip=146.20.161.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1745921226;
	bh=yzdtvQHd66YpVgJhqctghd5lhSNMCX1l7GfnmiRrRZo=;
	h=From:To:Subject:Date:From;
	b=dX3TQCN0LvDaaqUVZT8Asf6G9sFLUr1R35sEGNqLYPiDe7omT9WuLwyeXIFS8ntjJ
	 G0PuB3bUpLSGELaiCNgtCm1LXqtcTenC4gcsmNsPal7EfXQIQA1d0uRT/WWM1uzMGn
	 Qa4gehFEvTNut8N9udr7xHnn575L6unoD2BUFXVg=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp12.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id E888BC00D4;
	Tue, 29 Apr 2025 06:07:05 -0400 (EDT)
From: Ian Abbott <abbotti@mev.co.uk>
To: stable@vger.kernel.org
Cc: Ian Abbott <abbotti@mev.co.uk>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.14.y] comedi: jr3_pci: Fix synchronous deletion of timer
Date: Tue, 29 Apr 2025 11:06:57 +0100
Message-ID: <20250429100657.97928-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <2025042805-agonize-founder-450f@gregkh>
References: <2025042805-agonize-founder-450f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: ac0f0f5f-a653-4571-913e-cd9ffeab676c-1-1

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


