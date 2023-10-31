Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318137DCC01
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 12:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343743AbjJaLkM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 07:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343846AbjJaLkL (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 07:40:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF79DA
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 04:40:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 938C7C433C7;
        Tue, 31 Oct 2023 11:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698752408;
        bh=+I3ckAReIG/YxwEuoCyosBg7DwqkUXjYpeQuy8DrPLs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kvSqyBQKStHNm0qTryIcNkr9xttvtaAUHlQ4JZMe06wMGVrQcnsEi8W5NOiecyXMo
         SIRwHUwlUzzk0cWxWctrdtRLpe0swb1ank+V+ld914czeJP2l6grywmfBqEq1k24cQ
         7m1GWBTfiTyZMjrFOXG2WFDfKjaSkGpXnTfe5ToGBfmcOhoDRaMMTII5xrMi49jk9Q
         8D2L+GVch+Trv9Hqw1lDdXro09FbYC/WKndN473JEm6hLDf/K8beGcpgX+yR0eHP9L
         r6aV59g4Kz+DPktfcGSg6Twd0dNCiAlZKAYM5QRc0NFDSNeOA5F7sF0pN0IetgiBHV
         v7rfcofza2UIw==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org
Cc:     stable@vger.kernel.org, Hangyu Hua <hbh25y@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH v4.19.y 6/6] rpmsg: Fix possible refcount leak in rpmsg_register_device_override()
Date:   Tue, 31 Oct 2023 11:39:52 +0000
Message-ID: <20231031113956.2287681-6-lee@kernel.org>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
In-Reply-To: <20231031113956.2287681-1-lee@kernel.org>
References: <20231031113956.2287681-1-lee@kernel.org>
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
index 3d6427b0edc41..880c7c4deec30 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -550,6 +550,7 @@ int rpmsg_register_device_override(struct rpmsg_device *rpdev,
 					  strlen(driver_override));
 		if (ret) {
 			dev_err(dev, "device_set_override failed: %d\n", ret);
+			put_device(dev);
 			return ret;
 		}
 	}
-- 
2.42.0.820.g83a721a137-goog

