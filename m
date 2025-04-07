Return-Path: <stable+bounces-128698-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37227A7EAE4
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9893E17D7E9
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243D9267B78;
	Mon,  7 Apr 2025 18:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zk7cV1Zr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0F4267B70;
	Mon,  7 Apr 2025 18:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049696; cv=none; b=pNnx1eyFByaLo2fK6spaiBf5/8gK03QPdRapRSEFGRaw8WJ5f9cBLLt54Ypu97z6trCsCnOenvhQ0Vaqx3qFvpMrScwe0AeJ4FhPSJdWN3+2fbOV9wJI7S1oWTuE1KV3VMaAAgjW7r7z4GSUDmZHcW10AztayhBxJ6lm34BaORQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049696; c=relaxed/simple;
	bh=iVlPf0YN8m2qlYBKhUDIretqwO5glpY+D553GdAjKu0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l684gE38NRPOfifgYt34xajojaLeAZ4goflQyAE+KYqHeKAz2Eb/EduDNJb1y76smV2Fxuv4PYoSoXT6KbBGWLM0vicX9QB8sh2xGCtx0ConUz9Nkydy2Ncs1b8wdPgohqKeGxxlF+bG6dChVoyFLjMraS+tWVo2ongMbEU+82s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zk7cV1Zr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBBF9C4CEE7;
	Mon,  7 Apr 2025 18:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049696;
	bh=iVlPf0YN8m2qlYBKhUDIretqwO5glpY+D553GdAjKu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zk7cV1ZrceY2NN0OAXqUuC8Ln9vHIZe+GNQozBNIAMC7ewdluJVUkeAnrvFaWsbY8
	 +Wv8f1QSFssxjvHmo7hyIhscYoaqKlsprY4KPmigPfNvg8SUCP0Yc1yISJOH7bsdQ6
	 vDiJSoLvbIZFDyOiVyWffbGF9trSrgu49picTrVEBKmVqsEaKQYRXcRewqxHaXturC
	 49iYktZ9FMJnkO9uDH3bQ2A1/Q7gOBCgXd3PQgo0OCdwguQ0d6esDjhMPCmQjflbdl
	 GUHspjJ2/t1mLwqF0wQypu2G0yJBXigrUnV7eeSU75I78PZZiDp0RYQKZ1L3SHTlMj
	 K42N6G3FjjpTg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ferry Toth <fntoth@gmail.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 03/13] usb: dwc3: gadget: Refactor loop to avoid NULL endpoints
Date: Mon,  7 Apr 2025 14:14:37 -0400
Message-Id: <20250407181449.3183687-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181449.3183687-1-sashal@kernel.org>
References: <20250407181449.3183687-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.133
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit eafba0205426091354f050381c32ad1567c35844 ]

Prepare the gadget driver to handle the reserved endpoints that will be
not allocated at the initialisation time.

While at it, add a warning where the NULL endpoint should never happen.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Ferry Toth <fntoth@gmail.com>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://lore.kernel.org/r/20250212193116.2487289-3-andriy.shevchenko@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/gadget.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index f227f6c7c6d7e..d9b3c797077b5 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -555,6 +555,7 @@ static int dwc3_gadget_set_xfer_resource(struct dwc3_ep *dep)
 int dwc3_gadget_start_config(struct dwc3 *dwc, unsigned int resource_index)
 {
 	struct dwc3_gadget_ep_cmd_params params;
+	struct dwc3_ep		*dep;
 	u32			cmd;
 	int			i;
 	int			ret;
@@ -571,8 +572,13 @@ int dwc3_gadget_start_config(struct dwc3 *dwc, unsigned int resource_index)
 		return ret;
 
 	/* Reset resource allocation flags */
-	for (i = resource_index; i < dwc->num_eps && dwc->eps[i]; i++)
-		dwc->eps[i]->flags &= ~DWC3_EP_RESOURCE_ALLOCATED;
+	for (i = resource_index; i < dwc->num_eps; i++) {
+		dep = dwc->eps[i];
+		if (!dep)
+			continue;
+
+		dep->flags &= ~DWC3_EP_RESOURCE_ALLOCATED;
+	}
 
 	return 0;
 }
@@ -721,9 +727,11 @@ void dwc3_gadget_clear_tx_fifos(struct dwc3 *dwc)
 
 	dwc->last_fifo_depth = fifo_depth;
 	/* Clear existing TXFIFO for all IN eps except ep0 */
-	for (num = 3; num < min_t(int, dwc->num_eps, DWC3_ENDPOINTS_NUM);
-	     num += 2) {
+	for (num = 3; num < min_t(int, dwc->num_eps, DWC3_ENDPOINTS_NUM); num += 2) {
 		dep = dwc->eps[num];
+		if (!dep)
+			continue;
+
 		/* Don't change TXFRAMNUM on usb31 version */
 		size = DWC3_IP_IS(DWC3) ? 0 :
 			dwc3_readl(dwc->regs, DWC3_GTXFIFOSIZ(num >> 1)) &
@@ -3525,6 +3533,8 @@ static bool dwc3_gadget_endpoint_trbs_complete(struct dwc3_ep *dep,
 
 		for (i = 0; i < DWC3_ENDPOINTS_NUM; i++) {
 			dep = dwc->eps[i];
+			if (!dep)
+				continue;
 
 			if (!(dep->flags & DWC3_EP_ENABLED))
 				continue;
@@ -3713,6 +3723,10 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 	u8			epnum = event->endpoint_number;
 
 	dep = dwc->eps[epnum];
+	if (!dep) {
+		dev_warn(dwc->dev, "spurious event, endpoint %u is not allocated\n", epnum);
+		return;
+	}
 
 	if (!(dep->flags & DWC3_EP_ENABLED)) {
 		if ((epnum > 1) && !(dep->flags & DWC3_EP_TRANSFER_STARTED))
-- 
2.39.5


