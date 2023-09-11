Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE1379B9E5
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353716AbjIKVsI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241097AbjIKPBy (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:01:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1643E40
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:01:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 452D7C433C8;
        Mon, 11 Sep 2023 15:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444509;
        bh=YPqmbEIYTFvLj3mW8HCOa37jnQRf5cjRssdqFc3OEH4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q9rURQd7MGdZr4wcSogmSR1gRVF6kQjMJGuJTRv86v21ITQmf93B5+ZOQ1AuSxtWd
         HzEWXQPD+2mMV4AX71ODtjYirKRZtHLW+bnLMQvp3/E2N/KU7XfPN8/aMgb9khoFFs
         vJWqzs8Zb99/XHhWS0uk/yybrP6XnVNxTR4A8mTk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 003/600] scsi: ufs: Try harder to change the power mode
Date:   Mon, 11 Sep 2023 15:40:36 +0200
Message-ID: <20230911134633.727473100@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bvanassche@acm.org>

[ Upstream commit 579a4e9dbd53978cad8df88dc612837cdd210ce0 ]

Instead of only retrying the START STOP UNIT command if a unit attention is
reported, repeat it if any SCSI error is reported by the device or if the
command timed out.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Link: https://lore.kernel.org/r/20221018202958.1902564-8-bvanassche@acm.org
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Stable-dep-of: fe8637f7708c ("scsi: ufs: core: Increase the START STOP UNIT timeout from one to ten seconds")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ufs/core/ufshcd.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 977bd4b9dd0b4..36437d39b93c8 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -8830,9 +8830,11 @@ static int ufshcd_set_dev_pwr_mode(struct ufs_hba *hba,
 	for (retries = 3; retries > 0; --retries) {
 		ret = scsi_execute(sdp, cmd, DMA_NONE, NULL, 0, NULL, &sshdr,
 				   HZ, 0, 0, RQF_PM, NULL);
-		if (!scsi_status_is_check_condition(ret) ||
-				!scsi_sense_valid(&sshdr) ||
-				sshdr.sense_key != UNIT_ATTENTION)
+		/*
+		 * scsi_execute() only returns a negative value if the request
+		 * queue is dying.
+		 */
+		if (ret <= 0)
 			break;
 	}
 	if (ret) {
-- 
2.40.1



