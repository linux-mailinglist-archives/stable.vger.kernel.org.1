Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C8179B4ED
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354140AbjIKVwg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240777AbjIKOxf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:53:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE98118
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:53:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C1EC433C8;
        Mon, 11 Sep 2023 14:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444010;
        bh=+hlaxlLw7V5nxNRN6LOT6M+5l86aGJVdm5fN/f73DQ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pg17dZaQDjnXR74YEIvKjrzgEgZQQtvfqc5gBAiL5XzE6RXAx1ccG6ZJaEyyANjq6
         m+FIyX8r7hrVQBSk9KjbdolxeXj61ugK3cpKepaC4v8/s3xKJLDzVQbe/Sqy+NDtHX
         vTbU/lFhdy3GMFwlRFr92ogN5jPGgbS4zpFkcEMk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Colin Ian King <colin.i.king@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 551/737] media: go7007: Remove redundant if statement
Date:   Mon, 11 Sep 2023 15:46:50 +0200
Message-ID: <20230911134705.948077088@linuxfoundation.org>
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
index 38339dd2f83f7..2880370e45c8b 100644
--- a/drivers/media/usb/go7007/go7007-i2c.c
+++ b/drivers/media/usb/go7007/go7007-i2c.c
@@ -165,8 +165,6 @@ static int go7007_i2c_master_xfer(struct i2c_adapter *adapter,
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



