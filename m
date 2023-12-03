Return-Path: <stable+bounces-3746-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 365518023EC
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 13:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF8E11F21190
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 12:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77BCE556;
	Sun,  3 Dec 2023 12:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="snSC+tkM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836053D79
	for <stable@vger.kernel.org>; Sun,  3 Dec 2023 12:54:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEBADC433C9;
	Sun,  3 Dec 2023 12:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701608098;
	bh=7qSaAhalKOWj7S/h3tURvB8u+m2eszws00kIwOMQ6oo=;
	h=Subject:To:Cc:From:Date:From;
	b=snSC+tkMdVAkKu8w6WXWt045vcp1dOuEm7Nm4cBu0X5l5aRlWCLCJzcSCVH+YmWZT
	 Uc9p8gt8zP2zv4cjpcdWUy4kQW+oAxa3wepDlcmG6+qgeDJX3Z3TMp6mcOPkNVDL22
	 6F2LcIyH3O8qg10VpiCMCjAvjZWqajhZQG9Y9OoE=
Subject: FAILED: patch "[PATCH] mmc: block: Retry commands in CQE error recovery" failed to apply to 4.19-stable tree
To: adrian.hunter@intel.com,avri.altman@wdc.com,ulf.hansson@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 03 Dec 2023 13:54:43 +0100
Message-ID: <2023120343-roamer-hacksaw-5f16@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 8155d1fa3a747baad5caff5f8303321d68ddd48c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023120343-roamer-hacksaw-5f16@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

8155d1fa3a74 ("mmc: block: Retry commands in CQE error recovery")
6b1dc6229aec ("mmc: core: convert comma to semicolon")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8155d1fa3a747baad5caff5f8303321d68ddd48c Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@intel.com>
Date: Fri, 3 Nov 2023 10:47:18 +0200
Subject: [PATCH] mmc: block: Retry commands in CQE error recovery

It is important that MMC_CMDQ_TASK_MGMT command to discard the queue is
successful because otherwise a subsequent reset might fail to flush the
cache first.  Retry it and the previous STOP command.

Fixes: 72a5af554df8 ("mmc: core: Add support for handling CQE requests")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>
Link: https://lore.kernel.org/r/20231103084720.6886-5-adrian.hunter@intel.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index befde2bd26d3..a8c17b4cd737 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -551,7 +551,7 @@ int mmc_cqe_recovery(struct mmc_host *host)
 	cmd.flags        = MMC_RSP_R1B | MMC_CMD_AC;
 	cmd.flags       &= ~MMC_RSP_CRC; /* Ignore CRC */
 	cmd.busy_timeout = MMC_CQE_RECOVERY_TIMEOUT;
-	mmc_wait_for_cmd(host, &cmd, 0);
+	mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
 
 	mmc_poll_for_busy(host->card, MMC_CQE_RECOVERY_TIMEOUT, true, MMC_BUSY_IO);
 
@@ -561,10 +561,13 @@ int mmc_cqe_recovery(struct mmc_host *host)
 	cmd.flags        = MMC_RSP_R1B | MMC_CMD_AC;
 	cmd.flags       &= ~MMC_RSP_CRC; /* Ignore CRC */
 	cmd.busy_timeout = MMC_CQE_RECOVERY_TIMEOUT;
-	err = mmc_wait_for_cmd(host, &cmd, 0);
+	err = mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
 
 	host->cqe_ops->cqe_recovery_finish(host);
 
+	if (err)
+		err = mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
+
 	mmc_retune_release(host);
 
 	return err;


