Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3B479C03E
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350610AbjIKVjo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240861AbjIKOz4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:55:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACCC118
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:55:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1DB4C433C7;
        Mon, 11 Sep 2023 14:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444152;
        bh=xZkXvTe3OiXbwtVSGEr6cMtG+HRDrSJhwEBcAWMLe8Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pFHN+VHQKf3T+OYqN1I1ve5rKEQU7XId8SOFv9Uood/f/CVSsofG+OctL3skX2UlH
         K4/x+nAc24lBZXwy1i0TxEcQYD2pXOEb7nToSybPvYZfZw1F8Ys3hABd3FoGG0sSxx
         CABknKAyJ6zdN7FYViYNs8e7Z0Qd/QuRo8ARnNms=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Fenghua Yu <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 628/737] dmaengine: idxd: Fix issues with PRS disable sysfs knob
Date:   Mon, 11 Sep 2023 15:48:07 +0200
Message-ID: <20230911134708.072235184@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

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



