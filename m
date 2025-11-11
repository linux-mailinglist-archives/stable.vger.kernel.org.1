Return-Path: <stable+bounces-194492-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF5EC4E52E
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 15:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 878253B189C
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 14:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A3B32AADC;
	Tue, 11 Nov 2025 14:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b="M0BU84RW"
X-Original-To: stable@vger.kernel.org
Received: from mx12.kaspersky-labs.com (mx12.kaspersky-labs.com [91.103.66.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9652B2F7ADC;
	Tue, 11 Nov 2025 14:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.103.66.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762870245; cv=none; b=RtYvyGFpi3paFG3VTchbIpbkxLM4I3a5dRYgaO/D1QIT7+pAVja3PpnoqBkOIW6TfZiVcDvhO8ml30HP6dYyVyJ25HKHym0mT5T07udcLKHGhskiv1TnM05I0l7XXbOwoEm4U3bZnsvmBGZFDtt2xrrwSHshx8fJ/AVdQRGlObY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762870245; c=relaxed/simple;
	bh=qjFsNwbmRxO4Hp5vuknqfvOSCdjPaO3iwBWAF9Nevcs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Eqhj67Sxh0in+nnnnlpMaY6sHP5EpwPZyJzLis8LiZIeDHDG5VC1F3mJT6c744blvMrEKEM2yrX0cI0dwo/t7dRo1/bD59NqknbZHg30Gu6FRCc43LfauMcGM99tWEZINjiCD0DCxch5fxcOnPWbBm/c0f0FJA6UOJtNZlfGzLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com; spf=pass smtp.mailfrom=kaspersky.com; dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b=M0BU84RW; arc=none smtp.client-ip=91.103.66.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaspersky.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
	s=mail202505; t=1762870234;
	bh=I77upVn73xtl2hhKLa4OtVaXf553s+NjSyLwVjwUjJw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=M0BU84RWOCpgmJ590tapWIk5F9Bod6FsxhQlFSC0tnOCBTmji4/iL0LtUZN2fZ3aS
	 h/SmCjYz+uNXmuI3xABp55QEgmPP2BEV2lX2bD29mvlvHcaRSzYiFuKzSur2yFgv1P
	 lhjjyTDop2XHWvwmA+7v0VRc0YSior4k6Ph5Cptf8HOg1AfFiXYXk7AYFIGlPgaVeD
	 aDsE6lH20rJJQ0rq/Y6hT6lHyJhsF94cfMIMs1l0puQm07mY+PJ5cG0Bc2vI5fCsFb
	 OfZVGlFE3PlP4hoVXWT9WSuoUjMSvQhHHdOsnqyHdlHun4jZg5JYsMhIbHjz8yxISZ
	 GGcvuD3ctD/Pw==
Received: from relay12.kaspersky-labs.com (localhost [127.0.0.1])
	by relay12.kaspersky-labs.com (Postfix) with ESMTP id 7FEA75A4A7A;
	Tue, 11 Nov 2025 17:10:34 +0300 (MSK)
Received: from mail-hq2.kaspersky.com (unknown [91.103.66.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail-hq2.kaspersky.com", Issuer "Kaspersky MailRelays CA G3" (verified OK))
	by mailhub12.kaspersky-labs.com (Postfix) with ESMTPS id 4EA0D5A15AB;
	Tue, 11 Nov 2025 17:10:33 +0300 (MSK)
Received: from zhigulin-p.avp.ru (10.16.104.190) by HQMAILSRV2.avp.ru
 (10.64.57.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 11 Nov
 2025 17:09:58 +0300
From: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>, Chunfeng Yun
	<chunfeng.yun@mediatek.com>, <linux-usb@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>,
	<stable@vger.kernel.org>
Subject: [PATCH v2] usb: mtu3: fix possible NULL pointer dereference in ep0_rx_state()
Date: Tue, 11 Nov 2025 17:09:53 +0300
Message-ID: <20251111140956.3285945-1-Pavel.Zhigulin@kaspersky.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HQMAILSRV2.avp.ru (10.64.57.52) To HQMAILSRV2.avp.ru
 (10.64.57.52)
X-KSE-ServerInfo: HQMAILSRV2.avp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 11/11/2025 13:58:40
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 197969 [Nov 11 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: Pavel.Zhigulin@kaspersky.com
X-KSE-AntiSpam-Info: LuaCore: 75 0.3.75
 aab2175a55dcbd410b25b8694e49bbee3c09cdde
X-KSE-AntiSpam-Info: {Tracking_cluster_exceptions}
X-KSE-AntiSpam-Info: {Tracking_real_kaspersky_domains}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: zhigulin-p.avp.ru:7.1.1,5.0.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;kaspersky.com:7.1.1,5.0.1;lore.kernel.org:7.1.1
X-KSE-AntiSpam-Info: {Tracking_white_helo}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/11/2025 14:00:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 11/11/2025 1:40:00 PM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSMG-AntiPhishing: NotDetected, bases: 2025/11/11 13:30:00
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/11/11 12:29:00 #27910883
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2025/11/11 13:29:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 52

The function 'ep0_rx_state()' accessed 'mreq->request' before verifying
that mreq was valid. If 'next_ep0_request()' returned NULL, this could
lead to a NULL pointer dereference. The return value of
'next_ep0_request()' is checked in every other code path except
here. It appears that the intended 'if (mreq)' check was mistakenly
written as 'if (req)', since the req pointer cannot be NULL when mreq
is not NULL.

Initialize 'mreq' and 'req' to NULL by default, and switch 'req'
NULL-checking to 'mreq' non-NULL check to prevent invalid memory access.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: df2069acb005 ("usb: Add MediaTek USB3 DRD driver")
Signed-off-by: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>
---
v2: Add <stable@vger.kernel.org> to CC list
v1: https://lore.kernel.org/all/20251027193152.3906497-1-Pavel.Zhigulin@kaspersky.com

 drivers/usb/mtu3/mtu3_gadget_ep0.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3_gadget_ep0.c b/drivers/usb/mtu3/mtu3_gadget_ep0.c
index e4fd1bb14a55..ee7466ca4d99 100644
--- a/drivers/usb/mtu3/mtu3_gadget_ep0.c
+++ b/drivers/usb/mtu3/mtu3_gadget_ep0.c
@@ -508,8 +508,8 @@ static int handle_standard_request(struct mtu3 *mtu,
 /* receive an data packet (OUT) */
 static void ep0_rx_state(struct mtu3 *mtu)
 {
-	struct mtu3_request *mreq;
-	struct usb_request *req;
+	struct mtu3_request *mreq = NULL;
+	struct usb_request *req = NULL;
 	void __iomem *mbase = mtu->mac_base;
 	u32 maxp;
 	u32 csr;
@@ -519,10 +519,11 @@ static void ep0_rx_state(struct mtu3 *mtu)

 	csr = mtu3_readl(mbase, U3D_EP0CSR) & EP0_W1C_BITS;
 	mreq = next_ep0_request(mtu);
-	req = &mreq->request;

 	/* read packet and ack; or stall because of gadget driver bug */
-	if (req) {
+	if (mreq) {
+		req = &mreq->request;
+
 		void *buf = req->buf + req->actual;
 		unsigned int len = req->length - req->actual;

--
2.43.0


