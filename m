Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F157A3C1C
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240917AbjIQU0q (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240991AbjIQU0g (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:26:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58ABF101
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:26:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BA34C433C7;
        Sun, 17 Sep 2023 20:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694982391;
        bh=SrOre4N5gqiaA52p9dl9rveDnVOnVtafQn9m9eyG7F8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qjbCdZI7TNhozCctEBrAIGoi6Nsi1sRmh3hkPHtWpSqgETiyJVK0QpCzVvE0Y8K0E
         zkM674s90Coo2OuvpeIvUawL84za81wDGOk8pAbmNCJ5LWpUT/R5HZe65KbpsgkeHw
         uN9bpScW/qr0LZ+HWaX+s1Dc60ep+6nTZRB4sTns=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 236/511] media: i2c: tvp5150: check return value of devm_kasprintf()
Date:   Sun, 17 Sep 2023 21:11:03 +0200
Message-ID: <20230917191119.510513288@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Claudiu Beznea <claudiu.beznea@microchip.com>

[ Upstream commit 26ce7054d804be73935b9268d6e0ecf2fbbc8aef ]

devm_kasprintf() returns a pointer to dynamically allocated memory.
Pointer could be NULL in case allocation fails. Check pointer validity.
Identified with coccinelle (kmerr.cocci script).

Fixes: 0556f1d580d4 ("media: tvp5150: add input source selection of_graph support")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/tvp5150.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/i2c/tvp5150.c b/drivers/media/i2c/tvp5150.c
index 4b16ffcaef98a..b0dc21ba25c31 100644
--- a/drivers/media/i2c/tvp5150.c
+++ b/drivers/media/i2c/tvp5150.c
@@ -2066,6 +2066,10 @@ static int tvp5150_parse_dt(struct tvp5150 *decoder, struct device_node *np)
 		tvpc->ent.name = devm_kasprintf(dev, GFP_KERNEL, "%s %s",
 						v4l2c->name, v4l2c->label ?
 						v4l2c->label : "");
+		if (!tvpc->ent.name) {
+			ret = -ENOMEM;
+			goto err_free;
+		}
 	}
 
 	ep_np = of_graph_get_endpoint_by_regs(np, TVP5150_PAD_VID_OUT, 0);
-- 
2.40.1



