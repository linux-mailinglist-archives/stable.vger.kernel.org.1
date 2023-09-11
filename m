Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E613779BB39
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352416AbjIKVtB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239147AbjIKONA (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:13:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B01CE5
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:12:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC2BC433C8;
        Mon, 11 Sep 2023 14:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441575;
        bh=R/WEInI3T5X9sWQBqqmyE8vHJR2GT4qMttOfbZydpjk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KNVUK6HFIxRXlXCmdFsyhzt92X6KyUjuvVuwL0YkOrJdQpNhFB55+4i1NQvIlStpn
         6zspT5qss+aKgKdVFD89oA0ctdCAu5hgokMPTTtYhaUUzNxwbSGAY33nGWjx6uOjsn
         cAF762Mb5ApE8IuWhXG/6ieqsYhlnFHpwW/O2Jx4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 460/739] media: dvb-usb: m920x: Fix a potential memory leak in m920x_i2c_xfer()
Date:   Mon, 11 Sep 2023 15:44:19 +0200
Message-ID: <20230911134704.003985325@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

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
index fea5bcf72a31a..c88a202daf5fc 100644
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



