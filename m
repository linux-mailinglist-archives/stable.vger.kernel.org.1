Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386CA7DCBCB
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 12:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235607AbjJaL1P (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 07:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235604AbjJaL1O (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 07:27:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBA697
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 04:27:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58114C433C9;
        Tue, 31 Oct 2023 11:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698751632;
        bh=awmAiSkNnN+TI2CC+XYBdrCPjVDFhVbo56UCv/+j4iQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kFzGDvaUsqm4M9amVukFVP4UnX6Y1c703m/tNatUpvGnYEgoSBywsB/k59+vKIrpL
         6uSstmZUCYVQho3yprK5eZsbSakgNShrWG8HoiBGQhO64gvpo19c20rDcsm8fIYRdE
         PCmfCW5n2Kh0sP9IjzCiliqUMvdIQU3jvFuRdHE//GbdUHnmp9aoBvWvOd1kzL+1F+
         gXvJkoM2GLa5sdLNsvqTh1nmsib+LMkSFfXHek6qy8t43Itl35TuSSTIUgR2Yu+fnq
         xqd6CX02V+w9scFvim+iAWbdBCwyHLaP12GQxi0+N3maC5uGCtm6d3opro5iY0oebT
         yydn/24RsWs6A==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org
Cc:     stable@vger.kernel.org, Hangyu Hua <hbh25y@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH v5.15.y 6/6] rpmsg: Fix possible refcount leak in rpmsg_register_device_override()
Date:   Tue, 31 Oct 2023 11:25:40 +0000
Message-ID: <20231031112545.2277797-6-lee@kernel.org>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
In-Reply-To: <20231031112545.2277797-1-lee@kernel.org>
References: <20231031112545.2277797-1-lee@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Hangyu Hua <hbh25y@gmail.com>

commit d7bd416d35121c95fe47330e09a5c04adbc5f928 upstream.

rpmsg_register_device_override need to call put_device to free vch when
driver_set_override fails.

Fix this by adding a put_device() to the error path.

Fixes: bb17d110cbf2 ("rpmsg: Fix calling device_lock() on non-initialized device")
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
Link: https://lore.kernel.org/r/20220624024120.11576-1-hbh25y@gmail.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/rpmsg/rpmsg_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index 0ea8f8ec84efc..8bb78c747e30c 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -594,6 +594,7 @@ int rpmsg_register_device_override(struct rpmsg_device *rpdev,
 					  strlen(driver_override));
 		if (ret) {
 			dev_err(dev, "device_set_override failed: %d\n", ret);
+			put_device(dev);
 			return ret;
 		}
 	}
-- 
2.42.0.820.g83a721a137-goog

