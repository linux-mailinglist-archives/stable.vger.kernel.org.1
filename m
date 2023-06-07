Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBF9726CA1
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233943AbjFGUfH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234042AbjFGUfA (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:35:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6782690
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:34:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C11F64552
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:34:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 937BAC433D2;
        Wed,  7 Jun 2023 20:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170082;
        bh=qpilShCwED7f0bXYutKGopJXm9f9b0FCMRyNydBedBc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dOKJdSnerjOrHwhN7Q6D0ypxZxUVbfMKle5TVOl9NvsekujWYWp/yhVRH/0I39ZWm
         7alJqPU6OHLgVTqk7Zo9Gh9iFN8iUmXG4kPcaLq+uPWmOpnY0ByMgnP1HsZrKt/mXE
         hEynG1nOHs+jVWPmzz9guYNzR+0mN8aFW6vHVVWY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Wei Chen <harperchen1110@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 39/88] media: dvb-usb: az6027: fix three null-ptr-deref in az6027_i2c_xfer()
Date:   Wed,  7 Jun 2023 22:15:56 +0200
Message-ID: <20230607200900.439364273@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200854.030202132@linuxfoundation.org>
References: <20230607200854.030202132@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Wei Chen <harperchen1110@gmail.com>

[ Upstream commit 858e97d7956d17a2cb56a9413468704a4d5abfe1 ]

In az6027_i2c_xfer, msg is controlled by user. When msg[i].buf is null,
commit 0ed554fd769a ("media: dvb-usb: az6027: fix null-ptr-deref in
az6027_i2c_xfer()") fix the null-ptr-deref bug when msg[i].addr is 0x99.
However, null-ptr-deref also happens when msg[i].addr is 0xd0 and 0xc0.
We add check on msg[i].len to prevent null-ptr-deref.

Link: https://lore.kernel.org/linux-media/20230310165604.3093483-1-harperchen1110@gmail.com
Signed-off-by: Wei Chen <harperchen1110@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/dvb-usb/az6027.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/media/usb/dvb-usb/az6027.c b/drivers/media/usb/dvb-usb/az6027.c
index 7d71ac7811ebd..fdd57d84cfa42 100644
--- a/drivers/media/usb/dvb-usb/az6027.c
+++ b/drivers/media/usb/dvb-usb/az6027.c
@@ -991,6 +991,10 @@ static int az6027_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[], int n
 			/* write/read request */
 			if (i + 1 < num && (msg[i + 1].flags & I2C_M_RD)) {
 				req = 0xB9;
+				if (msg[i].len < 1) {
+					i = -EOPNOTSUPP;
+					break;
+				}
 				index = (((msg[i].buf[0] << 8) & 0xff00) | (msg[i].buf[1] & 0x00ff));
 				value = msg[i].addr + (msg[i].len << 8);
 				length = msg[i + 1].len + 6;
@@ -1004,6 +1008,10 @@ static int az6027_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[], int n
 
 				/* demod 16bit addr */
 				req = 0xBD;
+				if (msg[i].len < 1) {
+					i = -EOPNOTSUPP;
+					break;
+				}
 				index = (((msg[i].buf[0] << 8) & 0xff00) | (msg[i].buf[1] & 0x00ff));
 				value = msg[i].addr + (2 << 8);
 				length = msg[i].len - 2;
@@ -1029,6 +1037,10 @@ static int az6027_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[], int n
 			} else {
 
 				req = 0xBD;
+				if (msg[i].len < 1) {
+					i = -EOPNOTSUPP;
+					break;
+				}
 				index = msg[i].buf[0] & 0x00FF;
 				value = msg[i].addr + (1 << 8);
 				length = msg[i].len - 1;
-- 
2.39.2



