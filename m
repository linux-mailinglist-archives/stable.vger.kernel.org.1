Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF55755576
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbjGPUlO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbjGPUlI (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:41:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E44E6B
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:41:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 576BB60EBA
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:41:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6374FC433C7;
        Sun, 16 Jul 2023 20:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540059;
        bh=dS3RfzImIkh0u/q5OPx5Zo84ixze5DIOE0aP09OEsD0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FcJEDuTx8SnKBhdMnBx8EU7TEon1CTpzxL+94sUMNJkQM/6LQ6Q/BKDvd0hqE3cWX
         rwkZIUzMeEwx95D3gvlaMdTqPORxjuS1Fn5HThl5RQiRkhxBqOU/CvQfxM4T9OIr+U
         Cbq+VeMiqasTCDSOpAnxUafw3TWCJFzu3jdcZZL0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Robert Foss <robert.foss@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 191/591] drm/bridge: anx7625: Convert to i2cs .probe_new()
Date:   Sun, 16 Jul 2023 21:45:30 +0200
Message-ID: <20230716194928.817824606@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
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

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 71450f8c824f5571d4af9e6e021b733085c8e690 ]

The probe function doesn't make use of the i2c_device_id * parameter so it
can be trivially converted.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Link: https://lore.kernel.org/r/20221118224540.619276-18-uwe@kleine-koenig.org
Signed-off-by: Robert Foss <robert.foss@linaro.org>
Stable-dep-of: 1464e48d69ab ("drm/bridge: anx7625: Prevent endless probe loop")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index b0ff1ecb80a50..86a52c5f4fbc4 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -2562,8 +2562,7 @@ static void anx7625_runtime_disable(void *data)
 	pm_runtime_disable(data);
 }
 
-static int anx7625_i2c_probe(struct i2c_client *client,
-			     const struct i2c_device_id *id)
+static int anx7625_i2c_probe(struct i2c_client *client)
 {
 	struct anx7625_data *platform;
 	struct anx7625_platform_data *pdata;
@@ -2756,7 +2755,7 @@ static struct i2c_driver anx7625_driver = {
 		.of_match_table = anx_match_table,
 		.pm = &anx7625_pm_ops,
 	},
-	.probe = anx7625_i2c_probe,
+	.probe_new = anx7625_i2c_probe,
 	.remove = anx7625_i2c_remove,
 
 	.id_table = anx7625_id,
-- 
2.39.2



