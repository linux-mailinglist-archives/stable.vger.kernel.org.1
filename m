Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3218F7DCC08
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 12:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344025AbjJaLmO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 07:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344003AbjJaLmO (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 07:42:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314ED97
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 04:42:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70CC4C433CD;
        Tue, 31 Oct 2023 11:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698752531;
        bh=5GMJPTTb6ZOleR/9n5TweQdZ32Y7RCVOsZULilMhyGM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gPJuN7wAVF7xSivtodXV9o2fRmqeJ4npTr703RlhrZzPNkckigMen4vtzRDzIPEUK
         KAeEHq2LZqSy4C+vkIhvAZ8bel8PMwrUO3q669Hom8Vgo8cFEpUomEgLlJIPcdqZ5b
         8BqnQlt1yjOYTyOpQ4qIpZYo/qmSGGbwJ3ZD4XHQIG55q3pw57ovG6DiAe1DNBrm2P
         3tN55osbxHcbMcRflQNF7FwxWlNInZ/HyhNlwlQ9WDZkeJlh6P6ZzPgFqqAHw3DhtE
         t1G0IQjUBhuQOTuGPr1Te8Nt+pmIqkAx7/bVgjb9n5J0WqcFkp6l8vgvfIwiiYsTjh
         CU1QIINrE61VA==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org
Cc:     stable@vger.kernel.org, Hangyu Hua <hbh25y@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH v4.14.y 5/5] rpmsg: Fix possible refcount leak in rpmsg_register_device_override()
Date:   Tue, 31 Oct 2023 11:41:50 +0000
Message-ID: <20231031114155.2289410-5-lee@kernel.org>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
In-Reply-To: <20231031114155.2289410-1-lee@kernel.org>
References: <20231031114155.2289410-1-lee@kernel.org>
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
(cherry picked from commit d7bd416d35121c95fe47330e09a5c04adbc5f928)
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/rpmsg/rpmsg_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index af1a50a799aa8..1389a32fdea33 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -499,6 +499,7 @@ int rpmsg_register_device_override(struct rpmsg_device *rpdev,
 					  strlen(driver_override));
 		if (ret) {
 			dev_err(dev, "device_set_override failed: %d\n", ret);
+			put_device(dev);
 			return ret;
 		}
 	}
-- 
2.42.0.820.g83a721a137-goog

