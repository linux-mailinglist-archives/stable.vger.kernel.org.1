Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDC77A7BE8
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234847AbjITL4k (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234583AbjITL4j (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:56:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D6F11A
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:56:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D58C433C7;
        Wed, 20 Sep 2023 11:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695210990;
        bh=n956jxZQz7gg8DiRTaxVaIud0dmjb0evTNIUDM8Spgs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dunQG0kXCER/a+5CukMR3DhK4sSAmSUWOhjphYQG223yGxmUFm8kbx4tNjC6uN3HJ
         40wqEUOpoYHwNTDTvIG3FpvSnlg9vQ+rLcCE3OhJHBD+RbrbyWsIVkCQCO11X4hhuD
         X0CMrn4dL5+MUBDRdQAPNDxxttGOyQDYpQXAoDd8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhang Shurong <zhang_shurong@foxmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 067/139] media: dw2102: Fix null-ptr-deref in dw2102_i2c_transfer()
Date:   Wed, 20 Sep 2023 13:30:01 +0200
Message-ID: <20230920112838.206213516@linuxfoundation.org>
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

[ Upstream commit 5ae544d94abc8ff77b1b9bf8774def3fa5689b5b ]

In dw2102_i2c_transfer, msg is controlled by user. When msg[i].buf
is null and msg[i].len is zero, former checks on msg[i].buf would be
passed. Malicious data finally reach dw2102_i2c_transfer. If accessing
msg[i].buf[0] without sanity check, null ptr deref would happen.
We add check on msg[i].len to prevent crash.

Similar commit:
commit 950e252cb469
("[media] dw2102: limit messages to buffer size")

Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/dvb-usb/dw2102.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/media/usb/dvb-usb/dw2102.c b/drivers/media/usb/dvb-usb/dw2102.c
index 8747960e61461..356fc728d59a8 100644
--- a/drivers/media/usb/dvb-usb/dw2102.c
+++ b/drivers/media/usb/dvb-usb/dw2102.c
@@ -128,6 +128,10 @@ static int dw2102_i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 
 	switch (num) {
 	case 2:
+		if (msg[0].len < 1) {
+			num = -EOPNOTSUPP;
+			break;
+		}
 		/* read stv0299 register */
 		value = msg[0].buf[0];/* register */
 		for (i = 0; i < msg[1].len; i++) {
@@ -139,6 +143,10 @@ static int dw2102_i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 	case 1:
 		switch (msg[0].addr) {
 		case 0x68:
+			if (msg[0].len < 2) {
+				num = -EOPNOTSUPP;
+				break;
+			}
 			/* write to stv0299 register */
 			buf6[0] = 0x2a;
 			buf6[1] = msg[0].buf[0];
@@ -148,6 +156,10 @@ static int dw2102_i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 			break;
 		case 0x60:
 			if (msg[0].flags == 0) {
+				if (msg[0].len < 4) {
+					num = -EOPNOTSUPP;
+					break;
+				}
 			/* write to tuner pll */
 				buf6[0] = 0x2c;
 				buf6[1] = 5;
@@ -159,6 +171,10 @@ static int dw2102_i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 				dw210x_op_rw(d->udev, 0xb2, 0, 0,
 						buf6, 7, DW210X_WRITE_MSG);
 			} else {
+				if (msg[0].len < 1) {
+					num = -EOPNOTSUPP;
+					break;
+				}
 			/* read from tuner */
 				dw210x_op_rw(d->udev, 0xb5, 0, 0,
 						buf6, 1, DW210X_READ_MSG);
@@ -166,12 +182,20 @@ static int dw2102_i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 			}
 			break;
 		case (DW2102_RC_QUERY):
+			if (msg[0].len < 2) {
+				num = -EOPNOTSUPP;
+				break;
+			}
 			dw210x_op_rw(d->udev, 0xb8, 0, 0,
 					buf6, 2, DW210X_READ_MSG);
 			msg[0].buf[0] = buf6[0];
 			msg[0].buf[1] = buf6[1];
 			break;
 		case (DW2102_VOLTAGE_CTRL):
+			if (msg[0].len < 1) {
+				num = -EOPNOTSUPP;
+				break;
+			}
 			buf6[0] = 0x30;
 			buf6[1] = msg[0].buf[0];
 			dw210x_op_rw(d->udev, 0xb2, 0, 0,
-- 
2.40.1



