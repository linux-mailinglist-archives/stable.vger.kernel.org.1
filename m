Return-Path: <stable+bounces-169413-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E819AB24C8D
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 16:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A6EDA4E2562
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 14:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88E42EBBBC;
	Wed, 13 Aug 2025 14:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jIwIRiuH"
X-Original-To: stable@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958A42EA756
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 14:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755096921; cv=none; b=EjiP2ItKaJBaIzTQluRIC4c7thR4BZXZ9T8z1dURop86COX3iUhQw2Srds+HjtZGt/gXPlRRyYCfPN/Lpmx7HKJUzJYSIHQ81xrRlAI68rBeI/Jny0qQUJgiWFjBfwqDWcipoQTy7Zo+szQWKW/l7OMRsAZPdC4ZBqus3YEIQY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755096921; c=relaxed/simple;
	bh=M7GZNSUpI9ATPqxGDtbiF1Ozy+rhBjrdP5xZjfVP5lo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=URnwoZdfIvxr7lr6dP4D5IGWLmPNMUdf7V9eguhoi0De67/lu6lRm3vf6TG6byAEuMYO/8NhYoqv5MigJUWr/McNZ09QcW3st00aOAe6J2DPgUZZ2MP2pCAO2Siqn2GMVgiTTM2TGUPqBNAxXY5NKI3y0p53ApRLQDq3U2OK3b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jIwIRiuH; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755096907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LvftcL58ct6X0ftT2fa9FbYktve1QOI78gCmcjiX2eg=;
	b=jIwIRiuHdRmRr7Y++eYtolUWNm35sk2k0VwL5lOQMPhOAthrCOFojp2G0NDQabomPnmOP8
	gEKBtK5y2ZC2xA1cDUAAgifuYzi8ZUxiTi4mvpamjoeGSAHqLTuavewaA/Awef0ag6L/88
	DWjlaqaLE019fowMhri0iUaFzzZEozw=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	wwang <wei_wang@realsil.com.cn>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@suse.de>,
	linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH] usb: storage: realtek_cr: Use correct byte order for bcs->Residue
Date: Wed, 13 Aug 2025 16:52:49 +0200
Message-ID: <20250813145247.184717-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Since 'bcs->Residue' has the data type '__le32', convert it to the
correct byte order of the CPU using this driver when assigning it to
the local variable 'residue'.

Cc: stable@vger.kernel.org
Fixes: 50a6cb932d5c ("USB: usb_storage: add ums-realtek driver")
Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Resending this as a separate patch for backporting as requested by Greg.
Link to previous patch: https://lore.kernel.org/lkml/20250813101249.158270-6-thorsten.blum@linux.dev/
---
 drivers/usb/storage/realtek_cr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/storage/realtek_cr.c b/drivers/usb/storage/realtek_cr.c
index 8a4d7c0f2662..758258a569a6 100644
--- a/drivers/usb/storage/realtek_cr.c
+++ b/drivers/usb/storage/realtek_cr.c
@@ -253,7 +253,7 @@ static int rts51x_bulk_transport(struct us_data *us, u8 lun,
 		return USB_STOR_TRANSPORT_ERROR;
 	}
 
-	residue = bcs->Residue;
+	residue = le32_to_cpu(bcs->Residue);
 	if (bcs->Tag != us->tag)
 		return USB_STOR_TRANSPORT_ERROR;
 
-- 
2.50.1


