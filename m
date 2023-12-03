Return-Path: <stable+bounces-3744-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C838023EA
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 13:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73D5D1F210C4
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 12:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDBADF51;
	Sun,  3 Dec 2023 12:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a/+LTQRH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9DD3D79
	for <stable@vger.kernel.org>; Sun,  3 Dec 2023 12:54:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD67DC433C9;
	Sun,  3 Dec 2023 12:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701608085;
	bh=8mgnCqfcUc6Yl65582wZbrxezNiaSKe/xD1CTcX1XkQ=;
	h=Subject:To:Cc:From:Date:From;
	b=a/+LTQRHLBQgd1m4IbZOJnVXKa8rXGlX0hLr7PSeLSaI7/8h8bkf44XZvg8T+xjSy
	 2kGz3Fr8JPMkeJ5VZG1BOkdxoU1lywcidGQ35h5eUk0M6SpFPVVvPa3VB2bo9zCAcB
	 5JbNqUMA7pn7sNPt2qGSxCnX/JwdNIhbehcyb1VY=
Subject: FAILED: patch "[PATCH] mmc: block: Retry commands in CQE error recovery" failed to apply to 5.10-stable tree
To: adrian.hunter@intel.com,avri.altman@wdc.com,ulf.hansson@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 03 Dec 2023 13:54:41 +0100
Message-ID: <2023120341-superbowl-perkiness-0b1a@gregkh>
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
git cherry-pick -x 8155d1fa3a747baad5caff5f8303321d68ddd48c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023120341-superbowl-perkiness-0b1a@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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


