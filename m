Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703997B89E8
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244306AbjJDSa3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244301AbjJDSa2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:30:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCE398
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:30:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92408C433C8;
        Wed,  4 Oct 2023 18:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444224;
        bh=nSFdjdJiZEeIVS6T7nkPKUMoaElqLPN/+ODy1MwlXP8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fDHDQHKJtt/SQhVWXctZ/VUBs6z1YR8qEGHDc/zq613fd3SfxWCLC6vavGOufAvaV
         qXhSQOZGISHg8jOZClvTXIh+x6FiC7IpqCQQPX9b8zRWhjU0rALDycKro9U8RWbqZO
         DN9mGM1aldFbN4nSPrSnIHzutbqOJVjydv5x4gpc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kiwoong Kim <kwmad.kim@samsung.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Chanwoo Lee <cw9316.lee@samsung.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 174/321] scsi: ufs: core: Poll HCS.UCRDY before issuing a UIC command
Date:   Wed,  4 Oct 2023 19:55:19 +0200
Message-ID: <20231004175237.308551378@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kiwoong Kim <kwmad.kim@samsung.com>

[ Upstream commit d32533d30e2119b0c0aa17596734f1f842f750df ]

With auto hibern8 enabled, UIC could be busy processing a hibern8 operation
and the HCI would reports UIC not ready for a short while through
HCS.UCRDY. The UFS driver doesn't currently handle this situation. The
UFSHCI spec specifies UCRDY like this: whether the host controller is ready
to process UIC COMMAND

The 'ready' could be seen as many different meanings. If the meaning
includes not processing any request from HCI, processing a hibern8
operation can be 'not ready'. In this situation, the driver needs to wait
until the operations is completed.

Signed-off-by: Kiwoong Kim <kwmad.kim@samsung.com>
Link: https://lore.kernel.org/r/550484ffb66300bdcec63d3e304dfd55cb432f1f.1693790060.git.kwmad.kim@samsung.com
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Chanwoo Lee <cw9316.lee@samsung.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ufs/core/ufshcd.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 75c6628af2c0e..80c48eb6bf85c 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -22,6 +22,7 @@
 #include <linux/module.h>
 #include <linux/regulator/consumer.h>
 #include <linux/sched/clock.h>
+#include <linux/iopoll.h>
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_dbg.h>
 #include <scsi/scsi_driver.h>
@@ -2324,7 +2325,11 @@ static inline int ufshcd_hba_capabilities(struct ufs_hba *hba)
  */
 static inline bool ufshcd_ready_for_uic_cmd(struct ufs_hba *hba)
 {
-	return ufshcd_readl(hba, REG_CONTROLLER_STATUS) & UIC_COMMAND_READY;
+	u32 val;
+	int ret = read_poll_timeout(ufshcd_readl, val, val & UIC_COMMAND_READY,
+				    500, UIC_CMD_TIMEOUT * 1000, false, hba,
+				    REG_CONTROLLER_STATUS);
+	return ret == 0 ? true : false;
 }
 
 /**
-- 
2.40.1



