Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3468C755296
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjGPUJi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbjGPUJh (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:09:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449AF9B
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:09:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C66FB60EB3
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:09:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5761C433C8;
        Sun, 16 Jul 2023 20:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538175;
        bh=p7VM3isMGMCuc5zXckDZFeb3S3f7P/SpglHGrA3iMQ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E0vBDfN2jy8iAEXrhLr/9iSaxlA854oWcQq8gdma55tiCt3uriayLVD71jhr+XoB3
         d1NutqJ9VUHZZRh8+onTw7QlydPmq2H65rweGYnZtQClqvFu2OMRyEi3E9gczIL88C
         nMtixWmZQfO5rsAj4c05jT7sQum+lsOFMUjOqWvo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Oded Gabbay <ogabbay@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 358/800] accel/habanalabs: fix gaudi2_get_tpc_idle_status() return
Date:   Sun, 16 Jul 2023 21:43:31 +0200
Message-ID: <20230716194957.394754841@linuxfoundation.org>
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

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 9ec7639b5e124f273db20555cc38bd40057157b3 ]

The gaudi2_get_tpc_idle_status() function returned the incorrect variable
so it always returned true.

Fixes: d85f0531b928 ("accel/habanalabs: break is_idle function into per-engine sub-routines")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/habanalabs/gaudi2/gaudi2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/habanalabs/gaudi2/gaudi2.c b/drivers/accel/habanalabs/gaudi2/gaudi2.c
index b778cf764a68a..5539c84ee7171 100644
--- a/drivers/accel/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/accel/habanalabs/gaudi2/gaudi2.c
@@ -7231,7 +7231,7 @@ static bool gaudi2_get_tpc_idle_status(struct hl_device *hdev, u64 *mask_arr, u8
 
 	gaudi2_iterate_tpcs(hdev, &tpc_iter);
 
-	return tpc_idle_data.is_idle;
+	return *tpc_idle_data.is_idle;
 }
 
 static bool gaudi2_get_decoder_idle_status(struct hl_device *hdev, u64 *mask_arr, u8 mask_len,
-- 
2.39.2



