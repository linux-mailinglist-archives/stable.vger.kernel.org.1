Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB7D7ED58C
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 22:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344704AbjKOVHh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 16:07:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235604AbjKOVH0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 16:07:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0993F1A1
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 13:07:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9174BC4E764;
        Wed, 15 Nov 2023 20:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081525;
        bh=89YU0Zp/mifB7bkWS6rs0FrHzir8ejHYzukBP50lGy8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vVG4yPNH4nK3x4oJYzEBBhZvvrGtwnFAhjvqUgCHKgUfLyvA4Beb/COSfD/ubQ/BY
         eAK3zV6zD+FIVM8ExLGqmxXkZxUMn616YxnJnK2nRK6AuZCcJxH8AaVSqoem9hbtHu
         EGn0vvBufv2fw6jzm14itHMqWAfjvfULzjUaTSkM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 207/244] media: dvb-usb-v2: af9035: fix missing unlock
Date:   Wed, 15 Nov 2023 15:36:39 -0500
Message-ID: <20231115203600.780418995@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115203548.387164783@linuxfoundation.org>
References: <20231115203548.387164783@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

[ Upstream commit f31b2cb85f0ee165d78e1c43f6d69f82cc3b2145 ]

Instead of returning an error, goto the mutex unlock at
the end of the function.

Fixes smatch warning:

drivers/media/usb/dvb-usb-v2/af9035.c:467 af9035_i2c_master_xfer() warn: inconsistent returns '&d->i2c_mutex'.
  Locked on  : 326,387
  Unlocked on: 465,467

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Fixes: 7bf744f2de0a ("media: dvb-usb-v2: af9035: Fix null-ptr-deref in af9035_i2c_master_xfer")
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/dvb-usb-v2/af9035.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/media/usb/dvb-usb-v2/af9035.c b/drivers/media/usb/dvb-usb-v2/af9035.c
index 56bb507fca214..dabfe9b332226 100644
--- a/drivers/media/usb/dvb-usb-v2/af9035.c
+++ b/drivers/media/usb/dvb-usb-v2/af9035.c
@@ -323,8 +323,10 @@ static int af9035_i2c_master_xfer(struct i2c_adapter *adap,
 			ret = -EOPNOTSUPP;
 		} else if ((msg[0].addr == state->af9033_i2c_addr[0]) ||
 			   (msg[0].addr == state->af9033_i2c_addr[1])) {
-			if (msg[0].len < 3 || msg[1].len < 1)
-				return -EOPNOTSUPP;
+			if (msg[0].len < 3 || msg[1].len < 1) {
+				ret = -EOPNOTSUPP;
+				goto unlock;
+			}
 			/* demod access via firmware interface */
 			reg = msg[0].buf[0] << 16 | msg[0].buf[1] << 8 |
 					msg[0].buf[2];
@@ -384,8 +386,10 @@ static int af9035_i2c_master_xfer(struct i2c_adapter *adap,
 			ret = -EOPNOTSUPP;
 		} else if ((msg[0].addr == state->af9033_i2c_addr[0]) ||
 			   (msg[0].addr == state->af9033_i2c_addr[1])) {
-			if (msg[0].len < 3)
-				return -EOPNOTSUPP;
+			if (msg[0].len < 3) {
+				ret = -EOPNOTSUPP;
+				goto unlock;
+			}
 			/* demod access via firmware interface */
 			reg = msg[0].buf[0] << 16 | msg[0].buf[1] << 8 |
 					msg[0].buf[2];
@@ -460,6 +464,7 @@ static int af9035_i2c_master_xfer(struct i2c_adapter *adap,
 		ret = -EOPNOTSUPP;
 	}
 
+unlock:
 	mutex_unlock(&d->i2c_mutex);
 
 	if (ret < 0)
-- 
2.42.0



