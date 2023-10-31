Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84E27DC963
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 10:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343842AbjJaJX2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 05:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343852AbjJaJX1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 05:23:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F26F4
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 02:23:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E854C433C8;
        Tue, 31 Oct 2023 09:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698744205;
        bh=TV5hf9z1vj4XBeij+P8Dzyr5IJ8/oQj10+D6OI1q6ZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mi6ozmiG6Ntt1z/j/8d8o7DhNRRda2hWNIDCayGgKGWFnDZka9TSErQnJgGmuBYZo
         e+3l/IXGql9NDYreqWcLquMvddjyPYHCHWpVWibcYtf+cbzr2xlm3r2bTYPYO50Ahj
         hKmj+q/GL8m+SJwAyh3qjp21ZCrvYO89gLSER9X7pTzxDaB+2M18zX9+Vu6fLQ5XK3
         4TJu1/7D+6JK9MyrophdsBc4sy958v/YM8/kfMPS8ufGc2M66HsOIr40cfdLkGntkr
         vNNjY2M8l1D68I4/i25ECiZOPyx+mlxX/FxTvL9Z+/8PcFZlwh9zyvWObKhgOKrt49
         Itn/Y9IhDFLIw==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org
Cc:     stable@vger.kernel.org, Hangyu Hua <hbh25y@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH v5.10.y 6/6] rpmsg: Fix possible refcount leak in rpmsg_register_device_override()
Date:   Tue, 31 Oct 2023 09:23:01 +0000
Message-ID: <20231031092308.2227611-6-lee@kernel.org>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
In-Reply-To: <20231031092308.2227611-1-lee@kernel.org>
References: <20231031092308.2227611-1-lee@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
Change-Id: I36fcb13fe2ea03ac6b2a94fe7cd9bf186db64f19
---
 drivers/rpmsg/rpmsg_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index 089eee735accd..fd3d7b3fbbd1f 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -551,6 +551,7 @@ int rpmsg_register_device_override(struct rpmsg_device *rpdev,
 					  strlen(driver_override));
 		if (ret) {
 			dev_err(dev, "device_set_override failed: %d\n", ret);
+			put_device(dev);
 			return ret;
 		}
 	}
-- 
2.42.0.820.g83a721a137-goog

