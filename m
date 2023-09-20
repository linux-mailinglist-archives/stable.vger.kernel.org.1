Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8777A7B09
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234465AbjITLsq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234628AbjITLsp (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:48:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A3CB4
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:48:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD63C433C9;
        Wed, 20 Sep 2023 11:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695210518;
        bh=x8IbYFp8DsrWzpnoMp1aH7fGz72miMnsdpkTmfOUMlY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B16ik+p+E1ir3MArFZq4TXxDSqEkTq8ItvnOMhPXCB97bbSiRiAbdSbD7qaOV9nnF
         RRjForkRSO+yiy1RC6kebAHtd5bOrcKZ7zfDaMgl5WYZJwM2ycmMpNqFnuMP846CQA
         FMB2aw0OXsGYEUC1hmDByU7x9Yp6B3Y0eqLMokmM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhang Shurong <zhang_shurong@foxmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 107/211] media: af9005: Fix null-ptr-deref in af9005_i2c_xfer
Date:   Wed, 20 Sep 2023 13:29:11 +0200
Message-ID: <20230920112849.112173944@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112845.859868994@linuxfoundation.org>
References: <20230920112845.859868994@linuxfoundation.org>
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



