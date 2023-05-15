Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD87703947
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244464AbjEORkt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244435AbjEORkP (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:40:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5C84C9CF
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:37:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E45A662E01
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:37:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F082DC433D2;
        Mon, 15 May 2023 17:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172260;
        bh=kMUztMBB9S30K7crN/JZ6oSouslX9ZY4hJy38IEpb5Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jPRbupH59cVmYwLkPILVK0zvu3gBRlyooqPH2it1/yb17l0DckDs/bke1D5lIgtUq
         LU549fjdkdiftoDpnp51Sna6j1ruO08Uayj9xxVxCak1uFgekxt42f7cX/lQfD7ETf
         zVyiAuNDObvsVuJHF4vrqCvnzsSxdcSklbuxTxHI=
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
Subject: [PATCH 5.10 095/381] media: max9286: Free control handler
Date:   Mon, 15 May 2023 18:25:46 +0200
Message-Id: <20230515161741.104668485@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
index 79a11c0184c65..62ce27552dd3c 100644
--- a/drivers/media/i2c/max9286.c
+++ b/drivers/media/i2c/max9286.c
@@ -899,6 +899,7 @@ static int max9286_v4l2_register(struct max9286_priv *priv)
 static void max9286_v4l2_unregister(struct max9286_priv *priv)
 {
 	fwnode_handle_put(priv->sd.fwnode);
+	v4l2_ctrl_handler_free(&priv->ctrls);
 	v4l2_async_unregister_subdev(&priv->sd);
 	max9286_v4l2_notifier_unregister(priv);
 }
-- 
2.39.2



