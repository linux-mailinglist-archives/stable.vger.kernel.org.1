Return-Path: <stable+bounces-89704-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7989BB6F7
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 15:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2E6F284B93
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 14:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1936013B5B6;
	Mon,  4 Nov 2024 14:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UX5LDSX4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3721CF8B;
	Mon,  4 Nov 2024 14:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730728820; cv=none; b=EoCTmEP7QH8bbayLzgieOeyfyaxDUPQ9bWBimax/UUDzTIOC/dywB1vG28zWjrsmOrcUWzUGIDLDu1FD0YvZE6dLnVgacp1vNSqw9cKAqiWk0TVMknd837GPQubSYlTc6yD16NuU+REtrBL9o5UnaIiSp1W0sGiqZvztmQL2uRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730728820; c=relaxed/simple;
	bh=P1k0MUVMq1QqUtbiW9xLpMKx1OZ1yhgJFMtdzOL+cGQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IHfc65LNhJ5oF533hYGUoKeyP1W62qJUvSuehxXEnOCBgsDn9Dy8JL7Xr9eKh1NuJb2qCW59FHmWXlllcaqQ2SeSIHo8TvbyYTDBHOHRlqaYm37nKNtI9z8+tM8F/pNO3gLQqlLbkY6WQQBuZLDrEhNLA/pb8IbYxVHgrFGnhCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UX5LDSX4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42486C4CECE;
	Mon,  4 Nov 2024 14:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730728820;
	bh=P1k0MUVMq1QqUtbiW9xLpMKx1OZ1yhgJFMtdzOL+cGQ=;
	h=From:Date:Subject:To:Cc:From;
	b=UX5LDSX416ittxWJFLtIK3h56f2siL7MxHeSChZXP9Qgwq9nbSSSu7sZr22zxDe46
	 tbb6L7Kfk3hOGu/V7w07bldevkpsUSCi1MOHyEUFAjUpM6Ml2/SS2Q4lg4SGJBXgE2
	 gR0KLTDOW0OgbOA8kCRuGYn65ANrCO0im8qLV3uxxwc8NS55yGUdScn7ColA0oBmWo
	 kYyGPVzWqgDTb9eXFDMprWOKfGFsIE8xg7KP/LGRfmoqhATCvNkPYvkqbFO8cf8k79
	 d8wqtiwsxLhDC9X+/7wszbV+j+Ox+S4aoFeN64Ukoulmd6emJrZanEk0ysdObm8nYQ
	 df6g80HzIErPw==
From: Roger Quadros <rogerq@kernel.org>
Date: Mon, 04 Nov 2024 16:00:11 +0200
Subject: [PATCH] usb: dwc3: fix fault at system suspend if device was
 already runtime suspended
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241104-am62-lpm-usb-fix-v1-1-e93df73a4f0d@kernel.org>
X-B4-Tracking: v=1; b=H4sIAGrTKGcC/x2MSQqAMAwAvyI5G2hqXfAr4qHaqAE3WhSh+HeLx
 xmYiRDYCwdoswiebwly7Akoz2Bc7D4ziksMWmlDpDTardK4nhteYcBJHixM7VxTUVGOBCk7PSf
 9L7v+fT+6wuvMYgAAAA==
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dhruva Gole <d-gole@ti.com>, sashal@kernel.org, 
 William McVicker <willmcvicker@google.com>, 
 Chris Morgan <macroalpha82@gmail.com>
