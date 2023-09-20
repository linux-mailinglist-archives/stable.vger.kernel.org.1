Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4B97A7EFF
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235549AbjITMWt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235675AbjITMWs (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:22:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DA792
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:22:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4582DC433C7;
        Wed, 20 Sep 2023 12:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695212562;
        bh=T6bF6A0E9Vp8ZvxVHVkae8XE3KNopROyLfp897SboTk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mBNqJb/mtl2Mtrkm4ki3rEJ+EQvnikmxWfaO3yw9JOQIkRu+b96bsVnPhaMqKjGDc
         Z8LGHvZ8FrpB632pmXR9/5c873CGV3Y/IpdGIeRo7r1ClWlCu3oOo55cYY1ltNauFo
         824H+7z0ZsU2G6ApG2XVr2yUjAavjKTRLB6n5gik=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 47/83] media: pci: ipu3-cio2: Initialise timing struct to avoid a compiler warning
Date:   Wed, 20 Sep 2023 13:31:37 +0200
Message-ID: <20230920112828.532233373@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112826.634178162@linuxfoundation.org>
References: <20230920112826.634178162@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sakari Ailus <sakari.ailus@linux.intel.com>

[ Upstream commit 9d7531be3085a8f013cf173ccc4e72e3cf493538 ]

Initialise timing struct in cio2_hw_init() to zero in order to avoid a
compiler warning. The warning was a false positive.

Reported-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/intel/ipu3/ipu3-cio2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/intel/ipu3/ipu3-cio2.c b/drivers/media/pci/intel/ipu3/ipu3-cio2.c
index d6838c8ebd7e8..f8dca47904766 100644
--- a/drivers/media/pci/intel/ipu3/ipu3-cio2.c
+++ b/drivers/media/pci/intel/ipu3/ipu3-cio2.c
@@ -355,7 +355,7 @@ static int cio2_hw_init(struct cio2_device *cio2, struct cio2_queue *q)
 	void __iomem *const base = cio2->base;
 	u8 lanes, csi2bus = q->csi2.port;
 	u8 sensor_vc = SENSOR_VIR_CH_DFLT;
-	struct cio2_csi2_timing timing;
+	struct cio2_csi2_timing timing = { 0 };
 	int i, r;
 
 	fmt = cio2_find_format(NULL, &q->subdev_fmt.code);
-- 
2.40.1



