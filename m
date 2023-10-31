Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333DD7DD3E3
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 18:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236307AbjJaRGH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 13:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236358AbjJaRFx (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:05:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D731705
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:03:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30F96C433C7;
        Tue, 31 Oct 2023 17:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698771791;
        bh=zZ7SLVEkHXOzlYrlj1vm0tGfY9JApPKQUpEzd3oIfW8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T/EPDdo3+8IY4Mrp88f2WGbbmIPmicCJTzf3AyumWiKWS0NFHh2k3SjfRPamMzWPJ
         Kvmf3EQD/jNajydr/lbkPGpaacgL3DYD+D0D2TCEluCjtCvV5Bwc+ZuAiektTfZebJ
         9YSJBOTZelb0SGyeFKAq4q1vHVr11JeO61209zOw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Avri Altman <avri.altman@wdc.com>,
        Christian Loehle <christian.loehle@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 04/86] mmc: core: Fix error propagation for some ioctl commands
Date:   Tue, 31 Oct 2023 18:00:29 +0100
Message-ID: <20231031165918.749940500@linuxfoundation.org>
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

[ Upstream commit f19c5a73e6f78d69efce66cfdce31148c76a61a6 ]

Userspace has currently no way of checking the internal R1 response error
bits for some commands. This is a problem for some commands, like RPMB for
example. Typically, we may detect that the busy completion has successfully
ended, while in fact the card did not complete the requested operation.

To fix the problem, let's always poll with CMD13 for these commands and
during the polling, let's also aggregate the R1 response bits. Before
completing the ioctl request, let's propagate the R1 response bits too.

Reviewed-by: Avri Altman <avri.altman@wdc.com>
Co-developed-by: Christian Loehle <christian.loehle@arm.com>
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230913112921.553019-1-ulf.hansson@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/core/block.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 1aab4f47eab98..1fc6767f18782 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -181,6 +181,7 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 			       struct mmc_queue *mq);
 static void mmc_blk_hsq_req_done(struct mmc_request *mrq);
 static int mmc_spi_err_check(struct mmc_card *card);
+static int mmc_blk_busy_cb(void *cb_data, bool *busy);
 
 static struct mmc_blk_data *mmc_blk_get(struct gendisk *disk)
 {
@@ -472,7 +473,7 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 	struct mmc_data data = {};
 	struct mmc_request mrq = {};
 	struct scatterlist sg;
-	bool r1b_resp, use_r1b_resp = false;
+	bool r1b_resp;
 	unsigned int busy_timeout_ms;
 	int err;
 	unsigned int target_part;
@@ -566,8 +567,7 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 	busy_timeout_ms = idata->ic.cmd_timeout_ms ? : MMC_BLK_TIMEOUT_MS;
 	r1b_resp = (cmd.flags & MMC_RSP_R1B) == MMC_RSP_R1B;
 	if (r1b_resp)
-		use_r1b_resp = mmc_prepare_busy_cmd(card->host, &cmd,
-						    busy_timeout_ms);
+		mmc_prepare_busy_cmd(card->host, &cmd, busy_timeout_ms);
 
 	mmc_wait_for_req(card->host, &mrq);
 	memcpy(&idata->ic.response, cmd.resp, sizeof(cmd.resp));
@@ -620,19 +620,28 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 	if (idata->ic.postsleep_min_us)
 		usleep_range(idata->ic.postsleep_min_us, idata->ic.postsleep_max_us);
 
-	/* No need to poll when using HW busy detection. */
-	if ((card->host->caps & MMC_CAP_WAIT_WHILE_BUSY) && use_r1b_resp)
-		return 0;
-
 	if (mmc_host_is_spi(card->host)) {
 		if (idata->ic.write_flag || r1b_resp || cmd.flags & MMC_RSP_SPI_BUSY)
 			return mmc_spi_err_check(card);
 		return err;
 	}
-	/* Ensure RPMB/R1B command has completed by polling with CMD13. */
-	if (idata->rpmb || r1b_resp)
-		err = mmc_poll_for_busy(card, busy_timeout_ms, false,
-					MMC_BUSY_IO);
+
+	/*
+	 * Ensure RPMB, writes and R1B responses are completed by polling with
+	 * CMD13. Note that, usually we don't need to poll when using HW busy
+	 * detection, but here it's needed since some commands may indicate the
+	 * error through the R1 status bits.
+	 */
+	if (idata->rpmb || idata->ic.write_flag || r1b_resp) {
+		struct mmc_blk_busy_data cb_data = {
+			.card = card,
+		};
+
+		err = __mmc_poll_for_busy(card->host, 0, busy_timeout_ms,
+					  &mmc_blk_busy_cb, &cb_data);
+
+		idata->ic.response[0] = cb_data.status;
+	}
 
 	return err;
 }
-- 
2.42.0



