Return-Path: <stable+bounces-122785-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5F9A5A132
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 357EB7A4B00
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E6E23237F;
	Mon, 10 Mar 2025 17:58:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A461C4A24;
	Mon, 10 Mar 2025 17:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741629492; cv=none; b=TNuqsJahexFekkZAabM7p7mmJBwodkd88m9cZTMU3FehXtehgXehm904yxk3Se1HN9HnK6aj58s2MJKveNitJTPr7dIfjnLP2ttL0D3Eg7S9F8v8WVVQTCVC/USnx8uOvC4enIbyiyvXabHzAfTj7prDdEOOPtBu5+G6ARlfAJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741629492; c=relaxed/simple;
	bh=oZAX4ZsFkwdrUYXqPWdEuU4XKuGxf5NrIGOTkEDVuB8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g0sXYMjPgt30MDzj+/IXmkP5h2Q7u069BlsRn/I0Myw9ZxdimVEE1qm28fs5qVVBfZ8yjfo0tyip6Ew3c0rdGjMXRLp6HODRkkQaVuOXgrhpqdqB+NiCbzkg3egBCWBaFkkZ0jdEC4PRpIINt/eyBy3bhojh8z67iXKPpjeeifI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BCD851516;
	Mon, 10 Mar 2025 10:58:20 -0700 (PDT)
Received: from pluto.guest.local (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E3DA83F673;
	Mon, 10 Mar 2025 10:58:07 -0700 (PDT)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org
Cc: sudeep.holla@arm.com,
	dan.carpenter@linaro.org,
	Cristian Marussi <cristian.marussi@arm.com>,
	Huangjie <huangjie1663@phytium.com.cn>,
	stable@vger.kernel.org
Subject: [PATCH] firmware: arm_scmi: Fix timeout checks on polling path
Date: Mon, 10 Mar 2025 17:58:00 +0000
Message-ID: <20250310175800.1444293-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Cc: <stable@vger.kernel.org> # 5.18.x
---
This fix got to be backported to 5.4/5.10./5.15 due to small changes in the
context
---
 drivers/firmware/arm_scmi/driver.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 60050da54bf2..e6cf83950875 100644
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
-- 
2.47.0


