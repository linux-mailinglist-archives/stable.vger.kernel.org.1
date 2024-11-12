Return-Path: <stable+bounces-92544-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4DE9C563C
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 12:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A46BFB3CF3A
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 10:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF57722B390;
	Tue, 12 Nov 2024 10:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LOiv6vPd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0D822B38B;
	Tue, 12 Nov 2024 10:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407864; cv=none; b=YOA+lgbzLaCmuzuDFyQ3tt3F82N7o5DkAA5ddNRN0TTo+2IuhweAcOTEl6Mzvq0JslV0wagaXot8IvyKBN0tbXvNCEJX+tYN2LX+hJKjk44L/ZCn802d4FvZT9Bch1F+yj/aEUKHNh9sgydmdrvH2nEsJhZ7PN3j7rtJuqrCYb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407864; c=relaxed/simple;
	bh=EfReWBh7h9jKmgxsv5bpsa+U2VmGlTQ+N+mLgnmaU6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=usGeXrg02Vjy46mrD1h51tpKb+UPdedMzodSYbhmTSa99pJY1fsxNjmIii8wJ+frqxhNugXT5XoYZnLIAArvL4/9lK4FeagURxEnst7V4t7NkKBfMTEAP4nAB9ERgo0jGPoqp2RdIExggVFWNXL7UY9+N+nUzArqxsd+JlzMtX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LOiv6vPd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFCB1C4CECD;
	Tue, 12 Nov 2024 10:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731407864;
	bh=EfReWBh7h9jKmgxsv5bpsa+U2VmGlTQ+N+mLgnmaU6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LOiv6vPdmwOZ7Rx+Bv2WMEZk8csr9PXJkn8lWPggXbScrY+0dvHWrPSFA/8rrmnsT
	 ZiQWGYKtdKjcAkLH355U3sakNEezH6aRgHvQxLLslhCYT00Z07t0cTVX7dZvXRuk0h
	 k0HHTgAP9bFIoVGYBatgCeBxOGmSxBIbcOV8tWrQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	William McVicker <willmcvicker@google.com>,
	Roger Quadros <rogerq@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH 6.6 107/119] usb: dwc3: fix fault at system suspend if device was already runtime suspended
Date: Tue, 12 Nov 2024 11:21:55 +0100
Message-ID: <20241112101852.811240718@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112101848.708153352@linuxfoundation.org>
References: <20241112101848.708153352@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Roger Quadros <rogerq@kernel.org>

commit 9cfb31e4c89d200d8ab7cb1e0bb9e6e8d621ca0b upstream.

If the device was already runtime suspended then during system suspend
we cannot access the device registers else it will crash.

Also we cannot access any registers after dwc3_core_exit() on some
platforms so move the dwc3_enable_susphy() call to the top.

Cc: stable@vger.kernel.org # v5.15+
Reported-by: William McVicker <willmcvicker@google.com>
Closes: https://lore.kernel.org/all/ZyVfcUuPq56R2m1Y@google.com
Fixes: 705e3ce37bcc ("usb: dwc3: core: Fix system suspend on TI AM62 platforms")
Signed-off-by: Roger Quadros <rogerq@kernel.org>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Tested-by: Will McVicker <willmcvicker@google.com>
Link: https://lore.kernel.org/r/20241104-am62-lpm-usb-fix-v1-1-e93df73a4f0d@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc3/core.c |   25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -2106,10 +2106,18 @@ static int dwc3_suspend_common(struct dw
 {
 	u32 reg;
 
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
@@ -2158,15 +2166,6 @@ static int dwc3_suspend_common(struct dw
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
 



