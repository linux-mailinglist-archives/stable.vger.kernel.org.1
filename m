Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90BFE7A8197
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234840AbjITMq6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234837AbjITMq5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:46:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F19AD7
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:46:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B32DC433D9;
        Wed, 20 Sep 2023 12:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695214002;
        bh=NiObPo46xLAHwQaQEKhR6OPeSRojGSMx50694hZw/UQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xcnV2XiRfaEfGE/9Rf7i2vu21OQpeZ4OG6GkvCx4DdD3HJDvlg2WWF7I2EuYrQRPR
         8nHPo62IuDBykSY9fXgepHeORCfzP/WybLydmEzOOAOg79+FZ7FqOX+55DqQD35voi
         Qb8ACcVVmzoBNiSZg0MJ7G/SzY7hDO1MtKIfxqik=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jinjie Ruan <ruanjinjie@huawei.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 076/110] drm: gm12u320: Fix the timeout usage for usb_bulk_msg()
Date:   Wed, 20 Sep 2023 13:32:14 +0200
Message-ID: <20230920112833.262474439@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112830.377666128@linuxfoundation.org>
References: <20230920112830.377666128@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jinjie Ruan <ruanjinjie@huawei.com>

[ Upstream commit 7583028d359db3cd0072badcc576b4f9455fd27a ]

The timeout arg of usb_bulk_msg() is ms already, which has been converted
to jiffies by msecs_to_jiffies() in usb_start_wait_urb(). So fix the usage
by removing the redundant msecs_to_jiffies() in the macros.

And as Hans suggested, also remove msecs_to_jiffies() for the IDLE_TIMEOUT
macro to make it consistent here and so change IDLE_TIMEOUT to
msecs_to_jiffies(IDLE_TIMEOUT) where it is used.

Fixes: e4f86e437164 ("drm: Add Grain Media GM12U320 driver v2")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Suggested-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Link: https://patchwork.freedesktop.org/patch/msgid/20230904021421.1663892-1-ruanjinjie@huawei.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/tiny/gm12u320.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/tiny/gm12u320.c b/drivers/gpu/drm/tiny/gm12u320.c
index 6bc0c298739cc..9985a4419bb0c 100644
--- a/drivers/gpu/drm/tiny/gm12u320.c
+++ b/drivers/gpu/drm/tiny/gm12u320.c
@@ -67,10 +67,10 @@ MODULE_PARM_DESC(eco_mode, "Turn on Eco mode (less bright, more silent)");
 #define READ_STATUS_SIZE		13
 #define MISC_VALUE_SIZE			4
 
-#define CMD_TIMEOUT			msecs_to_jiffies(200)
-#define DATA_TIMEOUT			msecs_to_jiffies(1000)
-#define IDLE_TIMEOUT			msecs_to_jiffies(2000)
-#define FIRST_FRAME_TIMEOUT		msecs_to_jiffies(2000)
+#define CMD_TIMEOUT			200
+#define DATA_TIMEOUT			1000
+#define IDLE_TIMEOUT			2000
+#define FIRST_FRAME_TIMEOUT		2000
 
 #define MISC_REQ_GET_SET_ECO_A		0xff
 #define MISC_REQ_GET_SET_ECO_B		0x35
@@ -386,7 +386,7 @@ static void gm12u320_fb_update_work(struct work_struct *work)
 	 * switches back to showing its logo.
 	 */
 	queue_delayed_work(system_long_wq, &gm12u320->fb_update.work,
-			   IDLE_TIMEOUT);
+			   msecs_to_jiffies(IDLE_TIMEOUT));
 
 	return;
 err:
-- 
2.40.1



