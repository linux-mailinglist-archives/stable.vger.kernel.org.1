Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32AFC79BDD4
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344318AbjIKVNv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239128AbjIKOMc (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:12:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD96CE5
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:12:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58890C433C9;
        Mon, 11 Sep 2023 14:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441547;
        bh=SduPr7mFjpHImEurGeSuKSuz1RzHiiW2oDutr+cChJU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2vPn/3r54xd6Q2PkqYvctb7ogBe4H/weIo5jid8QYcaN2JKS7XFIGxQQrCsqWSvW3
         xHk3sYjYj/mh3udATU8n+q6JUVrSacyOsq/K3DcIgin9W+sO7JC6pw+TCuHtt7vW2A
         E6APiDjKuIX+iAQ2eEal6cOM9+UZ2dGK9tXnlKm0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, "Guoniu.zhou" <guoniu.zhou@nxp.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 451/739] media: ov5640: fix low resolution image abnormal issue
Date:   Mon, 11 Sep 2023 15:44:10 +0200
Message-ID: <20230911134703.758262895@linuxfoundation.org>
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

From: Guoniu.zhou <guoniu.zhou@nxp.com>

[ Upstream commit a828002f38c5ee49d3f0c0e64c0f0caa1aec8dc2 ]

OV5640 will output abnormal image data when work at low resolution
(320x240, 176x144 and 160x120) after switching from high resolution,
such as 1080P, the time interval between high and low switching must
be less than 1000ms in order to OV5640 don't enter suspend state during
the time.

The reason is by 0x3824 value don't restore to initialize value when
do resolution switching. In high resolution setting array, 0x3824 is
set to 0x04, but low resolution setting array remove 0x3824 in commit
db15c1957a2d ("media: ov5640: Remove duplicated mode settings"). So
when do resolution switching from high to low, such as 1080P to 320x240,
and the time interval is less than auto suspend delay time which means
global initialize setting array will not be loaded, the output image
data are abnormal. Hence move 0x3824 from ov5640_init_setting[] table
to ov5640_setting_low_res[] table and also move 0x4407 0x460b, 0x460c
to avoid same issue.

Fixes: db15c1957a2d ("media: ov5640: Remove duplicated mode settings")
Signed-off-by: Guoniu.zhou <guoniu.zhou@nxp.com>
Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/ov5640.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/media/i2c/ov5640.c b/drivers/media/i2c/ov5640.c
index 36b509714c8c7..f6c94e9094761 100644
--- a/drivers/media/i2c/ov5640.c
+++ b/drivers/media/i2c/ov5640.c
@@ -568,9 +568,7 @@ static const struct reg_value ov5640_init_setting[] = {
 	{0x4001, 0x02, 0, 0}, {0x4004, 0x02, 0, 0}, {0x3000, 0x00, 0, 0},
 	{0x3002, 0x1c, 0, 0}, {0x3004, 0xff, 0, 0}, {0x3006, 0xc3, 0, 0},
 	{0x302e, 0x08, 0, 0}, {0x4300, 0x3f, 0, 0},
-	{0x501f, 0x00, 0, 0}, {0x4407, 0x04, 0, 0},
-	{0x440e, 0x00, 0, 0}, {0x460b, 0x35, 0, 0}, {0x460c, 0x22, 0, 0},
-	{0x4837, 0x0a, 0, 0}, {0x3824, 0x02, 0, 0},
+	{0x501f, 0x00, 0, 0}, {0x440e, 0x00, 0, 0}, {0x4837, 0x0a, 0, 0},
 	{0x5000, 0xa7, 0, 0}, {0x5001, 0xa3, 0, 0}, {0x5180, 0xff, 0, 0},
 	{0x5181, 0xf2, 0, 0}, {0x5182, 0x00, 0, 0}, {0x5183, 0x14, 0, 0},
 	{0x5184, 0x25, 0, 0}, {0x5185, 0x24, 0, 0}, {0x5186, 0x09, 0, 0},
@@ -634,7 +632,8 @@ static const struct reg_value ov5640_setting_low_res[] = {
 	{0x3a0a, 0x00, 0, 0}, {0x3a0b, 0xf6, 0, 0}, {0x3a0e, 0x03, 0, 0},
 	{0x3a0d, 0x04, 0, 0}, {0x3a14, 0x03, 0, 0}, {0x3a15, 0xd8, 0, 0},
 	{0x4001, 0x02, 0, 0}, {0x4004, 0x02, 0, 0},
-	{0x4407, 0x04, 0, 0}, {0x5001, 0xa3, 0, 0},
+	{0x4407, 0x04, 0, 0}, {0x460b, 0x35, 0, 0}, {0x460c, 0x22, 0, 0},
+	{0x3824, 0x02, 0, 0}, {0x5001, 0xa3, 0, 0},
 };
 
 static const struct reg_value ov5640_setting_720P_1280_720[] = {
-- 
2.40.1



