Return-Path: <stable+bounces-70082-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F259595DBD1
	for <lists+stable@lfdr.de>; Sat, 24 Aug 2024 07:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A016C1F232D5
	for <lists+stable@lfdr.de>; Sat, 24 Aug 2024 05:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDCD14AD20;
	Sat, 24 Aug 2024 05:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wo0yCwjO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF9514A611
	for <stable@vger.kernel.org>; Sat, 24 Aug 2024 05:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724476681; cv=none; b=J6WZ4dPr9ItE2tZhZFCra/28xSWx7mX06XPWsljf3PGLKp2an/p8cHU9Vb/Wgpw8CWoXK3XYvzcN7TjnfxBJ1ewMxrYsBwx+6oWtWQrC+Maq6bq515PTBv6UlydFTW4VEMzG+LvPICBoomSSysT26GdOKUqLqA8D4LupcMLfmeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724476681; c=relaxed/simple;
	bh=XGa3pEzrbeAQxMX0O98B1xcADQ8TahnnoP36TzKFTUA=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=AdEZARRJnzNFhEz+kYKToEt93QCIRWkln5p51FAJTjQsqm6FE8fO+GCQ4qlawDFGWo9ByXtjffBxgFFmiVo8una08C4rQJSiNgLTkkTErKKOY5BrU4Kuqz/FQ0QHZ4EACJT9g62I14sFFUaQm5o9ZlPfwoT8MMcKliuPyuc/wWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wo0yCwjO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75DF3C32781;
	Sat, 24 Aug 2024 05:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724476680;
	bh=XGa3pEzrbeAQxMX0O98B1xcADQ8TahnnoP36TzKFTUA=;
	h=Subject:To:From:Date:From;
	b=wo0yCwjOHJW97xTorIwls0pmu5dslxsRXbsJ5JWuxJBPll59zEeqJ3A5ZveHbtPJ8
	 Ii/5KjosQHuW1Zh3NujQt3i00ycJvpXLaXzAkU/adadLlv2iOre0kkHdpj/vlBgSNN
	 HRdto0OZTM5OSwSCqJeHv+aWuudxJgIaRcA1SzJY=
Subject: patch "usb: cdnsp: fix for Link TRB with TC" added to usb-linus
To: pawell@cadence.com,gregkh@linuxfoundation.org,peter.chen@kernel.org,stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Sat, 24 Aug 2024 10:08:56 +0800
Message-ID: <2024082456-jockstrap-dipped-26ac@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    usb: cdnsp: fix for Link TRB with TC

to my usb git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
in the usb-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 740f2e2791b98e47288b3814c83a3f566518fed2 Mon Sep 17 00:00:00 2001
From: Pawel Laszczak <pawell@cadence.com>
Date: Wed, 21 Aug 2024 06:07:42 +0000
Subject: usb: cdnsp: fix for Link TRB with TC

Stop Endpoint command on LINK TRB with TC bit set to 1 causes that
internal cycle bit can have incorrect state after command complete.
In consequence empty transfer ring can be incorrectly detected
when EP is resumed.
NOP TRB before LINK TRB avoid such scenario. Stop Endpoint command
is then on NOP TRB and internal cycle bit is not changed and have
correct value.

Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
cc: <stable@vger.kernel.org>
Signed-off-by: Pawel Laszczak <pawell@cadence.com>
Reviewed-by: Peter Chen <peter.chen@kernel.org>
Link: https://lore.kernel.org/r/PH7PR07MB953878279F375CCCE6C6F40FDD8E2@PH7PR07MB9538.namprd07.prod.outlook.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/cdns3/cdnsp-gadget.h |  3 +++
 drivers/usb/cdns3/cdnsp-ring.c   | 28 ++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/usb/cdns3/cdnsp-gadget.h b/drivers/usb/cdns3/cdnsp-gadget.h
index dbee6f085277..84887dfea763 100644
--- a/drivers/usb/cdns3/cdnsp-gadget.h
+++ b/drivers/usb/cdns3/cdnsp-gadget.h
@@ -811,6 +811,7 @@ struct cdnsp_stream_info {
  *        generate Missed Service Error Event.
  *        Set skip flag when receive a Missed Service Error Event and
  *        process the missed tds on the endpoint ring.
+ * @wa1_nop_trb: hold pointer to NOP trb.
  */
 struct cdnsp_ep {
 	struct usb_ep endpoint;
@@ -838,6 +839,8 @@ struct cdnsp_ep {
 #define EP_UNCONFIGURED		BIT(7)
 
 	bool skip;
+	union cdnsp_trb	 *wa1_nop_trb;
+
 };
 
 /**
diff --git a/drivers/usb/cdns3/cdnsp-ring.c b/drivers/usb/cdns3/cdnsp-ring.c
index a60c0cb991cd..dbd83d321bca 100644
--- a/drivers/usb/cdns3/cdnsp-ring.c
+++ b/drivers/usb/cdns3/cdnsp-ring.c
@@ -1904,6 +1904,23 @@ int cdnsp_queue_bulk_tx(struct cdnsp_device *pdev, struct cdnsp_request *preq)
 	if (ret)
 		return ret;
 
+	/*
+	 * workaround 1: STOP EP command on LINK TRB with TC bit set to 1
+	 * causes that internal cycle bit can have incorrect state after
+	 * command complete. In consequence empty transfer ring can be
+	 * incorrectly detected when EP is resumed.
+	 * NOP TRB before LINK TRB avoid such scenario. STOP EP command is
+	 * then on NOP TRB and internal cycle bit is not changed and have
+	 * correct value.
+	 */
+	if (pep->wa1_nop_trb) {
+		field = le32_to_cpu(pep->wa1_nop_trb->trans_event.flags);
+		field ^= TRB_CYCLE;
+
+		pep->wa1_nop_trb->trans_event.flags = cpu_to_le32(field);
+		pep->wa1_nop_trb = NULL;
+	}
+
 	/*
 	 * Don't give the first TRB to the hardware (by toggling the cycle bit)
 	 * until we've finished creating all the other TRBs. The ring's cycle
@@ -1999,6 +2016,17 @@ int cdnsp_queue_bulk_tx(struct cdnsp_device *pdev, struct cdnsp_request *preq)
 		send_addr = addr;
 	}
 
+	if (cdnsp_trb_is_link(ring->enqueue + 1)) {
+		field = TRB_TYPE(TRB_TR_NOOP) | TRB_IOC;
+		if (!ring->cycle_state)
+			field |= TRB_CYCLE;
+
+		pep->wa1_nop_trb = ring->enqueue;
+
+		cdnsp_queue_trb(pdev, ring, 0, 0x0, 0x0,
+				TRB_INTR_TARGET(0), field);
+	}
+
 	cdnsp_check_trb_math(preq, enqd_len);
 	ret = cdnsp_giveback_first_trb(pdev, pep, preq->request.stream_id,
 				       start_cycle, start_trb);
-- 
2.46.0



