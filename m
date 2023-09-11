Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42CAD79BE55
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242171AbjIKVSD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242045AbjIKPVH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:21:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481A39B
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:21:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E03C433C7;
        Mon, 11 Sep 2023 15:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445662;
        bh=ZQH5mltMEjYtoqERMly4I5jNHxEDriiUnzNKDmbE7OM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RrHGoGODy/IYszfZdDDTWSThLR8XIFHUXoFgn7yzn+dsaFnvFwdaYtdsxa6sJoI9z
         6v1cgnsBzMB7gJBauEf3AkvSrBxIwUkde4hZFwuOiqTjupgWt5loQiOXRYQQxbPae4
         QCcMKi1JovI5e2GmdQGZJckx358gGMigslWsDF8c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 399/600] media: dvb-usb: m920x: Fix a potential memory leak in m920x_i2c_xfer()
Date:   Mon, 11 Sep 2023 15:47:12 +0200
Message-ID: <20230911134645.452016680@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
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

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit ea9ef6c2e001c5dc94bee35ebd1c8a98621cf7b8 ]

'read' is freed when it is known to be NULL, but not when a read error
occurs.

Revert the logic to avoid a small leak, should a m920x_read() call fail.

Fixes: a2ab06d7c4d6 ("media: m920x: don't use stack on USB reads")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/dvb-usb/m920x.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/dvb-usb/m920x.c b/drivers/media/usb/dvb-usb/m920x.c
index 548199cd86f60..11f4f0455f155 100644
--- a/drivers/media/usb/dvb-usb/m920x.c
+++ b/drivers/media/usb/dvb-usb/m920x.c
@@ -277,7 +277,6 @@ static int m920x_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[], int nu
 			char *read = kmalloc(1, GFP_KERNEL);
 			if (!read) {
 				ret = -ENOMEM;
-				kfree(read);
 				goto unlock;
 			}
 
@@ -288,8 +287,10 @@ static int m920x_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[], int nu
 
 				if ((ret = m920x_read(d->udev, M9206_I2C, 0x0,
 						      0x20 | stop,
-						      read, 1)) != 0)
+						      read, 1)) != 0) {
+					kfree(read);
 					goto unlock;
+				}
 				msg[i].buf[j] = read[0];
 			}
 
-- 
2.40.1



