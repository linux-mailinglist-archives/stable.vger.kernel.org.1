Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE3E7A7E0F
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235400AbjITMP1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235681AbjITMO6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:14:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1E093
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:14:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5849DC433C7;
        Wed, 20 Sep 2023 12:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695212090;
        bh=nKdPoA/yfM5ThMLPb5nb4xIB2+nKJWSmTkJ2EeDuIHA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R4WUFoHKpHcORuNd9SV2RArYVo57I1Wwp0H00pmfRlqTNOHlwqLW+IF3sR62nLP+h
         hkdktDRKuspnkXs9hFy9ihLfRFdjXVU2+WH6zyioyEmpAgJVG6pFRvDuwz42XoA7w0
         GNd7dNilIRw7JZwg1NYG9Wyviwp374LLQAcnIICU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Colin Ian King <colin.i.king@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 147/273] media: go7007: Remove redundant if statement
Date:   Wed, 20 Sep 2023 13:29:47 +0200
Message-ID: <20230920112851.074119853@linuxfoundation.org>
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

From: Colin Ian King <colin.i.king@gmail.com>

[ Upstream commit f33cb49081da0ec5af0888f8ecbd566bd326eed1 ]

The if statement that compares msgs[i].len != 3 is always false because
it is in a code block where msg[i].len is equal to 3. The check is
redundant and can be removed.

As detected by cppcheck static analysis:
drivers/media/usb/go7007/go7007-i2c.c:168:20: warning: Opposite inner
'if' condition leads to a dead code block. [oppositeInnerCondition]

Link: https://lore.kernel.org/linux-media/20230727174007.635572-1-colin.i.king@gmail.com

Fixes: 866b8695d67e ("Staging: add the go7007 video driver")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/go7007/go7007-i2c.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/media/usb/go7007/go7007-i2c.c b/drivers/media/usb/go7007/go7007-i2c.c
index c084bf794b567..64f25d4e52b20 100644
--- a/drivers/media/usb/go7007/go7007-i2c.c
+++ b/drivers/media/usb/go7007/go7007-i2c.c
@@ -173,8 +173,6 @@ static int go7007_i2c_master_xfer(struct i2c_adapter *adapter,
 		} else if (msgs[i].len == 3) {
 			if (msgs[i].flags & I2C_M_RD)
 				return -EIO;
-			if (msgs[i].len != 3)
-				return -EIO;
 			if (go7007_i2c_xfer(go, msgs[i].addr, 0,
 					(msgs[i].buf[0] << 8) | msgs[i].buf[1],
 					0x01, &msgs[i].buf[2]) < 0)
-- 
2.40.1



