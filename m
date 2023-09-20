Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF17B7A7E11
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235405AbjITMP3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235706AbjITMPB (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:15:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E8BAD
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:14:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93387C433C8;
        Wed, 20 Sep 2023 12:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695212095;
        bh=Vh4xpK3o0vymehyig9r9WAU9+xCjMBU+vcglOIQn9VQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o8aIFl5Gu0QzeKstt+YF4Zb2uz+cCmUYYBE+ijXh9M8FZFL8M3Dt6FKn/QQb9jPiN
         BDyAV+9wIwY1u+hWZOfE1AakXf8ckFhzajr+t56yeNWmnrhn9sUYoo74ujx5Jqfe4G
         YN8RYxrVYZoh0A+lWopeyPjfWZ6KAGK97YbfMNC8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 149/273] media: i2c: ov2680: Set V4L2_CTRL_FLAG_MODIFY_LAYOUT on flips
Date:   Wed, 20 Sep 2023 13:29:49 +0200
Message-ID: <20230920112851.138676621@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112846.440597133@linuxfoundation.org>
References: <20230920112846.440597133@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index d8798fb714ba8..426386b94fff4 100644
--- a/drivers/media/i2c/ov2680.c
+++ b/drivers/media/i2c/ov2680.c
@@ -969,6 +969,8 @@ static int ov2680_v4l2_init(struct ov2680_dev *sensor)
 
 	ctrls->gain->flags |= V4L2_CTRL_FLAG_VOLATILE;
 	ctrls->exposure->flags |= V4L2_CTRL_FLAG_VOLATILE;
+	ctrls->vflip->flags |= V4L2_CTRL_FLAG_MODIFY_LAYOUT;
+	ctrls->hflip->flags |= V4L2_CTRL_FLAG_MODIFY_LAYOUT;
 
 	v4l2_ctrl_auto_cluster(2, &ctrls->auto_gain, 0, true);
 	v4l2_ctrl_auto_cluster(2, &ctrls->auto_exp, 1, true);
-- 
2.40.1



