Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75EBA7553A3
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbjGPUVP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbjGPUVO (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:21:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED622126
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:21:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C9F760EB0
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:21:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C80CC433C7;
        Sun, 16 Jul 2023 20:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538873;
        bh=kHPX4Ov12ZRg1jPFlP8ipf2JA6+9RgVxmjQfkcDvdl8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AkQV0XaCv2W2P9wEm9hWDZ3E+mBHRhRHBmHeMJl0j9DURROi4z9c796CLdkERt7Rk
         BbcVlBRn53Jn37UW6TDWFerSa1fkC6X9eaO/Dci+6zRYub9XKsFHztteJ7rIVeRWiw
         5Vwp+SuzOV2ObfresHNgbhXK2sfaaIqOA/ur2NbU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 607/800] media: atomisp: gc0310: Fix double free in gc0310_remove()
Date:   Sun, 16 Jul 2023 21:47:40 +0200
Message-ID: <20230716195003.206062187@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 2746a966f9f05fdb0727f4e1e8f2d51ec79e071d ]

gc0310_remove() must not call kfree(dev) since the gc0310_device struct
is devm managed so explicitly freeing it causes a double free.

While at it add a missing mutex_destroy() call for the input_lock.

Link: https://lore.kernel.org/r/20230518153214.194976-6-hdegoede@redhat.com

Fixes: 340b4dd6c183 ("media: atomisp: gc0310: Use devm_kzalloc() for data struct")
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/media/atomisp/i2c/atomisp-gc0310.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/atomisp/i2c/atomisp-gc0310.c b/drivers/staging/media/atomisp/i2c/atomisp-gc0310.c
index 273155308fe36..eb6db1571dc0d 100644
--- a/drivers/staging/media/atomisp/i2c/atomisp-gc0310.c
+++ b/drivers/staging/media/atomisp/i2c/atomisp-gc0310.c
@@ -377,8 +377,8 @@ static void gc0310_remove(struct i2c_client *client)
 	v4l2_device_unregister_subdev(sd);
 	media_entity_cleanup(&dev->sd.entity);
 	v4l2_ctrl_handler_free(&dev->ctrls.handler);
+	mutex_destroy(&dev->input_lock);
 	pm_runtime_disable(&client->dev);
-	kfree(dev);
 }
 
 static int gc0310_probe(struct i2c_client *client)
-- 
2.39.2



