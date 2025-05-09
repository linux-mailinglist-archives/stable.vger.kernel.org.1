Return-Path: <stable+bounces-142994-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A947AB0CC2
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 10:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68AE81899FF9
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 08:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BA526A1DA;
	Fri,  9 May 2025 08:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uc/hnAUC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464EB26989D
	for <stable@vger.kernel.org>; Fri,  9 May 2025 08:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746778309; cv=none; b=o7ZtmeOOnMvQpxkHFj8BXF9eLoGSQQHb5OiaraQGgWRo6YIvmFuw5erYEpzTRVBvLf06Hr9dx+wutfEx+eP0/m2eP2cSudU2yE2Jusl4O60fz4txCNvqWUiTyw/X5XvbQ/QtIVoWt7sRIdmwF0x7ug56qnp+IvO8OaOAX+9/rzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746778309; c=relaxed/simple;
	bh=IOkItXqcyemuO9jpfsmQb5QrfA2bQcDkGFUT1wmNs5w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FyjbiqbFtDgG0FB2Z9KptuH0Cn7dBogwfKILK2PqENIoTztfeGEbQLEWvBL1pSBgJy+Wff1L8RFoO8yQ05E2LF0ELjPTFNugZGbTFmN7tBSVPYIw/9fO6qx8orGjsUf6qcN3UgQFjkrjON0JqmhEcxKNVQskIEgYOoxPFmXbjoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uc/hnAUC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E92DC4CEE4;
	Fri,  9 May 2025 08:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746778308;
	bh=IOkItXqcyemuO9jpfsmQb5QrfA2bQcDkGFUT1wmNs5w=;
	h=Subject:To:Cc:From:Date:From;
	b=uc/hnAUCU6IfNeKohj5aB9YXTvxALSJonzzIPPFRbqs8FDCJPTzH9schckUTXmeHV
	 fanFsukG1tbGxAaUJVSmjHkOcmlwKKdZUOY0FDa8jqCM5/cHOX3ooR2wUrEIfWPcXe
	 +v/DKvQ4cQR5sJBCCvNRthN6vCd4Sm3WNBNB4ZO4=
Subject: FAILED: patch "[PATCH] firmware: arm_scmi: Fix timeout checks on polling path" failed to apply to 6.1-stable tree
To: cristian.marussi@arm.com,huangjie1663@phytium.com.cn,sudeep.holla@arm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 09 May 2025 10:11:45 +0200
Message-ID: <2025050945-multitude-powdered-34d0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x c23c03bf1faa1e76be1eba35bad6da6a2a7c95ee
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025050945-multitude-powdered-34d0@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c23c03bf1faa1e76be1eba35bad6da6a2a7c95ee Mon Sep 17 00:00:00 2001
From: Cristian Marussi <cristian.marussi@arm.com>
Date: Mon, 10 Mar 2025 17:58:00 +0000
Subject: [PATCH] firmware: arm_scmi: Fix timeout checks on polling path

Polling mode transactions wait for a reply busy-looping without holding a
spinlock, but currently the timeout checks are based only on elapsed time:
as a result we could hit a false positive whenever our busy-looping thread
is pre-empted and scheduled out for a time greater than the polling
timeout.

Change the checks at the end of the busy-loop to make sure that the polling
wasn't indeed successful or an out-of-order reply caused the polling to be
forcibly terminated.

Fixes: 31d2f803c19c ("firmware: arm_scmi: Add sync_cmds_completed_on_ret transport flag")
Reported-by: Huangjie <huangjie1663@phytium.com.cn>
Closes: https://lore.kernel.org/arm-scmi/20250123083323.2363749-1-jackhuang021@gmail.com/
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
Cc: stable@vger.kernel.org # 5.18.x
Message-Id: <20250310175800.1444293-1-cristian.marussi@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 1c75a4c9c371..0390d5ff195e 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -1248,7 +1248,8 @@ static void xfer_put(const struct scmi_protocol_handle *ph,
 }
 
 static bool scmi_xfer_done_no_timeout(struct scmi_chan_info *cinfo,
-				      struct scmi_xfer *xfer, ktime_t stop)
+				      struct scmi_xfer *xfer, ktime_t stop,
+				      bool *ooo)
 {
 	struct scmi_info *info = handle_to_scmi_info(cinfo->handle);
 
@@ -1257,7 +1258,7 @@ static bool scmi_xfer_done_no_timeout(struct scmi_chan_info *cinfo,
 	 * in case of out-of-order receptions of delayed responses
 	 */
 	return info->desc->ops->poll_done(cinfo, xfer) ||
-	       try_wait_for_completion(&xfer->done) ||
+	       (*ooo = try_wait_for_completion(&xfer->done)) ||
 	       ktime_after(ktime_get(), stop);
 }
 
@@ -1274,15 +1275,17 @@ static int scmi_wait_for_reply(struct device *dev, const struct scmi_desc *desc,
 		 * itself to support synchronous commands replies.
 		 */
 		if (!desc->sync_cmds_completed_on_ret) {
+			bool ooo = false;
+
 			/*
 			 * Poll on xfer using transport provided .poll_done();
 			 * assumes no completion interrupt was available.
 			 */
 			ktime_t stop = ktime_add_ms(ktime_get(), timeout_ms);
 
-			spin_until_cond(scmi_xfer_done_no_timeout(cinfo,
-								  xfer, stop));
-			if (ktime_after(ktime_get(), stop)) {
+			spin_until_cond(scmi_xfer_done_no_timeout(cinfo, xfer,
+								  stop, &ooo));
+			if (!ooo && !info->desc->ops->poll_done(cinfo, xfer)) {
 				dev_err(dev,
 					"timed out in resp(caller: %pS) - polling\n",
 					(void *)_RET_IP_);


