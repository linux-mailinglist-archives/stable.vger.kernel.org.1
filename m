Return-Path: <stable+bounces-204234-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F37CEA1C7
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 16:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08740301F5D4
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 15:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4B9261B70;
	Tue, 30 Dec 2025 15:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNssbD4K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12C886277
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 15:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767110141; cv=none; b=tIC/wzbzdzdJPXbOZwc0fuGasYY9cXS9m39Ssz9zK94UbCG3wfVoHjsBgBXmhN3tGVbpKQ1XmPN17K2cKk54e3mwQvkTahW1tWt95pP4+BR1OIBxbQeUnuUUOBtJR/irlukKbl6e8zxYKiSs2LR4RLDdzhFQEhw6sreUMePZwIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767110141; c=relaxed/simple;
	bh=knMGLjYrSjImMlypFgP8NK74jDC78E01zegWGR8n/4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TWfQRfY2mBjqSSHPc0GcbnOqYsdeKUYhTn0lrDA92O3eWHVvww2cCTtlqHdrFThCF8mw8CKwDTTsWKKvWs5Y0uq2HjPgZTkKiE7uCPOzsl8WJ6SiVBBsRxQ5p91RBU0D9XooEh9phuJt/zPvgIwOrPOY6uAQ5Xjbu3AxPzmFHKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNssbD4K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BACD6C4CEFB;
	Tue, 30 Dec 2025 15:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767110140;
	bh=knMGLjYrSjImMlypFgP8NK74jDC78E01zegWGR8n/4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LNssbD4K9wLmpt9YNHsNN7LXk0pApvPO1SwLmyK/lSTIUIyoIjSZbgwVDGV3hgEdd
	 4iGiEBfGkqdR7XCNUTk2Fho+HQ5P2QAdVGXV2ItR0qgvOKN/tFPEwLugEiOsvewhAi
	 OW9coXZkEyPcvKiQwqCnkI6ENFYFmssDA/tvW8Wnar+ryKljnsF3sECxxiQWfvDEEv
	 Y01WC6KR6JKe+cJ8BK1tCwlcSTTMa1ufcPB1u2cfgpBnXTngNn6ZvQ0o45wE7o95pq
	 IOpsGjctUee+F5ZenDLc+G7w8nXBIA/NRwdI2jD1f+sz13kREwvpoX1HCsgYMrrfim
	 tereFMmvCT0aA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Udipto Goswami <udipto.goswami@oss.qualcomm.com>,
	stable <stable@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] usb: dwc3: keep susphy enabled during exit to avoid controller faults
Date: Tue, 30 Dec 2025 10:55:37 -0500
Message-ID: <20251230155538.2289361-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122911-punctual-slapping-497e@gregkh>
References: <2025122911-punctual-slapping-497e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Udipto Goswami <udipto.goswami@oss.qualcomm.com>

[ Upstream commit e1003aa7ec9eccdde4c926bd64ef42816ad55f25 ]

On some platforms, switching USB roles from host to device can trigger
controller faults due to premature PHY power-down. This occurs when the
PHY is disabled too early during teardown, causing synchronization
issues between the PHY and controller.

Keep susphy enabled during dwc3_host_exit() and dwc3_gadget_exit()
ensures the PHY remains in a low-power state capable of handling
required commands during role switch.

Cc: stable <stable@kernel.org>
Fixes: 6d735722063a ("usb: dwc3: core: Prevent phy suspend during init")
Suggested-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Signed-off-by: Udipto Goswami <udipto.goswami@oss.qualcomm.com>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://patch.msgid.link/20251126054221.120638-1-udipto.goswami@oss.qualcomm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/gadget.c | 2 +-
 drivers/usb/dwc3/host.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index de6406ada056..9dbbefe00f22 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -4585,7 +4585,7 @@ void dwc3_gadget_exit(struct dwc3 *dwc)
 	if (!dwc->gadget)
 		return;
 
-	dwc3_enable_susphy(dwc, false);
+	dwc3_enable_susphy(dwc, true);
 	usb_del_gadget(dwc->gadget);
 	dwc3_gadget_free_endpoints(dwc);
 	usb_put_gadget(dwc->gadget);
diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
index 9adcf3a7e978..c6514cd1ebd8 100644
--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -157,7 +157,7 @@ int dwc3_host_init(struct dwc3 *dwc)
 
 void dwc3_host_exit(struct dwc3 *dwc)
 {
-	dwc3_enable_susphy(dwc, false);
+	dwc3_enable_susphy(dwc, true);
 	platform_device_unregister(dwc->xhci);
 	dwc->xhci = NULL;
 }
-- 
2.51.0


