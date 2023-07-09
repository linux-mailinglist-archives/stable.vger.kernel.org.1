Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2864E74C2BB
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbjGILYE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbjGILYD (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:24:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E32130
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:24:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D9A260BD6
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:24:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F30CC433C8;
        Sun,  9 Jul 2023 11:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688901842;
        bh=WhRLqJwL2XzYZQDeRugeUOihRub/oI3wxyEgEUCzMzo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lqLMz9FyylxZihJXq3f0H1Kvb0h5wZViWlDnwz+uTF0ZtU1VrdCVedDy5UjhLOZ1i
         dMSuhJeJiCuZN+a6Y2nY6YmVqSyW2+IiBLJfoyHLzfJ4DoYt8NHPnQn1rh2S4Mu2v3
         vlQhkwHPLsz4LCLROASioGAS1N9Pg7E2MDJ6vTng=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Markus Elfring <elfring@users.sourceforge.net>,
        Robert Foss <rfoss@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 164/431] drm/bridge: it6505: Move a variable assignment behind a null pointer check in receive_timing_debugfs_show()
Date:   Sun,  9 Jul 2023 13:11:52 +0200
Message-ID: <20230709111455.019130152@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>

[ Upstream commit 0be05a75de2916421e88e0d64b001984f54df0bd ]

The address of a data structure member was determined before
a corresponding null pointer check in the implementation of
the function “receive_timing_debugfs_show”.

Thus avoid the risk for undefined behaviour by moving the assignment
for the variable “vid” behind the null pointer check.

This issue was detected by using the Coccinelle software.

Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Link: https://patchwork.freedesktop.org/patch/msgid/fa69384f-1485-142b-c4ee-3df54ac68a89@web.de
Reviewed-by: Robert Foss <rfoss@kernel.org>
Signed-off-by: Robert Foss <rfoss@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index bc451b2a77c28..32ea61b79965e 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -3195,7 +3195,7 @@ static ssize_t receive_timing_debugfs_show(struct file *file, char __user *buf,
 					   size_t len, loff_t *ppos)
 {
 	struct it6505 *it6505 = file->private_data;
-	struct drm_display_mode *vid = &it6505->video_info;
+	struct drm_display_mode *vid;
 	u8 read_buf[READ_BUFFER_SIZE];
 	u8 *str = read_buf, *end = read_buf + READ_BUFFER_SIZE;
 	ssize_t ret, count;
@@ -3204,6 +3204,7 @@ static ssize_t receive_timing_debugfs_show(struct file *file, char __user *buf,
 		return -ENODEV;
 
 	it6505_calc_video_info(it6505);
+	vid = &it6505->video_info;
 	str += scnprintf(str, end - str, "---video timing---\n");
 	str += scnprintf(str, end - str, "PCLK:%d.%03dMHz\n",
 			 vid->clock / 1000, vid->clock % 1000);
-- 
2.39.2



