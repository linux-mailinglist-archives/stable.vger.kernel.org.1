Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038C37DCBC7
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 12:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343671AbjJaL1K (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 07:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235606AbjJaL1I (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 07:27:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94128D8
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 04:27:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B000C433CA;
        Tue, 31 Oct 2023 11:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698751626;
        bh=aD8F5BQWzvdM1VeUwF3zdA33At2xeqIgw4P15/6eny4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F3e+oQgTTB2xlu3W9xhRyQnHps1Z42e+j/JGnkUiezMMd6BsbzmqohhkKrUDTlu2B
         GZtD+6CW5Uw0s3k4yJOEhAV9T2IiL4GDWCUnvCBDViDPjVIdhzhfcgGcb6VpP0xovp
         2EivkrUMxGV98kbmrpxyvdTpBE+FaY86XHjaniqTzyvbjmsiFOQxtzA6DYQOo9GQ8j
         gL+RURzDNos6r/XN8GYxoIbPXe0H8kZ3SJlIDTQKfMEFGHv8iZCkQKR8uBaJ+mkoo0
         bo3tF5d2wdXMGU+Wtli28pb9GWuL8ReAa5/E4rkb/1S5T7mVMdXT14tP7h91XiwdVz
         3OBiFC4gyAD7Q==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org
Cc:     stable@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v5.15.y 2/6] rpmsg: Constify local variable in field store macro
Date:   Tue, 31 Oct 2023 11:25:36 +0000
Message-ID: <20231031112545.2277797-2-lee@kernel.org>
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

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

commit e5f89131a06142e91073b6959d91cea73861d40e upstream.

Memory pointed by variable 'old' in field store macro is not modified,
so it can be made a pointer to const.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20220419113435.246203-12-krzysztof.kozlowski@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/rpmsg/rpmsg_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index a71de08acc7b9..c544dee0b5dd9 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -376,7 +376,8 @@ field##_store(struct device *dev, struct device_attribute *attr,	\
 	      const char *buf, size_t sz)				\
 {									\
 	struct rpmsg_device *rpdev = to_rpmsg_device(dev);		\
-	char *new, *old;						\
+	const char *old;						\
+	char *new;							\
 									\
 	new = kstrndup(buf, sz, GFP_KERNEL);				\
 	if (!new)							\
-- 
2.42.0.820.g83a721a137-goog

