Return-Path: <stable+bounces-3748-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 604018023FD
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 14:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81A57280CED
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 13:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C424EE57E;
	Sun,  3 Dec 2023 13:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VT25KLGk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711F81115
	for <stable@vger.kernel.org>; Sun,  3 Dec 2023 13:12:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F98BC433C8;
	Sun,  3 Dec 2023 13:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701609149;
	bh=FzA1vkgboW8OH1u/Ceb9hQk3eKIsDf08JFNb8bWqIqQ=;
	h=Subject:To:Cc:From:Date:From;
	b=VT25KLGkRPb3sWRdYf063B81zZYQxBaRaM9+7J5hDuBNcSqj2T1fbAb7NpdbGEnOm
	 /7hhSKBHFOVw5iGQ8IQVPOSeC0xHP2r/Nlwic0hDcazGsjuDmQHV9aRvYCsV+7PFGS
	 wsFVLaEE9z7AV2jPaiNQB8qdtUS8Im3Vlt0UIwqs=
Subject: FAILED: patch "[PATCH] mmc: block: Be sure to wait while busy in CQE error recovery" failed to apply to 4.19-stable tree
To: adrian.hunter@intel.com,avri.altman@wdc.com,christian.loehle@arm.com,ulf.hansson@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 03 Dec 2023 14:12:26 +0100
Message-ID: <2023120326-sadness-deem-1895@gregkh>
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
git cherry-pick -x c616696a902987352426fdaeec1b0b3240949e6b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023120326-sadness-deem-1895@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

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


