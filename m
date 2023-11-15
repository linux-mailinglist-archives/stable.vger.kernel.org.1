Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967FE7DD3F1
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 18:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236319AbjJaRGW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 13:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236367AbjJaRGK (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:06:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8582106
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:03:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F2BC433C7;
        Tue, 31 Oct 2023 17:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698771824;
        bh=emtbnUQzpJpLWRsOKrQ0iTJlAX21to0DxXF+3HZkCCY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ObQQrmwIgN2fEqmpowzwDbhXk5QSD8WGZIBLo6nM0sLQQ9HWl1RJRg6B9I2ysLqph
         zM+dQwx2VCY0DoQWQO3EQXVanuE0CPtw+COZmAJiR3OLQPqw9tGZBpGtP65i2CNOHi
         q4c7N68IV/kyncn4k3UnC51fOZDgrm8HU+xu4gjA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christian Loehle <cloehle@hyperstone.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 02/86] mmc: core: Align to common busy polling behaviour for mmc ioctls
Date:   Tue, 31 Oct 2023 18:00:27 +0100
Message-ID: <20231031165918.686567190@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031165918.608547597@linuxfoundation.org>
References: <20231031165918.608547597@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ulf Hansson <ulf.hansson@linaro.org>

[ Upstream commit 51f5b3056790bc0518e49587996f1e6f3058cca9 ]

Let's align to the common busy polling behaviour for mmc ioctls, by
updating the below two corresponding parts, that comes into play when using
an R1B response for a command.

*) A command with an R1B response should be prepared by calling
mmc_prepare_busy_cmd(), which make us respects the host's busy timeout
constraints.
**) When an R1B response is being used and the host also supports HW busy
detection, we should skip to poll for busy completion.

Suggested-by: Christian Loehle <cloehle@hyperstone.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Christian Loehle <cloehle@hyperstone.com>
Link: https://lore.kernel.org/r/20230213133707.27857-1-ulf.hansson@linaro.org
Stable-dep-of: f19c5a73e6f7 ("mmc: core: Fix error propagation for some ioctl commands")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/core/block.c   | 25 +++++++++++++++++--------
 drivers/mmc/core/mmc_ops.c |  1 +
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index cdd7f126d4aea..baefe2886f0b2 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -471,6 +471,8 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 	struct mmc_data data = {};
 	struct mmc_request mrq = {};
 	struct scatterlist sg;
+	bool r1b_resp, use_r1b_resp = false;
+	unsigned int busy_timeout_ms;
 	int err;
 	unsigned int target_part;
 
@@ -559,6 +561,13 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 	    (cmd.opcode == MMC_SWITCH))
 		return mmc_sanitize(card, idata->ic.cmd_timeout_ms);
 
+	/* If it's an R1B response we need some more preparations. */
+	busy_timeout_ms = idata->ic.cmd_timeout_ms ? : MMC_BLK_TIMEOUT_MS;
+	r1b_resp = (cmd.flags & MMC_RSP_R1B) == MMC_RSP_R1B;
+	if (r1b_resp)
+		use_r1b_resp = mmc_prepare_busy_cmd(card->host, &cmd,
+						    busy_timeout_ms);
+
 	mmc_wait_for_req(card->host, &mrq);
 	memcpy(&idata->ic.response, cmd.resp, sizeof(cmd.resp));
 
@@ -610,14 +619,14 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 	if (idata->ic.postsleep_min_us)
 		usleep_range(idata->ic.postsleep_min_us, idata->ic.postsleep_max_us);
 
-	if (idata->rpmb || (cmd.flags & MMC_RSP_R1B) == MMC_RSP_R1B) {
-		/*
-		 * Ensure RPMB/R1B command has completed by polling CMD13 "Send Status". Here we
-		 * allow to override the default timeout value if a custom timeout is specified.
-		 */
-		err = mmc_poll_for_busy(card, idata->ic.cmd_timeout_ms ? : MMC_BLK_TIMEOUT_MS,
-					false, MMC_BUSY_IO);
-	}
+	/* No need to poll when using HW busy detection. */
+	if ((card->host->caps & MMC_CAP_WAIT_WHILE_BUSY) && use_r1b_resp)
+		return 0;
+
+	/* Ensure RPMB/R1B command has completed by polling with CMD13. */
+	if (idata->rpmb || r1b_resp)
+		err = mmc_poll_for_busy(card, busy_timeout_ms, false,
+					MMC_BUSY_IO);
 
 	return err;
 }
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 81c55bfd6e0c2..3b3adbddf6641 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -575,6 +575,7 @@ bool mmc_prepare_busy_cmd(struct mmc_host *host, struct mmc_command *cmd,
 	cmd->busy_timeout = timeout_ms;
 	return true;
 }
+EXPORT_SYMBOL_GPL(mmc_prepare_busy_cmd);
 
 /**
  *	__mmc_switch - modify EXT_CSD register
-- 
2.42.0



