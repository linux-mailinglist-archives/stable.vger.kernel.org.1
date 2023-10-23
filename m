Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0277D33B7
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233787AbjJWLdZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234126AbjJWLdW (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:33:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC098100
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:33:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DED2C433C9;
        Mon, 23 Oct 2023 11:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060798;
        bh=cRZDVFB3/fiU9elFx8D/JF2XFZxVDMcYY2kXcudBhKY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OEpJan673h3W5Q/VZESfeGwUX5Yex6VwJHsBi1VaN6vAkaNmXDvjZnCf6LtX4zWQ4
         je75tzAA2GnpM7V+4nD+Kvz3vVfpRpguPR3sbbk++9/+xxZC6VOnwln0E7LaP0TYBQ
         Og4DSbXdJW/RntbwyqknPbTWOFdHEeDMr1b6dfe0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 096/123] regulator/core: Revert "fix kobject release warning and memory leak in regulator_register()"
Date:   Mon, 23 Oct 2023 12:57:34 +0200
Message-ID: <20231023104820.910665366@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104817.691299567@linuxfoundation.org>
References: <20231023104817.691299567@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michał Mirosław <mirq-linux@rere.qmqm.pl>

[ Upstream commit 6e800968f6a715c0661716d2ec5e1f56ed9f9c08 ]

This reverts commit 5f4b204b6b8153923d5be8002c5f7082985d153f.

Since rdev->dev now has a release() callback, the proper way of freeing
the initialized device can be restored.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Link: https://lore.kernel.org/r/d7f469f3f7b1f0e1d52f9a7ede3f3c5703382090.1695077303.git.mirq-linux@rere.qmqm.pl
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/core.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index fe4b666edd037..87d0cd6f49ca9 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5351,15 +5351,11 @@ regulator_register(const struct regulator_desc *regulator_desc,
 	mutex_lock(&regulator_list_mutex);
 	regulator_ena_gpio_free(rdev);
 	mutex_unlock(&regulator_list_mutex);
-	put_device(&rdev->dev);
-	rdev = NULL;
 clean:
 	if (dangling_of_gpiod)
 		gpiod_put(config->ena_gpiod);
-	if (rdev && rdev->dev.of_node)
-		of_node_put(rdev->dev.of_node);
-	kfree(rdev);
 	kfree(config);
+	put_device(&rdev->dev);
 rinse:
 	if (dangling_cfg_gpiod)
 		gpiod_put(cfg->ena_gpiod);
-- 
2.40.1



