Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDAA6FA483
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbjEHKAM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233882AbjEHKAL (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:00:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A842CD2B
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:00:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4B9A622AE
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:00:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A17C433EF;
        Mon,  8 May 2023 10:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540009;
        bh=+tQr1AKU+iRkKDqqBwRtMFn6kX1Jk0rF+9cVhliGB8s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wAmcKmySL3AXpZCGg4ifUrElUzyyks3AWPtITUM/uj2W0p0qXKJYL3yTjOD2ZLvMR
         aUYfrpc7XCYHWnoQfO3jVPldN14x9UjyzGtMOp+Qr6/vsaAmuNzeuIjK51OCCL+S78
         5Bslf9uwM81fXVb4xuqV9SCwFykZRftdv1FXip8M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 177/611] media: max9286: Free control handler
Date:   Mon,  8 May 2023 11:40:19 +0200
Message-Id: <20230508094428.125480811@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

[ Upstream commit bfce6a12e5ba1edde95126aa06778027f16115d4 ]

The control handler is leaked in some probe-time error paths, as well as
in the remove path. Fix it.

Fixes: 66d8c9d2422d ("media: i2c: Add MAX9286 driver")
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/max9286.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/i2c/max9286.c b/drivers/media/i2c/max9286.c
index d034a67042e35..892cd97b7cab7 100644
--- a/drivers/media/i2c/max9286.c
+++ b/drivers/media/i2c/max9286.c
@@ -941,6 +941,7 @@ static int max9286_v4l2_register(struct max9286_priv *priv)
 static void max9286_v4l2_unregister(struct max9286_priv *priv)
 {
 	fwnode_handle_put(priv->sd.fwnode);
+	v4l2_ctrl_handler_free(&priv->ctrls);
 	v4l2_async_unregister_subdev(&priv->sd);
 	max9286_v4l2_notifier_unregister(priv);
 }
-- 
2.39.2



