Return-Path: <stable+bounces-195269-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E03D1C73EE1
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 13:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 0940F30661
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 12:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F31333732;
	Thu, 20 Nov 2025 12:14:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [207.226.244.123])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAED233290F
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 12:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.226.244.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763640897; cv=none; b=QzJFzZDVVWn68lPzFxCtVaWjTFTed3v5sQdg9Du/8ipdE4RJetQvV9JhPV7uoBesy++II5NG0tYayPK2w89XUjvWUiVvNrISfY+LQGdTbhWszx8AXNjNzOQw+78pgG0NyllPGjrS8RAHkT/dYr86d6VMrqCGkymQ1Gm3yyF0BkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763640897; c=relaxed/simple;
	bh=uASkiBThjg0+2aydI15+rppeNYNlJb+ZepyqZt3ACiI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Be9fTlTHhmwxB+ryuFNkgO/0M3Wc34idW2UtvwKfgQOofIB9fY48+Znj4xcJeUcisjufxbkLFnUvLAGb3mwqxam1QXnUHCr91LFFP2pmuES0fZyJ9X6Q6uKemOMba+krkF9SHH0Vivw07KwmEg30xUCA0D72CiMnKCJ7JEK+0RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=xiaomi.com; arc=none smtp.client-ip=207.226.244.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.com
X-CSE-ConnectionGUID: xIPD5yrJRPqGe14saw1uyA==
X-CSE-MsgGUID: 2GWyIMy3QkW+wIGDW4LRlQ==
X-IronPort-AV: E=Sophos;i="6.20,213,1758556800"; 
   d="scan'208";a="158951715"
From: guhuinan <guhuinan@xiaomi.com>
To: chenyu <chenyu45@xiaomi.com>
CC: Owen Gu <guhuinan@xiaomi.com>, <stable@vger.kernel.org>, Oliver Neukum
	<oneukum@suse.com>
Subject: [PATCH v4] usb: uas: fix urb unmapping issue when the uas device is remove during ongoing data transfer
Date: Thu, 20 Nov 2025 20:13:27 +0800
Message-ID: <20251120121327.3233-1-guhuinan@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJ-MBX17.mioffice.cn (10.237.8.137) To BJ-MBX05.mioffice.cn
 (10.237.8.125)

From: Owen Gu <guhuinan@xiaomi.com>

When a UAS device is unplugged during data transfer, there is
a probability of a system panic occurring. The root cause is
an access to an invalid memory address during URB callback handling.
Specifically, this happens when the dma_direct_unmap_sg() function
is called within the usb_hcd_unmap_urb_for_dma() interface, but the
sg->dma_address field is 0 and the sg data structure has already been
freed.

The SCSI driver sends transfer commands by invoking uas_queuecommand_lck()
in uas.c, using the uas_submit_urbs() function to submit requests to USB.
Within the uas_submit_urbs() implementation, three URBs (sense_urb,
data_urb, and cmd_urb) are sequentially submitted. Device removal may
occur at any point during uas_submit_urbs execution, which may result
in URB submission failure. However, some URBs might have been successfully
submitted before the failure, and uas_submit_urbs will return the -ENODEV
error code in this case. The current error handling directly calls
scsi_done(). In the SCSI driver, this eventually triggers scsi_complete()
to invoke scsi_end_request() for releasing the sgtable. The successfully
submitted URBs, when being unlinked to giveback, call
usb_hcd_unmap_urb_for_dma() in hcd.c, leading to exceptions during sg
unmapping operations since the sg data structure has already been freed.

This patch modifies the error condition check in the uas_submit_urbs()
function. When a UAS device is removed but one or more URBs have already
been successfully submitted to USB, it avoids immediately invoking
scsi_done() and save the cmnd to devinfo->cmnd array. If the successfully
submitted URBs is completed before devinfo->resetting being set, then
the scsi_done() function will be called within uas_try_complete() after
all pending URB operations are finalized. Otherwise, the scsi_done()
function will be called within uas_zap_pending(), which is executed after
usb_kill_anchored_urbs().

The error handling only takes effect when uas_queuecommand_lck() calls
uas_submit_urbs() and returns the error value -ENODEV . In this case,
the device is disconnected, and the flow proceeds to uas_disconnect(),
where uas_zap_pending() is invoked to call uas_try_complete().

Fixes: eb2a86ae8c54 ("USB: UAS: fix disconnect by unplugging a hub")
Cc: stable@vger.kernel.org
Signed-off-by: Yu Chen <chenyu45@xiaomi.com>
Signed-off-by: Owen Gu <guhuinan@xiaomi.com>
Acked-by: Oliver Neukum <oneukum@suse.com>
---
v4: Add the fix tag, cc stable and acked-by tag
v3: Add some commit message.
v2: Upon uas_submit_urbs() returning -ENODEV despite successful URB
submission, the cmnd is added to the devinfo->cmnd array before
exiting uas_queuecommand_lck().
https://lore.kernel.org/linux-usb/20251015153157.11870-1-guhuinan@xiaomi.com/
v1: https://lore.kernel.org/linux-usb/20250930045309.21588-1-guhuinan@xiaomi.com/
---
---
 drivers/usb/storage/uas.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/storage/uas.c b/drivers/usb/storage/uas.c
index 03043d567fa1..02fe411567fa 100644
--- a/drivers/usb/storage/uas.c
+++ b/drivers/usb/storage/uas.c
@@ -698,6 +698,10 @@ static int uas_queuecommand_lck(struct scsi_cmnd *cmnd)
 	 * of queueing, no matter how fatal the error
 	 */
 	if (err == -ENODEV) {
+		if (cmdinfo->state & (COMMAND_INFLIGHT | DATA_IN_URB_INFLIGHT |
+				DATA_OUT_URB_INFLIGHT))
+			goto out;
+
 		set_host_byte(cmnd, DID_NO_CONNECT);
 		scsi_done(cmnd);
 		goto zombie;
@@ -711,6 +715,7 @@ static int uas_queuecommand_lck(struct scsi_cmnd *cmnd)
 		uas_add_work(cmnd);
 	}
 
+out:
 	devinfo->cmnd[idx] = cmnd;
 zombie:
 	spin_unlock_irqrestore(&devinfo->lock, flags);
-- 
2.43.0


