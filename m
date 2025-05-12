Return-Path: <stable+bounces-143958-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D393AAB4371
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 20:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7A8F7BB00A
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 18:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B08D29A337;
	Mon, 12 May 2025 18:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WVommQoR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F3C2980C5;
	Mon, 12 May 2025 18:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073419; cv=none; b=C6z+HwsnHzVkWV5KVF0pBKJoHRx685EC/dDev7uRkhuFik8S4OwZ7CCNZI4cCRFxL+BmwSwB6WrjnCBakRAL6c9u2sZvJaz/ICeWrYkbK/qWPgdanH4vemlbmQl9vqSzuMSQJNEXj1xsixbo+2bt+tFFqhuFwTXP1tvY5Nq7T4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073419; c=relaxed/simple;
	bh=bsgytnYn4ZanvM07XKl92fD5P21k5asvHXMa3dK9JiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DxXYB2+OF2guNv3/mKD0ZfDcLW0sEMxyGIfV7/D8ah38Z7THBuImLB7qzXgFPWtF+6FmkmPCbJhIwm6bTrREjmignWrowXHwpNJwMFrVvOz2pnsvJ8NVJ0Ct+HehKBQb2LF7cEL4kx0YHvxEURpOjTtUEbxF8jJuhtjlaG7Uqps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WVommQoR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6808AC4CEE7;
	Mon, 12 May 2025 18:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747073418;
	bh=bsgytnYn4ZanvM07XKl92fD5P21k5asvHXMa3dK9JiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WVommQoRrhipmEgazwsja1YOX1FAwWCi9pty7GWwSPb731DmnUIUo20t5C8jXnGMW
	 iRCl9n++3CNhbMh0dAwuvekh6M45RwOFVhtLU/dbIKKSKelT36wKMNg6ezE5yMm0WP
	 jydnncjT7knp7yDZ4tu+WEv10qCc6stq71Vyy63c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Pawel Laszczak <pawell@cadence.com>,
	Peter Chen <peter.chen@kernel.org>
Subject: [PATCH 6.6 068/113] usb: cdnsp: fix L1 resume issue for RTL_REVISION_NEW_LPM version
Date: Mon, 12 May 2025 19:45:57 +0200
Message-ID: <20250512172030.449321607@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512172027.691520737@linuxfoundation.org>
References: <20250512172027.691520737@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pawel Laszczak <pawell@cadence.com>

commit 8614ecdb1570e4fffe87ebdc62b613ed66f1f6a6 upstream.

The controllers with rtl version larger than
RTL_REVISION_NEW_LPM (0x00002700) has bug which causes that controller
doesn't resume from L1 state. It happens if after receiving LPM packet
controller starts transitioning to L1 and in this moment the driver force
resuming by write operation to PORTSC.PLS.
It's corner case and happens when write operation to PORTSC occurs during
device delay before transitioning to L1 after transmitting ACK
time (TL1TokenRetry).

Forcing transition from L1->L0 by driver for revision larger than
RTL_REVISION_NEW_LPM is not needed, so driver can simply fix this issue
through block call of cdnsp_force_l0_go function.

Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
Cc: stable <stable@kernel.org>
Signed-off-by: Pawel Laszczak <pawell@cadence.com>
Acked-by: Peter Chen <peter.chen@kernel.org>
Link: https://lore.kernel.org/r/PH7PR07MB9538B55C3A6E71F9ED29E980DD842@PH7PR07MB9538.namprd07.prod.outlook.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/cdns3/cdnsp-gadget.c |    2 ++
 drivers/usb/cdns3/cdnsp-gadget.h |    3 +++
 drivers/usb/cdns3/cdnsp-ring.c   |    3 ++-
 3 files changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/usb/cdns3/cdnsp-gadget.c
+++ b/drivers/usb/cdns3/cdnsp-gadget.c
@@ -1796,6 +1796,8 @@ static void cdnsp_get_rev_cap(struct cdn
 	reg += cdnsp_find_next_ext_cap(reg, 0, RTL_REV_CAP);
 	pdev->rev_cap  = reg;
 
+	pdev->rtl_revision = readl(&pdev->rev_cap->rtl_revision);
+
 	dev_info(pdev->dev, "Rev: %08x/%08x, eps: %08x, buff: %08x/%08x\n",
 		 readl(&pdev->rev_cap->ctrl_revision),
 		 readl(&pdev->rev_cap->rtl_revision),
--- a/drivers/usb/cdns3/cdnsp-gadget.h
+++ b/drivers/usb/cdns3/cdnsp-gadget.h
@@ -1362,6 +1362,7 @@ struct cdnsp_port {
  * @rev_cap: Controller Capabilities Registers.
  * @hcs_params1: Cached register copies of read-only HCSPARAMS1
  * @hcc_params: Cached register copies of read-only HCCPARAMS1
+ * @rtl_revision: Cached controller rtl revision.
  * @setup: Temporary buffer for setup packet.
  * @ep0_preq: Internal allocated request used during enumeration.
  * @ep0_stage: ep0 stage during enumeration process.
@@ -1416,6 +1417,8 @@ struct cdnsp_device {
 	__u32 hcs_params1;
 	__u32 hcs_params3;
 	__u32 hcc_params;
+	#define RTL_REVISION_NEW_LPM 0x2700
+	__u32 rtl_revision;
 	/* Lock used in interrupt thread context. */
 	spinlock_t lock;
 	struct usb_ctrlrequest setup;
--- a/drivers/usb/cdns3/cdnsp-ring.c
+++ b/drivers/usb/cdns3/cdnsp-ring.c
@@ -308,7 +308,8 @@ static bool cdnsp_ring_ep_doorbell(struc
 
 	writel(db_value, reg_addr);
 
-	cdnsp_force_l0_go(pdev);
+	if (pdev->rtl_revision < RTL_REVISION_NEW_LPM)
+		cdnsp_force_l0_go(pdev);
 
 	/* Doorbell was set. */
 	return true;



