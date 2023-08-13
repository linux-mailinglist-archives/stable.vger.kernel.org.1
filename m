Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC58777AC61
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbjHMVc0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbjHMVcZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:32:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B78910D7
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:32:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 939A862BCD
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:32:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A903BC433C8;
        Sun, 13 Aug 2023 21:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962347;
        bh=fE48/0UsUrllRDfbt97Jx6zTEXya9sANIdyZCWDOEkg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TZc8KxrrSCnqWVTG0sQBK5xm0QXIvOGawSwNT0HAYzR59nqMDDR66JQUdjEaoosJ0
         pnwpSOYkyQA33GMtdF3Xevj0U08iSGWiyEv5ZRhKG7Y/OJBwfApRPKTSxsU26kL5CF
         G8AujkasnJtQN2rify6JMaobkm2IoXQr2BIuDL1w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Vadim Pasternak <vadimp@nvidia.com>,
        Michael Shych <michaelsh@nvidia.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 6.4 203/206] platform: mellanox: Fix order in exit flow
Date:   Sun, 13 Aug 2023 23:19:33 +0200
Message-ID: <20230813211730.813556600@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
References: <20230813211724.969019629@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Vadim Pasternak <vadimp@nvidia.com>

commit 8e3938cff0191c810b2abd827313c090fe09d166 upstream.

Fix exit flow order: call mlxplat_post_exit() after
mlxplat_i2c_main_exit() in order to unregister main i2c driver before
to "mlxplat" driver.

Fixes: 0170f616f496 ("platform: mellanox: Split initialization procedure")
Signed-off-by: Vadim Pasternak <vadimp@nvidia.com>
Reviewed-by: Michael Shych <michaelsh@nvidia.com>
Link: https://lore.kernel.org/r/20230813083735.39090-2-vadimp@nvidia.com
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/mlx-platform.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/platform/x86/mlx-platform.c
+++ b/drivers/platform/x86/mlx-platform.c
@@ -6238,8 +6238,6 @@ static void mlxplat_i2c_mux_topolgy_exit
 		if (priv->pdev_mux[i])
 			platform_device_unregister(priv->pdev_mux[i]);
 	}
-
-	mlxplat_post_exit();
 }
 
 static int mlxplat_i2c_main_complition_notify(void *handle, int id)
@@ -6369,6 +6367,7 @@ static void __exit mlxplat_exit(void)
 		pm_power_off = NULL;
 	mlxplat_pre_exit(priv);
 	mlxplat_i2c_main_exit(priv);
+	mlxplat_post_exit();
 }
 module_exit(mlxplat_exit);
 


