Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A92E7A386F
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239824AbjIQTgB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238857AbjIQTf1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:35:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49DCD9
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:35:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA96AC433C7;
        Sun, 17 Sep 2023 19:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979322;
        bh=FHkBQ0A1C1SnQQMe8SZWDJHZe4/jmNiHLFXx4oySq0E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fLnp5fLu3AWEO5FYJTAT/o4xCJNmLdnjGHMLnEiGo/BXZ4hiHa4JWgeswLILSqmcb
         QfAjc9+z73ngDv7lE18KZh6eJaw8BzNhOk+JidxM3F30Z+nQ+sDsL6PU5AR1KaHge2
         P5kvvoH6JKeN7bcXCzf33YwxRzl88+xOsnBRMP8o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
        Benjamin Tissoires <bentiss@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 252/406] HID: logitech-dj: Fix error handling in logi_dj_recv_switch_to_dj_mode()
Date:   Sun, 17 Sep 2023 21:11:46 +0200
Message-ID: <20230917191107.823816107@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>

[ Upstream commit 6f20d3261265885f6a6be4cda49d7019728760e0 ]

Presently, if a call to logi_dj_recv_send_report() fails, we do
not learn about the error until after sending short
HID_OUTPUT_REPORT with hid_hw_raw_request().
To handle this somewhat unlikely issue, return on error in
logi_dj_recv_send_report() (minding ugly sleep workaround) and
take into account the result of hid_hw_raw_request().

Found by Linux Verification Center (linuxtesting.org) with static
analysis tool SVACE.

Fixes: 6a9ddc897883 ("HID: logitech-dj: enable notifications on connect/disconnect")
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Link: https://lore.kernel.org/r/20230613101635.77820-1-n.zhandarovich@fintech.ru
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-logitech-dj.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index 587259b3db97c..f4d79ec826797 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -1217,6 +1217,9 @@ static int logi_dj_recv_switch_to_dj_mode(struct dj_receiver_dev *djrcv_dev,
 		 * 50 msec should gives enough time to the receiver to be ready.
 		 */
 		msleep(50);
+
+		if (retval)
+			return retval;
 	}
 
 	/*
@@ -1238,7 +1241,7 @@ static int logi_dj_recv_switch_to_dj_mode(struct dj_receiver_dev *djrcv_dev,
 	buf[5] = 0x09;
 	buf[6] = 0x00;
 
-	hid_hw_raw_request(hdev, REPORT_ID_HIDPP_SHORT, buf,
+	retval = hid_hw_raw_request(hdev, REPORT_ID_HIDPP_SHORT, buf,
 			HIDPP_REPORT_SHORT_LENGTH, HID_OUTPUT_REPORT,
 			HID_REQ_SET_REPORT);
 
-- 
2.40.1



