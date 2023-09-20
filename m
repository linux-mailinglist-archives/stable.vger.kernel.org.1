Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647957A7EB8
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235289AbjITMUR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235780AbjITMT6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:19:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59B292
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:19:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1AE2C433CA;
        Wed, 20 Sep 2023 12:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695212391;
        bh=3zaeCMRKIDtBHcXKz7Quf6uzsYun4oKH+AKt/eHyQ9k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TRd5g7K1SF5dJONJ8NGQB9Tt7Ke2fqF6tO0FguF+fobBS+EfnVGI7DPV5M7IvyVG7
         SFVZHEs19VhtANouwKuBS5ZmNowoZjugm8ys1ms9n7nBfO+9IggWC+2+29LmD2UiW1
         DrnE2QMe2vFtMZ+EmwwQA6wxpS5bOUe6SXhLO7/0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhang Shurong <zhang_shurong@foxmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 258/273] media: az6007: Fix null-ptr-deref in az6007_i2c_xfer()
Date:   Wed, 20 Sep 2023 13:31:38 +0200
Message-ID: <20230920112854.243422878@linuxfoundation.org>
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

From: Zhang Shurong <zhang_shurong@foxmail.com>

[ Upstream commit 1047f9343011f2cedc73c64829686206a7e9fc3f ]

In az6007_i2c_xfer, msg is controlled by user. When msg[i].buf
is null and msg[i].len is zero, former checks on msg[i].buf would be
passed. Malicious data finally reach az6007_i2c_xfer. If accessing
msg[i].buf[0] without sanity check, null ptr deref would happen.
We add check on msg[i].len to prevent crash.

Similar commit:
commit 0ed554fd769a
("media: dvb-usb: az6027: fix null-ptr-deref in az6027_i2c_xfer()")

Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/dvb-usb-v2/az6007.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/media/usb/dvb-usb-v2/az6007.c b/drivers/media/usb/dvb-usb-v2/az6007.c
index 8e914be5b7c5e..2f40eb6bdbb83 100644
--- a/drivers/media/usb/dvb-usb-v2/az6007.c
+++ b/drivers/media/usb/dvb-usb-v2/az6007.c
@@ -796,6 +796,10 @@ static int az6007_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
 			if (az6007_xfer_debug)
 				printk(KERN_DEBUG "az6007: I2C W addr=0x%x len=%d\n",
 				       addr, msgs[i].len);
+			if (msgs[i].len < 1) {
+				ret = -EIO;
+				goto err;
+			}
 			req = AZ6007_I2C_WR;
 			index = msgs[i].buf[0];
 			value = addr | (1 << 8);
@@ -810,6 +814,10 @@ static int az6007_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
 			if (az6007_xfer_debug)
 				printk(KERN_DEBUG "az6007: I2C R addr=0x%x len=%d\n",
 				       addr, msgs[i].len);
+			if (msgs[i].len < 1) {
+				ret = -EIO;
+				goto err;
+			}
 			req = AZ6007_I2C_RD;
 			index = msgs[i].buf[0];
 			value = addr;
-- 
2.40.1



