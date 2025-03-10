Return-Path: <stable+bounces-122191-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 329F1A59E49
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD524188ACD1
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A81823099F;
	Mon, 10 Mar 2025 17:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PAr6Tr/R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3766822B8BD;
	Mon, 10 Mar 2025 17:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741627787; cv=none; b=BoDh3VCXz+/rLP8oOuspeXTN6jNr3E814wgi7sT1NCJoltRFzBAAEstaBJzxE+H8EUOU4lfmOGH2LEJ5xoZ2TYZzI7rJfxFS0NPVLIv8Z9m32xJPWyOzk5NfgajNgTdKJiIAuKtbmsVio8Zn2TLjfrXT0O4u6e2q0DaDJJmC+Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741627787; c=relaxed/simple;
	bh=dCN/CHfPFu2bMYNmYac36P39762K0phKIQ9Ja/FXWak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hiynww2qp00Nl/qD0OXUqtb9Mk4ZW+4IIvvPpAt4vM8lteCtDZlUBFM6fkWmIh8aV+hhQsMBAQgINOkK/cw6dRg//R+043UHZh3Xat3c9Fzpg/EZEdpLpohH/R1mmP4/iLLebb0NEVxptwmhELxPR/gxVXuYKvN2NiCetoDEk9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PAr6Tr/R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53233C4CEE5;
	Mon, 10 Mar 2025 17:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741627786;
	bh=dCN/CHfPFu2bMYNmYac36P39762K0phKIQ9Ja/FXWak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PAr6Tr/RQrV08/WaEHZP0hTb3qH9xKnVCnOpfsh927bAYPTCHSkveZCbctMB1GxBq
	 FuMFnHrsBVN3E5pUJ0WyIcC2eSDA/S/HGjuNxg6M+M2FGCzcSHRH7/XLkkmGUcbf0B
	 21OohFcV5TMpGqyCCOCDmGqG+lX/E0+KZNTQC4DY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Badhri Jagan Sridharan <badhri@google.com>
Subject: [PATCH 6.12 217/269] usb: dwc3: gadget: Prevent irq storm when TH re-executes
Date: Mon, 10 Mar 2025 18:06:10 +0100
Message-ID: <20250310170506.337203966@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170457.700086763@linuxfoundation.org>
References: <20250310170457.700086763@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Badhri Jagan Sridharan <badhri@google.com>

commit 69c58deec19628c8a686030102176484eb94fed4 upstream.

