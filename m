Return-Path: <stable+bounces-143018-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A49B1AB0DD6
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 10:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 729103A4608
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 08:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9F72741D0;
	Fri,  9 May 2025 08:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b4GXqnEG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7D72741BE
	for <stable@vger.kernel.org>; Fri,  9 May 2025 08:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746780815; cv=none; b=pqZl3vXiKk5xE1ol8O2rYxqejdieNwCv3EBjwTsC/1R6xD0t02RkEQiw3H2PvRGz/6lZe3bOUImDcqovcS5hbPqfaU9zILYDFAkwztSiG7E5pfSP5j1Lb2hNzgQqf41dOof7DHQFZDofMHycxCNdbvuS5ivQZVlqo7u7lCjCeZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746780815; c=relaxed/simple;
	bh=YaU0wkVGCOIB5w6m0jLo2M6LUI8nU485ajGHfYaae98=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YBQ59IRi3AexMhj1BlwSZvQLHP67NSyCdcAQIGj2p07HM0NgVsBcMCGjsC6u2l/o4k4Qe8xsIrISXqfucgpoMctjVsFoisJo8VdeE1YVJMcYPxOuOhH88KiN1TsPnVkXWQv48l7AvCrRNX6X6BZaj32HHLOe60b4ahQNjTAim5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b4GXqnEG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C373C4CEE9;
	Fri,  9 May 2025 08:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746780813;
	bh=YaU0wkVGCOIB5w6m0jLo2M6LUI8nU485ajGHfYaae98=;
	h=Subject:To:Cc:From:Date:From;
	b=b4GXqnEGrN5VQ+coGRJ3uiWIzU/0gjffOBGQDIqq5hL7Ait0r57xumXqiuYLQjYAu
	 A9Kor2v+43Rh6tFoiT/frFrW62yKqgAz0PSwfSHpWQ0g3YLOEMX1lnjLjYh3Z0daWn
	 uRMZGoxBaXEuYHoBR21zooceUaqFvpxwb6GpkVNQ=
Subject: FAILED: patch "[PATCH] firmware: arm_scmi: Fix timeout checks on polling path" failed to apply to 6.6-stable tree
To: cristian.marussi@arm.com,huangjie1663@phytium.com.cn,sudeep.holla@arm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 09 May 2025 10:53:30 +0200
Message-ID: <2025050930-scuba-spending-0eb9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x c23c03bf1faa1e76be1eba35bad6da6a2a7c95ee
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025050930-scuba-spending-0eb9@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


