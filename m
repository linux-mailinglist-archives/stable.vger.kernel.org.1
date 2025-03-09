Return-Path: <stable+bounces-121619-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53093A58818
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 21:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E84D3AA314
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 20:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5668160783;
	Sun,  9 Mar 2025 20:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="abZxByOU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972CF46426
	for <stable@vger.kernel.org>; Sun,  9 Mar 2025 20:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741551799; cv=none; b=arkuN1WQvz8rIAoyaqtnHgDspoIlhYkmuSoi60gERdjTduLHGY6KpQhunDO1WD367nZqjoqgVEW2MpzcgoeyuTiVWZH6EVFkZOBqXIQ+LgpKXt2fKKfeJsa5or07xXZ25/60j66BVECTVctMaIJ8kkXiX7w30Bs+ZARJU9DuRG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741551799; c=relaxed/simple;
	bh=xIhHIJj4fzDIjlSqyCbisPahszZUpVWHAy06odwxJQ4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=P0e6TWZiLpvKQVNsct2rxXohcfGOmiaSxeSFzbX89wuGxpPQf3FdyR8hKNIW641EhowkmL6rgGDZNDvjmcZe4nCeuxqBz73i9o4dW+UHMGzBAIqBYWbXKti41ll2w6vv5Y4ZDEeF/O1Ym6EBoTvBh6dK9mrqkeB5IuQUrCf2bfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=abZxByOU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 201A4C4CEE3;
	Sun,  9 Mar 2025 20:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741551799;
	bh=xIhHIJj4fzDIjlSqyCbisPahszZUpVWHAy06odwxJQ4=;
	h=Subject:To:Cc:From:Date:From;
	b=abZxByOU6Pa3I3U9giDfCJmOaLgx9unL08BQJFiiu/+HruB+3rh2DH6t1R8e3NlW3
	 N4ivqby0hqGxlqRRc4Ju+nOHqPrB9GnDlLquKvhk8ISin38EQ+kFpwIE3j5MpKJUGg
	 dwGFbPtYzCh2xvhFn64L1o3T02ms3c46opZ2bZlY=
Subject: FAILED: patch "[PATCH] usb: dwc3: gadget: Prevent irq storm when TH re-executes" failed to apply to 5.10-stable tree
To: badhri@google.com,Thinh.Nguyen@synopsys.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 09 Mar 2025 21:23:16 +0100
Message-ID: <2025030916-expenses-extended-20cc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 69c58deec19628c8a686030102176484eb94fed4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025030916-expenses-extended-20cc@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 69c58deec19628c8a686030102176484eb94fed4 Mon Sep 17 00:00:00 2001
From: Badhri Jagan Sridharan <badhri@google.com>
Date: Sun, 16 Feb 2025 22:30:02 +0000
Subject: [PATCH] usb: dwc3: gadget: Prevent irq storm when TH re-executes

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

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index dfa1b5fe48dc..2c472cb97f6c 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1835,8 +1835,6 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	dwc->tx_thr_num_pkt_prd = tx_thr_num_pkt_prd;
 	dwc->tx_max_burst_prd = tx_max_burst_prd;
 
-	dwc->imod_interval = 0;
-
 	dwc->tx_fifo_resize_max_num = tx_fifo_resize_max_num;
 }
 
@@ -1854,21 +1852,19 @@ static void dwc3_check_params(struct dwc3 *dwc)
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
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index ddd6b2ce5710..89a4dc8ebf94 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -4501,14 +4501,18 @@ static irqreturn_t dwc3_process_event_buf(struct dwc3_event_buffer *evt)
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
 


