Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D01E775B08
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233357AbjHILNi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233354AbjHILNh (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:13:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCB7ED
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:13:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 255FB63153
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:13:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 327FDC433C8;
        Wed,  9 Aug 2023 11:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691579616;
        bh=sh0BdM7yCUfougoeb6Vj0qsgIljj/yM9u9Iu3TFNyq4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c15HsmERXNjO6yDmj5cas5HUzCqNpdW+qKAfLE0R9u/yCq3An3/0jWF0BGj7YwrgF
         4rA18ropUXrIxxtUBo1TmewMLao97JuJNjhO6ZNFeKAfUcR6ruysGvJpHOsZiZaBrJ
         BhqMh3D9KHxSBwnB/vB9w/KnTKc9nCanvb7ouGDw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Luca Weiss <luca@z3ntu.xyz>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 055/323] Input: drv260x - sleep between polling GO bit
Date:   Wed,  9 Aug 2023 12:38:13 +0200
Message-ID: <20230809103700.652751790@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103658.104386911@linuxfoundation.org>
References: <20230809103658.104386911@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Luca Weiss <luca@z3ntu.xyz>

[ Upstream commit efef661dfa6bf8cbafe4cd6a97433fcef0118967 ]

When doing the initial startup there's no need to poll without any
delay and spam the I2C bus.

Let's sleep 15ms between each attempt, which is the same time as used
in the vendor driver.

Fixes: 7132fe4f5687 ("Input: drv260x - add TI drv260x haptics driver")
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
Link: https://lore.kernel.org/r/20230430-drv260x-improvements-v1-2-1fb28b4cc698@z3ntu.xyz
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/misc/drv260x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
index 17eb84ab4c0b7..fe3fbde989be2 100644
--- a/drivers/input/misc/drv260x.c
+++ b/drivers/input/misc/drv260x.c
@@ -443,6 +443,7 @@ static int drv260x_init(struct drv260x_data *haptics)
 	}
 
 	do {
+		usleep_range(15000, 15500);
 		error = regmap_read(haptics->regmap, DRV260X_GO, &cal_buf);
 		if (error) {
 			dev_err(&haptics->client->dev,
-- 
2.39.2



