Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6727726EFD
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235365AbjFGUye (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235486AbjFGUyY (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:54:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAF6269A
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:54:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCEC9647C3
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:54:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF208C433EF;
        Wed,  7 Jun 2023 20:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686171259;
        bh=7cAly7DcdgfqYX85ezVGq42ONFyTzMCckcBCyWirnak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hFT8RIT+Xm+sPQ8lyjSv2Vg8SWDRjqOtDPp9UvlUDvhViTLKMg73PgXbhfwzvQr2N
         R58B865Y+k4o0cl1zBqPncZyN2AWayX4lqaAkBhe8LjPjjcAQQpdXrFgA8IiHBSWW8
         DGKz48wtsijWIvE1V/d1lSRL6LLs8X/t2VPwuxrU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhang Shurong <zhang_shurong@foxmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 42/99] media: dvb-usb-v2: rtl28xxu: fix null-ptr-deref in rtl28xxu_i2c_xfer
Date:   Wed,  7 Jun 2023 22:16:34 +0200
Message-ID: <20230607200901.570484836@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200900.195572674@linuxfoundation.org>
References: <20230607200900.195572674@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Zhang Shurong <zhang_shurong@foxmail.com>

[ Upstream commit aa4a447b81b84f69c1a89ad899df157f386d7636 ]

In rtl28xxu_i2c_xfer, msg is controlled by user. When msg[i].buf
is null and msg[i].len is zero, former checks on msg[i].buf would be
passed. Malicious data finally reach rtl28xxu_i2c_xfer. If accessing
msg[i].buf[0] without sanity check, null ptr deref would happen.
We add check on msg[i].len to prevent crash.

Similar commit:
commit 0ed554fd769a
("media: dvb-usb: az6027: fix null-ptr-deref in az6027_i2c_xfer()")

Link: https://lore.kernel.org/linux-media/tencent_3623572106754AC2F266B316798B0F6CCA05@qq.com
Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/dvb-usb-v2/rtl28xxu.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/media/usb/dvb-usb-v2/rtl28xxu.c b/drivers/media/usb/dvb-usb-v2/rtl28xxu.c
index 0fe71437601e7..ec9bbd8c89ad3 100644
--- a/drivers/media/usb/dvb-usb-v2/rtl28xxu.c
+++ b/drivers/media/usb/dvb-usb-v2/rtl28xxu.c
@@ -176,6 +176,10 @@ static int rtl28xxu_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 			ret = -EOPNOTSUPP;
 			goto err_mutex_unlock;
 		} else if (msg[0].addr == 0x10) {
+			if (msg[0].len < 1 || msg[1].len < 1) {
+				ret = -EOPNOTSUPP;
+				goto err_mutex_unlock;
+			}
 			/* method 1 - integrated demod */
 			if (msg[0].buf[0] == 0x00) {
 				/* return demod page from driver cache */
@@ -189,6 +193,10 @@ static int rtl28xxu_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 				ret = rtl28xxu_ctrl_msg(d, &req);
 			}
 		} else if (msg[0].len < 2) {
+			if (msg[0].len < 1) {
+				ret = -EOPNOTSUPP;
+				goto err_mutex_unlock;
+			}
 			/* method 2 - old I2C */
 			req.value = (msg[0].buf[0] << 8) | (msg[0].addr << 1);
 			req.index = CMD_I2C_RD;
@@ -217,8 +225,16 @@ static int rtl28xxu_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 			ret = -EOPNOTSUPP;
 			goto err_mutex_unlock;
 		} else if (msg[0].addr == 0x10) {
+			if (msg[0].len < 1) {
+				ret = -EOPNOTSUPP;
+				goto err_mutex_unlock;
+			}
 			/* method 1 - integrated demod */
 			if (msg[0].buf[0] == 0x00) {
+				if (msg[0].len < 2) {
+					ret = -EOPNOTSUPP;
+					goto err_mutex_unlock;
+				}
 				/* save demod page for later demod access */
 				dev->page = msg[0].buf[1];
 				ret = 0;
@@ -231,6 +247,10 @@ static int rtl28xxu_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 				ret = rtl28xxu_ctrl_msg(d, &req);
 			}
 		} else if ((msg[0].len < 23) && (!dev->new_i2c_write)) {
+			if (msg[0].len < 1) {
+				ret = -EOPNOTSUPP;
+				goto err_mutex_unlock;
+			}
 			/* method 2 - old I2C */
 			req.value = (msg[0].buf[0] << 8) | (msg[0].addr << 1);
 			req.index = CMD_I2C_WR;
-- 
2.39.2



