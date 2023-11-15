Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7CDA7ECE48
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234951AbjKOTmG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbjKOTmF (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:42:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23711A3
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:42:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60773C433C8;
        Wed, 15 Nov 2023 19:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077321;
        bh=Zz01tjpAsAtKezKZQ0XTTG3d0CtHclSgouwVKSEZubs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sLslY8lsf1gumnl5QyLsZmkNSQQrFjVA9O2LHE5nw0FWZ5n1ssx2h0ErQne3lyin6
         ctySLtUdSZvd+ZRioa55oueK9FkFYbrEjfT/nujAn0AlalaZLu9XeH7uRZ1hxf2Pdd
         SBlIAcBNYLgm0zeLF5Z/EhUtYVRU0R6TAdcIADjs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Geert Uytterhoeven <geert@linux-m68k.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 229/603] drm/ssd130x: Fix screen clearing
Date:   Wed, 15 Nov 2023 14:12:54 -0500
Message-ID: <20231115191629.047323275@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert@linux-m68k.org>

[ Upstream commit 4dbce3d6fea59e1df1d1a35aacea0c186f72107a ]

Due to the reuse of buffers, ssd130x_clear_screen() no longers clears
the screen, but merely redraws the last image that is residing in the
intermediate buffer.

As there is no point in clearing the intermediate buffer and transposing
an all-black image, fix this by just clearing the HW format buffer, and
writing it to the panel.

Fixes: 49d7d581ceaf4cf8 ("drm/ssd130x: Don't allocate buffers on each plane update")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Tested-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/c19cd5a57205597bb38a446c3871092993498f01.1692888745.git.geert@linux-m68k.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/solomon/ssd130x.c | 47 +++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index 5a80b228d18ca..78272b1f9d5b1 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -553,14 +553,45 @@ static int ssd130x_update_rect(struct ssd130x_device *ssd130x,
 static void ssd130x_clear_screen(struct ssd130x_device *ssd130x,
 				 struct ssd130x_plane_state *ssd130x_state)
 {
-	struct drm_rect fullscreen = {
-		.x1 = 0,
-		.x2 = ssd130x->width,
-		.y1 = 0,
-		.y2 = ssd130x->height,
-	};
-
-	ssd130x_update_rect(ssd130x, ssd130x_state, &fullscreen);
+	unsigned int page_height = ssd130x->device_info->page_height;
+	unsigned int pages = DIV_ROUND_UP(ssd130x->height, page_height);
+	u8 *data_array = ssd130x_state->data_array;
+	unsigned int width = ssd130x->width;
+	int ret, i;
+
+	if (!ssd130x->page_address_mode) {
+		memset(data_array, 0, width * pages);
+
+		/* Set address range for horizontal addressing mode */
+		ret = ssd130x_set_col_range(ssd130x, ssd130x->col_offset, width);
+		if (ret < 0)
+			return;
+
+		ret = ssd130x_set_page_range(ssd130x, ssd130x->page_offset, pages);
+		if (ret < 0)
+			return;
+
+		/* Write out update in one go if we aren't using page addressing mode */
+		ssd130x_write_data(ssd130x, data_array, width * pages);
+	} else {
+		/*
+		 * In page addressing mode, the start address needs to be reset,
+		 * and each page then needs to be written out separately.
+		 */
+		memset(data_array, 0, width);
+
+		for (i = 0; i < pages; i++) {
+			ret = ssd130x_set_page_pos(ssd130x,
+						   ssd130x->page_offset + i,
+						   ssd130x->col_offset);
+			if (ret < 0)
+				return;
+
+			ret = ssd130x_write_data(ssd130x, data_array, width);
+			if (ret < 0)
+				return;
+		}
+	}
 }
 
 static int ssd130x_fb_blit_rect(struct drm_plane_state *state,
-- 
2.42.0



