Return-Path: <stable+bounces-114596-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EEFA2EF0D
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 14:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2BBD163610
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 13:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8118D230998;
	Mon, 10 Feb 2025 13:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nfGUXqrv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4279014B08C
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 13:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739195884; cv=none; b=pceicS4mVrnJk8r3SHI6JSfG6OYheVLyfsTnXWLUpebPiGd76lRvzEpE995wAOIDD06bK0RkjDC160Qx7UJ7HSorkxu/s4DWAbfCIo+4xs7kc+7PU/Ob6sic9PQ5xSfEk5TBewBw0wOytVznOMazbpFeDKx/WPEWEOtVKXVtjkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739195884; c=relaxed/simple;
	bh=A0YoPwipTO4eT4sxV9kIMKTM8eAghsK6b7IqBepkX10=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YHNDfeCr9c+RcoJr8KrL3r+YJZDVXYyFbEblPFp8z2JKxcF2WxREFThSv9SynLgwDBz5BWRS5WBDVwW5ZmjoHTHSlvnKu0VHq+P6wri5H3QMhqtL4Psu3g4jbEU5bi6yzXNMUFN/hdp7hbd69yIF4KirdAKa55LmbZ3A8hCpDho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nfGUXqrv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0076C4CED1;
	Mon, 10 Feb 2025 13:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739195884;
	bh=A0YoPwipTO4eT4sxV9kIMKTM8eAghsK6b7IqBepkX10=;
	h=Subject:To:Cc:From:Date:From;
	b=nfGUXqrv0uUar8z0Z350hj2XCCjQ1lvFrErCGcOBLZ9xjGTrkap0Y2vStvLeTb1HA
	 /uMCIpE8l0cNVNuykh/tw/N3SXDZ+05m2ZfCA+dKd+K16LIGD4QaWBx6SU9gvwsuWf
	 Wu9/Fw4jtLfCJlFRXKjBE9d6+7yqiDfQOwF3vj38=
Subject: FAILED: patch "[PATCH] scsi: storvsc: Set correct data length for sending SCSI" failed to apply to 5.4-stable tree
To: longli@microsoft.com,martin.petersen@oracle.com,mhklinux@outlook.com,romank@linux.microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 10 Feb 2025 14:57:55 +0100
Message-ID: <2025021055-utensil-raven-b270@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 87c4b5e8a6b65189abd9ea5010ab308941f964a4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021055-utensil-raven-b270@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 87c4b5e8a6b65189abd9ea5010ab308941f964a4 Mon Sep 17 00:00:00 2001
From: Long Li <longli@microsoft.com>
Date: Wed, 22 Jan 2025 19:07:22 -0800
Subject: [PATCH] scsi: storvsc: Set correct data length for sending SCSI
 command without payload

In StorVSC, payload->range.len is used to indicate if this SCSI command
carries payload. This data is allocated as part of the private driver data
by the upper layer and may get passed to lower driver uninitialized.

For example, the SCSI error handling mid layer may send TEST_UNIT_READY or
REQUEST_SENSE while reusing the buffer from a failed command. The private
data section may have stale data from the previous command.

If the SCSI command doesn't carry payload, the driver may use this value as
is for communicating with host, resulting in possible corruption.

Fix this by always initializing this value.

Fixes: be0cf6ca301c ("scsi: storvsc: Set the tablesize based on the information given by the host")
Cc: stable@kernel.org
Tested-by: Roman Kisel <romank@linux.microsoft.com>
Reviewed-by: Roman Kisel <romank@linux.microsoft.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Long Li <longli@microsoft.com>
Link: https://lore.kernel.org/r/1737601642-7759-1-git-send-email-longli@linuxonhyperv.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 5a101ac06c47..a8614e54544e 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1800,6 +1800,7 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 
 	length = scsi_bufflen(scmnd);
 	payload = (struct vmbus_packet_mpb_array *)&cmd_request->mpb;
+	payload->range.len = 0;
 	payload_sz = 0;
 
 	if (scsi_sg_count(scmnd)) {


