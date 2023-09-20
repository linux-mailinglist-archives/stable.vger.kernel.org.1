Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77457A7BEA
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234834AbjITL4s (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234843AbjITL4s (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:56:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7CA100
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:56:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A54C433C8;
        Wed, 20 Sep 2023 11:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695210996;
        bh=N1PzgjG7aWEllmxCCkfZLde98RjeEWwscUEIgQJpKog=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LVL2QdB5XWdieL2XwNS1ULSMtv4tC+q19js4q+yuu2GUqQw2k2PtDwaBYF1gB64Is
         7VEgAZudIo8H6As7kqRv3mJlpQ9WEjgfWCXVw/PUaPEKGZh0vKpqmnhOS2vRtkpD2D
         +BsA/KLCYjBTNopglN0RlvJI61d50355DiotNC3s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhang Shurong <zhang_shurong@foxmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 068/139] media: af9005: Fix null-ptr-deref in af9005_i2c_xfer
Date:   Wed, 20 Sep 2023 13:30:02 +0200
Message-ID: <20230920112838.240036999@linuxfoundation.org>
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

[ Upstream commit f4ee84f27625ce1fdf41e8483fa0561a1b837d10 ]

In af9005_i2c_xfer, msg is controlled by user. When msg[i].buf
is null and msg[i].len is zero, former checks on msg[i].buf would be
passed. Malicious data finally reach af9005_i2c_xfer. If accessing
msg[i].buf[0] without sanity check, null ptr deref would happen.
We add check on msg[i].len to prevent crash.

Similar commit:
commit 0ed554fd769a
("media: dvb-usb: az6027: fix null-ptr-deref in az6027_i2c_xfer()")

Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/dvb-usb/af9005.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/usb/dvb-usb/af9005.c b/drivers/media/usb/dvb-usb/af9005.c
index 0827bf3d4e8c7..13604e6acdb83 100644
--- a/drivers/media/usb/dvb-usb/af9005.c
+++ b/drivers/media/usb/dvb-usb/af9005.c
@@ -422,6 +422,10 @@ static int af9005_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 		if (ret == 0)
 			ret = 2;
 	} else {
+		if (msg[0].len < 2) {
+			ret = -EOPNOTSUPP;
+			goto unlock;
+		}
 		/* write one or more registers */
 		reg = msg[0].buf[0];
 		addr = msg[0].addr;
@@ -431,6 +435,7 @@ static int af9005_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 			ret = 1;
 	}
 
+unlock:
 	mutex_unlock(&d->i2c_mutex);
 	return ret;
 }
-- 
2.40.1



