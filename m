Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981BB7A7BED
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234583AbjITL46 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234890AbjITL45 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:56:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5849CF7
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:56:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A33C1C433C9;
        Wed, 20 Sep 2023 11:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695211004;
        bh=JedBv2KfopEh38qIlbNa0Iubgt/wepbBBnhYNuF5daw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v7uKJFLqC+B5wH/YAyakOSJy8WCFdAUBh2593cFnBTB1l1T26IlGoKbpq8JVyuL3k
         Qprc/qws8NLuvPgJTyj1gQktw/bj7kAFSefs8nBfaZbl8t/Li1hVLjDVEDBJUEJ/Ds
         JQnq6/pJ0D0QmBQhrxu4SSlNqx7YsC0fT6CuL/R0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhang Shurong <zhang_shurong@foxmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 071/139] media: dvb-usb-v2: gl861: Fix null-ptr-deref in gl861_i2c_master_xfer
Date:   Wed, 20 Sep 2023 13:30:05 +0200
Message-ID: <20230920112838.340959278@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112835.549467415@linuxfoundation.org>
References: <20230920112835.549467415@linuxfoundation.org>
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

From: Zhang Shurong <zhang_shurong@foxmail.com>

[ Upstream commit b97719a66970601cd3151a3e2020f4454a1c4ff6 ]

In gl861_i2c_master_xfer, msg is controlled by user. When msg[i].buf
is null and msg[i].len is zero, former checks on msg[i].buf would be
passed. Malicious data finally reach gl861_i2c_master_xfer. If accessing
msg[i].buf[0] without sanity check, null ptr deref would happen.
We add check on msg[i].len to prevent crash.

Similar commit:
commit 0ed554fd769a
("media: dvb-usb: az6027: fix null-ptr-deref in az6027_i2c_xfer()")

Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/dvb-usb-v2/gl861.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/dvb-usb-v2/gl861.c b/drivers/media/usb/dvb-usb-v2/gl861.c
index 0c434259c36f1..c71e7b93476de 100644
--- a/drivers/media/usb/dvb-usb-v2/gl861.c
+++ b/drivers/media/usb/dvb-usb-v2/gl861.c
@@ -120,7 +120,7 @@ static int gl861_i2c_master_xfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 	} else if (num == 2 && !(msg[0].flags & I2C_M_RD) &&
 		   (msg[1].flags & I2C_M_RD)) {
 		/* I2C write + read */
-		if (msg[0].len > 1 || msg[1].len > sizeof(ctx->buf)) {
+		if (msg[0].len != 1 || msg[1].len > sizeof(ctx->buf)) {
 			ret = -EOPNOTSUPP;
 			goto err;
 		}
-- 
2.40.1



