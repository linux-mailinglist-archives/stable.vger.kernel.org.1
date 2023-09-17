Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4FC7A3841
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239705AbjIQTdZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239802AbjIQTdM (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:33:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04973D9
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:33:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B5EC433C7;
        Sun, 17 Sep 2023 19:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979187;
        bh=53yVDR+tc78t5AGw//Cay3J/ziojrNfpC8KdLClLKmY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qAaCuKH8kDJz9qBXds1oxGVsPb/acFpFk0V3BGs/3L1XGeHpdwg2199zBAfg3UmtY
         /wUOZNfqB/lNVhaiGmGR1d/SEvhne/gejbtaXxQXwFHXM09IUafGRxLPff5KhF8g0n
         Mu2YYOryhV9v8QxuSjORcyNXlzAx1xoLVZ92la1c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 239/406] media: i2c: ov2680: Set V4L2_CTRL_FLAG_MODIFY_LAYOUT on flips
Date:   Sun, 17 Sep 2023 21:11:33 +0200
Message-ID: <20230917191107.474295113@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

[ Upstream commit 66274280b2c745d380508dc27b9a4dfd736e5eda ]

The driver changes the Bayer order based on the flips, but
does not define the control correctly with the
V4L2_CTRL_FLAG_MODIFY_LAYOUT flag.

Add the V4L2_CTRL_FLAG_MODIFY_LAYOUT flag.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Acked-by: Rui Miguel Silva <rmfrfs@gmail.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Stable-dep-of: 7b5a42e6ae71 ("media: ov2680: Remove auto-gain and auto-exposure controls")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/ov2680.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/i2c/ov2680.c b/drivers/media/i2c/ov2680.c
index 59cdbc33658ce..cd0c083a4768a 100644
--- a/drivers/media/i2c/ov2680.c
+++ b/drivers/media/i2c/ov2680.c
@@ -966,6 +966,8 @@ static int ov2680_v4l2_register(struct ov2680_dev *sensor)
 
 	ctrls->gain->flags |= V4L2_CTRL_FLAG_VOLATILE;
 	ctrls->exposure->flags |= V4L2_CTRL_FLAG_VOLATILE;
+	ctrls->vflip->flags |= V4L2_CTRL_FLAG_MODIFY_LAYOUT;
+	ctrls->hflip->flags |= V4L2_CTRL_FLAG_MODIFY_LAYOUT;
 
 	v4l2_ctrl_auto_cluster(2, &ctrls->auto_gain, 0, true);
 	v4l2_ctrl_auto_cluster(2, &ctrls->auto_exp, 1, true);
-- 
2.40.1



