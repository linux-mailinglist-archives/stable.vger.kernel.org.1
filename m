Return-Path: <stable+bounces-9772-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 035418250CE
	for <lists+stable@lfdr.de>; Fri,  5 Jan 2024 10:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D70D286336
	for <lists+stable@lfdr.de>; Fri,  5 Jan 2024 09:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31B822F17;
	Fri,  5 Jan 2024 09:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RGuwVmRv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7B23C3F
	for <stable@vger.kernel.org>; Fri,  5 Jan 2024 09:24:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F43BC433C7;
	Fri,  5 Jan 2024 09:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704446648;
	bh=kLrwZLtHqqdGr7ptPviCsOkopYfFB+Lhv31VQV7BNnA=;
	h=Subject:To:From:Date:From;
	b=RGuwVmRv46hp8DiyEoxf8EfwHsiSQUAbMpyQibF15XqyUwymwOMQappDu/Rmg5lcG
	 yjxee1Mldosw2m96GE982VqMU3E9tudTHetf2dz4UQGI0NjIo1UGYxlTQEpNGCV6/A
	 At6vQXEJxkaeng+3WiqCFufiR4mSsoZs83OcOGFk=
Subject: patch "usb: dwc3: gadget: Queue PM runtime idle on disconnect event" added to usb-next
To: quic_wcheng@quicinc.com,gregkh@linuxfoundation.org,stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Fri, 05 Jan 2024 10:22:07 +0100
Message-ID: <2024010507-catalyst-chase-4f87@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    usb: dwc3: gadget: Queue PM runtime idle on disconnect event

to my usb git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
in the usb-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From 3c7af52c7616c3aa6dacd2336ec748d4a65df8f4 Mon Sep 17 00:00:00 2001
From: Wesley Cheng <quic_wcheng@quicinc.com>
Date: Wed, 3 Jan 2024 13:49:46 -0800
Subject: usb: dwc3: gadget: Queue PM runtime idle on disconnect event

There is a scenario where DWC3 runtime suspend is blocked due to the
dwc->connected flag still being true while PM usage_count is zero after
DWC3 giveback is completed and the USB gadget session is being terminated.
This leads to a case where nothing schedules a PM runtime idle for the
device.

The exact condition is seen with the following sequence:
  1.  USB bus reset is issued by the host
  2.  Shortly after, or concurrently, a USB PD DR SWAP request is received
      (sink->source)
  3.  USB bus reset event handler runs and issues
      dwc3_stop_active_transfers(), and pending transfer are stopped
  4.  DWC3 usage_count decremented to 0, and runtime idle occurs while
      dwc->connected == true, returns -EBUSY
  5.  DWC3 disconnect event seen, dwc->connected set to false due to DR
      swap handling
  6.  No runtime idle after this point

Address this by issuing an asynchronous PM runtime idle call after the
disconnect event is completed, as it modifies the dwc->connected flag,
which is what blocks the initial runtime idle.

Fixes: fc8bb91bc83e ("usb: dwc3: implement runtime PM")
Cc:  <stable@vger.kernel.org>
Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
Link: https://lore.kernel.org/r/20240103214946.2596-1-quic_wcheng@quicinc.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc3/gadget.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index c15e965ea95a..019368f8e9c4 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -3989,6 +3989,13 @@ static void dwc3_gadget_disconnect_interrupt(struct dwc3 *dwc)
 	usb_gadget_set_state(dwc->gadget, USB_STATE_NOTATTACHED);
 
 	dwc3_ep0_reset_state(dwc);
+
+	/*
+	 * Request PM idle to address condition where usage count is
+	 * already decremented to zero, but waiting for the disconnect
+	 * interrupt to set dwc->connected to FALSE.
+	 */
+	pm_request_idle(dwc->dev);
 }
 
 static void dwc3_gadget_reset_interrupt(struct dwc3 *dwc)
-- 
2.43.0



