Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A94A7831DE
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjHUUJH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjHUUJH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:09:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1936DF
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:09:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8083364A64
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:09:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88B8CC433C9;
        Mon, 21 Aug 2023 20:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648544;
        bh=3Kd24lTvXcNQq6I8eFfN8B3jBvCJApVg1Qrw2F8/VPA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PlOOY1MTYQBjZg6DQexvPzQUVXMQ+4sG8SK4cAWVfS9r1A3gSD1G6xl4aSY2ys5Ue
         3YrYRSd0HID+vBZPlT7SQz6PZ10Lf+RDsQ555AzaXb/ErE1/3e6Yg7XSf0PdBEP0Bi
         TUgvnxHOoMP2RflE7q6aInjpj1Ga1y5LSduP2Toc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Poncho <poncho@spahan.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH 6.4 213/234] media: uvcvideo: Fix menu count handling for userspace XU mappings
Date:   Mon, 21 Aug 2023 21:42:56 +0200
Message-ID: <20230821194138.284912090@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

commit 6d00f4ec1205a01a6aac1fe3ce04d53a6b2ede59 upstream.

When commit 716c330433e3 ("media: uvcvideo: Use standard names for
menus") reworked the handling of menu controls, it inadvertently
replaced a GENMASK(n - 1, 0) with a BIT_MASK(n). The latter isn't
equivalent to the former, which broke adding XU mappings from userspace.
Fix it.

Link: https://lore.kernel.org/linux-media/468a36ec-c3ac-cb47-e12f-5906239ae3cd@spahan.ch/

Cc: stable@vger.kernel.org
Reported-by: Poncho <poncho@spahan.ch>
Fixes: 716c330433e3 ("media: uvcvideo: Use standard names for menus")
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/usb/uvc/uvc_v4l2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index 5ac2a424b13d..f4988f03640a 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -45,7 +45,7 @@ static int uvc_control_add_xu_mapping(struct uvc_video_chain *chain,
 	map->menu_names = NULL;
 	map->menu_mapping = NULL;
 
-	map->menu_mask = BIT_MASK(xmap->menu_count);
+	map->menu_mask = GENMASK(xmap->menu_count - 1, 0);
 
 	size = xmap->menu_count * sizeof(*map->menu_mapping);
 	map->menu_mapping = kzalloc(size, GFP_KERNEL);
-- 
2.41.0



