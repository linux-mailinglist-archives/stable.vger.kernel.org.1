Return-Path: <stable+bounces-198030-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B463FC99CAE
	for <lists+stable@lfdr.de>; Tue, 02 Dec 2025 02:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 68F614E220B
	for <lists+stable@lfdr.de>; Tue,  2 Dec 2025 01:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4422190664;
	Tue,  2 Dec 2025 01:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejJbUM4u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634B041C71
	for <stable@vger.kernel.org>; Tue,  2 Dec 2025 01:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764640131; cv=none; b=GUORNk2gb0dPEnmmA8CTa0jwIDiHp4GRQvaN9yBvQ71evnNj5W7lg7lFNUSvncFrIN6nwKlu6WMAFicC/c72TxHGSieLDNQz2dFWc7XVsFNwsQV0YjwBNHNiLkOIEqnCiJKip7wXjFyFuS6+yJP9qxPFFh6yrA2vMp+YHrCq1RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764640131; c=relaxed/simple;
	bh=fKaPZdm77gObvxEQRGwQh/hsRyckAr+k+oUIlTl23sk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eBNPBBplfqwUkPjP45MBjRbaWTBXnli8HmXiNFbMemJuUDkJF2KzQV7hRbY/BeZBO6tDyk4gA2XUP7Jc6UGbclPDYt6PZ/IO8zXVBsHJBMecPjHKBbgLW/9YFo7OQuwyUa/o5jh7rHH2gtlEUO43EjBvVdhU5LpUtVK1xgo5faM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejJbUM4u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A74E0C4CEF1;
	Tue,  2 Dec 2025 01:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764640129;
	bh=fKaPZdm77gObvxEQRGwQh/hsRyckAr+k+oUIlTl23sk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ejJbUM4uw4AprPi6gOY93ajK/loeiEvoWYOLR+919E7tA3bTk9tZG7MP7PFNgC5xw
	 hVf9Xl9deVK+p8HixuTY+ZWihhkVb7S4kq//4d+JdVCZGYxCnFNK2Ii5f6bCT9Lzhg
	 xCCAZkMrAnXipOVhKrdGzk//Ui0qSNWdvH5jQ8+c/4jgwH+M03iuxoAmmVr4/9qAxz
	 E3kAlCRN1IXCuICvnwc+vtIqu0Wwd/ABcKFBtpGJvoUsW8AiucMR9tS2Ragxbnvko5
	 s4aWI0WGuwkutAqksve9d7wFOOw7S1Iu407q51TAOlD9CZwLImeVyAkrwWML5S3ZkK
	 /F6Z43/qnmqvQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Owen Gu <guhuinan@xiaomi.com>,
	stable <stable@kernel.org>,
	Yu Chen <chenyu45@xiaomi.com>,
	Oliver Neukum <oneukum@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] usb: uas: fix urb unmapping issue when the uas device is remove during ongoing data transfer
Date: Mon,  1 Dec 2025 20:48:40 -0500
Message-ID: <20251202014840.1603338-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025120132-patio-vocation-ff6a@gregkh>
References: <2025120132-patio-vocation-ff6a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Owen Gu <guhuinan@xiaomi.com>

[ Upstream commit 26d56a9fcb2014b99e654127960aa0a48a391e3c ]

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
Cc: stable <stable@kernel.org>
Signed-off-by: Yu Chen <chenyu45@xiaomi.com>
Signed-off-by: Owen Gu <guhuinan@xiaomi.com>
Acked-by: Oliver Neukum <oneukum@suse.com>
Link: https://patch.msgid.link/20251120123336.3328-1-guhuinan@xiaomi.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ adapted scsi_done(cmnd) helper to older cmnd->scsi_done(cmnd) callback API ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/storage/uas.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/storage/uas.c b/drivers/usb/storage/uas.c
index ea1680c4cc065..eab64154e8697 100644
--- a/drivers/usb/storage/uas.c
+++ b/drivers/usb/storage/uas.c
@@ -705,7 +705,11 @@ static int uas_queuecommand_lck(struct scsi_cmnd *cmnd,
 	 * of queueing, no matter how fatal the error
 	 */
 	if (err == -ENODEV) {
-		set_host_byte(cmnd, DID_ERROR);
+		if (cmdinfo->state & (COMMAND_INFLIGHT | DATA_IN_URB_INFLIGHT |
+				DATA_OUT_URB_INFLIGHT))
+			goto out;
+
+		set_host_byte(cmnd, DID_NO_CONNECT);
 		cmnd->scsi_done(cmnd);
 		goto zombie;
 	}
@@ -718,6 +722,7 @@ static int uas_queuecommand_lck(struct scsi_cmnd *cmnd,
 		uas_add_work(cmdinfo);
 	}
 
+out:
 	devinfo->cmnd[idx] = cmnd;
 zombie:
 	spin_unlock_irqrestore(&devinfo->lock, flags);
-- 
2.51.0


