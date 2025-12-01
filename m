Return-Path: <stable+bounces-197948-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1D4C986EF
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 18:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EBC854E1CDC
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 17:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BBF334C06;
	Mon,  1 Dec 2025 17:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AWPctfgZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAF93191D3
	for <stable@vger.kernel.org>; Mon,  1 Dec 2025 17:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764609046; cv=none; b=oOAvc2OtjsynGnuGvdZOEi9YtDHWdpnlkyEX9zxi8BpDYI2iID+1sup6Kz5pgZcwwu0CV9rH7vs5KJjvGVx9EtBo+TO6iqtXqZAKWZTcmYNjpulgF/LpvYiQa+ngjHx43aiN5if6dM0fLpL6Ql6Av6NjGMb5mcG1YYzkLBSkhkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764609046; c=relaxed/simple;
	bh=2CVslr4OPwVOOBVoC9vsiBK0aNtWz6XlqyMtlc4X/6U=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=TcHTnCYcNkuXI2tDt/2mlK48LDvcMpAw0Atx9grwlG327lHFN6C8VeH410SwlE0uxRcd5JwZSgDf0Uf+bVwQRsmoLoAAMYd2vziIMyDfx5jheFR67Avt9z24l34R9q1RFGyKJI1hne9hBKGZJsjU8mUXfYCV0c6WwAK+87GsFEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AWPctfgZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CE8EC4CEF1;
	Mon,  1 Dec 2025 17:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764609044;
	bh=2CVslr4OPwVOOBVoC9vsiBK0aNtWz6XlqyMtlc4X/6U=;
	h=Subject:To:Cc:From:Date:From;
	b=AWPctfgZimUBO/NtYEBiGMO3aELk48zK7pzzCeByUQZ26bgIq6CgfxlP1ZQnDG1ge
	 B35bLnT6xeAsmTGQXjykfTngL1jqH4BzBlc7CAU80Jc7d5LPvi1u2T/f6GTEvNlBKh
	 81ecbPF4lKPL91OB9IB/HGJNnY6MXbabbkMw/BS4=
Subject: FAILED: patch "[PATCH] usb: uas: fix urb unmapping issue when the uas device is" failed to apply to 5.10-stable tree
To: guhuinan@xiaomi.com,chenyu45@xiaomi.com,gregkh@linuxfoundation.org,oneukum@suse.com,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 01 Dec 2025 18:10:32 +0100
Message-ID: <2025120132-patio-vocation-ff6a@gregkh>
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
git cherry-pick -x 26d56a9fcb2014b99e654127960aa0a48a391e3c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025120132-patio-vocation-ff6a@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 26d56a9fcb2014b99e654127960aa0a48a391e3c Mon Sep 17 00:00:00 2001
From: Owen Gu <guhuinan@xiaomi.com>
Date: Thu, 20 Nov 2025 20:33:36 +0800
Subject: [PATCH] usb: uas: fix urb unmapping issue when the uas device is
 remove during ongoing data transfer

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

diff --git a/drivers/usb/storage/uas.c b/drivers/usb/storage/uas.c
index 4ed0dc19afe0..45b01df364f7 100644
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


