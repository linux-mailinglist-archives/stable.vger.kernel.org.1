Return-Path: <stable+bounces-204239-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BF6CEA1DF
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 16:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B46AF3020C5A
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 15:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E22F28505E;
	Tue, 30 Dec 2025 15:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qa0HBrUY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32E6231C91
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 15:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767110317; cv=none; b=ibIzDD5zi78AuG+NBqfeBAhrlNhrPglgB2RfGcd/NqRF9hIdHx1wAPgUQm1l0Qw3WAeFC4JWUmf/6ix7qYAdUIVVyit6/usYnF0GxMkPjUcgQYV72fRbLVBn2n5YL+kWfsxuJehqiygl6krEOYEAg3fIRtQ+gvPJtxXchz19N6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767110317; c=relaxed/simple;
	bh=ZLKBHiRi6HgYrjP12xVqhy2hazXvzrLBgY+Qxd7jFvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BgdW6SaF7+6yuZzxsqL8Tuc32FutAp3x5z5Z/eqbWIH700AW5tqv3jkxLg98ToQ86FiXqS9VEwEFRQrc8qa3yYtmf6ntlK7RR9sWoTlxE4EsTfOJ3P/YfqcFe4BnRgWC1KVNpXgHDW3UvGVtXUZWlLrgAD2Yfk041NT6Q8oVWCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qa0HBrUY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE19C4CEFB;
	Tue, 30 Dec 2025 15:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767110316;
	bh=ZLKBHiRi6HgYrjP12xVqhy2hazXvzrLBgY+Qxd7jFvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qa0HBrUYMsyrp5wtQXzd/BlmDi8cXwYQCUO7mTerG46Lpfp3zgDbspPjn74TCbjhd
	 051wUDQOowNxd58+ZYh242xEoCTvZVMrVPWqAHStAi5SwZ32mpq//EyGgITzbVhRN3
	 kHqDa0BT021+hHvkSEu9DJSwYlvKpYHHz7oGv8RtlbmSg742xNryblVKdIyd0sTYGG
	 G8qV7wCoX05Mb2d7qAzpgV2VnKZ+6BAz2XjLEox0a41JBGSlPqV7QdzNtddgEcnGio
	 sPaui1PzTCA+rDy0UQMbG1NBVYSs33/6iMNI8/wyq4Aq9Ww8/9Mfk756riKHyH6Lt/
	 t51+pRFtS7j6w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Udipto Goswami <udipto.goswami@oss.qualcomm.com>,
	stable <stable@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] usb: dwc3: keep susphy enabled during exit to avoid controller faults
Date: Tue, 30 Dec 2025 10:58:34 -0500
Message-ID: <20251230155834.2291619-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122912-stuck-knickers-4454@gregkh>
References: <2025122912-stuck-knickers-4454@gregkh>
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
index 7aa4a7a46233..5ea6d0c929db 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -4109,7 +4109,7 @@ void dwc3_gadget_exit(struct dwc3 *dwc)
 	if (!dwc->gadget)
 		return;
 
-	dwc3_enable_susphy(dwc, false);
+	dwc3_enable_susphy(dwc, true);
 	usb_del_gadget(dwc->gadget);
 	dwc3_gadget_free_endpoints(dwc);
 	usb_put_gadget(dwc->gadget);
diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
index 05718f6fa60d..9fa76abdaadc 100644
--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -155,7 +155,7 @@ int dwc3_host_init(struct dwc3 *dwc)
 
 void dwc3_host_exit(struct dwc3 *dwc)
 {
-	dwc3_enable_susphy(dwc, false);
+	dwc3_enable_susphy(dwc, true);
 	platform_device_unregister(dwc->xhci);
 	dwc->xhci = NULL;
 }
-- 
2.51.0