Cc: Vishal Mahaveer <vishalm@ti.com>, msp@baylibre.com, srk@ti.com, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2168; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=P1k0MUVMq1QqUtbiW9xLpMKx1OZ1yhgJFMtdzOL+cGQ=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBnKNNwkMQZtv8N51Zpfl0t+0+S1Q/Vqsv7isk4/
 LM0GMkE07CJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZyjTcAAKCRDSWmvTvnYw
 kwTFEACsBb0SZTJAsj7DWP3Ea2zc5LO6JpvWSA8jicrLPdp1JEYQUwf9yhvKod2c8Db/HhHwnva
 fXGwGJrDFHL/v7Z51nNqd+pwWRWanFJux7e1LvClsgG/8URpA24qnHDZsWaV+3/gDmgw+NeUHmJ
 02G/id7VO1StoYkZGyQmUZVxcJEZaKRP2iAzGXpv+iyaV3TA4fn1P10rchq3TzililZr2oH2VCG
 GOdKSf2bF/Ni1h35GptC//EkE0OQ/N6ykCMeABj1gEjUGJW1C6okJB+XYTx4HhPQGGrGGLzdIJw
 kLEE5QpEvzHmTgh/E4rsCuFSPBNIQJLRfhZ9kz/s+BmF9+n09+ZrMl0rU+bdFcVAMhXtUK0uoQn
 8a64bstTlTNdu5FFxsVwNlruwUsxRIdKdr8AKh9Kd7DMpquJUNnEp9bxVtWUWqpCDFtjN/dE3mR
 xcqvFfUS0g32OTROKX1lyvglvNrJya2DhwdHneNGIl1UwtaXF4ql0Yt976TqTM/esaCn1b86grS
 0L8/OoVGcdTxapmvmm9n0GjzrxwEKD6Exj2MvenXDo87QYxLJ5R3tmQsuqvQvurLRzn7uP/2QGx
 k85c82RPh/hvRG7UOL5KDlPqXl4IVV7z1Qf1rXU0RbqgoxT+B3za1OEg3Owr6OsGNca1Ijm9jeZ
 YIQHRfY6BMXB+fg==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

If the device was already runtime suspended then during system suspend
we cannot access the device registers else it will crash.

Also we cannot access any registers after dwc3_core_exit() on some
platforms so move the dwc3_enable_susphy() call to the top.

Cc: stable@vger.kernel.org # v5.15+
Reported-by: William McVicker <willmcvicker@google.com>
Closes: https://lore.kernel.org/all/ZyVfcUuPq56R2m1Y@google.com
Fixes: 705e3ce37bcc ("usb: dwc3: core: Fix system suspend on TI AM62 platforms")
Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/usb/dwc3/core.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 427e5660f87c..98114c2827c0 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -2342,10 +2342,18 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 	u32 reg;
 	int i;
 
-	dwc->susphy_state = (dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0)) &
-			    DWC3_GUSB2PHYCFG_SUSPHY) ||
-			    (dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0)) &
-			    DWC3_GUSB3PIPECTL_SUSPHY);
+	if (!pm_runtime_suspended(dwc->dev) && !PMSG_IS_AUTO(msg)) {
+		dwc->susphy_state = (dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0)) &
+				    DWC3_GUSB2PHYCFG_SUSPHY) ||
+				    (dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0)) &
+				    DWC3_GUSB3PIPECTL_SUSPHY);
+		/*
+		 * TI AM62 platform requires SUSPHY to be
+		 * enabled for system suspend to work.
+		 */
+		if (!dwc->susphy_state)
+			dwc3_enable_susphy(dwc, true);
+	}
 
 	switch (dwc->current_dr_role) {
 	case DWC3_GCTL_PRTCAP_DEVICE:
@@ -2398,15 +2406,6 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 		break;
 	}
 
-	if (!PMSG_IS_AUTO(msg)) {
-		/*
-		 * TI AM62 platform requires SUSPHY to be
-		 * enabled for system suspend to work.
-		 */
-		if (!dwc->susphy_state)
-			dwc3_enable_susphy(dwc, true);
-	}
-
 	return 0;
 }
 

---
base-commit: 42f7652d3eb527d03665b09edac47f85fb600924
change-id: 20241102-am62-lpm-usb-fix-347dd86135c1

Best regards,
-- 
Roger Quadros <rogerq@kernel.org>