While commit d325a1de49d6 ("usb: dwc3: gadget: Prevent losing events in
event cache") makes sure that top half(TH) does not end up overwriting the
cached events before processing them when the TH gets invoked more than one
time, returning IRQ_HANDLED results in occasional irq storm where the TH
hogs the CPU. The irq storm can be prevented by the flag before event
handler busy is cleared. Default enable interrupt moderation in all
versions which support them.

ftrace event stub during dwc3 irq storm:
    irq/504_dwc3-1111  ( 1111) [000] .... 70.000866: irq_handler_exit: irq=14 ret=handled
    irq/504_dwc3-1111  ( 1111) [000] .... 70.000872: irq_handler_entry: irq=504 name=dwc3
    irq/504_dwc3-1111  ( 1111) [000] .... 70.000874: irq_handler_exit: irq=504 ret=handled
    irq/504_dwc3-1111  ( 1111) [000] .... 70.000881: irq_handler_entry: irq=504 name=dwc3
    irq/504_dwc3-1111  ( 1111) [000] .... 70.000883: irq_handler_exit: irq=504 ret=handled
    irq/504_dwc3-1111  ( 1111) [000] .... 70.000889: irq_handler_entry: irq=504 name=dwc3
    irq/504_dwc3-1111  ( 1111) [000] .... 70.000892: irq_handler_exit: irq=504 ret=handled
    irq/504_dwc3-1111  ( 1111) [000] .... 70.000898: irq_handler_entry: irq=504 name=dwc3
    irq/504_dwc3-1111  ( 1111) [000] .... 70.000901: irq_handler_exit: irq=504 ret=handled
    irq/504_dwc3-1111  ( 1111) [000] .... 70.000907: irq_handler_entry: irq=504 name=dwc3
    irq/504_dwc3-1111  ( 1111) [000] .... 70.000909: irq_handler_exit: irq=504 ret=handled
    irq/504_dwc3-1111  ( 1111) [000] .... 70.000915: irq_handler_entry: irq=504 name=dwc3
    irq/504_dwc3-1111  ( 1111) [000] .... 70.000918: irq_handler_exit: irq=504 ret=handled
    irq/504_dwc3-1111  ( 1111) [000] .... 70.000924: irq_handler_entry: irq=504 name=dwc3
    irq/504_dwc3-1111  ( 1111) [000] .... 70.000927: irq_handler_exit: irq=504 ret=handled
    irq/504_dwc3-1111  ( 1111) [000] .... 70.000933: irq_handler_entry: irq=504 name=dwc3
    irq/504_dwc3-1111  ( 1111) [000] .... 70.000935: irq_handler_exit: irq=504 ret=handled
    ....

Cc: stable <stable@kernel.org>
Suggested-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Fixes: d325a1de49d6 ("usb: dwc3: gadget: Prevent losing events in event cache")
Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://lore.kernel.org/r/20250216223003.3568039-1-badhri@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc3/core.c   |   16 ++++++----------
 drivers/usb/dwc3/gadget.c |   10 +++++++---
 2 files changed, 13 insertions(+), 13 deletions(-)

--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1826,8 +1826,6 @@ static void dwc3_get_properties(struct d
 	dwc->tx_thr_num_pkt_prd = tx_thr_num_pkt_prd;
 	dwc->tx_max_burst_prd = tx_max_burst_prd;
 
-	dwc->imod_interval = 0;
-
 	dwc->tx_fifo_resize_max_num = tx_fifo_resize_max_num;
 }
 
@@ -1845,21 +1843,19 @@ static void dwc3_check_params(struct dwc
 	unsigned int hwparam_gen =
 		DWC3_GHWPARAMS3_SSPHY_IFC(dwc->hwparams.hwparams3);
 
-	/* Check for proper value of imod_interval */
-	if (dwc->imod_interval && !dwc3_has_imod(dwc)) {
-		dev_warn(dwc->dev, "Interrupt moderation not supported\n");
-		dwc->imod_interval = 0;
-	}
-
 	/*
+	 * Enable IMOD for all supporting controllers.
+	 *
+	 * Particularly, DWC_usb3 v3.00a must enable this feature for
+	 * the following reason:
+	 *
 	 * Workaround for STAR 9000961433 which affects only version
 	 * 3.00a of the DWC_usb3 core. This prevents the controller
 	 * interrupt from being masked while handling events. IMOD
 	 * allows us to work around this issue. Enable it for the
 	 * affected version.
 	 */
-	if (!dwc->imod_interval &&
-	    DWC3_VER_IS(DWC3, 300A))
+	if (dwc3_has_imod((dwc)))
 		dwc->imod_interval = 1;
 
 	/* Check the maximum_speed parameter */
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -4507,14 +4507,18 @@ static irqreturn_t dwc3_process_event_bu
 	dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0),
 		    DWC3_GEVNTSIZ_SIZE(evt->length));
 
+	evt->flags &= ~DWC3_EVENT_PENDING;
+	/*
+	 * Add an explicit write memory barrier to make sure that the update of
+	 * clearing DWC3_EVENT_PENDING is observed in dwc3_check_event_buf()
+	 */
+	wmb();
+
 	if (dwc->imod_interval) {
 		dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), DWC3_GEVNTCOUNT_EHB);
 		dwc3_writel(dwc->regs, DWC3_DEV_IMOD(0), dwc->imod_interval);
 	}
 
-	/* Keep the clearing of DWC3_EVENT_PENDING at the end */
-	evt->flags &= ~DWC3_EVENT_PENDING;
-
 	return ret;
 }
 



