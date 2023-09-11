Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1A279B78D
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378587AbjIKWfq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239439AbjIKOUi (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:20:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BA1DE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:20:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C1EC433C7;
        Mon, 11 Sep 2023 14:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442034;
        bh=BQLeg2oWhFRDM6wy3TbXfPADIPdMlC3UURX75Gt4QGY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NwEHYtGIO66dfY8TKxzNsiQAAfUpH3gD1PKPojm7M9U/GixFnLnxKFzuV77vW60zA
         11yQWzP4OD+ZEFULGPFpPPKhrBXG6CQzFHrTF/rZJmszxUUEBne7AwPz2LsBXPpZsh
         G6EG/AXnHsK911t3YLJIvdEEAvesrRAxuulTPa/E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Fenghua Yu <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 623/739] dmaengine: idxd: Fix issues with PRS disable sysfs knob
Date:   Mon, 11 Sep 2023 15:47:02 +0200
Message-ID: <20230911134708.499475281@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fenghua Yu <fenghua.yu@intel.com>

[ Upstream commit 8cae66574398326134a41513b419e00ad4e380ca ]

There are two issues in the current PRS disable sysfs store function
wq_prs_disable_store():

1. Since PRS disable knob is invisible if PRS disable is not supported
   in WQ, it's redundant to check PRS support again in the store function
   again. Remove the redundant PRS support check.
2. Since PRS disable is read-only when the device is not configurable,
   PRS disable cannot be changed on the device. Add device configurable
   check in the store function.

Fixes: f2dc327131b5 ("dmaengine: idxd: add per wq PRS disable")
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Link: https://lore.kernel.org/r/20230811012635.535413-2-fenghua.yu@intel.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/idxd/sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 66c89b07b3f7b..a5c3eb4348325 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -1131,8 +1131,8 @@ static ssize_t wq_prs_disable_store(struct device *dev, struct device_attribute
 	if (wq->state != IDXD_WQ_DISABLED)
 		return -EPERM;
 
-	if (!idxd->hw.wq_cap.wq_prs_support)
-		return -EOPNOTSUPP;
+	if (!test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
+		return -EPERM;
 
 	rc = kstrtobool(buf, &prs_dis);
 	if (rc < 0)
-- 
2.40.1



