Return-Path: <stable+bounces-3749-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7338023FE
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 14:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E62F280CB6
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 13:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED515E57E;
	Sun,  3 Dec 2023 13:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WQb5EOz6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973D71115
	for <stable@vger.kernel.org>; Sun,  3 Dec 2023 13:13:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD0ABC433C7;
	Sun,  3 Dec 2023 13:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701609197;
	bh=D/YnpRTfmwx2qe8pw6Xc+iYgH6zGwY5jXHM0IjDPE+U=;
	h=Subject:To:Cc:From:Date:From;
	b=WQb5EOz6/079TIJNmfwQJWQjhdXT82gjAStT+UZ7AC7BKkGTFdbZEZzirqCfVhIHK
	 qFpek0gmSy9zPCw4y3EB8gbPFN7FRyGGl+r8Xwpyf0gzdmNLgLn8s3McU4Zl//xzvM
	 tPB6Rv7TNfShsp6MhTxXURdUEEzKdOzD59Ev4G7w=
Subject: FAILED: patch "[PATCH] mmc: block: Be sure to wait while busy in CQE error recovery" failed to apply to 5.4-stable tree
To: adrian.hunter@intel.com,avri.altman@wdc.com,christian.loehle@arm.com,ulf.hansson@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 03 Dec 2023 14:13:14 +0100
Message-ID: <2023120314-freeware-thesis-5dd5@gregkh>
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
git cherry-pick -x c616696a902987352426fdaeec1b0b3240949e6b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023120314-freeware-thesis-5dd5@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

c616696a9029 ("mmc: block: Be sure to wait while busy in CQE error recovery")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c616696a902987352426fdaeec1b0b3240949e6b Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@intel.com>
Date: Fri, 3 Nov 2023 10:47:17 +0200
Subject: [PATCH] mmc: block: Be sure to wait while busy in CQE error recovery

STOP command does not guarantee to wait while busy, but subsequent command
MMC_CMDQ_TASK_MGMT to discard the queue will fail if the card is busy, so
be sure to wait by employing mmc_poll_for_busy().

Fixes: 72a5af554df8 ("mmc: core: Add support for handling CQE requests")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>
Reviewed-by: Christian Loehle <christian.loehle@arm.com>
Link: https://lore.kernel.org/r/20231103084720.6886-4-adrian.hunter@intel.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 3d3e0ca52614..befde2bd26d3 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -553,6 +553,8 @@ int mmc_cqe_recovery(struct mmc_host *host)
 	cmd.busy_timeout = MMC_CQE_RECOVERY_TIMEOUT;
 	mmc_wait_for_cmd(host, &cmd, 0);
 
+	mmc_poll_for_busy(host->card, MMC_CQE_RECOVERY_TIMEOUT, true, MMC_BUSY_IO);
+
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.opcode       = MMC_CMDQ_TASK_MGMT;
 	cmd.arg          = 1; /* Discard entire queue */


