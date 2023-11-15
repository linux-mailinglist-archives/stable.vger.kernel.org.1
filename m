Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D4E7ED436
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235064AbjKOU5T (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235585AbjKOU5P (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:57:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37EF61AD
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:57:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90068C4E779;
        Wed, 15 Nov 2023 20:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081831;
        bh=OBvH0PwmBggZW9hgKfHoSHt6W1Zt3w2u5Gsb9xSu+uQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HaEyvnhm+K3r9APah3sbuoDB/xZ4G/InYxr6kstZjw4+h6wr7nVjeU0RPUboCQSX9
         oyQg3oyjRs6gDCWwSpST6iy8tJoSHDWjvAuG0ir073ptQuyPabVQlp177kuLN200WM
         mFCyr4HrCfCe4iM4gw9dTQUt/KluKSsBghG8cjdA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 153/191] media: i2c: max9286: Fix some redundant of_node_put() calls
Date:   Wed, 15 Nov 2023 15:47:08 -0500
Message-ID: <20231115204653.673162185@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115204644.490636297@linuxfoundation.org>
References: <20231115204644.490636297@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 0822315e46b400f611cba1193456ee6a5dc3e41d ]

This is odd to have a of_node_put() just after a for_each_child_of_node()
or a for_each_endpoint_of_node() loop. It should already be called
during the last iteration.

Remove these calls.

Fixes: 66d8c9d2422d ("media: i2c: Add MAX9286 driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/max9286.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/media/i2c/max9286.c b/drivers/media/i2c/max9286.c
index 62ce27552dd3c..a358eb3fe0f4d 100644
--- a/drivers/media/i2c/max9286.c
+++ b/drivers/media/i2c/max9286.c
@@ -1143,7 +1143,6 @@ static int max9286_parse_dt(struct max9286_priv *priv)
 
 		i2c_mux_mask |= BIT(id);
 	}
-	of_node_put(node);
 	of_node_put(i2c_mux);
 
 	/* Parse the endpoints */
@@ -1207,7 +1206,6 @@ static int max9286_parse_dt(struct max9286_priv *priv)
 		priv->source_mask |= BIT(ep.port);
 		priv->nsources++;
 	}
-	of_node_put(node);
 
 	priv->route_mask = priv->source_mask;
 
-- 
2.42.0



